Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946272631;
	Sun,  1 Mar 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328475; cv=none; b=Au8v+UpxNdaRp5RuqAodHwkmIiIJr8Q69lJ4Yel+1W17RGhiYhbGkuramw4u/GjAe8TQmP3K2j2jIH0hbUGocfxd8Q4Fv4hA3LfSwsd7oMn0naj+46OSPnAWWzxtrddfEzZc0SF9UKw5RsKq3jso13Aywl/6sxoYVb7A3Qwi+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328475; c=relaxed/simple;
	bh=F3r882UWnPssaPVKAkQf+YzFKnjpTi7CWyCMiCEm3aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ezn1KjvVBYOwafd+kk2GyiUryP4AY4//SU9TVg2yWBeDRMv6k5dLf+LHxXbCFvDD7iuBTgoAmVOgXEB3zmaTgt/OzF9pOjebvfRU7GCZJfkFB3+G31JV0+jQY10nRjXhEUUwU/XY+vk9QuYY+FwxwXoNLJ3Km14px4U7tOp0Ldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrFjfP9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrFjfP9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB31C19421;
	Sun,  1 Mar 2026 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328475;
	bh=F3r882UWnPssaPVKAkQf+YzFKnjpTi7CWyCMiCEm3aw=;
	h=From:To:Cc:Subject:Date:From;
	b=jrFjfP9W+3mbZJ4wExUQSibPPPugS39AzpGdRe44THtlFgi9+QTYOouEf9e4ftE91
	 YW9rByu+l6t4IRxx25ypVezBHF5iycaSrHYG81OQdDwt1LVYyksKTDLQTdP91Qf/b7
	 yveXLpyO5n870nX+XDbxXTHUoy2HGjww9MqiE7p+St8QQ86UES1Lzy+a/DvGm6Swxw
	 UgfRWZMBQUMBLY8oawrHLIKegdFmEqYBH2LM6jzks51FMMi5NrPlf81tQOU4SMU7KX
	 IKKn4Rdn3Ge2Z1I8By/yMyENurkRNeobGPVbP9nG1hd9Recb3lqMER6iziU4M7ZBuS
	 GyC0JOWQJxQXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bo@mboxify.com
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "octeontx2-af: CGX: fix bitmap leaks" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:53 -0500
Message-ID: <20260301012753.1685516-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




