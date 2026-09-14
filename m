Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094483D3314
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376107; cv=none; b=NQpeznA27ctTTqq4V+E07msmZaQXdAQVVo1RMpyW3qA7pnrd4E2/H6KZtdmqHKVDUUCL1hzh92u9vXOmNUBQMvwKPZIa0X0DnQcEU3OX0V4BBoiO7Uvju6ZpzBrI+SI1b7frEdT+cGSIf2JJMyntwCOiFmSWVoWGj2zNdwj89n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376107; c=relaxed/simple;
	bh=NtW1s5TM8w+nL85SG/lHCrwnPQJycA+8iAW+DfLcEfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8kJXL8n1DHzSspnOuvO3BHGctegfD8jYV792Dkls8PJ7A7bEhHwC74/r0NO3Yn4dyM9oE3vNqf3byD98sburr35d8cmuszbxYa8MqC4yDhYMuUf6LS2T2C3zTXfGlamGI4VPdCxdVOf1g3aSi+NsK5mQZgjHmd1+O8nB1kN1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYQF5I9S; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYQF5I9S"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so287782166b.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376098; x=1789980898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0EQZjh8FpaL9SkuEWQ6ncbogVE07+uLcTnWo4fn4u1w=;
        b=EYQF5I9SCwV+LLFVX/mjPN2DUUIhZJG4bolKsBbRbhnwDiUqKBepEipTcodcvOuq25
         I7tAcXaoT5ntMNtTALMFfAyRgxA2wiviYo+XDA1IADQunCo+fPyIoIxiFwtGZKDdZiKI
         wZCUeLyneWvhre0x/Ydkf4asK01xgvFXf2iWNsBVz59E9xgQg9QZajBMaTqSu3s4+sKG
         Hw4+1+cgcQbAWzRqFuvqlWoVO75filzBld8MFnJ3aDgaOWWo6de38bT3hnjX49EazukB
         EEyr4iNjJKwUQF5qabQ1O/RXWwiz3vEFMOzDEsM7sA56GsZJ0N4pNt4ra2P/Fv6pZ8ek
         hEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376098; x=1789980898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0EQZjh8FpaL9SkuEWQ6ncbogVE07+uLcTnWo4fn4u1w=;
        b=UPbS5KoPkYt86T75WTXlKZjBQb5DSMCh0Zk+3HhbyuG2kiYElxpx9VQpzUs+ECuhMU
         mUPa7b8Nrd0hpkFajBZ03oQke5S+HS9hKfeqb1XClnO8J2cT2hHO0NIhHZTDRovqJETo
         jTRn1X8OplXMHs09eQmnY4hYkIAScsub2Sd7ufcf3HLIH0CnihTiYR0QxP+8WA+suvt5
         AQ1dtOI1juiWBnCDGlroLmgme+OZ+WGl6XzdRuOyVrV6t1H09OYFBPx6JCYQMuA6OThH
         Tul8NtMWOJZLC397Q0hlWpEYnMeIJ/KYvGQhjnvf8sbr8TW0zYmLA2DeAS1REC5tgjZH
         PdzQ==
X-Forwarded-Encrypted: i=1; AKwUvBza9LmozPgOyMnn3rYTmLtzO/jChVX3Ewp8oXvMyX9qx1Fhr8TBLpAg8cr16C+1dp1887NiNCM=@vger.kernel.org
X-Gm-Message-State: AFuF++mi8XCSY55Zr7RFfCKNMXD2c/tcMu2AV7hfHD6hsKoaHupZ87gA
	5sLXCDY33kaYAH0khY/4V3jqYqioTWsyUS/pM2wOtnaNHhTrk4euQ9rF
X-Gm-Gg: AYBFou0djOEKtsEZ/lVPA9dP0Zvax6rTx1H9REQC752c4PppzCm08j4N2dRgWRr0iYD
	qM9HJi2n6DGZwiLcCD84AHihHQdwH96JjGM/oPugj43qz6a4sVxsgu92iBw7jJ7lydS28wit3JN
	IgGfdRX8bf42FzfUnOe1yJyvHnhPutDsR18YPGip+2j7nIDCaUD9wf3ZInfDtMgk2O3Bv6d25O/
	GgQMq4k+VGaxoQD+FhA6+Cq1w076etJP/oE0zs/Kxf6raNo+dtWpT7jtXK0dSucmJhxR+MLOEiI
	5/tLM8rQ/EUUsxhacK9+6xBqG/JwXX5B9ggneAzfv/VoBgDf8L01tLqjPXnI6n6U6atrU8RFK6v
	xQNdXQpKK7XYxfF7j5m5NawYMqsR6Ma2WRO4upMMnmnDSlMAxWNks+sOtdivDzwhuXj7zqwaXNf
	mWHZtCth6owe4rI2hOO00kRm30XLULxnpJdGy/3D71+6CBHV5Usg34AWL/4/zMx6ar0+ZhjbQbg
	Ui9bcyWZjnKblDhJeMuvARwCLTQAcQ+A46tdk7k42iAUM0xov3Iv5g/S8zP5QIJ1VbS
X-Received: by 2002:a17:907:db03:b0:c26:1648:a076 with SMTP id a640c23a62f3a-c29b87eb88amr93365966b.49.1789376098041;
        Mon, 14 Sep 2026 01:54:58 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:4701:1ac4:1c21:4a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm101378466b.47.2026.09.14.01.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 01:54:57 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
X-Google-Original-From: Bernardo Soares <bersoare@isovalent.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bersoare@isovalent.com>
Subject: [PATCH net v2 2/3] net/mlx5: LAG, check if vport exists on br_offloads
Date: Mon, 14 Sep 2026 09:54:29 +0100
Message-ID: <20260914085430.18694-3-bersoare@isovalent.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914085430.18694-1-bersoare@isovalent.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
 <20260914085430.18694-1-bersoare@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() walks a LAG bond's
lower devices and returns the first rep that's structurally eligible
(same HCA, is a rep), without checking it's tracked by the calling
instance's br_offloads. On a merged-eswitch HCA where a bond spans
reps of more than one eswitch instance, this can return a sibling's
rep instead of continuing to the one this instance actually owns -
reached via mlx5_esw_bridge_port_obj_attr_set(), so a bridge attribute
change on a bonded uplink can silently no-op on the right instance.
Fix by checking mlx5_esw_bridge_port_exists() at the point each rep is
picked, same as the previous commit did for the single-rep case.

Signed-off-by: Bernardo Soares <bersoare@isovalent.com>
---
v2: new patch, addresses review comment on v1 asking whether
    mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() should verify
    the rep it picks while walking a LAG bond's lower devices is
    actually tracked by the calling instance's br_offloads, since it
    otherwise returns on the first structurally-eligible rep found,
    which is not necessarily the one owned by this eswitch instance.
---

 .../net/ethernet/mellanox/mlx5/core/en/rep/bridge.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 56592e2e6b9b..4b7b0a0fc2b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -85,9 +85,16 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
 	struct net_device *lower_dev;
 	struct list_head *iter;
 
-	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev))
-		return mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
-								 esw_owner_vhca_id);
+	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev)) {
+		struct net_device *rep;
+
+		rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
+								esw_owner_vhca_id);
+		if (rep && !mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id,
+							esw->br_offloads))
+			return NULL;
+		return rep;
+	}
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
 		struct net_device *rep;
-- 
2.43.0

