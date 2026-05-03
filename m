Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850C176FB1;
	Sun,  3 May 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811028; cv=none; b=iG3dF8AgRLmXux+TALLJgT0R078vde2IXJUyRPe9bQur7OHeRd+TWrWEwIvWiclDRX1u6SJGfQVmhOuqy+dwCZBZQ7qOMpmYNP2PpRquXjCRdsI4lc2t45ygfAHQFv6hBmxbB9V884fQk4ZlxTfQCdZKdeF0kETDgTDTDWX9la0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811028; c=relaxed/simple;
	bh=og/KbJTzMBuS0M1D9ny3QC96ABI6fM7k015VpJIfs3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn99LQo+PouWk4p9823f6FHTvzGP/YIljICnNz2RhLVOday/V+TprQwgGTRSupp3t/TCXDDAH9JOF5YDEl+brtAvi8IXdhGawZuf4UvCHfAHDUwU7aKWTw9RSNDEbxHM/y84IZKEckMRrcYkvcYDat6Kmf+mxOfDRG4D59QadTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=SIiJoF+G; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="SIiJoF+G"
Received: by dvalin.narfation.org (Postfix) id 6A13D1FF1D;
	Sun, 03 May 2026 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEbXNhkPfNvLqtNPlezsj4uw+CjuYhQZoIojUxX1vQ=;
	b=SIiJoF+GuOYBQBXDzSTj6QFlEeRy8CMj9C1U41hLFPkn2Cm64Ao0vE5Ii6d/IIvnestbuu
	xWOfFqf2vXNwAS5TT76RFqXDHIiTJy2l0fe/g0aTd1WwItMnMMMljQGaaIWmjPOBJwj/SI
	lJNbiawix4V7SGWUN3O1pRQOSd2PYAA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:41 +0200
Subject: [PATCH batadv 8/8] batman-adv: tt: prevent TVLV entry number
 overflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-8-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=sven@narfation.org;
 h=from:subject:message-id; bh=og/KbJTzMBuS0M1D9ny3QC96ABI6fM7k015VpJIfs3c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQ32n5Z//5qFfO5u7mOG/kcPN8kMnnqfeyeeuXin
 JITywoedpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8ukNw39/tRAB9hurBKdP
 mnH/wvObR9LOl94+1qm7L3eCue+Bb7dWMPyVUhO2X/dh+eVfxZ6L97wJ1Pd4fqrjw1ROa6bcaxf
 VAiezAgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

The helpers to prepare the buffers for the local and global TT based
replies are trying to sum up all TT entries which can be found for each
VLAN. In theory, this sum can be too big for an u16 and therefore overflow.
A too small buffer would then be allocated for the TVLV.

The too small buffer will be handled gracefully by
batadv_tt_tvlv_generate() and is not causing a buffer overflow - just a
truncated reply. But this overflow shouldn't have happened in the first and
the too small buffer should never have been allocated when an overflow was
detected.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5a005d4e6cc6..630ae8a66beb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -804,11 +804,18 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u16 total_entries = 0;
 	u8 *tt_change_ptr;
 	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			*tt_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 
@@ -896,11 +903,18 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
+	u16 sum_entries;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			tvlv_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 

-- 
2.47.3

