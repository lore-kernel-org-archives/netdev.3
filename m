Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934378;
	b=Rcs+OxrD0s1IIjwnuFEeA/saFREx192sm1g31J0jJ934X/MqJZoTVlCog7P0kjviAVVi
	 q4Fa2p5/d6L1YHW2kS1uR+Oym8zCQITH9mSFQcc2Hpphjc8FOQuxLrtlaTBifgLiPrMR2
	 SsSZo4roXK57MYBLnOaoLGpHZ9qvPcmLO55AvmmB0wgzvbNq4TW0JS/MH2BmjTfrEFzL0
	 RvjP/eT/tNQQyiJlWKh4121lokl/6kOyHFeq/D9cvLhRbuYnbGWAXSpwwfITFnWCgc6AM
	 jb6FZRTFVu+ll+9KdNNYoA3YlVN/imJNw+Mtj372gi2+9Y1uzOzkcxrZlSdJXkQpWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934378;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFN7QdsDLQ4jCa9vD0JR+UWCPjLFqpbGwK2CZE9LN7Q=;
	b=CjBjyCaTcRmQsmbJQFcy4LsIqEOUk3MHd+l6/s1fesW9E2VO6RA4zOaex2Hs6cBQzbki
	 jIINPtTTPu3KTTycL2Mhj7wJVp5NMAZAT6AhKjY9ysfLtBzQ/JfcGMX5z6Gy3XpDlaSPX
	 4jTLXIatDbah/4wQ0pznX5aRfsaB8LkeTvp85m5iJQnWqfeQs4mf/Q96Ju0sg/Rtk3Tme
	 1JnD3zOYmcYPKc/Z9XvmirlvguNwE8kFuYlm5eOmmi9eeUyKQnQpI/7Lh7MtzyttYhiXl
	 AfHAJ5+S7qSwTxVS4sUEF4gVCGWgSaft5+iLe95BM7PQhomA+wwdh/MbZo9CcpE33sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FgImZkCd;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E2606A32E;
	Fri,  6 Nov 2026 03:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76E2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FgImZkCd
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793934368; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SFN7QdsDLQ4jCa9vD0JR+UWCPjLFqpbGwK2CZE9LN7Q=;
	b=FgImZkCd6E7D4QLeUEq7KLPuUJMtdg2oTdtirex5JYmt7O5pR9VzBhtadavbFL4uUSX4yVgECOwFhSt/NbfDD8RbKq9ayHzh2z4ALosHjL6A970AKfXn3aiyNxkV8YpQWAUMyuUlbMX8Z0DE2kTiYdRJ5KI461AByBlZl2LOK9o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07902923|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00260988-0.000500615-0.99689;FP=14554920093083864496|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxsfG3j_1793934365;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxsfG3j_1793934365 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:06:06 +0800
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
Subject: [PATCH v4 0/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Fri,  6 Nov 2026 11:06:03 +0800
Message-ID: <20261106030605.576584-1-liuc63@xiaopeng.com>
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

  [PATCH v3] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
  https://lore.kernel.org/all/20261105072147.3383565-1-liuc63@xiaopeng.com/

following Andy's review: 1/2 prepares a parse_mac_pton() helper in
lib/net_utils.c, 2/2 uses it in get_ether_addr().

The two patches belong to different trees: 1/2 touches lib/ and should go
via netdev or -mm, 2/2 is for the USB tree.  2/2 depends on 1/2, so it
can only be applied once 1/2 has reached Linus' tree.

Changes since v3:
  - no code change at all, the tree is byte identical to what Andy
    reviewed, only the log of 2/2 changed
  - 1/2: unchanged
  - 2/2: pick up Andy's Reviewed-by
  - 2/2: name 331a2d82bcaf ("[PATCH] USB: ethernet/rndis gadget address
    params") from v2.6.7 as the commit that introduced the loop, and
    record that it only resolves in the history.git tree, which is why
    the series carries no Fixes tag
  - 2/2: record that the Cisco notation and irregular groupings are
    historical and rarely met these days, and that the commit introducing
    the loop never documented accepting them

Changes since v2:
  - 1/2: pick up Andy's Reviewed-by, no code change
  - 2/2: keep the separator-less notation "aabbccddeeff" working by
    falling back to hex2bin() when parse_mac_pton() does not match, as
    suggested by Andy
  - 2/2: drop the Fixes tag, the loop predates the git history
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

