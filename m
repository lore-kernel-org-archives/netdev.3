Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D2554094
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089642; cv=none; b=O91xzb9S10/HgeTscc0OMes6CuO8pe6XPIY16WwgkyEvh8O+6iUYSmvaZk3BwU/k47ztn+tfntiC/XcDZP3PlYQF1GL5AUvWvLKrUVv3mWsNRKlbIp1rN/bxsA6Rk2TuVHmmqe66RTO9QHMDx7KuETJAZoRPiSfdoyhYP1/ZNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089642; c=relaxed/simple;
	bh=eYsBKBEhTdI0RzND1OTGM2BlKm4H7blB5pkPXgKcXkg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=poSW6pm+JinNaPKsWpVwvhbCOgWnC1O7rtpZjrKE3GMX3dk88dJW8xrnmdcZUTS03cOo7I7F8jkxQaH38cPn0PI1GqgywlQ6pO73bfCrYtygL976AEfYatGPOuMu19sbICgNqomMStSvn/1ILDp8WFA3sMRZspEGlgK9OZUdF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjwZOvhA; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjwZOvhA"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so841437b3.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089636; x=1790694436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e7snuKKMY8AafgQ14cuSPog3PjlInhdYKOV1MzSg5bg=;
        b=XjwZOvhAqyipxeCBpa94cemRSURB4I2WznkPY8LPdi68FpS4towCHqeZaq02TumNOi
         VSgI3CupN7aWKgGl1LlJymnMgpMxTzDvxKjlxCNGHQHEMrAwtEsa6Q5ijMrexMDt5KOh
         rCc0ycxKjENLBa4X0InxD06JMkw/pKYjtkz/rm50FtDYXuS7UXobmpFii+CmdZpG379i
         2ybY7+wI3o419hCncgAcGSvOdRnvtAU8u8KpTNqGutcHVXKkdUTsLeOGYizJvzQ5KFeV
         uB4pKqLzwZZn1xRPmvh9Cdw0Cji7TEBUC+hymlaEi1cr/tHPL1HenDte1qNUP+WcBMtW
         xRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089636; x=1790694436;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7snuKKMY8AafgQ14cuSPog3PjlInhdYKOV1MzSg5bg=;
        b=m8YLzBXKfgVQl2IY7xL3fHUPLr47jOUeyM+4l7q1fP1dRyTogbG+5z5ew7rFliwYpW
         elzYwTwZphhIfQQabWGQOSGQM9LZNT4TQ+rcWrJSfpDcCgS17IorA0dNP52ip99UhceW
         u8xmIvvy/heJxXe0PBQXJ2p4lnapFeGcNL15v3IvcQRymrFBU1R4ytW9QQnONAYx2bvk
         OeMp08KnIit6AtCu/EsXHOiGdFX2AQhaKQ9zubGuT08GPFoxBNEb2IXVKyvn43jAyNY1
         90SR/rLRx/SpDRrGcvIuAqkIp8ySBtn/4Kw2xcgBTxoHxC1eOD1r/yVPCeS+2qNe4lEC
         s2Qg==
X-Gm-Message-State: AFuF++mwrb/JtgV/6Nvtd3PFQWU+9WAOnwUB9vkObZEZbzt+voaPN7pk
	9466wYMhk+ukEAbFmSRX88k5Sk5TpPbTlQUnWPpvwkl2Lk7T7o+j0Msp
