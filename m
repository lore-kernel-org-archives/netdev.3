Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376121;
	b=1H+6vePlNBGVKFX7iimbGzPq2/WkRI8oaeKenGS9kJhkuhbpq0Me+iORJpBejU/dYOWQ
	 GdppI/EGnuS5bf9oYxytZRz70AusP1b5FkqGhn57ftOuFcuRXfGtF5fGI0Ci+7IN/tpvG
	 BGkVZgVxn+Q/p9HQcF/GdNFOBHzNSTp/TQ/wcob/fV8t6nCLnMoA6rKn4e2lL4prA6LiN
	 Aefoz+5cB4EPihznSA5tCPScabnrCGJaG4G0+OZQyZO7K90z00ccZa+RlXXGYZmHvJ1XZ
	 K+FVZTkyzB0YCkKLS6HyodZvyArWo+Cmfe4luB//0hTxOifdl9wd99bwKfhrNQ+L2Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ghxg2Vb1au5nQAaQf1TtxvsSzv+LRPNDw6Q8zozRJDE=;
	b=5GgvsIgfrzpv/MtQeMwtjGrS8+Y+4OMaRMRfHZT/GsEU6q6hpYRQu8jpPAiCDG+5IDmb
	 Dfws1m8eMBg0W8iseiVMCmOh6vXRrpMrj6mYex4Uu7yNeT5K9BBf9KzSjCDa+NRKLkz/n
	 Pmt3DjinKWEDWqQlevV5wLZVj5AZljCQ3SkKIv3chkuCvhbNBl4w1UYRWZf98C1z7Sfou
	 sV27GUVSpFt6XaGl5bqkeRNHxvunQkZaI/1VX6Vmgn/czBr2elVB+ZmpVACirZD675bPW
	 LLtSa6dHwcxoH7WjJEV1VMtmrLXi3lDNtG1XjJ6FWWB3nufnriFJHP+/tCLM0Pp5WIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZAiekH23;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C93606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C93606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZAiekH23
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea381ce04fso44602235ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794376121; x=1794980921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ghxg2Vb1au5nQAaQf1TtxvsSzv+LRPNDw6Q8zozRJDE=;
        b=ZAiekH23S18cbYW8ZVCh3XJnZdr1GZylOx7MO6BKbW5qYkdOzbHlNney2AIfcN2kg2
         PJ5O/gYoUq/zdLJp/SHN+EJ5zt3aY3PBKeBTG96pBXHTE7qq/eOrAPrx0x1hW2Ju3gvc
         N8QMGPqPpoXQvTKQP4H2tYIqQ4lYOBnTbmwQ/YajPUm80EGJwSbVk8IGX7vl72oHuqlQ
         VHCTvL4xwHDGbx4vUOnNztwT/HpidECoSkijEwdbbXNZlSlA4MUUeKQDT9BZt2957IvW
         enpSa0W6e/qerGontaHuFwYMoWFHfgvcFeBgyUcBnOBy+29C6nyRyJGSC04HejJ7C6PV
         YULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376121; x=1794980921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ghxg2Vb1au5nQAaQf1TtxvsSzv+LRPNDw6Q8zozRJDE=;
        b=j8Ni2tusdSDdEZ7POnquc6BZVHmIH0YQazr3EPRo01Z6+y+OK5CPhRf2hmJRvv3OHs
         hJrHbj043aG9gsmV9stieOceflze+xNdRh3zqOuePDC8uPBiU1FSn0lS5Ccb71QUJ+cu
         S3lxPH2SOu77xJ+VcBUj8vIjIaftX7lzYKOri1S8dzYeQ/ymQEo+VXk605Fi/0kbggju
         y51PPgFuVXgPanjkW/DP8UuGO8I8rLohkyWtfso8YM0sh4B/b2xKm/gSjDcB2DLvlcb4
         TrOmDKF2Uaq+yYkaMLl7RMXqpCRPllKkyrXjJLOqBGofhva+pQDKd6YBfZpPFAYkbhD3
         n/dg==
