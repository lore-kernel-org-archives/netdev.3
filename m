Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD93644D5;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057475; cv=none; b=LPqvcWJYC+9i50QdSgjL7HZdeuA56ZE7YEPrLcJCtZ+CsIZlDNco/zduCjLgradAEIMlK1jD1EKsF/tKRwV9RDk8Q21jcXPaPp8yxAvuSTj5dVTZFxl6le2iYFTnktPY9ARav7oRXxE/Lu/TZAEe/IjDVQZM/8+AynZck85aGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057475; c=relaxed/simple;
	bh=YhIMr4yYwBZ5EllsEmbIO/ym48ayC5JDhQ8YCwvYqy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPr7NWAkCypw/6JhmvjisqCeY5whcO9pn5nwsWcJY/6TS1y3iJs/BmauWtiY/v4vWMmOFS8kt8UwSKT4gdINPimXvyt5gA5V2oeil754ufj1+r/6BMM6NXDd/o+A1Bc967mzky0YEyCO/dCPks1KaLKrTD7xJTNDZn/e9Kk7NVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHa07fb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHa07fb5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7836FC2BCC6;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775057475;
	bh=YhIMr4yYwBZ5EllsEmbIO/ym48ayC5JDhQ8YCwvYqy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NHa07fb5a0VWwbCb+B08dKympPj4BhcFSThp1oOyjZGqmBINdqrpQ0CQdK4uV/cgH
	 VLcEKzJxNgACfGvSrZAyEnaLyYk5+lraR2uo8iVJk0T7DAwTYXC37HMNMQB/QdJxun
	 1POzcMoNlClwCPQ7pmOlkpEU1qcTflwtPo6IO4JDPKjMKdfCWHlv//EirUDZsR6YL9
	 aXxZHizkAkWiGuhyaYHi0jOPrai08yqPmpOXZBNonrxh4RdfARcrVARnJ2Sdf2VYlq
	 zf9uGK7BOcShwIicgkAt0gzb9arX0icA4O3IXYirQO9c20Vp69E3CwBq3yyMpL43JB
	 UeroWYrpF+FtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F11076381;
	Wed,  1 Apr 2026 15:31:15 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 01 Apr 2026 08:31:16 -0700
Subject: [PATCH net-next v4 6/6] enic: detect admin channel resources for
 SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-enic-sriov-v2-prep-v4-6-d5834b2ef1b9@cisco.com>
References: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
In-Reply-To: <20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775057474; l=2466;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=1nJliUotDMusF5w/UMmuyqwJOqlCYgr21D/fx9rjM1w=;
 b=z2YAxCOM/ke0G7APDq98nCEY38H4/XW/owLDHsp0MaxZl2zYCZcmhcy+Pn3PkC464V3BSi5hu
 6AJ5I0DR1D+AfrN34+602nw1cW+UMRz7DG0b7dj+e6d2kyi3WgYkyfH
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Check for the presence of admin channel BAR resources
(RES_TYPE_ADMIN_WQ, ADMIN_RQ, ADMIN_CQ, SRIOV_INTR) during resource
discovery. Set has_admin_channel when all four are available.

Use ARRAY_SIZE(enic->admin_cq) for the admin CQ count check since the
driver allocates two admin CQs (one for WQ completions, one for RQ
completions) and both must be backed by hardware resources.

Add admin WQ, RQ, CQ and INTR fields to struct enic for use by the
upcoming admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  7 +++++++
 drivers/net/ethernet/cisco/enic/enic_res.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 67fd780b1fa1..08472420f3a1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -289,6 +289,13 @@ struct enic {
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
 	enum ext_cq ext_cq;
+
+	/* Admin channel resources for SR-IOV MBOX */
+	bool has_admin_channel;
+	struct vnic_wq admin_wq;
+	struct vnic_rq admin_rq;
+	struct vnic_cq admin_cq[2];
+	struct vnic_intr admin_intr;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index bbd3143ed73e..2b7545d6a67f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -205,10 +205,18 @@ void enic_get_res_counts(struct enic *enic)
 	enic->cq_count = enic->cq_avail;
 	enic->intr_count = enic->intr_avail;
 
+	enic->has_admin_channel =
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_WQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
+			ARRAY_SIZE(enic->admin_cq) &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
+
 	dev_info(enic_get_dev(enic),
-		"vNIC resources avail: wq %d rq %d cq %d intr %d\n",
+		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",
 		enic->wq_avail, enic->rq_avail,
-		enic->cq_avail, enic->intr_avail);
+		enic->cq_avail, enic->intr_avail,
+		enic->has_admin_channel ? "yes" : "no");
 }
 
 void enic_init_vnic_resources(struct enic *enic)

-- 
2.43.0


