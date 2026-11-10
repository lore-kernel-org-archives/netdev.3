Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333392;
	b=CO1M5f3peAig/Q19jCMuhXVwR57YbEcLDgZQ2FYQjfLDZSPW7/3ksfWxUHJqkm/3WuUZ
	 vA2WbpnD2cXOsyegqXcOzdIVamYvSAAY3hrI46rzbZ5Xq0UEdpAG+LNpyt+2n0uDBFxcU
	 l4Qv1qqhjEXXyRMtCupYLcdZF8O27+/Sz3f6mXNjkqYJb1jL3rKzMNJjoQAg1dnWP8pQN
	 5JyRhSxLODtl6w5WILZn9YniVzBLVrJqkhhinNsrAV5L+jt5G3JY3RdYpE27vP7o2LRBn
	 I8XF6k09slwX3K4aETrwf4lSB/S1TGAo5YcpZz20FpbsqwldwjMZhd9VP0dO0yzZHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333392;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=M1nAtzlpeHXUapfmKhu366PtPUt/GiB1Ra4Z9QPV3Ko=;
	b=rO+2sbpQKWpQTX7fDKg5bWdHXkH5MruPZQRedXnJO20rQkiurCoXZy3y77Lmx2FWsP61
	 T1dkywezKcXwH4GLMzLZ/4WQF4b+x4hpBLMits0NwlNws9Sa/MGAioq42Rz+uCkDOuI5k
	 t9QwDgevs1Ox7n3isR2ZLCGk9ZqpefVorEPGBO8I4fiWqfBrR9MNr1opWcTWrPSeRQhY5
	 gEQphajuJHDNeh5XsUffs7VLmYnlbWWJHBAwGwOu3tJDhxEZpFti7YBrqqLzuDAcAYKPc
	 i2f1c4P+9IxS8TaBvRZEGTy7rxOvQFVcDIyFaJkZagA1BmvQWo0SHJn47OzQKB3Wp3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IkeSWgG1;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385F606A21E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6385F606A21E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IkeSWgG1
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so1073131a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333392; x=1794938192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1nAtzlpeHXUapfmKhu366PtPUt/GiB1Ra4Z9QPV3Ko=;
        b=CVq8HkylnDZXqmGAdgGUHKYD4p8XJKc7upvtsl+JNJCXYewTir5dlbfl8y3DZNhg4z
         d3L2Wczu56F0Sq3UT2uWjSs8JUnVcTw5De1zD42bVpgA12AMgZitcJQFMnPYtk5Vt1RL
         cqMi1Nb1G8VrMXPIyhOPaY4WkZdICtsALjTbRnihV1c4ZBRUyGwk0LMu3AKprP1+DpP9
         YWS9cgk5yz0LyyJcLFHZbgWMUQ35jkl1oqO4u3QF3e5AUMNUbZI/FT3V6eDJJu1QJDn4
         dMCFeF+sybslQHiIRSV7YSc9EP1ye4+dEHOB46LU1FLbLQZ236TD7+9/MaULnG7UmaCd
         PppQ==
X-Gm-Message-State: APuU4Z9oyqPOO1DB+PTof8V9ctl+09LLpaw6u1QwoDZ8/7sxptxB49Su
	Y+DXxSEUtqr6k+46a4SaKMIMztkqaRHnkUNwg/t9UuHVaOL/OjFW8Kp1CAOM5VoH7utNe6NnonJ
	8jlH3FISkH/oHxeeOG8zCa37P7VaDBwj1tIKGg+qkygiLVJ8edl+yrvpzCLYOl6zuqsbeCkdgrX
	r+TpMkvEBKVfCshh6oo5TWrXYUo8Opa1llEpY2lWKNWzMUffGLQj3zw+1p6xv7Ix6AnCEfW2xyC
	N1zA1VggN4=
X-Gm-Gg: AYBFou0o5EeqeAxLAfDZ325O8U8eX4dBortn7gKCZ2/5kJvKOukV6CHTYEOl7ySN7Va
	hYNfJimOxDFh6JCRi2O+AwZr4MsuUF34RsXc+kTuWFquMm73VP/3uUXz7g5uUDofdatuYBzsL5F
	rJzsvqkO0HgumLmU25yeqKiSxooHM70JmQVTLSdLkw2+kmNXenWeKj1GL+Y6W0t1qtXY4M/HGUC
	mqGb9rl8AZpwEL3bLoh+ItpgQkZC/QtlDjz2160Q2bhPn90jNwIIF7F46pLs0Twc4PBV8F0jgUc
	hfzkNJhid75xPj/c4mazDXNY5WGLBeQgEKW7cMDbhXogfrO0LBvKX7DkmvvAbNfYKXtAu3JLnhf
	JrcIJw8ITT7BmF4DEeFD4///RhzDaVhsDxIs2ZeohkBtlCVFfCm2tLLAn8yHUYS6Dq0NCPRZd1H
	HOwreYx87b8OHW/HQgTn6Kps2td3eQwpw1EFY=
X-Received: by 2002:a17:90a:dfc8:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b166cf786fmr3743258a91.24.1794333391650;
        Tue, 10 Nov 2026 09:56:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17d915366sm347562a91.0.2026.11.10.09.56.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:56:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91e9a0eae11so34169156d6.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794333390; x=1794938190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1nAtzlpeHXUapfmKhu366PtPUt/GiB1Ra4Z9QPV3Ko=;
        b=IkeSWgG1eaFhVJWSJVNylTyrQtIvZIkkcp65pT+kGQTu91pZUk+BzHTymo0GGpoO2U
         eL5AKDrvk1SJLLzDsmKLvH/SyPsmbB9vM5r+O4JoQXUO4NM6t+dlWFsIuv5tjAdybAqo
         lD7tcW8a/68V6ohy2C0VMhH0GGoifv9Cm8zkg=
