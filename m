Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951C43F4BD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976533; cv=none; b=p4n8ixUg49XJw0gCnViZfCHkhMx5EK4QgKgd866QzC6imKC2htM6nGi8J3AHRh+DQ6hJGEe57ptlEpCLQCfVr7zfn7B/9TUYFJdWERzYUqegUCKy4HMiveLY2nGJseNRKaMmaEILAIrIaBBDYA7AM8P++rtBtzkONysMeA3WwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976533; c=relaxed/simple;
	bh=6q5OvduezYDttcoOa+Vp3n3pmhhO/TNjR5O4tftm/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AButRP+rBU1is/RDBbfGJxFUFiaM63thuTGV+IDriX1gJRr61F2+27ESakDu8R/Dlx2clAvALQNViuFAwuB12xodX6Gp62qusvucGEc+zOrIquZpRuW77IyAOSpThP8XsQUeN9/R62Y5q5M9pf5TV+mMOizGuI/sDBjrp0o4BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms5BoYqY; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms5BoYqY"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8686f46e4adso2237370b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976530; x=1790581330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=Ms5BoYqYr5teC5rECBj2VncEItGwRBZjcJIzSWBqb/CMQpwGP60/+zvTcBpqMdIF0H
         /CkVjPSpRlNsUY62IdICXOnwrD/M5ldxhcLJqmnDXiXIVxrzL1BDZDOtlLVnSnDyhOq6
         urIc2PALgiWt1+GkUSWasHn9dyTRUarEcerH8fJbEWN2wsHa1XIP3lOkmnGSx8/N24N7
         E3/+rsc6YUEqnxLRg3bwIpmJaet+NB8au5hJ0u826lSIK7aMTRaDAZIx4XC8zdoqeVj9
         8Z2c8ZNxXFoqJz0UXbeFULBHQX9cU8jS15S1g2sMKBge7L7A2/e3Zof5wQyRqoga4pMY
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976530; x=1790581330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=Jg0jll7KaA5m2R9M6kdlJqwjNSaY3o5l4aNegGMVtzR55v4sJ7k0ERhuAvMtfqHzAa
         gZHARqRhgEmCrrge4khQvKNg67/QdK79Azh5sLdPnyVWf3wBj39Xu/0qz6wryUb0XVFw
         f0xx3ug9w7GNYsN3pUYBcKDMH6zRrksW+Dfd1A/RKF7XoUWwci3z8mNG3uC1tNf5s/wN
         MPoEGGO741ndAZ5hwKpkej7kTYnqMiArzlLa4+1NOiDcp7YdRmTaV3rolYmBRpHOSB95
         bngsqDIb8K1oBMXuu5yWI6cjyFbxCchBLCriQGouXsi/Qt8doimUP2mFyhPPNoua93I8
         7ErA==
X-Forwarded-Encrypted: i=1; AKwUvBxOnSJGHVLvfXqMv8Gibcd1L+lJvz+LT8FPiqeoLh9U8xEh1Rh7s3BUjNyhnCP0D9/P0nObMeo=@vger.kernel.org
X-Gm-Message-State: AFuF++nVaIC+aZPRcL0rfaz/WU3UjHju2Kjns0p7FOJ9+RbKWamYb+EL
	Z4fqX+DQrN3fC9SBGTkW74lu8sft/TJUu/y1pRTj6ldRPyHb6XSvlJhU
X-Gm-Gg: AYBFou3NbQbn3nHgnfzhgQ6JuXVtZiGdCpWjEjcvWEW8QpZ0tUM/FtzN4HYfyO6UvNf
	bvVeeAe9DoZr+5xIFZwUw/qNjhYvqq4O6HPa9bvPn3vBNic/HgDPlLbIqCrSOUw5W6I1DgcilY7
	UgXTWOberqyaWIRBLP0T8bDEeRQaIpCsMDnFCUsIc07oIFr3oNidJ8bv58VZvcgDUoJJhBr4LPy
	BCfrFXP1aRRxCYavOp8OGtDPfzgH86ezJ+tthqqCfMNna6umrdkyPt/wjKKScuUhdQkPdch2gPi
	PtygC0Kuw1ykKQJL+u/nGGUETF5xv7Gv85+EJu/OQOi9xag33dnTKLhEmlgvLT5wMA9qqhBKJJn
	8AntxZob6KMOD1AC5cmCCsxnlUuVTjSHD/18F7CHuYiYk3MYji6uGKpk6BIQPwDEiXwUSOsZor7
	eF2kGl4MaqWBMB7i5B4nCcMIB1/83ArynUWCRtmwLpZqltMjh8viQckoV6eGOmUHa2YS8NoAqtq
	juMx/2BAJfoeVLXgHGwn3UJQ/ePCSKoiQDPyz6FPb7NIe+d8cH0VLnHd+izBWFwpv7Li4C43/VK
	ehNjlmlZJg==
X-Received: by 2002:a05:6a20:1605:b0:3cc:2552:ddd7 with SMTP id adf61e73a8af0-3dd8c2ddcb5mr17987536637.5.1789976529965;
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/4] ieee802154: mcr20a: fix 1-byte out-of-bounds read in mcr20a_handle_tx()
Date: Mon, 21 Sep 2026 07:42:07 +0000
Message-ID: <20260921074207.2289391-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mcr20a_handle_tx(), the 1-byte psduLength prefix (lp->tx_len[0]) is
already sent in a separate SPI transfer (lp->tx_xfer_len), while
lp->tx_xfer_buf transfers the payload from lp->tx_skb->data. Setting
lp->tx_xfer_buf.len = lp->tx_skb->len + 1 causes the SPI transfer to read
1 byte past the end of lp->tx_skb->data:

  BUG: KASAN: slab-out-of-bounds in mcr20a_handle_tx+0xf5/0x150
  Read of size 17 at addr ffff8880057f7500 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   mcr20a_handle_tx+0xf5/0x150
  ...
  The buggy address belongs to the object at ffff8880057f7500
   which belongs to the cache kmalloc-16 of size 16
  The buggy address is located 0 bytes inside of
   allocated 16-byte region [ffff8880057f7500, ffff8880057f7510)

Set lp->tx_xfer_buf.len to lp->tx_skb->len.

Tested in QEMU with KASAN enabled by transferring a 16-byte tx_skb->data
buffer in mcr20a_handle_tx().

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 4/4 covering only the mcr20a TX SPI transfer length
  fix as requested by Miquel Raynal.

 drivers/net/ieee802154/mcr20a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index d01b277d33d2..d7e076397550 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -867,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
 	/* add 2 bytes of FCS */
 	lp->tx_len[0]		= lp->tx_skb->len + 2;
 	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
-	/* add 1 byte psduLength */
-	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
+	lp->tx_xfer_buf.len	= lp->tx_skb->len;
 
 	ret = spi_async(lp->spi, &lp->tx_buf_msg);
 	if (ret) {
-- 
2.47.3
