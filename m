Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D643F4AF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818086; cv=none; b=NUndpxcFEU+kWyQwISkvcJDY+lmv3seeM4SgZFrdHbx/wlczvbzgjVegfo3ECiN69Uj7YoJneHLrBkcCLhxdwaepvsEn4IPL6aSP2X9ZgIW7m201kInbIdZZa62yFXJPaUGQBrZv/5CKJOLhznA/jO17u+2G9KHLdS8ynwsnO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818086; c=relaxed/simple;
	bh=6gD9cPa3rk6w/IUG4LaLFS0hBqCw0Ni+w/H83jcmfzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXSkhr7uCJX0p6XGq/9ZvQoSnHbtbI543ijG9FCTXiM8GWG52aFHf8EUFCvepYMwCXLcqzU+wuxHiT/JV89T3jh1m70Q88R7ZueQD0TBjiZkfiBr007lBMBIz+MbwogzHJEbyM64V9GxzF3v6H4OvlbYcYOfgVsXd9CWa1kKWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIWTHAT9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIWTHAT9"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8588583a7c3so36916847b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818083; x=1789422883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
        b=qIWTHAT9quXqA0t6iOtNO/cWrRcxjeYDvz09E+AkWcxyxnjPeDjjAYX78vwb5lm3ed
         8Jq6R2tRFlC0+brur2FptO9TJ4RYZxlh0tXE240RPv0oIRRDZ6kIc3wCWbNSd36cwts4
         cGBX9t39xKhAa08SIDlg7kqyrbHFGKFlb3gu8RUOEKxvTv7umHvATMb6yCp50fQ2fVu/
         s136vjKD8FxjBwYh0YiP4jIGtwc5dcZLoyC6oZ2d5miiiZEtjnV6q9VPZZa0+R/diJQe
         WCZKrIZiN1CQXJB50VNU6NxPzc2LW58HahHyF7zntN4TzdACIAwoWOqnDBTonFyqjqML
         0rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818083; x=1789422883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
        b=Yus7r5XkB7gmLc5jCJWJH5eS4IH6K0Ap/G6VB8d0A7xZadyxzLAZm0rJxgtGNybPTC
         ZMfm8ZYuR/iaUbcT4WFFyA7lTx3ez5EM9Tp0FSFbJiEferLQOFqIMreSsNfjakg7WVKs
         mZeOWNdg0LVIYP4MV3mewzY1rKDVTWbV/nXipuKxXia/yC5LO3Sv6HRRnPR07T46RgAX
         NA5WGwshAQzvi5m6jzFgJsyi/TDMfoxlZc47hitbvFEZx2CUzm8y5T5+xTwNQme8tl4w
         v0a9akrICCW8LzQK5XpKuRvPjmY3Iv7376/C5XHKMq/Mt3/oCFGTUb3bw1H2YR2jlObI
         XSKA==
X-Forwarded-Encrypted: i=1; AKwUvBy9WWA8bBEXugvCTWlVyFbohoLrYZsXYG9bVo/5suW9nk5byNGHxlhhOI/aqjj/67xl/rwssQM=@vger.kernel.org
X-Gm-Message-State: AFuF++kZIQM0tvyJad+wpRixtc5l6lmqjbPf9JtLi42aqAtTYQkkHGcn
	l8aPcZLHVSAEpQXtKa8m2cKWCHelobTDdPygxVkzeVl68o4Rfc1oiwku
X-Gm-Gg: AYBFou1vscF4sBsWk5jtKwPp0vOwabdekcdrpRP0yQDlKlITCNAeZ6IgawzTns3hwFE
	qZiD57B9EFSetO/chPcfCMwtLNgW4slVDwkpZo2S3JgQLf/ogLsAdwDNitlGIOdXVm5yZW1b0sJ
	vnu6Ze9K50JIYOEA22HzVJba/Ny6vyhaJWjajvkB1gmmTfebQ5+y8qBDbfQ5jpgDAz3nx28645F
	iiOkMm4I5ZfbzLmv7r0Kz4Dfp3MJcXI0jx6Z85MWzQrj/JxMJa1WYn3g6sNezyW8AoQ6ukRRggH
	6GmWQunYe80DzcblfRqKnJbdTwRHZdK0lWjPqmSDX81ytPil3NOm/TtTbDgSilH/5sWbCUFaIjn
	YP27op/iBVfxIE2rGP0qkL7ISfUIOtCEoZ7SRKDbJjIXV7x2lbDyxhsL2f58saaofAuxYpWG9xo
	u3cO7NPgWgcHfM2MEME1B1r3oq9d4Z6NKvLIuI/wrrn9+cmp6YUgmq+TzvE6r0ePYrXKRMhTu4q
	T2d9CxVkAkNYYklug==
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c08 with SMTP id 00721157ae682-8735bb26eb3mr43482417b3.50.1788818083523;
        Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149315162sm78079637b3.12.2026.09.07.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
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
Subject: [PATCH 2/9] linkmode: make linkmode_and() return boolean
Date: Mon,  7 Sep 2026 17:54:31 -0400
Message-ID: <20260907215439.409858-3-ynorov@nvidia.com>
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

bitmap_and() returns true if the resulting bitmap is not empty.
Propagate that return value through linkmode_and() so callers can use
it where applicable.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/linkmode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 3b9de09871f6..c08632c10c3d 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -20,10 +20,10 @@ static inline void linkmode_copy(unsigned long *dst, const unsigned long *src)
 	bitmap_copy(dst, src, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline void linkmode_and(unsigned long *dst, const unsigned long *a,
+static inline bool linkmode_and(unsigned long *dst, const unsigned long *a,
 				const unsigned long *b)
 {
-	bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
 static inline void linkmode_or(unsigned long *dst, const unsigned long *a,
-- 
2.53.0

