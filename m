Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE0533D6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383172; cv=none; b=Uii3RkU3hPq02qchkIQH0VCQDwd1Hd52lPzuNs4pdR6t2Smn0AX2Xf8WukH2oHhNUktuvTRHYi6LAWVbJms5eYudxCUu98K8lP/U8ylRGoXaX0zKw3Tz/pifwZBj5Adsp4YrUIdk2jnino6mLm6Rh4xT/3OJCzZjYRmtmDafX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383172; c=relaxed/simple;
	bh=xrqARh8TQbs4ciR0dTroZcY+LxKJj3xqOU6/42yAmOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEZHZyfaOV0JykQoCetbTvvH+LDqkt2JxpDTVNvQcMMtHdmp8Wdx6+2p3lvnjryvkp0TK19hUAz/8nVEobsFxLjtjfmgZ5F3NEXY9i/IR9nZal481pXhAXGXRBRkpIjm3DNLJCacbaHOWfs+PeeEbyI8Xt6s2YrzHVMMsEE/hKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwUNIMyP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwUNIMyP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53512cd2f85so19094521cf.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792383169; x=1792987969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtQsxQjp047DVrmkRoHUNEQgOllzCNqACTLdhJlYHZw=;
        b=KwUNIMyPBZUpdVLmQGw7xXrjdUUSRoJx75R/qkVBEMmAE4hutbEYMWTw5mzutNF7hv
         TGkpdwChYoowhqjE5DQAxka4J39JFqgF6xKI90mt92pGoICN8nAEwl5cMjhWR2SJfbKH
         WeTsRzjMUH3x8AmzmtmH57tgeb1U//jCHBAiPZOzxdjkZoijJ7acXr76zDoHQ+7uf1qa
         lDTsvA2kM9QNFvIogMVpsGtC0WS7odQBniwNx/4d0/J1XGwycrRCHP1nNdFFTkWNQqpI
         UDw6Lb6BqpsdDGJA9HfPQn3BLrke2aRTHmEPzbmZR5GxNmsfIUzeh3xB/epE4xHoqSlj
         AoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383169; x=1792987969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtQsxQjp047DVrmkRoHUNEQgOllzCNqACTLdhJlYHZw=;
        b=GbRfaf8rOzMMn+Kf+4fh8l2Cuk9HFAnMN/wET/MiScG+MGnkN2szRz9oQ1BMvdAPK3
         ImI2fSqQQjpnfbtbT0vyRC+6wFHkFbh5AFWV5+mjdPZHcW5a2f1hK/iIpc+EUiKCQh5a
         t8Rq7AlBdPJyQHsv53onLRX/rN9RmAfGa5RYq3ezGoffO12Tz+JSKLRgTvU1nlnF2b2a
         aRugq53sCuwi/97BG10qxClY70mZ0V5GyXtP88eiyqfhMGxlS6U22C3Ddr6Dx2SfaUl2
         bpgTRGf9a4M/9jVv8F3QEGFAEcC0foRxDs31aJFOnO96kYqY/AI6dWea6sDEFmNlJht7
         Adng==
X-Forwarded-Encrypted: i=1; AKwUvBxZoAHTwkuVDHncaE3E2fdf5zYCoEr7Vb1TFGtVcGp5ZEUL0Q5Nme2NU+P6gOyDY0Vw4RLnws0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9jXo4V4VL1M6CwDEZWK5a2RAPtBauGb6Udv6G8pto9O+Mcj8c
	HiNlI5L7TzKx1IkIQTZLQ6CiltTFMtwpzv7YaKX78MdXsVVAsDqD5xHr
