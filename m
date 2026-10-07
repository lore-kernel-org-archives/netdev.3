Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A33F412C
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398307; cv=none; b=ivuAJt5HK+am6TSvKC9DyLvfJirHwA4e2K1Z2qCvrJrVD36Dg/2VqSwDvCXY9gLoQ13u5TbOlKRUlhbaDRZVr+ogJRARQuauVGybhcEAAUTleqIP3OYNpM7QM4qYLKlUBAl0bul9AMUqCZUDOUAVd4yS7o3gkFSV94ft+IoageQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398307; c=relaxed/simple;
	bh=JpBMAw+tGIDULMwd1xZavj6lhXlGClcjwk1vQb+S4gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CT8Ne7yMHwFVERI2l9ATnIjokhOAGb2S5NjOquvgeSLIKiTOCr9RIO9mRBOOmP9TKxiRF+7aFE9JAgqvLY9ldI+54fqp8tgNXOkKMA7YXZSIN2sEUGUnMop+EkiRsmiZsnSTttK/zBkEjBSKAgVWH1LcVthn4irBsLSNYz+Lnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnfd5wRv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnfd5wRv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91054f537ccso23792866d6.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791398305; x=1792003105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCXCiQO584QO3eX/a3eFjBSu6WZdPOZ9HmP0EKIExx4=;
        b=Nnfd5wRv2WQ84t0Fe15SC017vnuyTYj7NKUhEJ+Uu7d5ytBLt9mt3F3vozgmbEo3bw
         nhb22s8Cj8wOXYi0izqSUxBgiyj0iFXDYReMm61RzGqNUNnS7qsT5kDQLEFWAMvcZWiX
         2cCrZUlHUSxL4RYdkf/+toxns7xJtBXEOG961Sl1GnyGoZzeCJ9/QCIMaOi9y9/+vVJD
         YkZvaR4bPm19pHSbvNZ2joziY/KBejKzA7i6aQzWzSwZE1LcR/wLoTaNc3N1NWpimZhj
         wjIiHDrgew3xvcVSlb/xHtXUmgCr7yyYqQPBuFDJZ2FkQ6Y2Vug1MCoue3yDruHLtV5a
         +8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791398305; x=1792003105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCXCiQO584QO3eX/a3eFjBSu6WZdPOZ9HmP0EKIExx4=;
        b=IMiFWw20oZ4LEY7o73Nv2VlruvBPUGoSyihsH/stDAn0hejEA2lQR9DEST7kg4bo1K
         0uB78sbb/8vlbNBmeXwaq4HHRt0gZNK3yrSXFRj/mGVZm5WTYRnNBUuS8rkvxcYMhbgp
         h6T1hJeLx1FZHkWwYFLcG6ND0H9zo/D+/eZFiWh4WubNihIGZLWImvdngZ6fXfV6mzaN
         StTounrQFpDQQZ3N676b26rETEk8Ju7gQYEBxJJTOm+LN0ecdIIiNfQZeKJIz7YFS7mK
         CogVRUN1FO4cteKXMGd9pYqPgRQxlNeDADY6WZAGiJ/243nZABAxV4lh+oT6kqysfPVL
         u2ag==
X-Gm-Message-State: AFuF++l1k6PpbxNyW7V9b0ItlBtd4gOZNaJ31adWaV0ePmUTwj8VkIlU
	GimHys96MChahPPve3XsPxGF12vfzNurjPL+JjVGsrpossluNYBfdlPavnGtCk4w
