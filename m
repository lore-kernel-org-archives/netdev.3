Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0841DE0B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206418; cv=pass; b=QzHlh9t9a+T/OSI2kldCKSFRwdWAy16Ip99agW8eXoZo+yE5fpwE+eHwqE/1DCKnITDhNrUWh8WdrOg6KFKQWRwCmmrHg+skefSBu2BbJtEyTNOQ2YCTu2MTx4GFDpOvY8ShlfmS0zWjj/fq1eTW43PrbxpSn6Rl7ktgb8zB6Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206418; c=relaxed/simple;
	bh=rVuZ1/j6WS3yKJ/+J5ak2N5sJ6zYZ6SuijxYLYOO9IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfrOXzkSkNw6/6pmt2myGKh+lPWM3B4diTBdN83EOzNSjRsrTxqipIc+hTX93OIybDcKsrxL83clgNs3PKZ5v2ERhott08bS9yLgwUPMzM0O66tSp8T2Q45F0k+jP3lN/SqrW1GGLxgveaxNWO7tp0NpHy5PdVrjrs8aFvnZavo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pi57i/kA; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pi57i/kA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c05dcdf49so71534651cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784206415; cv=none;
        d=google.com; s=arc-20260327;
        b=ATYHaJGqRCXAiQTHkOKFg8AHm50EsXwq7xFIfs3sHjpIdxFaGNnUKK1UtDa/SRU9hf
         msBL+hE6VTJZByL85F6Fs+m4Bslj0FACpHiAt1m9WrULD5wZz1mbxj94+bzVqRnFIBKk
         EM2L/F9Y7Kt6Vz8kC/uNk9KEw3wM6igFOHtH5s3T3c61EIqEfQ3S+9E4pkDClUqjGGBh
         u7mjtda4YjK2xXaewEnloLVHoQ6VxqMlTG7wNmqSsYfD2hIAy9tVxFOVEZ8ZcMLZtgkr
         y0DiVsMSvNKJgSYJIVpHk6fNkfB82V3BgOe4jIEcrqIAcFZHnYK6NmCaPN1vER2H2N8l
         skog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sPWYmavr3P3lPLt50xEZ6dCncgfwt0JoMinuAxYXtzo=;
        fh=ojKZeLhxxF8tvpd8ig4avFGXJKR3RRMR+zT+pC4n8Rw=;
        b=c2YRPItKYVAmsNsSf9hymWiEtnTm6pt5lAKCapV4rLM5i+EBRRA0UDT0jRqfzu9ISG
         +S+6ZPxJSHR+y88Tqq+MugqpHzuRVxLjGlZ7wF+pLqV1yD7OXm7zJSlcpNhpxJEI+fjz
         7F3yXcKNDaJNAkf61p4fxBF14Ay8NjFYoKBvum/0HBireSpMOWjEoG7Bo894zT0Qim7P
         y4ve3myoJjpusXnjvp8u8wjB0FPbAJfkHY4YQRCcVFjMPsJ/xZ0qJ85BWaMsIiuMZZ/4
         hYRze7/iaSfoZ4n/X8Jo+DVv2SanwRayMkLpZ/RauCQxCcRFfXyGyAGKKb5pomiM/lk1
         GeRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784206415; x=1784811215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sPWYmavr3P3lPLt50xEZ6dCncgfwt0JoMinuAxYXtzo=;
        b=Pi57i/kA/eu9OMgc/ZkLovRj9YR/JqZ2RCgXdgkeAcpJsce12d0gK15wS/o/WORCuO
         qwhBeik7AT+T7WsvC3wxW/ZcRnIUAmSzBOKcKhbEwoASQyOJ/GSGUMS+Zz9H5r09YVKY
         l8Nv9+eoehXFTQ7Ure75QUeKvX3KpAYhUQP4wqLH/anpY0DJouGVKzHqhpno/xhwo7t/
         HNAlI95UH+PVwOii4nRUqfmZY4CepwxZHywCsBpCZL5dH66gAuhbdRrgTTtUtc45XwX5
         +qVjC7jzBIn2pV86pBHYWP/OrLw4/6vfRcqd9gBufFoFFfo1caw/dAB606LqJIApJOKS
         sX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206415; x=1784811215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPWYmavr3P3lPLt50xEZ6dCncgfwt0JoMinuAxYXtzo=;
        b=XzYDDQ5pAhtAXOcbef1xqFZiR4zImRH9JrAgtpREI04AMxsqISzxNJq9FJ1+5JTl4O
         9xYWaKmao8e7yOD0+WlFnpCXY512kZIAYgRkpn+a08y1Dy9ltCXYAyAwC3cifhUtSbDr
         L7xNc15fSrY9aXuslbJjEXMfRZPHP/GaQDe4sbupPQ5GMZBVEBT6wtkigAlRA2GrSmp1
         BKzNFvCBt7jhVE3gPgMvPkUZ8Awgxksd8+R7YFPPwspbakkn0OnNp/m/QYF2XX5WmrLI
         ApCIotQp0/CiOQltqb12RlZYmMyllKDJ7qNeJ1wVuyM8eNUOk7Dtzpdql82m0eOvLPN7
         VPFg==