X-Gm-Gg: AYBFou3V/KP1fNm2B692yAWjs5QrCA8w04vbzzdrvcCQFlyw1hbcXKCyc9lrNBJJ3ta
	h7LYm64i1cjHpwdtBymaCfbGiVwdQV1TE9IWgaIpSvJM05WYqoG0ea72EkFXEV2BTJeb79g8PIm
	yIwlR2TtXrFGiLBgQQp82f+raeaCnA3hcA6hBZqF5voxtGvNWvNr6tGVyXdlMNl29F6X0T7NBB6
	6/ibUuJvDaq8RA8jX1wCmqv3SrmDZLzAzqWCLdc0WCLpnh1Q2KPFFJQsZtx4YJLzOiOaxwnZJTp
	AG+3J1pFoi57riXdM3o3S98REiKEYs0dy4Nz1Ls8PK3o+FqEX+F7i7BFflRktzkdpgwWTpzgqJs
	8zvCtsSzUffOvEUKHCYPNdIwHe4ddunV+HPlVnaMRVaj+Sz6WJWz0gurxHdk/xJsrmwc77E9v+U
	VKjGjbr6jh0ZzZpd1ggx3hGN3UzAySvmioeR/F5XH0OjkQVFTyLFE9NiOfSck8ZxJ7FCORsCLxl
	jRmhv/tfp7WQ2AIyvuS5A==
X-Received: by 2002:a05:622a:550c:b0:534:d386:fa67 with SMTP id d75a77b69052e-53645fe8defmr93215871cf.40.1792383168776;
        Sun, 18 Oct 2026 21:12:48 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536448b6ce6sm64078091cf.28.2026.10.18.21.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:12:10 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net v1] bnx2x: Close the VF when loading it fails after INIT
Date: Mon, 19 Oct 2026 00:08:23 -0400
Message-ID: <20261019041122.1054520-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnx2x_nic_load() hands the VF status blocks and statistics buffer to
the PF with bnx2x_vfpf_init(), and later its queues with SETUP_Q. If the
load fails after that, the unwind frees all of them without sending
TEARDOWN_Q or CLOSE to the PF. The PF keeps the VF enabled and keeps
issuing statistics ramrods that write to the freed statistics buffer,
and every later load of the VF fails, as the PF only accepts INIT from
a VF in the acquired state.

This is easy to reach: if the host has set the VF MAC address with
"ip link set <pf> vf <n> mac <addr>" and the guest brings the interface
up with a different address, the PF rejects it in
bnx2x_filters_validate_mac() after the queues have been set up.

Close the VF in the unwind before the memory is freed, as
bnx2x_nic_unload() does. Call bnx2x_vfpf_init() after
bnx2x_set_real_num_queues() so that every failure after INIT goes
through load_error1, where NAPI and IRQs have already been released and
bnx2x_vfpf_close_vf() only has to talk to the PF.

Fixes: 8d9ac297d18d ("bnx2x: Add init, setup_q, set_mac to VF <-> PF channel")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware; compile-tested with CONFIG_BNX2X_SRIOV=y, W=1.

 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5a9742fd3ddf..5463de650f70 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2689,13 +2689,6 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 	if (rc)
 		LOAD_ERROR_EXIT(bp, load_error0);
 
-	/* request pf to initialize status blocks */
-	if (IS_VF(bp)) {
-		rc = bnx2x_vfpf_init(bp);
-		if (rc)
-			LOAD_ERROR_EXIT(bp, load_error0);
-	}
-
 	/* As long as bnx2x_alloc_mem() may possibly update
 	 * bp->num_queues, bnx2x_set_real_num_queues() should always
 	 * come after it. At this stage cnic queues are not counted.
@@ -2706,6 +2699,13 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 		LOAD_ERROR_EXIT(bp, load_error0);
 	}
 
+	/* request pf to initialize status blocks */
+	if (IS_VF(bp)) {
+		rc = bnx2x_vfpf_init(bp);
+		if (rc)
+			LOAD_ERROR_EXIT(bp, load_error0);
+	}
+
 	/* configure multi cos mappings in kernel.
 	 * this configuration may be overridden by a multi class queue
 	 * discipline or by a dcbx negotiation result.
@@ -2967,6 +2967,15 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 	/* clear pf_load status, as it was already set */
 	if (IS_PF(bp))
 		bnx2x_clear_pf_load(bp);
+
+	/* The PF may still use the status blocks, queues and statistics
+	 * buffer it got from bnx2x_vfpf_init(). Close the VF, as
+	 * bnx2x_nic_unload() does, before they are freed below.
+	 */
+	if (IS_VF(bp)) {
+		bnx2x_clear_vlan_info(bp);
+		bnx2x_vfpf_close_vf(bp);
+	}
 load_error0:
 	bnx2x_free_fw_stats_mem(bp);
 	bnx2x_free_fp_mem(bp);

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

