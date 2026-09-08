Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025239E19A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897820; cv=none; b=hIWQCm4KmNi2Sc3SdbC43lGFjgIpm+U9x5N3G224NKpr/W+3fQ9PjSoWyMbMOw34klBwZSfPwBh8kdNPYPwjzGJXGKg02/5K9gZAi74ErerFg/e4Ipx93v7/A+DRCFFmBjVhm/gX+zQAYvOgAdz9zr+08Qi0ovOgV0QxTTglwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897820; c=relaxed/simple;
	bh=BhOybF4SM988jmElaY651UMA0ZJ4hoNXScR86uq4YCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTjdyGd5If/ValAeTZtk2q9Xqsn6tjdoUnW243hHdoHO3qwkVGf2nnSFTt1LQTA3YoY0kTvAOPq08q+tTZBi1RtQUBD6/gAsohC4e5iKTJmpbFGJlrY4CNyxMy13zujAPKCciWCKjGrylAPmqzjfChxYk7+WQPTzcs2Uujd/Vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIqcmaAi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIqcmaAi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so57010905e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788897817; x=1789502617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+Uf/HpFf4jiz8FoMkzGSbgKYbbCXOaImYMY1I/Mejc=;
        b=kIqcmaAiLXPtztrnc8o8G2NuJ2hMOXDX3MD5aQcaXfV32V8pd5/SVnbH/7Wysr9max
         xcAgB5hDA4xfkDU3+EKKu+upsbYb/Nblk5/xQuo1/yeiIaRGZrLe6KaxqDbiHyP8EO4O
         1yzzM7foC1ejhhO+WU4HI1uOETLDeTKT5l0PMa/9Tgj7CzG0lg2u4eqlG/pPo28kdQ72
         S663tmt3wqV/Ojm7F3K1Vf5+6JORquhsY8DtDbZDXYaf4769Ip/3/Cmsq1Vj0r8Vkfgt
         oaVVWMTxZ4nDpbsMbxCc05BDiynbSS3wPeBsckB950rxgw99rnqotJ/MrGsDXo1iknp3
         u6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897817; x=1789502617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+Uf/HpFf4jiz8FoMkzGSbgKYbbCXOaImYMY1I/Mejc=;
        b=XPzMwxo1H3ULS6xLV7OYlL+0ea/TOgjg80fs54CXCYuikQRMsE/zjWWLZ3zt26RjG3
         VQSnNoZP9LouSnOHTddYaVrZ166VrOprbLVWTcurw7kVqjgMCxlwnAg9KCDJ5KnwTlVc
         g4HkDgP7QGxu6T+n+MBSCS4GNaKovgTx9pD3/brSa0VvKF5cjvv9nDP2wfslOjVXagBT
         hi7RI49XoYJpL2y6Rpzhrz0+PnEH8lmigWRE9srNj4hr/o+xObLePGTXKI5b5bXlLIWG
         EpSGT17fiGesDXQbsfw9dmvOfRUUD3FBxeBp2r1cafKmWKT8Wq27fBbaTDVrxGrRFGBu
         JX/w==
X-Forwarded-Encrypted: i=1; AKwUvBy2hEOuvjmyTT/aWQ6M/PfIOOzJKKX0ejwDJBsOE5Z3NMWZ9fXkYZhvM89eUijWFkOGC2f1y3A=@vger.kernel.org
X-Gm-Message-State: AFuF++mTe2m+13GrpK96nwZw6d1rf8OS+COZ3AlGflu6nHOEZqN3Z3y0
	59nIy6Pzc7cWteNgi32hgkxpOXQZrggl4p9ckLWLTco0KNy2HYaKiMtT
X-Gm-Gg: AYBFou1QN7MHxEg3hKNyMrJXOcv+H1R/Fs63KcPA9eLFxnxz46PdLLfEBvJITHOOZ2D
	l3fex6foafhr0CEsYvQ9NA8+quO64EHaOpKgeS/2X6h9gs4lmpEALPOi5cP7NJI7P3Oo5ZXR25I
	iTqDoOEUd537oRSVoLYuA+k5m5gRDSandqBkDvsC/nJtuY0DwtsJkOdT4g+hRzizfrlJCis55sU
	7srpCF07NOh4wkePNncaYcvdMCr0mJx3BMgQZJAegADyhVxOhTj8nmKi1kCpNQ8LqR5Xz6Lr3Mk
	IX7raYXtTi4WG0VyP0sSpRXfH3dhmUxqwCuRrnocM7wFeD5T50XeGlVpE7h/SEhJcA5KqTLb58Q
	/JTavahaAYV8QHAb7mfJ6ntuLYOwoyyFAIWKcG+FiloOxLvHzJuKc1jEBdNFuwy4bWSKxxef4cH
	NUvmWLMEYT1/LWqLJYr9TimirrNOziTF8cnaG9sHwu7G3+cU/ZyQKyd3Z41/bX9Gl0kBaQMgDx+
	M7DZ6WOywssp/5dSqtNi9+PTY6/o5xRefGquxcTLquI
X-Received: by 2002:a05:600c:154f:b0:49c:fc6e:8cb5 with SMTP id 5b1f17b1804b1-49cfc6e8ee3mr317855475e9.25.1788897817212;
        Tue, 08 Sep 2026 13:03:37 -0700 (PDT)
Received: from arch.home ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm32503702f8f.17.2026.09.08.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:03:36 -0700 (PDT)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH net-next] r8169: use str_enabled_disabled() helper
Date: Tue,  8 Sep 2026 22:03:08 +0200
Message-ID: <20260908200309.533537-1-gawindlin@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded ternary condition (? "enabled" : "disabled")
with the str_enabled_disabled() helper from <linux/string_choices.h>
to improve code readability and maintain uniform string representation.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5415ff62a286..360df5284042 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -30,6 +30,7 @@
 #include <linux/prefetch.h>
 #include <linux/ipv6.h>
 #include <linux/unaligned.h>
+#include <linux/string_choices.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
 
@@ -6225,7 +6226,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (tp->dash_type != RTL_DASH_NONE) {
 		netdev_info(dev, "DASH %s\n",
-			    tp->dash_enabled ? "enabled" : "disabled");
+			    str_enabled_disabled(tp->dash_enabled));
 		rtl8168_driver_start(tp);
 	}
 

base-commit: ab217fbb9b2169ce677b09a66558d5c3adcfbb76
-- 
2.55.0

