Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760672;
	b=lyGICKSQL6ceAGbDxNsdLKsyUkQ68u/K3C3qiWpHO64OoKdRE92+QNZeq6aVmeAlTVLk
	 fIEKL3zkSeIfPah7Xd2a5xHIh48/bVlzZKUvODIZo8aadGrpw/5HPcDJ2NUg2Ym5yXClM
	 G64G78CGsha+NnJkKq3MRxy5hE0GtFN7uZTOUtLWflCMDGxs2ZYNJU5Y4yXuZGGGr3Tfj
	 STHNA6Dh8PXNhTqzGn1hJejFNsjwGPvkhf+6aUj69NLNA87bPBmORvVTVohlSqG7Sz4o/
	 mOiV5UTmeECD38VWoWPxkcX0gH0AQfRESw9wGlfBg7J+P1LUmdShLiCnGNIH2cXp9mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760672;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SioAWEYfRCFZpwPbRZU0p2xEMvbLLXbeW/x6ieH+PU0=;
	b=rxMYwxoNGr/TxdbQd+EI7xAvszl1sNLq4BMnHA/NAy+VHyfilE0gZ6GYm21jmj9lSj9p
	 rFOdlC3qPjAhtJmhDzZta23J0qv4VtqpSGuRi5x9mU7DOe0NDpDeQGdtrYbcKZ3q4Q7Bf
	 ZseP678o1pN41ocLuyNS20kyS4T7S4fW1/H6iE3BE4oRFJqLa/ZTZGz6bSw+2x8TIWZbD
	 keN8ccjCiSaePSpAGw7oUrxAVxYWF/bIRkXuXvYIIKnvzKVWinsaymkDJOyPvWSm3Y+N+
	 8g6ZRp02z+yvbaBwBDBzJOI05Z1jiz3F8NIE1jlZL59kYIfixg81p2R8WIM6BMR/fhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=fO9S6by2;
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08C606A338;
	Wed,  4 Nov 2026 02:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F08C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=fO9S6by2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793760661; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SioAWEYfRCFZpwPbRZU0p2xEMvbLLXbeW/x6ieH+PU0=;
	b=fO9S6by2gm2rDiabX7QGHYy7NTnhutUQtBgc3dmTnrmKjvWpZLWodwmyP6zku4hxRNq2YdQcNC16Ykyjs6y6NztDnCoGyhRoiT1n2cO6A3VIo9vcnQaTmSHPBNh686bc13Ocl8lldh6V9Nt6tILqdkJfxxdeVI4jCDDxOm8guCQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1425388|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00365155-0.00040029-0.995948;FP=14482862782513753520|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jwK3XJA_1793760658;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jwK3XJA_1793760658 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 10:50:59 +0800
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
Subject: [PATCH v2 0/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Wed,  4 Nov 2026 10:50:56 +0800
Message-ID: <20261104025058.2650911-1-liuc63@xiaopeng.com>
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

  [PATCH] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
  https://lore.kernel.org/all/20261023110113.2969708-1-liuc63@xiaopeng.com/

following Andy's review: 1/2 prepares a parse_mac_pton() helper in
lib/net_utils.c, 2/2 uses it in get_ether_addr().

The two patches belong to different trees: 1/2 touches lib/ and should go
via netdev or -mm, 2/2 is for the USB tree.  2/2 depends on 1/2, so it
can only be applied once 1/2 has reached Linus' tree.

Changes since v1:
  - rework the fix on top of parse_mac_pton() as suggested by Andy
    instead of open coding the bounds checks in get_ether_addr()
  - add the KASAN report and the malformed address example that v1 was
    missing, both collected on a KASAN build by loading g_ether with a
    short and with a non-hex dev_addr
  - select GENERIC_NET_UTILS for USB_U_ETHER
  - drop Cc: stable: 2/2 calls parse_mac_pton(), which 1/2 introduces,
    so it cannot be backported to any stable tree on its own
  - drop the Reviewed-by, the implementation changed completely

One user visible effect worth pointing out: the old loop also accepted a
separator-less string such as "aabbccddeeff" and the Cisco notation
"aabb.ccdd.eeff", both of which parse_mac_pton() rejects, so such input
now falls back to a random address.  Details are in the log of 2/2.

Liu Chao (2):
  lib/net_utils: allow mac_pton() to take a custom delimiter
  usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr

 drivers/usb/gadget/Kconfig            |  1 +
 drivers/usb/gadget/function/u_ether.c | 14 +++-----------
 include/linux/hex.h                   |  7 ++++++-
 lib/net_utils.c                       | 17 ++++++++++++++---
 4 files changed, 24 insertions(+), 15 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.50.1

