Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2904AB3B7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576840; cv=none; b=eavFB17N/5y2v7LOhQRBY4zCjIBTnnw7Du2d4uk/Sh31n4mF6/8PJaKQBvXOUvu9uTAlmh57+QMPhgdu9KPACgHkqY9OztDuICIj4k808xyNIYDNV8ZONcA9AEotTg2qfMpn3+eqBGoNTbepQZhx1ydqAwm5a20Er+oPwejuAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576840; c=relaxed/simple;
	bh=nSsSWXBX9C4+LhFuaC9s9XNJIBXDx86cIiaBNLs2SYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OepjLOsql9yzL6Lqq3fYSaV54hDXiGZAfLaS5bl+orbXVGtYLinPpj/saJOlsCFA+evCCHBViURhHdgX6UE9ojrDBJLEOK2MlTaNaciAGylD85m5fAcOGJDrpbNeeAm4S7yNKl+Yp/spc8m498O2TGQJexKthBrz+ZkZiucZ024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N1HqnVtE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N1HqnVtE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-80638c24bedso1656239a34.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789576827; x=1790181627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SjnTPR/EGL67/pMd+T2zbAYFe3UJ3Z05Gc3GQfpLaVg=;
        b=N1HqnVtEapPsh29OdVjaRqzp4kXDll9PJyHhkgx6T7eSVwJIj4v2FmnO3ysCnMOOcZ
         mpFvCt640HelqNfeTJYLY9Sj86qBGX+zHj3jQ+JDzoj5kPjLCDJTEjsPDV/ybzF3Wpug
         s5iCuAvKyNLss8CNwoAWGRSHVhDaS8cQVimzwrfnpUVGp9a9wBWs3T83+ipIuR6eCIe1
         UXB/y2mG5gMtu80+GVM2wewV1XsX9ugoWMVNq4MmBUofMaJbr7IVd5NUSis4epqRQ/+o
         jYScVewCffEvkFfUFSPPkb9aQsX/xvGLZONwj+1viclw3xw6wZDqk+qbzp8iCLjyZQ4n
         S6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576827; x=1790181627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjnTPR/EGL67/pMd+T2zbAYFe3UJ3Z05Gc3GQfpLaVg=;
        b=r0aMqI8otXRinpchnosXWoEUhk4xSRVNlQssLUU1VvQWgTNXi0r4Xqgbi/vZHHm+jh
         bePtwew4HvQRMnvj6ngTuUZcveKv/sMv0TyDxUjCw+CmaIWs95M0ynzpEQdfK3iJlwc5
         ESXGes771/G7sfVxOWt6GQklr2kgpBOaqHB8Zpm6jg94Rg41d7f+syew78m9ZWlXs2sf
         pLn0U9CUBwW+I3CZ1bCgbZQljLonntlW58kZ6BhOfU/tDXYZUZ+AQUtiDUdgf7Eaup2f
         xyrLQGQv9Lm5X1DfF8IJPHGDSp/NTTOGKNCwo3CkwgTYw6SIY/fGXUcPVMja6HoD0wdW
         TnsA==
X-Forwarded-Encrypted: i=1; AKwUvBxacF2f7kcAy34JkWjDA9i8NxmsqHLoqc9ouh+TK2iPSpmc83iLUnaDwGgKMJGS0p/YOzAPaF8=@vger.kernel.org
X-Gm-Message-State: AFuF++nr5+1ZQ5yo1Rz3/q+gspKBEbLc6U1hif/XYrJL3BOUmlIagoDY
	+la9R6vg27tGP2pqYmZf8Q6+NZ/0H/Hd7EpAsVVMHDd1g88X8Hx4+VPUVasdITXURe8=
X-Gm-Gg: AYBFou2Tee1Inmz95NAJ+Jb47pRlepyYGBiPZjGSKkJOWFhrlleA9LYlm3AngX4Qozf
	FSteH/4kWl6qywE76IhR5P/hMrc96XNgPqxKPDcLf8/KU0JbysnjSoRvVXjMjMtUDn/KkCg4tUL
	maNK5A206LHml2flTOtFCH6D549+ehJgnoJhRVQxCp3J2yXxJT3z5HFeUb5BucWaBG+2I5gugVj
	xlX8HPdaDwigpDZiK1ghjqeQKiYIuJUuo7QGhcchw6dcfwT6fES/fernWCADDzKAFcMlipgaP0R
	k+lLIqp0PUd4+EzGOFUGbnzO66G55qdhYQrx8OOKevvhHP0bu5oSR7j6ZKYMT7OP3xxMzIvY+Gt
	BAuBI/9Z0QjecuyiX2cjMtJMHRF7vuPZzk1hRnXOkM3PcpMUNHmXSZqQL1itvtQMzSxhZ2/7kdU
	RTDALqUaE1j/xKUmRVhkCHwtoJbuUUUTp/QWmlnwOwGKBmpscV+8a53I/RZSIbmw==
