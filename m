Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD6262A6;
	Wed,  3 Jun 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467460; cv=none; b=tvkYNtH3O+qWdUuu7ZoT4nUz4bXju8sBsAErIDy1oxJ8q1IC05soceSpYHTbkRhf1jQWvCBKdgAwhZIthHEvpHjLehurRaeBkScKHoK4fZZ8yLhbAixZTQzN3lnU97tLkw4tBUvZWZb6OfcPTV5w4vx1ZvdkqjDm/Nwx5JQrGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467460; c=relaxed/simple;
	bh=pMjuKfBcl4RI/BToMAsxSzxsOiNMFY3xgUH5UO4ZAIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOMZQEIkevu1S3cdUNw2kBxBc/P78sBLrqlHvRVGrokRelbK725wAl63kx0PmYKSPbiFoIJXwfVpG3ohSrwp/akLBMPh9ofmY7/k2bn0Z3l6Gdxj9vntg4QHdQ9TwoulIvob83tSZXh3pD3oTHnxn1SXV8R5bX12lXYX0ITC92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowAB3GdLtxh9q+ROAAA--.1778S2;
	Wed, 03 Jun 2026 14:17:19 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	kees@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH net-next v3] net: microchip: sparx5: clean up PSFP resources on flower setup failure
Date: Wed,  3 Jun 2026 14:17:16 +0800
Message-Id: <20260603061716.747282-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3GdLtxh9q+ROAAA--.1778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWUKr18CryUWryUGw45Jrb_yoW5KFy7pF
	WUA3sIkr18Gr43uF18tr40vFn8Z34SqrWxWF4fK345Aw15CF4kCF1DKFyFgr1YgryUAFn3
	ZF4DAa17uwnxGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsHE2ofvUkf-wAAs5

sparx5_tc_flower_psfp_setup() allocates PSFP stream gate, flow meter and
stream filter resources before adding VCAP actions. If a later step
fails, the resources allocated earlier in the function are not unwound.

Add error paths to release the stream filter, flow meter and stream gate
when setup fails after they have been acquired.

Also make sparx5_psfp_fm_add() return the acquired flow-meter id before
the existing-flow-meter early return. When an existing flow meter is
reused, sparx5_psfp_fm_get() increments its pool reference count, but the
caller previously kept psfp_fmid as 0. If a later setup step failed, the
error path could try to delete flow-meter id 0 instead of the reused flow
meter, leaving the incremented reference behind.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
Changes in v3:
 - Make sparx5_psfp_fm_add() return the acquired flow-meter id before the 
   ret > 1 early return
 - Modify the commit message
Changes in v2:
 - Rebase on netdev/net-next.
 - Add a Reviewed-by tag.
---
 .../ethernet/microchip/sparx5/sparx5_psfp.c    |  5 +++--
 .../microchip/sparx5/sparx5_tc_flower.c        | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index cd4f42c3f7eb..83b37f95ee46 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -277,6 +277,9 @@ int sparx5_psfp_fm_add(struct sparx5 *sparx5, u32 uidx,
 	ret = sparx5_psfp_fm_get(sparx5, uidx, &fm->pol.idx);
 	if (ret < 0)
 		return ret;
+
+	*id = fm->pol.idx;
+
 	/* Was already in use, no need to reconfigure */
 	if (ret > 1)
 		return 0;
@@ -291,8 +294,6 @@ int sparx5_psfp_fm_add(struct sparx5 *sparx5, u32 uidx,
 	if (ret < 0)
 		return ret;
 
-	*id = fm->pol.idx;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index f779a5c00803..a17143953502 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -807,7 +807,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 		/* Add new flow-meter */
 		ret = sparx5_psfp_fm_add(sparx5, pol_idx, fm, &psfp_fmid);
 		if (ret < 0)
-			return ret;
+			goto err_sg_del;
 	}
 
 	/* Map stream filter to stream gate */
@@ -816,7 +816,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 	/* Add new stream-filter and map it to a steam gate */
 	ret = sparx5_psfp_sf_add(sparx5, sf, &psfp_sfid);
 	if (ret < 0)
-		return ret;
+		goto err_fm_del;
 
 	/* Streams are classified by ISDX - map ISDX 1:1 to sfid for now. */
 	sparx5_isdx_conf_set(sparx5, psfp_sfid, psfp_sfid, psfp_fmid);
@@ -824,13 +824,23 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 	ret = vcap_rule_add_action_bit(vrule, VCAP_AF_ISDX_ADD_REPLACE_SEL,
 				       VCAP_BIT_1);
 	if (ret)
-		return ret;
+		goto err_sf_del;
 
 	ret = vcap_rule_add_action_u32(vrule, VCAP_AF_ISDX_VAL, psfp_sfid);
 	if (ret)
-		return ret;
+		goto err_sf_del;
 
 	return 0;
+
+err_sf_del:
+	sparx5_isdx_conf_set(sparx5, psfp_sfid, 0, 0);
+	sparx5_psfp_sf_del(sparx5, psfp_sfid);
+err_fm_del:
+	if (pol_idx >= 0)
+		sparx5_psfp_fm_del(sparx5, psfp_fmid);
+err_sg_del:
+	sparx5_psfp_sg_del(sparx5, psfp_sgid);
+	return ret;
 }
 
 /* Handle the action trap for a VCAP rule */
-- 
2.25.1

