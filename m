Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000666;
	b=S5JUyd4ej7HTNwjPVfN4MWTKI2dikx6Kl6rbEf8SlO7u5RpyKv6Q6IQ7zG6FkP6Ar1RK
	 i1E8HFuvh3e9RMAnyF41lPdr+eA5yG6jASfeUzH+vaWwnX/Ea0lAW05168gSFcLSOTTNF
	 bC6ZSboQiOi2d6h6/6KeIJC8jiMnxVMFQ987osK2j8LsCucVBitgrZnBEZiIEvKtY9KYa
	 Ux3eGsqIp8gDqpGbXlm1P0yZ88JyDYPD3z0E0x8NpdlDWz0ZIQlWRRxjtC8CQh+xWI0bU
	 GOb8RWdRm1UM227swXIyCAvKCjiiBmqvsAh9hBgbfJyGgN5/LQumUMimqwrUqtXKa5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uHS53nPXOSejlSi+jv2gNsezl/OTR0N1w5mfEYw9sCM=;
	b=VWYjFhHHCm9nfygCSWVxZHKlhdfaFuOxrBDzKevOzctdVOHvGl+VyCXpEjrcAe5hlUA2
	 fl7Nx9Ued5nwvBw0ZEaazNLGhyb42d6sE5enxedrrMGEs8g+Qt4y1ybT/E8iF0wrxvZXR
	 xzmo42ziAec/wqW0BKK1zRlVam9zSPAUmV8gtG+78TC1g47zBgXqQY+eYrD7+/uAFPmwm
	 ZEQlezY//655eN6h/L1yUFFjAbXTDt2Sw8mwBuDd7z/cpEA2Q8MZlzbGe/QdERF/YOkvh
	 dJOyxbS0WCPu8uTscw5Nv2vGdXEqMnMEl3FM+1HglfO8ImahB4qcG8aWVH+amwANCHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLgftZoq;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 21:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA5A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLgftZoq
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9912c47367cso48749241.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000665; x=1794605465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uHS53nPXOSejlSi+jv2gNsezl/OTR0N1w5mfEYw9sCM=;
        b=VLgftZoqDcFjKg1swyoCOChrJ0OxOJvbblETpjbEy0evspZ/pC/CXy2vxESL25kZVp
         gGVKLUbehFEbL0rlHzX+/H+cbYZ7Rgc0bNxGXc7RaAwY7+j+a1h2eqAAt4rFiVbGyQ5Y
         UckI9UkkbneFWr5W/chpda2QTN0VOMEHt4iKpGUy3oAO8X6BArJr+GkNtObB2+JQ61Ei
         05ng9NQqmFwtAjPfssmAOGqpHlYl1EmqS9odx6uugu3g2gLMihbT61pQWNbCQ8o3i9OO
         b3O2GWzKJU6jZ9i9FVGxwl/Nrks7lyZQo4rD4BSg+B9YLeKOTqv64gfU3PQLs7rUyY8Q
         zRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000665; x=1794605465;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHS53nPXOSejlSi+jv2gNsezl/OTR0N1w5mfEYw9sCM=;
        b=exFYn7RYHmwBMuom/tSh0f/9uG+BKPisxo5YwTzyjAz7gvpY+0fBZHtV3dI1+pns5B
         Qo1/I/Pg31DJKVRckTP6xQZrb5mDbV229fePEha7dN2lFrBsOCMvfhvTOywX3jlK5XwI
         BbkwbzkZyhJOul1AOjqY6FbuuElE7M2c0OGXPKuY5xSaxfUh/5l060fvIesxgCsF0zij
         waIpgtcWUxhtjtc10RTVTfCmpWrZ8mQcHJcg7VTNAallKVwF20wSgql4mEN9moTQOOZi
         0wgF88hwRQIrjfcAPIokrurLP3yfpD+juYPu5wv1WkKIT4SsTfYSCseMbZ/QrnNoJ7uS
         Loww==
X-Forwarded-Encrypted: i=1; AL+hErE0cWDKewOtxo1WefzG2cUph0jKjNiEVrYUKtS5h1qPQKxS1uIm3Jc8CE14eTh0A098QKYxkzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DMiAY0neUgO1tE6fTW3LEC4YbTmi1LBNMkZRCb8Bw+9xMHhAd
	VVbOkJOID3wz+IA9fNH7B8PGVJOgaw+J9MLKwa+LG0FjItWx/lQdlHBQ
X-Gm-Gg: AYBFou2JGpUcqbCXP6OigH0b7V5iEL0yeUt46so1tAdQU3wy9+l0NRKxBB6oV8TU7ub
	ztdPjE0IiKdSRcXq35txk4uuG23H0rIh1JHr9T2HSFXmBH1G8dnZOqXUHMJPD0C1cU0nMiFPY5S
	n7PU7HMreg5PGjA8o/5KkOIAO7LmxoPKZbLFFmWBZOum1+ffJqDapKrK6e8VrhQWvFaIsnFBc7+
	h3x2vZ2a0S3Ktf3X0tSSjsZ5VrXvnYp+1TUuA7uEA9qpmROZxnStfvNgDJEQ5NCkOWluUQH6tui
	7+wssmNfny0qn2iW/ZjnMNdK+B+EhBPGOWLjx2J5/G/qWu1z1rbzefsYEVTqK+BxTFvsCvb+A1+
	PaR2bpdiseXcah6gtZNRYOyLnuCzEPwkSjx5hYyA692sh3Ffu+9nEeERdZwrf1UI4NTRExTnY6Z
	u/MaOdGZW0O1RKaqa17OB0hoQV0+YhPilPsn0DP6+YLr16WT/XTbzDiJD+GJm3S20ioflXjVRs9
	uKDNuyeAnAquFVIlX+uAqONK1i9/HRQ4pMbgdLoDwlU9JZA7GxCDa93HtwamcFt3wGfN7fPbsF4
	s53guoHvk9bENSU5hHGfmbgMAT/QUHX1YzXdiSU8rDqUMulVabwbJpQuhn529fGYcoKfOS0EpTO
	pZkDZMV4/vxEdstMHhCZaclScbughUNySkGzNkMStvzAWzp2Sf7CqzIxSjnE9ONUNpOtGrCU=
