Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11A19A288
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210123; cv=none; b=sw8OqipnUOfDkBKmkEtE4kBz0wwi3aWvwsu0b32p6vMWPYgKNola4y93rZT0CbsnVtfNzQsu/Or6/VpcnZmMJTVnoqZE8plzT0/VmopXkBktNLMErafefwgcZmx7SB1FH6Gura1/DjKFCXbsVSPo7EcBP1jIkoA9MAqXUJjuJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210123; c=relaxed/simple;
	bh=Sv2hBzyDg9AqYTFO4Wom4dUQjtsGQ/OkpVTOHKuyIko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzL2ZpE4Lh5umKorQu3gVHFc8JJRzni0KpNc+XX9cSvPAXDmv+82elY4hhQSoAAC63/Mrm+ON/p1wNNxUf1fsY03++6xXKc/WrXfXeyBJ8Uf5b6HjqMdsMsOPupgoZf1vMkGJpNgCxxzcdDvs9YpUq+qoRGp9khnoT5LXvVF7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGSc95Iw; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGSc95Iw"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso898119a91.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792210122; x=1792814922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6uFFZ6SToImv4HFp3macvNWcEjUZM2inxO+1r6WtVA=;
        b=sGSc95Iw7m+oDj7zlR/zYn3Sel/9Zy8bm88Jvs7sdy9/U8ott5BDoatrAx0Gm7oHdx
         DGppPmpXSbNGEM8yB0WYB/R6xFLTeShlkZFWx/dILno1ck8haRUTT3N53VRQ3egPi1DA
         tObxDBUSfn+0U3FxphGlEiJ0cb7GxQ5NMgBUmo5Fb+DLPf3Xp7jJGW26cEf4hzrc/Yyo
         KPHAmoBO2+2Vvit5M+VUFiTnKrEK7hR3dotKdxA7Ua78We00WxYYl0Xy36u8b4hFDxyy
         niZbH7+hlycUSRXS2flknnPuLt7la1S+joKH3ZAydMYrVjlwZx65qhD6C8t9ItPYPtgw
         ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210122; x=1792814922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6uFFZ6SToImv4HFp3macvNWcEjUZM2inxO+1r6WtVA=;
        b=h2Vr8dEHYIDNF1nTBXrOAFz11ujpE1cvZDByQGnLPmrMAADrzfW/ruGAlZDG2KKo8e
         JdRpvkztpeIconkl0ypgL+BJhUxN/+Nuo9qEbGW7JyAjv78u/B+XdGAhBDO6OWUKlpyw
         IkYCJCFXJ7Thx3Gl9lr8ux9w99agbVV9XVoobnFunISV//CZHmM0hdOLdFMZnvnOj5/w
         /i4I6Qogu5VztZLhdipAaA53mVHVkLX/aqBZwT8mBeQp0jJiSG+gNkg0xpICgChZOSba
         GdxAbBY6QjHfrIkGh19mBYHWM1tCTTF8TqDMjBEv3WtyN5UGVeF4l3NAla+r0mtZdB2k
         /zBw==
X-Forwarded-Encrypted: i=1; AKwUvByNniAFxVOe/aZRnWhrM0kRmEDrfd0NxGceIWY71lXe3ZLLmZzoZ4Wx5z3+coUFIovRo4pV9l4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4/eAW9wB4/P6uA3RvBgZK4d9wgZYcNxZJYNtLRqxc/FPtXmwZ
	fv9lwMvLDOj+FBjQrbbuI5LA7Dh2w845xmgDjfHejpxd3lk0iXkmNynUd7Y05qzURITw5+g/IDG
	8m2Sj1w==
X-Received: from pgbd24-n2.prod.google.com ([2002:a05:6a02:64d8:20b0:cc4:aa77:305b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5803:b0:3ab:36c4:b500
 with SMTP id 98e67ed59e1d1-3acee27acb6mr1626747a91.5.1792210121557; Fri, 16
 Oct 2026 21:08:41 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:08:41 +0000
In-Reply-To: <20261016084802.2725187-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016084802.2725187-1-edumazet@kernel.org>
Message-ID: <atL0mHavBRoo27tr@google.com>
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst
 device netns
From: kuniyu@google.com
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Qiliang Yuan <odys.yuan@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 10:48:02 +0200, Eric Dumazet wrote:
> tcp_get_metrics(), __tcp_get_metrics_req() and tcpm_new() look up and
> create metrics entries in the netns of the cached dst device rather than
> in the netns of the socket.
> 
> These usually match, but not after the device has been moved to another
> netns or unregistered: a socket can keep a stale dst in sk_dst_cache
> until it is checked again, and tcp_update_metrics() reads it with
> __sk_dst_get() without any dst_check(). Once dst_dev_put() has run, the
> dst device is blackhole_netdev and the entry is created in init_net.
> Before that, for instance for routes through nexthop objects whose
> cached dsts are released from a nested RCU callback, it is the netns the
> device has just been moved to.
> 
> A TCP socket of netns A that enters TIME_WAIT in that window then
> creates or updates an entry carrying A's addresses and RTT in another
> netns, where TCP_METRICS_CMD_GET can dump it and where new connections
> to the same peer inherit those metrics.
> 
> The metrics belong to the netns of the socket, so use sock_net() for
> full sockets and request sockets, and pass it to tcpm_new().
> 
> Kernel sockets that do not hold a netns reference can still reach
> tcp_time_wait() after tcp_net_metrics_exit_batch() has flushed the
> entries of their dismantling netns, and an entry created then would
> never be flushed and would keep a dangling tcpm_net. Make tcpm_new()
> refuse to create entries when check_net() fails. Its callers are in
> an RCU read-side section, and cleanup_net() waits for a grace period
> between the refcount reaching zero and the flush, so an entry added
> after a successful check is always seen by the flush.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
