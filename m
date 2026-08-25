Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2B3C109F
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639155; cv=none; b=H+MTovnVt410xzrj9FV4buJI8pBkUUCQBiN2J7hGru04vksvYQG5/oqz5PP4ddaOA4eniNJpTYV0UyKmVI3xO1GnFRspwl4Gr9PFyj6n8MYDt0mrHgNeZgkI02pDGpCLl1DotvCd2sqi305n+nol8mKKXol8GD5Xn81UxE+SOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639155; c=relaxed/simple;
	bh=dUMSqSVcFGMunPYmuhY7MzZq9ngfehg9Fdxl2QXuk10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbT2tcXueYwarRbR3fi9g3I1UwWnMtTatlaU/V1WkyxZW2VWhsB929aU6kcAxLd2Gq3bn3UjeQAhr+G/LaeAde5rnw+M22Zmq8pmb15cBcpSWCo63CZRme9Nlv9uSQOeszrszYJ5a0xpg/19aZHFqtRDJNKBYMGztiP7f+fo5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CE1b/lX8; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CE1b/lX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787639151;
	bh=7bAYI7eCw/MYQdq1y7RwqclS0q/FhTPCE9GWfgseLNM=;
	h=From:Subject:Date:Message-ID;
	b=CE1b/lX8Yx2SMuePn92O1U5EPXx1IteXtcEuaOHhavvtOWpEIRnR3427ydCb5nM7M
	 n8L0FXA/FtfkXTQnwBVq+Wa+KLeEU3vdVN/m12HhMQGwrBTDh7RCfPL1xEslRsWk/O
	 aJnwIzqH+AWXW9jpw5suYlQTp9q9tPxncVjXFxXc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.33) with ESMTP
	id 6A8D355C00002E70; Tue, 25 Aug 2026 14:25:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3155476685210
X-SMAIL-UIID: E802616010994DC8BD3B85AEC7EE0424-20260825-142540-1
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
Date: Tue, 25 Aug 2026 14:25:21 +0800
Message-ID: <20260825062523.1481-1-hdanton@sina.com>
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
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