X-Gm-Gg: AYBFou3LWZfLMGYip/ZFkddiFqRfOJx15H2zFXbHj9qCwfWpTcLU58xrV57GSecxfHC
	HRsG0GDm6wEuDWFWZPAbrPlngOW1Ds8SicsyBthiu07jOUAFjIkDgtjRDxuE3FMfGLxNPNpunkj
	tdF7HkG8mYM60Mx5r7/Pyo39D01jd3ZWsWWWmdQ0+6JnH3vJBzvuO2t73BFyDkdvr7iUqFtTNYA
	mWZV+iwjlnEnwqiXoBh6YrTkmvG0I4nwoGgMOfijP3l2KD9jZ0tpMUcCvbH49Itj9/Eei5gKL1q
	mggTF3s/l8tpAzGRs8KKGV5TSRNDfepcA9CprUNYqh3tng4gmy4nBtt5gOTGzRf0s8rqTAJScFu
	r7H8eFhW94ntXPG5yaMLWRJtC39cxKbRO26xrd6OIbaj05X+hNEMrg7JihHuaILgbT/P+A/iszJ
	sKfSonKLT/DK/iALtjpXhOOlo5Sy8x/PAjkdRi7Meg9e/IceKVXFEIFxzPyyOvHFM0pxNIPtXso
	51vrdQP8fe2KAwXq9FOxADXPxXZYMFRmydd2+m79zZMLfGwh8Qg
X-Received: by 2002:a05:690c:28b:b0:826:8d02:9c1e with SMTP id 00721157ae682-89732973623mr53220217b3.13.1790089636302;
        Tue, 22 Sep 2026 08:07:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c2f8319csm7734977b3.35.2026.09.22.08.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:07:11 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:07:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com, 
 kleaver@janestreet.com, 
 doebel@amazon.de, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3ad8224b38583@gmail.com>
In-Reply-To: <179004896529.2160803.14644876688990648036@kernel.org>
References: <20260919004748.1463985-3-willemdebruijn.kernel@gmail.com>
 <179004896529.2160803.14644876688990648036@kernel.org>
Subject: Re: [PATCH net v2 2/2] packet: use ubuf_info completion for TX_RING
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
> =


> [Severity: Medium]
> Should Documentation/networking/packet_mmap.rst be updated along with t=
his
> change?  The "Transmission process" section still says:
> =

>   The kernel updates each status of sent frames with TP_STATUS_SENDING
>   until the end of transfer.
> =

>   At the end of each transfer, buffer status returns to
>   TP_STATUS_AVAILABLE.
> =

> With slot release moved into tpacket_ubuf_complete(), TP_STATUS_AVAILAB=
LE
> now means "the kernel no longer references the payload", which the comm=
it
> message says can happen before transmission:
> =

>   net/core/dev.c:deliver_skb()
>     skb_orphan_frags_rx()
>       skb_copy_ubufs()
>         skb_zcopy_clear()
>           tpacket_ubuf_complete()

[Medium] This is a pre-existing issue.

The slot can be returned prior to the end of transfer after this
change. But the same was true before this change with skb_orphan().

I can improve this documentation in a follow-up to net-next. But I
don't think it belongs in a stable patch.

> =

> The timestamp section also documents a specific recipe:
> =

>   Getting timestamps for the TX_RING works as follows: i) fill the ring=

>   frames, ii) call sendto() e.g. in blocking mode, iii) wait for status=
 of
>   relevant frames to be updated resp. the frame handed over to the
>   application, iv) walk through the frames to pick up the individual hw=
/sw
>   timestamps.
> =

> When the copy happens before skb_tx_timestamp(),
> __packet_set_timestamp() returns 0, so the frame is handed back as
> TP_STATUS_AVAILABLE with no TP_STATUS_TS_* bit and stale tp_sec/tp_nsec=
,
> even though timestamping was requested.  Can that documented procedure
> still be followed, or should the text describe the new semantics?
> =

> > +
> > +	packet_dec_pending(&po->tx_ring);
> > +	complete(&po->skb_completion);
> > +
> > +	kfree(tu);
> > +	sk_free(&po->sk);
> > +}
> =

> [Severity: Medium]
> Does releasing the wmem charge through sk_free() here miss a write spac=
e
> notification?
> =

> sk_free() only does the decrement:
> =

> net/core/sock.c:sk_free() {
> 	if (refcount_dec_and_test(&sk->sk_wmem_alloc))
> 		__sk_free(sk);
> }
> =

> whereas the skb charge release path notifies first:
> =

> net/core/sock.c:sock_wfree() {
> 	...
> 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
> 		sk_write_space(sk);
> 		len =3D 1;
> 	...
> }

