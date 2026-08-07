Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86E3AB26E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106573; cv=none; b=ATObzlR50QE8T4BxlaFJx2RYgG8QSJB5V0CeXzFUIlfsxAxE3h2D5jDvGQFn8iNXXSNPS8YUTUIE/e26k6RN/s3SpqvHiciOcXLJwfWT7pCTLiUoJlHulvXuK4WssTGXPwMu4/SbWgos4ZfJdqwit6gCH1WlYbE0OI5Jya11TyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106573; c=relaxed/simple;
	bh=ck4bAkOfDic09ZssSDi+4HZxa2XXe+1yDPSGhMpxajQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukzGwz3lU8HR89zzJdKudBkf4BSqemNmaN4lr6mu/4Z7xcZmi7U8o2ypVqrtnNY3J0daPXkQwCMPOa1fhbqPEePoPucNWXIDa50pC/+/PHbns+V1WwzzMvIQOZDmZS/xRLch7mGpzLEshU5WGpmW8SVkq2ihBlJlIOaYq3ni4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWCE1ZtC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWCE1ZtC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso46089235ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786106559; x=1786711359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kr8eJSH+BHIvzscsgOXb82JV/MgVCq0b6ifuojuwJ6s=;
        b=sWCE1ZtCL8oRZY46lIEXdEHQuw3OyIonxaYmeK0k/lzlHNAqLehZO5j4+yO7lT6lG7
         o/7bdPFpmH7u4zNQ5Y4InlV+Ge6kyt9ssHwkdohIIth4jylDgk1GRxQaumgIlWSnOULw
         ZC3piSrgpRVOBkKIya0CHBv/n5IQiNSNfyyFkxypnVRvW5oiFU05KyaZietr3q78TrcO
         ajFYk68jB097vuI0USy4ubcmP1r6iYEqKETUczULPG7AoiaQ+fjTg/k3eBBDotLcV9Lz
         RoQRd/sYG3R2SU93dJ0BWXDfLFsk87yhMDuLv/Hfcm2rRoLkPpoML07XP26PfsiS1Grf
         YZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106559; x=1786711359;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kr8eJSH+BHIvzscsgOXb82JV/MgVCq0b6ifuojuwJ6s=;
        b=rXaOwP4eX6xBG27nBIjD+8MxhnHBAvDJrJDhMKr5NDrs8Cis62AWT4ZJWWPFp0Abhn
         NqOG81EYycioLRnxGNojnzFdjBtOf1oMntRc5UZH06hJbm+jFBpa27ailbeH0q1124Uc
         eHFISoZz4tEWG+EgRFB7G2xHjlRhvexFoClXvvRLDNvzKZFjmhi3eolwQKgRFJl0pXjK
         8Qtj9qmXAPnDUf94TKkBpoM5ziD+nrGJB6d74RMqxFNmzvhNu+BaFtGfZxLMFqLsWCQk
         S3UutGoWobK5Bg7HBJlkUcXI0C6Gx0RnN6R1aFpMOWzVob6LVEDgsBjTQzSXyknn++6r
         PP7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqbg/IHwEBS4U/osLRu+2Idb6+vNDKM4Gac86mEvmAWGZjGHpdrZZI0AWE+ee1D0QnA+lPIspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywX7gM+E/v1gADU4Pf8Ij9NhLrZvqxF75oByHCPhcUrcmofhbG
	v9WNw6jddxNyb96JDxOUnNcs1wlvMtktuHAxdL+OCv/hb70Wb59/KZcA40GHkQ==
