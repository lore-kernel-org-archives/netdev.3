Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCE384CC2;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608689; cv=none; b=JkI1ECjL0srGv7yujL/NAk7t0PX4eLBOtlwks9LX7sEUA2HO3ZORULsKy3CliEOmtAwG+AVzSNcTpqCAj7fg/wkcNQEvidEP97ONltfzKyd9JgFEkhjRV+CzlIs/+JOJpdyIm17w64Qh1nuTTUUR52u7jkGV7XTuIi7Yd3CST9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608689; c=relaxed/simple;
	bh=om7v9KvnQTWR6moirRcH8FnUf79QqY76zszAUr8UiPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fctt8eV32ZRJz/NQvtxHVVG+HD6POfwMIM3WklfaZeR4G3u5FBdPHeruYhiEGHCjF8E1RgO6eMpAZ74kvx5/xGN+vdGMTXgoXvfjTjcwDaqg3HpwgdHtQdbr46jWcGVtpLp9RSz395li4KVPouQK9bEcFI8IOTpdyH3QUzWu84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fphx3a0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fphx3a0A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92542C2BCFF;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787608689;
	bh=om7v9KvnQTWR6moirRcH8FnUf79QqY76zszAUr8UiPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fphx3a0A9YtgUEV39bmNjClFo1q+XEPOtXRuI4mlotoGRKRNadSehj4kEtIybjfEs
	 CZdjZCIVQaw5csc7MOJJ5P9JG7Ji3OPQJ9PQAiCHvHMYCmbq3bu1SFOHqToL41oA5/
	 2Px9+sFuZ4oxSAQycnOPnJw3lz+Q4y8evOTxKIlbNqR8ymt3bRcJpkH04cUjRW+CSJ
	 QN/GLWKWSL+uveO1fddQDazq7oH1fkdmFTf82eDVcfqkHN3/sW5gldGthi7i8OMyiL
	 q4bl06l8tnJSb2Wbp9lZdDaQ0tZQNg1BjyRORWEwbyQS0jvGyDOHNodW8m/F/LahB9
	 plOp6xnK2y4pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78213C61CE2;
	Mon, 24 Aug 2026 21:58:09 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 24 Aug 2026 14:58:01 -0700
Subject: [PATCH net v7 4/4] net: ethernet: oa_tc6: Fix for the wrong data
 type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-fix-race-condition-and-crash-v7-4-4323279b18f2@onsemi.com>
References: <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
In-Reply-To: <20260824-fix-race-condition-and-crash-v7-0-4323279b18f2@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787608678; l=1054;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=no23al67vcDK5tp325bYlmc8jUdp9BwqmZKml1V/MkA=;
 b=SS1uGmOYLtqeBYw5mUfV3ry/SYc9reh8Ps0puXtGB9o27hhcq0IQkRPFPy38oW0n7anLhoDh5
 jM4UKPqy1rRALidlzb2nB08WW7kn5Uue3ZmtZ1qYufHrzPCAn0x82wh
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Inadvertently bool data type is used where int is supposed to
be used. This might turn a negative error code into true or
false and sign of the return code would be lost.

Fixes: 8f9bf857e43b ("net: ethernet: oa_tc6: implement internal PHY initialization")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - New patch. Fixed the wrong data type used.
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index eea00b41fb8d..6fcc5f561d56 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -455,7 +455,7 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	u32 regval;
-	bool ret;
+	int ret;
 
 	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),

-- 
2.43.0


