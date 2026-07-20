Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE72BE051
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542804; cv=none; b=TGh24cOIdkbbasdUV5p1uTb/jboW42tWks97tWoI/fUTRlhkoGw+tIVeI//DznkczUDDvOhIbn10rnzLgdwflSJjPQVazRy2uA7qOwr9xCwOjaCvVXI+/EzW9hJhbYxFXezs67PIXeqsB8hDMWA8EiNsqkMnoHaoVpZo8XdMJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542804; c=relaxed/simple;
	bh=R+WfaiY/iSUvhT2MDkaBzNzAIk+AeTXDH3AArAa4+94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXC0ZEmFhe+kSHTuCS1/k1KqiuuCQ5srXf6kW0hHkqJR99/pFLX5B/Gx5IEPa9eRZDz2iAPx5FXedJI8jSUDZasqIy0QNejx62cAr2G72CVhnnk4SjwJPZznYh+w/ztTPqUf0hU8zdg3brlSa0XdeJAaFU+Rm4MEwzOGQZ438bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4KLzmx+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4KLzmx+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso5758080a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784542802; x=1785147602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBik4rNwr+Vo/kNhhYOUVadRXwI3dT2C+cEHBotjVuA=;
        b=F4KLzmx+hvQm90buZDTL1ZgwNFvE2q2Xit4PgAOWcE80VS3hxSWpn7E+Re+60KbrWe
         wKqG+XKclq35ZPegxKg3eJjrR2zwd4b7PXyyKUWl5SC3srtcpjZmUirt+DSthp0haGeB
         2oBVLYJ/rusMgmwxYEnCg7ENe01JwPqftK94NwtPiFlunllApGHcIHRL57kd9joz2GxF
         LJVspbjp3EDtbOGEajAvB0L7daHMOeR2KKamgAAa/8/fm1Q1FxJqxwMMXMYHoOpgJZBs
         ATJE0oFWKKFa7MgxnjbyIFnMH45pHy7bH+B7DojDtDAEuYVs8kOVy+IIP7PMRFXyGqxn
         XzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542802; x=1785147602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBik4rNwr+Vo/kNhhYOUVadRXwI3dT2C+cEHBotjVuA=;
        b=dx4vmAHbO48F7VxQlhPBPTFTzSmgtvsixp6v6I1ITi40d3zEuLlJBdHGr+NF8QiyM+
         RrGlKQMkP4cje/W3gXiTxuJyXaYbsMmUhwWqF6ZMJr1W4fSHzLDen/KkIGBswi8KQqbT
         UjLmvtc5H8IEWsGVw6V8cpjIfq/zrhGwMYXM17aPoyTbqv5nMOdan4mbDM+hz5gcF9Vj
         o6sb6zoBj8AJVReTjlp7GQLHStFU9pjtzmQGLeRt1OyrNma5oT6lut37XQAP5PulKnbQ
         KDaLP37Yq9/zmmYwhwwvCZLpnr1I1HwAvykXjg2Sl3lCq1HvZzjYqBGwSKhaj1AEUbFu
         zwoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeVRVAopAlrePZQ5ScDf7l8/13XomKehVgY4jZQfo/PpmHdWzypgIE3Hx41TZRN3mKYWRGSpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmZFSRX3cCY1iTvDUV9SpUOudXkqgmXLY0evMPtzzhLwsICHg
	zhlZ7TBc2ZUu9wmd0xTS45vPF2kzqxrv63pK6bvXalFA8IdcKkNljr0=
X-Gm-Gg: AfdE7cnL4a2+YbyR5Un/tZ1UcfFCScoPlXfbVdeoPMxV/AFwWrFgtfFHfj2OzuKcp4r
	NXNtUAkiyi16Sbyl4cgRtnhejaAaLGsdm/Df+Bu/+JwCto/axYb881j6ywRHVodAC+BiqKkAS+6
	dUEBu5D/h/qfI6jxnbZIqnDvyJYdgkmbDCF5PGjKzuWhKzl90doj8jyxFn27+bDPvXSW8jBgLQ9
	Obmr+Hn+XCrQ2rVNkNzChu/FuLeXDwaqjyoh1Gr9ChmUXqfRW6Ngv1lXXdZki8PmszcRlS/Ac/Z
	b+G3IK1/BIqG+2C934Iohn5AZq6YKn+rinkV77JA7Er36NKB5lMuMKfJbchlxlREOi6SLu1OwqN
	kPASoGuzeQ2kRlc/o0z3fEafk+lcbxrHreKQx61kHVkSQROtZs17P9YNBzd4E4RpMh+LZPPnw17
	MKSsT3EBenkL3+7t8zWxGM59I8MbAtbUK/XJY4
X-Received: by 2002:a05:6a20:b786:b0:3c3:97fc:93e1 with SMTP id adf61e73a8af0-3c3ad677c23mr14063104637.15.1784542801669;
        Mon, 20 Jul 2026 03:20:01 -0700 (PDT)
Received: from t-rex ([2401:4900:c200:8f2e:8d2c:f805:595:9600])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm37931653eec.29.2026.07.20.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:20:01 -0700 (PDT)
From: kr494167@gmail.com
To: ioana.ciornei@nxp.com,
	vladimir.oltean@nxp.com,
	vkoul@kernel.org
Cc: neil.armstrong@linaro.org,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	surendra <kr494167@gmail.com>
Subject: [PATCH] phy: fsl-lynx-10g: propagate PCVT enable errors
Date: Mon, 20 Jul 2026 15:49:06 +0530
Message-ID: <20260720101906.80584-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: surendra <kr494167@gmail.com>

lynx_10g_set_mode() currently ignores failures from
lynx_10g_lane_enable_pcvt(). It then updates the lane mode and reports
success even though the protocol converter may remain disabled.

Propagate the error and leave the previous lane mode intact so the caller
can handle the failed reconfiguration.

Signed-off-by: surendra <kr494167@gmail.com>
---
 drivers/phy/freescale/phy-fsl-lynx-10g.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-10g.c b/drivers/phy/freescale/phy-fsl-lynx-10g.c
index 38def160ef1a..9740b08700c4 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-10g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -1231,7 +1231,9 @@ static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 
 	lynx_10g_lane_change_proto_conf(lane, lane_mode);
 	lynx_10g_lane_remap_pll(lane, lane_mode);
-	WARN_ON(lynx_10g_lane_enable_pcvt(lane, lane_mode));
+	err = lynx_10g_lane_enable_pcvt(lane, lane_mode);
+	if (err)
+		goto out;
 
 	lane->mode = lane_mode;
 
-- 
2.55.0

