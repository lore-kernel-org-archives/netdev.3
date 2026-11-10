Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331042;
	b=TbMJo0CVEDCVyCyDz6hLHOOI403OE/mxORPlHFLjvEL8Cuv945Ufj28VR3oH/6Dv4a99
	 1FG2CoNdrSvCr9GNodkzQWT61ldYpPkAgybqxSU9zVAaODweJRkMQD/NQhJkc+Ig/md26
	 k+w7rGTSWKZacOPR2hP/jeI7Jq+egZpJLt9Ep6lRGd5vstFOAb1Ssb5MqelZpfBC+3nJl
	 dhta4Ou92O8CJyP91y+JjCq8h4kxlhnWfurFk+sgL1QY0JIBahgA9gVe1MDYjQb6gEbrm
	 ERDSooogBdAzYc9Al+5EpZKB7yVLqqhDEWHqE86K9LKefyvM52szuxSiG4kKxBBI5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
	b=vmIaOIpEFH3ExHXhVPCPPDDQOG1NhOY1a3ZeJNp9MbwuPOMqpMoO+YmEVaTybIf7MPAT
	 G9VISL81buAUcHEmjcHF/GmmYoA0GLum4FZPGAx1/LThbJ3qFROOAjEROGiC9dl7KTNL9
	 2Cy6wE1qaxwcOEOtkZwkqc20nEO5MOz2PYT55u4o8j65p18zN+A3ai+y7ocqstkSo1xqr
	 JiWSvT8kDwZaMiVjOmb2tF9dzKmYIsr17I/g9pBHpto0pfiIpNVpCl8XJ0ZyAyMpT2pq9
	 O7xZ1MSNc3gDdGKvW+7UDpsa/EJ9nUS8VT9yrSYqNZTbrkyJz2VN54tukQehm+gUlgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NKKCrJA9;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC1606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NKKCrJA9
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec6f271883so1384980e0c.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794331041; x=1794935841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=NKKCrJA9g8WcA1Ou1yzg2Qhs61lb8dcLj5MZUxusyhRetSjLQ36Zg04UidHm6J9a2J
         ZVt6Sgq+0eCGLFC3Y7PwAt2B+DLaYU3sLlrlveXZp8FtmrHS6UUmfRgujvJ6b8Ch6QDr
         85GUlFDvlsOibkvJsJvKQF4d5qTHlVT3s14fPoFbRd/CdmjDO7i7xGUD7JcMpZeGMGea
         QPyWeoKJXsSlgySEFMDNjA3xLGFRuLjZa2I+f3uwbTasnpqZjxiN/ErJxiXE7hhUR/vs
         mNpMtW3q2HCePxE8ZMaRIddfrjsD4mR+rip5SVcDsSJ9Yybgu7C/pFbER85AWofvgUdZ
         XcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331041; x=1794935841;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=aHlfaWx6bL/aptZvPRFpYDScYNpTKDgBvKlshJ/MQybLDg5K2Cu11D6EAXgS9e3O9e
         ZDT1Bc2I37mddJJ7RsoNi/oxYdlVYBD7Npno88tW3e3xLsYwVMC+lYTlT7tDRviAFL3O
         H/T8MiVrjaTtApAp06YakmrrCntfbm7EZZ73NVfIFXokRTBgwoH4itr9X4apKOZSo2kD
         AQuafD5XX7WaOfq2zNs5Nq+8RjLKn7NpjyHGDETnle/D3kxGjcA+7AvrsroonlqXgZmy
         0ymJfDreGhHa+LyVyt2RtgZibcwP3SjF21XMQUWJGxHMe5hUMkmj4Ed5BpWRa0cG+dV/
         0ONQ==
X-Forwarded-Encrypted: i=1; AL+hErFt/KCXfNlsOBoZ/RWcA5yImHuoLTZSYVp7dxpqDGeBvgt0p/3VEY+nvwcUJItPnkus9YCoMRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z98UbuUMpqo6LRVVUHzh/WZAqtqmIC4A8N+sco3uMgD4EZZw8QP
	SNq4b3/t8GewOV1eMN+cxZC1alN/k+397tJVlnYulq0iSXkAuTMSgz6u9eSE2w==
X-Gm-Gg: AYBFou2mKeX9h4WilJMPWEkK8C6gD+12o8jXfWe8zp0Q+sVz9Naoj5ZQAiOJcLiuyTl
	OKlobOxjo0YiJTehGnpP9dN3COa83ZG/BDolElZb1/4Yz0wS0dlZ2x5oooZuJxafMcw/ifbisG4
	8uw++oH54BqsDHZDyci7nvMM4JmvjXlqIxkVDPiCVhPVpJUCVGpbazGc4hjLazjE/dnFclZeQno
	KyX6skJ25bud1FwkuBT4oCxeMC4q9hPlWqjVdCXOVZufld0SXVmeAuL6A3vq0d4NQ+//WCXbm+S
	jNg9KPvWHB8nKYVEYLdRg6xsQ06hXGLkNiRFtiUpUOi5N/whOfmOtagw6gEQ2irbNc4WuWKpy3Z
	Npm9Xaef9Unv7DkPJLqCVi0EME+xKmUFkc7rnOS7WcXSzYcdNUJ/9pW/cHKU2TZ9QqEWJEn5H+2
	O24bWM5EbguC8ghEVaDwoNipY/B2ZJduu4M5+ZnjNcpinrE8mBIaNKEzNr1+GkxFEQvQ1tIps0F
	GZz9Od0QMKMeb37auiKzL0Pxv2NjXWgkSqEZcyklJgBgdBfyQFGgpL88gW4TO07p7bJCICZPUJ5
	9qv0Po60S3YP2hu3Ni8uwuFR1a7i3G9pzQQbqj/I0j6QhBtuYy5/sMThlCYKlRIypgMt21uBvjZ
	VysCA87Qxo+lIox30h8IDwpza2Pg0Sv0qoES0qX3nahqc2fa7WY0wZX46R4+Y3Rk1dvFt9oM=
X-Received: by 2002:a05:6122:210a:b0:5ea:c722:b3a with SMTP id 71dfb90a1353d-5ee0d0d51d8mr1334938e0c.7.1794331040981;
        Tue, 10 Nov 2026 09:17:20 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5dace7sm2095563e0c.12.2026.11.10.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:17:20 -0800 (PST)
Date: Tue, 10 Nov 2026 12:17:19 -0500
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
Message-ID: <willemdebruijn.kernel.33a00c75cd53e@gmail.com>
In-Reply-To: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
References: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
Subject: Re: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies at
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
