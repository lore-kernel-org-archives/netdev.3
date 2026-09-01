Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1B38D401
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264461; cv=none; b=Uz/6DJuj6+k6vuUvD7b8Gvot5Nkv1jniS7eCTmo1HcSGNsEK5kNhHBWOKpcVQx0Mspr8eYQ6VKZ9leZ016Lvpc6H0vPuBk+PclcCNzR/CTOl7Xam9EfzZu+OWgBRi4N9mIjZsYuhcIcQP8kpDUC1TSuhua6Cnv+6wD+59t4I9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264461; c=relaxed/simple;
	bh=FEur/ri54hGyH4cUJi+IzbPc4XzKpmrDPdVGZZlD3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbx45pV1+nlMCc1vb67x5P9B2jM9sF/q1ydCDyl/KyCTdwk4xJy9P9umTyJYM1rrQvvn43aO5w+/85fN7CUNDAB0IUDeiOtkYD8YjFXjKn4JUjmjALrE6FQXmyLwZX4rbFdIUKKPI/gou7zQ2qObWIcyXzc0O4BQxOMZqfnF//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ic9GkfYt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ic9GkfYt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1045297f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264458; x=1788869258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=ic9GkfYt178AWtlfTnyZ2MAGL0YaF5XELFYsOAIcaOhUse5pRoTaqyQOGv0My0A4q9
         G3wBvwtJfSC1Y/2uhPzN0hTJOed4sDwdYdIlzz/E7Bm+4CoGrlxO09ZAv6oi+ba8x2Zu
         zhGVp/M6ZZ76QKlHfGZ1TiLJlvzFvH3zQR7nMm66wJ1HeqOgFK4WA08XhvCpVz2WZabb
         ZoQyMSqRwx/GJCNaesFK0Ql3O0rVAs7nKDCW6moOm6G+dfFro70SmYFbdcYHWjSWamS+
         9eOBprMibPN82JYsHwfpM2rlQ/Qr+9Cdrl4LqNI0+pfBZzAHdWL/sCyazDmFOnYGuuCT
         KKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264458; x=1788869258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bgh+p7Ku2uvfVDGLLZ5aGg6OM4iEpOCQPH5ASYbm68=;
        b=B4XwtLzz06cw08/VbZs4EyD8tq2CmCCiPtd7pXPkkXZj2Gy4PhQD/tnMwgBzwBwkZu
         t+ZZrPGP55ip22oXH6ZGyy8QulvnzRXd+yX91CVJsnI6pDzjW2JT+vwLexkxLTX5SfOq
         BCH3PC691tKBKrOQtkwn6RFXSs7K/vmlQga3MM/MZl1ILGwNDAplrkXefVYNpd1jbHXK
         gJkAwVySXrCijmUqhRyxOjsya2mHE1+Xt3qk5Hbe4GXyXaRi8HeuBuCSElLorOkucMiq
         7plUHpqk55YnbqOgAV0Wod5afJr6Za6xrR3PSDZi53HN075GZ0zvjt7yBqNEITW5+82N
         XRDw==
X-Gm-Message-State: AFuF++n+GrLDkKjwqkUuklc4vr88WdsQS9Nlq47voAmGuPhPG9Ekyu+R
	gLVxkucAp72F2Qg7pR4ndfMY0VHqnAcmgche6+0DGvz8Aew1pCuNjw2maKaELpJHgOAN8hDJt8X
	OBj8NO6CrXg==
X-Gm-Gg: AYBFou3tdxMeUDHpkxjAKywmqOCpHZyFtza4RupYltz9j85aR2mllYDuX+q8NTaAm6P
	HQhpoh/GcBPZd8vvgRA5YxJJsrHgqGf4vKJVRTerXOmw93BfqpCE70Uroyj8eKMNIh5R1BzhRxA
	N3VXMykmAyu8jwpxZytEDjFSmnqPcWYszUJ2ZRA5p5K6ieresaElGF6OtTpmTQosdtIMm8rBsSM
	eTak/nDFO2CBJ7a4wNXKJBAb3Rpb9Gee1A/dLExWNq8pZIipsUx1qgXLfQE5+BgsnftOa69LjzC
	JSHvV3P6xDJg1HArf1GY2OONKacHoCH0hb3eFvAh7v5emJh0GjseajzXsonrHPWVbNUBJiokDV1
	ry0IM9YD2QLu2RFUnm5OW3zUnImYcn1OpoddK4/eOJy5rxCaQ84mbLYI+G73eZPmoYTlK5SNOdK
	iMfwxP5wHK5TAZ0hzXWemf+lr2OoIdKz13eKQJf1qSuz0RUAQwf6JVdf5fe3WQcxN3AlXwfVlN5
	1m6dpoONJWJsrGccTBRNg==
X-Received: by 2002:a5d:5d01:0:b0:482:fd9c:5d25 with SMTP id ffacd0b85a97d-4844101181dmr14309649f8f.16.1788264458091;
        Tue, 01 Sep 2026 05:07:38 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d6e826sm4430021f8f.19.2026.09.01.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:37 -0700 (PDT)
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
Subject: [PATCH net-next 2/9] net: bridge: vlan: annotate lockless pvid use
Date: Tue,  1 Sep 2026 15:07:14 +0300
Message-ID: <20260901120721.747908-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
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

