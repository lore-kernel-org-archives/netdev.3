Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7103FF896
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471545; cv=none; b=dV807M5vjqCwKC92rxYhIFtSDOLNTeJ12Ih3oFo5iBnEMz1dlYLmgXVJcpEK19O4CAQRLQXpurDhdQ59Bt87xAufV7yFiIai7IPZQtuK7HNOdmM4qFDltpsxxreyPwhvx4GR4JOMaE3CbSktMviHMUhhA2J0TZEfMwbZbzYavM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471545; c=relaxed/simple;
	bh=MD947tOF1MuALRDYBBL+bT91exAqoD8mmAMSWPS//Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7aW4gyPS05BCYeAJfEK1c1iTjpQldFuaW0xC7sqCrVUETCAjfujAwdXUfeuxDH3Krywg9+ZyQYXtDwgaZO6tSvvsII7Mh4iePCsIU4yjJqQ1So1NGATOnMS30s9Q31Fb3bZg7/pI4yYnvuWJi1JKM3yzOlAKVqaI3xzW7usZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=OSYALhgv; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="OSYALhgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ulgidNTatzgbV+pIO5rkwxfSaR0IyvSe4n67ApgCno=;
	b=OSYALhgv/h9x5avi10rzV7YQBTGlIvE4j4pksJ3l/ZAs9Libpq3Yd15nuZ6g2jONmxpzM/
	ztLIFnZHXEMp0Y7/yBqhyMMhw+TSrIQhD+Q6By3a4hWUKJUCfBMlukp0pZ/9I0waN2abDA
	du/co0qqe7XS2J7tHX1tMDvS+q4WbqYcy62ROV3egliS6rUJTvRtFnfxoVeRcWOPLvhdlt
	vSfr1FTQW/UnNTI2lNKQFvSgnfAI2GOkayeaevy8mdCQ6AKPFIg6bQG0yDA/tz28/7QfuR
	hC5HcuDMWgkyRr2LqbUMwv1KXgCQU80zAeg41OErZRGtMcg0tvwimLaSU0M21w==
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
Subject: [PATCH net-next 14/15] batman-adv: tt: sync local and global tvlv preparation return values
Date: Wed,  3 Jun 2026 09:25:25 +0200
Message-ID: <20260603072527.174487-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The batadv_tt_prepare_tvlv_local_data() and
batadv_tt_prepare_tvlv_global_data() functions are supposed to work the
same - just with different sources for the TT entries. But both handled the
return values completely different. The global variant only made sure that
the *tt_len parameter was set to 0 and didn't care about the actual return
value of the function.

The local function never made sure that the *tt_len value was set to some
value when the operation failed. The callers were handling these
differences and made sure that they didn't access the incorrectly
initialized variable.

Sync both function as good as possible to avoid problems with new code
which might not be aware of these differences in the behavior.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5e134d08a80fd..44bbaa3bb37d1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -797,21 +797,22 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 				   struct batadv_tvlv_tt_change **tt_change,
 				   s32 *tt_len)
 {
-	u16 num_vlan = 0;
-	u16 tvlv_len = 0;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	u16 total_entries = 0;
 	size_t change_offset;
 	u8 *tt_change_ptr;
+	u16 num_vlan = 0;
 	int vlan_entries;
 	u16 sum_entries;
+	u16 tvlv_len;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 
 		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			tvlv_len = 0;
 			*tt_len = 0;
 			goto out;
 		}
@@ -827,12 +828,14 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		*tt_len = batadv_tt_len(total_entries);
 
 	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
 		*tt_len = 0;
 		goto out;
 	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
+		tvlv_len = 0;
 		*tt_len = 0;
 		goto out;
 	}
@@ -867,6 +870,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 
 out:
 	spin_unlock_bh(&orig_node->vlan_list_lock);
+
 	return tvlv_len;
 }
 
@@ -896,13 +900,13 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
-	size_t change_offset;
-	u16 num_vlan = 0;
 	u16 total_entries = 0;
-	u16 tvlv_len;
+	size_t change_offset;
 	u8 *tt_change_ptr;
+	u16 num_vlan = 0;
 	int vlan_entries;
 	u16 sum_entries;
+	u16 tvlv_len;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -910,6 +914,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 
 		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
 			tvlv_len = 0;
+			*tt_len = 0;
 			goto out;
 		}
 
@@ -925,12 +930,14 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 
 	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
 		tvlv_len = 0;
+		*tt_len = 0;
 		goto out;
 	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
 		tvlv_len = 0;
+		*tt_len = 0;
 		goto out;
 	}
 
@@ -964,6 +971,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 
 out:
 	spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+
 	return tvlv_len;
 }
 
-- 
2.47.3

