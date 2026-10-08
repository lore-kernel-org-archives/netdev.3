Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED473B9922
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449931; cv=pass; b=k2KvgY6gycqh9gsGYmx+enuiZjTMJTpef6h6Onbtyo2DElug5VKK3gRT1PG6nGHjpWFsI2aMDP5zoWWjoP+yPjNkVuS+b11qzkRnbiAC6ltCpT1I58SO0w5iwPNFXgGGZaiy9jt2LZmD0bm/V4qY5OCOjnAPffZN4FFVRj3aqec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449931; c=relaxed/simple;
	bh=iGhry8OSy5NpUf/OudCWP+OhrPgRkmkd2lyoQM640zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggOge0jbQtY0gH7hY0ek5Sh39XhP871nmc19X6fWgS7U/RR3E7gDnLiFNAedqL28AyNeYzRFF50bH0oWbOTdUrPm3ecHFTITIOD1IGwSpBjK0LT6FOm0ILIJy2bayuL67BorZSyOnAHD9j0D25xC3w7bDjrfgPv1MSAQstBbTN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/mrppHW; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/mrppHW"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535853983f0so9765731cf.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 01:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449928; cv=none;
        d=google.com; s=arc-20260327;
        b=sNll/+Y2QhCPd+j9kP7eIqAe6MTD3L0A3/UHS0gPpZF9yrc8AJNydKWBXOnZk9cdmQ
         0uinnIzG1epAlb8S/Ia7YxN5toBmTQJ3Mp5BXUt29nltel3ZN+P+X4CGiAEIIGKg0fgf
         rUCq3p1ZjDwIhzGG22QLcVkaYj5HtKF3IqpchPOOZZnx7Qntj7Rvv50XDk18Z49vZeh+
         6LyIbjmcG3Znbsz5epyZ/Yinbo94PFIBNtxzO8J0WVNIzoflT7q+A0olFUWtjp0mbVJG
         DPMJeEO/kCGXmVRvbLHbevtnMmuBXj/g01F+JYEL9PWYwFmj+D8twULC3myh888hTr9l
         ggCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        fh=WrcdMP/Lht6P4BMZA6nITh7W/GOq93K14vFbP3i84u0=;
        b=CgSd/MIt2ogmrBVS4wXpPF7/eunUO9woWIa9fzMCNNARbVrhNa4fbOTXdtXznKKISW
         Q4S5SkreZ5f04jjS8gP28jp/3LmZyawmq7+JtugTCndwp9qSLXkZhl8Vti+SWKrHhTQf
         OjkWRZb973dqYu2PLl6RuHaS46KTLNHocRNMgYWIBRCK4GGq/L0J9VFt7qOMfROynEgb
         CcxFuqgis2mzmnsHK8cnuDggwT0Z759KBoH5FkXur7tugiZ7sWCwE8C1yql6XKBcetnz
         1bdDT2U6BslqYv8OMJyr3VrHX8NblVlytTT6r9BciNIDfxL4WxlHQ6CaUPngpnZvIIw8
         HgvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791449928; x=1792054728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        b=k/mrppHWHh45MEVr5E2/8aU06otdklFCqFyMBV8Rj8BKpZ6b8PsFu0rJhFrgGO2Iq9
         1xcls0/op5jgGRP1J4ukYvyZK4grAnnG84CeNmL1IpDoq5ICYZsr4FM3ZEkWnDm1/D+B
         EFUEiTtdYl3Y4eFZ/Rwp88WLvibenwPvUfsb/NyZYHucm/axs323J11xrfdEBmsG7PMZ
         B+o5Omb3EW67VyuM9m7BYQlSJ4ciNKamW87wknCagz1U6z5Iqadaa4j9xdH8/Lxex0WC
         TyuRocEjnVyQqFXSMKTJX2MMc91ze9iiz2FFhhA8BtbNer7NmXKUabtnuW2JvgkDcNYw
         6RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449928; x=1792054728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6WGTpJs/XXXD3HACG4yE9wcBHyQvNNrKktD1oYCass=;
        b=CA3sq2zAu650MTDTuvdE+Ki5RGWCFHcPjPhUAe1tDSVGqEtlYiXp+mk5yCIfLoUAZ9
         Hm0zq876UHnvqj6XgQk+7SY1A/+mhz4/zKpt6k2cDpI1nCUqGQzrVdBtpl9zvSBW4rZj
         P+J75x6LaSDX8lZromjOD3NP+evnbv1+/5M60jdx4x4a/Wlw8IxIMcHXHdwuMt0nOpx4
         N1CYUW63K4CWnl613chIcRXWxr0vnjmcAmgf0wHPiZmLmBry/KlFY8tkpAnqpbzco1kc
         bUmgX0TXN6xBAVs044ETyZ3pem+6JQdulnkOE2UjLrq+B2xcTH6BSKILaS5MUfJtF2lN
         u0pg==
