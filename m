Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81A3515E2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445931; cv=none; b=rWjsycmIhP5O5b0sVXz6g4DnWHEmkxha6LMnmQMVZXKiojfwhgOtlH0cDbgAo4efWuVXTKu5sKx6jSBx+KGtRIe+KLJAWI4Xu/9aOf1MuLqXfABByWYahP88mjZW5pC/zXCx/Vxy5uc5COs6TqVtP+5aLsoEW++3N7D69xQONhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445931; c=relaxed/simple;
	bh=FEur/ri54hGyH4cUJi+IzbPc4XzKpmrDPdVGZZlD3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3oJE3hhXp30L2cTNCQpGWBbskgtcZh9HeBEuqBKhv8bzPjTv2ZqjhhEHGPd2wHpOWoq3j5ENeD52G3O59Teoh+wA0sKrYZzk02FUOQa9gAuu2SkXMS+KYGyAH8GU+cEdojJtaPG/24TcgvD2f469HTxgIe7WvSAhmedFDm0q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QuUGH9Hm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QuUGH9Hm"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a682579c72so3333732a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445921; x=1789050721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=QuUGH9HmKojCV3OdvQcNlZf+2vW5Wby83tQSWTZHIq1OrUgVlNAix3VgRWXqKgTx2v
         xcmRaC+DXVQI10EOetWAXYZN1LvS1ztkszP8sgEKa2h93QGyqaQCKe2si2ESUybR4Bl6
         3JZSSUxyccVN7/5kJNKMhConyTyWfnMwVyOTqKyJJa14AaQRvRRu8pKPHDbN5d2LWz3V
         XU33LTuRqzEdmrXVyMmRkJXZbwfsskzlkA3digyJhp/gx3nkVPfvqDCr3JRCu0OC74/l
         2HOL6pK00B/6t5Yzg5K10RHb5XXhmS51N543LF5i8sRY53LuiamIwgGZM3/KV+vnfcgF
         o6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445921; x=1789050721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=TWDOoq/635s4SGV+oksVGKwywFp10IlstQjvnLWvNm7cUa09Uz5y9VnTjCPTD7Ru1B
         vVANP7t2jj/u9tjzzp+PkbO3A8vPWmxd9seZKf2ZTloIh9cUzP0auWJY/LHAcau/bwvL
         zFJG3pcnetGoF6HLGLU7lA81klcnftrSztLLKwLE0E/77Hg/cKod7/ub1FwzfAlwDFHZ
         WJ3LLsHNVrwMgmzyU7atlJ/QAPIMNfx9kNNuRps+Ms581BiumX7BdbioG9vn7RM8jbP6
         nTQ0yqqniNlX/1nysnN8l6EGW2pK/G8I1IPF4bJKKOtCyCNMyH6p1Nuai+HGuJuuUV5G
         CtLA==
X-Gm-Message-State: AFuF++kxMGCYObkC6XcKqZf36EdCdC0o5rJVwdC4CSicOFkvviafcKy2
	5Yy/bUzaVgJGyLc4p7eXLqdPYKtnohO4D0xvTqyp2fKSx46BZxYnjBex/Uh+enH1qvECKkrR3P7
	qoMSA354=
X-Gm-Gg: AYBFou1fwEPsK9ORggDaBXqDQeOXUhI+eRnktojVAeaGJT3ju87VmE+M2fzqxzHP9b9
	srzV4V2yvxE658NPVk4WZAZOHVhi4sODLpcqvktQyxikH4Udil4Thp3MjqiG363Dh5rzrW2Yec8
	M16u427b4xdw8XJLG8604VYjveAxASTt297WuKHEozgGMAuX+I3Kx5g3ojoJ77HIVL6njwR4VAY
	fSOpGh8rju0mobtrHwd/BfArSnaaVfM4dYU71Ja9BCgPRp8udPOKVrhgIBxKRpIBKEX1NdC/t5B
	Pd7pVdNLz3HV7o5c7p3pZT5/5J9iqcks2ZOY9VBGANauk0qmmj1eyzXlCiL8lHZ+fjx0ULppO3F
	+r/AQYi6vy4dbtzu4VLEG3g/rMhuP4GZLbk7RB9kw9mRZInFKiySxPv5qYnw8UqaSLRlQCo/hnY
	tNFILo4b9ZvlrcsbTRi5FKJ1hp8GY+OjYrwuXd2mG5CXioeyJDHDOyt+U2iCvGZLEKcTNl+MmWM
	gqPZiagqKToQb86LJq8Ow==
X-Received: by 2002:a05:6402:51c6:b0:6a6:7f0c:32b6 with SMTP id 4fb4d7f45d1cf-6a682ac0831mr6738716a12.15.1788445920954;
        Thu, 03 Sep 2026 07:32:00 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6a67f8c7a0esm2400317a12.13.2026.09.03.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:59 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/9] net: bridge: vlan: annotate lockless pvid use
Date: Thu,  3 Sep 2026 17:31:31 +0300
Message-ID: <20260903143138.1574598-3-razor@blackwall.org>
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

Use READ/WRITE_ONCE to annotate lockless pvid use, br_get_pvid() is the
helper that should be used outside of the bridge vlan code. The rest of
the vlan places that access pvid directly all have rtnl.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 2 +-
 net/bridge/br_vlan.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5b2c22ad669e..0efd2e79e255 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1687,7 +1687,7 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 	if (!vg)
 		return 0;
 
-	return vg->pvid;
+	return READ_ONCE(vg->pvid);
 }
 
 static inline u16 br_vlan_flags(const struct net_bridge_vlan *v, u16 pvid)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 2ae6ffb23399..a53054fcc093 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -41,7 +41,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 		return;
 
 	br_vlan_set_pvid_state(vg, v->state);
-	vg->pvid = v->vid;
+	WRITE_ONCE(vg->pvid, v->vid);
 }
 
 static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
@@ -49,7 +49,7 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 	if (vg->pvid != vid)
 		return;
 
-	vg->pvid = 0;
+	WRITE_ONCE(vg->pvid, 0);
 }
 
 /* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
-- 
2.47.3

