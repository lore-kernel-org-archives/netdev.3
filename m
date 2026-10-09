Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8B3B2AA;
	Fri,  9 Oct 2026 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504709; cv=none; b=CDezLCs1sUxJlmRSEEyXftvV0TO/4HAs5zb5nJlL2K2m+7LDWPuyfOqW9xS1PdE2OWGq5gNNGTfQ4noz6Czs9zqvR588rnyvZskvQgRSnose3ED0EXOGctHA7jd3yH13LwGZ98p6mcMtFNC10ot9+5JjJwQnxEs6Ot8IJlWFlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504709; c=relaxed/simple;
	bh=i53aezsOyLtSZ8MJNALx/JN+P0CJ3ZBJrWwkpk4j7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKw8Bimp9o957duchI1zlSQ16yu2P0AguMP04dinVdD7ngqbyne46xQnOXcyic2u+xGMrwhxuKT2QjKEypj8/6SsgfaDmwQ+zNztHomaROKsxtZGE2wqxuv/ubDyMuqXDkrCRepL5Pxs8Ld82HGvzBb3I8JrqU6cXp6zniMyI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDucb7WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDucb7WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170F1F000FF;
	Fri,  9 Oct 2026 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791504708;
	bh=JiBPy5435avd9YWp0uXYEWYcf7ARhlznAXfMCM1iHUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MDucb7WMdoJqEVHpUfQRzvT/PpetwoZ3qCIy65tOoCKLhygA+upvG1oki9cumFxNE
	 38+B+5N4gws6LRMdXVcaGOnaa4DMUFDtGzW1Br1rGmZYzHD6bQF4uwlxea6Z1AOyv8
	 ipWnaMEYuG5CFzdXKFIxU0YpHhkYC6c5GaGjwT3DiUnyTznP6JQbto0HXHk9GNWoEu
	 8kL4At3r65aBbvKqNMRWla1RKbcCYk6NV3WJQxDjv50lIfiDmSVrlJqD39iInEKvCK
	 6OIrCCxUD1kVvDUSUQfYioK7+d8vswy5TeFbJf4eFW+ZTka3k37kSJXoOkx3WfPZ7P
	 JMHoibKzzelnA==
Date: Thu, 8 Oct 2026 17:11:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Donald Hunter <donald.hunter@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] selftests: net: add a test for the gtp
 netlink family
Message-ID: <20261008171147.0c4ef171@kernel.org>
In-Reply-To: <20261008181031.4129029-4-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
	<20261008181031.4129029-4-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 18:10:31 +0000 Anil Kaushik wrote:
> Exercise the gtp generic netlink family through its ynl spec: create a
> gtp device, add a PDP context with newpdp, check getpdp lists it and
> delpdp removes it. Two more cases check that two contexts are dumped and
> that deleting an unknown context fails.
> 
> Add a GtpFamily ynl wrapper and register the test.
> 
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> ---
>  MAINTAINERS                                   |  1 +
>  tools/testing/selftests/net/Makefile          |  1 +
>  tools/testing/selftests/net/gtp.py            | 77 +++++++++++++++++++
>  .../testing/selftests/net/lib/py/__init__.py  |  5 +-
>  tools/testing/selftests/net/lib/py/ynl.py     |  8 +-
>  5 files changed, 89 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/net/gtp.py

You need to add GTP to the config (please not that configs are sorted)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6e43995e..8ac817a78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11423,6 +11423,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
>  F:	Documentation/netlink/specs/gtp.yaml
>  F:	drivers/net/gtp.c
> +F:	tools/testing/selftests/net/gtp.py
>  
>  GUID PARTITION TABLE (GPT)
>  M:	Davidlohr Bueso <dave@stgolabs.net>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index d4ca82fec..5366de878 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -44,6 +44,7 @@ TEST_PROGS := \
>  	fin_ack_lat.sh \
>  	fou_mcast_encap.sh \
>  	fq_band_pktlimit.sh \
> +	gtp.py \
>  	gre_gso.sh \
>  	gre_ipv6_lladdr.sh \

this is not the correct alphabetical order