X-Gm-Gg: AYBFou1UXnmVaWQcYn5m1O7YLLAmLo+bz3DjlQm5C0LIJriAseStwZBcKH8AqZKw6RO
	HtVkfMHiCINPOZMZAfEmC7m10kXgFcPBENleIUWzNjfsifX5DlRJiofzocGSP4WbI3K4YQlRKBX
	3eKUVfjKPnNY46dPlipIVu5RqNgeTqjz4WvHZ/4Zi7Fu9UzWQv/YhYCGLDsASFXS6qBpBbnYLQE
	zWtCrJ1PocnGU8Ry7a6cfCT2g51OcJCmHV8k+GLRCa4w7VAmp2g1N59VNAiHlRZhRtteDKjR/+k
	Yy40BsBtiBPpPDGAr+UHohgUy/x2V21ro4GB92poeZG9m8J1nW/aUkqGSPnYxBq5Ue98vfaKdpn
	49bVaeCVCe0BqGavxWgDem1NwWtIq3+SHIMnpmgQX9jor1uHbNtUYAjZiqpHrFJR4zzXTUzbeLN
	yM4Cl147ZwcL26cvrauj7YnwwsAMgiYX9z55Q3c1zdbx2cq6E/ENt4DL0MN7YAfcF5w1KUs2sLw
	i8waLE5jHNFKMAxQ47OznfHnREab4VAmRu/S/ILbQTidV396T00L1TTivYavodmku0Lvl9PYlar
	Wffjc4r1G6R9hDQEMR60keCV9wVZb6ZfJoSH5hk4vXsrt39n
X-Received: by 2002:a05:6214:1d01:b0:912:d20:9b1c with SMTP id 6a1803df08f44-91997560269mr60576826d6.0.1791398304797;
        Wed, 07 Oct 2026 11:38:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919973a87c3sm25516746d6.42.2026.10.07.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:38:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
Date: Wed,  7 Oct 2026 11:38:21 -0700
Message-ID: <20261007183821.928263-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_request_irq() is a managed resource: the IRQ is not freed until
devres_release_all() runs after the probe function returns.  In the
probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
while the IRQ is still live.  If the shared IRQ fires during cleanup,
the handler accesses unmapped DCR registers (crash) or the already-
freed dummy_dev (use-after-free).

Switch to plain request_irq() with per-IRQ error labels that tear down
only the IRQs that were successfully registered, and add the matching
free_irq() calls in mal_remove().

Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 v3: add Reviewed-by and fix Assisted-by.
 v2: rebase and add tested comment
 drivers/net/ethernet/ibm/emac/mal.c | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 42027665f2a9..236603a381bc 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -665,26 +665,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = devm_request_irq(&ofdev->dev, mal->serr_irq, hdlr_serr, irqflags,
-			       "MAL SERR", mal);
+	err = request_irq(mal->serr_irq, hdlr_serr, irqflags,
+			  "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
-			       "MAL TX DE", mal);
+	err = request_irq(mal->txde_irq, hdlr_txde, irqflags,
+			  "MAL TX DE", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
-			       "MAL TX EOB", mal);
+		goto fail_serr_irq;
+	err = request_irq(mal->txeob_irq, mal_txeob, 0,
+			  "MAL TX EOB", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
-			       "MAL RX DE", mal);
+		goto fail_txde_irq;
+	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags,
+			  "MAL RX DE", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
-			       "MAL RX EOB", mal);
+		goto fail_txeob_irq;
+	err = request_irq(mal->rxeob_irq, mal_rxeob, 0,
+			  "MAL RX EOB", mal);
 	if (err)
-		goto fail2;
+		goto fail_rxde_irq;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -703,6 +703,14 @@ static int mal_probe(struct platform_device *ofdev)
 
 	return 0;
 
+ fail_rxde_irq:
+	free_irq(mal->rxde_irq, mal);
+ fail_txeob_irq:
+	free_irq(mal->txeob_irq, mal);
+ fail_txde_irq:
+	free_irq(mal->txde_irq, mal);
+ fail_serr_irq:
+	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_dummy:
@@ -729,6 +737,13 @@ static void mal_remove(struct platform_device *ofdev)
 
 	mal_reset(mal);
 
+	/* Free IRQs before freeing resources they access */
+	free_irq(mal->serr_irq, mal);
+	free_irq(mal->txde_irq, mal);
+	free_irq(mal->txeob_irq, mal);
+	free_irq(mal->rxde_irq, mal);
+	free_irq(mal->rxeob_irq, mal);
+
 	free_netdev(mal->dummy_dev);
 
 	dcr_unmap(mal->dcr_host, 0x100);
-- 
2.56.0

