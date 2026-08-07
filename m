Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D81465B4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112853; cv=none; b=loikDx2eoFZ12J6g0ai7I30d57ZVctKZ6Z24To4JMc8fqjc4i44af9y7EhPPBRVtH6SdcVZz0dOJ1xVrSqhGg9FPCdzJ/xL0g2dML8ttLozWjJT0j1E3WG8IYQAh60YQyEw4puVVbNIzYM7hOVI8uRV4PxUNle8DFlnotNgSvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112853; c=relaxed/simple;
	bh=tJ6YIoKNUDojeg86gqnCuw1WTPa7k4m9/MpBN2CPG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doj4zaZSY61W7ky7dy7/2tC5eyybhjLz0MhRjQYX+tX94HY3jYQStjMyCQ80kLl5RZHQZKwTpwlP8+aZPgREiD5XQmUzCoBY5cg5ZModF/asVHAsL1xaFv6IuwElL+WcgL/v0n7z9ywnLM0siHNwBhEyNGxKc0hWLprzBdb0Vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQbqc2jZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQbqc2jZ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2332355a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112850; x=1786717650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY6T8KLKe7c50VCzbw04TgHR78SFTtnFy4T2vHFIKTs=;
        b=BQbqc2jZvfZL+tgjDrZGUNXRoSQDjlvLCKTmrNYmIPTIzs7SEuIxMINYi/dNAPagrh
         qwP5jS/UsbQyPCf6ocQ6TtTEwHQDo+YGagEJxvO6r0vy+UWHBFxoLG1ivYmkMOL69wXo
         BUsr6yrzdc5VPdDxtzYOf9jwcep9cNibfMw26Z6U0ypmMcbvI/FTk7RVRIdQOafX9CMD
         g5iiiPTU5xtz+cwbQ69oC+sW9lXMmingA94DguRfi0Um5YH12uQxu2wFNhX4ZUilWUzE
         QK+aNFtgkqifGFgd/TMmJnanV/km9nDQmJeb7Bg3ZMJU/dpyrr2U+VeqRzyvwhBbzEgb
         gFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112850; x=1786717650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY6T8KLKe7c50VCzbw04TgHR78SFTtnFy4T2vHFIKTs=;
        b=L/GrxGg2tOP64JR1TkZmqZjaDur+aYownUZ0c0r8LwJ/3flZBuHMVDJeFUrr/pUjv4
         0Na9C0MKw8rDN++u7fTcrzg9FjeGC7QWPgUSB27unwyLwFzXJG8DR1JTnodyKTfJUK8l
         fuejmeo/wVf4KzSgOwWc0FL/GPTtHjoisCsJKOs3G6tXfVLBLAzXx7kfDGsw+HDzGoS8
         TjDeFHW8b9ecM5WfT5rBVedOL1yzpfPwqS8sh0R1857yTpP5pLUFR7RO8SyqjEb14lFz
         DhF7N7ydHiulVQuLcrsb/6Xon7eoUl16rGox6jWwRJVGcmrHHAGUOfaut4RVFSa64sr4
         /uIQ==
X-Gm-Message-State: AOJu0YyPc/Fa14K2GwIcWQaarqFfcjOCOikoGWsxr4BRmYcpsJqVvIKi
	Amby5wMqUKN0iuyBljwFXzEp+gbvewrmbtCm5xVKj8E2gEEMdLyV19dO
X-Gm-Gg: AR+sD1299zqVSXGBgGH9kqpfXbyDV5ZWMkLAZrXfxpcn0B1+VZzpWgS7RNOOMwCeLYN
	nVxbvC0wlt/bG/jBBNFJElAHSp1H/6tIgysks9fZgyF+LmSOsrafwgFXpYWHPrI4hARb8b0M2xK
	s8FFpIztkEiA4SymzXYl+fZGus8By1SSvXDmc2wtNvhaeflCJGMdCLw4gtZlfgAqd0qgHIxrAQp
	GtkpRe2XSNjburFeIu29HMWMD2fT4P2ahqjEfsBCp2YJw4nR/m76lGIFMdvMfBCFVTBUMTQkXzo
	BjwRpzArkRELjxKdpdmRHt0XsMXhdI0IuNf1My89nKZ5IfAuOnLsDsXmDRvKFNBfmcuPko3/cZF
	A++CA7QveZGAGEErgm5NB2W/MEqU3l5G5m7MIYXwTDkt2m6g0iYSFiNgEbq3402HcMYeo1mwllj
	KgJ2n+k1FXDxuXXyslfMQvUh9rPJZG/NuQjB7LCf3/R5X/APm0r9bwOYA=