X-Gm-Gg: AR+sD12C9MIGw4aMIKRbyhdLpOBgIB9rVoz47dYdudU8amN5bj2fQ7yYbr9NWZmgYjr
	S1kEpTK2WnGuw4/qMUa5VD0E4PANVhFm2EF1SbwOQ+SYslMvIO8f3aEmiU61Ngxd2ItgNEt7yM1
	ImIYdJ8rRdQKFvKNAm4U1Ed59F+gMi7dPL/izxbHrukptQBQ5fBDYzM5gKcy+t5sWvub7bZrb3s
	oq/jRbLLx9I1ISbU1W2Ma5OFKFCcRxT+3sMXQE5dbfR8Jmcv/C5OG50m7x/lQwYhV+0KEClRjAt
	vWbKzDxvXoJcmW9JANe7sicdOW76ubdJeqvDu0KVnLv0xn9O8HNhWavcyyNIpdoy+ww7HvRFiLu
	9gBA71PJpe3Pm+RSg3Q3Mixj0eGQGcVK+EaiYo+qx259/TXimQ+PRcrsptNIYyJQTxQgDV5+3T+
	YAtTcu26U/mEjjOcgI+FMJqGVD8rf4Yis0VEyKBka0RoVssruRhLfdOx0ND7KjBtRS/g==
X-Received: by 2002:a17:902:ced0:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2d2a8e9ded1mr2645485ad.19.1786106558845;
        Fri, 07 Aug 2026 05:42:38 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbed969sm8560035ad.54.2026.08.07.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:42:38 -0700 (PDT)
Date: Fri, 7 Aug 2026 20:42:30 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>, Felix Maurer <fmaurer@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH net] hsr: Avoid holding seqnr_lock while transmitting
 packets
Message-ID: <anXStphPD0z-ystm@fedora>
References: <20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn>
 <20260807094325.GG51943@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807094325.GG51943@horms.kernel.org>

Hi Simon,
On Fri, Aug 07, 2026 at 10:43:25AM +0100, Simon Horman wrote:
[ ... ]
> Simon says:
> 
> I don't think the advice on how to annotate this is correct
> 
> Tags trump freeform text, but Depends-on is a not a standard tag and as
> such should not be used.
> 
> I believe that the correct approach would be a tag like this:
> 
>   Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> 
> Link: https://docs.kernel.org/process/stable-kernel-rules.html#option-1

Thanks, I will update with this.

> 
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 5555b71ab19b5..14e8d06762294 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> >  		skb->dev = master->dev;
> >  		skb_reset_mac_header(skb);
> >  		skb_reset_mac_len(skb);
> > -		spin_lock_bh(&hsr->seqnr_lock);
> >  		hsr_forward_skb(skb, master);
> > -		spin_unlock_bh(&hsr->seqnr_lock);
> >  	} else {
> >  		dev_core_stats_tx_dropped_inc(dev);
> >  		dev_kfree_skb_any(skb);
> 
> [Severity: Medium]
> [Finding: main-2-3]
> [Sources: opus-5]
> Can this lose statistics updates? The tail of hsr_forward_skb() does plain
> read-modify-write on struct net_device_stats for the master and interlink
> ports:
> 
> net/hsr/hsr_forward.c:hsr_forward_skb() {
> 	...
> 	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
> 		port->dev->stats.tx_packets++;
> 		port->dev->stats.tx_bytes += skb->len;
> 	}
> 	...
> out_drop:
> 	rcu_read_unlock();
> 	port->dev->stats.tx_dropped++;
> }
> 
> Before this change every caller reaching those increments for
> master/interlink held hsr->seqnr_lock across all of hsr_forward_skb(), which
> made them mutually exclusive as a side effect.
> 
> hsr_dev_setup() sets dev->lltx = true ("Prevent recursive tx locking") and
> the master has no qdisc, so __dev_queue_xmit() calls hsr_dev_xmit() without
> the txq lock. Two CPUs can then run tx_packets++ concurrently and drop an
> increment, and tx_bytes += skb->len can tear on 32-bit. The interlink RX
> path, hsr_handle_frame() -> hsr_forward_skb(), now races the same counters.
> 
> Would switching these to dev_sw_netstats or otherwise per-CPU counters be
> preferable while the lock goes away?

Using dev_dstats_* looks good since it has drop count. But hsr also counts
dev->stats.multicast. Do you have any advice other than re-implement a
per-CPU counter for multicast specifically?


[ ... ]

