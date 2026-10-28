Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183056;
	b=zH70sZ0NCXC8XAXfbRoFN/MDpnxovF8SxfIETfgA0kuyDqzxYrUDezfO7V8UvvaBagFZ
	 1SG4Hr6ZMuHB97eMy5GC5dUQ7dYwPvxxmd6Rw/Grfgr1nuT4aNNhdDLhj850I7uhCA25E
	 9EiN5dKBr017wDaEF9JqzgjcBfHH+4LrCMfxLEmAGKyy6NfSU375W0nKruHEqRn70ceQd
	 dvLw2IfMDKwfZUhF1RfWeP/CsFh94Vu3SEReVpeqQUpy7zjGTXXE7SV16a1/BCLIURycD
	 al/9fZc2QAlHcBOfI9pJEE51xLdRNxTrwX4XIE0T3C062CftF9vsWjpcQ4P7jSWCq/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9TgQg4UpHv2Lq9L9q/Umb0LXQsRTilJXVrrgSBI6ObM=;
	b=c3S5aFgYsEJdtN9Ms9LgQA/kHc7/UiR+OhZoWVBjd9eEQkJIU9JSvr4Vpw6jnVgJtygU
	 3c4gOGBf1mcbNV0kMMgKBbqsH8L5VEAvzaQYkq1rWCVhlAGdtQUj89HzfHoY7zSiGTwSB
	 l8uRYdLGIWa1CwiP8W4tv8gy/pzhPLv3NdpxTcEAwm6EByZfAfQ2aK5EgS85htvERasCI
	 3yw3wqrYfwqeJFEIc0AfTpUAVUJ8bjxgAdutJg4aJHLz5kghDKESj/QtUNLuBN7sgOhs5
	 bUiznr73+TuQ096Z/Hq3SaRhHk0Yy3Bc6HnwJUIlyuKomlLlAFJ41NK+22vR0aJ5xKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oClVi2ms;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A1606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oClVi2ms
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215344409so1454185e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183054; x=1793787854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TgQg4UpHv2Lq9L9q/Umb0LXQsRTilJXVrrgSBI6ObM=;
        b=oClVi2msMtbkDKGF3IDNcX4Pj5LwShKJ9gqtFEHTknJmKVlgYZzYTxyL4sZwhkuYhk
         BeKovhW+0CFNn5LuWu0TGDbTN0PdgM/qMMY2fH+wVX3FX1qJkPwqI4klxLLd3XS9tCYx
         C7475M4Lif7aUj0XqgbpWXZMCaqS/QTb4dng7a+LG5m4Ku7M6sZoAqdNPVyMf9p0wo/9
         9azWi3GJXdc/Wes+ouoG179+mIs9YExUeiHgVdKFRxLwbJTA8LfrCTRY8rYcSygIojKU
         ewTjvJQ5X9G5oYbJbTVoogFBF+M06dY2XvLs7VU0pmJAMqw72zJVtGGyjKktPAEfUhHK
         U6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183054; x=1793787854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TgQg4UpHv2Lq9L9q/Umb0LXQsRTilJXVrrgSBI6ObM=;
        b=TsXF4VhAmQG0EvrmFGq8e5rT7exfQYTiKrLx1NP1uvbQNEMQJpAyA3n2O55eFf4gQc
         qfRJMbWhkADN3T58ppICn8LJkjoKv1cfOTOMDpMsWcigQCIUHLnua9WlScxKR7eNpzwy
         MS6i77KDwPoXAN2Oui01ABRK1mT5W/4qenvRBtVzHLSLPd5Qy/bsMkOa/2BziTo8XUrK
         y6EO4ZKnXkr89/Nefxdf7lVKrnO5E3QkFSPMLK5GrDCVKa6Beja5HWq9stj43OWI8M+c
         1AKuXeDXKlAW5mYHl5YqyC1iIwiJxX9VXDXb/4ChY9MkQNautodzgdxtxVqkpZGU2isY
         ez4A==
