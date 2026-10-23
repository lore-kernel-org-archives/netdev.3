Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755898;
	b=MWfg0nd69zR556SBheIIhru04D1ZlTT9H7PeE1H2RLMV236WZoUoJsyr3jTIZ4XfLfHk
	 aT8XLQekACJztjDY8o/BTqsILX+YVad5SCdTy92RzRvMfksl4gHQnx/NAdeDhIYOrU9XE
	 A63YAjC1TgKIV9eSlKxRXkeIhqxHPTxLbgHHMit7gGo6l+h9fEF9C4JWj4fa9jDs8DpDe
	 Nf8wrSdLpYf0FKhwUmnYfJXTmobUEeDpDRcuKmleRNyDB9DC+68AdlmE33SQG+xfI5zlr
	 DrDt58IJVok/YTL7vFx4eV3xW2RxAXAQc0DUuAvOJCUry4LwQ6t62goJceI5tBZDLjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=lxqbvwFqN6f0307wk9swW4RU/zRuHzzzT93nJYQ+qnU=;
	b=pceI6ooDkrZzggGCfLLPLox8jBfVDqi8yXxs7gsqOf/7/Zyt4Hz0nX+tfysGGV8kObFQ
	 6PWKF6mefBxpOdePQZDoS9mK73ztFdOTAmYgiUpNCTh7Zunu3YhGHivx2pXC+P9D2xmmN
	 ZXGitSdVDn+8v6zI2durzcQJ4FtD/9qD4TqePHs7FoRu3UWifdvJyjxKKS3sKr8nC3y0C
	 I8jQxtnRh615y4O5qofB1U9kgFlxsJYGPE0Cl10zv6zAmhkFLfHpdVFgnHjA7yqkk6aQu
	 WvmJlD3QhkxqiWTCGV5F1rD2ToY7fvc8fAtJROjgOOeESTjTJsN8eKLNvvylPqXD7iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jd5We0KK;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501B606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6501B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jd5We0KK
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93ece7a73b9so97203085a.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792755896; x=1793360696; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lxqbvwFqN6f0307wk9swW4RU/zRuHzzzT93nJYQ+qnU=;
        b=Jd5We0KK4r7BGz3mXWEYz/W3selomABFv7LO9gn394fAvZWbNudJAk907/5PZwsxtc
         RlhuxnmCCbboGFbmjArGt3nyDfCUusCqT6PQN7JZCQ+YAdvYicTNofA15pdQ8O/MN3oA
         J4FbkTpcAQBqIcLRv++bpjgPwNeErWzhE+MNlCivStmYSOH0XjB/qIMJC7mFN9VO8fPJ
         6KL5igRidfcSo/acV1VkFRjpfsMi4djZtZWDf9lW0gq5B48FSQLPiAKwC51McIbd5zG/
         JUyIF82ngz68jM0OmDjcIUz4nmcscizr1snFAC3Teid6joyVSVP2ZnFdYLrXOhj2Idi4
         9/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755896; x=1793360696;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxqbvwFqN6f0307wk9swW4RU/zRuHzzzT93nJYQ+qnU=;
        b=geha8X3HveEYEOL3BptU0JiEEz5mTMfLaqBp5gYJ3txUkCggiANGUSPiXsY1lVC0z4
         LjgIMzdh5C67CUlHxLTyEwHf2MEoKO0zGy24iPR93TjcavBJ5bqtH8IneBA7yXLqyfUe
         lGIFUuRoN/HvAWwDRYrO2LJNMbs4O3+pon6axv3yC6eEIdtlzzXTCSEDo6AjRRYgERe8
         c2D1gSP5u8uZAODY4QAzLRrtwx4M2ENMVa1B6vn3LY3Y8bCYPEs8oSm2Nq7F3WVwaQVz
         hGaG9zy29D/lcSn89GrCjrev2r33TlQCWFnle4NhvA9pQZ+Qj0NrAi7Vk+kcplXBEHTM
         /cLA==
X-Forwarded-Encrypted: i=1; AKwUvBwdvqUPIoqcU8n7Ycd9o4UBlAUM6HiG4f9bBC4vwEiyuAZ3CxIow+yE+mVeTbRWyEI5IXee6XQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnqUaUiihoQ37j086pXReCD9aVqn7Rld6MKW1PW4O2v/uDoPZH
	QnPCMX4N8AVGYA6UfpcY8Ur0chHG4bDY0fBZuuS20cv33u7jkN/0AN6e