X-Received: by 2002:a05:6a00:1915:b0:8b4:b88a:c2d5 with SMTP id d2e1a72fcca58-8ba860d9305mr4054412b3a.13.1794333014629;
        Tue, 10 Nov 2026 09:50:14 -0800 (PST)
X-Received: by 2002:a05:6a00:1915:b0:8b4:b88a:c2d5 with SMTP id d2e1a72fcca58-8ba860d9305mr4054386b3a.13.1794333014152;
        Tue, 10 Nov 2026 09:50:14 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm1241256b3a.0.2026.11.10.09.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:50:13 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	keegan.freyhof@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/2] bnxt_en: Map HWRM_ERR_CODE_PF_UNAVAILABLE to -ECOMM
Date: Tue, 10 Nov 2026 09:49:42 -0800
Message-ID: <20261110174943.2106347-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110174943.2106347-1-michael.chan@broadcom.com>
References: <20261110174943.2106347-1-michael.chan@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

The current use of -ENODEV for both PCI being disabled and FW's
HWRM_ERR_CODE_PF_UNAVAILABLE errors makes it impossible for the
caller to distinguish between the 2 errors.  As a result, a disabled
VF device will cause the driver to pointlessly retry setting L2
filters believing that the PF is down.

Fix it by using -ECOMM instead for HWRM_ERR_CODE_PF_UNAVAILABLE
which means that the FW is failing the command on the VF because the
PF is down.  This new -ECOMM error code which is more accurate will
now propagate to userspace instead of -ENODEV on some VF failure
paths when the PF is down.

Fixes: 662c9b22f5b5 ("bnxt_en: improve VF error messages when PF is unavailable")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 14 +++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c |  4 +++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33c4cacc8ffe..9d232d835758 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11319,7 +11319,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	/* Filter for default vnic 0 */
 	rc = bnxt_hwrm_set_vnic_filter(bp, 0, 0, bp->dev->dev_addr);
 	if (rc) {
-		if (BNXT_VF(bp) && rc == -ENODEV)
+		if (rc == -ECOMM)
 			netdev_err(bp->dev, "Cannot configure L2 filter while PF is unavailable\n");
 		else
 			netdev_err(bp->dev, "HWRM vnic filter failure rc: %x\n", rc);
@@ -12477,7 +12477,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 	rc = hwrm_req_send(bp, req);
 	if (rc) {
 		hwrm_req_drop(bp, req);
-		if (BNXT_VF(bp) && rc == -ENODEV) {
+		if (rc == -ECOMM) {
 			netdev_warn(bp->dev, "Cannot obtain link state while PF unavailable.\n");
 			rc = 0;
 		}
@@ -13954,7 +13954,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
 	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
 		rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
 		if (rc) {
-			if (BNXT_VF(bp) && rc == -ENODEV) {
+			if (rc == -ECOMM) {
 				netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
 				rc = -EAGAIN;
 			} else if (rc == -EAGAIN) {
@@ -16997,7 +16997,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	}
 
 	rc = __bnxt_reserve_rings(bp);
-	if (rc && rc != -ENODEV)
+	if (rc && rc != -ECOMM)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
 
 	bnxt_adj_tx_rings(bp);
@@ -17007,7 +17007,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	/* Rings may have been trimmed, re-reserve the trimmed rings. */
 	if (bnxt_need_reserve_rings(bp)) {
 		rc = __bnxt_reserve_rings(bp);
-		if (rc && rc != -ENODEV)
+		if (rc && rc != -ECOMM)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
 	}
@@ -17033,7 +17033,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	bnxt_clear_int_mode(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
-		if (BNXT_VF(bp) && rc == -ENODEV)
+		if (rc == -ECOMM)
 			netdev_err(bp->dev, "Cannot configure VF rings while PF is unavailable.\n");
 		else
 			netdev_err(bp->dev, "Not enough rings available.\n");
@@ -17411,7 +17411,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bnxt_aux_devices_init(bp);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
-		if (BNXT_VF(bp) && rc == -ENODEV) {
+		if (rc == -ECOMM) {
 			netdev_err(bp->dev, "Cannot configure VF rings while PF is unavailable.\n");
 		} else {
 			netdev_err(bp->dev, "Not enough rings available.\n");
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 5bfabdca7d0e..de02d1baa751 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -360,7 +360,7 @@ static int __hwrm_to_stderr(u32 hwrm_err)
 	case HWRM_ERR_CODE_CMD_NOT_SUPPORTED:
 		return -EOPNOTSUPP;
 	case HWRM_ERR_CODE_PF_UNAVAILABLE:
-		return -ENODEV;
+		return -ECOMM;
 	default:
 		return -EIO;
 	}
@@ -716,6 +716,8 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
  *	ENOMEM: HWRM has no buffers.
  *	EAGAIN: HWRM busy or reset in progress.
  *	EOPNOTSUPP: Invalid request type.
+ *	ENODEV: PCI device is disabled.
+ *	ECOMM: The parent PF is unavailable when issued on VFs.
  *	EIO: Any other error.
  * Error handling is orthogonal to request ownership. An unowned request will
  * still be consumed on error. If the caller owns the request, then the caller
-- 
2.51.0

