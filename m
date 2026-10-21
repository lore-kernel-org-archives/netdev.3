Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593232;
	b=w4isKeGyQ8t+UDxMsdckrustNSXi768nqnvlEYf+AppDE70zaIQhc/5XrPIXuXTmNcd0
	 ow3pZTa8oapPvnxHqG08NSwI0Aa1G7J2l1iMphS5mIz4Os5CWbbiqcGBzUyg5FzPsojkK
	 /ODk5G+AambVtk5uVDjfXz9HfkxBJne86mr1621re4VxYx99llJirUMovupFK/oT4FWmp
	 3Dv7KpqzV0EII+R6BTj3rmwiCdBcuPF3+cYtEmuSfiMlanyJjJQpesbaaT8/KSRDS+9O9
	 3MTE+siyYWSn811P3QH4QYL/pNdu7KGNkr/52Shi8hvRoOCc/G3poQEN9agOxZMdkmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593232;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pYNpcLyFz6HUlSTmqyPZEPX0/mcE5+MbBWGYVNQFy8I=;
	b=uGburReyaDIOsIrPJVWjRS7Xp8ZzBZHJBFvyZMrI3/l20m6b8uQQmqYrVHThY6o8JcOh
	 1kMgsSRqEXlgKKToBlgazMvGjvefANvc3Nn7DdAXHX9u8+2r0RQ5D0Q7ZHSI9ZQ095iYM
	 /Z1/eSOd/amLq+8+DjCuuqEL3ADNBUB3/de1sx+M3RAduIIKlm+/W2wCZj9MkKymac0I5
	 WIUBlYk0HxbfRUSk9TsFRmeq91p0AC1bUPr41FPueslrM1mILNzQCNm/3Eqrd8HNzsp4R
	 kjsSlzaXbOwwZvAkkos98F0G2nzFqpYlebFSUGmUBOB/TJc3vFwKd1OkjK/dEm7mqOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELdG6wHZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Uplxl6Wi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65E606A334
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D65E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELdG6wHZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Uplxl6Wi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792593230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYNpcLyFz6HUlSTmqyPZEPX0/mcE5+MbBWGYVNQFy8I=;
	b=ELdG6wHZv907SUaOrPjhn+BjuNOGyb8zJ19d4OslggYGh8GQICfIa+YEc6zJ9N5nCzwg3N
	TZKTrWveAEVKuujogFagpmQlqG9hcxxV1g6CLNaWmjXTwR+V9MugFMOeir+nhkkn/JSv8H
	P5gk3UzMY0C6GJ7R1GvPgso6eEfcKv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-HWUP_xnkNsqQLLLTpVyk4g-1; Wed, 21 Oct 2026 14:33:47 +0000
X-MC-Unique: HWUP_xnkNsqQLLLTpVyk4g-1
X-Mimecast-MFC-AGG-ID: HWUP_xnkNsqQLLLTpVyk4g_1792593226
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso4930395e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792593226; x=1793198026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYNpcLyFz6HUlSTmqyPZEPX0/mcE5+MbBWGYVNQFy8I=;
        b=Uplxl6WiSzZ4xZ9Jrr3fa+o0Ztzz+0+srDLs+CN4ZfYpoEesfRqGme7g70hOC55gJS
         mAnZqFQrxmfdIfmWPyP+OCwS7Yp6NQn5XtHG3H1Yp92Ad9CdXTWlKU3UBVPc6aA1wbbb
         dIkYwiO6KQaQoznBDeinAHy8pSMwrnKjakETHhyzoeeYyKHNhJU0nYVs9EKIZWOhfx18
         bChFw530D16twjouZ56kS/qmVXRnNJadZD8eD/VoI7WyAJQYGtyc2wnVNyTW/iDmgLNE
         wmq6HBc43qX/EaY1pMB1J6PecCTbPlJ+qiG4Sj4OCj7WnAzkaJZjEEWju6KSUoRCNh5o
         VrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593226; x=1793198026;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYNpcLyFz6HUlSTmqyPZEPX0/mcE5+MbBWGYVNQFy8I=;
        b=NcstqMStF9hWPCf+ASquENz9dfjMW5hOIHVdoB4Go1xZ05B+/VO5xBh/gp0svecEm/
         v7Y9N12sWAkDxqlOgVXIutwbk6PsMw8ow6sDdIuadGkhNkrBEbi60Yi0nPlIYmddnMpu
         vbfIJ3LZFz3LNond0pUeEHz+tu7ZhWINUarXDXcuq0FjBf/h/TWIUnQfTQA3PC6Rwzlx
         fq48RfrZGGBTKhzlywm/Hk65G+KqW0nYXPzvfPrUkYVVgphEqRiBoo6bHPza+MTatiGp
         2g12YO6o4DYhQQ/YXmpEYq4ixFr3Gng/G80HQjmXcohLKHYSJfkDm4OjRWLNKl8RerMm
         rfuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwi0dEzqvzUw2ixowVldzSHeEWekgZJGYlvtdgsg8UgaBwqKpbZu9sQkJwvb9FN3jb1NYgwmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLudaSTUwKtOrs3etmhVvaka45sDwoD+QYWhZfokPIip6q776UR
	OY5CMLo/DEc0PcgSAIMSHl7f4NZg1d88xPTn8EuMpEnMEPC44+LHjACh2rWUcD3Dlq++2rbMipp
	8+GcWHXVxtACy76K48roAzTW5g20u7fFJltLHgNQen1i8uyKnA2j3x5QWtqYOQ5mY6g==