X-Forwarded-Encrypted: i=1; AKwUvBwe+LIbxmijdyWjTVbrrUV9Aayvc1mkcAROYZqMrhmwT6raiU+3ayDHT/XjOmDw0BlIS3+zoog=@vger.kernel.org
X-Gm-Message-State: AFuF++lplhaZkVZXmAChRC2ZwKV3B6BTZxypW3ukT+DGML2hrYXbW/vE
	q8Brny309sZ7iFmLg22xDVmzkyisGV86tNA+ZU5ALBiQGszPsJXHilG1voNYy2Ir5uIq3FjP7rM
	22A5LSzyDVKLNH3Nj494r349Be/8FRHvdFplyIKE=
X-Gm-Gg: AYBFou341nKSuMDWX1WIdlbi5gEO5f/YTG8T5iw2njP2NLcSdauj9pVWRscHw9Rm1nh
	WdHb/TPUDtZhmboVyvc/QscjpQj3MSNibj7SngZmj4SEXT2Mxa7Y4QyGujP6WcuSmqoCm5SBUuM
	yPjlIQkZMyVTjka6yuuBjKqoYWmfmAo/bThBKvZafguvnQ7AfCrSMbcHBag7goC/w1qW8/bO3RS
	lhx7P8PfnhfdSvLa50GHBbKI9RBgEgg5S/7WuZPhU1uZbQdBYnjRTqHiOcGguI2IALJ587CNCfb
	fm8UqQkKFuqoDlotQMOgl4od7Uth9cPR8nIEg6I24lDQUFzbqNh3fHLl
X-Received: by 2002:a05:622a:309:b0:535:198f:9cb3 with SMTP id
 d75a77b69052e-53575571eeamr93171101cf.29.1791449927990; Thu, 08 Oct 2026
 01:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788800732.git.caoruide123@gmail.com> <f66560e3-b821-4e70-980b-d3a6252a022d@kernel.org>
In-Reply-To: <f66560e3-b821-4e70-980b-d3a6252a022d@kernel.org>
From: Ruide Cao <caoruide123@gmail.com>
Date: Thu, 8 Oct 2026 16:58:37 +0800
X-Gm-Features: AclHuK_2TFbmDoxBsmcfKlZVfWVsNVYNJp20EISwQYaGbvpGPwk0ZZDKLioHjuE
Message-ID: <CACveakRhBR6RiGMO8Ur0V_N1SfNk3__h6g+EbkcYu=9kdBGYsg@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] mptcp: fix request migration ownership
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	geliang@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

Thank you for taking care of this. I've opened the packetdrill PR:

https://github.com/multipath-tcp/packetdrill/pull/207

Thanks,
Ruide

Matthieu Baerts <matttbe@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 02:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren, Ruide,
>
> On 08/09/2026 18:41, Ren Wei wrote:
> > TCP request migration clones pending requests with inet_reqsk_clone(). =
Some
> > MPTCP request fields carry ownership which cannot be duplicated by a pl=
ain
> > byte copy.
> >
> > For MP_JOIN requests, subflow_req->msk holds a socket reference. The cl=
one
> > inherits the pointer without acquiring its own reference, so the origin=
al
> > and cloned requests can drop the same reference. Patch 1 lets the clone=
d
> > request acquire a reference while verifying that the original request s=
till
> > owns the same msk.
> >
> > For MP_CAPABLE requests, token_node belongs to the original request and=
 is
