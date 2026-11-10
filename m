Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328442;
	b=MFIPnHJnJ4r46JaCiOq1q3nCJDqBoi3+EskyAKEAZuLtuGy5Rdtij2XpnXzW4+jVKH/c
	 cSjK3ILoqEST6GZtk7Oc6itLDO8pAIj0Pdo88kgqlKjIkS1BLBScaoOew7/CGVcZfVy49
	 dwZ2VRW7+qDVcQ1H5ZnTYwahD2EljwarG/m/g5fud3grlOjJE/v7QKp+pC2ywvBabxMBS
	 c6dygrt3tLaicZTdycvupMVal8ybou1LwHH57hPE1XnfT/imxlcuj7FltbV4JdeZ6OPtL
	 J0Bqo/2DKFf4mPGJ5pw2aAD2Gw9fUh6zqJpOG5PPDcrr17xZB8OKD08s8R4oW2A5LEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328442;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xYEq8HbwUXEbqfAYqiylUR/1VTWi5Y1t3UUmnG8Hobw=;
	b=qsofpqhD5WwrFChlzT8z5O8YSv2gMSlPvKpaxGZYdRMHKD+D+uK041h1eU+uk45gHXii
	 p6EqEDS2+N3wNxJmEJcIAAHgNpOSznNS+M4OjS49ONMcpO/OmWQjLkWQsj6wMkGYSeuG6
	 Nx2JX7TI0wS9/NrizKQHsHI5fMddIvzgc9EPm7VAccxdtU1qOvyt4/rUqIrDLYyF2d0Tk
	 vetzQfUNRLmqXeEOA0uSOaMHpC21wl6cCdma/8G9/9mIITz5gHVzBMSax5vjd6rNdLy7s
	 mYvPEAVxBCXdgCFxm6ijvUIP9eJ6GwT2uTbeu2MEXGV+GCfqdGnhBpm9MbJgKDfvo+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=NjXWYsqU;
	arc=none smtp.remote-ip=209.85.216.102
