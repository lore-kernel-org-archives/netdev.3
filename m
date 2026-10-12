Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A623B3BE9;
	Mon, 12 Oct 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831308; cv=none; b=IWLVNMLcPWzockNtaY4ZVz5OC1g3XIoBaxKPtMIMw40xO3+0p47UYQAmTkBea0fAOMvJKJzS/UpunP6gyGgBLqRTk+7f41Y1tdZxpceoC/9pG84PZpaWeFVG2VMffSZ/O1q0n08lCqFNXZ5vOSz9jKtcP2DlL0XFAVlWtpcryX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831308; c=relaxed/simple;
	bh=8hELTSxHlCkmI97AVMjsFD7U8AjcRzKvsoJ0jemvbLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ms76kSqeN8nIJXOosTvNxX3L8MDfJpABcbR7TDhtoBwHTxNRnED7YkzLqJV8MCF+puieN6OsCcQJLg/byyMyokgJtjJNN8d8bk6kMTTpX07Y74FT8RiV0NlLiNGl4zuXWdFFxWZz1dxRvA+MHhKboGnWYH7MqXg0MwqEN+gqcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Q0duKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Q0duKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770861F0089B;
	Mon, 12 Oct 2026 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831307;
	bh=6vfqQO2QrV6a6SUEG26degKJt9tS+iPZ7F4DeqIuSUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d7Q0duKkPOgJgsD7HggLgdoH2++bwmjww1MuoPk6EYJ5tPcnC/wzgWF1Umq85+aec
	 +2FpbGIfAoS2wo14iB+Gwdry2wwtyOjrhu8BGcTvHjJa4tteRqTJpTug+5wmN2Z0SY
	 4ml7gsyA1N1nYteowWR1eB6VfsNpSzHNLcGSnDPOk4IFluu+wv8PjWRpP+nrJDjIRy
	 IatT4EHqC0dFAbRYZNCiie15KBcMT7jHh1SQavuPD16O3nIaFiuGijsIxenyACqXSi
	 sQFiTpvNoJmkIp8VLgQwqI6RvwyxvBFDPKAipYQoQxOjz5ycwZXXfaNCK2vb7d+4IR
	 Dtdu2bSwFLDfA==
Subject: Re: [PATCH net-next v2 3/3] selftests: net: add a test for the gtp
 netlink family
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: pablo@netfilter.org, laforge@gnumonks.org, donald.hunter@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 18:55:06 +0000
Message-ID: <179183130606.434549.10085139421249310466@kernel.org>
In-Reply-To: <20261008181031.4129029-4-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-4-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/gtp.py, main() calls
  GtpFamily() (line 71) inside NetNSEnter, before ksft_run() and before…
- [Medium] The patch adds gtp.py to TEST_PROGS in
  tools/testing/selftests/net/Makefile (line 47) but does not add…
- [Medium] Documentation/netlink/specs/gtp.yaml was added by commit
  "netlink: specs: add genetlink-legacy spec for GTP" in this series and…
- [Low] Both delpdp calls in gtp.py, add_del_pdp (lines 42-43) and
  del_unknown_pdp (lines 64-65), send 'i-tei' together with 'ms-address'.
- [Low] _add_gtp_dev() in tools/testing/selftests/net/gtp.py catches
  every CmdExitFailure from `ip link add gtp0 type gtp role ggsn` and…
- [Low] tools/testing/selftests/net/gtp.py is added with `new file mode
  100644` (confirmed in the commit diff) but is listed in TEST_PROGS,…

--

selftests: net: add a test for the gtp netlink family

This adds a Python selftest for the gtp generic netlink family, driven by
its ynl spec. It creates a gtp device and checks newpdp, getpdp and
delpdp. It also adds a GtpFamily ynl wrapper to the selftest library and
registers gtp.py in TEST_PROGS.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 54beea2e348c4..3b9279bcdb6ec 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -44,6 +44,7 @@ TEST_PROGS := \
>  	fin_ack_lat.sh \
>  	fou_mcast_encap.sh \
>  	fq_band_pktlimit.sh \
> +	gtp.py \

[Severity: Medium]
Should CONFIG_GTP=m also be added to tools/testing/selftests/net/config?

The config fragment has no CONFIG_GTP entry, and GTP is an opt-in
tristate. Kernels built from the net selftest config fragment, as CI
does, will not have the gtp driver or the gtp genl family. On those
kernels newpdp, getpdp and delpdp never get exercised.

Other tests in this directory that need a driver list it there, for
example CONFIG_GENEVE=m, CONFIG_VXLAN=m, CONFIG_AMT=m and
CONFIG_BAREUDP=m.

Because of the GtpFamily() ordering in main() (see below), those runs
would also be reported as failures, not skips.

[ ... ]

> diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftests/net/gtp.py
> new file mode 100644
> index 0000000000000..984c626b7172a
> --- /dev/null
> +++ b/tools/testing/selftests/net/gtp.py
> @@ -0,0 +1,77 @@
> +#!/usr/bin/env python3