> > hashed in the token table. Copying the node gives the clone invalid has=
h
> > state. Patch 2 moves token ownership under the bucket lock and makes to=
ken
> > acceptance and destruction tolerate an already moved token.
>
> Thank you for your patience. It looks like we were waiting for Clashiko
> report, but it didn't get processed for some unknown reason, sorry about
> that.
>
> The patches look good to me, I suggest taking them in the MPTCP tree,
> and I will send them later on.
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> (...)
>
> > // poc for MP_JOIN:
>
> Thank you for the PoCs using packetdrill! Do you mind creating a PR to
> add them in the MPTCP fork, please:
>
>   https://github.com/multipath-tcp/packetdrill/
>
> (if it is an issue, please tell me, I can add them later)
>
> >
> > // Minimal reproducer for a stale subflow_req->msk after reqsk migratio=
n.
> > --tolerance_usecs=3D200000
>
> Usually, 100000 is used. Do you need more?
>
> > --non_fatal=3Dpacket
>
> Why do you need this?
> > `sysctl -q net.mptcp.enabled=3D1
>
> This one is not needed, you can use '../common/defaults.sh' instead.
>
> > sysctl -q net.ipv4.tcp_migrate_req=3D1
> > sysctl -q net.ipv4.tcp_synack_retries=3D1`
> >
> > // Listener A and the owning MPTCP connection.
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 8) =3D 0
> >
> > +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[fl=
ag_h] nokey>
>
> (When validating the listener side, you can drop the TCP TS options,
> except if you do need them, clearer with less options)
>
> > +0.0   >                               S.  0:0(0)  ack 1             <m=
ss 1460, sackOK, TS val 1000 ecr 1000, nop, wscale 8, mpcapable v1 flags[fl=
ag_h] key[skey]>
> > +0.1   <                                .  1:1(0)  ack 1  win 256    <n=
op, nop, TS val 1000 ecr 1000, mpcapable v1 flags[flag_h] key[ckey=3D2, ske=
y]>
> > +0     accept(3, ..., ...) =3D 4
> >
> > // Make the MPTCP socket fully established so it accepts MP_JOIN.
> > +0.1   <                               P.  1:3(2)  ack 1  win 256    <n=
op, nop, TS val 1001 ecr 1000, mpcapable v1 flags[flag_h] key[skey, ckey] m=
pcdatalen 2, nop, nop>
> > +0.0   >                                .  1:1(0)  ack 3             <n=
op, nop, TS val 1001 ecr 1001, dss dack8=3D3 dll=3D0 nocs>
> >
> > // Leave exactly one MP_JOIN request half-open.
> > +0.1   <  addr[caddr1] > addr[saddr0]  S   0:0(0)         win 65535  <m=
ss 1460, sackOK, TS val 2000 ecr 0,    nop, wscale 8, mp_join_syn address_i=
d=3D1 token=3Dsha256_32(skey)>
> > +0.0   >                               S.  0:0(0)  ack 1             <m=
ss 1460, sackOK, TS val 2000 ecr 2000, nop, wscale 8, mp_join_syn_ack addre=
ss_id=3D0 sender_hmac=3Dauto>
> >
> > // Listener B joins the reuseport group, then A is closed. The next req=
uest
> > // timer clones and migrates the half-open MP_JOIN request to B.
> > +0.1   socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 5
> > +0     setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(5, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     bind(5, ..., ...) =3D 0
> > +0     listen(5, 8) =3D 0
> > +0     close(3) =3D 0
> >
> > // Wait past the first SYN+ACK RTO, then release the owning MPTCP socke=
t.
> > +1.5   setsockopt(4, SOL_SOCKET, SO_LINGER, {onoff=3D1, linger=3D0}, 8)=
 =3D 0
> > +0     close(4) =3D 0
> >
> > // The migrated request expires on its next timer and its destructor us=
es msk.
> > +4.0   `true`
> >
> > ------------------------------
> > crash log of MP_JOIN> [  280.449259] [      C0] BUG: KASAN: slab-use-af=
ter-free in
> subflow_req_destructor (net/mptcp/subflow.c:45)
>
> If such calltrace is on public ML, please, next time, include this in
> the commit message instead (without the prefixes between []). I will
> amend it in the commit message.
>
> (...)
> > MP_CAPABLE packetdrill reproducer:
> >
> > // Reproducer for MP_CAPABLE request token ownership during TCP req mig=
ration.
> > //
> > // The first listener owns the request created by the MP_CAPABLE SYN.  =
A second
> > // SO_REUSEPORT listener is added only after that SYN, then the first l=
istener is
> > // closed.  The SYN+ACK retransmission timer migrates the request to th=
e second
> > // listener, and a later request timer destroys the migrated request.
> > //
> > // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  T=
he clone
> > // is not the token table owner, so destroying the migrated request tri=
ggers the
> > // MPTCP token ownership bug.
> > --tolerance_usecs=3D250000
> >
> > +0     `sysctl -q net.mptcp.enabled=3D1`
> > +0     `sysctl -q net.ipv4.tcp_migrate_req=3D1`
> > +0     `sysctl -q net.ipv4.tcp_synack_retries=3D2`
> > +0     `sysctl -q net.ipv4.tcp_timestamps=3D1`
> > +0     `sysctl -q kernel.panic_on_warn=3D0`
> > +0     `sysctl -q kernel.panic_on_oops=3D0`
> > +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> > +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`
>
> You probably only require tcp_migrate_req=3D1 here, after
> ../common/defaults.sh.
>
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     getsockopt(3, SOL_TCP, TCP_IS_MPTCP, [1], [4]) =3D 0
> > +0     bind(3, ..., ...) =3D 0
> > +0     listen(3, 1) =3D 0
> >
> > +0       <  S   0:0(0)         win 32792  <mss 1000, sackOK, nop, nop, =
nop, wscale 7, mpcapable v1 flags[flag_h] nokey>
> > +0       >  S.  0:0(0)  ack 1             <mss 1460, nop, nop, sackOK, =
nop, wscale 9, mpcapable v1 flags[flag_h] key[skey]>
>
> "wscale 9" is "strange". Note that you can launch tests with run_all.py,
> e.g.
>
>   # ./packetdrill/run_all.py -lv mptcp/<subdir>/<test>.pkt
>
> > +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 4
> > +0     setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0     setsockopt(4, SOL_SOCKET, SO_REUSEPORT, [1], 4) =3D 0
> > +0     getsockopt(4, SOL_TCP, TCP_IS_MPTCP, [1], [4]) =3D 0
> > +0     bind(4, ..., ...) =3D 0
> > +0     listen(4, 1) =3D 0
> >
> > +0     close(3) =3D 0
> >
> > // Let the retransmission timer migrate the request to fd 4 and let the=
 migrated
> > // request expire.  On vulnerable kernels its raw-copied token_node is =
not the
> > // token-table owner, so the request timer trips the token owner assert=
ion.
> > +8.0   `true`
>
> If you set `sysctl -q net.ipv4.tcp_synack_retries=3D0`, can you reduce
> this to 2 seconds instead of 8?
>
> > +0     close(4) =3D 0
> >
> > ------------------------------
> > decoded warning from MP_CAPABLE reproducer:
>
> Same here, I will add it in the commit messages.
>
> > [  314.661418] [      C2] ------------[ cut here ]------------
> > [  314.661636] [      C2] WARNING: net/mptcp/token.c:364 at mptcp_token=
_destroy_request+0x2b0/0x330, CPU#2: swapper/2/0
> > [  314.661931] [      C2] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tain=
ted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)
> > [  314.662092] [      C2] RIP: 0010:mptcp_token_destroy_request (build/=
../net/mptcp/token.c:364 (discriminator 1))
> > [  314.663001] [      C2] Call Trace:
> > [  314.663043] [      C2]  <IRQ>
> > [  314.663107] [      C2]  subflow_v4_req_destructor (build/../net/mptc=
p/subflow.c:694)
> > [  314.663213] [      C2]  __reqsk_free (build/../net/ipv4/inet_connect=
ion_sock.c:906)
> > [  314.663325] [      C2]  reqsk_timer_handler (build/../include/net/re=
quest_sock.h:137 build/../net/ipv4/inet_connection_sock.c:1147)
> > [  314.663762] [      C2]  call_timer_fn (build/../kernel/time/timer.c:=
1748)
> > [  314.668915] [      C2] ---[ end trace 0000000000000000 ]---
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
