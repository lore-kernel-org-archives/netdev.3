Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793154148;
	b=VPP7XRWbwo3ruO31GsWsV2oVMi3/akw8Ujh7xhMvBH3VNnw4tC+BPBBcbwMX/WH77Pnq
	 vr5Nr4stXR/LnLnfLwj8lm9OAvfIsssZGmdHGaYmgkkQG4THJt+D5N9fAlfdyjtmw27QU
	 BLRK4U1a8akpizc2iVzMTF+aS7oH/Zed16aXsdVd/eaT31+n8CzBPqHT4/BKHnlDCAhW5
	 biVE0yvEHNZK1Gs0X0DhD2zpS4V5gEgVZM0lIiG0/xZNOg8yU5w8f99cJe0ivRPnf71Fc
	 hS6CCrQsO83eCQiXBrXZEO0I4HeIM+w/OBT8W2OXKCRoSX5Kwtpe1Rb7EXDGMfR9xYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:From:In-Reply-To:References:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=rLkAB7kZhLYtyniHu9ByUzUeYbWTwWcUmXl1PzQJPZs=;
	b=U8NpWLdCOmaglHTXPwlFfX0Qz908a+LC6hPZUI55/W1bVFR1m96QVc0clYKaXuTR2O6+
	 5QebavKuKsQVbls5ZG2cC3KLxlrNTk2/v0D0XdLb0z7lFoYM/Bu4cpZqCetCAhC0q21sg
	 fvDU5oCV2t0H+V/R1kfAcd+tOT8O69K2riwtiD+dZc+Tw6aeZ5K+bxnQAXAWSLoYbYJmB
	 K8il8jhxpSp/osbWLIakrcVmLhJMhiCE0pnCUvIH8V4dDOvGKeNA/NfkR3h/fUeh1FJkB
	 f1q4A0+D1Utz7iRcmwSidyFLYbY2U/O8bcqlJXsIERAB6j2xrTi9PMxD4+1SDhp0Bfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5CDpCYn;
	arc=fail smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E81606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E81606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5CDpCYn
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so344283a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793154146; cv=none;
        d=google.com; s=arc-20260327;
        b=OR2nqOouc26hP+8LxdZKId85PT1ef7LPTTAI9zzaYSoavDz+8Aj4Er0x+ENEhbT/rd
         LgB6bGm3ZxpmY17vdFspoYd/63TXbpAHrEgsvESyhabBqrrUrvRHlSoqODQljGdA3Ibe
         12GQ7B+PFcCYd7GsHsoF2rgdPkXShk0auOb+hUKV/DWk9/u/nJ4rFJgkYQ3d6XpLKRpD
         sxTCRmGgDcoLLg7HBFRaIX9JJ3+OyIbdDkp1xMvUDg4ETtDxzva4g34x1D+2rSkV4w6L
         S05vXd0CH65+ENJEmrMtWFw703jWhKM3yhOPjl1vvJyA6PWr9+P1vZ2ab4UMlQ5/se/u
         z3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=rLkAB7kZhLYtyniHu9ByUzUeYbWTwWcUmXl1PzQJPZs=;
        fh=fT7kxOvnpWqPLCQrbKowFS+mFxLB9Ph0paWgozJmdq4=;
        b=Fr3DG7j4MHCQ4H3BtHBUfmnCXsFARATwfNnUQ0LmZ6TEiQ8sgpRd01xxTWZN1sxNQZ
         31HAeHU1XRwas1y5OBKFHFEoc44hGkj/QQDGzBSvxVuwCj9y3ssEihgnLQEQVbE9s2X4
         ux+hHM3SasoT55QKRKazRsouwvs5w+Qr9jDioThjwMbAcyjiTw+AST6trJEAIZnAoWU2
         sWCMlj5wWOSGMRxHPs6dKW6ZQeECaxerZMsj965Og39YpYWuiHr+/9mCXSvUQs7MKxcS
         htM/ADbnj7cRDLwukOSfUucfI78ZNl7CWmcy4JbJeYMDMUZSUEYG+opoe9o5orAfe2RY
         eozA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154146; x=1793758946; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLkAB7kZhLYtyniHu9ByUzUeYbWTwWcUmXl1PzQJPZs=;
        b=K5CDpCYnJ1qrM/VnuvwRVH1L1+xT8oLS14G0KLHi4xCdXJS17zel0z2UsexwKRUObq
         XSvGAEfefwHrWVOwCMjP27oy3Ik3cuB2RvwU/5R0Q31bZQHlwwbaoNUj906szZa5+0Pl
         gW8kOMsPKfu8ZgwuvJzuplfz0v0EFieoLRvnZ+Di0XvzVHXJXsuvy2CKN8tm+LUvWKbL
         JhX0jXQycz9/nTChRLQO9zfQxmpRQWeDku3WLIewwU1aCu2sV3LcdhDfAcO75W7SfgUc
         amQEaErRajM/BN98vstMlJ1gNmPTcmEoq/bePlnspo3D4cLXuor9SLX1h1zXW9NvRF2I
         u9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154146; x=1793758946;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rLkAB7kZhLYtyniHu9ByUzUeYbWTwWcUmXl1PzQJPZs=;
        b=pFU5uFQy44HY9dV5w76dTJxyQWyydleZ2xK7bEatOlLxz1qDMGhqO5q5nXpEh98sfv
         IguBaL8VTolRn2aNmqu1wrYBz+2NAbKugr1Xwme8IfAKMtOdrPMbRZAE4yjXaxCpULgO
         WrGcOZJD+/qXdFtVjk7zQHLvFy4u8IjeBoQ806uMJIHikOHvGiN4gnjN1z6G0V3C5fwB
         JpR66iwfYVqpWndmnsd2UEGB7Ucu2glCEP3AwXv0S2ueqxiyjhHF7IRm6FMlx2Z326mE
         4pfLpxWgoe1Agg6jostyKioE8Q6JGpqoyE/a0uDsOgJCD/XtHFXpCgB9bXciBW2Rf6qt
         PiCg==
