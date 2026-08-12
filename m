Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1D340406
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514864; cv=none; b=mOd2c6oPT5jyf8FMyEDbcz1f9KMY2pzl7hRBBBtk06LCT/2hcQ+sCygvIaE6UpvILJvUqxwZNJSWQ64XImuY+dUPw3EFLrwZZpQoCI6hsIXrzVqvCt/sRqmlMdSm4nwIsKoldOD1e+/R7s4WWnjjoPszxceFgtxUOe/I9lQUsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514864; c=relaxed/simple;
	bh=VXPqmmbzfn+RvfwbL6ygzQo0kyt9LdFzU8OQGMNFM5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1trdAgJJpXWDqdQE5aT/WfNk2VTW0p4vK+WgjM6U4GwQWjz4X51LvWY+ywQqpI5VeTM2yLsC0dLC43xHqUKt4O2MZ0qw8P/GbbdGcmT26nGPWexWQhZieC0mU0ppj4eWdkGM2jvH8KDPzN6DiSJu8++qKwurVy2YP3zR1zNu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+VmkA1L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+VmkA1L"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f633e6058so452191f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786514857; x=1787119657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Cd+LEEyd3TXyxLex7677AjSY0WWkR48elXEAfm8gqg=;
        b=p+VmkA1LzLYsFf3pj0t3lWJjTkgaosYQE9wccXmkqVQF1LcYKMKs+2BP7W9jbN7co2
         SQDToOT7uaZjDgX/cU6f1zOzCV+oS36dnJzwNmdf2AbONdUDz1kDPI5SBwmLS1OmKFrG
         mAmQKt+iFdhVbA330YwDDnVKj4Eow5aondfctIJUGJv2xT0TI0vDi/Qd+oq+NA/XdjPp
         SZ0aT+PVoqkRsAgOuZ3Snzt5KiPce3zqbPTAp3DGVhevXhd87zIE9i5zPN5odAsbAFnL
         TKYabIZoTmDc5CfxcmksjSlvUGbxapVzGsa/gTJXQ6z563m5+HPmXvYQ176oej6NuYO7
         TzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514857; x=1787119657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Cd+LEEyd3TXyxLex7677AjSY0WWkR48elXEAfm8gqg=;
        b=kHqvwK/W8sLrHXGf1HX8zInzDr+Xw0N/hXFFpqlnslp5tR2lWMF3sEWJltmpDfpSeS
         AvCzv9MRe6CwCnohFEt1bxaKT4CQL4HG+F9XhxWAg2zo25FNY8moyWTO9bUM6yqnTsQz
         /mOqv9ZkSWBDzBhCqQZojdsOq0B6/Jbd3neG/bxQucSTV8isbeR36WPyf+AGCdvMlkhu
         q4k8pbNI/51pGJJf7RKKEUfCpW+shD2ajNfO7AO3VABCDZi9o3VUH/tgIrTAZ2hTkpV5
         SJewkjLU4OYQ57TLu5zU5SD/J3HO4mKJ+nOaiVinDjfL6LZHPFKT6hfabHPAva2KOerB
         VkMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpj8hX1fUzEFYmBe/mmyrj/0NfkpNgve4y1e1fukOCgd13E/VyptqxwRA+SVUTn5IC+Q1ClFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqynt4deKJEl2g7sHhflDroeTeEaKgSMuZd8GIzKXliDyoAJdS
	E9nrYTuY6x/vmLFgcatzuyBC3s0b8wfXRWVEDuZUpityWaYSxeLS/WTd
X-Gm-Gg: AR+sD1152DzptBL/B+Ab/OBwVBxQCbYU9OqThnRo02d1g21uTHU3I352suz04KRpbhv
	C/0ZeN+ZIwBuG4P9VPgZ81B8TQ2lg7TlHH3Ns4TrKAQmPa0KDWOI/rHKdJbLAe0W4TWK80qZqbx
	6CO73+x/6PtGnl8nRrcYqoVAdTXtkowLE8s9d+x0pvwhHJYNdtCTei4E18LqAVD9xqvWYU0B82k
	jpSRlJOKWRr+5bDxNhEpasd2+4lRRlxsrpJcB/WPyZN6s5H3PP5hUzFLz+iwH7g+ddb3wcFL+BB
	rG6b1AiHhcVaIE2HGS/vjdygJmaFOsTeto5ackPPoeSxSmDTuo5hMXuUXZi68Bwcz/l78MbozZV
	VECB7P5NXfBeYZosbPIbc5SACJH2RUy1jw9RvAysS5fA0uBZkHHA2s7ixlsmez6nXANerM4UChQ
	HvekAV3uwgS9B4eOdmsFTK18CGjP3DYQXR8xQZCbkws4FIyVAOwPEePfQMzNOGJUe3BtcuMTfc8
	r+bEkgjanDZRuDoeb7mefAFfV37zSMYCbBAxrMfu2zbEstDTPc8ak+Gin5mutazClraEg88JX8L
	fGU+d5pcjI+G/+YOAa2mzfIOlmZPwlTdk0VYJg==
X-Received: by 2002:a05:6000:41dd:b0:47f:c62e:9cca with SMTP id ffacd0b85a97d-4815290583emr3188068f8f.22.1786514856838;
        Tue, 11 Aug 2026 23:07:36 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-095-117-170-147.95.117.pool.telefonica.de. [95.117.170.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4c10asm4168555f8f.20.2026.08.11.23.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 23:07:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] octeontx2-af: initialize lmac_bmap in rvu_mcs_set_lmac_bmap()
Date: Wed, 12 Aug 2026 08:07:30 +0200
Message-Id: <20260812060730.6181-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rvu_mcs_set_lmac_bmap() declares lmac_bmap without initializing it and
only sets bits for valid lmacs with set_bit(), which ORs into the word
without clearing it first. Bits for invalid or skipped ports keep
whatever was on the stack, and the garbage is stored into
mcs->hw->lmac_bmap.

Initialize lmac_bmap to 0 so only valid lmacs are marked.

Found with Clang's -Wconditional-uninitialized.

Fixes: ca7f49ff8846 ("octeontx2-af: cn10k: Introduce driver for macsec block.")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index d98b49f47970b..fce22e314cac0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -856,7 +856,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
 static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
 {
 	struct mcs *mcs = mcs_get_pdata(0);
-	unsigned long lmac_bmap;
+	unsigned long lmac_bmap = 0;
 	int cgx, lmac, port;
 
 	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
-- 
2.53.0

