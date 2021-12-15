import { AppProvidersProps } from '../components/redesign/AppProviders';
import { getBuildInfoAsync } from '../native-modules/DevLauncherInternal';
import { queryDevSessionsAsync } from '../native-modules/DevMenu';
import { getSettingsAsync } from '../native-modules/DevMenuInternal';
import { getLocalDevSessionsAsync } from './getLocalDevSessionsAsync';
import { restoreUserAsync } from './restoreUserAsync';

export async function getInitialData(): Promise<Partial<AppProvidersProps>> {
  const initialUserData = await restoreUserAsync();
  const isAuthenticated = initialUserData != null;
  const initialDevSessions = isAuthenticated
    ? await queryDevSessionsAsync()
    : await getLocalDevSessionsAsync();

  const initialBuildInfo = await getBuildInfoAsync();
  const initialDevMenuSettings = await getSettingsAsync();

  return {
    initialDevSessions,
    initialUserData,
    initialBuildInfo,
    initialDevMenuSettings,
  };
}