X-Forwarded-Encrypted: i=1; AL+hErFA9A0PHk6GGLK0YWC0aR+9GPK98NVdrBhOvEcNeaTEES4KzSaFGSptf0R0d0rZV5DX35o8EnA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YZy5FuCzslBYAiaa7c9zlNLyPWMEKeWkkaegC225IDF1MQG10
	LVhd0L/RwAEXjlZlcnaRW1wcgeH824tMDvNO8x1jaivvu6bKYTfas289MjGUEkMPto/+MLE9LQA
	dXnNfKA==
X-Received: from pluo3.prod.google.com ([2002:a17:903:4b03:b0:2e9:7df8:f0e4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ec:b0:2e5:debe:cb4b
 with SMTP id d9443c01a7336-2edd3ecf804mr16525285ad.10.1794376120408; Tue, 10
 Nov 2026 21:48:40 -0800 (PST)
Date: Wed, 11 Nov 2026 05:48:40 +0000
In-Reply-To: <avMkfJrXhCFXn8M_@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <avMkfJrXhCFXn8M_@v4bel>
Message-ID: <avQBWJFGoi9Dp9uA@google.com>
Subject: Re: [PATCH net v2] tcp: fix NULL pointer dereference when restarting
 a Fast Open listener
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 23:04:44 +0900, Hyunwoo Kim wrote:
> When a valid RST is received for a Fast Open child accepted before the
> three-way handshake completes, reqsk_fastopen_remove() adds the
> request_sock to the listener's RST list if the listener is in TCP_LISTEN.
> 
> An application can call shutdown(SHUT_RD) on a listener socket.
> inet_csk_listen_stop() checks rskq_rst_head without holding
> fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the lock
> and therefore does not synchronize with an insertion by
> reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
> check.
> 
> The more likely outcome of this race, even without a subsequent
> listen(), is a leak. If reqsk_fastopen_remove() inserts a request_sock
> after inet_csk_listen_stop() observes an empty list and returns, the
> request_sock is stranded in rskq_rst_head and keeps a reference on the
> listener. The socket is already in TCP_CLOSE, so a subsequent close()
> does not call inet_csk_listen_stop() again.
> 
> If listen() is called again on the same socket before the delayed list
> insertion, the insertion can overlap the queue initialization in
> reqsk_queue_alloc(). If it occurs after rskq_rst_head is set to NULL but
> before rskq_rst_tail is set to NULL, rskq_rst_head points to the
> request_sock while rskq_rst_tail is NULL.
> 
> When a valid RST is later received for another accepted Fast Open child,
> rskq_rst_head is not NULL, so reqsk_fastopen_remove() attempts to write
> the request_sock pointer to rskq_rst_tail->dl_next while rskq_rst_tail is
> NULL. KASAN reports:
> 
>   BUG: KASAN: null-ptr-deref in reqsk_fastopen_remove+0x147/0x210
>   Write of size 8 at addr 0000000000000088 by task swapper/3/0
>   ...
>   Call Trace:
>    <IRQ>
>    ...
>    reqsk_fastopen_remove+0x147/0x210
>    tcp_check_req+0xa70/0x1060
>    ...
>    tcp_rcv_state_process+0x1cb/0x2ae0
>    ...
>    tcp_v4_do_rcv+0x1fe/0x740
>    tcp_v4_rcv+0x1744/0x2070
>    ...
>    ip_protocol_deliver_rcu+0x5c/0x280
>    ip_local_deliver_finish+0x171/0x330
>    ip_local_deliver+0x107/0x370
>    ...
>    </IRQ>
> 
> To widen the race window, the issue was reproduced after adding
> mdelay(3000) immediately after reqsk_fastopen_remove() checks that the
> listener is in TCP_LISTEN and immediately after reqsk_queue_alloc() sets
> rskq_rst_head to NULL.
> 
> Make inet_csk_listen_stop() acquire fastopenq.lock regardless of the
> value of rskq_rst_head and detach the list while holding the lock. With
> this synchronization, reqsk_fastopen_remove() either inserts the
> request_sock before inet_csk_listen_stop() acquires the lock, in which
> case inet_csk_listen_stop() reclaims it, or sees that the listener is
> not in TCP_LISTEN and does not insert anything.
> 
> Fixes: 0536fcc039a8 ("tcp: prepare fastopen code for upcoming listener changes")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

