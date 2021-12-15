import { Packager } from '../../../functions/getLocalPackagersAsync';
import {
  getPendingDeepLink,
  addDeepLinkListener,
} from '../../../native-modules/DevLauncherInternal';
import { render, act, waitFor } from '../../../test-utils';

const mockGetPendingDeepLink = getPendingDeepLink as jest.Mock;
const mockAddDeepLinkListener = addDeepLinkListener as jest.Mock;

const fakeLocalPackager: Packager = {
  url: 'hello',
  description: 'fakePackagerDescription',
  hideImage: false,
  source: 'test',
};

describe('<DeepLinkPrompt />', () => {
  afterEach(() => {
    mockGetPendingDeepLink.mockClear();
    mockAddDeepLinkListener.mockClear();
  });

  test('retrieves pending deep link on mount and displays in modal', async () => {
    const fakeDeepLink = 'testing-testing-123';
    mockGetPendingDeepLink.mockResolvedValueOnce(fakeDeepLink);

    expect(getPendingDeepLink).not.toHaveBeenCalled();

    const { getByText, queryByText } = render(null);

    expect(queryByText(fakeDeepLink)).toBe(null);

    await act(async () => {
      expect(getPendingDeepLink).toHaveBeenCalled();
      await waitFor(() => getByText(/deep link received/i));
      await waitFor(() => getByText(fakeDeepLink));
    });
  });

  test('shows packagers in modal', async () => {
    const fakeDeepLink = 'testing-testing-123';
    mockGetPendingDeepLink.mockResolvedValueOnce(fakeDeepLink);

    const { getByText } = render(null, {
      initialAppProviderProps: { initialPackagers: [fakeLocalPackager] },
    });

    await act(async () => {
      await waitFor(() => getByText(/deep link received/i));
      getByText(fakeLocalPackager.description);
    });
  });

  test('calls subscription on mount', async () => {
    expect(addDeepLinkListener).not.toHaveBeenCalled();

    render(null);

    await act(async () => {
      expect(addDeepLinkListener).toHaveBeenCalled();
    });
  });
});
