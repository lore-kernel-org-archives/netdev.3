Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A894BAA18
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445947; cv=none; b=PtqAi/aNnqCgmsbxRKjvfGWUIuCrHmGO9G+4PeC8elZhQaTF9BCW5FAC7QB6bjOymr+UtX5E42FoRC4ttnMMse4FRFfcUgfXrMuMGX+rNyC/CF351S0DJqpLHYz9JXHHeVfV91Gc1hPQPVJE6Qc7BKkgcQtWIrtdS0KUUBpG2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445947; c=relaxed/simple;
	bh=vDHm7CkTNErA2+VH4D/qGhWbmoMxmNZSOesyPx+peIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kujk8ya2J7axcd9wL/y8XnYLLRiRoChrrt10Pm/dvQ2ksJli2SKJtTI/9F/19la5fEy9gW6TzJNSt/rSDAtuS2Qde/ubEB47DD2K7O+nV1hN3FKGDrEakZ2PYOtsLiUKLPDNIGqA6kAlbKnkdaCFGq0o9NQavCgUGUOtR7KP2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=g4COhdKQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="g4COhdKQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c250f28f1cdso421337666b.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445923; x=1789050723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=g4COhdKQtiDcsWWePzeVYWRNAzbpNX/9Q6Hh8BwZkFtlZo2s3t8kONPOB7NpnfTgrs
         Uj8IfF2EFOPuKtjWj73qE9vaqsSISFhwtbvi/8vTCiy4s1O0chqWQZ8hdtLtoZFhoa9c
         XyXvL36wRg0ormxhOg56B5WVZr6LsmI3C2igW2LAFOH2QJriEha3T1u7dHBkir2dDT8V
         YNm28gtFZB+vkV5KYU6F8/dsyAefPUbyMzAjfnqHQGfHzhQoK5DdJYDXFb5UCb7Qks0P
         xBN37il+kph+RBoQx0oDv3FgLV7wJz7BMzTaXPzyZ5lw9sdxXSt/dJRfljl+ZUOGyK0q
         0PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445923; x=1789050723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=TA8BXUbi7V1A51HuI7z0kpOWorqhhPDAAd3X6lA5scj1e8NKTvPStdxB+GKoMWYClR
         o2NKrBJHtnH8OYRS49kkIomGWCduUV5GVsxbmAjwCxJoZ7cL3WCV6B+lr/G0p4CRuaxY
         yACb7OY3HjpiGhkM082RHdD9jLAbyFs+8nZ+8f6EG3fBsIw6TzSJjgu0izd7InKACzr+
         8n8b+G4taqx5ZF19ltUV6o3cxjFsUqm6Ovop5W6fQTx7JHK7h/qZI63tYqviKrWKDNs0
         GzEY52ie/q8MQvsSMFJd7qIqirI3Ba3E5UQVfceuIHJ2/vm9F3QHDTJU8OzAG++fR2UC
         H5Nw==
X-Gm-Message-State: AFuF++nXWXfW2Axtw+7UCAoBHpWKEbdzvhXAEY7UrVRPvcoRTAaWliwS
	hzuD6Nd8/WLOp8IyV/bvdDlQXh81xb1bFonIxA9kFvdSJYR7xHO5TEMwUDasy0mjWVolnYikPkD
	NT729IBo=
X-Gm-Gg: AYBFou2+L1+1FzVUOJyIyC2E2NFjJnT57vQxDYyCIvnLwUONFRN1k2k/glNASNqn3zo
	ayUHTtxum4l1CDhuv7an5VuC1sXaSm0IqJW7oMHENpR3mSN+iAD6D6hUQqeWbocDeq8b8oFcoy1
	ZXXlj+AOfXUz5O44mqnAuYo5zXiOGozktBUwS1tZ4t46QkCDsOYR4KpzHh5rh6oRy70bZ7cdpgs
	SShuZ0Tm1mCdg8qpThpvPpUDbXAaDdAqqsICv8iz4f435koV1STHW6IESgeqjix7CPh004cZlMk
	wFCfFbkKL9TfvXcTl8TXGolhExCWtM5W9Why4cERcWrXeJXseFDN1M49WzwI3gP1dtl9JfCxDKz
	GGphUTAGM2lPz67biqFvXbKhV9mXb/CWnO/GH2kG7BJPsbSRvl10GGZcRXmSaqJz2dmWS6Xd+Z4
	4KVIE5azOPwen8H8OEcx+bOs0ufmhmmYINYRSMMzuKvN+LEKFPjXN+tE+C3EI2jyV1T6c2xU28e
	+8G7sc=
X-Received: by 2002:a17:907:198a:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c25d563b583mr924706766b.22.1788445922972;
        Thu, 03 Sep 2026 07:32:02 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c25f423f2fbsm106058466b.58.2026.09.03.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/9] net: bridge: mst: use br_get_pvid helper
Date: Thu,  3 Sep 2026 17:31:32 +0300
Message-ID: <20260903143138.1574598-4-razor@blackwall.org>
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

The only place that accessed pvid directly outside of the bridge vlan code
was mst, change it to use the br_get_pvid helper.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..95e49ec8065e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -86,7 +86,7 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	if (v->vid == vg->pvid)
+	if (v->vid == br_get_pvid(vg))
 		br_vlan_set_pvid_state(vg, state);
 
 	br_vlan_set_state(v, state);
-- 
2.47.3

