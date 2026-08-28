Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743F13777E
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907716; cv=none; b=fCSJ4PUOBKW5PIYV6bMFrL/in/JMFiWo+XP6YK/R/mOSVAAb/l15Xu85IvseITmW0et5XJw22WHKf+AV/+ip9twQvgdOPvAzEXBfOCWE39MbraiGurK4qV6YQK69eNQFbKcVz2xNpGbg6QtSTp+mliwFi3AHZaY1JB0ROuhIhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907716; c=relaxed/simple;
	bh=r9+AOLRFjFQYDmlGo6RU1nUidA/os8pW1y9nXU1lfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxUsaM6MJvPAl8nFY0kpioEx+Hd4Kmz9OTmyrhX+6QT+998R77DBrFOxBdaMq3cYG+jGsbuIlN8qPCTol9weo6K07axO/Ul/N7wb8loeJT5tLTwtttT8nr+pekqFPHy74Pyr/HRJxvaQI464cdaeaT+5Fn0/m6b5C+QbmBpBo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=p88GHPIz; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="p88GHPIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787907713;
	bh=srAaliEDGMeII5077n047iXQZy11pZEpc56pqzlQ+dw=;
	h=From:Subject:Date:Message-ID;
	b=p88GHPIzf7egJIWMrDUQMW9kCm+RL+YXPprxdTHdxO6kyEjYCacc49sL75OzgA8cr
	 O9SJlQBSjK3w5t/8iqJXVQYIv1uEQop/5ypgnymFee8Qg1mgVSnkOTHVSWj8Sq2JGY
	 pTH0dokIAtuR4LSaG+asVbOqfe5u2mb90KwwhZkU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.34) with ESMTP
	id 6A914E5500001447; Fri, 28 Aug 2026 17:01:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5278146292015
X-SMAIL-UIID: E7CCE3D0A05A4AC1B1F9E9A3F3B2E189-20260828-170111-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	boqun@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Date: Fri, 28 Aug 2026 17:00:56 +0800
Message-ID: <20260828090059.1895-1-hdanton@sina.com>
In-Reply-To: <CANn89iKEVEs5=K1Uhj_CHagbt+eV0QGernwz9EBFkLEZOB1FAw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 06:05:15 +0200 Eric Dumazet wrote:
> 
> I decided to ignore your rants a long time ago, as many others did.
> 
Aha another rant chance for showing you the steps to quiese syzbot that
reported deadlock.

[11] Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
https://lore.kernel.org/lkml/6a913c08.4d659fcc.734b4.001b.GAE@google.com/

[12] Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
https://lore.kernel.org/lkml/6a90ef26.27659fcc.2ceef7.0018.GAE@google.com/

This is one of my good works in 2026 in addition to catch your HBCs.