X-Forwarded-Encrypted: i=1; AHgh+RqQYj4tqLKAZO3nH/tU8x7kJhVkViboY5MUGL8THAb6D9iCoQqxKns79Zq9TrIFidrOHGvmBHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdm7yDGrWHyqUcM8M5YAzeb6P+iUFMG+V/UvT6lvs6aqT6e/Hu
	wL7Cbd1ngE8CF3WuUOQMRWcK1nHfQT+l3ndmisqwiDzFPmR6cBTcwMl0ygCikVQGWt0wxc6lSdY
	Bqx4xujrYydZg8W/VlhjXkgqExnM4eLMjIGocRDPl
X-Gm-Gg: AfdE7clC48ZYILIbk3URZ69UyJRAJZ7VyYh6loiZKHOZFq7MlBzU/A8nZvdb2jkPkro
	arQhzZY6HiPz2N9Zk/kG83LWC2RHtLpF0H++/p30nWU5xLoBxzdJ1ewz8fpZaBRIQ80PEcawfYd
	FyyTSIGDS0rn0edEBUrZfjNz5EDz+jSrK5RJnoXe0Xhi7INqsEmflqqpwXl9uGVM0RY87B14h16
	PhMEhbcb9E0BwELjW1ZrTq/OAw1htpU3MHDvGSphZHKcCwXyAgLAob7+6bbZsRp2+4C30Mj803o
	WlFYwiqE/be6gk9Cmg6WhsC26Yq3YLh06h1aXammPBSKJNrHZ+nRSPu6XcagDwXlsmyCBu0Sptq
	q
X-Received: by 2002:a05:622a:301:b0:51c:7b12:5fd3 with SMTP id
 d75a77b69052e-51e4f129ca6mr78062931cf.79.1784206414654; Thu, 16 Jul 2026
 05:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com>
In-Reply-To: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jul 2026 14:53:23 +0200
X-Gm-Features: AUfX_mwJ6wOXiWALTw9CQCSGPqtRuyG63o1Vlu5Z0draBHhLIJs3UoqtlSjaa80
Message-ID: <CANn89i+z6ECLND1o8oD10re_zGJg73JCOr3dnV9AADeG40K=_Q@mail.gmail.com>
Subject: Re: [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX
 on lower device
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Fastabend <john.r.fastabend@intel.com>, 
	Jesse Gross <jesse@nicira.com>, gaoxingwang1@huawei.com, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 2:20=E2=80=AFPM xietangxin <xietangxin@h-partners.c=
om> wrote:
>
> [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX on lowe=
r device
>
> Hi all,
>
> We encountered a skb_under_panic triggered by toggling
> NETIF_F_HW_VLAN_CTAG_TX on the lower device while a VLAN device is
> up and sending traffic.
>
> Call trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  skbuff: skb_under_panic: text:ffffc0d2900283d8 len:74 put:14
>   head:ffff334820249c00 data:ffff334820249bfe tail:0x48 end:0xc0 dev:vlan=
4
>  ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:116!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Call trace:
>   skb_panic+0xcc/0xd0
>   __skb_checksum+0x0/0x480
>   eth_header+0x48/0x1a0
>   vlan_dev_hard_header+0xd0/0x284
>   neigh_connected_output+0x16c/0x20c
>   ip6_finish_output2+0x4b4/0xd74
>   __ip6_finish_output.part.0+0x1ac/0x3b0
>   ip6_finish_output+0x160/0x200
>   ip6_output+0x13c/0x294
>   ndisc_send_skb+0x41c/0x6f0
>   ndisc_send_rs+0xac/0x3b0
>   addrconf_rs_timer+0x42c/0x660
>   call_timer_fn+0x54/0x290
>   expire_timers+0x26c/0x420
>
> Reproducer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  # Create veth pair (NETIF_F_HW_VLAN_CTAG_TX is ON by default)
>  ip link add veth0 type veth peer name veth1
>  ip link set veth0 up
>  ip link set veth1 up
>
>  # Turn off HW VLAN TX offload on lower device
>  ethtool -K veth0 tx-vlan-hw-insert off
>
>  # Create VLAN device on veth0
>  # At this point: header_ops =3D &vlan_header_ops, hard_header_len =3D 18
>  ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
>  ip addr add 192.168.10.1/24 dev veth0.10
>  ip link set veth0.10 up
>
>  # Turn HW VLAN TX offload back ON on lower device
>  # This triggers NETDEV_FEAT_CHANGE -> vlan_transfer_features()
>  # hard_header_len changes from 18 to 14, but header_ops is NOT updated
>  ethtool -K veth0 tx-vlan-hw-insert on
>
>  # When a packet is sent through veth0.10
>  # - skb is allocated based on hard_header_len=3D14 -> ~16 bytes
>  # - vlan_dev_hard_header() pushes VLAN_HLEN(4) + ETH_HLEN(14) =3D 18 byt=
es
>  # - skb_under_panic!
>
>
> Any feedback or guidance would be greatly appreciated.

This rings a bell, I thought we already fixed this issue long ago :/

I would suggest we always add VLAN_HLEN even if not (yet) needed.

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb166d52c3351768d9dfedc7b2c8ec2d..d7f90b3b2bb3aadb2c466891720=
a7f407d0bc34b
100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -323,10 +323,7 @@ static void vlan_transfer_features(struct net_device *=
dev,

        netif_inherit_tso_max(vlandev, dev);

-       if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-               vlandev->hard_header_len =3D dev->hard_header_len;
-       else
-               vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HL=
EN;
+       vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HLEN;

 #if IS_ENABLED(CONFIG_FCOE)
        vlandev->fcoe_ddp_xid =3D dev->fcoe_ddp_xid;

A kind-of-similar change is needed in net/8021q/vlan_dev.c
