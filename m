Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDE4B7176
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445949; cv=none; b=P6aAcJNtnhTrLACXg/8qWRrDoM1CUE0udnsHcuAQh65MrNBANzFHFuDNNJ1xep2b8TIMj0tfF4HSfLXBzOCIZIAW+FUXo8d+swjRP3b+seBQOpp6keKhDpHjaQR6c+OWGBifZ7ijzfN5ITdB7BwwrDAoVo9NwucKkyQBjglpy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445949; c=relaxed/simple;
	bh=yJfkb3hM5Pba0nKvWUAIgOdfux2UtM7ON45POiZc+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bcsy9+5VT0F7bUnBllRpZTNubqtk0M7R46zBBeltyqjfmFDQxZ9Dvxb5GehLHGosUF2WKOi/OUn3l3wWnR7PgbTqx6V1DlH4Ly2lwMDZakFROVPZWglR/aHjSNEbe0xcKI0e5swrV3oyGmn+CLiBA5krqSUknWU3xvJQLVFXdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IPL+uPKZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IPL+uPKZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482ea739de2so1364847f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445930; x=1789050730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=IPL+uPKZX4W0q/wQ5QJbutwLiml1ZLOkzwVTwE8nT69EC7J0GxiEJSN7YPILbMpPzS
         0kTtfKwYleQL+vW6ap+1TudukLKKURz3eiFe0uYuV9V+EfAZ/weUn4PA5HK8oXAj2Uy7
         fJEIK0UjXyh0COYoIJ7UsL+IKrdJywp+pGUhlfmWMegtZtT67ot6ieCK/fDfYfz70neE
         uekYcJ5dNoLKTabcOmmQZkNPdqNSAVzrWAa8bJNfY/4cyykWhtzrXH5wqB/IY/815E5u
         R69096zi5jHkJyrpuLvVtw7MV8Yz8QPyQA+xl26ecIVRp353rabj4uvDdIq3Ex7SM7DE
         2o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445930; x=1789050730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=DlFsQnPrTYjbiTi8C6x9k8Yh5xv31VDMPfkYEUBIsjpPiQd6MOibxLaZ0VN3fjKpOf
         bbgOZWy2FT237o/9RWd9txf1hWzK5+XQq0hPLqw7i0ac93r6y4HBQcOvPcsuEFAWUVVv
         JA4FpiZdmwQhl1DS2LV1jNK00GvY8F9NVXj1bQy6k8pr5YKK14ZTnlCNA1Nkk9Bu+pT7
         ltMjAl5HtDuXM3h47bFf843dqpN2QEqHOAKLbgd7EEqaj074w+FJaQOqIayao6c7b7iS
         fCJqYFjDAdXyVhEyS/hdUvGvqCc61zP1IXMF8Vf1X9lYYgJHBHNzpLa7DwCUcadCks84
         HYzg==
X-Gm-Message-State: AFuF++mN8RwFfOeKIdDEUxOnz6fnbxNEBfLt67AnNtKT0A9WsChfG2aO
	iqYhfhqDwpPbwQhjeKlR0eOtt/uTun/ChDZGVrRWwVAED7ysEfMe8C77MvLoqW9yZTd1j/fRKY0
	GnUGpdPA=
X-Gm-Gg: AYBFou0ddgxLqB+Snsy8LmWXyL/pi1qsvbMnqqsiZf93xReDJiQF9Xn1YIaH5TWZAmx
	ky25xBq8YGvCPgNJoTF1Vz3K+qVweKH8qar006rZBSjwgxvm3MRCFl7rPFYSCO/3SvzaRTbWKkj
	GjoJaZjoYC+jK6onu4VK3sYIKSWWydkH2vSH1qBFWE5NbCY8y9tpXe1eg5k2dtWKBhSKOyPvu/Y
	hFBz0MeBYFHLUKJn4Hx3ivqztkBpTdo4as7t+JG0JXShjIn8Bgklibdf4I//y8DF/Fdtx5ytulk
	GANeXIokieWWHLdVyy75hXppz/u5Cu1LIaY+WKTMK06RIxFnm/cH6mQ8VnFm7SoJR0YJxeC1I32
	0/t4Xyc4sOPmyeMMrpzaJzjSzs61ZWdGeLhRBEn7KMSABPrbn/MoOGxyokuRIbVdsBCFTnI5sDY
	A/hUOmO/dtHAyRWBPa/HnE/oJJX1etL7L/cqPjieVBeDfPmK4dHEhp5R/xlIAFGNPsKOyN0hwMj
	DL78F+87aU=
X-Received: by 2002:a05:600c:224b:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49cf5c03b82mr6106425e9.13.1788445930276;
        Thu, 03 Sep 2026 07:32:10 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d587csm81801485e9.4.2026.09.03.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:09 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 6/9] net: bridge: vlan: annotate lockless use of num_vlans
Date: Thu,  3 Sep 2026 17:31:35 +0300
Message-ID: <20260903143138.1574598-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate data races around vlan group's num_vlans, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c |  4 ++--
 net/bridge/br_vlan.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 62ce96d9ba32..ae76df0de05a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -81,7 +81,7 @@ static int br_get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		return 0;
 
 	if (filter_mask & RTEXT_FILTER_BRVLAN)
-		return vg->num_vlans;
+		return READ_ONCE(vg->num_vlans);
 
 	rcu_read_lock();
 	num_vlans = __get_num_vlan_infos(vg, filter_mask);
@@ -531,7 +531,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		else
 			vg = br_vlan_group_rcu(br);
 
-		if (!vg || !vg->num_vlans) {
+		if (!vg || !READ_ONCE(vg->num_vlans)) {
 			rcu_read_unlock();
 			goto done;
 		}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 102792f20a5e..95187a607ec2 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -344,7 +344,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 				goto out_filt;
 			}
 		}
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 	}
 
 	/* set the state before publishing */
@@ -367,7 +367,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 out_fdb_insert:
 	if (br_vlan_should_use(v)) {
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 out_filt:
@@ -417,7 +417,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 
 	if (br_vlan_should_use(v)) {
 		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 	if (masterv != v) {
@@ -695,7 +695,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 		return true;
 
 	vg = nbp_vlan_group_rcu(p);
-	if (!vg || !vg->num_vlans)
+	if (!vg || !READ_ONCE(vg->num_vlans))
 		return false;
 
 	if (!br_vlan_get_tag(skb, vid) && skb->vlan_proto != br->vlan_proto)
@@ -757,7 +757,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 
 		refcount_inc(&vlan->refcnt);
 		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
 	}
-- 
2.47.3