[Medium] False positive.

This sk_free only releases a 1 byte hold for the slot.

The actual release of the truesize attributed to the data (to_write)
is released in the normal sock_wfree path.

It is admittedly odd to have two wmem operations per slot. And perhaps
even questionable to have truesize and wmem count userspace TX_RING
data. But the second is pre-existing and for net-next.

The first is new, but alternatives like sock_hold were found to be
less preferable than an extra 1B hold on wmem.

> =

> A blocking TX_RING sender reaches sock_wait_for_wmem() via
> tpacket_snd()->sock_alloc_send_skb()->sock_alloc_send_pskb(), and its o=
nly
> wake condition for send space is sk->sk_write_space():
> =

> net/core/sock.c:sock_wait_for_wmem() {
> 	...
> 		if (refcount_read(&sk->sk_wmem_alloc) < READ_ONCE(sk->sk_sndbuf))
> 			break;
> 		...
> 		timeo =3D schedule_timeout(timeo);
> 	...
> }
> =

> With the default sk_sndtimeo that schedule_timeout() is
> MAX_SCHEDULE_TIMEOUT.  If the drop below sk_sndbuf is performed by the =
new
> uarg charges only, is anything left to wake the sleeper?  A path where =
the
> skb charge is gone while the uarg charge is still outstanding is
> loopback_xmit(), which calls skb_orphan(skb) (running sock_wfree) witho=
ut
> skb_orphan_frags(), so the ubuf_info survives in the backlog.
> =

> [ ... ]
> =

> > @@ -2908,7 +2918,24 @@ static int tpacket_snd(struct packet_sock *po,=
 struct msghdr *msg)
> >  			virtio_net_hdr_set_proto(skb, &vnet_hdr);
> >  		}
> >  =

> > -		skb->destructor =3D tpacket_destruct_skb;
> > +		uarg =3D kmalloc(sizeof(*uarg), GFP_KERNEL);
> > +		if (unlikely(!uarg)) {
> > +			if (likely(len_sum > 0))
> > +				err =3D len_sum;
> > +			else
> > +				err =3D -ENOMEM;
> > +			goto out_status;
> > +		}
> > +		uarg->po =3D po;
> > +		uarg->ph =3D ph;
> > +		uarg->ubuf.ops =3D &tpacket_ubuf_ops;
> > +		uarg->ubuf.flags =3D SKBFL_ZEROCOPY_FRAG;
> > +		refcount_set(&uarg->ubuf.refcnt, 1);
> > +
> > +		/* Hold a sk_wmem_alloc reference until completion */
> > +		refcount_inc(&po->sk.sk_wmem_alloc);
> > +		skb_zcopy_init(skb, &uarg->ubuf);
> > +
> >  		__packet_set_status(po, ph, TP_STATUS_SENDING);
> >  		packet_inc_pending(&po->tx_ring);
> >  =

> =

> [Severity: Low]
> Just below this, the packet_xmit() error handling in tpacket_snd() stil=
l
> refers to the destructor that this patch removes:
> =

> net/packet/af_packet.c:tpacket_snd() {
> 	...
> 			if (err && __packet_get_status(po, ph) =3D=3D
> 				   TP_STATUS_AVAILABLE) {
> 				/* skb was destructed already */
> 				skb =3D NULL;
> 				goto out_status;
> 			}
> 			/*
> 			 * skb was dropped but not destructed yet;
> 			 * let's treat it like congestion or err < 0
> 			 */
> 	...
> }
> =

> With skb->destructor back to sock_wfree and slot release moved to
> tpacket_ubuf_complete(), does the slot status still imply anything abou=
t
> the skb?  TP_STATUS_AVAILABLE can now be observed while the skb is aliv=
e
> (the uarg completed early through skb_copy_ubufs()), and the slot can
> still read TP_STATUS_SENDING after the skb was freed if a clone or segm=
ent
> holds an extra uarg reference.  Should these comments be reworded for t=
he
> new completion scheme?
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260919004748.1463985-1-willemdebruijn.kernel%40gmail.com


