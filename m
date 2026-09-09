Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331753D0DC
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966214; cv=none; b=WFSxFpt1p8yfTFH0DB3CcgNXDvmBJB6SKmL7YKliz0HFvWCGJsrhQ0A3TgfZl+JIl8AHXOz8Ej6vTeOJjE7s9i4dKjJGzPZOK45QLHPqDzVsQh+iy+bnyJxLkpKE4KVhvgOaPJEadZOH0c+yyFAZg8AX7mxwS9PO05cr7QSmhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966214; c=relaxed/simple;
	bh=HHNm5/zc77jcYLLmGgqPDR+NQaIoL0CJyojjLcJtZKc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oFADXpDWPU+rhZNahCw9lP6wYjALZn/fmRDXTnwOvG1b4rPyFDo9n2DG9DGT8ARusgAWeqtkl5hpbfYxI3PcHi54r9AYTNMCHBuCRUiQ6i6aXiM2Iyi4CPBL0zG2cxOz0K5cZyeG1J8Z1D+yepuuTWp8VaMNJsHl2PFExqX7G+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pe4eIKu1; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe4eIKu1"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso11137077b3.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966211; x=1789571011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=08HkDWgh1+HEX92rfdOLS5P3VBFy/7LtpPCQPcLhVmk=;
        b=pe4eIKu1NcigxbYAhfQnp88yJbDzdBiP5VV/aE31+JK7IdCbd1L4QsQb2xQLMRr9k3
         +Fqatxp0DXKcVvUb3E3kmU+YLT1WF9jXPx32jZSnDU9TJpg4BXW0XAq2ztqfNzXccuDu
         KzUZ0L5jEZJVam0tlzVAhiSqIO2ZNachSXJJvgHkRn1P2Fm5GSYDBd/wk7jhV6MZAS5i
         ODan5nEmAplPSPIsBenby5tTpO2eKhGVMh7UNuPeLB0GgtP1d32CZn1CvdFinc7XK1/N
         Rf+qwkh6p4U4I3ZTHDQOYNJ0WkdIWWOgh1ejZTFa+QtvvhYV4dKyCargmcK8Sz/XY0HA
         eAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966211; x=1789571011;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08HkDWgh1+HEX92rfdOLS5P3VBFy/7LtpPCQPcLhVmk=;
        b=DO6hIM1GwJOyaIeqFT7usRch4KDLE2lavYDBGXuYut1gYuDOvQ+6YGxF+4Z143z4cs
         xXB2UHw8k/R9zV3wHFkFkgvYdKtjbIgeGlxeDLM8iAI06mTkYk5/zE8g3La3WH4ItGUR
         1obWZhrghsGUh6ccb3iZukWEcSwcz2EnaEudbqdBgUjbyuHvB7fzoLa3xSwocEonZIwI
         WY/TENNeynxEpK4siQ89/PQxdNn5R78Oq60ooOHDp6Vp7vEoahiLy2r8Ad+J5uUciMJy
         NrpoLa5tSqooDUOsKyPrSTQgjF5Jd+lMRoRlbzh6o+yxpoV36rR5UvwLyfv2GGCetf8A
         Ixvg==
X-Forwarded-Encrypted: i=1; AKwUvBydXaAFDFDRrJ0MGksxDINEpQP8MqlmWOVo+L3J3oQvDoq9U2diosNAbUevwdle21q2ZMXI+GY=@vger.kernel.org
X-Gm-Message-State: AFuF++m7pUBfRskLPumOetuqnwCofRqplhc6feD2SE7E9ElSkgH+S34L
	6y7rKkIAhpeFzGaF0knOG+o5wcVsdeQXEVSFEWOAqPCx5X1nHwnPSm7B4eN1hQ==
