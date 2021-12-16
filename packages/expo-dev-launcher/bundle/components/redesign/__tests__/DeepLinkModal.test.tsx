import * as React from 'react';

import {
  getPendingDeepLink,
  addDeepLinkListener,
} from '../../../native-modules/DevLauncherInternal';
import { render, act, waitFor } from '../../../test-utils';
import { DevSession } from '../../../types';
import { DeepLinkModal } from '../DeepLinkModal';

const mockGetPendingDeepLink = getPendingDeepLink as jest.Mock;
const mockAddDeepLinkListener = addDeepLinkListener as jest.Mock;

const fakeLocalPackager: DevSession = {
  url: 'hello',
  description: 'fakePackagerDescription',
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
    const closeFn = jest.fn();

    const { getByText } = render(<DeepLinkModal onClosePress={closeFn} pendingDeepLink="123" />, {
      initialAppProviderProps: { initialDevSessions: [fakeLocalPackager] },
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
