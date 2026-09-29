Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28253B345
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694409; cv=none; b=GRNTjDcNnG6iR3qIG+IGbbRjMpx2GXUxYp8/4KorCu1qBK492DNbdosTYK414m5eYhiWOsUDPxsqEIfO8h0fzIXhmStytFN7Zwc7HM7jdufFybpmWT6n1c2ikzTxPnjtsmMRO0uRkzPgDA4aMVQPEYZg/ChaZnq0ANjfh8qgHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694409; c=relaxed/simple;
	bh=jwEA9tszSdXiqK2lVGbK9zWNHlffeaTYOxNnAuJHg0s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Pu/rLgR483dCDLvStfY53XFlnvNVZqXJp+3eBDCHbafKPb5V68PC8wQCLiu9XytChGIY2svJXX9kMCBVxIjsjnLTjp56zWA+NswvmlI+M06Nh4hBqWPA47uenui398Ixg2R/4eq/j5f77e91N2D0wBZdZJXmrr+quiIvRdTGcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6GT5t2o; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6GT5t2o"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ab3694b2acso16255567b3.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694388; x=1791299188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aBbvMtdtXkPr9NqwMjzBWKgQ9hOQ8+AsNzjKBiR/MZM=;
        b=h6GT5t2oAjpHhnStHfZZs5+v/BGAaWIu/60oc/Jvtrwgq25a5N78TqLWlLY6tAon4h
         CUKwPT4nszAokGPumvJbv0xMvmD3KJbacNAD4CKQSd+3ue/XjXYvXB81nfL2qRoQmA2X
         /K7XkENNeq0m7wX+miFKcfZrwHwZM/Nn7TC4VlpXCjqvSCLzqWslN1U9szSJZx1/W4dz
         KWiToeXr+ZUMsx9/i7ZeQkOGaIm41XisMs6mmxTjZjYrWYqlgmdjdjBVCPeGxBwg9v9q
         q+O3vyHinS+AHmQy8NviMV8vGooteQFhkUTjtTggt8Zcl8rlDz88/WTcnZIg8DXVix3M
         ouzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694388; x=1791299188;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBbvMtdtXkPr9NqwMjzBWKgQ9hOQ8+AsNzjKBiR/MZM=;
        b=GPhO18rpL9P/oK3NsFTKZl6NGYZhJPWcmYZOG2blXiqfQ7g+fodZXlmCVVtNKXjD3m
         3tdoLO6hWpLwRwnDmxdigBIYSCda/DvdKn+324iq2RO/iqn6kCk5HaMSvO6Z12EQFcZ3
         wu+UfD4nyFC+boLqAxH8qTYh+F7MmiKDnv2E5j8sA2xV7Dkg1I/oyVJO4yaXh2RX0Ty2
         nFgW9kKrfRxHGzCBWSR5DrwjvrF2bQBWsF7jd+OwWYp+QJ/jkPF5vHH+ycUTdA/gsW0F
         n0TRQKAGru00RkVFfuJTHnvMVOMDohmFi599PshiAFe5xkOO8d3UAN0nU+nqw/fkwckg
         4CuA==
X-Forwarded-Encrypted: i=1; AKwUvBy3qoJu0WlaaJXobsIb1iMrQweKC9THE7p529fAQEPF4cl7uu0u4mXaizdaVlsll/JO+CKy+Us=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIhDnZvY9YaVqPzpn2IE4o5JoLhVYfUT9+j5m5IIzOHc2Lz7aP
	0MCCp4PD3OnY65UR73hfIF3IQv6oRncpkFG7gwE2BpuhM2PI3Ejvzb0v
X-Gm-Gg: AYBFou0P+VMS6soxMDiPsLPUE1sNuKioPqok4xDg2xpBLwDZjC7AA2EWJZd1d3egrNJ
	2h9VnhahEjs5KvMucpOyApRKZ0wXyUkMk/Dpzx82GAEmgLbQ1oeNo5dw1k4My2/QZWXuANJ+Vbz
	7TgStKSqdGCiCBoIsaK/2GlQzZjGG7ERZaiXCbyMtuZzkV3D4fApY30hxfhbhxlz+fMWEUlc9C6
	ZNeU/ADiMO2gUDMNSbINUwx1Suet41vXkIeXR+IZ1FBAtlx+34K49IdwwGiMiubRMmsxVVP46v4
	QImx3eGAkKPUQgppwNfErr50rmR8Zk/9DuYDv82r1HdyMtBeP6zYavaytzKjtfsoN+gSxKqZ6b0
	iZTZyHmdi1garhuX3Zbgj1fVnRN1Lhn84G17qmhpz3PQWKUS3IlmU6G87UzltJale7uWnjCrfIg
	LRhmqcABExOY3VxLhbg8rXIEbes5MgIBakwMBEgTTRmZWhZR/stDZHgqssX4xOdKYe9Yi+RDn08
	wqzsZZYhJmHlCCYgXoJD51W8EhtSZRsRMHckNZ8as5gNr7nNHVD
