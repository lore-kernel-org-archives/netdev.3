Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA14A99A8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364386; cv=none; b=QtgSJlnHyv2b130i0J852eqqmnd6jM9kj2oSW2w6uUzkhdvTHs9cnCwOyFpNptUazN4QXVYCiIQG6yEJXPpqgMQUgKrNnW7RKQ5Iz/Xn8sG2Q7tdjCi2NZyI1GsWMGmAJ0k7c6o0JuNY9sHGFr/Rbzdckh0v5bMEHcVQflA6pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364386; c=relaxed/simple;
	bh=6MAfs2y3VwcdK/z+jm64GnqxD/YmkCOafRbcTEg6efA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c01KkfcWH/c9SmLEbwbYdb9XmbbBb9bheBQUfmKkCaIchDZ+PUYjveDpOl4THWMY47RbQAXpGEGzvcm/7aXOfwmXEodA465KgdzhoA2mTRjvrsa5PDzOanbZzOhV1CfYvpn+edA4NfCIowd6SW8IwcRf+rYQSEBuaGUu2EB8tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXdUqObA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXdUqObA"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso991212a12.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364383; x=1788969183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJjiilOnreU5ZYIm7PKJOLTqjb9QBJthxd9KEc/39Ok=;
        b=QXdUqObAQnbwD82KnPUo4idzS0caVDHlIgTB84x9LSrlVr+R1vLtf0PC82WsSjdh13
         RPRefYMQcbSU2p6Lk4S1uka9yx3xYncZrrl7fEc8XpoXgG95b79bWPXVqTumPv3a4agy
         wQynb25MroQs0KTXGndcwJdjOdD2SQIfaoUuUzA3OyahKKlGTIEfYv6wlb9uevh3fXRG
         MlqIFofZhgCXM5W/A8PUjfwGN9VcLnbATFGnqEXZvYRwoF4eEmKIQ2vETswvraAs2IF+
         OQgRpuPVEiARWHk1gkxG63U1NHRQkD945PzbCrlozTmgG++IT/xalqhY0iWPUkgeghyQ
         05Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364383; x=1788969183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJjiilOnreU5ZYIm7PKJOLTqjb9QBJthxd9KEc/39Ok=;
        b=AHqhdl5FbEv+DHqGmQfhsGMgUVr+8RD9pGrbrqXIaAS1V2erYFA+QI658ZttGMG/01
         L1rI7LFfqU+HkX+a3WquU1DDEIXJnmgsbou3nXZ9jvCzamz11h15MG4MiUJPqr9QQyi9
         yw82642QJ4TRNPZCyh6sPcGpg3dmCYyJSQqdTqw9x2I9YG9zKkEGjalUpIydg6KXQ0ID
         QAkxcLZI6npK/I77TeacYK28/+lFBFwX9vlRkEd3+ILx1g2FUU9xakj9wg1HMGhLcMSt
         bEjpC1JfHLmCqQa+sfIHeUb4vlFsDNns88c4/1bcBx6fbjZvGEGFTZlE0g2rcS/1KNQ7
         ymPw==
X-Gm-Message-State: AFuF++lko54Ym+7mxC3LXAHHHbkmJRG5Zcv3WsRAv6oH2CwYFE7Z6sZ+
	olsiVzG9c4DTMhw7pC1t+9PJF1qtG3nioeMTbCPt9S/TIRyiMEahl+vy
X-Gm-Gg: AYBFou0Ip8Iv0jp/BtwxDWGzz1HolzrcJ+E261DoSke/YCKHkfuBhPYryD8Gev+5GPq
	ubIvoeWE1VjxsotxxosQckblWG3GlICqnEQjs1u2fXYsD4K83R9Ffg6vEOKgLFAydyklAt+SYhq
	bgIEofz7zxu8DcwoLhZEUT4zyF+1Nvat5xC0fRwVjmjKqM0hHEZa7qokAqigEMS3J3EpjC4+HN9
	dR2qFemz6GzEQGMTog7gKO7voOGXrJECmPYVvb/DoZbrhDi4keKsG3T1Ut7BvBPl1VTc0dLeDhE
	ztlB9oiMwndwHSWqndvLdPbTzYSZZ4cYcr4APO9k4y8YoWVXTcT2u2zp2Ger8vE/gPRGh+uSl5L
	j8rV6LnPR6kzKfLg4P14FeoUY308OZlP3RC/YcXbq/qnKkkkt76yNpYFKV4INufBc/yI1+M1avj
	39dFMl0PBa9muAfUdf6GUrkHr9WnD02kkuBSiZM+KtR6oBvhAGy3CG3ObAbhQcU48wx2cVtm7GM
	FH7Y5kTkXUsLVD7lHn7
X-Received: by 2002:a17:90b:164d:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39aedeb9aecmr8965073a91.1.1788364382919;
        Wed, 02 Sep 2026 08:53:02 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1448esm1683187a91.4.2026.09.02.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:53:02 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 0/1] net/sched: defer qdisc freeing after failed creation
Date: Wed,  2 Sep 2026 23:52:30 +0800
Message-ID: <20260902155231.2149915-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the qdisc failed-creation lifetime fix posted by Kyle Zeng
and David Lee [1].  The public reproducer is available in a follow-up
message [2].

When clsact binds a populated shared ingress block, ->init() can publish
an embedded mini_Qdisc before qdisc_create() completes.  A later invalid
TCA_RATE makes estimator setup fail.  The unwind removes the published
pointer but frees the containing qdisc synchronously while tc_run() can
still hold it.

The fix itself is unchanged: failed qdiscs are retired through RCU.

With the public reproducer from [2], the vulnerable kernel reports a
KASAN UAF in tc_run(), with the free in qdisc_create().  The same test
completes without a KASAN report on v2.

Changes in v2:
- inline qdisc_free() into qdisc_free_cb()
- use qdisc_free_rcu() for normal and failed-construction teardown
- retain Fixes: 51ab2994c387 as requested
- credit the earlier security-list reporter

[1] https://lore.kernel.org/netdev/20260805102505.740806-1-david.lee@trailofbits.com/
[2] https://lore.kernel.org/netdev/CAC_etQFk%3DtGLvbHPmQwOyrYWgRtDru3dSw4T7sZ-9hvVMy_J-g@mail.gmail.com/

Weiming Shi (1):
  net/sched: defer qdisc freeing after failed creation

 include/net/sch_generic.h |  2 +-
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_generic.c   | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)
