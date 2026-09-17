Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E890492E2C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685483; cv=pass; b=I1zYBZQ7xVKfGG5YSfBW8Xr48XujuOjsNt2uIdcAyT2uM54VTfcCAjokv55AZIeVp1TO/j6iUyfMWEX6K5hKc2X9RAV7aOeCRR/cdoGIk4TqT+LEx2j85WjujyDtdanL0F+vGhAIOHjFDAJiAKRk3sqf+X2/OW0Ztcw2GyMvLzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685483; c=relaxed/simple;
	bh=4Xuxf3yPQP1MfjICZYuzKVbVDhN5kvQYVWP5uo8YgI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHP14L9IYuqlKMvMWfr3vMrHykjQ7Lxri8L5fWPCbdCrugJN9f9CkiY0K+KVWwNLNvJyb+7ot+sKrfbXD2CyCRTgYbexGimagr208J0ZI/Zi0QLclzLb23avaAvtzbwqtw7ynNepOoDD8s7RSodcNhlGEPXPs0TcExGBQjE0Twg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=yRr1u2Db; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="yRr1u2Db"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a05d236f53so99063137.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685480; cv=none;
        d=google.com; s=arc-20260327;
        b=C3bHZxQaBxVDbDihWnE+HwmzbQ5/4h41pFHHA5lJgCdPREQnXsYXlLixKifdmjX7O/
         5WpNNe3jfj8JxlGBtCBfqXvwM7lbkFkrNEeeQavCar79R/DA+ralL4MSJzdklFwsSNIj
         qp7e9ZBA3C197evcCX0GFJk/lrgT4Qs7sJftWAotu7r9GSZEbpkZmnJ8qWze1MaApqVl
         I1NIiyKNJBXOnLAuLJHxwigbTYRXyGcAZk6GUPoy7kCxgAtTtbD3iZATvTpeLQy7cak9
         RiUbgB46uMTtBEie5AbLGfzJ2JRoZGg/Bt882xEcp070LKKZWLy/xRbYD6f1pUftOCUh
         Yb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvfL0Aq6GcW6SzecELoGQDCwBaUQ5inZGAF540j/58g=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=KZTD7s9ExidfBwor2stu11CJyAPLaGOpuzq4A8z+i0pb1QecZ4+bT9MbtBrePAcFw3
         gSsERTfZ273KxB2DzhNpU1Mz6PR0EuMIpnazTyLBK2vertnHxUxNkMaZfqo/hjtB8NgC
         6Gg1Y1SfQbzn2oD3USOCjPusCeEU5GRQ+mhPgEVRWwMZMvRXxrs+TIp/gkCLYxxSQQiT
         Qh37B4tWvXoBExCVd8wd8xutfe1nFuaEBXExgbMxklQTC2QoWD/qdDU//Al6GgnRQz+A
         1qk2UreVv0kz2/YwrMsb6FWKysw54Pbqy8sIy4SfC1WrskS7O0el3D64unzUGY4du90p
         qKfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685480; x=1790290280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvfL0Aq6GcW6SzecELoGQDCwBaUQ5inZGAF540j/58g=;
        b=yRr1u2DbfRSpcvMDjGFg4lMkIEaeQwdKQ6YSpCV/pyTSriSCbU97vDs6IynRcmAUJz
         9CTZZ0L63I2nZsniKsVf0Io3IQZj+Do27fpXAb/Na0/1QtPXfsMBFBbJJ76B4/UiFSTL
         XJgH7fWb6mQqOu0sZ0fdci5tJCC15WpB9GEDk4v2LiMlXcKkC1qbwyAuM+0BZ6XHlpdM
         At+OIIZQMMPZnT3kHW44XIjtWnL8jXOlUfhkotvKafEq+KSEI3cJhcwHy4YAWKr9YNLg
         FAEF/L9aYoBbT5jN2cKjqbo4IV48qBq3JDAAsd57FA7iLYV3xRlDEGvlvkFTLDYLEggO
         F9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685480; x=1790290280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvfL0Aq6GcW6SzecELoGQDCwBaUQ5inZGAF540j/58g=;
        b=XXq6+K39lDyiCjQe66eQYdUgFLsR9gYUw97IR0CkjMcmqjCpVYCfwVohdq49SHdksM
         ZEDnHdWIXj17gv/KOBIAo/YijSyvTA5zLyy8L91Y3zzooN1NSGLS6901vOUYEs8jjewa
         xHSX7afOlwJh7s+wWaqdKQ8ttpVUhQ1ikxsN8UT6PpSXWcLKcEJ9RnjwQQR7kocq2ORm
         eqLxt4jAvVUJzJMH1eFfQOI4uBjXbsvbqIsyPgKBuHSnXRn5JTO9OTLEUrZMrFhcOLKV
         UmCN/orgTNarf5MY4NafG24/zFmpg3MgBa1X8SMlX+S/xXl+PFhCiRa3kB1h1aN2xoV+
         Qs+A==