X-Received: by 2002:a05:6a00:1705:b0:82f:38df:681c with SMTP id d2e1a72fcca58-84f2e0228e1mr21662231b3a.6.1786112849746;
        Fri, 07 Aug 2026 07:27:29 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm1125866b3a.43.2026.08.07.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:27:28 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:27:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH net v4 2/4] net: hsr: shrink seqnr_lock to sequence
 counter updates
Message-ID: <anXrR6-2UVYF1iZa@fedora>
References: <20260803222211.877-1-xiexinet@gmail.com>
 <20260803222211.877-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803222211.877-3-xiexinet@gmail.com>

Hi Xie Xin,
On Tue, Aug 04, 2026 at 12:22:09AM +0200, Xin Xie wrote:
> hsr->seqnr_lock is currently held across entire hsr_forward_skb()
> calls: master TX (hsr_dev_xmit()), interlink RX (hsr_handle_frame()),
> and both supervision frame builders hold it while frames are built,
> classified, duplicated and forwarded on every port. The only state
> that actually needs the lock is the sequence counters themselves
> (hsr->sequence_nr / hsr->sup_sequence_nr).
> 
> Shrink the locking to the individual counter updates:
> handle_std_frame() now takes the lock around its sequence number
> allocation (replacing the lockdep assertion), the master TX and
> interlink RX paths drop their outer lock, and the supervision
> builders release the lock right after updating their counter instead
> of holding it across frame construction and forwarding.
> 
> Statistics: the outer seqnr_lock also incidentally serialized the
> tx_packets/tx_bytes/tx_dropped updates in hsr_forward_skb(), which are
> reachable from the concurrently callable master-TX, supervision and
> interlink-RX paths. Those updates now use DEV_STATS_INC()/
> DEV_STATS_ADD(), the atomic legacy-stat helpers, so narrowing the lock
> does not turn them into lossy plain read-modify-writes.
> 
> Ordering: with IFF_NO_QUEUE and dev->lltx, hsr_dev_xmit() is
> concurrently callable, and this change removes the old
> allocation-through-forward ordering guarantee there: master-TX frames
> may now be emitted out of sequence-allocation order. On the current
> tree this is safe because duplicate discard tracks individual
> sequence numbers in sparse bitmaps (commit aae9d6b616b5 ("hsr:
> Implement more robust duplicate discard for HSR") and
> commit 415e6367512b ("hsr: Implement more robust duplicate discard
> for PRP")) rather than requiring monotonic arrival. Sequence numbers
> remain unique and monotonically allocated per counter.
> 
> This is a latency/critical-section prerequisite for unfolding GSO
> super-packets at the forward entry (not a functional prerequisite):
> the segmentation work should not extend the global sequence lock's
> critical section. Patch 3 depends on this change; their automatic
> stable selection is limited to 7.0 and newer, where sparse-bitmap
> duplicate discard accepts out-of-order arrival. Older stable branches
> require an adapted backport.
> 
> History of the lock being narrowed: it was introduced by
> commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
> incremented outgoing seq nr.") and briefly removed by
> commit b3c9e65eb227 ("net: hsr: remove seqnr_lock") in net. Merge
> commit 46ae4d0a4897 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> reverted that removal because
> commit 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames
> received via interlink port.") in net-next had already superseded it
> by adding locking for the interlink RX path. All sequence counter
> updates remain protected; only the forwarding work moves out of the
> critical section.
> 
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Maybe use a shorter commit description.

[ ... ]
> @@ -746,8 +747,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	 * So check and increment stats for master port only here.
>  	 */
>  	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
> -		port->dev->stats.tx_packets++;
> -		port->dev->stats.tx_bytes += skb->len;
> +		DEV_STATS_INC(port->dev, tx_packets);
> +		DEV_STATS_ADD(port->dev, tx_bytes, skb->len);

Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters.

And the counters in hsr_deliver_master() also need to protected. Especially
multicast.

Thanks
Hangbin