> [Severity: Low]
> [Finding: main-2-2]
> [Sources: opus-5]
> This isn't a bug, but the two implementers of the same
> hsr_proto_ops->send_sv_frame callback now follow different rules for
> seqnr_lock.
> 
> send_hsr_supervision_frame() was converted to the minimal scope the patch
> establishes in handle_std_frame(): lock, bump sup_sequence_nr/sequence_nr,
> unlock.
> 
> send_prp_supervision_frame() still takes seqnr_lock before the sequence
> number bump and holds it across skb_put(), ether_addr_copy() and the
> possibly reallocating skb_put_padto(), which is also why it keeps the
> duplicated unlock in the error path and just before hsr_forward_skb():
> 
> net/hsr/hsr_device.c:send_prp_supervision_frame() {
> 	spin_lock_bh(&hsr->seqnr_lock);
> 	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
> 	hsr->sup_sequence_nr++;
> 	...
> 	if (skb_put_padto(skb, ETH_ZLEN)) {
> 		spin_unlock_bh(&hsr->seqnr_lock);
> 		return;
> 	}
> 
> 	spin_unlock_bh(&hsr->seqnr_lock);
> 
> 	hsr_forward_skb(skb, master);
> }
> 
> Nothing in the extended region re-acquires seqnr_lock and the two unlock
> sites are on mutually exclusive paths, so this is not an unbalanced unlock.
> Could the PRP side be shrunk the same way so both callbacks obey one
> convention and the duplicated unlock disappears?

OK, I will update the prp path.

> 
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 0774981a65c16..8e4158a9b57c8 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
> >  	if (port->type == HSR_PT_MASTER ||
> >  	    port->type == HSR_PT_INTERLINK) {
> >  		/* Sequence nr for the master/interlink node */
> > -		lockdep_assert_held(&hsr->seqnr_lock);
> > +		spin_lock_bh(&hsr->seqnr_lock);
> >  		frame->sequence_nr = hsr->sequence_nr;
> >  		hsr->sequence_nr++;
> > +		spin_unlock_bh(&hsr->seqnr_lock);
> >  	}
> >  }
> 
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5]
> With the lock released here, allocation of the sequence number and the
> actual transmit are no longer atomic with respect to each other. Can frames
> now leave the ring out of sequence order?
> 
> CPU0 handle_std_frame()
> 	spin_lock_bh(&hsr->seqnr_lock);
> 	frame->sequence_nr = 100;
> 	hsr->sequence_nr = 101;
> 	spin_unlock_bh(&hsr->seqnr_lock);
> 
> CPU1 handle_std_frame()
> 	spin_lock_bh(&hsr->seqnr_lock);
> 	frame->sequence_nr = 101;
> 	hsr->sequence_nr = 102;
> 	spin_unlock_bh(&hsr->seqnr_lock);
> 
> CPU1 then reaches hsr_forward_do() -> hsr_xmit() -> dev_queue_xmit() on the
> slaves before CPU0 does, so 101 goes on the wire before 100. hsr_dev_setup()
> sets dev->lltx = true and the master has no queue, so nothing re-establishes
> ordering between the two.
> 
> Local receive is fine, since hsr_check_duplicate() uses the per-node bitmap
> under node->seq_out_lock. The changelog only justifies the relaxation with
> this kernel's own array based discard, which is the point 06afd2c31d33
> raised for the peer side:
> 
> 	"if the higher sequence number leaves on wire before the lower does
> 	 and the destination receives them in that order ... it will drop the
> 	 packet with the lower sequence number and never inject into the
> 	 stack"
> 
> How is a remote DANH, RedBox or hardware peer that still uses last-seq or
> window based duplicate discard expected to behave here, including a Linux
> peer older than aae9d6b616b5? If out-of-order egress is considered
> acceptable, could the changelog say so explicitly?

I think this should not be a problem. The devices running HSR should be in
the same network. It is seldom that one device is upgraded while another
one is left with an old kernel. If the packets go through the internet
via interlink, then no one could promise that the packets are in order.

Thanks
Hangbin
