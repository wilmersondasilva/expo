import * as React from 'react';

import { getLocalDevSessionsAsync } from '../../functions/getLocalDevSessionsAsync';
import { clientUrlScheme, loadApp } from '../../native-modules/DevLauncherInternal';
import { render, waitFor, fireEvent, act } from '../../test-utils';
import { DevSession } from '../../types';
import { HomeScreen, HomeScreenProps } from '../HomeScreen';

jest.mock('../../functions/getLocalDevSessionsAsync');
jest.mock('../../hooks/useDebounce');

const mockGetDevSessionsAsync = getLocalDevSessionsAsync as jest.Mock;

function mockGetDevSessionsResponse(response: DevSession[]) {
  return mockGetDevSessionsAsync.mockResolvedValueOnce(response);
}

const devSessionInstructionsRegex = /start a local development server with/i;
const fetchingDevSessionsRegex = /searching for development servers/i;
const refetchDevSessionsRegex = /refetch development servers/i;
const textInputToggleRegex = /enter url manually/i;
const textInputPlaceholder = `${clientUrlScheme}://expo-development-client/...`;

const mockLoadApp = loadApp as jest.Mock;

describe('<HomeScreen />', () => {
  afterEach(() => {
    mockLoadApp.mockReset();
    mockLoadApp.mockResolvedValue('');
  });

  test('displays instructions on starting DevSession when none are found', async () => {
    const { getByText } = renderHomeScreen({ initialDevSessions: [], fetchOnMount: false });
    await waitFor(() => getByText(devSessionInstructionsRegex));
  });

  test('displays refetch button', async () => {
    const { getByText } = renderHomeScreen();
    await waitFor(() => getByText(refetchDevSessionsRegex));
  });

  test('fetching local DevSessions on mount', async () => {
    mockGetDevSessionsAsync.mockResolvedValue(fakeDevSessions);

    const { getByText, queryByText } = renderHomeScreen({
      fetchOnMount: true,
      initialDevSessions: [],
    });

    expect(queryByText(fakeLocalDevSession.description)).toBe(null);

    await waitFor(() => getByText(fakeLocalDevSession.description));
    await waitFor(() => getByText(fakeLocalDevSession2.description));
  });

  test('refetching local DevSessions on button press', async () => {
    const { getByText, refetch } = renderHomeScreen({
      fetchOnMount: false,
      initialDevSessions: [],
    });

    mockGetDevSessionsAsync.mockClear();
    mockGetDevSessionsResponse([fakeDevSessions[0]]);
    expect(() => getByText(fakeDevSessions[0].description)).toThrow();
    expect(getLocalDevSessionsAsync).not.toHaveBeenCalled();

    await refetch();
    expect(getByText(fetchingDevSessionsRegex));
    expect(getLocalDevSessionsAsync).toHaveBeenCalled();

    await waitFor(() => getByText(fakeDevSessions[0].description));
  });

  test('refetching enabled after polling is completed', async () => {
    const testPollAmount = 8;

    const { getByText } = renderHomeScreen({
      fetchOnMount: false,
      pollInterval: 1,
      pollAmount: testPollAmount,
      initialDevSessions: [],
    });

    mockGetDevSessionsAsync.mockClear();

    await act(async () => {
      await waitFor(() => getByText(refetchDevSessionsRegex));
      fireEvent.press(getByText(refetchDevSessionsRegex));
      expect(getLocalDevSessionsAsync).toHaveBeenCalledTimes(1);
    });

    // ensure button is disabled when fetching
    await act(async () => {
      fireEvent.press(getByText(fetchingDevSessionsRegex));
      await waitFor(() => getByText(refetchDevSessionsRegex));
      expect(getLocalDevSessionsAsync).toHaveBeenCalledTimes(testPollAmount);
      fireEvent.press(getByText(refetchDevSessionsRegex));
      expect(getLocalDevSessionsAsync).toHaveBeenCalledTimes(testPollAmount + 1);
    });
  });

  test('select DevSession by entered url', async () => {
    const { getByText, getByPlaceholderText } = renderHomeScreen();

    expect(() => getByPlaceholderText(textInputPlaceholder)).toThrow();
    const toggleButton = getByText(textInputToggleRegex);
    fireEvent.press(toggleButton);

    const input = await waitFor(() => getByPlaceholderText(textInputPlaceholder));
    expect(loadApp).toHaveBeenCalledTimes(0);

    fireEvent.changeText(input, 'exp://tester');
    fireEvent.press(getByText(/connect/i));

    expect(loadApp).toHaveBeenCalledTimes(1);
    expect(loadApp).toHaveBeenCalledWith('exp://tester');
  });

  // TODO - figure out how to trigger blur event
  test.skip('unable to enter an invalid url', async () => {
    const { getByText, getByPlaceholderText, queryByPlaceholderText } = renderHomeScreen();

    expect(queryByPlaceholderText(textInputPlaceholder)).toBe(null);
    const toggleButton = getByText(textInputToggleRegex);
    fireEvent.press(toggleButton);

    const input = await waitFor(() => getByPlaceholderText(textInputPlaceholder));
    expect(loadApp).not.toHaveBeenCalled();

    fireEvent.changeText(input, 'i am invalid');
    fireEvent.press(getByText(/connect/i));

    expect(loadApp).not.toHaveBeenCalled();
    await waitFor(() => getByText(/invalid url/i));
  });

  test.todo('display for a valid url that is not found');

  test('select dev session from list', async () => {
    const { getByText } = renderHomeScreen();

    await waitFor(() => getByText(fakeLocalDevSession.description));

    fireEvent.press(getByText(fakeLocalDevSession.description));
    expect(loadApp).toHaveBeenCalled();
    expect(loadApp).toHaveBeenCalledWith(fakeLocalDevSession.url);
  });

  test('navigate to user profile', async () => {
    const { getByA11yLabel } = renderHomeScreen();
    expect(fakeNavigation.navigate).not.toHaveBeenCalled();

    const button = getByA11yLabel(/to user profile/i);

    await act(async () => {
      fireEvent.press(button);
      expect(fakeNavigation.navigate).toHaveBeenCalled();
      expect(fakeNavigation.navigate).toHaveBeenLastCalledWith('User Profile');
    });
  });
});

const fakeLocalDevSession: DevSession = {
  url: 'test://url321',
  description: 'fakeDevSessiondescription1',
  source: 'desktop',
};

const fakeLocalDevSession2: DevSession = {
  url: 'test://url123',
  description: 'fakeDevSessiondescription2',
  source: 'desktop',
};

const fakeDevSessions = [fakeLocalDevSession, fakeLocalDevSession2];

const fakeNavigation = {
  navigate: jest.fn(),
};

type RenderHomeScreenOptions = HomeScreenProps & {
  initialDevSessions?: DevSession[];
};

function renderHomeScreen(options: RenderHomeScreenOptions = {}) {
  const {
    initialDevSessions = fakeDevSessions,
    fetchOnMount = false,
    pollInterval = 0,
    pollAmount = 5,
    ...props
  } = options;

  const { getByText, ...fns } = render(
    <HomeScreen
      fetchOnMount={fetchOnMount}
      pollAmount={pollAmount}
      pollInterval={pollInterval}
      navigation={fakeNavigation}
      {...props}
    />,
    {
      initialAppProviderProps: {
        initialDevSessions,
      },
    }
  );

  async function refetch() {
    await waitFor(() => getByText(refetchDevSessionsRegex));
    await act(async () => fireEvent.press(getByText(refetchDevSessionsRegex)));
  }

  return {
    ...fns,
    getByText,
    refetch,
  };
}
