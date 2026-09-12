Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4C233946;
	Sat, 12 Sep 2026 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219147; cv=none; b=eo0QhMmmEBYpfiPHkoRWLu7kb6rbt2dtwf876/oJEH3jp0ricN00hDJ1nlU1N69H91j5yB/L+bZu4k/3xQXnnWZfpO1A56uxb2up6cS7sJjtjwgj2RPjwBjJYgiw9vcJ6E/xEE0VFsxAYugCgA/QGNkjORYnRNpzCFGJLjZPSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219147; c=relaxed/simple;
	bh=+MgUTUWlSHdHdI+8c/0oVNHYsDAGpfCsPIRxe08aRsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqPkPeTdvylGVkEDQ9j46zd44GWwfVylh9HNghn7E/17Vfk/qKdU3vHSQK+jzGQ79O2MrPTlfo4BZjADnkstM/Dd9wLzA5kls6yiQ0Bh/rtVA7Lx+iJxnkHMJ0tXG6BaCmuXd/V2N6PjbMTYSXb3vkpin7j2VLMVZLsvFS2El+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=cuV6cNiK; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="cuV6cNiK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789219136; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D5rvoIF6Bi92T/DUDS1w7bWkDEeG7ZF3OvsRw+aTjMo=;
	b=cuV6cNiKOEdhG5TPR3uZZsE3ivM46aclMhAv3DIS9J3gHktlDoxhBrywZqVQNoHD9NeF5vABSxetLCZ/PKsFBhJwOXDOvO0ttkQQsQsjootfWSu8nKYMSvOPSatHpFvNcct+O90ds9iaZU2sixnzasUeluYNZ8ItFeKXOkuOP2E=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1302451|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.116611-0.00731119-0.876078;FP=12031672803178159555|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jC..l7g_1789219134;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jC..l7g_1789219134 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 21:18:55 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: David Heidelberg <david@ixit.cz>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH net 0/2] nfc: digital: fix two bugs in NFC-DEP chaining and frame handling
Date: Sat, 12 Sep 2026 21:18:50 +0800
Message-ID: <20260912131852.1651462-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a guaranteed kernel panic (skb_under_panic) caused by
pushing protocol headers into a chaining_skb allocated with only
1 byte of headroom.  Both initiator and target paths are affected.
Switch to digital_skb_alloc() which reserves the same head and
tailroom used by every other send buffer in this file.

Patch 2 adds a length check in the ATR_RES completion callback
as hardening; the downstream handlers already validate, so the
practical impact is limited to misdirected dispatch on stale data.

Liu Chao (2):
  nfc: digital: reserve proper headroom for chaining_skb
  nfc: digital: check resp length in digital_tg_send_atr_res_complete()

 net/nfc/digital_dep.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)


base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.50.1