X-Received: by 2002:a05:6102:6f08:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7d2bd915fd4mr37281137.33.1794000662028;
        Fri, 06 Nov 2026 13:31:02 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a85bf388sm2231650137.2.2026.11.06.13.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:31:01 -0800 (PST)
Date: Fri, 06 Nov 2026 16:31:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 paul@xen.org, 
 wei.liu@kernel.org, 
 mst@redhat.com, 
 axboe@kernel.dk, 
 josef@toxicpanda.com, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.10d143c35878@gmail.com>
In-Reply-To: <20261106212405.947546-1-kuba@kernel.org>
References: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
 <20261106212405.947546-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: replace ubuf_info ops ptr with type
 id
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: skbuff: replace ubuf_info ops ptr with type id
> 
> This commit replaces the ubuf_info_ops vtable pointer in struct ubuf_info
> with a u8 type ID. net_zcopy_complete() switches on that ID to pick one of
> the known completion callbacks, and callbacks that live in modules are
> registered through static_call. The io_uring link_skb callback becomes a
> direct call.
> 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 48f6764117243..3ec9851d0a10e 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> 
> [ ... ]
> 
> > @@ -1898,10 +1900,72 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
> 
> [ ... ]
> 
> > +void net_zcopy_complete(struct sk_buff *skb, struct ubuf_info *uarg,
> > +			bool zerocopy_success)
> > +{
> > +	switch (uarg->type) {
> > +	case UBUF_TYPE_MSG_ZEROCOPY:
> > +		msg_zerocopy_complete(skb, uarg, zerocopy_success);
> > +		break;
> 
> [Severity: High]
> Is the indirect call primitive described in the commit message still
> reachable through this path?
> 
> The commit message says:
> 
>   Corrupting skb_shared_info gives a trivial one-hop indirect call
>   primitive via uarg->ops->complete.
> 
> Take the same threat model: an out-of-bounds write that overwrites
> destructor_arg and flags in skb_shared_info. A forged blob then needs only
> refcnt == 1, type == UBUF_TYPE_MSG_ZEROCOPY, mmp.user == NULL and len == 0.
> Completion goes:
> 
> skb_zcopy_clear()
>   net_zcopy_complete()
>     msg_zerocopy_complete()     /* refcount_dec_and_test() succeeds */
>       __msg_zerocopy_callback()
> 
> __msg_zerocopy_callback() derives the skb from the uarg address. A real
> msgzc uarg sits inside skb->cb, so the derived skb lands in the same
> forged region:
> 
> 	struct sk_buff *tail, *skb = skb_from_uarg(uarg);
> 	struct sock_exterr_skb *serr;
> 	struct sock *sk = skb->sk;
> 	...
> 	mm_unaccount_pinned_pages(&uarg->mmp);
> 	...
> 	if (!uarg->len || sock_flag(sk, SOCK_DEAD))
> 		goto release;
> 	...
> release:
> 	consume_skb(skb);
> 	sock_put(sk);
> 
> With len == 0, sk is not dereferenced before consume_skb() runs on the
> forged skb. consume_skb() then goes through
> __kfree_skb()->skb_release_all()->skb_release_head_state(), which calls
> skb->destructor(skb).
> 
> That destructor pointer comes from attacker memory at a fixed offset just
> past cb[]. sock_put(sk) only runs after the indirect call.
> 
> So forging costs about the same as before: one controlled region at a
> known address plus a target. Before this patch, the same route could be
> reached by pointing a forged ops at &msg_zerocopy_ubuf_ops. Now the forged
> ops pointer is a single byte, and no data symbol address is needed.
> 
> The other type IDs also hand forged memory to callbacks that trust
> container_of():
> 
>   UBUF_TYPE_TPACKET: tpacket_ubuf_complete() writes status through the
>   forged tu->po and tu->ph, then calls sk_free(&po->sk).
> 
>   UBUF_TYPE_VHOST: vhost_zerocopy_complete() writes
>   vq->heads[ubuf->desc].len through forged ctx and vq pointers.
> 
>   UBUF_TYPE_IO_URING: io_tx_ubuf_complete() queues task_work on a notif
>   derived from forged memory.
> 
> Would closing this need one of two changes? One is checking that
> destructor_arg points to a real object of the claimed type. The other is
> stopping msg_zerocopy completion from deriving and freeing an skb (and
> calling its destructor) from the uarg address.

Thanks. I was aware of the ability to forge the sk. But not of all paths.

This patch intends to fix one path, before moving on to the next.

Alternatively, I can try to send a single series that addresses all. It
probably offers little protection otherwise.

Though this also just removes an indirect function call from the hot
path, so arguably it can stand on its own for that too.
