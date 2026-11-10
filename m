Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344513;
	b=0AEoGZig+XPb0L2UWBiTt/RlXg84EejuP3mOhTmE/AP2WJHiPp+hWrqX6lMkXSUSvPZE
	 XiifWFUzjRG4l/ePwZ0mQUP57cfd+3m1E42vv7xBqcDWKpGofOj2hbP6W4jPYoG4g49Ro
	 EJJOpVqeMDuGpacZDKX5jRcAnbzJKDTLVUUmEk1If5FtjHbGPCv884mKJw/Mq0Gra/8gO
	 1MtFFAJOOZEV3eMD3AGL//H/REkP8nc/cQdRQ7HA4D3Z96CRQPdiy/N5VNy61H3Jf0Nve
	 sQaLm2CNB3Rmo9ddqvvmmh9D9CAzceCYLaISgf0R/SoNItemyZQMi28dhNrLVfuB2Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
	b=FV+e0EOsTaBZPqxyibAFt8QvPyxtbdj7ehcvjUYyDNP9ib3l1hrOuZEVR/glRTY+EQxa
	 loLUe5vjMAf8FiU1J/48b4HNyocySnBZvJFCKDljK5i9VvZuNgBvCsv58VRoVbu8kZ7bv
	 yWFDr2uEsF13xy6/lyqCGj1dsa6dxvoGXar8iUaMx5I3R4/aAweb/YHBhXpQXGojT2kNE
	 OwhFdYFAhzI33S8iAnPbZh4Z6Fw8S7R/lBN1SDpcihJAI4JL8PWV0exS1EFPofT4aNiUJ
	 dcpC2VpKyjcH1izCupotmICvXMEasUvcOKzDjLb+/7q07lQfqHevBRHGTElotHFEqDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=CSJ9Dgp0;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69C606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE69C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=CSJ9Dgp0
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18818daa3e7so794305c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344512; x=1794949312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
        b=CSJ9Dgp0zGlrS9GT0Yb7zoj6ITj6pka3nrha22Lru7iJfbhyzdeBhzBHWat74WMNtO
         6I7fNFUxnihp+OiK6I4FRUbbuzOmWZig8TzXInUMD4q82joiV8MMV7bPZ5itH+GxgLLI
         /2STzSYDYWj41+0g/1DnGSRu/Q9ONfSdCbUvBnxZ/8pWVf145+nbhldcjBbi2kkMHJd4
         pZNiRQ5MQlHFYCyKBQMngh56SCV47a9T7N9W97bXOnZZlt2hWWn9X6NBKP0Vi0d6emIN
         t3xR8T6qT4F5vB9asfdyn6rukpaXEP+J3H4ACd0uK6VRHkXkrbgBkCg9pnZ2hAMy7kIP
         EtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344512; x=1794949312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7R8N2eXWD6+EHKfny1HAblM/aky2ALTwQRlCwbdbPY=;
        b=FlYIyMeP8c+DFqKTdEQR9OpC3SUlT2ciXC86vEzL8ub5mOzod0K81Lnh2u4NnlOP6U
         WwAdoVhTB46iQwCCZrx3k0e4+LKDY1P2p7gDR7b/07SrllobCiw+CY/19GCMOcqXuRyk
         je4yDHJaZPEQ4s3RPw26KJAUq1JeYS9Wz2mC2oMN9LXT+AOKxRm16T+r5r3Pw2LrvUXM
         3W+YbA2ifRS2x/uQYMaojy6roetF6Llhd1F5xVwzmsDb5Lk59pOkraTEFON03or2rY1X
         Xw8rVqbSj/Qa69lfeAWEcbKSleqHM+P8OyXbMxl08zW0/fBZJ2K2GhwURDIh/RK+eXqh
         kjTw==
X-Forwarded-Encrypted: i=1; AL+hErEjqZNhonzdYgPXf/aQnbrSM/jMmGOKfaUN9RUDDpoMsWE2ZmMw3EdV8e7EYiOgD+swrz4UPLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G9L2XzXcnJ4FsPxOikBJ7V0XB5+JzJbzZS3OVkt30KVnHbgnG
	lQ4LQ1kkvZdnveTcpFgcGU32aDTivKaHdd6x+99l4R6r9CZTMHeI4zF8a2/Bi6mSr2g=
