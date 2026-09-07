Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D243F085
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818097; cv=none; b=Lz12s/OXMD5Fa+zfwGMQFJfM7lJo4Eis9ft24HO9Jxb1Pw/22ZT6JcU9xqSafyQz3jBehYVBvkKi8nLUD06t2FlhO1WEycBBMOJgcOpPnBlEH+znLPh2XmdM7x08YC4FM4uMzNNf7NWG3vpElvzYx4ZvotSaFD/i6YZTYjTvSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818097; c=relaxed/simple;
	bh=UueUMpeCwNeGVdy3GJf5lm29xyeCkwc/aGA+P30mwdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa1M29MSqTAhFEWRASAwECtsL3RP8h18S3VtXwo/A3T9j+FhUBGi6JgXEPZii/KJfh2m8NfeMuuZp2EMhBuxpaue7Fx6WJKeacP3X7aaW0VARM1leJSl399MYeIGOVL5rMF31MS1/KYf68Wd82kN8SNc2mXVqlcjrliRZxS6Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j73ZnSGr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j73ZnSGr"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-86fbd1a23ebso28152557b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818089; x=1789422889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
        b=j73ZnSGrWL60KlmfspddoXdvmb153n0+llSPhJJy5CQ5dPoVj7T90b0b0Ifx/3GKQa
         7wbdHTPJ+HpGPwa8scBxlsxEctTL81MSiLHMQ3aD5s5mGxIuRAiNHaIDVSMmfn/G3Y2f
         EulYrEOSlZ4XO+zfRFhYfT54W+pDT0OrUtzOfHukN11SbDrhcs1FLl7kPxZC2aws8v04
         PpUqkZMsm6yfx03LRUUABGR1g7deHfHKierqt3ertUQTVeZwzJFQ66tZ3ByF2VJPHv4z
         +XV8VaiW23XsFrQTGNWmkl/xBGJe5cy6WMVJeX04vwJwgTgT0u5CFLu/LQyWRdECsIjz
         392w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818089; x=1789422889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
        b=lLovX6F9xomARqe3Z+wEQ7Y0+PxrTSbbQqF3PsXf5tdMIiA5dmKtJSCh+FTiD//2bd
         tHSjP5yWa3LRxU3YHLdFMz2x2frq2yhv6b0OUAqJR87+qWmyuiYvNUADlhk8CCXo1t95
         O43s9dlmkclcEOkLd8fl3nZrPLXssWRQabTupXEvxht7c0nzfO5WQDwR7IW9rlwusxjR
         JC3dchakrPY9aErIy8U1oZpRerJcgSifyHD9SWg2P1VXFxn6AbGQhUcz9IDocuL+QUPR
         08WXVQf56XPmrUlB4+g/MYgi5chnITtvGFzfmhi4IcaR+vAG4g7cJ+eLdiOi1OtQ5X6O
         4Uwg==
X-Forwarded-Encrypted: i=1; AKwUvBzSJchhW1nTYyxoFGm9M2zhtDIYuisrbhR3tf0dXWNyCGPJP1odi6awnzkoI5Fo1dXqW5xjAtc=@vger.kernel.org
X-Gm-Message-State: AFuF++kQgToBxyabb/0Gdj/XJnWQ1bFUCmKoCQpezIg0qrpyCkS0uA8V
	nfQWns86jZ0BLGipl8TA3Xx2vqZoVSH4LeQFcwT9s8nZegFDK/TTqHV3
X-Gm-Gg: AYBFou2jpmwugzTyrHlsQYE+SgePkaiE8f4UqFDZbsCx2eOutv2ECAsV6WZzITwXQCJ
	YVHo3BGs4x/HYfL/mYA0dxlLhuT+Tg04XuoLZzaEacPF+cBRu7jYSdTWC5UlFJjO03FibqAwmLR
	5SXl9Vg3lSErF9EwGhoOJm73TKMYpuhoh1qrL+tkUJLjp+S+EayEBAXhFozOpBJWPA9GVs6U6gv
	FxCUIjYlY8ny0oyUM+NfanWWWpNfu+LV36KfS81XjeczZTYFaBs97TdU2d8hz6QWt16bZrQdZ+W
	53HBnb04OTNHm+xStEpmtWR7PbCZimpx9YTjLuDnctsZIAx/VekYEw4RG4VdaN2jXur/nAN09sz
	XFOqi/3BchtIDg9s9RMhallYtjjFnLyl8qheUM/bxCA4vmgopc0tnPv9k0T5b5o+D/HmrDDoVFF
	n+Mj5e5J4EJI1pgby1HTFeBBYTqwcCjdRwfykwudwrKSHSoqb0fn8nYtclcjBLYHPKbZ+cJy0uV
	O5MD25aYRFZaLeCdnNAgWbHbEP6
X-Received: by 2002:a05:690c:c4fa:b0:866:e57f:58db with SMTP id 00721157ae682-8711ec239e9mr98053137b3.0.1788818088629;
        Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714c1e1eacsm78453177b3.49.2026.09.07.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/9] r8152: use linkmode_and_and() in EEE checks
Date: Mon,  7 Sep 2026 17:54:37 -0400
Message-ID: <20260907215439.409858-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine the three link mode masks in a single operation and use its
return value to determine whether EEE is active.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/usb/r8152.c  | 10 ++++------
 include/linux/linkmode.h |  8 ++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..75f0574fe1d4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9149,9 +9149,8 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	if (speed & _100bps)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
 
-	linkmode_and(common, common, eee->advertised);
-	linkmode_and(common, common, eee->lp_advertised);
-	eee->eee_active = !linkmode_empty(common);
+	eee->eee_active = linkmode_and_and(common, common, eee->advertised,
+					   eee->lp_advertised);
 
 	return 0;
 }
@@ -9222,9 +9221,8 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	if (speed & _100bps)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
 
-	linkmode_and(common, common, eee->advertised);
-	linkmode_and(common, common, eee->lp_advertised);
-	eee->eee_active = !linkmode_empty(common);
+	eee->eee_active = linkmode_and_and(common, common, eee->advertised,
+					   eee->lp_advertised);
 
 	return 0;
 }
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 49587a2e0f69..efd392dc62ae 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -26,6 +26,14 @@ static inline bool linkmode_and(unsigned long *dst, const unsigned long *a,
 	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline bool linkmode_and_and(unsigned long *dst,
+				    const unsigned long *a,
+				    const unsigned long *b,
+				    const unsigned long *c)
+{
+	return bitmap_and_and(dst, a, b, c, __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 static inline bool linkmode_and_andnot(unsigned long *dst,
 				       const unsigned long *a,
 				       const unsigned long *b,
-- 
2.53.0

