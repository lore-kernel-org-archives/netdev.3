Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582681;
	b=BBOk+VFN6T0sEOhZrvhscDZytDddWLbemltxictxcMaVo0pykWYHvtEx/kCq6a9/swfV
	 EjIotUhz/JRfWbpQzlF2SVOsMh+5N9pz9wa8diG65mQdw7HYBlESfAPouIeeJvcxLNXAk
	 FI+kzTd+f9tpE/Bho6Q/EyWHzFlOkoC5oxWjwDBhatuEysSeHvKHixwMW2GOaQcrLCz8q
	 1nivHvxtUJZmJ81UNpMc4ynOmqnn39STJoUyzaUJ1S3kjhqJVv34OBRqdrsg/39fsui0d
	 oTG4X09PLL+r7t5F9G9+LfouHbNflTAaumNd5LKsUA75AanusPv8e/XcqRNpN9SJrag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
	b=xnjy4Z0byhXmnLEr9+wLDOhhzWxq9ZSj2b7HHZSND18YVgAMecNjDe19rGamRyuHQiFQ
	 0rmEygs6+/Du/YO2F8OTei4cisp6Sp9lc945X6mlB3bqS3vRTpTrUZI+pDMENL02+Sd3R
	 I9FRYixlU7thJ043PRY8vGK2FNwqW077HCJdJFFLPx75L/zmnZBrAKem7dABBomfUdEa3
	 v/mvOh9l5o0wP/xUDT4x8pI4JnuDbqw+DGDgCSQ6jro6n8tL+EgRg2wUSoJBqYNLTQ4LR
	 vG4uWQjeqh1LqwCmbGFLbnjStskSYdQHItvVaW5ZdUDqg/3Fz/EqiWM/8zZRF98M39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1BE18LQ;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61102606A334
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61102606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1BE18LQ
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so298654241.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582680; x=1795187480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=u1BE18LQ5cUCwlaJfHj8b/uAgIGAk423ZAbmEWwKAu3EGxGmmyFxlc9jRLwzuc/TFe
         bxUCAmF004E0WxA9Yj5yqfdlupxGmr+wsD36wQO+QPoEa/E55jjxGQqpiE9VfqEo6B5T
         d9bzKOO25H4LY7GPIZ0uNRdqFMXUVr04oMfAWizbicvVmWXxRMLLTTgIEjYhceJIJgv6
         SECq82jRNEunGe8utF/T0uCeRmKESmWjuN16PdmF6RjrAQ24wWdz+mguRSHmLxHMOjIo
         z9ULhYDXsz8dASsujCSzK55o06RJ8temYBXI7Bk9s3R3ZNCVJdoKXaDfQx+4SU49O2XP
         yBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582680; x=1795187480;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=P19xQZ6n9YsAZXxTwsHvZF+x/Mf38pjoCzh8rVdILC38FQdei2o1jxjr8YbNc/GNNm
         qe5oIzdExd7Lrq3wA40Q+Et050XUdvIv7AHRjdry+XWMGx+g4iMAoCahtpUbTONDvmDV
         znbQq/s3VekKidwRMdskzzcazQyYm8jq+ujy4equz/cCo0uwhDI2ByD33+u92moPsIBQ
         GAot8OVqAW4DG8seUZOi2JpnXJqnOxm9blh8F2CNNCrwaFzQBKEn4ixjYQOqjbZ8lt+I
         w044EZ0aG/Y/NmekUoGcb3EusuUMlqdEX+zMFzHBtRXBZKAN/hLj0cgwh5lU3qNY1EKU
         rA3g==
X-Forwarded-Encrypted: i=1; AL+hErGcgeigOdPC8yjq/RQRV5io20X6LYWaEPDVeOFgp0dAyaO9qjo/UWnY2JpLLCU7/pnbTwWpoa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+buJSP3REoJUVgaztxd7RiTzeU8JSHf7XGp3EWgos3tYjhcRGF
	EtzUbDREThu67+ZfYO0m9tqNKb8K4PrnRbKr6cdGVa4Cn3r8X2/pXSDw
