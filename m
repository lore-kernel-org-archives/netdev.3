Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863323;
	b=IeY/THHRfk6y5yja8Yd5IIG9SLMXSL5AUTnUwll8BWrosGZoy1EyxQLpFPVc0cc2MIeG
	 Wgt5K6uBoDB5P0GEIp2gOAPbOSjzCNsCCCpS3RntX8oJV4S8qQX9uaadvDerl9ejUU7DG
	 KTWL9HR1QbN2MEroCd+4ByHK+iz5LM9ADdyR5MHv0a7bBhEWYUlsF2lTo9n0VDCMVKie1
	 ZIjVWV29gnPOr4E1HcPbvEWMMM9+qaWmPyad+8IKixIOfkyrQci8y6+A7jAp0I3FW979p
	 hLoPO5X/zRnCDEfupgZHNC/n/WYDm7ilyKQ5MLgvn3P7qKAtjPTyDBI6JmIdjlP7Vjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863323;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LTLu+I3aouMczWmmEHyuqhA7vSrJ6hSqAiX0k5uFl2s=;
	b=E4q/EGS5TDz48GU7+L88DFPNJP70x2KXC13m6zHUz2QJVKJykWlfALrDHNzK5bpuyJbg
	 tCcwkegHtGJrV8CpfLZXmzAZOq7Mi8iLphmtaszRqmyp69s6rfh8F3mktFYiBhm6fnW+M
	 s4hi7Sugc7eFiVxfLC0NCUqY0j54ar/ycx4xrQKA2zB2VxteqPidAH58tAQbThMw+KonN
	 6aUt8I97NUv7TvPV5EAqaRxGuYeDNXBSV7rXgFa9mHxHNjfn4AJzfPj9dS5I91r6XGwUz
	 XDck6A6EmUJnV9TOXGyH3Zd3idMFxQmgJkS/q5Shu6JUSGdbeaxP/TXNRtiOEmzSILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GOumxeBq;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF82606A326;
	Thu,  5 Nov 2026 07:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF82606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GOumxeBq
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793863310; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LTLu+I3aouMczWmmEHyuqhA7vSrJ6hSqAiX0k5uFl2s=;
	b=GOumxeBqizZ9HhsXA63AIsGt8fqsbRV+mNQfsAoVcwCQQ0JcS3sauyxRk2a8UXu7ZDTimuG9RA0SZmgSbmHW+yDCo7oRcp34DwwZSbevqYEyjxvcd9+UHXv9BNK4eF1QZmqkvWOZFVQnbDR4dbADI8A/6Im0/k54XHYSaO7yDbg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09765808|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00260988-0.000500615-0.99689;FP=14482862507635871152|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxPfor8_1793863307;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxPfor8_1793863307 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 15:21:48 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	khtsai@google.com,
	fangxy@xiaopeng.com,
	Randy Dunlap <rdunlap@infradead.org>,
	dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Thu,  5 Nov 2026 15:21:45 +0800
Message-ID: <20261105072147.3383565-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

Rework of

  [PATCH v2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
  https://lore.kernel.org/all/20261104025058.2650911-1-liuc63@xiaopeng.com/

following Andy's review: 1/2 prepares a parse_mac_pton() helper in
lib/net_utils.c, 2/2 uses it in get_ether_addr().

The two patches belong to different trees: 1/2 touches lib/ and should go
via netdev or -mm, 2/2 is for the USB tree.  2/2 depends on 1/2, so it
can only be applied once 1/2 has reached Linus' tree.

Changes since v2:
  - 1/2: pick up Andy's Reviewed-by, no code change
  - 2/2: keep the separator-less notation "aabbccddeeff" working by
    falling back to hex2bin() when parse_mac_pton() does not match, as
    suggested by Andy
  - 2/2: drop the Fixes tag.  commit 2b3d942c4878 ("usb ethernet gadget:
    split out network core") only copies the loop into the new
    u_ether.c; in drivers/usb/gadget/ether.c it is already present in
    commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), so the defect predates the
    git history and there is no mainline commit to point at
  - 2/2: spell out in the log which notations stop being accepted

Changes since v1:
  - rework the fix on top of parse_mac_pton() as suggested by Andy
    instead of open coding the bounds checks in get_ether_addr()
  - add the KASAN report and the malformed address example that v1 was
    missing, both collected on a KASAN build by loading g_ether with a
    short and with a non-hex dev_addr
  - select GENERIC_NET_UTILS for USB_U_ETHER
  - drop Cc: stable: 2/2 calls parse_mac_pton(), which 1/2 introduces,
    so it cannot be backported to any stable tree on its own

One user visible effect remains: the Cisco notation "aabb.ccdd.eeff" and
irregular groupings such as "123456:789abc" are no longer parsed and now
fall back to a random address.  Details are in the log of 2/2.

Liu Chao (2):
  lib/net_utils: allow mac_pton() to take a custom delimiter
  usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr

 drivers/usb/gadget/Kconfig            |  1 +
 drivers/usb/gadget/function/u_ether.c | 18 ++++++++----------
 include/linux/hex.h                   |  7 ++++++-
 lib/net_utils.c                       | 17 ++++++++++++++---
 4 files changed, 29 insertions(+), 14 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.50.1

