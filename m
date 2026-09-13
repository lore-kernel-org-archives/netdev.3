Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190773ACA5C;
	Sun, 13 Sep 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303944; cv=none; b=mkDXT+5qIuyQ82R26A7QBNgRCf1J1EoCUmAgCEfy9OsFOSVPqke89IymcWgoTnv6Rb+FpYXILwOAzEbtEgsDNBkfYCCKc9LrtHY/ptluxS8L11VU471aThEOYaqP7ztuLgkcxJax3fu+Xzu8oYCjBHXyrrEKQvp38W2d0K3j3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303944; c=relaxed/simple;
	bh=o5oApsx/rdBFHW2i4W9ApDOHk5V0yHbQGMXXG9KPGvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SN8qM+SJe/0tNnoiOJouQjMkvlB6fnikvh8JtES2/YYSnh1dpS4mdWJWoNYo0CN7yCehJJyhVg8ECA7auPClsjC8lmE53EB0uv/Gy737MelXNjBUuf6cx3/dOI+qX8yj0kM4yU7n5dPfr6jfaXeEEsOESrQ5Dz6y8P1aeRUTWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SvSx3eZ9; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SvSx3eZ9"
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3f1;
	Sun, 13 Sep 2026 20:52:14 +0800 (GMT+08:00)
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
Subject: [PATCH net] octeontx2-af: skip absent MCS blocks in PTP configuration
Date: Sun, 13 Sep 2026 20:52:12 +0800
Message-Id: <20260913125212.110005-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad34e1303a1kunmddc12c282511d4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0kaVkxLGB1MHU9KGhpIGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=SvSx3eZ9XAPTlfV6xVdj1s2CB71IIl9sEjpUEL6GTyLtCaAugaCoJmXCQv6lakB+8kk2LvufOfW89iA2iwrR9EREmDBn1RQye68sberrMd7Y1rn6vtKERJ4D+5OFxmbakU0fGpCN3ChDCvQSAYylgiaQtrWhRpB9WjUhNHbUhT0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=MPOpKAV3OBLDwzkI77dQ9BHdlH69etdDfGQUc0oQJUc=;
	h=date:mime-version:subject:message-id:from;

A successfully probed RPM does not imply a matching MCS block.
Check the independent MCS lookup before accessing PEX registers.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 65cdc2b637a5 ("octeontx2-af: mcs: Config parser to skip 8B header")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index fce22e314cac..5e24d43d5fc7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -50,6 +50,8 @@ void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)
 	/* CNF10K-B */
 	if (rvu->mcs_blk_cnt > 1) {
 		mcs = mcs_get_pdata(rpm_id);
+		if (!mcs)
+			return;
 		cfg = mcs_reg_read(mcs, MCSX_PEX_RX_SLAVE_PEX_CONFIGURATION);
 		if (ena)
 			cfg |= BIT_ULL(lmac_id);
