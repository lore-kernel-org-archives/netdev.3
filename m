Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6459B662
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184302; cv=none; b=OIz4NSgysGJp4d1Iwr48S9aG36faFzntTGNDccYAwPec2JgAv2Pf2yNPcLFfi8j3O9BrQl8GU+6IIky8/xQI6oMIMKEEhrZGj5nfmsznuod3pNu7qm0bL0j8dCKkfn50t0SOg18nXbBwd1wzezXd7Hm+RcDRWfa82Iwxb3VYqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184302; c=relaxed/simple;
	bh=x+VocDDf5M+nvg2WJScmbbX9j16SL9Iz7yX0eBqg+Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjM3Tey8zSEIcPlakid0eumQ/RiUucOzifY1yVBaHIx2oGfnvwVycdA6VTufCCL3gCfIBWB/8yPdHRXL4gV1Rut5xALy46QAPxQgHtU5iPJic1eMvsRT3iYjk8J6qxgZk6LDhYy/VWgENnDV2NG4hivBz8/9ojk19/f6vWVoNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=kvyKXH/6; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="kvyKXH/6"
Received: from kero.packetmixer.de (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9C4F6FA197;
	Mon, 31 Aug 2026 15:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9djlSccpnSy7X9rubGoKjj29XMoDwYx5YPADpj9abOg=;
	b=kvyKXH/6eHNfqquj7moJ4cukey3QnXE7eW1DTm68acRIcvfac+uXEgMwIcAHVKiX8GyqGl
	fNB6yVVqgFMM6TXd/96UAYDjoVMG/8gM3Qf6vvlk2+a6ig5V//akmq/YrQ+bpSfo7//kaY
	Vq60sAnxQQMY39yqTV4vK3ZBZxSTz74kmLE3eXCFZiQlpo8/Bs5stpCegrjCd/vVpLVotV
	knNEqZh7SyxapqzAnsJm8hP7+T6+99HvmWit22RsfhjxYsOxyUIBm/EbNXRcRr9Vi9ZiBc
	RWy90Q0k0/nAf2kty0sNUovtidqjsEMo22H8NHjF0u/JZhKwXOEJ9XRUYAriEg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 05/15] batman-adv: use more descriptive var names for is_similar_or_better
Date: Mon, 31 Aug 2026 15:51:07 +0200
Message-ID: <20260831135117.574836-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

neigh1 and neigh2 is not really helpful when looking at a code which needs
to judge the metric similarity between a candidate and a reference. This
already caused an implementation error in the B.A.T.M.A.N. V bonding code.
Simply using "reference" and "candidate" for the neighbors is a lot more
descriptive and makes it easier to understand the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 25 +++++++++++-----------
 net/batman-adv/bat_v.c      | 42 ++++++++++++++++++-------------------
 net/batman-adv/types.h      | 12 +++++------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe8f4f7..3fe09b4c30463 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2424,25 +2424,26 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
  *  than neigh2 from the metric prospective
- * @neigh1: the first neighbor object of the comparison
- * @if_outgoing1: outgoing interface for the first neighbor
- * @neigh2: the second neighbor object of the comparison
- * @if_outgoing2: outgoing interface for the second neighbor
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the metric via neigh1 is equally good or better than
- * the metric via neigh2, false otherwise.
+ * Return: true if the metric via @candidate is equally good or better than
+ * the metric via @reference, false otherwise.
  */
 static bool
-batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
-			   struct batadv_hard_iface *if_outgoing1,
-			   struct batadv_neigh_node *neigh2,
-			   struct batadv_hard_iface *if_outgoing2)
+batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *candidate,
+			   struct batadv_hard_iface *if_outgoing_cand,
+			   struct batadv_neigh_node *reference,
+			   struct batadv_hard_iface *if_outgoing_ref)
 {
 	bool ret;
 	int diff;
 
-	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
-				       if_outgoing2, &diff);
+	ret = batadv_iv_ogm_neigh_diff(candidate, if_outgoing_cand,
+				       reference, if_outgoing_ref,
+				       &diff);
 	if (!ret)
 		return false;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0d0a226c3fd0c..596889b3522d0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -514,40 +514,40 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbours have
  *  a similar or better throughput
- * @neigh1: first neighbour to compare
- * @if_outgoing1: outgoing interface to use for @neigh1
- * @neigh2: second neighbour to compare
- * @if_outgoing2: outgoing interface to use for @neigh2
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the throughput of @neigh1 is more than 3/4 of the
- *  @neigh2 throughput
+ * Return: true if the throughput of @candidate is more than 3/4 of the
+ *  @reference throughput
  */
-static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
-				  struct batadv_hard_iface *if_outgoing1,
-				  struct batadv_neigh_node *neigh2,
-				  struct batadv_hard_iface *if_outgoing2)
+static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *candidate,
+				  struct batadv_hard_iface *if_outgoing_cand,
+				  struct batadv_neigh_node *reference,
+				  struct batadv_hard_iface *if_outgoing_ref)
 {
-	struct batadv_neigh_ifinfo *ifinfo1;
-	struct batadv_neigh_ifinfo *ifinfo2;
+	struct batadv_neigh_ifinfo *ifinfo_cand;
+	struct batadv_neigh_ifinfo *ifinfo_ref;
 	bool ret = false;
 	u32 threshold;
 
-	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (!ifinfo1)
+	ifinfo_cand = batadv_neigh_ifinfo_get(candidate, if_outgoing_cand);
+	if (!ifinfo_cand)
 		goto err_ifinfo1;
 
-	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (!ifinfo2)
+	ifinfo_ref = batadv_neigh_ifinfo_get(reference, if_outgoing_ref);
+	if (!ifinfo_ref)
 		goto err_ifinfo2;
 
-	threshold = ifinfo2->bat_v.throughput / 4;
-	threshold = ifinfo2->bat_v.throughput - threshold;
+	threshold = ifinfo_ref->bat_v.throughput / 4;
+	threshold = ifinfo_ref->bat_v.throughput - threshold;
 
-	ret = ifinfo1->bat_v.throughput > threshold;
+	ret = ifinfo_cand->bat_v.throughput > threshold;
 
-	batadv_neigh_ifinfo_put(ifinfo2);
+	batadv_neigh_ifinfo_put(ifinfo_ref);
 err_ifinfo2:
-	batadv_neigh_ifinfo_put(ifinfo1);
+	batadv_neigh_ifinfo_put(ifinfo_cand);
 err_ifinfo1:
 	return ret;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e799e2..99667f632d4d9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2087,14 +2087,14 @@ struct batadv_algo_neigh_ops {
 		   struct batadv_hard_iface *if_outgoing2);
 
 	/**
-	 * @is_similar_or_better: check if neigh1 is equally similar or better
-	 *  than neigh2 for their respective outgoing interface from the metric
+	 * @is_similar_or_better: check if @candidate is equally similar or better
+	 *  than @reference for their respective outgoing interface from the metric
 	 *  prospective
 	 */
-	bool (*is_similar_or_better)(struct batadv_neigh_node *neigh1,
-				     struct batadv_hard_iface *if_outgoing1,
-				     struct batadv_neigh_node *neigh2,
-				     struct batadv_hard_iface *if_outgoing2);
+	bool (*is_similar_or_better)(struct batadv_neigh_node *candidate,
+				     struct batadv_hard_iface *if_outgoing_cand,
+				     struct batadv_neigh_node *reference,
+				     struct batadv_hard_iface *if_outgoing_ref);
 
 	/** @dump: dump neighbors to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
-- 
2.47.3

