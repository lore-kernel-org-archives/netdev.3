Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483B224AF7
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519446; cv=none; b=i5i2VN7r8jlxOLcATm3GpU/gVyBGoNryIBfVjWoADz/R5lkGF49NUyeYKhC5Y64J383r5DL8ssqYRhQpfyxzBtQ79wAQqLKsN2UUv2XQbO6PZNw0m4MhtPWrfMYstzmEuU2urEMaK+hydSQJLvMosJbjPLsj1bgY78l+jNNBg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519446; c=relaxed/simple;
	bh=QfWEIqf+Wp46qmgxsgwYftEzg52EL1A1VTmkcb9WrPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGm014VDAbQdmgLrA9/hMFXRvgAOQ4BPaTj7zzlk0m6T/BgFuwVieXtn4lT0UnJshhdP2gCrNqELDPB8ur2pGX/nX1iY0hS0aHYGjsmYDe7WrPJLE1hOYnf7FHJ+dHWhAxz4/EnStOgnJ5w+vRIIoQwtcmxlNtNqcvIZWdz9vU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=ce/L/9iX; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=P9w+v+cQ; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="ce/L/9iX";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="P9w+v+cQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=8mHjX6TyFjTvn38dtQM0Lm04BitL+7nkhimd3emS1kk=;
	b=ce/L/9iXo1+wtsbWX1FWQlukl1rPpDnsGRwerxkYvfVZnb1rnRp43MjWjYQ7bSsjzt3XxN51EHNY6
	 JBLDbwMEhzMIithPgX2hgcnBdhg8EhPZ1QA9iOMEgBkcug+Prt4cgOYWINERXE9pzbZbnfmTNg/NJs
	 oGmgzO2W9B3DrTZw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=8mHjX6TyFjTvn38dtQM0Lm04BitL+7nkhimd3emS1kk=;
	b=P9w+v+cQ6/3NywsZDlfe7ZbTpRCl7hSa4Nmudc0SVDhz7KODrPcvS11jNgvpQBrpa9SI0CVnBeHHX
	 C99gS+z67l9EWYzQSxa0iblwqXewo19usAUKK2606QwNoXzMBl5cHcbsFAAWaL+K8LJh0jCQnv4mCM
	 iTe3qbssmmAs7RY2bbfawX6p/wTxa+KPWLe5oXlEo0QcQ7qWJW3LdWb8RLgVHUQ21zeEaurv4Q3QR8
	 niBVgantLHQPgjCJXm48JwWTJB9gWmLBYNMYvaCkjk410WZG/tOM/UabJasSfvQoYmTSqIAyV/QdjY
	 ndxT162zwFWt++9W/M0ErrCX5XPP6pQ==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: f387f247-28fa-11f1-8751-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: f387f247-28fa-11f1-8751-f54febe22707:9
CFBL-Address: prvs=05455ff80f=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id f387f247-28fa-11f1-8751-f54febe22707;
	Thu, 26 Mar 2026 10:02:53 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id 7BFAC161F;
	Thu, 26 Mar 2026 10:02:51 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net [172.31.41.203])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 0474960B7D47;
	Thu, 26 Mar 2026 11:02:51 +0100 (CET)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com,
	andrew+netdev@lunn.ch,
	Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
Date: Thu, 26 Mar 2026 11:02:32 +0100
Message-ID: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Immediately after setting to 0 we are adding to it, and subtracting 0
from budget. Replace with just assignment and no subtraction.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index b72ab9951875e..3bd57527b1be6 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -628,8 +628,7 @@ static int ucc_hdlc_poll(struct napi_struct *napi, int budget)
 	hdlc_tx_done(priv);
 	spin_unlock(&priv->lock);
 
-	howmany = 0;
-	howmany += hdlc_rx_done(priv, budget - howmany);
+	howmany = hdlc_rx_done(priv, budget);
 
 	if (howmany < budget) {
 		napi_complete_done(napi, howmany);
-- 
2.47.3

