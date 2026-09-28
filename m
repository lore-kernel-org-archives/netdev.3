Received: from mta.kiivia.com (mta.kiivia.com [95.217.65.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8805263F44
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.65.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585250; cv=none; b=oNx3499fA4tE0bHuU8amfAsCcr8L9d70WsIJ479VHEaPAbYPsP0M5CtJFHsNo8BZAfVR0tf9CO7fY0MJ/D5XPpfmC24H5sw0W0rgwDTNa54FlFqwdic05y4HR7bf7mG7X3wu/v5zzIoUfyIJF1gfx8Q+GPrfJywsjRUvL6b6ADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585250; c=relaxed/simple;
	bh=4oz568CjYFq3wRD/Hmqkz+qIwafWxiN0GgI9BDHGMQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FSkK1pXR9t6Wf7ovs40uI+lISCthOCn01z2UscH+wppld5NFIAyXeO2KTr9YXFDENk07u4liIllh3RUzGDO+PuFPDuX566qayKuZJ4yR50HCz25r0dc1ui1oVI6UjA1rmFoxP/qsz9vWzrhkP2Ira7Gte2hvMoe4YkFjoiIiUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nocloud.org; spf=pass smtp.mailfrom=nocloud.org; arc=none smtp.client-ip=95.217.65.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nocloud.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nocloud.org
Received: by mta.kiivia.com (Postfix) with ESMTPSA id 2219CA8021D;
	Mon, 28 Sep 2026 11:47:21 +0300 (EEST)
From: =?UTF-8?q?Jari=20Sepp=C3=A4l=C3=A4?= <jase@nocloud.org>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Jari=20Sepp=C3=A4l=C3=A4?= <jase@nocloud.org>,
	kuba@kernel.org,
	sgoutham@marvell.com,
	gakula@marvell.com,
	rkannoth@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	linux-yocto@lists.yoctoproject.org
Subject: [PATCH net RESEND] octeontx2-pf: Fix RSS indirection table size
Date: Mon, 28 Sep 2026 11:47:11 +0300
Message-ID: <20260928084711.2462571-1-jase@nocloud.org>
In-Reply-To: <20260927154803.4b4bdf35@kernel.org>
References: <20260927154803.4b4bdf35@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The conversion to the dedicated RSS context operations replaced the
pointer to struct otx2_rss_ctx with an inline u32 ind_tbl[] array.
However, otx2_rss_init() still uses sizeof(*rss->ind_tbl) to set rss_size.
This now yields the size of one u32 (4), rather than the 256 entries in
the indirection table.

The RSS initialization and hardware programming loops use rss_size,
so only four entries are initialized and programmed despite the NIX LF
being allocated a 256-entry table. On an OCTEON CN102 with eight RX
queues, the table contained 0, 1, 2, 3 followed by zeros. Traffic was
concentrated on queue 0 and ethtool -X equal 8 did not correct the table.

Use ARRAY_SIZE() to count the indirection table entries. On the same
hardware, this restores the full table repeating queue numbers 0 through
7, and bidirectional multi-flow traffic increments multiple RX queues.

Fixes: 62e01d8c4170 ("eth: otx2: migrate to the *_rxfh_context ops")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/netdev/361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org/
Signed-off-by: Jari Seppälä <jase@nocloud.org>
---
Resending with git send-email because the previous email had a mangled
diff. The code change and commit message are unchanged.

This is the formal patch requested in response to the bug report with
Message-ID <361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org>.

Runtime testing was on an Asterfusion ET2500 (OCTEON CN102 A0), using
Yocto BSP commit 9a05f15b453377f50632ebbb57c87b7ec3270492 plus the
existing local board/build fixes. The kernel configuration was unchanged
between the before/after tests. The resulting kernel was
6.18.52-cn102-yocto-kvm, package revision 6.18.52-5.

The table was checked with ethtool after reboot, then bidirectional
four-stream UDP traffic was used to check hardware RX queue counters.
The upstream net tree has not been boot-tested on this device. Full
upstream allyesconfig/allmodconfig W=1 builds have not been run.

The diagnosis and patch were prepared with AI assistance and validated
on the physical device as described above.

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 175992188..0e78a0531 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -394,7 +394,7 @@ int otx2_rss_init(struct otx2_nic *pfvf)
 	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
 	int idx, ret = 0;
 
-	rss->rss_size = sizeof(*rss->ind_tbl);
+	rss->rss_size = ARRAY_SIZE(rss->ind_tbl);
 
 	/* Init RSS key if it is not setup already */
 	if (!rss->enable)

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.3