X-Gm-Gg: AYBFou0MO35UFJBk8SRIswHf7yPI661b+e5pnZGuqNEbUwnHEiGA7gD9Eb5EzQv9WMH
	KhXanjQJYku9ON4rtxMt4D3Eofxe2NFHXfpIeO+6RwhX9a8C+r6Q9jLIVMriQiycSizwxF87Nwr
	7Hcp1OGZ/3BnUoV+4XqqIspYz7GS2UzprJ/OgoYqs7FH2ypcqNF/+whPHSxX7Ujm6T4n/8mcbN9
	jIX9ytA0RiVZU6J5orvqsBccw3ivNge5TZhzqlDSfu3locJXC9eYomX5I0EiaatGZRPSFF5679r
	lRmprHB4yQW0/alPaVvD54YfdPbfEe4O6RH+IkB/D8Lpk4gjl7SuLHsNSs3YGjfYj8Km0Wu6QRp
	kOY5CLoawIAo4RD2iezXanryzMgpqVPGM+bh4+bDqYsMurD1Hy0PWwhCPr7SiEDMbHy74G1X6cA
	==
X-Received: by 2002:a05:600d:82c1:b0:4a1:cdab:f5c4 with SMTP id 5b1f17b1804b1-4a1fdd24674mr47196625e9.5.1792593225788;
        Wed, 21 Oct 2026 07:33:45 -0700 (PDT)
X-Received: by 2002:a05:600d:82c1:b0:4a1:cdab:f5c4 with SMTP id 5b1f17b1804b1-4a1fdd24674mr47196105e9.5.1792593225200;
        Wed, 21 Oct 2026 07:33:45 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581fa7fsm5484387f8f.17.2026.10.21.07.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:33:44 -0700 (PDT)
