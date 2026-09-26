Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700B3ABD80
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790423781; cv=none; b=EnPUAd1c4Z9zh3/X/uX6NYcsqZYRyDnvsgTQYk+5JGh+DW1MAkk2ad/fKV6AdUay/f03UKaLOJthbiY4GlLW+xqt1I8ulE9tQKNz9/zqFea0wbAwxQDfaDx+cwe38WeHThJPcUAz7cI14ZyZJcMzCOSrIBoq2TPKJU9XmodDBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790423781; c=relaxed/simple;
	bh=p/aA3q7dGb6rMTLZdywmMWZ771K7JU7OE4990Soo7h0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oN8dSWheLcM10AZz5azZ9P/oydPDE80ur0q5Ja8mnQL/tEG28cAz2sfWcq0feDyxtXDY6GJKnczuqLmT2R080V96LeZrDCg3ATy/7o1x2rGY6doCTdiVIoy5dyb0UFyZoGxWEYk2BSLlQ1cPFTv7GPWsj/PAVD5YhCrDelWjc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJWzWTzQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJWzWTzQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so18910585e9.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790423778; x=1791028578; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjEi4VNevqX9s+v8m/m8iSJ8qE2I19ueR5QHAcHq+jU=;
        b=oJWzWTzQ2gPAeaTAsCG5w0gE4CpuXHvanr2QgZN0jZJp0YcvSvpjsjRnJ9PTNCC5KJ
         q5+EaLF1uwlp31qL8DBWo91zLPzvWX563cljEcndPTdYjnHX7aXBuuA4JLGBxPmKkUOz
         MhNhf6mVwI/pfom+5Kkd37Cb1XUX0mhnWsyGiCuF5zoNggm4tdnP0iars7ydDhO2x361
         59fzap7GHxgeX9IhxN0gDZOKhQL7JytsirH/XX7vB7waJ/fTvXCnfC64QVpsiSLS+HMp
         3YTiQwg6OlBs8fYxTXBcm+42pOaHLrikLw8klvrONI7CTLf+3WAMJiE1HwauHWaFiUJo
         ESwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790423778; x=1791028578;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjEi4VNevqX9s+v8m/m8iSJ8qE2I19ueR5QHAcHq+jU=;
        b=vJsomPcCZnXBK38OqNmT1qhtWfxl99WxhR6+HEldug48AMX3VXAon+4wySwn1SbMDg
         aS86EDX1C2H5A6yUe2bThroOR3O8eI5U12kXR9FVb8g1iCNMUv4cFC9GqI4+o8niLx8Q
         1C5thM5Y4M9RmsERNl8lGjyVpGUPFQpDCWACgv/APmQprYnO5fta4wCGcP8qUCpa65J0
         H0tISSmwOPJO590ZeSK9rmuZLbMeCYWs7pwiFpeYQ8OrRX9dkDBHujo6pg0WCDU5vL9i
         g2snVMshu9nfN2avWa7XLlRzIoGhvvanOPAbPDgqhORrOljBWOL8M6U1gFmF7CESGnNc
         P0Og==
X-Forwarded-Encrypted: i=1; AKwUvBwyXN35BWYrNIIlp13Zv9G0rlRAf6JHLTY742HvclqNzCfFYspmnYddXBLEqmsjwHR7RFdQW38=@vger.kernel.org
X-Gm-Message-State: AFuF++moCL1RQJPiWh41lnjuj5p51JxvYlZnKxE+yuJMOoAvyctnC5fC
	Js+C6Z28Gi7xs22YGVp+H169TFVwEqYNNMEhqcpP6zbzZkcdbtK7+y9L
X-Gm-Gg: AYBFou2iHdhaWTQxG2xSPVTxdPs0NxD8S6HgNyBdz6AzFMNLlu+Gv3W023EMfZzpXBn
	xpDFAWh8MY2gUYvi5R1swsFDc2S3AGQlMJHKYDctEfSlNW+UY6LeWK+swdZA3O4fOHbjB/y1kqY
	Mn8YHw8zF/Qhli8cjjHmk0auCG7ZGw8qS1ViFIf+OfyxzFUM00iCIfmWt3vpvGX9tKU79F+VbMJ
	0qBua4jhyc61Uw/2QI/KmHuRaHi+gBFCIa70l2mKAYvWKdY4lPKhuCVbPHc/BGFqO+LPHugpOTy
	zyG4fWgx3ip56yDR/dXTVvuiweSRrZplQw057E3h1PDeBeE50we2H7Zv39aC/yWsEecpFWX45Zl
	6iXWeWkTON6Y74VPhQZkBPjXbPWa2z/YHPg/hIscdzibZ16bXvEzYiuAvi6xMgK2qIqYHc/zP/n
	Kg+5NNNP+xRWjc9DGX8dmeaKfcoRM1F75Ed8+mqrQ1eDoioLBx2KUTiLgj4voLvDwchnklG073E
	PcDcg==
X-Received: by 2002:a05:600c:8b33:b0:49f:f9fa:fcfe with SMTP id 5b1f17b1804b1-49ff9fafdccmr28010155e9.13.1790423778140;
        Sat, 26 Sep 2026 04:56:18 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fedec53c4sm171071455e9.4.2026.09.26.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:56:17 -0700 (PDT)
Date: Sat, 26 Sep 2026 14:56:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: enetc: document enetc_msg_vsi_send() return values
Message-ID: <09f24cefc214455305543a0528ceae6349c77419.1790357822.git.error27@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Smatch combines the return values together and wants all the callers
to handle the positive values so it leads to static checker warnings.
Add a comment explaining the return values.

Generally functions which return non-standard values should have a
comment.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index ee9567998c7c..f70b6d4290f2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -48,6 +48,10 @@ static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
 	}
 }
 
+/*
+ * Returns: 0 on success, a negative errno on failure, or the positive IP
+ * minor revision for an ENETC_MSG_GET_IP_MN request.
+ */
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
 	struct device *dev = &si->pdev->dev;
-- 
2.53.0

