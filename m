Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5143D503
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903451; cv=none; b=j/gVfCyW20sZjUFVNsginPHKujyUTLOA6yyRl3ElwNvNQ4+w494VopEk3SPRgT4Cbk1dA8o34v0QsKPNL+sqFX2bAC3PIQ1IsJVPZHg3DpXagswh3lKlWgcsBDM0SZaFHyNYA1BAOK4sZqbuNF/Ro4lhIXJ5C4El3AmNgUtorG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903451; c=relaxed/simple;
	bh=90EVbGJA84/7M9JAh396s55yku4g+D/H4Cbmu9cjEms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keqIGCZLH8uilfbxmNHfcQzSYe27piuBW2+gQRugyFjtthzaZyVQlW7T82xZYEJtSjtObe3bEvZP0oTUmCZODY9AZBuvehRDmKJR3FDnxxYH30Tr1DVsnDX9AI5+0etR7h8uQu/QAfQSBgX9BC5s5RCn4xol/i1P+WVeq31nQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PNW7SGPW; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PNW7SGPW"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so410500b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903449; x=1785508249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRvfd4XDLRXG+hTzuT9EEdM6zfTC4YymdTujDGLFF/E=;
        b=jGmdBonDtSj7Ntgp0+WNyBU4YyV2L6WaxsbD6+x7ITpj5iFuPG8n3HJc2Iu09rzNw/
         0GyIUKgBhK7nokcuMq33coPNuWxmikdwp7bPgxuqJ8qGrQWu9aMZ2YnkUip3Bj0N0LQO
         UWijvKRYj0Q+mEOB/H068Rh3EBan7k0i4NaB5nK5poNUKOVxHdktZtNOi9c5aRdFNsVe
         mx9EkTd8PFStiHKXAzG5uAtRVM6edCyHu3/Bs9zX1rNOdgIFembbW97rW4f6+Fd6bONA
         GdxKhJ3wKJ8FdqZgujMX4opGdo6ZVl7I1vTawSfqK0Ou9f7bN+6kJTMHS/1Ch7FZRzUj
         TJeQ==
X-Gm-Message-State: AOJu0YwK763MPgvuLFnexhDH0XremdOx9PP0gskcGK4vbsBfPY/+efsg
	Ay8XOTSZtzA3jIOvAVaXpY58fRpXYWUqILMMufbPvkdLKYoG5K+gbuv4eL8HFUgW3kH0fFYOrdG
	vd3WgDBwhKCYYhBY+ShCUU0n1d2c1zjkw1BUR6YbCLCjoCDWJJDahljLkbFKuM8M2gR7PfBYKn6
	hCSupAq3oLqiLQc5nIsWjByRc4qay+pkjXkG1JdJytQ1QCVeCznoOqriyxiFyk9doKNIkU9NUtL
	USeB2NTZg==
X-Gm-Gg: AR+sD12riFUAQrpquu6Dhjv+EvSUWC4fRYZ4x1Ygex9svR+z4tn2zxBBZv64VhuEWwx
	nHAgko9rDJNG3nT7BNfZtyvXJR3v9jT4vtcxZTBgr/iyDCrZoiKzAMPPK7iMBmxh6yOuxHzoMyb
	AUinYX9GGgJOrn0MqUFphz335bHj/GNTtj4QDNWOpWRg0A2xuo65Zdh6NSBqpTyX6w3hi9kTGyH
	WMXTMVhTW158wRReNNuDHExuTsAK0alyahR56xtlEEIworyhfQzebpHN1KaFQjXOYSQ48oQeWo3
	seo3gOzSnY6Vts68ME1Ig+lWPwsULlkr2k98pYj2Qi9RzroF6R1HQ7pO0odOarymMLSA7+jOYCi
	6LYLFr1WYrrIoRzmg1kQ/yAmlEEwolgtmugvgEv6qHsdS6w8Nxm/5e5B9w99TAumu3dQkTkJKoi
	qQs4vPuPEgjAys+gq5agsvz8bt9sCJTeu0uQ==
