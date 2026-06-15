Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802F3AFAF1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552661; cv=none; b=Zcvw80OYMwuxBM3bEP/4wt7uCjYXzuXXviSXKla4GuLXc8YJ2Y0eNwrjrWdrge6u3NpUIpQnkKFS7uRq8IUM/Qq2I4z+ZP1SHsndgq672yA0nOo2qGgT0jbpKA+BLbE9MIH+/92nqKId0mMlOrDXs4GTEgWiTaj8Qq2+lhKtdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552661; c=relaxed/simple;
	bh=PDEWNmhQWCvGdMCu7E6cEINtfqKVBANG6PfpYYhSj40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyuodlUiuST475j566fSz0nd80VRaRo60TD2qrIfTK+DwdX1Vkx5Y031SdX5mDQeXi/Jk1fRv6ElIpMWLSccEwrVaA6grk4Mi+hSfZyDSjjDHcSj1aPOEIOl+cAEDta1A1ZI7t8sDOrtDJutSbMfz37uyfRmy04OFujmrZXXfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfCqPbA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfCqPbA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0531F00A3E;
	Mon, 15 Jun 2026 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552660;
	bh=4i1sj49Uq/9paJvXs5fVbG9vgxXdAKmcH+RVsk+ldfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lfCqPbA6AsiKIa4ByWGVsCjAyEjUilRn9Oomzc1A1PP2wT2B/2LhG131LhuMmnJPu
	 NAneq8lX+oL++2zhOQ370EILAbWmk9tkYkdzea7OUH9FwVxZTXPmgi6iZoDBvMtXU9
	 b8i+YfXEoD/qRb/AZ/gz5q4HpGxkZiVU4tbnZ5kIqR07PB/ONz7K470t0koL+bStU5
	 ELgHtOPWYt/n59JJeK9YNE8CFuM3kGMZ8aB3Gn/Z05625zszp6Lef5v1xLGRdyaqkp
	 0FoC106tceYJld86PSPOQbhN198EO5NYKLM3kTBFpDwq5OcrjynWe8ybo9BMTK269J
	 /5QAecHL80JNA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/9] atm: remove the unused send_oam / push_oam callbacks
Date: Mon, 15 Jun 2026 12:44:09 -0700
Message-ID: <20260615194416.752559-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atmdev_ops::send_oam device operation and the atm_vcc::push_oam
callback were the kernel's interface for raw F4/F5 OAM cell exchange.
Nothing assigns them a non-NULL value and nothing ever invokes them:
the core only ever initialises push_oam to NULL (in vcc_create() and the
AAL init helpers) and the Solos driver only lists send_oam = NULL for
documentation. The drivers that actually drove OAM through these hooks
were removed along with the legacy ATM adapters.

Drop both callbacks and the NULL initialisers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h  | 8 --------
 drivers/atm/solos-pci.c | 1 -
 net/atm/common.c        | 1 -
 net/atm/raw.c           | 2 --
 4 files changed, 12 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 82a32526df64..71c5bf6950e3 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -104,7 +104,6 @@ struct atm_vcc {
 	void (*release_cb)(struct atm_vcc *vcc); /* release_sock callback */
 	void (*push)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void (*pop)(struct atm_vcc *vcc,struct sk_buff *skb); /* optional */
-	int (*push_oam)(struct atm_vcc *vcc,void *cell);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void		*dev_data;	/* per-device data */
 	void		*proto_data;	/* per-protocol data */
@@ -170,12 +169,6 @@ struct atm_dev {
 	struct list_head dev_list;	/* linkage */
 };
 
- 
-/* OF: send_Oam Flags */
-
-#define ATM_OF_IMMED  1		/* Attempt immediate delivery */
-#define ATM_OF_INRATE 2		/* Attempt in-rate delivery */
-
 struct atmdev_ops { /* only send is required */
 	void (*dev_close)(struct atm_dev *dev);
 	int (*open)(struct atm_vcc *vcc);
@@ -188,7 +181,6 @@ struct atmdev_ops { /* only send is required */
 	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_bh)(struct atm_vcc *vcc, struct sk_buff *skb);
-	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
 	    unsigned long addr);
 	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index bcb1353877e4..4ad170a858ee 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1180,7 +1180,6 @@ static const struct atmdev_ops fpga_ops = {
 	.close =	pclose,
 	.ioctl =	NULL,
 	.send =		psend,
-	.send_oam =	NULL,
 	.phy_put =	NULL,
 	.phy_get =	NULL,
 	.change_qos =	NULL,
diff --git a/net/atm/common.c b/net/atm/common.c
index 913f7e32ce41..c6e87fc9bbfc 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -163,7 +163,6 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family, i
 	vcc->push = NULL;
 	vcc->pop = NULL;
 	vcc->owner = NULL;
-	vcc->push_oam = NULL;
 	vcc->release_cb = NULL;
 	vcc->vpi = vcc->vci = 0; /* no VCI/VPI yet */
 	vcc->atm_options = vcc->aal_options = 0;
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 0d36aeb3671b..1d6ac7b0c4e5 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -63,7 +63,6 @@ int atm_init_aal0(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
 	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
 	vcc->send = atm_send_aal0;
 	return 0;
 }
@@ -72,7 +71,6 @@ int atm_init_aal5(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
 	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
 	if (vcc->dev->ops->send_bh)
 		vcc->send = vcc->dev->ops->send_bh;
 	else
-- 
2.54.0

