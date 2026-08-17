Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8E3AAF53
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004636; cv=none; b=YFFfxhfFHfDwBhK9kv3YDviIG2A4K/QxsclDeOSubXwKqLhrNtB8tFrx+WsG9pjlftVVfXNPk1kvpUQhKx2jFOt/Iz9Rx7Unw0z6cCw3wCF+eK6esoV5jOM6Stj5ZRKZZGXntRjchv2tXZgOsq3qjc8steZAUUFSnQiffigSpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004636; c=relaxed/simple;
	bh=6URCNvtiPZPtL93KDskAgzfjaKXhpX5/lfeEMy3BCug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFXc4RPDcRZL6wmuARsQbCy9+OdFmzn7KycPVaeaqvSMTv0WXnhmGHuwPGNPq4Y3rcM7sT5+3rt0m32IPCkR+JLytTiKtjYujfBQ9jJaHGQwt+MaZStts+PFN+CRLCD732ZO+6bSluyuE8jHm6P4aYZuTIe2UyhZ/plqtO/5K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzYcHEzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzYcHEzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B71F000E9;
	Mon, 17 Aug 2026 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004634;
	bh=d8AC6vfALatX5UtOUWd5zCagvFlwl4bmdztMSDWa7Wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kzYcHEzUp81sRoj9g+Te7YgQV1rkxcc6PfdSpcAqjI1S7ze91fiqXFN7AN8SmCE+v
	 /68VWMt9TF5NmUWgRAhXot7wFbVvQRvwdb74jC6IofsQIOehlPjWdsxvrxZLEaOUKb
	 yOR+PzFiY4yrXSiJA1RcAm4zwHL9LhaI/bTp1HplCWSFnQ5n3ui5gWIx0XrmRhkKy1
	 y0G9Vo0wdH+gDVTX5OId3Ov0lGvb6tCIDMZ5GeNyuav65jjIZP2xDWtlnorVTjHqk8
	 G26VV0LTGXzyCZ8GQyrO6Lw2ByBvXHXOhw03uNYU+X7JfVhE78sw0KByWhbdc+UDG/
	 +IyaUp9fWexYg==
Date: Mon, 17 Aug 2026 15:10:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v16 10/10] selftests: net: add TLS hardware offload test
Message-ID: <20260817151033.700f797b@kernel.org>
In-Reply-To: <20260807183853.2288959-11-rjethwani@purestorage.com>
References: <20260807183853.2288959-1-rjethwani@purestorage.com>
	<20260807183853.2288959-11-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 12:38:53 -0600 Rishikesh Jethwani wrote:
> Two-node kTLS HW offload test using NetDrvEpEnv. A C helper binary
> acts as TLS client or server; a Python harness drives it and verifies
> TLS stat counters (RekeyOk, RekeyReceived, RekeyFallback,
> RekeyInProgress, RekeyAborted, RekeyError, DecryptError).
> 
> Covers TLS 1.2/1.3 with AES-GCM-128/256, rekey with various buffer
> sizes, and burst variants that stress TX rekey (temporary SW phase,
> HW reinstall) and RX rekey (boundary tracking, old-key reencryption,
> deferred dev_add).
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  MAINTAINERS                                   |   2 +
>  .../selftests/drivers/net/hw/.gitignore       |   1 +
>  .../testing/selftests/drivers/net/hw/Makefile |   2 +
>  .../selftests/drivers/net/hw/tls_hw_offload.c | 975 ++++++++++++++++++
>  .../drivers/net/hw/tls_hw_offload.py          | 295 ++++++
>  5 files changed, 1275 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08e43bc09735..6e119592b72a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19066,6 +19066,8 @@ F:	Documentation/networking/tls*
>  F:	include/net/tls.h
>  F:	include/uapi/linux/tls.h
>  F:	net/tls/
> +F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> +F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
>  F:	tools/testing/selftests/net/tls.c
>  
>  NETWORKING [SOCKETS]
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 46540468a775..f0a5d15b469b 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -2,3 +2,4 @@
>  iou-zcrx
>  ncdevmem
>  toeplitz
> +tls_hw_offload

nit: alphabetic sort would put tls before toeplitz?

> +static int client_connect_tls(void)
> +{
> +	struct sockaddr_in sa;
> +	int csk;
> +
> +	csk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

IPv6 support is a must these days, should be pretty easy
with getaddrinfo() ? Ideally we'd support forcing IP version
using -4/-6 flags and appropriate plumbing on the Python side.
Run at least a basic test over both

> +	if (csk < 0) {
> +		printf("SETUP ERROR: failed to create socket: %s\n",
> +		       strerror(errno));
> +		return -1;
> +	}
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sin_family = AF_INET;
> +	sa.sin_addr.s_addr = inet_addr(server_ip);
> +	sa.sin_port = htons(server_port);
> +	printf("Connecting to %s:%d...\n", server_ip, server_port);
> +

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..b8f5a3314030
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,295 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Test kTLS hardware offload using a C helper binary."""
> +
> +from collections import defaultdict
> +
> +from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
> +from lib.py import ksft_variants, KsftNamedVariant
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd, bkg, wait_port_listen, rand_port
> +from lib.py import CmdExitFailure
> +
> +# Burst variants push hundreds of MB and perform many rekeys; the
> +# default cmd() timeout (5s) is too short.
> +BURST_TIMEOUT_S = 180
> +
> +
> +def check_tls_support(cfg):

please make sure pylint --disable=R passes cleanly on new Python files
docstring missing here (you can prefix the trivial local helpers with
_ to avoid that)

> +    try:
> +        cmd("test -f /proc/net/tls_stat")
> +        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"kTLS not supported: {e}")

That's fine, but you also must update the 
tools/testing/selftests/drivers/net/hw/config
config to make sure that x86 defconfig + that file result in a build
with working TLS offload

> +    try:
> +        features = cmd(f"ethtool -k {cfg.ifname}").stdout
> +        if 'tls-hw-tx-offload: on' not in features:
> +            raise KsftSkipEx("Device does not support TLS HW TX offload")
> +        if 'tls-hw-rx-offload: on' not in features:
> +            raise KsftSkipEx("Device does not support TLS HW RX offload")
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"Cannot determine TLS HW offload support: {e}")
> +
> +
> +def read_tls_stats(host=None):
> +    stats = defaultdict(int)
> +    output = cmd("cat /proc/net/tls_stat", host=host)
> +    for line in output.stdout.strip().split('\n'):
> +        parts = line.split()
> +        if len(parts) == 2:
> +            stats[parts[0]] = int(parts[1])
> +    return stats
> +
> +
> +def stat_diff(before, after, key):
> +    return after[key] - before[key]
> +
> +
> +def check_path(before, after, direction, role, require_hw):
> +    """On the DUT, require HW offload; on the remote, HW or SW is fine."""
> +    dev = stat_diff(before, after, f'Tls{direction}Device')
> +    sw = stat_diff(before, after, f'Tls{direction}Sw')
> +    if require_hw:
> +        if dev < 1:
> +            ksft_pr(f"FAIL: {role} {direction}: HW offload not engaged "
> +                    f"(Device={dev}, Sw={sw})")

ksft_lt(..., comment="your string") ?
Please use the official check helpers

> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
> +        if not cfg.bin_local.exists():
> +            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg.bin_local}")
> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> +        cfg.require_ipver("4")
> +        check_tls_support(cfg)
> +
> +        ksft_run([test_tls_offload, test_tls_offload_rekey,
> +                  test_tls_offload_burst], args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()