X-Forwarded-Encrypted: i=1; AKwUvByoCyHJNDCB58Nsjy1uopBcR6PFENoE18eeYbJ/oU8wYohFt4JiDuBPUmQCNckxudx49eNm0fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXs1WEldVj9yuQq9cu6aR+xth5CabhcZuV9qNbUIQnamyHx3GE
	fjTmM7SJuyNdkNGN08cRdMAT/Ocuo5DkhCZVz+ShlScoewIXemPRu9Cx
X-Gm-Gg: AYBFou0RlrSLLUkLPZPdrd60DLY86KWs/cMYUwTgYA7/WlYgqrwCdBeONdMrxJEypPJ
	VanWWeaiR8xDr+QZBsASxKtgSs2tDFTvpi4Ywjspl7tFowpwoutvHU30F8762QSBjURoix/pakT
	z+aVMTaVo52WDhNXfJTqzsJrioPy1XXvPly28F0+vIbYDaT4830SZyhSUr/0YZFt5lxPaXr9kIc
	QXA0Mq5rDtmlUG32KgOp5TqGlRqZ41VZy5Nmvp02UDAkp6NRcHrOsg9N1xVTBlGgCD8ln+FpHf+
	LMhS275hvh1WtmXJEBQKK0phsrIdE4D9Dm+QWzvmdYW9vDpjaTMGdUufaq6SLIv4dUrw2T5uPYt
	mteSuiRYqYXI8XTO70lZDmzN7yQf4T3+tj4t9tzmdKVpgN9ptUl/fRZ89G3YMchu609EiktIe2w
	DEq8qH6VqChW5XxEQVNwd77XOFOc0+HfG9OBWuf0fYcUQ7ylUgQtay7/OgrE3k+oEyfEjqOYDiV
	YIRGxzjIqlgJekqNUIK0bDO/mo5j8ANr0wJct4kCizkTrbjsmBlBqQ0C2UiPn1NJzWhPrwj6ilg
	ZTEinXDqBy5b4rXPdBfyilc3kepPrEqvqnavKdXVSYrPgFY4M0FSpXZNvzD1oIV0yCyiRn+0omZ
	xj5s46do5d6YeXTbo2SO1Envk+o/Es85OmhpX7p13Qa4=
X-Received: by 2002:a05:600c:4286:b0:4a2:6ef:d1dc with SMTP id 5b1f17b1804b1-4a965cdc67bmr23985595e9.1.1793183053902;
        Wed, 28 Oct 2026 03:24:13 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a97c9f150fsm32656435e9.10.2026.10.28.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:24:13 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:QCOM IPA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: ipa: Fix double free of the interrupt structure on  config error
Date: Wed, 28 Oct 2026 11:23:25 +0100
Message-ID: <20261028102327.28263-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Since ipa_interrupt_init() allocates struct ipa_interrupt in ipa_probe(),
the structure is owned by ipa_probe() and released with
ipa_interrupt_exit() on its error paths and in ipa_remove().  The error
path of ipa_interrupt_config() still frees it with kfree().  If
ipa_interrupt_config() fails (called from ipa_config() via ipa_setup()),
ipa_probe() unwinds through err_interrupt_exit, which frees the same
structure again.

Drop the kfree() from ipa_interrupt_config(); it should only undo what it
set up itself.

Fixes: ad1be80d7582 ("net: ipa: introduce ipa_interrupt_init()")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ipa/ipa_interrupt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 131b9cc94201..17cefd6a0b18 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -260,10 +260,8 @@ int ipa_interrupt_config(struct ipa *ipa)
 	interrupt->enabled = 0;
 	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
 						   GFP_KERNEL);
-	if (!interrupt->suspend_enabled) {
-		ret = -ENOMEM;
-		goto err_kfree;
-	}
+	if (!interrupt->suspend_enabled)
+		return -ENOMEM;
 
 	/* Disable IPA interrupt types */
 	reg = ipa_reg(ipa, IPA_IRQ_EN);
@@ -299,8 +297,6 @@ int ipa_interrupt_config(struct ipa *ipa)
 	free_irq(interrupt->irq, interrupt);
 err_free_bitmap:
 	bitmap_free(interrupt->suspend_enabled);
-err_kfree:
-	kfree(interrupt);
 
 	return ret;
 }
-- 
2.53.0

