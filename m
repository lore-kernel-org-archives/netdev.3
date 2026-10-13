Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EEF55198F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924342; cv=none; b=Wp5HHhFnI43SxNxZpgzXR0eMOr6+toSHgwJhm6OTCg39HAJ2G0faHPwiCOAhiNgsRzsr5UhEvS1a7zzzIoQS13uTYQ9t8axDStNAwE/Y0s7p9GpufYmo0y2IGyrdj+GdrWizcAIZkO26uWxoh3I3enRDD5ScoJTgXLQuMjdD0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924342; c=relaxed/simple;
	bh=cMwBAastac/SwLSfCXNFutcItb00suFmuq/i2VUWIL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uofCPUVZkJXhQPbVCq7r89zvVNt0lM14qjk8+6Fkg/gsHKrGIVEPzpTccZsif6HWyJ6ga7mxbP7TaeC7GdGf9nArLKNHGIliyFxCskE1SkDOGgJDBm82J6qy2aGG4dvcORnT4hHPNaB3A2dFw1Iud9AQ18VSAJ4XUrczm01aGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C1/u7xcD; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C1/u7xcD"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1284565b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924338; x=1792529138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o401XOuolgRzvhquCe9eAwBmzW/eK7Qzlg72iAjj6OE=;
        b=yGZn8/T0kEfUMeG/mHHEvuMZBcxFCjk36Itw5XJde9KxpQmWLjojnOi1AIXiuyn8Ll
         7NEVwxOEoJu/nsSydmxy+u2381a4BUKqGaa555sgbB1/Yl6rTKTQxlz282epB2o7YXPE
         EY62rphR7bKIaHlDry9V3r/HQNdpUrST8B4XbNWudg1qtkQX53CubxEKnyFtvFpv4/+o
         OMFb6Hmdqd4zj01E9SfKPrqPYa/k93rgnMZaseHYbWp1V7GhpZWl8y25uKfx2lge1WLb
         ubyGXVQVqKRgvgi6fFGAvvlMCN1R2/lOK/xwZw5Wew+Lcw5VKZWILyEUyk+SQEVFd524
         c2+Q==
X-Gm-Message-State: AFq9FYI81JrCeru2V8fXb+UFhH/aJr4QzKwtr/PN5kyx9+h9vwmQXbQt
	LqcAe8XBNOF0HBGMz6P5JnRpq9swEkvwNk9w3D5lnWAnmtqtYWxDapWBB19TJeTtdNOxPNvE7K7
	zf4f7/uK8G0a3iMcTyfe3pHnXwdtQ5hUifLfxvoOvwCv3C6Q+a1/WRc631IXm/H7RltnPzTaFbo
	LPEpHwVbp4ngIa3DaAASaowHh20dkYdAM825bbNtH35k0mzVc/38MJqdedkpH4jH/o7ZXG29gJN
	rHB9kz81CdIhU8X
X-Gm-Gg: AYBFou1vN2kH0HAgV7rMWwHdF1exAyiUkrQXzCwFBe/VwsAeVe/Sey5A2lhIkX93s3I
	bYzAZxTBTdicwzkUzSxl4hLv1SNUyHbiyiFDGR06xkiFCmbfpgI+EucilYwIZEg0VwiKOYRNCqO
	CXnz3F/0NUsrXlM2hj5QUnPPLSqHfgvqNFEzTHqFkzHGNpwPqC1eEskPShk2b5zK5IFO30MxlfE
	J2i6eUwT5kzqk4nXvzCxVXCqqx4mQNauBCuTWtCnbHSuTQrn+hAE5OEVtDw3xGJj+minEGO3izC
	zNySGdkgbKbGshHu88D7bKhvkmLoVq4KVGNax3RPNoiZ+/f5kheqvDMCxKxTW0Sryn9+Lgz1tUv
	oCoddjf1uvyRLlOpMAst0+DFVUuV6GImcDIMJhCBx/sPv3I3A/fNLOqhWPs3N8IjWoGY89KwLVw
	iZGdGaajlikxP4SejQ/rVu2YvkU/3J/Km6wwxa9Raj4Rk=
X-Received: by 2002:a05:6a00:3e12:b0:886:77eb:38fb with SMTP id d2e1a72fcca58-897c6e1b5f0mr11848227b3a.25.1791924338173;
        Tue, 13 Oct 2026 13:45:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-89d7e4fa8b2sm33875b3a.0.2026.10.13.13.45.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5338ff2cf14so63518491cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924337; x=1792529137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o401XOuolgRzvhquCe9eAwBmzW/eK7Qzlg72iAjj6OE=;
        b=C1/u7xcD4n9uyfVINVa31DnBXW2ahdIzLgMYhxh2YKT633kw03pMPxU1T2AWXkWOHo
         UExTFur5croN5fMs9jn8UuRmKm1TLRhd0daIzSeYyCyy1oKSKZatw7pUj22/RTGJyJhN
         QaF5X8wZopmyTnKkNlJenoNLaLkySNYtGEoJs=
X-Received: by 2002:ac8:5f8e:0:b0:51c:fc4:a144 with SMTP id d75a77b69052e-5359f46d56bmr233646411cf.4.1791924336760;
        Tue, 13 Oct 2026 13:45:36 -0700 (PDT)
X-Received: by 2002:ac8:5f8e:0:b0:51c:fc4:a144 with SMTP id d75a77b69052e-5359f46d56bmr233645831cf.4.1791924336165;
        Tue, 13 Oct 2026 13:45:36 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:35 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 RESEND 4/6] net: bcmasp: fix OF node reference leak for phy_dn
Date: Tue, 13 Oct 2026 13:44:37 -0700
Message-Id: <20261013204439.3494046-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

In bcmasp_interface_create(), intf->phy_dn is obtained via
of_parse_phandle() or assigned ndev_dn. of_parse_phandle() returns a
node reference with its refcount incremented, but of_node_put() was
never called on intf->phy_dn in bcmasp_interface_destroy() or the
error unwind path in bcmasp_interface_create().

Acquire a reference on ndev_dn for the fixed-link case as well so that
intf->phy_dn consistently holds a reference, and release it with
of_node_put() on teardown and error.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index d679c796c8c2..693e8cdfe960 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1298,7 +1298,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 				 ndev_dn->name);
 			goto err_free_netdev;
 		}
-		intf->phy_dn = ndev_dn;
+		intf->phy_dn = of_node_get(ndev_dn);
 	}
 
 	/* Map resource */
@@ -1338,6 +1338,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(ndev_dn))
 		of_phy_deregister_fixed_link(ndev_dn);
+	of_node_put(intf->phy_dn);
 err_free_netdev:
 	free_netdev(ndev);
 err:
@@ -1350,6 +1351,7 @@ void bcmasp_interface_destroy(struct bcmasp_intf *intf)
 		unregister_netdev(intf->ndev);
 	if (of_phy_is_fixed_link(intf->ndev_dn))
 		of_phy_deregister_fixed_link(intf->ndev_dn);
+	of_node_put(intf->phy_dn);
 	free_netdev(intf->ndev);
 }
 
-- 
2.34.1

