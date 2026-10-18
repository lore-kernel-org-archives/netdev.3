Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD633905EF
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323764; cv=pass; b=to9k3gVuCgz7CPaZ1OSmjSHB+5cXywntAKw3Vst5hD8pG+FGJQ3i80vseHC1aNXDwfSp6e2rbAwSYBhmWUxIvjYud4YzW7UsX1dpdaSalga9juYNZAvDdBLf4jPKggTDNFMMXbsAW8OKN/bx/JHbtTv4mowA8pMqddLiTnYyAtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323764; c=relaxed/simple;
	bh=pdTjjuUEZr5/eCLLGOgRPlhMNoP9YTMXhfMuFbbNRq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAV6hCmlgp3IMBFzN/tWhEBtrITta7IWalg9EOZQpaVkURtyau38WvZBMFspy/X7ccdJmgKW26WooDGSODo3oboDGYCF40K6+vz2tTRF6zMCWB0Obl1EWp3/pHMwuG/2cXfg0jDWIA+ItAWbMFWi7VyBvT/xfNAEDKn+9igV2xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgssXaO9; arc=pass smtp.client-ip=74.125.228.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgssXaO9"
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-6ae19780777so795246a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 04:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792323761; cv=none;
        d=google.com; s=arc-20260327;
        b=UWj7kD1p65cddXK9dEPvG7HIEw292tfxx8M8gLBovlIwKiEUss4/4m5PCPlq8E/M/k
         nDs3e6pt9RTgbvNRxUZRi8eQqLCnKuPjvtnYZCXf0zzNR+pzf1aocqnN/H1+XP4UEJFE
         BFz+g92HFhMOhNdRtOPC4oqBBiI2THeBO9CQE5cHOK4occHrd8CUxKZsafK0KmUGJhtX
         sFDyX3lL4OOE3/RdqX3/2kQZn6/Rday3zqU4Qjj2iWu8HUM8bdSBB6UZwkjv9SF0ql4w
         BGK+LUmCTklGtMmrSSZeSvIMpjGfdBTM5EhrIjYRtgzKoZXAdDfa+0nzdz5wzkcax9zG
         FFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZLma18gptooWQFwxqC5664qisl8OyfBtIlcEuU76w1s=;
        fh=quTfbA6aHw8lh+giTNbm2KS8H4I2X8BMLs+cXBkL0GI=;
        b=HjEo+bdmPRDpEpNWv6CmuiHIz3hnz9K1CL9UUdlnZX445rsOdNcxIp35JRp4JyfnDX
         /mPDDH0vh2bgAn3UVvqf6y6LQ6KQ8dkn1rOaBVSXvN+ZtqHSqpfj6quvq0YuxCR0is0N
         r3dkSjxRc/X10p7NhI2vg5cdUDETD504Yp1/CWmn86y2YqSeDKTlxL7qOgRVCbGrI3/M
         3Mw45wU3K6ZrtjW4S6sYpbfBrHacFgmeg1tv53slFksqKMgc5yfCW7qdWKBh1d6u+nVC
         cIqO3ihK4WRBQutZ8tBHomfwBCWRHFEqFbgqKZM6xnUR8Ycvr1Y0DCVK5WXeyJMP56DH
         jueQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792323761; x=1792928561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLma18gptooWQFwxqC5664qisl8OyfBtIlcEuU76w1s=;
        b=VgssXaO9qp/vQllhL+eVY98U0X505B3wktYtOrRX3tqHgwenF34POmxSexqMlFr3Dd
         G79xOIaG9tVDbaFRYqTXYf4/KlyveLyKI/mLw0GbEo48ZOyt3zTfSPiWGbXFk81kpr7h
         AK7jYQrG9Dt8BEz7b5LNmcbYYTPjviMqovrV99jGP8VRlPqfdoieL+/xyVVcM2MCy1HG
         f48vXNDSM802tfpqX/JperJjJa1spb7qtZrQaLseLsi00x8cwoy0MYroOj236xsPhyrX
         GaH4R+YcBK6SYVAEUa8CmPIOWGUgEF5gxUWiUOlQoTv0/FUQryFmBfEYrJWoFEAoggdt
         EnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792323761; x=1792928561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLma18gptooWQFwxqC5664qisl8OyfBtIlcEuU76w1s=;
        b=tmSibjHx0qU6CqQ2YXEewUu36smUx/EhBgkJsHokUqtEJVmW+h5YRBMUKBQgN5NgZ7
         kQpeZnuGwRyTZlOWaGVTeKeoIlQPh4IlFIYXRuIUFy/sm4vxRgzBHhP6DPkazNnTdLI7
         Doe5Wj5vUyAn92l+QagiI8pRGXvKH904jtFzWn6buw9PayVCA5XLVSGC3omFBYaEMCjg
         t1db60gyfd5qJbfoNCvth5vwXJzgnGBkAXhR2HYlifyRHizvkleqnlRHYrHJO3aEZfsj
         6qfuMFJNq4Mv1WYh+lqITwr3cyfiRNfD35oc86EeTmUleZa0xQoU6i0BczR1vfQ+hZoT
         4LMg==
X-Forwarded-Encrypted: i=1; AKwUvBxP0GGEe1wUA/UmmaH/mAlPjSuM/YdZ1czYXQhlnWi4rfiVLWo4qeIK3romkVlQOcyOxrqaizM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgGaMTa99EDPOPahYJFtDBfrKOlkWxzdpp8EpUzpeI3t/Ua7i8
	IXGm0Eqkh3/mfcVbO7cdxImJewUXKuYLAWQVNvySwf8Ae4ytIaQBdy+ivuQM4anZyizcDedDJX5
	asEiaPBBbWkyILIfvrTn1dYMeaJvK1JY=