X-Gm-Gg: AYBFou3vhQA2C5Ahfrtd0rcTQoX+iFewYYtTKg/Iy5tg+YitjORC3mjuh/A8unwZ907
	t8nsi1maOd7VOru9xaBfFTnphwwOSu/qssJTgbDtLTwO0U2YNtosNpW0mMgGUMfE9UIgS1i0xOT
	Nw/4QbJ781qMJTksIsNITkhD96TzBkA7EsTyESYwVVCEqI1qTLOEG2rb1/YLEf3wAXkR0vHS7H2
	4Jtzl36Kst49qHFKuc1efDrThpONvVrnky234FhId0GpbArx839waiyePBWVIPCAhVvACe+5f+Y
	BEWCIXzNFsqSlsl18TLNoNCifGlQIO5HJndG4xd6WFzJi7VMmcq0dgsTfS1rOtpGsXshaWeQRpx
	D61RDZS3Id3Sc2rFNqI2Xc72TVP9XxkZh59a+Evv711iEXsi/neAX+ZCOQPUIHcUnfxsSYljv5N
	Bd/Qk7HiqMFNMj5OytGe0mpFDkh5cVd1pOnnokc4SC64hbvZ/xTqRVbZwja05IhPWFWVSJWEvO1
	8JUOAypKudCVCMavSW7IwQiTCnFOUzU4y+vv6xbTzU9y53A8Pob7ayPvdLp9dtbirg5ZA4E+YjE
	OEEYTFd1Tft95YWj0pZFfuuBGpQF04sRTmmbun1kRe4nnp5MAENX9/lJoUTbzbzDOKWDkYtvWIT
	0Ll/103QCus+EeM70
X-Received: by 2002:a05:701b:4516:20b0:14b:1ef8:698d with SMTP id a92af1059eb24-1b3c036c2c0mr73201c88.15.1794344511472;
        Tue, 10 Nov 2026 13:01:51 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm8017033c88.15.2026.11.10.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:01:50 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/5] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Tue, 10 Nov 2026 21:01:46 +0000
Message-ID: <20261110210147.100396-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179423575689.994134.7687724928848317687@kernel.org>
References: <20261105125010.1107546-2-omar@blockcast.net> <179423575689.994134.7687724928848317687@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 14:49:16 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] amt_tunnel_expire() (drivers/net/amt.c:1412) runs on amt_wq.
> - [High] amt_del_group() (drivers/net/amt.c:293) used to free the group
>   node with kfree_rcu().

v6 has superseded this posting; this patch is v6 2/6:
https://lore.kernel.org/netdev/20261107004935.2627329-3-omar@blockcast.net/

Answers below are against v6 and the v7 I am about to post.

> Can this flush deadlock amt_wq? amt_tunnel_expire() runs on amt_wq, and
> so do group_gc_wq and source_gc_wq.

Fixed in v6, and v7 keeps it. Both flushes are gone:
amt_tunnel_expire() and amt_dev_stop() call __amt_group_gc_work()
directly, and the group GC calls __amt_source_gc_work() directly
instead of flushing source_gc_wq. The cancel_delayed_work_sync() calls
left in the GC queue nothing: each takes a pending timer work off its
timer or queue, or waits for a running one on a barrier that
max_active does not count.

> What limits the number of deleted group nodes waiting on group_gc_list?

Nothing, and v6 still has this. max_groups bounds live groups, not
parked ones, and before this series a deleted group went to
kfree_rcu(), so the series introduces the regression.

v7 counts the nodes parked on both GC lists, under the one lock that
now protects both, and queues the drain of both lists at once when the
count reaches AMT_GC_KICK (2048). A parked group keeps its 256 source
hash heads, so it is a kmalloc-4k object, and 2048 of them is about
8 MiB; the kick keeps the backlog near that instead of letting it grow
for up to 30 seconds. A periodic drain that ends with that many parked
again re-arms at 0 rather than after the interval.

> When the GC finally runs, __amt_group_gc_work() walks the whole spliced
> list with no cond_resched():

v7 adds cond_resched() after each node in both drains. They run only in
process context, with no spinlock or RCU read-side section held. The
kick also bounds what amt_dev_stop() frees in its drain under RTNL.

> Is 0 safe to use here as the "never refreshed" value for last_seen?

Fixed in v6: 2/6 stores "jiffies ?: 1", and 6/6, where every tunnel is
stamped at creation, drops the special case.

> Could the commit message describe each of these failures? Alternatively,
> could they be split into separate patches, each with its own Fixes tag,

v7 keeps one patch, since the tunnel and node fixes share the same
helpers and the same tunnel->lock rules, but its message now names each
failure: (1) as the amt_dev_stop()/amt_tunnel_expire() double
list_del_rcu() and free, (3) and (4) as frees after only
cancel_delayed_work(), and two more races in the timer work: parent
pointers read before tunnel->lock or RCU, and a second destroy or
delete after waiting on tunnel->lock. It carries both tags:

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")

Both went into v5.16, so stable reach is unchanged.

On (2): every walker of a group's source hash, the report handlers and
amt_group_work(), holds tunnel->lock, as does every caller of
amt_destroy_source(), so I don't find a reader that can follow
snode->node onto the GC list. v7 still gives sources and groups a
gc_node of their own, and says it is hardening.