X-Gm-Gg: AYBFou0mvohhAzS6Cw9plA9orChsij1CgDSWGInTCU2lYv+omcLDUScaL5P/6n/lYN+
	Dt2F5HcDTxsrEWsWRuzm7IglQVlcq7DdS41IBNGBsUo2O3ofSDq6LbtSJYJnGDhK8wS5q8blhet
	WKxp0GwcFQoMb16R16y0iSVNXqHmGORdOAIoAnKjhdkWx8r0+QBzsbWEKQ5RfzMXBlkXHJy2JNp
	GfpAYgSPlN/BFOWgf50cJJWhRiXZ28dp8gzUqNsw6UKilK7LcpKXhHljb0ZxVsNk1qhRMJYvSoY
	IU0AfS/1xEElA6vca48qCT3SdwScuBDEroRbyBei0jCBW+j+fOg8qd9OOY2Ox/jJaINo1ibhZcg
	Rd2YbJl6/T/2i6L0+uXYlCVvmaKeE5dJxCrx7qkQp2gJ/BsymPM3LAjmTPxRMhS7B9qrOc1Ia/M
	2+af73eLc9mytkKW3Y+FjZMgFlbw+tCXMLFZpFg1YTIrMF+9l3HaJ4QX24CzLQGFd8m51w06J6G
	FPyWEEARe13Vd/J6c8SPfvmNyoRvpoPKOoN3SCxcBSG+sErrGT8TAAKmgCVibxUKDgLEBpNarJV
	2ajrgDEvPlSF0dirfRzUTTwZcAxCubCWLRRn+qtY/vDdYmBPfHV661GPDuDxu44mbkJQ2EiaX10
	lmUTjc751+O4S5+SarS6Lg09Vp+DmV7iYGx598sA+IuYXIln1w1V0GoQOkljzpJqV8+l7x40mKk
	3ooNenbqag
X-Received: by 2002:a05:6122:1816:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ee34aaf4ffmr865841e0c.16.1794582679986;
        Fri, 13 Nov 2026 07:11:19 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e32f83sm1472842e0c.6.2026.11.13.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:11:19 -0800 (PST)
Date: Fri, 13 Nov 2026 10:11:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?6Z+p5bCR6Ziz?= <shaoyanghan@deeproute.ai>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.3a16e755c0d38@gmail.com>
In-Reply-To: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
References: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
Subject: Re: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies at
 retirement
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
> TPACKET_V3 retires a full or expired block while holding
> sk_receive_queue.lock. prb_retire_current_block() takes
> blk_fill_in_prog_lock for write to wait for in-flight skb_copy_bits()
> before publishing the block.
> 
> On PREEMPT_RT a read lock can be held by a task that has been
> preempted or is running on another CPU. The packet path or the
> retirement timer then blocks on the write lock while holding
> sk_receive_queue.lock, and the receive path resumes only after the
> copy completes. This was observed as a receive stall of hundreds of
> milliseconds in a PREEMPT_RT deployment; manual inspection found the
> same unconditional write_lock() in both the full-block and the timer
> retirement paths.
> 
> Try to take the write lock without blocking on PREEMPT_RT. If a copy
> is still in progress, leave the current block and its metadata
> untouched:
> 
> - the retirement timer re-arms itself and retries after the configured
>   interval;
> 
> - packet allocation returns NULL, so tpacket_rcv() drops this capture
>   record and accounts it in tp_drops, while the original packet remains
>   in the network stack;
> 
> - a later packet can retire the block once the copier has finished.
> 
> Do not dispatch the next block while the current block is still open.
> The existing lock order and completion ordering are preserved, and no
> new state or worker is introduced. The trade-off is a higher capture
> drop rate while a copy is in progress; original traffic is unaffected.
> 
> Non-PREEMPT_RT kernels keep the unconditional write_lock(): there
> read_lock() disables preemption, so the writer only waits for the copy
> to finish, not for a scheduled-out task to run again.
> 
> The stall was reproduced on QEMU arm64 SMP PREEMPT_RT by delaying a
> copier after frame reservation: without this change the next sender
> blocks until the copier is released, with this change only that
> capture record is dropped.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>
