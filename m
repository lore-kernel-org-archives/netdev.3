Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960324;
	b=0wlgCDdf57OBtNx1Gsbg83CvckpHi7gEnwBXRr8iOd205NnT5+s2IEPYvxXfC7mrcByA
	 oKKfPLze9Em7n2kZcV8Tr2clqKOskTR0HgU1J3gl0YEZIzFPiZQc7E2oRqqzOUIZlqiVf
	 qqpyGL0cWXdXBEOWzER6nMRbc92Y3Hisb7UbBm3XMKyCOqAbixtEJlVgtfIv4hACeZBWr
	 cutlAbzTbpFK7lhyVjjFFe8owyrVlRf8twMygSYho4pOZfv4pUpDLsNUQNCb0HbXg7bl/
	 H8tpv9hll1qX1HY5y1oZBfFL5LEY5zq4E28aggmo5yaAThlO4mKutynYwJaRw4r82iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/foU+cSI6OMyqIz8ju5t4yslf2nKCeuPGIY1Tz0xSI=;
	b=UcnOKV+Kb2LQz5kUx3T1reIzruM29xcYRt9DniXFU4bu+bLq5397WlB7Xr4Sz0fEAm3v
	 a/i1YrvHyMcX2PucnYBf++o2Snhn+DjKE+5V1kOBU0CselL33Ga/kStm2w640s06lRVIz
	 WYNRgeHwUi1wSuLDYBkWitywpeNlMXXPHivpe9bclLJ4oNiItwajjVaK07XMojrbtvLJb
	 y48ssu8ArT9BZubE/2YkLxnF+AbecNsZ3QsCuCjDd+juhJwOesdZEa1CxxXhfyhvdtZI/
	 jZedlKKT+LjlDwxKqeUa4h0J3F+EZap+/5mix86XvQKOUdHVNcv5Yec6vQazEMkt9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tFoNH8jO;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F97606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29F97606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tFoNH8jO
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c43fbcb4393so325956266b.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960322; x=1793565122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/foU+cSI6OMyqIz8ju5t4yslf2nKCeuPGIY1Tz0xSI=;
        b=tFoNH8jO5oD4yvKeAuv5oUcHNujVbWhIuy8BfDaEJtcvjg3O60NTSmI+qVEElDW/X/
         A1+SQiwBj70VWpFA9/B5I2r7rA08a+GmrbgEgjSyhs6lhexzr/IODo7bBqAPHxQ4/XgQ
         qQI4eDNeaPK/vNJLPYM1y7DLAGYHFVloIIM+mQ1xD/vOdT/KuP6SjQr4bWncdSwXAycE
         ZQXLMQTzFwz1rRteUtvMVPhSEQpLGPZpxZELKIWpF6PKmJ0LAXVKfCqEWMpedNJJvckv
         7RGSf5g0Bo/tcubF6nussxJbybWCsHE7XhpNrwTySscx3iavu8qV01vEbjjA5lNbRNqp
         xeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960322; x=1793565122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/foU+cSI6OMyqIz8ju5t4yslf2nKCeuPGIY1Tz0xSI=;
        b=wn4ULp+if36oejqHh/w+oaf4C3yibVgHijTIiIEYdwP0jxplrSVOsKkMuSfL5Fr9Ff
         O4f3KPtrTHSHvWCPHpcKg/9en+cJ0naWSoqrH0TUwoZ5WB389tFhP3NYEPe/rZ+md9ZM
         ho/fYNZ0EcXMfcCqUMVpsrlHqLtjILowNRli27repNxS8OjNvjdje46IGxmvaz1ckWs1
         hBho3ys3xYk7Sw+U7QtwhV47JTjV6rQXUmq+Xuyu4Exs4pxq7TBl2iQUXH4WR+vx6U1l
         0yDEbMb5DD1odsUfNY4sNMaARO0O8CStv/pfyzLRpWI10cuhelkyBSUirwhf2HrnDHbw
         Mnlg==
X-Forwarded-Encrypted: i=1; AKwUvBwPdqz+3asT4u7nprkMbHTUPvo8d6EZ27bR6QsFC8NmURFabDTiDRgqZuK5Ufj3OsCY7ROIFT8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv1dRP0jxzRfjBvNoAon6HmGJNvF8L/iml6cX4El36PTMgZ2uy
	/FQqAgtNzQvHSm3wkNNy3AlMGRHPhVAKZOybeYEabDhW6J+oS/OsuXVV