X-Gm-Gg: AYBFou2WaUjbqgSpxT2lIeTDu7KlO3rl/ZHQ4eswNdpg18/Vq6PmY7YJ1lCzMAGcBid
	N0dcWfKoVUmTPAWCwPGDsng9ubySswKxpwnblrvT9/Gd1AYUoTfUYUyCJtw70OCC/DZ5AsWue/Y
	ZRMpk60qy7UAkXldUv7e62RNKGvvjriF8/q3QPBE2TxUYMTUehPY59cW2xwZsqDuIx8YZ4b0Jiq
	z6KcYQgQulLpjHb3ikhMHbiG0DUX9tytZWTou0jUBFCPJDFqHUAdRTdWplrunUwpayJetZizeBx
	wm5/Vb7sBekil6XYj8VktbwYdNBG84hGhPtzArt3nwQ9I6kCdLNUyKOItSS3QEJD7Js2cxgPki0
	LYJXFHz8tpsMzs+z4cqgu
X-Received: by 2002:a05:6402:3204:b0:6b1:c299:b3f8 with SMTP id
 4fb4d7f45d1cf-6b3a8188f53mr2836096a12.33.1792323761136; Sun, 18 Oct 2026
 04:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017120144.3059-1-yymhvert@gmail.com> <willemdebruijn.kernel.3068e5bf74671@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3068e5bf74671@gmail.com>
From: yymh <yymhvert@gmail.com>
Date: Sun, 18 Oct 2026 19:42:28 +0800
X-Gm-Features: AclHuK-M4GinSmZs-Gs-t6lI0SGAvtU4utZxfv2F0Y2YNSSctof4zzQNs0f4jyU
Message-ID: <CADLWKdUB8M70VLgd+foRg5Usy8rUo-hXkPQ1nrkJHM9iHaa=cA@mail.gmail.com>
Subject: Re: [PATCH net v2] seg6: Fix unset mac header in SRv6 End.DT VRF decapsulation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+98d7de09cd94fec5@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Willem.

Andrea, David Ahern, could you share your thoughts on the v2 approach?
In particular, does restoring the mac header after l3mdev_l3_rcv()
returns properly fix the issue without introducing any regressions,
especially in the VRF sniffer path?

Thanks,
Boyan


Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B410=
=E6=9C=8817=E6=97=A5=E5=91=A8=E5=85=AD 23:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Boyan Liu wrote:
> > SRv6 End.DT4/End.DT6 VRF decapsulation unsets the mac header in
> > end_dt_vrf_rcv() so that the VRF device can rebuild it for packet
> > sniffers. The VRF rx handler only performs the rebuild when a
> > sniffer is actually attached to the VRF device (ptype_all
> > non-empty); otherwise the packet continues up the stack with
> > mac_header =3D=3D 0xffff.
> >
> > Every other receive path delivers packets with a valid mac header:
> > NIC drivers set it in eth_type_trans(), and tunnels without an L2
> > header (ipip, sit, gre, tun) reset it to the network header after
> > decapsulation. skb_mac_header() even warns on the unset state with
> > DEBUG_NET_WARN_ON_ONCE().
> >
> > If the decapsulated packet is an unexpected UDP GSO packet,
> > udp_queue_rcv_skb() re-segments it after restoring skb->data to the
> > mac header with __skb_push(skb, -skb_mac_offset(skb)). With the mac
> > header unset, skb_mac_offset() returns a large positive value,
> > which the unsigned __skb_push() argument turns into a huge length:
> > skb->data moves far outside the buffer and skb->len is corrupted,
> > so segmentation reads out of bounds:
> >
> >     BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_ine=
t.c:1383)
> >     Read of size 1 at addr ffff88800da7ffff by task exploit/149
> >     Call Trace:
> >      inet_gso_segment (net/ipv4/af_inet.c:1383)
> >      skb_mac_gso_segment (net/core/gso.c:53)
> >      __skb_gso_segment (net/core/gso.c:124)
> >      udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
> >      udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
> >      ip_local_deliver (net/ipv4/ip_input.c:262)
> >      seg6_local_input_core (net/ipv6/seg6_local.c:1640)
> >      lwtunnel_input (net/core/lwtunnel.c:465)
> >      ipv6_rcv (net/ipv6/ip6_input.c:351)
> >
> > Restore a valid mac header, pointing at the network header, once
> > the VRF rx handler returns. The sniffer rebuild happens inside the
> > handler while the header is still unset, so tap behavior is
> > unchanged; when no rebuild happened, the packet now carries the
> > same mac header state as any packet received on an L3 device.
> >
> > Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> > Cc: stable@vger.kernel.org
> > Reported-by: co+98d7de09cd94fec5@bugs.sh
> > Signed-off-by: Boyan Liu <yymhvert@gmail.com>
> > ---
> > v2:
> > - Move the fix from the UDP GSO path to seg6local.
> > - Restore the mac header after the VRF rx handler returns, preserving
> >   the VRF sniffer behavior.
> > - Verify the original reproducer, datagram delivery, and VRF sniffer
> >   output under QEMU.
> > v1: https://lore.kernel.org/netdev/20261010073015.7665-1-yymhvert@gmail=
.com/
>
> Thanks. As discussed in v1, this sounds the better approach to me too.
> But it would be better to get the opinion of experts on VRF and SRv6.
