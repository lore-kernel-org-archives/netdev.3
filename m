Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEC244670;
	Sun,  1 Mar 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329620; cv=none; b=YtRA961EGQcrXIkGEabCimEM+yUeJSc+Ssqiw+ZZlEjWynepe+B4FkkDMasEmTNI0nQ2gT8vu9P/IjkaZyc+0BF/jEMYlNV+pSBmTCD8CBf/2n9OCQwsNAUIcuXTXJd4f5V2rnybcORwJuigcn+S88xSdVMraH9Yn+R/QA2j9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329620; c=relaxed/simple;
	bh=cMDV/GsPhNn31CguAG6uxms9WmKyLp/27GPTJViqR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5M/g4c4qTplRCH0C1BS2DT/DecGEJS/VJErPsucd6VWuRX8U5YwsO4D763tWeF7B1gvSbDnd1buvdbXutp3qlI2YtvN362bvUSB8sIOHZlSqdiILLhLDme8+VpN2JbKlUif4JUGELkBmtUNY5cutcLU87StpRB5ME05DvgoVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBzV1Y/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBzV1Y/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF92C19421;
	Sun,  1 Mar 2026 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329620;
	bh=cMDV/GsPhNn31CguAG6uxms9WmKyLp/27GPTJViqR0I=;
	h=From:To:Cc:Subject:Date:From;
	b=NBzV1Y/OSmNikrcrYkMJ68c83b0HwPmWISArMGRMCHWLse7sS7wGpUR21Vry+XRDV
	 4lrP6hy39We/0nbYP9axlfkLuumikIKRbfzU4PRVDf0GjXVgi1AjFK71lCm1p0CCBB
	 1sg+xzc0hjwB//vvJzd9Qt7xLmKdFs8ss8JMeCdODk6HYpNfK3NTfIuvHxU32LrOtG
	 9cALU6Ed3pDsy9yEHKjqQRu+5/6GvO3srm0MIxgXNQQ3kAe960TOFeiqjq0kNu9Zg0
	 /LuEOpSuiwi02//50G0iyNR7N5dZfshfoIGwzmqrkwkQk+yZfPn/1Ai8ramrb+Blmc
	 D45RPVfp7jUKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bo@mboxify.com
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "octeontx2-af: CGX: fix bitmap leaks" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:46:58 -0500
Message-ID: <20260301014658.1710141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3def995c4ede842adf509c410e92d09a0cedc965 Mon Sep 17 00:00:00 2001
From: Bo Sun <bo@mboxify.com>
Date: Fri, 6 Feb 2026 21:09:24 +0800
Subject: [PATCH] octeontx2-af: CGX: fix bitmap leaks

The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
Unbinding and rebinding the driver therefore triggers kmemleak:

    unreferenced object (size 16):
        backtrace:
          rvu_alloc_bitmap
          cgx_probe

Free both bitmaps during teardown.

Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260206130925.1087588-2-bo@mboxify.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 42044cd810b1f..fd4792e432bf0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
 		kfree(lmac->mac_to_index_bmap.bmap);
+		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
+		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
 		kfree(lmac->name);
 		kfree(lmac);
 	}
-- 
2.51.0




