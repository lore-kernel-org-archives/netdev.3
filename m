Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E14562AB
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515862; cv=none; b=exzA2Vajh9XXDypUaVBsJ5sTRdFnw9tlR5g1kFk4NNo/L3vEaBzNUSXhjtFuALr9UB4q66DB7TViSLvzWTSVyZryJV5QpeizY/y1dtECV2JLyREtRkayR27P6JUfIUJA6Us/Q0oikL4ZrOGzKsQ3OCz1oHsE3qVGUntT8tD1l/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515862; c=relaxed/simple;
	bh=/AHuTK/EWIh6mSL+YYtp1VcqATQuiVubR8zEMFzuA3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnPlJBfviUqdlfuo+Wv26ffAltAw5ZSuDZKkgHjbNlCuHRSKPjddRVKLvlcTxFym2id4G9t27AD829IQWAkEVp2Hl1w3UqNsD3QNUgUgt8HKBi/ldH3XBgjdXruDsnKqmhlrJJEDsjqz8zNsDjtsrs8YwWKelMN0Z9JD1uNIiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hqVRRmbV; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hqVRRmbV"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-9673385b1efso373697241.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515860; x=1786120660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRdwnNt6x86Uy4JXaTIBlaSrTz+xz9fM5aVZPxECWm0=;
        b=klIdr+7P141J5axADpBnr81OZlpzZt+dZ/gK2RjqPbjQ74kR2tdCx6V6/PUIKUjOQn
         gT4AAQZoH3I44bsMGFigGJquqU4/QuPPayEjgbakC2+SLKzEeTir7lfgm94Lmb1H0AVW
         zdskrWFddz6/Uvk4ABa2VM5bY/V11JXX+1rS4jDTCutimoTVT+45fv4Ldp2AonJgQtaV
         LzV3M/2BfYns/BqPy3c0qDxyjNxXFL7p22yGyCept1Onu7fjudPHSiEbDgc3lA3xMq41
         AfeEfOdXatNco9zB/taDWKhtb9HgiZjG2L0fqG688JUfuCa7KXo4KBHp8b9DDMip5v7m
         KTrw==
X-Gm-Message-State: AOJu0YwLgidgp5IWTO7Ldo7cb+ZvRA6uHNA/NhuHkhg0dQipRtaSrrNI
	ewyNV7FbMqmIQQfmm7d0CNysYA9o0kOg6/X3Fk2i2V0O5Fa/3jpCZ85F/UpGI9LtuYzFmXmHS9Z
	P/Udi3e/8CtRPM0AMfJJUvUVHGj7Ih5Vu/v07B/srJNH2ccgka48FnV1b3QOO/G2yML1SNq3F+N
	ywBwkCZHZEtk5CG0I3fLQ4aj0bRM8DKAuILFr85pKpPzk+/2BCRWyzvLx97uWxiUraN6JFmDXBP
	xAVz/GpBw==
X-Gm-Gg: AR+sD13Lihh8HEK3r/gtqDVokrdMHYnd5JCRziLFjsDF4n7KcQOMSwYBGm517dcZHrC
	AEz18k2FTyM9Z8/WpcGhOj0TLXyNApi4hty5t+PH1fAuFmjt+vrnBFaUg3kE6+9cqSRMBD35hgu
	kj9BIgMK3M1sEFAJq0oyzGjJbEK+71ByS/LfV1K8S8ouHBs0VIdQZxA1wyR6JcyFa8IgXoHzj16
	GjBpAlzUcVzDAP+RWjj7rJX3z5LWw9gpmkmYHq9Ui4bI7MFEF3jDxduskmocTnf9Vwpx4YDllWs
	TFuyv+gotN8kIp3kIXGo2SgXPIkUTr8M3TXzE7P1JHEBVTQUL0j1onKF1SJprK8e1T6d/z5yRm1
	HoqC5mH2m5yEKcAYN0fjqcFCQpBxA24Whcjey+NxliyIWP97mCu+O8XDEw/ddMp6oOKAAu7JpTr
	UYPhS2WalLNnF+Rv234dCtc4qpuxmoBVwiOw==
X-Received: by 2002:a05:6102:fa0:b0:738:be73:55e9 with SMTP id ada2fe7eead31-75b23f69f46mr675233137.12.1785515859718;
        Fri, 31 Jul 2026 09:37:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-759b8a1166dsm147263137.4.2026.07.31.09.37.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:37:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84857446424so2283757b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785515858; x=1786120658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRdwnNt6x86Uy4JXaTIBlaSrTz+xz9fM5aVZPxECWm0=;
        b=hqVRRmbVi5Y2FiopOcDQiIB5Jucu8w45pd1ytRkWV4AVD8SKDl5MXtj/3S624TdE64
         JQRYDN/hk1IWVDDNu3gRkXCGnA/zLWtC4AmHDdlj0HiLMHe1X0SpZoUW25x73vsByBiI
         CUhMHQUucUhAkLL+VG6xK3dbvohkf6p/D9wGU=
X-Received: by 2002:a05:6a00:2e85:b0:848:2f7a:2e5f with SMTP id d2e1a72fcca58-84ee49a5970mr282207b3a.78.1785515858421;
        Fri, 31 Jul 2026 09:37:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e85:b0:848:2f7a:2e5f with SMTP id d2e1a72fcca58-84ee49a5970mr282178b3a.78.1785515857974;
        Fri, 31 Jul 2026 09:37:37 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm690127b3a.17.2026.07.31.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:37:37 -0700 (PDT)
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
Subject: [net-next, v2 3/3] bnge: send hwrm for interface down/up transitions
Date: Fri, 31 Jul 2026 22:07:12 +0530
Message-ID: <20260731163712.3463362-4-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
References: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
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
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index d47eb9bc5b8d..c2e865f8d9c4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -20,6 +20,7 @@
 #include <net/page_pool/helpers.h>
 
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
@@ -2864,6 +2865,24 @@ static void bnge_tx_enable(struct bnge_net *bn)
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
@@ -2871,16 +2890,22 @@ static int bnge_open_core(struct bnge_net *bn)
 
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
@@ -2927,6 +2952,8 @@ static int bnge_open_core(struct bnge_net *bn)
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
+err_if_change:
+	bnge_hwrm_if_change(bd, false);
 	return rc;
 }
 
@@ -3157,6 +3184,7 @@ static int bnge_close(struct net_device *dev)
 
 	bnge_close_core(bn);
 	bnge_hwrm_shutdown_link(bn->bd);
+	bnge_hwrm_if_change(bn->bd, false);
 	bn->sp_event = 0;
 
 	return 0;
-- 
2.47.1

