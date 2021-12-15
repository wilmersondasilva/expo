import { getBuildInfoAsync } from '../../native-modules/DevLauncherInternal';
import { queryDevSessionsAsync } from '../../native-modules/DevMenu';
import { getSettingsAsync } from '../../native-modules/DevMenuInternal';
import { getInitialData } from '../getInitialData';
import { getLocalDevSessionsAsync } from '../getLocalDevSessionsAsync';
import { restoreUserAsync } from '../restoreUserAsync';

jest.mock('../getLocalDevSessionsAsync');
jest.mock('../restoreUserAsync');

const mockRestoreUserAsync = restoreUserAsync as jest.Mock;

const mockFns = [
  getLocalDevSessionsAsync,
  getBuildInfoAsync,
  getSettingsAsync,
  restoreUserAsync,
] as jest.Mock[];

describe('getInitialData()', () => {
  beforeEach(() => {
    mockFns.forEach((fn) => fn.mockReset());
  });

  test('calls all the fns we need', async () => {
    expect(getLocalDevSessionsAsync).not.toHaveBeenCalled();
    expect(getBuildInfoAsync).not.toHaveBeenCalled();
    expect(getSettingsAsync).not.toHaveBeenCalled();
    expect(restoreUserAsync).not.toHaveBeenCalled();

    await getInitialData();

    expect(getLocalDevSessionsAsync).toHaveBeenCalled();
    expect(getBuildInfoAsync).toHaveBeenCalled();
    expect(getSettingsAsync).toHaveBeenCalled();
    expect(restoreUserAsync).toHaveBeenCalled();
  });

  test('queries dev sessions if logged in', async () => {
    mockRestoreUserAsync.mockResolvedValueOnce({ username: '123' });

    expect(getLocalDevSessionsAsync).not.toHaveBeenCalled();
    expect(getBuildInfoAsync).not.toHaveBeenCalled();
    expect(getSettingsAsync).not.toHaveBeenCalled();
    expect(restoreUserAsync).not.toHaveBeenCalled();
    expect(queryDevSessionsAsync).not.toHaveBeenCalled();

    await getInitialData();

    expect(getLocalDevSessionsAsync).not.toHaveBeenCalled();
    expect(queryDevSessionsAsync).toHaveBeenCalled();
    expect(getBuildInfoAsync).toHaveBeenCalled();
    expect(getSettingsAsync).toHaveBeenCalled();
    expect(restoreUserAsync).toHaveBeenCalled();
  });
});