X-Received: by 2002:a05:690c:c50f:b0:8a9:a1e9:2659 with SMTP id 00721157ae682-8a9a1e92fcfmr37633367b3.50.1790694387584;
        Tue, 29 Sep 2026 08:06:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f9cdb0sm60566977b3.24.2026.09.29.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:06:26 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:06:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: lollipopkit <a@lolli.tech>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 lollipopkit <a@lolli.tech>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.570e0a646f4@gmail.com>
In-Reply-To: <20260929045433.59435-1-a@lolli.tech>
References: <20260929045433.59435-1-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs
 instead of requeueing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

lollipopkit wrote:
> SOCKET_URING_OP_TX_TIMESTAMP selects error-queue skbs with
> skb_has_tx_timestamp() but extracts the timestamp with
> skb_get_tx_timestamp().  The two use different checks and can disagree:
> a skb the walk accepted can be rejected with -ENOENT forever.  When
> that happens the processing loop stops and skb_queue_splice() puts the
> unprocessed skbs back onto the HEAD of sk_error_queue.  The rejected
> skb is selected first on every following run, fails again, and blocks
> every skb behind it: new timestamps keep arriving and keep re-running
> the command, but nothing is ever delivered again.
> 
> The disagreement is reachable without a race.  With
> SOF_TIMESTAMPING_BIND_PHC the walk never looks at sk_bind_phc, but
> skb_get_tx_timestamp() converts the hardware timestamp through
> ptp_convert_timestamp(), which returns 0 when no virtual clock matches
> sk_bind_phc (for example when the vclock was destroyed after the
> socket bound to it).  ktime_to_timespec64_cond() then fails and the
> extractor returns -ENOENT permanently.  Any skb with a non-zero
> hwtstamp is selected while SOF_TIMESTAMPING_RAW_HARDWARE is set, so a
> single such skb blocks even the software timestamps queued behind it.
> 
> Measured on real hardware, an I219-V (e1000e), using
> /sys/class/ptp/ptpN/n_vclocks to create and destroy the vclock the
> socket was bound to: 22 error-queue skbs generated (16 software + 6
> hardware).  Of the 21 extractor calls, 20 failed with -ENOENT and the
> one that succeeded delivered 1 software timestamp; deliveries then
> froze while 8 further sends kept re-running the command, and the
> remaining 21 skbs (15 software + 6 hardware) sat in the error queue.
> Both control arms (vclock kept alive; no BIND_PHC) delivered
> everything.
> 
> With this patch applied on top of the CQ-full fix ("io_uring/cmd_net:
> end TX_TIMESTAMP multishot when the CQ is full"), A/B tested in a KVM
> guest from a single kernel binary, with the new behaviour behind a
> test-only runtime switch (the switch is test scaffolding and is not
> part of this patch).  The guest needs no special hardware: QEMU's igb
> model emulates hardware TX timestamping (TSYNCTXCTL/TXSTMPL/TXSTMPH)
> and the igb driver registers a PTP clock, so the guest reproduces the
> same failure the same way.  The two arms are separate runs with their
> own sockets and sends; the device holds one pending hardware
> timestamp, so how many of the 16 sends get a hardware skb varies per
> run (12 and 8 here).  Switch off: 28 skbs generated (16 software + 12
> hardware), deliveries froze at 1 and the remaining 27 (15 software +
> 12 hardware) sat in the error queue.  Switch on: 24 skbs generated (16
> software + 8 hardware); all 16 software timestamps were delivered, the
> 8 hardware skbs the extractor rejected with -ENOENT were dropped, and
> the error queue drained.
> 
> recvmsg(MSG_ERRQUEUE) already treats such a skb as skippable:
> sock_recv_errqueue() dequeues it, returns the error message without a
> timestamp, and frees it.  Do the same here and keep the deliverable
> timestamps moving: drop the skb the extractor rejected and continue
> with the rest of the list.  The CQE-full case keeps its
> requeue-and-end-multishot behaviour.
> 
> Fixes: 9e4ed359b8ef ("io_uring/netcmd: add tx timestamping cmd support")
> Cc: stable@vger.kernel.org # needs the CQ-full fix above
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: lollipopkit <a@lolli.tech>

Is this a real name?

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

"a known identity (sorry, no anonymous contributions.)"
