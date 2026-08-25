Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9411A6815
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640370; cv=none; b=t5UGeOH9uDVRyiwbnpBDKz6Z/WXbncFJqGq5Ibnv83euyYuE0Xp/Rd+rALvT+cdleo6KiRUP/5QW9KdrpThsbHMUY5GMGOV69B0NCFYqUNpePvC0HmT0lK20y7dS3zU930nEOP1Bx3J6CAOWf2C1zQ1fA3BjmO7qNPKesMUSTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640370; c=relaxed/simple;
	bh=Mpet5v8PbkmOMB57V+GBl9/w1eFNgPSqTrZ+a/7/y7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpZ9Q0BDG9HYzWDT3ei1fhrolDLW8z5H8lZBWFCBlFL/2odcxBVAJeBfYmnB2UmAsFCqBGhayp7qH8vFJzlXBrsC1Z+s7CQkrRoAiZeRC32HQssimjvEX9WRpddcDoL0G+1syeQnsOZG8b3k7McFaKxZaVwcY+TBN9FmBwj2Ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=E0ZIgsUU; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="E0ZIgsUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787640363;
	bh=Mpet5v8PbkmOMB57V+GBl9/w1eFNgPSqTrZ+a/7/y7Q=;
	h=From:Subject:Date:Message-ID;
	b=E0ZIgsUUcHW3NiB7GID/6cK5im91sXd9H3yhDZaZErPh+fUEOVbPpDSCmfaYxXXSj
	 9/VFgSf4EO5g3EKJi96Jkdm47B03hCFIeoFtDsikqYRLdzY9+O3aLcP3w/0D+kNQQl
	 YW/H6qE0wrBoCph8d0rAvdaQ0pSfX9/Av6njp5js=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A8D39FC00007A0A; Tue, 25 Aug 2026 14:45:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4797094457020
X-SMAIL-UIID: 220ED35ACA1B48AFA97EF5A114D90D3F-20260825-144522-1
From: Hillf Danton <hdanton@sina.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Tue, 25 Aug 2026 14:45:06 +0800
Message-ID: <20260825064507.1499-1-hdanton@sina.com>
In-Reply-To: <ao0mwtt8ePAINFni@shinhome>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> >
> > I think 19bdb70c77d3 should be reverted.
>
> Just reverting the commit will reintroduce the other lockdep WARN that the
> commit addressed. I hope to have another fix to avoid the WARN.
>
I do not think you know the root cause of that lockdep warn, so reverting
19bdb70c77d3 is the right thing to do because of [11, 12].

[11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
[12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