Message-ID: <bcc5e8c7-21fc-4b63-a954-d737a37e9571@redhat.com>
Date: Wed, 21 Oct 2026 16:33:43 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/13] net/rds: make connection lifetime
 reference-counted
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org
References: <20261017032319.2563014-1-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261017032319.2563014-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 05:23, Allison Henderson wrote:
> Hi all,
> 
> This is v10 of the connection-lifetime set (v1 at [1], v2 at [2],
> v3 at [3], v4 at [6], v5 at [7], v6 at [8], v7 at [9], v8 at [10],
> v9 at [11]), following
> "net/rds: own the fastpath locks across connection teardown", which is
> in net-next.  It is targeted at net-next: although the series fixes
> real use-after-frees (one syzbot report and one report from Chengfeng
> Ye below), it does so by reworking connection lifetime rather than
> patching the individual crash sites, and that rework is too invasive
> for net.
> 
> rds_conn_destroy() frees the connection, its paths and its workqueues
> on the spot, relying on the documented assumption that "no one else is
> referencing the connection".  That assumption stopped being true a
> long time ago: connections are destroyed on netns teardown and on a
> protocol-version mismatch as well as on rmmod, while pointers to them
> still live in socket rs_conn caches, congestion-map conn lists, CM
> callbacks and workers, and - for as long as an application leaves data
> unread - in every rds_incoming sitting on a receive queue.  No single
> Fixes: commit covers the rot, so the series carries Reported-by tags
> where there are concrete reports instead.
> 
> Patches 6, 9, 8 and 13 are ports of the connection kref work Sharath
> Srinivasan did for Oracle UEK, adapted to the upstream code; patch 3
> mirrors UEK's device-removal gate in rds_ib_add_conn().
> 
> The series has been validated with the RDS selftests over loopback-TCP
> and RXE-RDMA, plus churn tests that delete network namespaces and
> unload the modules under live rds-stress traffic.
> 
>    Patch 1 fixes rds_ib_conn_free() re-enabling interrupts under
>    a caller's irqsave lock.  syzbot has since reported this one, and
>    Nguyen Ngoc Thang has posted the same fix for net [12]; it stays here
>    so the series applies today, and can be dropped once his lands.
> 
>    Patch 2 makes the passive-connection exits of __rds_conn_create()
>    undo conn_alloc() the same way the lost-race exit does, through one
>    helper (a refactor: the passive twin only exists for IB, so nothing
>    leaked there).  Both are first in the series because the
>    reference-counted teardown calls conn_free() from more places.
> 
>    Patch 3 has rds_ib_dev_shutdown() mark a device as shutting down
>    under the lock rds_ib_add_conn() attaches under, and makes
>    rds_ib_add_conn() refuse a marked device: a connect that was past
>    rds_ib_get_client_data() when the device's connections were dropped
>    could attach to it afterwards and, on module unload, never be torn
>    down.
>    Based on UEK commit:
>       8d0639e6ba2c ("net/rds: Clean up ib_nodev_conns list handling")
>       https://github.com/oracle/linux-uek/commit/8d0639e6ba2c
> 
>    Patch 4 guards the five work-arming sites that never tested
>    rds_destroy_pending(): two IB completion paths, the IB recv refill,
>    the TCP accept kick and the multipath reconnect in sendmsg.
> 
>    Patch 5 gives the connection its own destroy-in-progress marker.
>    One destroy caller does escape the old predicate - unloading the core
>    module runs the loopback pernet exit for every live namespace, where
>    check_net() is still true and the loop transport's unloading flag is
>    not yet set - though nothing can queue work at that point today.  The
>    later patches need the precise answer: the passive-twin creation must
>    refuse a parent whose destroy has begun, and sendmsg must drop a
>    cached connection whose destroy has.
>    Based on UEK commits:
>       e2f5005adf63 net/rds: Add krefs to struct rds_connection
>       https://github.com/oracle/linux-uek/commit/e2f5005adf63
> 
>       6c53ef92f46e net/rds: Merge uses of conn->c_destroy_in_prog & RDS_DESTROY_PENDING
>       https://github.com/oracle/linux-uek/commit/6c53ef92f46e
> 
>    Patch 6 splits rds_conn_destroy() into a synchronous quiesce and a
>    kref-governed free.
>    Based on UEK commits:
>       2c8569e4c880 ("net/rds: Add krefs to struct rds_connection").
>       https://github.com/oracle/linux-uek/commit/2c8569e4c880
> 
>    Patch 7 unlinks each transport node before its destroy, so a
>    free deferred past the teardown loop cannot write into the loop's
>    stack-local list head.  IB marks a gathered node as claimed by the
>    sweep, since its connect and shutdown paths move the node too; for
>    IB this also closes an existing corruption of the nodev list on
>    module unload, through the stale spliced head.
> 
>    Patch 8 makes each transport's exit path wait for its connections to
>    actually be freed before the module goes away.  It comes after the
>    unlink patch now, so that the IB resweep only ever finds claimed
>    nodes.  The wait is
>    unbounded and warns every ten seconds: a connection reference can be
>    held for an application-controlled time (unread data), so a timeout
>    would only move the use-after-free from freed memory to unloaded
>    module text.  rmmod blocking while data is queued and unread is the
>    historical RDS contract.  For IB the wait re-sweeps the nodev list,
>    since device connections migrate to it asynchronously.
>    Based on UEK commits:
>       ece4b4e39afa ("net/rds: wait_event_timeout until zero connections during rmmod")
>       https://github.com/oracle/linux-uek/commit/ece4b4e39afa
> 
>       905ec90e6166 ("net/rds: Each RDS transport should keep its own connection count")
>       https://github.com/oracle/linux-uek/commit/905ec90e6166
> 
>    Patch 9 makes struct rds_incoming hold a reference on i_conn, the
>    fix for the KASAN use-after-free Chengfeng Ye reported [4].
>    Based on UEK commits:
>        99b9a3715419 ("net/rds: fix crash by expanding kref coverage to rds_incoming.i_conn").
>        https://github.com/oracle/linux-uek/commit/99b9a3715419
> 
>    Patch 10 has the quiesce purge cp_send_queue under cp_lock, as every
>    adder to that queue holds it, and clear RDS_MSG_ON_CONN as it does
>    so, the way rds_send_drop_to() expects.  No sender can be in flight
>    at any of today's destroy triggers (netns teardown, module unload),
>    so this is hygiene rather than a race fix; the old BUG_ON() on a
>    socket-owned message becomes a WARN_ON_ONCE().
> 
>    Patch 11 hands out real references everywhere a connection pointer
>    previously escaped bare, RCU-annotates parent->c_passive, refuses to
>    revive a passive connection whose destroy has begun, and serializes
>    the SIOCRDSSETTOS check with the rs_conn cache.
>    Based on UEK commits:
>       2c8569e4c880 ("net/rds: Add krefs to struct rds_connection")
>       https://github.com/oracle/linux-uek/commit/2c8569e4c880
> 
>       0e9e3a72b7f7 ("net/rds: rds_sendmsg must use rs_conn only when not being destroyed").
>       https://github.com/oracle/linux-uek/commit/0e9e3a72b7f7
> 
>    Patch 12 pins the connection across the RDMA-CM event handler and,
>    on both the passive and the active side, declines to set up a QP for
>    a connection whose destroy has already begun.
> 
>    Patch 13 drops the now-unused global rds_conn_count.
>    Based on UEK commits:
>       905ec90e6166 ("net/rds: Each RDS transport should keep its own connection count").
>       https://github.com/oracle/linux-uek/commit/905ec90e6166
Does not apply cleanly to net-next. The mentioned base commit is not
in net-next nor in net.

You have to rebase on the target tree and resend. Please note that
net-next is currently closed for the merge window.

/P

