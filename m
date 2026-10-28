Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223736;
	b=jkfK1N3Ptgb1K6TMmPa08NCkUbAfSNJljizIXdobRnMuh9/QvJzKVie/QWnhu+n5ACDb
	 +Oc+cWrJRSGFwhR7JCZRsk5SM6OPyooqztTb9v02zOzPjQf3TPEu/AoBr5jTUhDibs3ch
	 1+AkJHamkg7Bf4FPpXZKZ9QYWu9+vVu+qxaAWmMbyvo9U/fOnqJfxs/ieuKARPcnPzn95
	 VqHY1fzdokW2s69cFEcFAU24btbk+noZgzv2OLoZ/jd3z+5cPpJ5D1NeE4UqZQ3CSkdZc
	 u9XH+QrNBqCOyY6oLrjdMp6CQ8Caded/R0KyBHh/E19TvdGS42fvAZZ6on2nY2D2pAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=97MNXpQUpTND+mmD0eYg+NTUf+Ug+pSsdYCeQhUXxgU=;
	b=gHe/zSsIH3WsMEf4OXxqJplPlLQb1mzyCtAlU+CwdQ1CfDSKqqoT03DUxbYbRqUyl//Z
	 /I8GnGSM5u3Y2VLHUzEd1awn4rKw4Ppxh95ckl19Wjntwcg7viTZRjSZNflx4Y28N3F1M
	 gYSlln2hmlhNx67jEAMkMaMAe0MpgBf0V0GH4tOJJeLIWz5F8LoIK7vkHaqGZQW6i92jw
	 P0qKHj7MhnbRVLr7k1OJWFxpKUbu4oN4hc0X73/supBrNt8sltC2B+nwDExC5QoLzceeD
	 NO2KovQvqOZqI3MqyhJGEEgMbzhXW10IUVTfM2y91B04CDhyJIQBXDlLvQguMtXhgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ084YdX;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9B606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B9B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ084YdX
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1213888e0c.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223735; x=1793828535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=97MNXpQUpTND+mmD0eYg+NTUf+Ug+pSsdYCeQhUXxgU=;
        b=EJ084YdXc2eiS3ZS+k8TSpmIQcLIf9JfhMiwssAV8dPSeFYAeOjGUHYN56I9QjgZ/K
         OWFgeZP0q5kSQwwQUaF2MZeR3/X7m58czhqSFPm/O7fmhF0tR9fXsfoBCU6Ovzlx15i4
         9IW5mtY20o4p7Gd5vv9OiL8SyX2Ve2MgKsp4P6mnYAWQFC/bEdLrjmG+vS/5Rpvrt8yF
         HzKtuCZYpI2UYB+jE3tUbyS5VVcsL82gI7CsfoPsIfXlhnC77CAcVu5KajAU+JZ4+dVY
         wIKIMlZtbsOktiBSbwbNuYJ3Tlr5dK/k47aGzIOypKqd+mI1nYUdz3tsdiRP42HaouQ8
         3nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223735; x=1793828535;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97MNXpQUpTND+mmD0eYg+NTUf+Ug+pSsdYCeQhUXxgU=;
        b=OfuqEsj0MqVUbN6ukcWl9QDcx8PZU9Z6gVIDJ9UkM1HvjD8ufxxwqFG48IWm5hhbnY
         57GZckDhM+RuBZe2rmYmXOayEYn1EuTgSrjAn3ZkqN/czKLsU9Yii8hHeqKvD9P4U+Bs
         t8FZ30WRnlsRDAcxXRxsLVG1eI11Cpri3Ceu10BPFSYKqzpQp3ozUgqGWiyMLusAGGC5
         cUWzaEC/DG5XM+FtI0d93IJBK6rXutocDQ3nhmZ0xc6075ZIwzDOIDqVu3ITRLaBU6YU
         6ZvUylnchpVRWJy7ZmYwfNpU2hyrIK8vVPDzOylCR4X2v9kSnVTU98gumxRFE+20gYSO
         oO7Q==
X-Forwarded-Encrypted: i=1; AKwUvByY4qxW4cTRLdBB51AhadqinYLFAEphXt20xiZtVSeYKAOSRutqhEQW991H5fBiKz0kzT/tQ14=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd0iylal8D2O4ys7djhIIOKLTpnTVNDqFe6DB4zjOS1nEI7rXD
	MzaPc1MHBjk/ivn1PNWw7X20dlTCLh0F70Q9jhvk9AGeXC+3pO97gchl