>  	icmp.sh \
> diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftests/net/gtp.py
> new file mode 100644
> index 000000000..984c626b7
> --- /dev/null
> +++ b/tools/testing/selftests/net/gtp.py
> @@ -0,0 +1,77 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Tests for the gtp netlink family."""
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, ksft_in, ksft_not_in, ksft_raises
> +from lib.py import KsftSkipEx
> +from lib.py import NetNS, NetNSEnter
> +from lib.py import GtpFamily, NlError
> +from lib.py import CmdExitFailure
> +from lib.py import ip, defer
> +
> +
> +def _add_gtp_dev(ns):
> +    try:
> +        ip("link add gtp0 type gtp role ggsn", ns=str(ns))
> +    except CmdExitFailure:
> +        raise KsftSkipEx("no gtp support (CONFIG_GTP, iproute2)")
> +    defer(ip, "link del gtp0", ns=str(ns))
> +    ip("link set gtp0 up", ns=str(ns))
> +    return ip("-d link show gtp0", ns=str(ns), json=True)[0]["ifindex"]
> +
> +
> +def _iteis(contexts):
> +    return [c.get("i-tei") for c in contexts]
> +
> +
> +def add_del_pdp(gtp, ns) -> None:

We need a sentence or three describing what the test is trying to
validate

> +    link = _add_gtp_dev(ns)
> +
> +    gtp.newpdp({"link": link, "version": 1,
> +                "i-tei": 0x100, "o-tei": 0x200,
> +                "ms-address": "10.0.0.1", "peer-address": "192.0.2.1"})
> +
> +    pdp = [c for c in gtp.getpdp({}, dump=True) if c.get("i-tei") == 0x100]
> +    ksft_eq(len(pdp), 1)
> +    ksft_eq(pdp[0]["o-tei"], 0x200)
> +    ksft_eq(pdp[0]["ms-address"], "10.0.0.1")
> +    ksft_eq(pdp[0]["peer-address"], "192.0.2.1")
> +
> +    gtp.delpdp({"link": link, "version": 1,
> +                "i-tei": 0x100, "ms-address": "10.0.0.1"})
> +    ksft_not_in(0x100, _iteis(gtp.getpdp({}, dump=True)))
> +
> +
> +def add_two_pdp(gtp, ns) -> None:
> +    link = _add_gtp_dev(ns)
> +
> +    for i_tei, o_tei, ms in ((0x111, 0x211, "10.0.1.1"),
> +                             (0x112, 0x212, "10.0.1.2")):
> +        gtp.newpdp({"link": link, "version": 1,
> +                    "i-tei": i_tei, "o-tei": o_tei,
> +                    "ms-address": ms, "peer-address": "192.0.2.5"})
> +
> +    iteis = _iteis(gtp.getpdp({}, dump=True))
> +    ksft_in(0x111, iteis)
> +    ksft_in(0x112, iteis)
> +
> +
> +def del_unknown_pdp(gtp, ns) -> None:
> +    link = _add_gtp_dev(ns)
> +    with ksft_raises(NlError):
> +        gtp.delpdp({"link": link, "version": 1,
> +                    "i-tei": 0x999, "ms-address": "10.9.9.9"})
> +
> +
> +def main() -> None:

add some docstring here too, to avoid pylint warnings
please make sure ruff check is also clean

> +    with NetNS() as ns:
> +        with NetNSEnter(str(ns)):
> +            gtp = GtpFamily()
> +        ksft_run([add_del_pdp, add_two_pdp, del_unknown_pdp], args=(gtp, ns))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> index 71df5880b..8d34f2659 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -18,7 +18,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
>  from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
>  from .ynl import NlError, NlctrlFamily, YnlFamily, \
>      EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
> -from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
> +from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, GtpFamily, Netlink
>  
>  __all__ = ["KSRC",
>             "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
> @@ -32,6 +32,7 @@ __all__ = ["KSRC",
>             "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
>             "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
>             "NetdevSim", "NetdevSimDev",
> -           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
> +           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "GtpFamily",

strange place to insert the GtpFamily, alphabetically would be before
PSP ?
