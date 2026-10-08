Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EB4963B6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455736; cv=none; b=UgeM1b6vlflJ1jRuBoR4EymU7gRBLQAKL14aUlTKm4dggLIdlitox2JQE3zyl0KY3IGgnWaLUV/vK9bVA6fSmF4g4FHrnO35HSf8S+MF6ShAiMv9O2fmNllxphP554lt6S6PmwrC2pHjpylxoZVZZ+xb5cYRspsvOeeT4+knGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455736; c=relaxed/simple;
	bh=kEkkur79QevX+txJt91AJcN2J7iTC/G/g51RVOWejxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zk/GakkreP2AjX0YairAKcLPW4EEZa8iHI0w0DwYzfP2qeccKMyowDDcC9Kd8HVZmhB7tT0p1QDQVjD3Yd3h2BhKdCYSHG0isMrdi6YHq/vH6v14l18njERz8BPh6M81NuyNpsZrtZnoKEO6tx4SOuy0MS9DD6gecdW14TuaXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
In-Reply-To: <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
 <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
Date: Thu, 08 Oct 2026 12:06:05 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875wzctsky.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> The qdisc is left with autorate disabled but with the estimate installed
> instead of X.  On 32-bit machines the unlocked 64-bit rate_bps store is
> also not atomic, so a reader can observe a torn rate.  iproute2 reaches
> this because parsing 'bandwidth X' sets autorate = 0 and emits both
> TCA_CAKE_BASE_RATE64 and TCA_CAKE_AUTORATE.
>
> Commit the parsed configuration and reconfigure while holding the same
> qdisc lock that serializes the datapath, so the netlink writer and the
> autorate writer can no longer interleave.  Make rate_bps an atomic64_t
> so a 64-bit rate update is atomic on 32-bit machines as well, and keep
> the READ_ONCE()/WRITE_ONCE() annotations for the remaining lockless
> readers (cake_config_dump(), which runs without the lock, and the
> cake_mq shared config, which readers observe under different child
> locks).

So atomic_t.txt has this section:

"SEMANTICS
---------

Non-RMW ops:

The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
smp_store_release() respectively. Therefore, if you find yourself only using
the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
and are doing it wrong."


So AFAICT, we don't need atomic_t, we just need READ/WRITE_ONCE()
annotations?

-Toke
