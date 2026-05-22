Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98D392806
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491610; cv=none; b=bmThzCgetB8cLn5t0B3R189OBVsxxQgECe6ld8LO9a0FukQdFxl3JwjCvWj8e8Wu7/FwrQ9VGYyttB/a3xPvY/7oKQnlBcfjtjTRednMD7pustPyfJ+GO9cMwq1pouB6RV3Mmwugw/eRVBXc1kQ0SSfIxrfZYj4xiebHReoGv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491610; c=relaxed/simple;
	bh=+dO38vWVnPntzPMa6uWC5oXOE+r4y4zZiPcV234zR58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyk3ZL7qhg7/h2tsiQjI8VqK5X50vxLFDOGf/xwjRsxKhdn2uAssi3vkEeLqAmsr+2oAcxrLVw67zhdeM0j+HN+5sAoAGhkbJJMUCy7GrXs2c+8vR6LALqBqMrV4wkd02eZT47fpsZ1Y4kV2UfTysrdejEexC3R1OGJZlgTsRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOi7taJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOi7taJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4771F00A3D;
	Fri, 22 May 2026 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491609;
	bh=FrLOXVycPbX1V8Qou87V+wl/TjWQPo0IAe2l/b5YCBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOi7taJkeV4gT0yx2oTOQRPrkh8gdN8WVjOYSt64+68M+/8OTx3DFHNrjyW14IB3J
	 nDENDecKfRFkIaOZezgbbo9Tf+ChwbYXJa6F3gRkHHg9YDGZ7q08QrHZalp2O3pBSW
	 xT8QYlwiiOnDOj0/9eBsXqXbjNlIMJ2pwCx2c8kYVi/59OIm8xo2H4vVQ2fn+rznri
	 TuQMDBRs/UGLgHFADeuiRarU9MaaDqsw5snqmxhoevztvhmGo1y+hTJqV6/DbmJtI4
	 Z7fkQNzDs1k73JOIfu6dyKH4WH1VR9SEdjQZ/6iWemKJnX2Y12ImpRZEeff8qTNRTx
	 4YArulAG+aFzg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 9/9] ethtool: cmis: validate fw->size against start_cmd_payload_size
Date: Fri, 22 May 2026 16:13:12 -0700
Message-ID: <20260522231312.1710836-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmis_fw_update_start_download() copies start_cmd_payload_size bytes
from the firmware blob into the CDB LPL vendor_data[] payload without
validating that the FW has enough data.

Since the start_cmd_payload_size can only be ~120B an image too short
is most likely corrupted, so reject it.

Fixes: c4f78134d45c ("ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: danieller@nvidia.com
CC: petrm@nvidia.com
---
 net/ethtool/cmis_fw_update.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index 16190c97e1f7..291d04d2776a 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -130,6 +130,14 @@ cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
 	u8 lpl_len;
 	int err;
 
+	if (fw_update->fw->size < vendor_data_size) {
+		ethnl_module_fw_flash_ntf_err(fw_update->dev,
+					      &fw_update->ntf_params,
+					      "Firmware image too small for module's start payload",
+					      NULL);
+		return -EINVAL;
+	}
+
 	pl.image_size = cpu_to_be32(fw_update->fw->size);
 	memcpy(pl.vendor_data, fw_update->fw->data, vendor_data_size);
 
-- 
2.54.0

