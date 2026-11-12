Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452201;
	b=12ems+FN1A5wEUKE0lqSbwqxZFa4HFERUSqLFIyVPxykG7JlqqpFQQRGDxk8caOSSvfa
	 waTywi5bkY/jsFvElEbekvI01kKN2ihmbYNkwUsB7cXGzVj5ZZ7c9sgLsDjfBKfmhghYl
	 8hT680FlndFFmmPsCxTbVKPvG1eGUTn4eC40faHdW+Uc5dPtLB86yHYFxEkvEnmKVljrV
	 +y0JIy1OkEEfCipHGDzgzFjL4ww2065PJl1Ncc11EFhwR5Naqp/0dQXd6HI8EQJSihdcG
	 EUtGxMX+yUfuID9tVu3CdSwXBgbU4JxzFiEOOnwmXVgbp9pZrf0RFAkwAR+/szYSpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452201;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MjxgtF6os8jLZ0qgVc4c8Eu/oAPabDGAFty/2i1zZKE=;
	b=t+D2fgU6b5GGwwMBdmyA162pMJdCWl6+izYO5lcrtGv58A8/GKBL8CNMpcIsOS1Yq4Tx
	 6PwjwfDH76bK7DqEral94S+wToQB6XsPs0r6OcfUEB8aGSmV1EKjYxd1quXIGdct9qjy+
	 adWmHQKgv8O7NVg9M6dbbMLUdX3dS/XusNLMfEa1uIJHQO1BkT3zsLNd4c61UymRe1V3o
	 z2+a6u0FrAwuy5KFQCTKwnkWNxJFG9Fux5fF54+k1o3rRh7UYWiCPocZ2rzUuXqjle6/1
	 Ebp2dUBzPnASFLpE11FVPCltwwH8zgP08TaXidpqRoEThxoRMv/gxx2Xv31eolFPIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=X5217Fxb;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF3606A31C;
	Thu, 12 Nov 2026 02:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AF3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=X5217Fxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=X5217Fxb5GEiWcnK7rGbyQ1r27qLIw3/uf6gWZSOc1MzlUA+gX9x4t1khyKUpjUuXCRraUwqPcOUO
	 +WiufUizpntgrzotw5a7QivS6WFgkzAqMtW5WYAOPxDoSOD1clpMm6s2XsEfTdslUgI92nuuQqbvOn
	 v5Gm51kOqDM8Q+PY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af52adfad7-a9819;
	Thu, 12 Nov 2026 10:56:31 +0800 (CST)
X-RM-TRANSID:2ee66af52adfad7-a9819
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af52adee4f-f02e6;
	Thu, 12 Nov 2026 10:56:31 +0800 (CST)
X-RM-TRANSID:2ee96af52adee4f-f02e6
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maheshb@google.com,
	arnd@arndb.de,
	kaber@trash.net,
	dskr99@gmail.com,
	linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net-next v2 0/2] ipvlan/macvlan: fix local RX byte accounting
Date: Thu, 12 Nov 2026 10:56:17 +0800
Message-ID: <20261112025619.563195-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

Both ipvlan and macvlan count the Ethernet header twice for some
traffic between virtual devices sharing one lower device.

Patch 1 fixes ipvlan local unicast, broadcast and multicast RX
accounting. Patch 2 fixes macvlan bridge-mode local broadcast and
multicast RX accounting. The lower-device receive paths retain
their existing Ethernet-header adjustment.

Tested in UML on net-next 368fbf5d82da with IPv4 and IPv6 UDP
traffic: 26 ipvlan cases and 20 macvlan cases. The corrected byte
counts match the received Ethernet frame lengths. The external
RX cases and macvlan local unicast cases retain their counts.

The ipvlan fix was first submitted to net. This v2 targets net-next
and adds the macvlan fix as Eric suggested. Cc: stable is dropped.

Changes since v1:
- Target net-next and drop Cc: stable.
- Add the macvlan local broadcast and multicast accounting fix.

v1: https://lore.kernel.org/netdev/20261025014251.542973-1-yanxia@cmss.chinamobile.com/
Review: https://lore.kernel.org/netdev/CAL4WiioxAR1ZBjVJNgYfLM0hUwyHapRu+TAUzedpOpe0yheH3w@mail.gmail.com/

Xia Yan (2):
  ipvlan: fix RX byte accounting for local traffic
  macvlan: fix RX byte accounting for local broadcast and multicast

 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 drivers/net/macvlan.c            | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219