X-Gm-Gg: AYBFou3k8Ld/TfMAIUAUBKchlZ87IP+vf/5k8ppV8un/QbTxQQwBBFb3VuGwJBIqiP2
	vPMvySisASANRmzUx60vYclSPrcJr82N8usNTsq34bZB7yyqwOAQ02ZxAewNZSBT6teNi87IfPz
	I0kRKVg91i8CiNHr4H0fiXzmGzNRB/tUVM0evlg0yLe6F+0Kg8mk81Md0R2n45W958jKH75SAi2
	nADbCYwX0eQIHkz0khvlrFfKJJC90YVPDxLKv5D8pvZ2vLV4ZwGXvkSl0VOHEd3ReRD7BGYK+Lc
	GT1dZ3txgyzKaVw+nPnx/mUbyKgAmHpIQMl4jWoYQGyVr/KCyk9yFAa9s7vFN20CX7q9aAVwu2m
	xPyXpzMMMSsH9HeQgFAsGZwid8XbTKiHa+1dCZ71QjKbIzGJygD+3+sy/lDxpITwbduzutZULz0
	DR/UAN9H6RbIIO7dhKTeQf3lvteYdqC2XrNd5nRBT/NFvqMrFZ6oFyHdQIhE25gOL+HS+yfvttG
	3pbHGtR2VA81kkB3M/SNw4kB81xWv9Ql826CIPjcWuzihdZj5TwNbbEWfmkEfcom/UPiN/0eVLQ
	IYRPtw==
X-Received: by 2002:a05:620a:2717:b0:93e:9171:b72 with SMTP id af79cd13be357-93f6f804a63mr353515885a.49.1792755896252;
        Fri, 23 Oct 2026 04:44:56 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f70f23995sm161994485a.12.2026.10.23.04.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 04:44:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 07:44:54 -0400
Message-Id: <DMC6XCEXFL8R.3THQH42V46UX@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>, "Raed Salem" <raeds@nvidia.com>, "Rahul Rameshbabu"
 <rrameshbabu@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: psp: test ipv6 tcp
 socket with extension headers
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261022223014.556388-1-toddfreed@meta.com>
 <20261022223014.556388-3-toddfreed@meta.com>
In-Reply-To: <20261022223014.556388-3-toddfreed@meta.com>

