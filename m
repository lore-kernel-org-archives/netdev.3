Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F063EC808;
	Sun, 13 Sep 2026 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303936; cv=none; b=LQFDvfst6gVVYYi50OYf3Zf+zR7VriIkydiYLGhyX1FszMwh1PlP+uhPXOlGPEBgBSy2oQqgLi9CBpcoZYMNrFT6B87FuUGgaZQn5PUjNjVWTChNYy5xLbIfHS+Lz665ZNe16NUyWhwYVbYgy8w3rrtrI02I1xuwljR80098R4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303936; c=relaxed/simple;
	bh=zTrMYEyhJA/x8TVISCU2RJz0BNZolnqJexKazjTnCm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7/cjVc/0Y98e6uZ+SO1fH1h6CZpiMHlasn/PIi5++kAFYVy/FMBeQjJnJhirIl0alkprB1Xai7sW/FE0huYbNvf5dsvngIEv+MZtVSb9xFnDs0dwdOw8TtcBH8QGqUts/yh//ZwnuCUzv2omGS/iH03XQf/egqXzHWA2xH6GHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=giHyvauA; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="giHyvauA"
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3ef;
	Sun, 13 Sep 2026 20:52:08 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH net] octeontx2-af: validate MCS blocks before initialization
Date: Sun, 13 Sep 2026 20:52:06 +0800
Message-Id: <20260913125206.109985-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad3351303a1kunm5ba25e222511c1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQx1NVh8eSEtDQ0NLGBlOGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=giHyvauAkWWATeXfmVWDhDLAp5Nf1JNvrq/b/RaYnS/q7/D0ki9FQq1tKvzUsdCWgTAitN8QJtgp+8/40w2kLITww5f4obvkOEeBd10UCQVPVEKPvosxvNnEKGBCKr64ZZkKnsN4lBoTMvb9gM+E3Tpab3cC40XfckXRPwG9SvA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=w4kZNmtGRQiUHJIIzrnO4tSSYdp/yOdZIDfvPa1VCSQ=;
	h=date:mime-version:subject:message-id:from;

The MCS count is a maximum successful ID plus one, not proof of a
dense device set. Validate the complete range before programming any
block, so a failed lower-ID probe cannot cause a NULL dereference.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index fce22e314cac..0ee2d0d698e5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -889,6 +889,11 @@ int rvu_mcs_init(struct rvu *rvu)
 		rvu_mcs_set_lmac_bmap(rvu);
 	}
 
+	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
+		if (!mcs_get_pdata(mcs_id))
+			return -ENODEV;
+	}
+
 	/* Install default tcam bypass entry and set port to operational mode */
 	for (mcs_id = 0; mcs_id < rvu->mcs_blk_cnt; mcs_id++) {
 		mcs = mcs_get_pdata(mcs_id);
