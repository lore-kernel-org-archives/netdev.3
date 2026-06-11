Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BA390235
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161781; cv=none; b=dAqrvq98H3En3XDykNkO6X+Mg20PXmKirR7zbt04nAVxxk9UjefG6KyB02XTixU5SM3GAjrA/l0lN/HGqjq+mNXKjRPMnW/2nWyPDGtViDjwC51hHpZ9NGKU+fgL0g3Q+cIlXR8aWU0diWHn02UIQNp7VRNeAG7tUdJkphuUfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161781; c=relaxed/simple;
	bh=k+IxjsuLra3cK2VhDLngm56iDPq+9Z/ufCcPp5tTvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCfNFAgxoWers8pGLj29doPb523U05mhpdRjd/+vm6A2vJC50+br6hvtwUmnFDU6q8jii1R+EKyqpCV38n6Ybv5S1WT2oxolDdMP3DWY1jfzdFCrjE4EHGBOuJKocSUMT/j2upligl3DvOE1UhiCJcsVD3k4AduHTVF/IVDmQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu1fFD11; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu1fFD11"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso73094295ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161778; x=1781766578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kc3MFHKXytuLZID0ql8vfVlQxw8tF3bNPdzjICZ2Iw=;
        b=Xu1fFD11W5Z1Ec9n/JkWHooxYDyf34mTGjvsuPlkCZW1oTVrI726tUmKypofUMVklu
         lK2yKEntlhFpkVH/59SNrLmdsMlbDEDzaOUR6tk4kJ/W0984/nQh0CsTNb0wNZ16BFwQ
         USGBicTmvc/4rYNiDhXJLgSN9cK8V5cOseqEhNs5RBNeWm1/mvttl76UOgbQvS72x2RF
         367t5zam2gKPY1x9cjhxFBciMJ8BtNzvh0pb/vPJMjQ5sjOiJIBF37+K7PlrLXS2NcDT
         DpLKwFyUo4KCLmTPnwTcBpyhFc1625bT4QJAjyY1qf2huGhQwWvHx19roGygpkUdGc6F
         Ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161778; x=1781766578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kc3MFHKXytuLZID0ql8vfVlQxw8tF3bNPdzjICZ2Iw=;
        b=AQN5ug6zL9sCbSfp773XaXvWl3u5/ueh0snFvqfKGWOSaOHPXmEvoF03l1f1aoK7a8
         QWf7oiOSqifpdum7g3w05FYHyWkmFnGdrJYs9Gn2jSdkzaLZzpPYZQIQcNUd1C7d8TvN
         NJ3dUgjdzNg6HpRcjRUNir+PRa0dSCnEHtIujnZImOea3AWgbsf5kktV74xYGs22FKKp
         xa41eTBHPuAd89YLWKZqX/nRzPvLGgSm7ZN1r9bv23KwyoJVUDsHuclwwGwdFsl+hwQG
         vg1A1XBESRUCJfcxW6kX+4zcV1yzErTDP1LPL3eMlEFpWZ8BQlBGViT23KYhFY8qxU2B
         h7HQ==
X-Gm-Message-State: AOJu0YwFJ1gHRjtPa9IuYcmA54Y8kOqaZKGNnjSEJ3RKV0hCBhAALET5
	tdL4euH5jLI8XRsOvlljo4ealnnff7A1yqeJjN9noDiiabqSfjcGdEA0RGO95yRt
X-Gm-Gg: Acq92OHLER6dS0eOUHzrS7VtUWhFh9k9MPsC6uJh4F7HwNSWrz1WFBl/QABj7qI7/MS
	4uJy1gja3cGH/u/l8r+2agy+v3WVGGxKrYatzD0sLrcj5bohnWx8WYzvDxZ5eRfFtitiRGtRw6r
	RJD7SAbMRi4DTKSIray8EUIMFi0rI8XEl51CVKspfKHf1bp8lzfUC8583B9u67ID/HILVb+IViC
	LJEKfRBX8PA02o3gV5SgTcg+cBt0597ubZCTgOenrOLiDcaG2AMmBkHYEC0tNP5/J0XYrbePLlZ
	SzVolTMGEEtU9iHA444KdVR0hZJaS2o1mhdv1KnS9sWD1eXNpgyNjHuG2zcFA8kxOjQReI2Gttq
	mLWrlqSgPg73i8obqu3xWUkO23HpvBECOsIICRmCniqIYXHFqaTxVFELu96UBunOgV7J7/emARb
	txdQD3oDTO24kpVFKUN8EE7yPpZM9ECG92ds+CwBTjWMxUEBDUiVDBao7lUUK/
X-Received: by 2002:a17:903:2f04:b0:2c2:cb80:e4bd with SMTP id d9443c01a7336-2c2f005d132mr19819545ad.2.1781161778122;
        Thu, 11 Jun 2026 00:09:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:37 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] net: dsa: hellcreek: avoid devlink resource IDs collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:49 +0800
Message-ID: <20260611070856.889700-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This might not cause real problems, but the hellcreek devlink resource
ID collides with the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP (0). Avoid
it by keeping the real resource IDs starting at 1.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/hirschmann/hellcreek.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index bebf0d3ff330..95593b5f002c 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -311,6 +311,7 @@ struct hellcreek {
 
 /* Devlink resources */
 enum hellcreek_devlink_resource_id {
+	HELLCREEK_DEVLINK_PARAM_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	HELLCREEK_DEVLINK_PARAM_ID_VLAN_TABLE,
 	HELLCREEK_DEVLINK_PARAM_ID_FDB_TABLE,
 };
-- 
2.53.0

