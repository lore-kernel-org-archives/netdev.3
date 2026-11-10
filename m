Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291565;
	b=sudNnNGqQ9cE/45YQTwV6bJUV608ILlIu07vjQHSYGrv5zsVieQ6aRzoXhAiDhqQSJQc
	 RXvNNNsXeh5Ji41KPrP3ph8VUzejjXwplCizsl4rR0IwiSHtfQX3PPagTefrlMXu3Wv0G
	 9l2ta2C35Z8ApnVENaIhy1YMfWBjYtDTckwvPTk7aPZv1wX9Ou1I1k+UURnM82+3BF/WV
	 UYHMD4eCJLNOWE4R3PDS5ShmhqzUaskWooSCZEtgCfB4Z9LzLwnOMCwgCDsUW4i2LDT9V
	 S7/yXnfy0m3gJTVR7zf/MKf2etNWL4amQ1bzwIvLzvBax0toufXvJuUVwBnUJ45UVhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ULmBZxzjd9nmob9hw3BrOGPAN+eHGNmyepihG+CN0s8=;
	b=4pO3ekHigPSGoAjQ4IIuWBZH5zzxW3i3atRxvdPy84YmLhuVb1LMTxEQUJeDfvj+8azq
	 5cHXNe08QSOOlDRZpzas1lvn4DfXlBvKeSkrbgfknGysWOLwEJFt/+oUZEivgpp+41E0c
	 37o3imJltLMOB0CZBKaEoKkg82Qn8MpS7g+EtpR5KCxhGuxc8R+XMEkLdOGNyIuWDgrVS
	 gPo5mtfEkkhd7BJFAUZBxRdHTI+5x1p2V1ZgjSOkQgeQ7iJYmUP8ke2wMabDvrMiMOgRi
	 LgjBu2Ry0r93DcS1dzIC1ZdEhpRXXs6s/5bOiVKChv8yvfoiG8eQ6ACXTmfYItboBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=APu2H1+i;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7773606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7773606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=APu2H1+i
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed1f955de7so11129055ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794291564; x=1794896364; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULmBZxzjd9nmob9hw3BrOGPAN+eHGNmyepihG+CN0s8=;
        b=APu2H1+ik7IdrBZIaZnEAQ9+N/vfJh04TDRCzsHQ8gApRVTdpiv6gdKBgnRm7U1u1P
         rkWSVBvKS0W6rC1PT1UNWRystkglBP30yLl2qF06gAD7fRKE3+djy0NmJVpEZPl0L+gK
         VC4LMl6eLCvXzzakLrUoVPzl6rYBz/Zns59XG82izZuoGJ7Cx2YHcEBq3j6SzF9D8GmQ
         k2oHWnhoZkv19hgyxY/n3kR0kyZfMjH+ojxms28aMAK+PPXBm6U0+hvwp0dW1VME3fBQ
         EzFfGS8cLsxp72jmVmza5ieolAUgaR3Srk0Ct+CydekD1V7Ysn7nx6qc5JTTqnvoETT3
         OwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291564; x=1794896364;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULmBZxzjd9nmob9hw3BrOGPAN+eHGNmyepihG+CN0s8=;
        b=yR82+k5zBuBrsNjeDDEOKSf5FeZX5oWs0fc9sebFSQruEKhVUQJ3ICzfWvNi5bPXPz
         gFSu8rXHKdr18hIYkyUBg9LsIzFyyu4VxxV3EMPyKZ1+0wnSkvvQ79hPb/SNjv2PE5SW
         +mkNalxV2/bVfUjrT6WkxdjvYR/x+oiG/3I17JARkOjgvG5NRUUOIQ+jmMt7eSvTolrp
         EEw25ykL48l/3rm+3S5nj54sIX4Vpe6gznQnfA0p6lDN0wReCMkc7I9Y1SVst6veTKEP
         OL98zMX+IAmAofsdoscmfVk68t8wNINd7EkJ56QuDxnV1qyDMkntq1HmxcU2+2CDbIb5
         FCYQ==
X-Forwarded-Encrypted: i=1; AL+hErEMrcpPmjpa4qeEtH4v4FUrxXQsbebmdKDdt0WMQCy2FnYAWA8tDOS/byX+ri7o6a4vWZ23hak=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OUpLKHuM5fYP4Zn26HbPiUvlnEhUlyxDH3KGJzGY4wQN+BtDP
	klED/EbVGm/UxmlXAR6v1NpTGOxKLB7mZdGzQxiJTyNPNZ8Mp4XXqFvgYhQArgILB5d76EboFZ3
	HAeVwzA==
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2e9:dea5:138])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc9:b0:2e9:8b88:f1ee
 with SMTP id d9443c01a7336-2edb91f89fdmr17283405ad.35.1794291563898; Mon, 09
 Nov 2026 22:19:23 -0800 (PST)
Date: Tue, 10 Nov 2026 06:19:23 +0000
In-Reply-To: <20261110-mtu-probing-series-v3-1-dedfab25d641@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110-mtu-probing-series-v3-0-dedfab25d641@gmail.com> <20261110-mtu-probing-series-v3-1-dedfab25d641@gmail.com>
Message-ID: <avK3FGrs1ca2e-BT@google.com>
Subject: Re: [PATCH net-next v3 1/4] tcp: initialize MTU probing before
 syncing MSS at connection setup
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yongjian Wang <echoowall@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, horms@kernel.org, ncardwell@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, panweiping3@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 00:44:35 +0800, Yongjian Wang wrote:
> With tcp_mtu_probing=2, a passive connection starts at the full MSS
> rather than tcp_base_mss. The IPv4 and IPv6 syn_recv_sock() paths
> call tcp_sync_mss() before tcp_init_transfer() enables MTU probing.
> With tcp_base_mss=1024, the first successful probe can therefore lower
> the MSS from 1460 to 1242. On a black hole path, the first reduction
> skips 1024 and goes straight to 512.
> 
> The issue surfaced while developing packetdrill coverage for MTU
> probing and comparing the initial send MSS on active and passive
> IPv4 connections.
> 
> Commit 4d83e1773031 ("tcp: delete redundant calls of tcp_mtup_init()")
> removed tcp_mtup_init() from the passive setup paths.
> Commit 27204aaa9dc6
> ("tcp: uniform the set up of sockets after successful connection")
> later moved MTU probing initialization into tcp_init_transfer(),
> away from tcp_sync_mss().
> 
> Initialize MTU probing immediately before the existing tcp_sync_mss()
> calls in the IPv4 and IPv6 passive setup paths and when processing
> a SYN-ACK for an active connection. Remove the late initialization
> from tcp_init_transfer(). This lets tcp_sync_mss() apply tcp_base_mss
> without adding another MSS calculation to connection setup. The
> crossed-SYN path already uses this order.
> 
> Fixes: 4d83e1773031 ("tcp: delete redundant calls of tcp_mtup_init()")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Yongjian Wang <echoowall@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