X-Gm-Message-State: AFuF++mD9MMVOr5x3tu5mYGcmu425ipuiYW24kIki/WIyr7SWRD7Hnla
	ld4wFyW+8izHr6e8FRuO9lgeldQiMeuMUa1mhOQleRwRfUChsofYHSNhYwYlUeNo8q75JDfgyoR
	o+OE3TY5SSQO7uRZH1xN8REA35a0H6seUfbGxAOu31g==
X-Gm-Gg: AYBFou2tjt0KdQURR4Z9Qo5+Xu+okpKC04bbitEwTY+cZSWZGvW5mikCiS1RSXlTBhy
	Eo0WyWpaS8dDaHRSizCyvDrJwE4X7I4swwSFzKlO1fFKQ1zfTwySTBjMlvMuG74nnD+ACr1xzSx
	zhQF4dnO1T3KlHLsZy/t66fdePDesrY800CfGwA7ReHVDtukpqlpZsPst3LqbuQC4ew/w5pfug6
	tP7H9H43g3LE+WYDh3UgOKZMAVHQBhOQF2MTcpMjItlUi0gSRr2J9SX04d/sNdm6gWdkMTMj9/5
	RHO5wda7ogODk5rSXNCbX8EmV3D2OExBrEtxEwfkEWfwv4lbEh5eQHm2gYNKsEqjPxPj+AZ5B6d
	QKMGWHpxxPP4UQ+kLU4TxMbtd0oAWusLjLgsZohaaGdepbzFFqjjmxA04CgoJnUyWkp2aA8OrmW
	TOeF+XPQwhsdZrgBACaywelftCAnBWqs/RULHoZu/8IQ==
X-Received: by 2002:a05:6102:f85:b0:7a1:4799:33eb with SMTP id
 ada2fe7eead31-7a55a72b2ecmr334798137.5.1789685480362; Thu, 17 Sep 2026
 15:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-1-rjethwani@purestorage.com>
 <20260807183853.2288959-11-rjethwani@purestorage.com> <20260817151033.700f797b@kernel.org>
In-Reply-To: <20260817151033.700f797b@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:51:08 -0700
X-Gm-Features: AcwNN1Xrk_qPPJF6BU5yqrwMtFcA_E9Fc84OpGdrrnIIb4TkezZQgj8gN-G_jYA
Message-ID: <CAKaoeS0G2_COHXn4E=qwFKTwoZABE2mDhTp8CHc+W0q4WRyCtw@mail.gmail.com>
Subject: Re: [PATCH v16 10/10] selftests: net: add TLS hardware offload test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri,  7 Aug 2026 12:38:53 -0600 Rishikesh Jethwani wrote:
> > Two-node kTLS HW offload test using NetDrvEpEnv. A C helper binary
> > acts as TLS client or server; a Python harness drives it and verifies
> > TLS stat counters (RekeyOk, RekeyReceived, RekeyFallback,
> > RekeyInProgress, RekeyAborted, RekeyError, DecryptError).
> >
> > Covers TLS 1.2/1.3 with AES-GCM-128/256, rekey with various buffer
> > sizes, and burst variants that stress TX rekey (temporary SW phase,
> > HW reinstall) and RX rekey (boundary tracking, old-key reencryption,
> > deferred dev_add).
> >
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> >  MAINTAINERS                                   |   2 +
> >  .../selftests/drivers/net/hw/.gitignore       |   1 +
> >  .../testing/selftests/drivers/net/hw/Makefile |   2 +
> >  .../selftests/drivers/net/hw/tls_hw_offload.c | 975 ++++++++++++++++++
> >  .../drivers/net/hw/tls_hw_offload.py          | 295 ++++++
> >  5 files changed, 1275 insertions(+)
> >  create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offlo=
ad.c
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offlo=
ad.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 08e43bc09735..6e119592b72a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19066,6 +19066,8 @@ F:    Documentation/networking/tls*
> >  F:   include/net/tls.h
> >  F:   include/uapi/linux/tls.h
> >  F:   net/tls/
> > +F:   tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> > +F:   tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> >  F:   tools/testing/selftests/net/tls.c
> >
> >  NETWORKING [SOCKETS]
> > diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/=
testing/selftests/drivers/net/hw/.gitignore
> > index 46540468a775..f0a5d15b469b 100644
> > --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> > +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> > @@ -2,3 +2,4 @@
> >  iou-zcrx
> >  ncdevmem
> >  toeplitz
> > +tls_hw_offload
>
> nit: alphabetic sort would put tls before toeplitz?

I'll fix the order.

