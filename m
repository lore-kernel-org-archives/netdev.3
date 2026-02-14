Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956011D63E4;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771079169; cv=none; b=qc8WQqWCd9g2MM+kwZ516SftPNOQieNf/h7DFM1ss26yv1McLiIYGp4QozvfVAyAfeUrZHMproA1Ae5ct1bICimJePdrsDaR+K0sB8pXrDp6dFgNXEpq0ZK7WhW2e2UYWC61TC8RNXNKsFh7zHmax+Lrl2bN/fdov1NZn73ChcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771079169; c=relaxed/simple;
	bh=mODyDok++EknqeJdDI8pu9Phdr8eA4ugMTT20UGCnrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Idzs5j+/Ax3tMgjmf8ll1nmYdsj4tvEkI7DrEctDdxTBOcWdewbQqtyxyDwMu8HFi41RwAryOMGLkMybZvDK2XMxXQZjQ5SgxuiFXDCof8rtqy/SR/KF3WAQ5vgmwFWWGGRKMSMmgRi7FJP25F+nI20qeRHbwdAXlDGya//Wp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRg4sVS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRg4sVS6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21B14C16AAE;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771079169;
	bh=mODyDok++EknqeJdDI8pu9Phdr8eA4ugMTT20UGCnrM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oRg4sVS6/4314eOMFIcvswLjVz7zGnFpD21xGpqEE4trijO96Sc0OzY0jRM9jTszP
	 HrZbCrg4UWrkHIoBKp9Pv8/ABuWmiJ7KOg7q7T8wXNG/LNyRgZBQIuEPAUoFTd95qF
	 j4Mo0aJrkhYeRs9jO5M70peZdUm8kf2Tokh9+bCiYYb4MwmhZWT04Ej3tM51Jmyw5e
	 BAGBoj93RkuOf5BlVo6e8/Du81wVtLHV5k/rIt9fnrrpBLyHNaYEVabBlN6CR/tX7+
	 AbbCEBYkp/5lxeJSx742DcbNgUMYV2sjghnTIxvOEDEwCEgYBWSCNVmBplggzSngnu
	 F+aVAmArBVIqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B6EDF142;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sat, 14 Feb 2026 06:26:02 -0800
Subject: [PATCH] MAINTAINERS: drop enic maintainer entry for benve
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-enic-maintainers-update-v1-1-5bec573f90ff@cisco.com>
X-B4-Tracking: v=1; b=H4sIAPmFkGkC/x2MOQ6AIBAAv2K2dhNEPL9iLFAX3UI0gMaE+HeJx
 RRTzETw5Jg89FkERzd7PmySIs9g3rRdCXlJDlLIWshCIVmecddsQ4Kcx+tcdCA0TVe3eiqnShl
 I9enI8POfh/F9P8GmhphpAAAA
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771079168; l=707;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=hrrYJtxFXPrrNRPRr7m5o4Zl6ZakysaA78D4Co4V8aY=;
 b=SoxCx0+j3d2EBLo+jSVGzdIsR98faUNM3bzZwZFw9cpoxC81/pu3vEwFkePtPg2hywlDoKtvZ
 ZZMuiQrp08SA8RJWq3ZwrJXtUixDrvU9kpXYUjSffZgYBLqFBINCYZP
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Remove Christian Benvenuti from the enic driver maintainer list.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e5fb80c32c..8b122a39dacf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6173,7 +6173,6 @@ S:	Supported
 F:	drivers/scsi/snic/
 
 CISCO VIC ETHERNET NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
 M:	Satish Kharat <satishkh@cisco.com>
 S:	Maintained
 F:	drivers/net/ethernet/cisco/enic/

---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260214-enic-maintainers-update-f7968ab3b54f

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>