X-Gm-Message-State: AFq9FYIyF5S6rgfyK1MREs6mnhiboYvPDqQO0Tw2hkK50vpSC/NfbSrT
	g/I7ZCzhC9y4y6falVyG6ncKLVxlnYpu/wW9TgxBFB1Pnxl/ktX4jvdygKZ8RXOmD8cy64i+CWa
	QCAinHQUV3boEL+W0uptH4LXxbXTcFtFsJmOM
X-Gm-Gg: AYBFou3EjJZhgMIrAoJjwmEWPSiGTR3CDKpQFPpltSbcpfUcRsHAz9mnyPr1RC1uCcI
	+aAA/lUWX/lrcIPpSSKVE9CDdXJqYIXx+2UNSEpm88cRkdbu6UF7S5cpiX79ZsZ7JjpEXtgY6Uv
	mszV3EwN0w3aFxmDauMwZMERKCohqMyCA6AlF3rVyq4qB+CRzhHu6sZQMEncmlu6eUjR25jIi/A
	6cfqstnvRS40guee1emkr7rV+Hd5Pn3NlVx1nohM9riZhaXjivdLF749uz/ZnkploSFsmNLMfog
	xR2wNZ9XZ8iPytFExfQgIm3edxksLRQQx4xIZtCpyanhsc1VXUYIAY1R4l1ClT9kBdhf6j4yw/h
	Vxz6uLSFGzL2xmSqnpklXg59TBN18mLncwo0=
X-Received: by 2002:a05:6402:2813:b0:6af:9dd5:f524 with SMTP id
 4fb4d7f45d1cf-6b49cc0eef1mr469352a12.37.1793154145870; Tue, 27 Oct 2026
 19:22:25 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:22:25 +0900
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 27 Oct 2026 21:18:11 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Wed, 28 Oct 2026 11:17:12 +0900
From: John Macias <dencity7@gmail.com>
In-Reply-To: <179299947310.3134.16517017879498438401@kernel.org>
References: <20261025072203.1519561-1-dencity7@gmail.com> <179299947310.3134.16517017879498438401@kernel.org>
Date: Wed, 28 Oct 2026 11:22:25 +0900
X-Gm-Features: AclHuK_oT_wF2qyX-CGsYBb5sKWaurG9YvjMPI2pYFBFay-dMm0w1_Kdm6sT16Q
Message-ID: <CA+KzPspGRX_=MiCX47r+tTW2fx-hX4DQ7OVHG3xOw7sndGi46A@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: clear the conduit RX queue on user port receive
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Both findings are right. A revised v2 is prepared with the changes below.

> The commit message says "TX queue selection is unaffected: ..."

That sentence is wrong. Clearing the mapping leaves no RX queue
recorded, so when no socket mapping or XPS map decides, skb_tx_hash()
picks the TX queue of a forwarded flow from the flow hash rather than
the conduit's RX queue number. Some taggers also consume the selected
TX queue: tag_brcm encodes it directly, while tag_ksz, tag_sja1105,
tag_ocelot_8021q, tag_netc and tag_vsc73xx_8021q derive a traffic class
or PCP. Different queues within the same class need not change that
encoded class. With CONFIG_SOCK_RX_QUEUE_MAPPING, packets received through DSA
ports also stop updating sk_rx_queue_mapping, so xps_rxqs no longer
follows the conduit's queue number for those sockets; a mapping the
socket already holds is left as it is.

I kept "not recorded" over recording queue 0. Both make get_rps_cpu()
use the first RX queue's map, but recording 0 would, when nothing else
picks the queue, put every forwarded flow on the first TX queue of its
traffic class. Under QEMU, 16 flows from conduit queue 0 routed out a
4-queue NIC with XPS cleared gave eth1 TX deltas of 800/0/0/1 with
queue 0 recorded and 201/100/350/150 with none recorded (one other
packet is included in each). v2 describes these effects in the
changelog.

> The fix is incomplete because one delivery path in dsa_switch_rcv()
> skips it.

Yes. v2 clears the mapping right after eth_type_trans(), once the
tagger has set skb->dev and before the branch for devices that are not
user ports. With tag_dsa trunk frames delivered to a 2-queue bond, the
unpatched kernel and v1 both hit the WARN_ONCE() and skipped RPS for
queues 1 and 3. With v2, each source-queue group's connected socket
reported CPU4 and the bond warning disappeared. These are observations
of the socket's latest receive CPU, not per-packet CPU attribution;
queue 2's NAPI already ran on CPU4 and does not discriminate.

pw-bot: cr
