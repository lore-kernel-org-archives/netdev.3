Received: from mail-oi2-f24.google.com (mail-oi2-f24.google.com [74.125.231.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F82222580
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764526; cv=none; b=HbxrYhWH2ceyIH4MQ2qMKbuS2ymfhxmCUVbcpziVIWG4YFTfxZbS6JhL5ucDjp422Xf4TBW5lQ1L6FsM7o0mckRSp641qLTzfBQh0tLsTeTrV7PAKzvVtigJVJKW7smgVISnVd7TJnrNkcYAQMTTE2grRKG/mPjxF76imNrz1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764526; c=relaxed/simple;
	bh=lIULnVXaHfRFnKyXSPLXe+B+3MNbWg24iPNhTFY0tY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvJSXfJzIAuGNtukgGFqxEzBt6Grv5gtRXBlrXXRklbrTl6FpspKV4J88jWvIX3f/ZHcCGNOZccsZjnRai0k9VhSxJQDfTMAKNkk6npWqLwsrO/Wz9q8hy7B1klo7yxFhRhA/B5Jip2yHcEBzh7OI8G4qRUHDBtlLddfUMz1Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MpxylbWV; arc=none smtp.client-ip=74.125.231.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MpxylbWV"
Received: by mail-oi2-f24.google.com with SMTP id 46e09a7af769-7f4f0d37dccso665021a34.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789764522; x=1790369322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppEJDHuTUlQGSUDN/FO8Ik2+PuCaJNFQHPiMwbR7z+4=;
        b=MpxylbWV8mXZjpP1d9RjcG5xs2WRhFCwoNWkKiEssMBss9q967o3UetYXz5mQVzcLR
         zJ+QcyfLzHcRq/u1TBWr4+xZ/Il546Xr7E13aFMBU4kHtDjX/+c8mwsqlRas4IZ7AqLG
         Px85tD9IsKfYCH7PhXkXha3addR6GK4RIRT5P2K8NmCU94zncAcHrJLoiHBGpxcyaVoh
         DymEBfMy3XS+U3l/5TALT6tnGU1/SMOjsKn5e6OBlOj3pasxQvcNyeaEDZcU9tiwV0a8
         M87W9IH4Ort8EfqJL9EvbibDL9rBnJRbeLePiDxkmem2E1GymKTopt8Anlmi6TztRvW6
         +92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789764522; x=1790369322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppEJDHuTUlQGSUDN/FO8Ik2+PuCaJNFQHPiMwbR7z+4=;
        b=zLrMRaTV/l9CiJzm8jEToQblBkwPNdp4qdeUdKxEXedXDOdkTmkdBhEvf1JV7NIbK0
         t2eyVcrlCKBE/vEI5nl1WO3vIPE3nwJAw0ZsWE0PW/CtKD6Kk7y5Hv2JmHsLkQOvSoGc
         Ux8s8jmj65TczCCFSb9DrIZaWcReaNuzMO80g90t7/NT/FGWKgNxVxvx6GGvCqzBvk5y
         paLnS0hX5znR8aieMGbD48dSauBbqxeGkb4fN5T8veXDdSZAzE4ErWfWJbFSpxHmn66Q
         Td4W8M15GsjSKC+b7ByjjGgkLqA17GMBkFP2KaJC43YdoUhCBPAOlVJ/OYTU6QNKU1p2
         tXEA==
X-Forwarded-Encrypted: i=1; AKwUvBwGfyOYjfrSZfwFl9F7Cmtz23NaJX9Xj6uvXnIUu+NmWiIwER+fNt66lyxHieC/gUSn0i/BIJw=@vger.kernel.org
X-Gm-Message-State: AFuF++kZBARyqPpySllZrinAmZfENpB7iNVZUjYK3Z1aRRGHbwd8UcnS
	B+T2slI4qZypc6Fw1sq1hEgwp8XJqLtH/qHH5PkumQFgMkx+t+Fox3YOaBYVCtGq+pk=
X-Gm-Gg: AYBFou1qT0L759stcswiQNqSwCNcDPZo+aSdzpvHlj8NlG48Ug9xIHD6Vgd8q0xmAX7
	BUBjS6ConTmuhMbUl7J6DHjyNsNxiEu9ZQBbELj/sqxv4A0dR+vz3/MxdfkuMXpuFO3y/m4Y9Hu
	bZZUXcJzdrMN8GlYTpT+tN/7aJQu4Jz5ty3S2HoYRHf83LmusLWjU8tcT50imdc7rCA51IsqRzN
	vyQgncK2aLg4arlLtlaW2p5KHycEh2amG4XuZOok2USFU5Lz3u0ksdpm+zClYInYMm/WB3vRxyk
	uorC39qmk+iw1CyFr1UgyT2lcY6/T81x0tgOEkU+HMlzq5FWCJOCfhtGaLnf1P60fkvRxJCe8rv
	ZD5IpBVsigeYA24BsJAS+XlM8oaUcrry19PXp69TjMmX752NWmOeWoQ0gMwiJjJJk9xWHW2h8tr
	izxN8yKrHegnGWUnsVrFMIaDxBcgl6TXh4wcyKTQjR6D9GoEa44GV+l4s=
X-Received: by 2002:a9d:7441:0:b0:806:ab05:c1dd with SMTP id 46e09a7af769-80ddfd6c11amr3214332a34.4.1789764522401;
        Fri, 18 Sep 2026 13:48:42 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:1923::281:62])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107dd8bc84sm480328a34.9.2026.09.18.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:48:40 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:48:39 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] wireguard: wait for per-peer crypto during removal
Message-ID: <aq2jp8lXwSIqihaj@20HS2G4>
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

Jason,

I benchmarked a wg peer on a 2 vCPU and 8 vCPU setup with 1200 byte
UDP payloads. Goal was stressing the path where these atomics are getting
incremented.
- patched 2 vCPU test showed ~1-2% reduction in throughput
- patched 8 vCPU test showed ~6% reduction in throughput (more contention)

My main goal is reducing the amount of time holding rtnl_lock when we remove a
peer. In our systems we frequently get hangs due to workloads bringing up and
tearing down wg peers. So perhaps I'll need to look into another approach
where we're not introducing something like a counter into the hotpath.

Thanks,
--chris