On Thu Oct 22, 2026 at 6:30 PM EDT, Todd Freed wrote:
> send on a psp tcp socket in three phases, checking the device's
> tx-packets and what the peer received after each
>
> 1/ no socket options - the data is sent and counted.
>
> 2/ an extension header set on the socket - with destination or
>    hop-by-hop options, the data is sent, counted, and received by the
>    peer. with a routing header, the packets are dropped, tx-packets is
>    unchanged, nothing reaches the peer, and the data stays queued.
>
> 3/ option removed - any queued data, then new data, is sent, counted,
>    and received.
>
> phases 2 and 3 run three times: with a destination options header
> (IPV6_DSTOPTS) and with a hop-by-hop options header (IPV6_HOPOPTS), each
> holding one padn option, and with a segment routing header
> (IPV6_RTHDR) whose only segment is the peer.
>
> in phase 2, a software filter on the peer also counts udp packets from
> the socket's address to the peer's. the psp packets reach the peer as
> decrypted tcp packets, as expected. malformed or unencrypted packets
> show up as udp, and the test asserts there are none. if the peer can't
> take the filter, the test is skipped.
>
> tx-packets is read after it has quiesced, because some devices refresh
> counters periodically (mlx5 takes about a second).
>
> without the fix in the preceding patch:
>
> - with netdevsim, the peer receives none of the data of phase 2, and the
>   test fails on that.
> - with mlx5 (connectx-7), the packets go out unencrypted and aren't
>   counted in tx-packets. the test fails on the udp packets which reach
>   the peer. capturing on the peer,
>
>     tcpdump -i <dev> -nn -A 'ip6 and src host <sender> and not tcp'
>
>   shows them as udp, with the test's payload readable
>
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---
>  tools/testing/selftests/drivers/net/config |   1 +
>  tools/testing/selftests/drivers/net/psp.py | 138 ++++++++++++++++++++-
>  2 files changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/s=
elftests/drivers/net/config
> index 4838adf27fa1..409f9a96a102 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -4,6 +4,7 @@ CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
>  CONFIG_INET_PSP=3Dy
>  CONFIG_IPV6=3Dy
>  CONFIG_MACSEC=3Dm
> +CONFIG_NET_ACT_GACT=3Dm
>  CONFIG_NET_ACT_SKBEDIT=3Dm
>  CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_BPF=3Dy
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
> index a5b1e14f120f..47e8cb19f376 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -16,12 +16,12 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
>  from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
>  from lib.py import ksft_not_none
>  from lib.py import ksft_variants, KsftNamedVariant
> -from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import KsftSkipEx, KsftFailEx, CmdExitFailure
>  from lib.py import NetDrvEpEnv, NetDrvContEnv
>  from lib.py import Netlink, NlError, PSPFamily, RtnlFamily
>  from lib.py import NetNSEnter
>  from lib.py import bkg, rand_port, wait_port_listen
> -from lib.py import ip
> +from lib.py import ip, tc
> =20
>  TCP_ULP =3D 31
> =20
> @@ -120,6 +120,57 @@ def _check_data_outq(s, exp_len, force_wait=3DFalse)=
:
>  def _get_stat(cfg, key):
>      return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
> =20
> +
> +def _get_quiesced_stat(cfg, key, timeout=3D10):
> +    """
> +    Like _get_stat(), but wait till the value stops changing. Note
> +    that some devices refresh flow counters periodically, e.g. once
> +    per second with mlx5.
> +    """
> +    val =3D _get_stat(cfg, key)
> +    end =3D time.monotonic() + timeout
> +    while True:
> +        time.sleep(1.5)
> +        new =3D _get_stat(cfg, key)
> +        if new =3D=3D val:
> +            return val
> +        val =3D new
> +        if time.monotonic() >=3D end:
> +            ksft_pr(f"{key} still changing after {timeout}s: {val}")
> +            return val
> +
> +
> +def _remote_udp_from(cfg, src, dst):
> +    """
> +    Count what reaches the remote from @src to @dst as UDP, with a softw=
are
> +    filter on its ingress (offloaded filter counters are refreshed
> +    periodically). Returns a function reading the count, or None if the
> +    filter can't be installed.
> +    """
> +    flt =3D (f"dev {cfg.remote_ifname} ingress protocol ipv6 pref 1 "
> +           f"handle 0x5053 flower")
> +    try:
> +        qdiscs =3D tc(f"qdisc show dev {cfg.remote_ifname}", json=3DTrue=
,
> +                    host=3Dcfg.remote)
> +        if not any(q['kind'] =3D=3D 'clsact' for q in qdiscs):
> +            tc(f"qdisc add dev {cfg.remote_ifname} clsact", host=3Dcfg.r=
emote)
> +            defer(tc, f"qdisc del dev {cfg.remote_ifname} clsact",
> +                  host=3Dcfg.remote)
> +        tc(f"filter add {flt} skip_hw src_ip {src} dst_ip {dst} "
> +           f"ip_proto udp action drop", host=3Dcfg.remote)
> +    except CmdExitFailure as e:
> +        ksft_pr(f"Can't count UDP on the remote: {e}")
> +        return None
> +    defer(tc, f"filter del {flt}", host=3Dcfg.remote)
> +
> +    def count():
> +        filters =3D tc(f"-s filter get {flt}", json=3DTrue, host=3Dcfg.r=
emote)
> +        for f in filters:
> +            for act in f.get("options", {}).get("actions", []):
> +                return act["stats"]["packets"]
> +        raise KsftFailEx("no action on the remote filter")
> +    return count
> +
>  #
>  # Test case boiler plate
>  #
> @@ -624,6 +675,89 @@ def removal_device_bi(cfg):
>          _close_conn(cfg, s)
> =20
> =20
> +def data_send_ipv6_exthdr(cfg):
> +    """ Test PSP on IPv6 packets with extension headers """
> +    cfg.require_ipver("6")
> +    _init_psp_dev(cfg)
> +
> +    s =3D _make_psp_conn(cfg, 0, "6")
> +    try:
> +        # In happy path, PSP traffic arrives at the remote decrypted as =
TCP
> +        remote_udp =3D _remote_udp_from(cfg, s.getsockname()[0],
> +                                      s.getpeername()[0])
> +        if not remote_udp:
> +            raise KsftSkipEx("can't count UDP on the remote")
> +
> +        rx_assoc =3D cfg.pspnl.rx_assoc({"version": 0,
> +                                       "dev-id": cfg.psp_dev_id,
> +                                       "sock-fd": s.fileno()})
> +        tx =3D _spi_xchg(s, rx_assoc['rx-key'])
> +        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
> +                            "version": 0,
> +                            "tx-key": tx,
> +                            "sock-fd": s.fileno()})
> +        _check_data_outq(s, 0)
> +
> +        def wait_outq_empty():
> +            for _ in range(100):
> +                if _get_outq(s) =3D=3D 0:
> +                    break
> +                time.sleep(0.5)
> +            _check_data_outq(s, 0)
> +
> +        # 1. No options: sent and counted
> +        tx_pkts =3D _get_quiesced_stat(cfg, 'tx-packets')
> +        total =3D _send_careful(cfg, s, 20)
> +        wait_outq_empty()
> +        ksft_gt(_get_quiesced_stat(cfg, 'tx-packets'), tx_pkts)
> +        _check_data_rx(cfg, total)
> +
> +        # An extension header with one PadN option, as destination optio=
ns
> +        # and as hop-by-hop options, and a segment routing header with t=
he
> +        # peer as its only segment
> +        padn =3D bytes([0, 0, 1, 4, 0, 0, 0, 0])
> +        srh =3D bytes([0, 2, 4, 0, 0, 0, 0, 0]) + \
> +            socket.inet_pton(socket.AF_INET6, s.getpeername()[0])
> +        for name, opt, val, sent in (
> +                ("IPV6_DSTOPTS", socket.IPV6_DSTOPTS, padn, True),
> +                ("IPV6_HOPOPTS", socket.IPV6_HOPOPTS, padn, True),
> +                ("IPV6_RTHDR", socket.IPV6_RTHDR, srh, False)):