X-Gm-Gg: AYBFou1JE0MJiE6t3nXXa+CKEBv+s+JbQ09eznONah+zGNvreNdy6upYjCOwHEMLPLM
	L6dNptMhQ+8CwUGgFNc7hCd0Ydk0cI79fa7Szr9kAIBt5gnP5x2/ZJdwtrUVbCAi89cb1UqyLPJ
	4J36qjG2eiVRej1uM1aYOQnszYUBeAUbZmaUIq6gjNzLWwPlLlmnO/5jUuBuxmPzchBhPRMJb8N
	rUu+PpaOIkn+TwzJub3ps5jCqCdpHkLfqesC25qkASWKvtjMcUjGqcBsLxNoBo0nf0M2ZXY0QBu
	fyL0FnMalmX3P1Rup9JsNXe4YOXINw1dAlcpo/kIDdjLvg/7K9O+kaQ/5y0ansFAmvx7FSYIDUD
	9vB9ERhhIXv7jJ296dhiYrIxk2ImlFgY1gnRHz2DsZVx/PrGLiE46CkHSocsO16/L6lpCqAekeS
	GJ92poqT1jWO/cPvglinVyq9vgCtZgVAszdNn0xX7444CjY0VRkayf6Tqk0Nqr4hdJeELZoTOg9
	0mj85YnQpeMDwq70asGsJfz/TKJg4OIBVCpXRRbfhVHwyviXR6R+HlsyIjgcLsRbywv44qxC8R9
	84cSg6xUlaUp81m3dw2zwdjj6AsGuC1hG+4b+GYaifKFdLHzNeNDBDx7g24gzIHW+iKE3/3n7+y
	5apY/Xa1ZTtWfMKVB1PgVKhPX2tV22Psi0ZOWqnBlgEY+
X-Received: by 2002:a17:907:968e:b0:c32:110d:682f with SMTP id a640c23a62f3a-c46bddf7a75mr615460166b.18.1792960322486;
        Sun, 25 Oct 2026 13:32:02 -0700 (PDT)
Received: from localhost ([2605:59c1:3500:c210:a19e:c679:44e8:e9a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79b884sm240272566b.75.2026.10.25.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:32:02 -0700 (PDT)
From: Selby Mashiki <mashikiselby@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Selby Mashiki <mashikiselby@gmail.com>
Subject: [PATCH] net: thunderx: fix fwnode_handle leak in bgx_init_of_phy()
Date: Sun, 25 Oct 2026 22:31:59 +0200
Message-ID: <20261025203159.455100-1-mashikiselby@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bgx_init_of_phy(), device_for_each_child_node(&bgx->pdev->dev, fwn)
breaks out of the loop without calling fwnode_handle_put(fwn) if
to_of_node(fwn) returns NULL.

Switch the loop to device_for_each_child_node_scoped() and remove the
manual of_node_put(node) calls so the child fwnode_handle reference is
automatically released on all loop exit paths.

Fixes: 9d28f9491258 ("net: thunder_bgx: add a missing of_node_put")
Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index b63039999..3fe3f80db 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1467,11 +1467,10 @@ static int bgx_init_acpi_phy(struct bgx *bgx)
 
 static int bgx_init_of_phy(struct bgx *bgx)
 {
-	struct fwnode_handle *fwn;
 	struct device_node *node = NULL;
 	u8 lmac = 0;
 
-	device_for_each_child_node(&bgx->pdev->dev, fwn) {
+	device_for_each_child_node_scoped(&bgx->pdev->dev, fwn) {
 		struct phy_device *pd;
 		struct device_node *phy_np;
 
@@ -1506,10 +1505,8 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 
 		lmac++;
-		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
+		if (lmac == bgx->max_lmac)
 			break;
-		}
 	}
 	return 0;
 
@@ -1524,7 +1521,6 @@ static int bgx_init_of_phy(struct bgx *bgx)
 			bgx->lmac[lmac].phydev = NULL;
 		}
 	}
-	of_node_put(node);
 	return -EPROBE_DEFER;
 }
 
-- 
2.56.0