Received: from mail-pj1-f102.google.com (mail-pj1-f102.google.com [209.85.216.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A4606A204
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07A4606A204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=NjXWYsqU
Received: by mail-pj1-f102.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1671137a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328441; x=1794933241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xYEq8HbwUXEbqfAYqiylUR/1VTWi5Y1t3UUmnG8Hobw=;
        b=PGRB7tS/Sc8Mo5ZiuKGShDypYx5H2qc/l/NfZufA8ha12AVwS6WOZ6GE3H6zpnbv7d
         pUeQESGiZORIwRZQWUZwZ/QC8He+8SLVZkqzvV0rqQ4yrhkq9X5WTE65+OFKe1E9FPI9
         QXiWRWlKF6nqvVKotr5Dln9MJ/TzFeNlXX3qhlxi6KKuQjDqzLafLL+t/EvvCSFoXsuw
         kovHZbxH57cQbabzjCrC7ZcZn9iz1bkADKWokID7iCuuq4JQGbT29i0GvzkTa8BbNWXm
         3SODnup9ijH6tS8P9aI5BUwX2ALHKA4ueZ40RU7dRZ9z27+4Rd/yG4YWJrQPauJTCXGO
         qWgw==
X-Forwarded-Encrypted: i=1; AL+hErHGCXjleYdxMUU6066IfeiUNyQ8P3XuYCo/RH6pLb0XNt2q+Xmj1dyfOcuzPhYw/IJAEif+1iY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RDwNjf3zeIZgv9GlGbkyYjO2JkNs6sAb8/5wpn2+Wj+n0CVZh
	5DN3HyGNRPpTOWoNR02q/rd7DhUucjyYpIMTrNbNToehGjVq9n4R5eYRuky/ntDsWEuzrDDNVdG
	vpJI6xi4+0YDhSUw16F8Pfo4lEyn3ynuh3IQ7Jos=
X-Gm-Gg: AYBFou1U6kKPq00YvxlOGjUBDtBrBA2eCjArR6QsmbtK1tfZa1JsT2/lVabetBY4NAr
	o3P3kTzJxd3O5KFGyPOBEJ/20J/hk/dTqxDE+pFxxgEqxdljhvN4x3y0irS/rUd99eItgfJ3ygA
	fjTgiFgDziqBz0cWPzipbnLU7SDK6MPRM3+8ensSLLUXcZtsMyjvKb9io+EQUzj/b8fwhl/eet1
	Ds1wrMpGcS07jxL2LUp1i8TWBCyPt4c+iMnNAcpmfumK/IopsuFxfBQYCWPOB/Dzj8PiO4kMlZc
	XgDM2lUEnQMxRjldoLrHjCw885vInO3C1C0i3rTyKXjFsDvSRrY+MyslKfw9aCyvthNc9RIFp7I
	vtw==
X-Received: by 2002:a17:90b:2b86:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3b166cc1492mr3132138a91.18.1794328441135;
        Tue, 10 Nov 2026 08:34:01 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17db39f76sm230466a91.3.2026.11.10.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:01 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794328438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYEq8HbwUXEbqfAYqiylUR/1VTWi5Y1t3UUmnG8Hobw=;
	b=NjXWYsqUesUoBb2Op846E0r3AyPiJ/nASZJaxW4MJZHcJSVe63eNzfVRxBodLtwKIO07fZ
	OGHokAm3OieWlB++q3OW7jcowp6Dlns0Su0gH8549/u85RwDnDxeVlOZ4JlL4h+hudRPpS
	YQ89M7sHVvCPkUqKhlM6t/YdSVJgrAY=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id d39f359f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:33:58 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:33:56 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Chris Arges <carges@cloudflare.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] wireguard: wait for per-peer crypto during removal
Message-ID: <avNHdEw2zHGyBe_U@zx2c4.com>
References: <20260913-fix-wg-peer-removal-v2-1-0cade985245a@cloudflare.com>
 <aqpqEIy_h0DIywRy@zx2c4.com>
 <aq2jp8lXwSIqihaj@20HS2G4>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aq2jp8lXwSIqihaj@20HS2G4>

On Fri, Sep 18, 2026 at 03:48:39PM -0500, Chris Arges wrote:
> On 2026-09-16 12:06:08, Jason A. Donenfeld wrote:
> > On Sun, Sep 13, 2026 at 07:19:08AM -0500, Chris J Arges wrote:
> > > Calling peer_remove_after_dead() currently flushes device-wide packet
> > > crypto and handshake workqueues while holding RTNL. This is problematic as
> > > unrelated peers can continue adding work to those queues, blocking other
> > > tasks that want to take the RTNL lock.
> > > 
> > > Instead, this patch tracks pending crypto handoffs for each peer using a
> > > counter. After marking the peer dead, synchronize_net() prevents new
> > > submissions. Next, wait for pending crypto workers to schedule TX work and
> > > for RX NAPI to drain the peer's RX queue. Then flush only the peer's TX
> > > packet and handshake work.
> > > 
> > > This scopes teardown synchronization to the removed peer and prevents
> > > unrelated peers from extending the RTNL hold time.
> > >  struct wg_device;
> > > @@ -161,6 +162,7 @@ static inline int wg_queue_enqueue_per_device_and_peer(
> > >  	 */
> > >  	if (unlikely(!wg_prev_queue_enqueue(peer_queue, skb)))
> > >  		return -ENOSPC;
> > > +	atomic_inc(&PACKET_PEER(skb)->packet_crypt_pending);
> > >  
> > >  	/* Then we queue it up in the device queue, which consumes the
> > >  	 * packet as soon as it can.
> > > @@ -182,6 +184,8 @@ static inline void wg_queue_enqueue_per_peer_tx(struct sk_buff *skb, enum packet
> > >  	atomic_set_release(&PACKET_CB(skb)->state, state);
> > >  	queue_work_on(wg_cpumask_choose_online(&peer->serial_work_cpu, peer->internal_id),
> > >  		      peer->device->packet_crypt_wq, &peer->transmit_packet_work);
> > > +	if (atomic_dec_and_test(&peer->packet_crypt_pending))
> > > +		wake_up_var(&peer->packet_crypt_pending);
> > >  	wg_peer_put(peer);
> > >  }
> > >  
> > > diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
> > > index 824bbefce61c..bb35e3205491 100644
> > > --- a/drivers/net/wireguard/receive.c
> > > +++ b/drivers/net/wireguard/receive.c
> > > @@ -476,9 +476,11 @@ int wg_packet_rx_poll(struct napi_struct *napi, int budget)
> > >  
> > >  next:
> > >  		wg_noise_keypair_put(keypair, false);
> > > -		wg_peer_put(peer);
> > >  		if (unlikely(free))
> > >  			dev_kfree_skb(skb);
> > > +		if (atomic_dec_and_test(&peer->packet_crypt_pending))
> > > +			wake_up_var(&peer->packet_crypt_pending);
> > > +		wg_peer_put(peer);
> > 
> > This adds two atomic updates to a per-peer counter for every RX packet
> > and TX batch. That could introduce contention across crypto workers. I
> > suppose it'd be good to see some measurements in if this changes
> > anything. Certainly it should change _something_. Question is by how
> > much.
> > 
> > Jason
> 
> Jason,
> 
> I benchmarked a wg peer on a 2 vCPU and 8 vCPU setup with 1200 byte
> UDP payloads. Goal was stressing the path where these atomics are getting
> incremented.
> - patched 2 vCPU test showed ~1-2% reduction in throughput
> - patched 8 vCPU test showed ~6% reduction in throughput (more contention)
> 
> My main goal is reducing the amount of time holding rtnl_lock when we remove a
> peer. In our systems we frequently get hangs due to workloads bringing up and
> tearing down wg peers. So perhaps I'll need to look into another approach
> where we're not introducing something like a counter into the hotpath.

Did you have any luck with other approaches? I'm still interested in
this.

Thanks,
Jason
