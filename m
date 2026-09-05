Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32090385D8E
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643220; cv=none; b=lLirXv5+P8Pzk8eiO72IzbARcbjNIxq9F39BjEDVam869Q9jLZOXGz7IMxgphMW2nafG/Fq7pey4LDfBxVsaL2L+nJa+YE0SsE6Xjag+LxZq5TvYC5x5ldU1qUwAeJo3edE00rAwyOnR73w1bH/BFokUD7ZOqGoj5Uke2eNvLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643220; c=relaxed/simple;
	bh=jSGSOPGdun1O6fIxZYqKJoHEOv2B0LFaUlT1O3HCPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsubnv9lR6CmHcjgCd7Yy5TbVq71DRGO8wXm0wougbp3m3gdOU93ypLxPm1UTidtOfgQgUMNPFM9L48b534aLdWtUet47ZDneAGmygrevdME6NBMap6piL5YJ5vzcDiH6bIN+Ozg6AbF5sIzHKoZurHbUx/RR3OosE/WALPx040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egQQaQwL; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egQQaQwL"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso925616e0c.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643218; x=1789248018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fELFukRK3cLSjolaPX8uHr3nBn0dP4gV3YMVhWZLVs=;
        b=egQQaQwLKlI3dzc/cj938Z3m1oDHPiPC8maV2gkRslFEZ8COaNHxMhuE4aFLz0/+9/
         PtVWGykdIL/CJqfbzV/7F0AHJo6bn66+kpBUZ1lKK2nTff/yEuIQVE0RSbwuOzBfadnR
         TsOa5S/YmhLXwfdCK0y5LZGTn51uFCSADiSLWh0Ir6cKYQ5J69Onxb7aDcZqTUdjnrd6
         52EcmzN4m3XFQvNLZVv9QQe0t7ZYgR5yB4Sxrk/gUbi2pqNZ5vCmNS4sZ7mufApJMQW/
         93TJu7ZstPtaCL++eiDbn0ZLDdisBc2+2DoBmuSy4k8bo7sMO7kOWPvCWTo95fSALbPq
         LE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643218; x=1789248018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fELFukRK3cLSjolaPX8uHr3nBn0dP4gV3YMVhWZLVs=;
        b=Y4PWaD4Ivl+ZWRdV2qTAspeEg3wVCQSPW1S1g8bzKq4LBm7Yz2xehSCNXx0SHw7Jy2
         bnQ9dgYNAlx6Ry5aHYEN+9H7vsohAV3LuSJVu3FDfYEvxnMewE8tTDUODuw++vozed0k
         7KGQK8c2jqY/57zpG5SeBCUGlwbWvLpxe9NcxDVOFoT3yrt4+WBrR8TuObHMZk0i0iHP
         Q7WjH/4OWxlBmgsXEeL/1xQKxz8PU7E9x1y+gxY+WSSOiA/GInFO4TMs3qAfipbTTRGX
         HlA6WdRDGVds2wMVVcVWD/I+WJSIwldYuwlFJcFkJYSErO2IZtcZZT7tiaWRkJ0fKgSI
         zlqw==
X-Forwarded-Encrypted: i=1; AKwUvBw1pRQlT4Ls3u926UoWn6Jvq6GwHt6KM8BhY+MFTtE+Yx/EAGE6hEt/eGjZdIy8XAheKgr99Ic=@vger.kernel.org
X-Gm-Message-State: AFuF++l+kfBO7qFyTsN047Kwd1VSxsPxjyCCzDBh/KQduD7XBI4+AWZj
	ctcysL4XtrCGWdCgZdd8UXiG68D97sZfwTb7Aj40lEqYJLHCiGQts37X
X-Gm-Gg: AYBFou069vquywYzLVF3ZMLFTTLPC6TjXbKzFonl9FjZw/1Khw+3Rc4rSEn5TcQVhrZ
	2Onsg4Lyk62+MlFR9QmX5cPcvK3rA+EfpIG6GuYdm+1LD/IhSWIE1np4NfWwO/xX12IGNWz67Qt
	5/rZNuB6+HZ+BWNT6VNv6I0wLqNckSBbUL11BZ9SFZNXGeqMfLkN7wbMJCGMZVCLtIMeg6QEUx6
	cs2TDJSDGQav9IBeh5hLqz84GxkkvrM2mzM+L1u5GgUXZ4WX2baQpaGwHADhVn7AuKQEJN8QRiX
	EGVSpOyCWlLceMrpcwM2hlWfDtVEcmlfXCtZIMzYuI0VFUPl7WYBceN/PpemIvbw2RAqtXhaD0c
	eqNSpBu77C0oVFcMJ4Lolw8vKefILhfwGAe5pJlK0nUeFAGsR6/nP/ayd9Z6uLiQRbehwSvEo1m
	EycXAMuXzg+wJb3JVBLq+6JY5+7Gq5bL47P5on4F3+I7z+QBbUDHtHV4uIo4iBxNQ=
X-Received: by 2002:a05:6122:8f8d:b0:5c3:61c2:9ec6 with SMTP id 71dfb90a1353d-5c7ed456d8bmr6057176e0c.7.1788643217986;
        Sat, 05 Sep 2026 14:20:17 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1097e5sm4901956e0c.2.2026.09.05.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 14:20:17 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 2/2] ieee802154: warn on unspecific wpan interface type
Date: Sat,  5 Sep 2026 17:20:06 -0400
Message-ID: <20260905212007.304875-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260905212007.304875-1-adrianox@gmail.com>
References: <20260905212007.304875-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the unspec-iftype WARN_ON that cfg80211 has. The iftype is set to a
real value in ieee802154_setup_sdata(), so hitting the warning is a bug.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/ieee802154/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index c6213412d291..ec5bfdf6bd31 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -297,7 +297,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 
 	rdev = wpan_phy_to_rdev(wpan_dev->wpan_phy);
 
-	/* TODO WARN_ON unspec type */
+	WARN_ON(wpan_dev->iftype == NL802154_IFTYPE_UNSPEC);
 
 	switch (state) {
 	case NETDEV_POST_INIT:
-- 
2.51.0

