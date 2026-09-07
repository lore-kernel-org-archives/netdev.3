Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B31356766
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763435; cv=none; b=XLyFHYPSwSN2+s0UI0saZDxotdolIV9QbSq0wRLaeTK6mAtyDDK0a2dmnGBooX183gR6s/xAXLXUi4ERaBUPIFD+C9tQxdSsXfEXNYkGn1PXITeKgYDfadfMUYLKAuW0XdVGz5IUx7y75jupP1LVtgqmh/XN/Q89g3yUmnuKgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763435; c=relaxed/simple;
	bh=YSOgfYZSp8SrbWiZSUofEBzDTvr3+SvBNc0tqAr8jTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ao/58KHkKwQ2CToFkq+nrUzy0sBJDe0mVLZRcK3IuWfoZk0Z3BlJijMWr6OP2pU6z3YyRSGkJmicDI1YoBhpDRpcBfV82ZZRUUVrHX2c8CjoThss43YpoMrtYeKU+xEXgJyJcL4NCAIFoaVUIONyS4Xotp+wGhFNm8VE4hub5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaUQXxa0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaUQXxa0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc328b43a56so2611203a12.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763433; x=1789368233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CFZlOFvP6r7OTGSRxMmbvfbXTssOe5ta1IwHi1yqgQ=;
        b=OaUQXxa084JHSuiWVj2ZvhicYKuepXIcxzGM5hMiYUJ9EvoUJ3GETU7lBckenl/orf
         RL+FxwfSg2F1Fj2vARl8IFJDqu4xhZPpgHz9p+FrmvJn6DM+U+U4xDYyOU7X5PMJiP9u
         0wcTeWAwJK1yog4FxopuET5g4laryRb6LENvNqbgz+b2f3mIsGHGRKaYguvf4SvQqaFK
         lmVo9jM7LNXh7q+lutYSuFe4+fMFv8yfge2qERbxerxgYBFhyHqb4x8aA2aHDuxcm1oD
         dbKrDnveiMyrLYLL+CU5+hVLMxWZAP/xHse0tJ31dsY4I9xriObh+HbJma7EvBtXVytm
         seJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763433; x=1789368233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CFZlOFvP6r7OTGSRxMmbvfbXTssOe5ta1IwHi1yqgQ=;
        b=bQq1/ESC7sBSA5rn7+17v24aY3UKgtuWTS4aic4Qqp4V9j21lGvjsOytxPlgjVjP8a
         FXSsNClsG1Ga75BFkn/1r9+PrUwcTJBMjzNlJfM8BKrLp856Am6NXXRxuUNp9+w+5Nd3
         djZK5GP1RUymvsUti2qO9SHYCVRYhiSyqBL0W37zh+dp2kYagxFfiu5qxFqBzHKNF4ZC
         xWpEu1autzIcCCakI7rbMVKHBBFd9Ol7peUMkR6HcFtpiGZKpCun8+kMIOwYDhAgCAeN
         r6o7DlNE2rF3jMEVjDS+Aou6zf0jgJLzZSC+g6qAENxyRsdejgxqUbH9MUGknTviXCzQ
         LbEw==
X-Forwarded-Encrypted: i=1; AKwUvBwSs2Zp9KK4PPdM3GDT7/by+tsNgwXQKMXbyQfAv/2xKdOcb3c8xym3X5CKIAR4UEwY7Z0tcTk=@vger.kernel.org
X-Gm-Message-State: AFuF++nn8j/90Zx3IqlJqp9nJ+C7oaeO959vPDOFUv9i+6QqU6tKBh6h
	hHyHZJqVn6APlKa+vOd8QumDzflsdOyhvBbOLhRXUM/ziZpx1lLfqPJX
X-Gm-Gg: AYBFou3NPGCA4Kc9U+yV1L2xtGQX00ppOTE7ANnxcs+PgYmI+/APkddjOY8FL2F8ERg
	CoMBupU/nPDp4VhnGl/w7hAnVUicsuu7H/ZGLH2rE9BDvWe4zm6FqWtDlMKrIWnCnain8vpLR5y
	AMmRZ0rS9VBZfus+bJ3rA7Em6AfVxJijNIqIsNWVdHlZK7UgLqqdhxF/x+m4Egf9S76ixQMwxR9
	/PZRH6QV+8hLp+cg2VT7UpGCrj0UXCnUeKKgjq6Px7vuQkIkN9f9vljCUAi7ZEo+waK4m+/7ghg
	4nTOorF3Eda+Z86AYUvgBo7uqcGjz9HGBbKrbnRHaVsB4c+ga5Zx5fH1FGbkwuFwNaP8zBT2URM
	irKoOF6JHwBXASgU7Lpz5MVHMGUlSO51BoFwmiagtW4MMsVHsEqx7B3Y/OgYN9BHs3B//zniyze
	EOxnqRNkFUfMTkm1/AUNbZo62D3WMMEtkcBaQ7MPcntldRA+WbiX5zcHXXpScN1KgfARK58jTY2
	ItbgDXSc9xk4Q==
X-Received: by 2002:a05:6a20:9e4e:b0:3d3:ae40:51e0 with SMTP id adf61e73a8af0-3da3a045196mr32280359637.20.1788763433116;
        Sun, 06 Sep 2026 23:43:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm39367339eec.16.2026.09.06.23.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:43:52 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix typos in comments
Date: Mon,  7 Sep 2026 12:13:46 +0530
Message-ID: <20260907064346.3288-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 net/mac802154/iface.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6156cf379916..f1adca942e3d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1370,7 +1370,7 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 	 *	  but this is different on each board setup. You need to fine
 	 *	  tuning this value via CTRIM.
 	 * CTRIM = variable capacitor setting. Resolution is 0.3 pF range is
-	 *	   0 pF upto 4.5 pF.
+	 *	   0 pF up to 4.5 pF.
 	 *
 	 * Examples:
 	 * atben transceiver:
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index b823720630e7..ff6e99257bc8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -521,7 +521,7 @@ static void ieee802154_if_setup(struct net_device *dev)
 
 	/* Let hard_header_len set to IEEE802154_MIN_HEADER_LEN. AF_PACKET
 	 * will not send frames without any payload, but ack frames
-	 * has no payload, so substract one that we can send a 3 bytes
+	 * has no payload, so subtract one that we can send a 3 bytes
 	 * frame. The xmit callback assumes at least a hard header where two
 	 * bytes fc and sequence field are set.
 	 */
-- 
2.48.1