X-Gm-Gg: AYBFou2/OlC/n7qVW5tA5/A1X0hpZlffqtCXNJlKlLXeSbgYlfJgFEhbkRsvsW0Axc+
	8xdtBpdLJ8phT91eVo9lJdpadlt8lEeT3z2hqM3OSsyZSzU11Kg2YVNTsTGZc0q4Fb4s7uyJBZF
	dYn7GBBlTlDYh+KdFVROXDMWww5S0k4RztSpWKq4iAB+KSsy4J1gRIoh8QlkIFcC27ONr4KXcal
	DMgKFcga/1JBJ28nUvMxZqH3W6lCnDbd9ffwjEe/m4/psoDH33hQa/aEvyw1VCFrvLQWIP2DPMX
	Kx5AYnl3INJsly4qlnn+s5ZRXi0nKoZWvYIrwTEOa8hDIQISeQ5UataxC9oRTXVduWJNjRNB1Po
	DYE4I7zrWP+PAUQuhmrgjiIsLtat9/6DWpJgaDUIEH54KrGKOdBooUsKnXOXrcmppT4qJi5D8Su
	+Dw5xLNOdkyU9rQ7jXD6MlEOuO25PV7HMH6UxBShFiADgodM6de+NILMmszLVKfjgzvhrOCQ1bR
	fyg3s0khPqCEI6zeS5WWQF64yAanraF44/qVRdpgY0jKII0c5Tlca8codduP/4ChmJk2s6rEHs2
	OVZ9nRI1lfEyP0GnEO1yjuqiJRTNPcaF+0US1Fn9oAkKRA1rguVx9DnP/uHFdYR7cxWCFBnBQKe
	sq29YbMw/SV3PffJXOO4EpkAIsNh3MtogBeb8FP8B6BB7bE0uxini2DWQKxyiwRFhMIVE
X-Received: by 2002:a05:6102:2c81:b0:7c2:7a0:ae28 with SMTP id ada2fe7eead31-7d03a55fdaemr1975911137.30.1793223735408;
        Wed, 28 Oct 2026 14:42:15 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125932041sm7264854241.1.2026.10.28.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:42:14 -0700 (PDT)
Date: Wed, 28 Oct 2026 17:42:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.31ae9fde05c@gmail.com>
In-Reply-To: <20261028070528.139531-2-jingxuanxie@deeproute.ai>
References: <20261028070528.139531-1-jingxuanxie@deeproute.ai>
 <20261028070528.139531-2-jingxuanxie@deeproute.ai>
Subject: Re: [RFC net 1/2] af_packet: retire TPACKET_V3 blocks without waiting
 for copiers
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

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> TPACKET_V3 waits for a ring-wide read lock before retiring a block,
> while holding sk_receive_queue.lock. A copier keeps the read lock
> after reserving a frame and dropping the queue lock. On PREEMPT_RT,
> preempting that copier can therefore delay another packet path or
> the retirement timer until the copier runs again.
> 
> This was investigated after an approximately 355 ms block-retirement
> wait in a real PREEMPT_RT deployment. A QEMU ARM64 SMP PREEMPT_RT
> reproducer uses test-only instrumentation to delay one outgoing
> copier after reservation, with a second sender forcing retirement.
> The unmodified retirement logic blocks the second sender. The
> instrumentation is not part of this series.
> 
> Track FREE, ACTIVE, SEALED and USER state per block in private
> metadata. Reserve and complete copies under the receive queue lock,
> retaining the original block reference across the unlocked copy.
> Seal a full or expired block and try the immediately following block
> without waiting. Publish sealed blocks in reservation order once
> their copies have completed. Do not reuse a sealed block merely
> because its mmap status still reads TP_STATUS_KERNEL.
> 
> Limit each locked publication batch to eight blocks and continue
> ready backlogs on an unbound worker. Stop the timer and worker before
> freeing metadata. Check readiness using the last published block,
> and validate virtio headers before reserving a frame so an invalid
> header cannot strand an unfinished reservation.
> 
> Tested against that reproducer with both full-block and timer
> retirement: B completes while A remains delayed, blocks are not
> published early, and sequence numbers, lengths and payload match.
> An uninstrumented QEMU guest also passes psock_tpacket and
> psock_fanout. The accompanying KUnit suite covers the state helpers.
> 
> Keep the mmap layout and userspace status protocol unchanged. Ring
> exhaustion can still drop capture copies; a stalled copier no longer
> has to block retirement or copying into another available block.
> 
> The block producer index must cover the full unsigned block count,
> matching the independent publication index across large rings.
> 
> Assisted-by: LLM
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
> ---
>  net/packet/af_packet.c | 319 +++++++++++++++++++++++++----------------
>  net/packet/internal.h  |  27 +++-

This is a huge change. Try to solve the problem with a minimal fix.

The patch is doing more in one patch than needed. Such as moving when
virtio_net_hdr_to_skb is called. Probably for good reason but then that is
a separate change.

The main purpose can hopefully be achieved with less code churn too.

Try to avoid re-acquiring sk_receive_queue.lock, a regression. Batching
adds complexity and is probably not needed. system_dfl_wq runs as
SCHED_NORMAL, so this may introduce a new priority inversion.

Also: whitespace corruption, a confidential ("top secret") footer.
