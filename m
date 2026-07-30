Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9D34DCE4;
	Thu, 30 Jul 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375358; cv=none; b=W6iDGHf0XmWqAK3yVCB6LqPprU8I3x9lJHLkhl7Lwl9nbAubMFOT91ALw7GA/X6EKde9LweuG/HspjompFiBCEvK/0JgqvucF/1CI91OtSMviekkOEf3kV4nNLOj+30amrLNI4DRM4NeBrd1WuITPg0Hz9dH2y8sbIxGgW8AU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375358; c=relaxed/simple;
	bh=7QcNmHeWKOj1WMb8n5qnUTZl2AoP06jPih0EJCwW+4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG6gkNBnZYAEcKewX7gHoXgDhbtyTQx3ysO159JD40bzb1EOgMxtN1DK/uFZ6xh6Z26TMalc3yb08pdGNhOO2+kmZIgoZseWsxR6pbuPSpWIh5M7622kEK851jovZBVsijF2fsnENy+O7UbQLQujVmPHuk2aFepS5UVZeDkG8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBRvDV4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBRvDV4v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CBDDC2BCFC;
	Thu, 30 Jul 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785375358;
	bh=7QcNmHeWKOj1WMb8n5qnUTZl2AoP06jPih0EJCwW+4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aBRvDV4vJIPErscl+FZitMl634EBWUlXacPeBATrXhu8ZOao3jOb58ikXEgyLch0p
	 8kqpAZ11za6fPSKqvT6CuNC0EgDdrZnWVg0FU5optESvzb8rgeIquVFbkRKVArDUwR
	 0Lc8NxBGpjTCX8yVTEULrqU4A2/9PTjbaE5tOhEC/GIPfdNz+amKW5uSjSuCcOcqBG
	 pLu3B3ixAJaAKqQOv24D4jyQrFIwkqjlWGrkBVfjq92b/zgMbleeozc5cRnXEJFbT/
	 REW51qI8tLzA5DQq5/MbMJMVv9EfYG1Idm5y2RSDAPBt7aRdz28gtCpRxEOhqfck20
	 NCgwWCOWigFqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059C1C55164;
	Thu, 30 Jul 2026 01:35:58 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 29 Jul 2026 18:35:18 -0700
Subject: [PATCH net v5 4/4] net: ethernet: oa_tc6: Fix for the wrong data
 type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fix-race-condition-and-crash-v5-4-3906bc485daf@onsemi.com>
References: <20260729-fix-race-condition-and-crash-v5-0-3906bc485daf@onsemi.com>
In-Reply-To: <20260729-fix-race-condition-and-crash-v5-0-3906bc485daf@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785375315; l=994;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=II9qua5tG/YhwMidD/wuhD+qp9nEPTfFdgjEsW4zGtg=;
 b=e0fkoRlnIEamhx375OqnjnNF9sZPfUAdssX5sDo3FmhNnYYSyHlLzGD/hemGr0UV4v5WVvHJ9
 PojGA8COVxqBUs6QvVfu1uxus5YlHglexYWI9SqoNOFNodGBFi1YRvX
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
changes in v5
  - New patch. Fixed the wrong data type used.
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index bb644509c32b..2ec22ba3ccba 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -423,7 +423,7 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	u32 regval;
-	bool ret;
+	int ret;
 
 	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),

-- 
2.43.0


