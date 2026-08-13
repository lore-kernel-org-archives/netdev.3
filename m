Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E2242D67;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590026; cv=none; b=bo2xhv7LbnlBV5cBhMYv/H8/Ayh+X8ZGumGhjj0rACA4MB/gfqf15dZkTyJYDcQwGS3ZE2HjmwA8fzG9lGJBhjy2nhikvdVan5M0ORw+RiuPg4eqvEw/og5Yz/4RuKd2LDG7mayQtknav5S4fzvPgzFykva+rYF2W4UnPKRPGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590026; c=relaxed/simple;
	bh=5kpSq+YZqBjwXavr5OCUEDCTfpqJn3lo1IRuwdRyHA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S783RgOdtD4TI2SFwsL2++Eh2F60FsNhzWWdJ8y5CIzfky7bZBHJtbnWTILygtSOnhwKDYGRh5C93TlRPDNcQLiQBMA6x+jVSHLCup1r3I5HniyhtSm3TbU05TOV+B+4wHLl9zGWBZ2RgZUuHRIdKSz25cjqJTjdJaF6cn3Ln/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE3/e/O/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE3/e/O/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EF02C2BCFB;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786590026;
	bh=5kpSq+YZqBjwXavr5OCUEDCTfpqJn3lo1IRuwdRyHA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aE3/e/O/ET17kk/TRKnVzED3JJoj/Mj/YxgALViZTi6mIQo4G9hNpDGluXPHpfjG3
	 FCm7oeH+WugQF+LjQsuW12NpMSULYux3hU0f6gz6O9uhUg8bf8d58X5qihO68hPkAm
	 M1/gO4+Iy7E41padLWWf9C1ULSO9RUzVUQbyLFwSFmmy3SxRX+UOycp05R/wxm/r8p
	 lRTbJg1yewSj2PsvaHSP/2HH3xxA3muQGoeM9xeyCdOFGLQEohy4R+wUO9QsVtr3bf
	 l6Y3ifdh3dLF9O491X8LMO6YpYhdfKzhFK7ifJrURURBwdoOJE1H4wfFLHjmE71TWN
	 QLqlEwgTISRSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A1C5DF64;
	Thu, 13 Aug 2026 03:00:26 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 12 Aug 2026 20:00:12 -0700
Subject: [PATCH net v6 4/4] net: ethernet: oa_tc6: Fix for the wrong data
 type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-fix-race-condition-and-crash-v6-4-6cf90f4a271a@onsemi.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
In-Reply-To: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786590011; l=1024;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=YFjPZcvWNnqDXoOsWmMkWYtr6Pvxm21ISCYKMWeW2o8=;
 b=jsr3P1WBTd8zqeCs2tqao6XPhg9SuwOINt6bjta0Jt9G9aNi25/6zPjAZlV7Sr/+4d2wJf5ws
 QVP8haXw8a4CDjM3RZY9DIwsV+I1Cm8l3nhl/1vTwB7sjRQFPGgTczg
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
changes in v6
  - No change
changes in v5
  - New patch. Fixed the wrong data type used.
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 5354ed3ece7e..6e27ed39a99b 100644
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


