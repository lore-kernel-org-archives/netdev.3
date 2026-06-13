Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171D2F83A2
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345561; cv=none; b=bb8C+tKbJk8kSc5YT6f0JD/1BUdK+vHM46PIg/6UZ+P8cbyF8kDDBE4yAfxnBdXXffLadkU8HYB3zr9EKuk2Xgn7UR6g/ab9hN8M0BBz7MbT+IkK5aZkyt106QFBvgBGw8UJGtXWr+qXCKI4nNiWBGIZsJgakuMTLmhz2LcL+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345561; c=relaxed/simple;
	bh=v912xpOvs0q/yr0iMenSrteIUL8UFC9cqr/6/oziSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nsve8qalenVC1TbusRFtbuhp+jXRvFH5qbUPy9li0GTRxMQm8KbuPTqzV/HSYYJanjtNiXAHbWR2dNGHvz01iLZYtOp8ZRIZFwtDx8Z3y1cryFO7CixrHuszdAodYMNs8SCy9isFJ4DR/5vfxt3/6iVWTp4yTFoFLBcwcViM8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=j+7UDRyA; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="j+7UDRyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1781345556;
	bh=o+4ANMBUOQ9kcRY4jwP0XwLbZ4OBI1MMyqHEK1GAvEo=;
	h=From:Subject:Date:Message-ID;
	b=j+7UDRyAIG96QpISdqZa9/KKHY8sAGnCK+Aps6Q/dfFO2DUxxTq1U9g0fVyzwCzUN
	 iobwsrj+nY+X3BwTWkygxVM5Vt6k6u20vag9wHIX6+keFqbTKW0OAt9x1Vn7yR0sRM
	 1LzzsE3GF6n0n22zULSc405/ASVIHe+jZo4Jm9xU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A2D2D0700000894; Sat, 13 Jun 2026 18:12:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5034706816304
X-SMAIL-UIID: 9BB9CB8B0A304A6598BC31B0012ACB21-20260613-181225-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
Date: Sat, 13 Jun 2026 18:12:13 +0800
Message-ID: <20260613101214.1771-1-hdanton@sina.com>
In-Reply-To: <20260613042619.1108126-1-edumazet@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Jun 2026 04:26:19 +0000 Eric Dumazet wrote:
> syzbot reported a possible circular locking dependency in udp_sendmsg()
> where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> can eventually depend on another sk_lock (e.g., if NBD is used for swap
> or writeback and NBD uses TLS/TCP which acquires sk_lock).
> 
> Since the UDP socket and the NBD TCP/TLS socket are different, this is a
> false positive. Fix this by reclassifying NBD sockets to a separate lock
> class when they are added to the NBD device.
> 
> This is similar to what nvme-tcp and other network block devices do.
> 
> Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")

Given the Fixes tag, can you specify anything wrong that commit added?

> Reported-by: syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2cdafe.428ffe26.258b27.0161.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