X-Received: by 2002:a05:6a20:2056:b0:3c6:3c5b:f2e4 with SMTP id adf61e73a8af0-3c63c5c1884mr4052655637.60.1784903449169;
        Fri, 24 Jul 2026 07:30:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbbb66bef29sm7356a12.9.2026.07.24.07.30.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:30:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7f385887bso10322975ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784903447; x=1785508247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRvfd4XDLRXG+hTzuT9EEdM6zfTC4YymdTujDGLFF/E=;
        b=PNW7SGPWpTRuLBMX9MyuSDLA3cvPatz3mnx0IZ3WqyVOPea0nqF0Hk/mx7xUVgllmV
         s+tKzmrR5phX0i/PR5jYjlQHd/AbYj00VcMJ3oMn86rV9oezI0vXWPv9sPUiP4SDFvTi
         LgzMUCGnP4YhwmhKGk90/yPf5QAxGUEVFXFZU=
X-Received: by 2002:a05:6a21:730a:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c44afb1ab6mr8101932637.2.1784903447122;
        Fri, 24 Jul 2026 07:30:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:730a:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c44afb1ab6mr8101882637.2.1784903446449;
        Fri, 24 Jul 2026 07:30:46 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm259643eec.31.2026.07.24.07.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:30:46 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 4/4] bnge: send hwrm for interface down/up transitions
Date: Fri, 24 Jul 2026 19:59:54 +0530
Message-ID: <20260724142954.3101980-5-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Firmware expects HWRM_FUNC_DRV_IF_CHANGE on interface down/up
transitions to coordinate resource management.
Add bnge_hwrm_if_change() to send this notification.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 32 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  2 ++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index e67536a8c430..220bdcced0db 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -20,6 +20,7 @@
 #include <net/page_pool/helpers.h>
 
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
@@ -2861,6 +2862,24 @@ static void bnge_tx_enable(struct bnge_net *bn)
 		netif_carrier_on(bn->netdev);
 }
 
+static int bnge_hwrm_if_change(struct bnge_dev *bd, bool up)
+{
+	struct hwrm_func_drv_if_change_input *req;
+	int rc;
+
+	if (!(bd->fw_cap & BNGE_FW_CAP_IF_CHANGE))
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_IF_CHANGE);
+	if (rc)
+		return rc;
+
+	if (up)
+		req->flags = cpu_to_le32(FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP);
+
+	return bnge_hwrm_req_send(bd, req);
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2868,16 +2887,22 @@ static int bnge_open_core(struct bnge_net *bn)
 
 	netif_carrier_off(bn->netdev);
 
+	rc = bnge_hwrm_if_change(bd, true);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_hwrm_if_change err: %d\n", rc);
+		return rc;
+	}
+
 	rc = bnge_reserve_rings(bd);
 	if (rc) {
 		netdev_err(bn->netdev, "bnge_reserve_rings err: %d\n", rc);
-		return rc;
+		goto err_if_change;
 	}
 
 	rc = bnge_alloc_core(bn);
 	if (rc) {
 		netdev_err(bn->netdev, "bnge_alloc_core err: %d\n", rc);
-		return rc;
+		goto err_if_change;
 	}
 
 	bnge_init_napi(bn);
@@ -2924,6 +2949,8 @@ static int bnge_open_core(struct bnge_net *bn)
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
+err_if_change:
+	bnge_hwrm_if_change(bd, false);
 	return rc;
 }
 
@@ -3154,6 +3181,7 @@ static int bnge_close(struct net_device *dev)
 
 	bnge_close_core(bn);
 	bnge_hwrm_shutdown_link(bn->bd);
+	bnge_hwrm_if_change(bn->bd, false);
 	bn->sp_event = 0;
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d177919c2e11..a1a939496ebd 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -275,6 +275,8 @@ enum bnge_net_flag {
 	BNGE_FLAG_PORT_STATS_EXT	= BIT(1),
 };
 
+#define BNGE_FW_IF_RETRY	10
+
 enum bnge_sp_event {
 	BNGE_LINK_CHNG_SP_EVENT,
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
-- 
2.47.1