Maybe parameterizing the test over these options would be better than
the for loop. Then one failure in the chain wouldn't make the whole test
fail, and features like filtering by test case would work.

> +            # 2. With the option. Destination and hop-by-hop options: se=
nt
> +            # encrypted, with UDP + PSP after the extension header, coun=
ted,
> +            # and received. Routing header: dropped, not counted, and th=
e
> +            # data stays queued. Nothing reaches the peer as plain UDP.
> +            s.setsockopt(socket.IPPROTO_IPV6, opt, val)
> +            tx_pkts =3D _get_quiesced_stat(cfg, 'tx-packets')
> +            udp =3D remote_udp()
> +            queued =3D _send_careful(cfg, s, 20)
> +            if sent:
> +                total +=3D queued
> +                wait_outq_empty()
> +                ksft_gt(_get_quiesced_stat(cfg, 'tx-packets'), tx_pkts,
> +                        comment=3Dname)
> +            else:
> +                _check_data_outq(s, queued, force_wait=3DTrue)
> +                ksft_eq(_get_quiesced_stat(cfg, 'tx-packets'), tx_pkts,
> +                        comment=3Dname)
> +            ksft_eq(remote_udp(), udp, comment=3Df"{name}: UDP at the re=
mote")
> +            _check_data_rx(cfg, total)
> +            if not sent:
> +                total +=3D queued
> +
> +            # 3. Option removed: any queued data, then new data, sent an=
d
> +            # counted
> +            tx_pkts =3D _get_quiesced_stat(cfg, 'tx-packets')
> +            s.setsockopt(socket.IPPROTO_IPV6, opt, b'')
> +            wait_outq_empty()
> +            total +=3D _send_careful(cfg, s, 20)
> +            wait_outq_empty()
> +            ksft_gt(_get_quiesced_stat(cfg, 'tx-packets'), tx_pkts,
> +                    comment=3Dname)
> +            _check_data_rx(cfg, total)
> +    finally:
> +        _close_psp_conn(cfg, s)
> +
> +
>  def _get_psp_ver_ip_variants():
>      for ver in range(4):
>          for ipv in ("4", "6"):