[Severity: Low]
This isn't a bug, but gtp.py is added with mode 100644 even though it is
listed in TEST_PROGS.

For a non-executable test, run_one() in
tools/testing/selftests/kselftest/runner.sh prints:

    Warning: file $TEST is not executable

It then falls back to parsing the shebang. Running ./gtp.py directly
fails with permission denied.

Could the file be committed with the executable bit set?

[ ... ]

> +def _add_gtp_dev(ns):
> +    try:
> +        ip("link add gtp0 type gtp role ggsn", ns=str(ns))
> +    except CmdExitFailure:
> +        raise KsftSkipEx("no gtp support (CONFIG_GTP, iproute2)")

[Severity: Low]
Should this skip only when gtp is actually unsupported?

Right now any CmdExitFailure from ip link add becomes a KsftSkipEx. A
real failure would be reported by ksft_run() as a skip, not a fail. That
covers a regression in gtp_newlink() or gtp_create_sockets(), and also
an EEXIST for gtp0, which all three cases share in one netns.

> +    defer(ip, "link del gtp0", ns=str(ns))
> +    ip("link set gtp0 up", ns=str(ns))
> +    return ip("-d link show gtp0", ns=str(ns), json=True)[0]["ifindex"]

[ ... ]

> +    pdp = [c for c in gtp.getpdp({}, dump=True) if c.get("i-tei") == 0x100]

[Severity: Medium]
Is the link attribute missing from the getpdp reply in
Documentation/netlink/specs/gtp.yaml? That spec was added earlier in this
series by "netlink: specs: add genetlink-legacy spec for GTP", and this
test is its first user.

The reply attribute list is:

        reply: &pdp-reply
          attributes:
            - version
            - tid
            - peer-address
            - peer-addr6
            - ms-address
            - ms-addr6
            - flow
            - i-tei
            - o-tei
            - family

The dump reply reuses the same list. However, gtp_genl_fill_info() in
drivers/net/gtp.c always sends it:

	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
	    nla_put_u8(skb, GTPA_FAMILY, pctx->af))

Python ynl decodes against the whole attribute set, so this test is not
affected. The generated C ynl code only parses the reply attributes
that are listed. C users of getpdp would therefore not see which gtp
device a dumped context belongs to.

Should link be added to pdp-reply?

[ ... ]

> +def del_unknown_pdp(gtp, ns) -> None:
> +    link = _add_gtp_dev(ns)
> +    with ksft_raises(NlError):
> +        gtp.delpdp({"link": link, "version": 1,
> +                    "i-tei": 0x999, "ms-address": "10.9.9.9"})

[Severity: Low]
Is i-tei actually used for the lookup in this call, and in the delpdp
call in add_del_pdp()?

gtp_find_pdp_by_link() in drivers/net/gtp.c checks the MS address first:

	if (nla[GTPA_MS_ADDRESS]) {
		__be32 ip = nla_get_be32(nla[GTPA_MS_ADDRESS]);
		...
		return ipv4_pdp_find(gtp, ip);
	} else if (nla[GTPA_MS_ADDR6]) {
		...
	} else if (nla[GTPA_VERSION]) {

When ms-address is passed, the i-tei values (0x999 here, 0x100 in
add_del_pdp()) are ignored. The GTPv1 TEI lookup through gtp1_pdp_find()
is never exercised on the delete path.

Also, ksft_raises(NlError) accepts any netlink error. gtp_find_pdp()
maps a failed lookup to ENOENT:

	if (!pctx)
		pctx = ERR_PTR(-ENOENT);

Could this case check for ENOENT? Otherwise an unrelated EINVAL, ENODEV
or EPERM would also pass.

> +
> +
> +def main() -> None:
> +    with NetNS() as ns:
> +        with NetNSEnter(str(ns)):
> +            gtp = GtpFamily()
> +        ksft_run([add_del_pdp, add_two_pdp, del_unknown_pdp], args=(gtp, ns))

[Severity: Medium]
Can this fail instead of skip when the gtp module is not loaded yet?

GtpFamily() runs before any test has done ip link add ... type gtp.
YnlFamily resolves the family id in _genl_load_families(), which uses a
CTRL_CMD_GETFAMILY dump.

ctrl_dumpfamily() only walks families that are already registered.
request_module() is only called from ctrl_getfamily(), so the dump does
not autoload gtp.ko.

This happens with CONFIG_GTP=m before gtp.ko is loaded (the default
after boot), and with CONFIG_GTP=n:

main()
  GtpFamily()
    YnlFamily.__init__()
      GenlProtocol.__init__()
        _genl_load_families()      -> KeyError on 'gtp'
      raise YnlException("Family 'gtp' not supported by the kernel")

Nothing in main() catches this exception. The script exits with
status 1, and the KsftSkipEx in _add_gtp_dev() is never reached.

Could the module be loaded before GtpFamily() is created, for example by
creating the device first? A missing family could then be turned into a
skip.

> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008181031.4129029-1-anilkaushikwireless%40gmail.com