X-Gm-Gg: AYBFou3MAtIfN49Qed43CE1fAqFOFhHlsExB5zUCA4xu7DB2fEty9q2ij+lDE8STeCG
	3ejyP0nrPAzPQF3m1s8VZr7D+rkfext92NafECIj4XitwmolrBEfGHFhn+Nu8GC3f5d4vA2JLkt
	A2SQf/cysOjjMR2CnkNlbYt3hjlXARccHom+uq+ZuccaOtJAimX1kdBd1MI92Z35Gng2hDfhA6N
	KXUxi2whfV3eFFjPkxJy+EOo9OWdzvMI9cg7exqkOmwxzrhMgbfVuTBCm19DCE1lGWvUQgL0SGR
	ysCEDhoPEPQnb2Zyq7AgWV1FyghEmZGncnQxWcmA332AMzZEfg9Sc+o6DTI5K1xavN/zbb2zKVp
	6Pq4ldHUiWg28idolB4UiDhCwY0USlVximDDRJ51xvMmevjmh/n48kS4KWJg2sDMkH3J+M9BADV
	hhgbing+JPR4cwBL6wjvJJPOOM9AJHtXEXuNP+Oi3grReipQgJcF9eXwayBq3Z1at5ziKiqsP3v
	1ziVhxvmc6NhfKGyVL+W8qeKPpb3gESoKV5uqehROi8kwJwjR5L
X-Received: by 2002:a05:690c:9:b0:836:ec9b:b468 with SMTP id 00721157ae682-87f2a0de993mr31193367b3.34.1788966209661;
        Wed, 09 Sep 2026 08:03:29 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316347sm113552517b3.15.2026.09.09.08.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:03:28 -0700 (PDT)
Date: Wed, 09 Sep 2026 11:03:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Bjoern Doebel <doebel@amazon.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bjoern Doebel <doebel@amazon.de>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.e4612d16d68@gmail.com>
In-Reply-To: <20260909085542.3370986-1-doebel@amazon.de>
References: <20260909085542.3370986-1-doebel@amazon.de>
Subject: Re: [PATCH net] loopback: orphan zerocopy frags before releasing the
 sender in loopback_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Bjoern Doebel wrote:
> AF_PACKET PACKET_TX_RING transmission over the loopback interface can
> silently corrupt packet payloads in flight. tpacket_fill_skb() builds
> the transmit skb using zerocopy frags. loopback_xmit() then calls bare
> skb_orphan(), which runs skb->destructor (tpacket_destruct_skb()) and
> marks the ring slot TP_STATUS_AVAILABLE, telling userspace the buffer is
> reusable while the in-flight skb frags still reference that buffer.
> 
> This is ok if the packet gets processed immediately in loopback's xmit
> path before userspace gets a chance to reuse the frag buffer. However,
> if the packet gets redirected for instance to another CPU (via RPS),
> this opens a window where userspace may already write new data into the
> frag buffer before the receiver reads the original content.
> 
> Reproducer using txring_overwrite from the net:run_afpackettests selftest:
> 
>   ip netns add ns && ip -netns ns link set lo up
>   ip netns exec ns sh -c \
>       'echo 100 > /sys/class/net/lo/queues/rx-0/rps_cpus'
>   taskset -c 0 ip netns exec ns ./txring_overwrite
> 
> Commit 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> is meant to trigger this copy from the skb_orphan_frags{_rx}() call
> sites, but loopback_xmit() calls bare skb_orphan() before any of them
> run. Address this by taking a kernel-private copy of the skb frags
> before going down the receive path.
> 
> Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjoern Doebel <doebel@amazon.de>
> Assisted-by: Kiro:claude-opus-5

Thanks for the report. We're receiving a number of these.

This issue is not limited to loopback. It is indeed possible to insert
skb_orphan_frags(_rx) statements before skb_orphan in specific
callsites.

But that is not sufficient in all cases, and a game of whack-a-mole
where we may miss instances.

I'm reviewing the options. The alternative, a deep fix in tx_ring,
appears to be non-trivial so not without risk itself.