X-Received: by 2002:a05:6830:67e4:b0:807:50d:7f3a with SMTP id 46e09a7af769-80c4e7f7ba1mr199721a34.30.1789576826716;
        Wed, 16 Sep 2026 09:40:26 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:96::f:339])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46dbe483sm255445a34.20.2026.09.16.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:40:26 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:40:24 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] wireguard: wait for per-peer crypto during removal
Message-ID: <aqrGeOpbu_u-CBes@20HS2G4>
References: <20260913-fix-wg-peer-removal-v2-1-0cade985245a@cloudflare.com>
 <aqpqEIy_h0DIywRy@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqpqEIy_h0DIywRy@zx2c4.com>

On 2026-09-16 12:06:08, Jason A. Donenfeld wrote:
> On Sun, Sep 13, 2026 at 07:19:08AM -0500, Chris J Arges wrote:
> > Calling peer_remove_after_dead() currently flushes device-wide packet
> > crypto and handshake workqueues while holding RTNL. This is problematic as
> > unrelated peers can continue adding work to those queues, blocking other
> > tasks that want to take the RTNL lock.
> > 
> > Instead, this patch tracks pending crypto handoffs for each peer using a
> > counter. After marking the peer dead, synchronize_net() prevents new
> > submissions. Next, wait for pending crypto workers to schedule TX work and
> > for RX NAPI to drain the peer's RX queue. Then flush only the peer's TX
> > packet and handshake work.
> > 
> > This scopes teardown synchronization to the removed peer and prevents
> > unrelated peers from extending the RTNL hold time.
> >  struct wg_device;
> > @@ -161,6 +162,7 @@ static inline int wg_queue_enqueue_per_device_and_peer(
> >  	 */
> >  	if (unlikely(!wg_prev_queue_enqueue(peer_queue, skb)))
> >  		return -ENOSPC;
> > +	atomic_inc(&PACKET_PEER(skb)->packet_crypt_pending);
> >  
> >  	/* Then we queue it up in the device queue, which consumes the
> >  	 * packet as soon as it can.
> > @@ -182,6 +184,8 @@ static inline void wg_queue_enqueue_per_peer_tx(struct sk_buff *skb, enum packet
> >  	atomic_set_release(&PACKET_CB(skb)->state, state);
> >  	queue_work_on(wg_cpumask_choose_online(&peer->serial_work_cpu, peer->internal_id),
> >  		      peer->device->packet_crypt_wq, &peer->transmit_packet_work);
> > +	if (atomic_dec_and_test(&peer->packet_crypt_pending))
> > +		wake_up_var(&peer->packet_crypt_pending);
> >  	wg_peer_put(peer);
> >  }
> >  
> > diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
> > index 824bbefce61c..bb35e3205491 100644
> > --- a/drivers/net/wireguard/receive.c
> > +++ b/drivers/net/wireguard/receive.c
> > @@ -476,9 +476,11 @@ int wg_packet_rx_poll(struct napi_struct *napi, int budget)
> >  
> >  next:
> >  		wg_noise_keypair_put(keypair, false);
> > -		wg_peer_put(peer);
> >  		if (unlikely(free))
> >  			dev_kfree_skb(skb);
> > +		if (atomic_dec_and_test(&peer->packet_crypt_pending))
> > +			wake_up_var(&peer->packet_crypt_pending);
> > +		wg_peer_put(peer);
> 
> This adds two atomic updates to a per-peer counter for every RX packet
> and TX batch. That could introduce contention across crypto workers. I
> suppose it'd be good to see some measurements in if this changes
> anything. Certainly it should change _something_. Question is by how
> much.
> 
> Jason

Thanks, I'll get some numbers here and share. We're testing this on some
production machines now. In addition I'll get numbers from my synthetic testing
and report back.

--chris