> > +static int client_connect_tls(void)
> > +{
> > +     struct sockaddr_in sa;
> > +     int csk;
> > +
> > +     csk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>
> IPv6 support is a must these days, should be pretty easy
> with getaddrinfo() ? Ideally we'd support forcing IP version
> using -4/-6 flags and appropriate plumbing on the Python side.
> Run at least a basic test over both

I'll add IPv6 support.

> > +     if (csk < 0) {
> > +             printf("SETUP ERROR: failed to create socket: %s\n",
> > +                    strerror(errno));
> > +             return -1;
> > +     }
> > +
> > +     memset(&sa, 0, sizeof(sa));
> > +     sa.sin_family =3D AF_INET;
> > +     sa.sin_addr.s_addr =3D inet_addr(server_ip);
> > +     sa.sin_port =3D htons(server_port);
> > +     printf("Connecting to %s:%d...\n", server_ip, server_port);
> > +
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b=
/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > new file mode 100755
> > index 000000000000..b8f5a3314030
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > @@ -0,0 +1,295 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +"""Test kTLS hardware offload using a C helper binary."""
> > +
> > +from collections import defaultdict
> > +
> > +from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
> > +from lib.py import ksft_variants, KsftNamedVariant
> > +from lib.py import NetDrvEpEnv
> > +from lib.py import cmd, bkg, wait_port_listen, rand_port
> > +from lib.py import CmdExitFailure
> > +
> > +# Burst variants push hundreds of MB and perform many rekeys; the
> > +# default cmd() timeout (5s) is too short.
> > +BURST_TIMEOUT_S =3D 180
> > +
> > +
> > +def check_tls_support(cfg):
>
> please make sure pylint --disable=3DR passes cleanly on new Python files
> docstring missing here (you can prefix the trivial local helpers with
> _ to avoid that)

I'll add docstrings to all functions that lacked them
(check_tls_support and the other helpers/tests), and added from e to
the two KsftSkipEx re-raises.

> > +    try:
> > +        cmd("test -f /proc/net/tls_stat")
> > +        cmd("test -f /proc/net/tls_stat", host=3Dcfg.remote)
> > +    except CmdExitFailure as e:
> > +        raise KsftSkipEx(f"kTLS not supported: {e}")
>
> That's fine, but you also must update the
> tools/testing/selftests/drivers/net/hw/config
> config to make sure that x86 defconfig + that file result in a build
> with working TLS offload

I'll add the TLS core + offload options plus the mlx5 driver chain to
tools/testing/selftests/drivers/net/hw/config.


> > +    try:
> > +        features =3D cmd(f"ethtool -k {cfg.ifname}").stdout
> > +        if 'tls-hw-tx-offload: on' not in features:
> > +            raise KsftSkipEx("Device does not support TLS HW TX offloa=
d")
> > +        if 'tls-hw-rx-offload: on' not in features:
> > +            raise KsftSkipEx("Device does not support TLS HW RX offloa=
d")
> > +    except CmdExitFailure as e:
> > +        raise KsftSkipEx(f"Cannot determine TLS HW offload support: {e=
}")
> > +
> > +
> > +def read_tls_stats(host=3DNone):
> > +    stats =3D defaultdict(int)
> > +    output =3D cmd("cat /proc/net/tls_stat", host=3Dhost)
> > +    for line in output.stdout.strip().split('\n'):
> > +        parts =3D line.split()
> > +        if len(parts) =3D=3D 2:
> > +            stats[parts[0]] =3D int(parts[1])
> > +    return stats
> > +
> > +
> > +def stat_diff(before, after, key):
> > +    return after[key] - before[key]
> > +
> > +
> > +def check_path(before, after, direction, role, require_hw):
> > +    """On the DUT, require HW offload; on the remote, HW or SW is fine=
."""
> > +    dev =3D stat_diff(before, after, f'Tls{direction}Device')
> > +    sw =3D stat_diff(before, after, f'Tls{direction}Sw')
> > +    if require_hw:
> > +        if dev < 1:
> > +            ksft_pr(f"FAIL: {role} {direction}: HW offload not engaged=
 "
> > +                    f"(Device=3D{dev}, Sw=3D{sw})")
>
> ksft_lt(..., comment=3D"your string") ?
> Please use the official check helpers

 I'll switch everything over to the official ksft check helpers and
drop the hand-rolled error-counting entirely.


> > +def main() -> None:
> > +    with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
> > +        cfg.bin_local =3D cfg.test_dir / "tls_hw_offload"
> > +        if not cfg.bin_local.exists():
> > +            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg=
.bin_local}")
> > +        cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
> > +        cfg.require_ipver("4")
> > +        check_tls_support(cfg)
> > +
> > +        ksft_run([test_tls_offload, test_tls_offload_rekey,
> > +                  test_tls_offload_burst], args=3D(cfg, ))
> > +    ksft_exit()
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
>
