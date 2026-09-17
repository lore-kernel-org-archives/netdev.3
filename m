Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E544B1467
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687958; cv=none; b=Q7Y5Vu2HDiNAd/ioXAmrGD4Qp22TR963vK/sEwww6WgtJ+ktDbiOjKF54nT4/mzkgPBnEsqsPZFU6Sul7fchtnuuvOH906ZSn16Y8epc55AAcrYAxwYoQwfpDkK/bAuk2RvwB7dSrXSeyMKg+PpAy6qZ8JhI9FGgs8tZW2i5rEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687958; c=relaxed/simple;
	bh=i5EAoq1Xc8k5Nb96NUryR385FSoC/JKqS1uOw/t3FNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6qOHv6JymPgz7r+l1c9qsjSD4q9w1AgUaHIfIKpKe7Jj6gip2CINw5T8S7SMbcCjtNgUHR3b3C9tvL4c90Gai0/EFDNlOwLM6O4QlK7KBpwvudnTjVRsKF8Dn0bvanxlDZIWe0tRP6vPizgufsYEsPAv+4Oo/DNIf9IkFeliE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=g7sHcvFL; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="g7sHcvFL"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso189907a91.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789687955; x=1790292755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLY3UmOqZzZ3us+Px/eqBPnv/fx2lVKt8ROnyv5E4d8=;
        b=g7sHcvFLN0JS/LhPhg5kNsY64AISQkLDazaArtEVQyvOnkdwjLtuquk2u3vzHLzdG5
         cIyL1MdVQAfh9j84LgLJcxsVk3zEMZr8T7/Yka73oCHu7XH9w9W5edSV5CdffHZCFWUv
         M4RWgYqh0TdmIRb5CPCIJpwDqq/8+7TPHJBwnJ+dfj+rpgkY/jbvFW452kWSxKG+zJkS
         jh/45NDRMX4rh8jPsBFsTho6LS7JW34zZA/ZD801rTjdfpB83mQz6UyNTivS3YX+oK5l
         H/TjLQjbkC271Y3XI6acIXrYZBMG346r4joIcwrCjCeMt3/OqwE5yiyvKoulN1omTLFf
         9B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687955; x=1790292755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLY3UmOqZzZ3us+Px/eqBPnv/fx2lVKt8ROnyv5E4d8=;
        b=0mhG49VP4lRv916gz0F2kMmYX0Qk4MlfT6JxXaxVOhor4s8r1c+9VirSFgtMjSB3pP
         8raPkERVPFLNcLw5OmUkw6gXnmU8QOJI4ijS1SKlji9N1NDmrjzUuOYsliH2oYyDP5xX
         hEj9KIZ/GBhWFMD3hil0XD8AJ11bMI8KchxJJ+LBjIgoQbUQb4OYbgmyXDMZyIJ1RAy6
         k7X1DFS78oZJzToz2sybJa8SAuLU0TZCb39g7NrlLgtdnQVbZRzYZbnhx5fAMnN7//U5
         gk1zS8GJaNgCZSGsNOaU3bHImx0ssMwbJhFlGETHbtn3tjvgKxzAJ99C158lmqOO9Lvv
         yWYA==
X-Gm-Message-State: AFuF++lTMvZKr1PTj7k7Q8tHFnH+okL4GsDXUAoWv9l8NZ6bGaykYqSI
	NoRsNOpwWF5b6tEOEbq3vbNIryTCjbH32uk3cv2QbQ30/qSncpML8lb++zg66C9LvaGlLJa7HAU
	wJGrp
X-Gm-Gg: AYBFou1WeljO+PU8gEjOUBw3AuvS9NNbNWsKk9f5K3Ku4nr0bNsMFAm7pHU7DkRZdGd
	qFewqcG5lnVl/0NWUDqiy+JE5/iD1twBvpRKSkwn02Fl0TFAINDdxmtX2Kc6UL2g5YOOMDGqw4m
	SayBqRrraOOGx07eaNa7bcj0BA9LQzSqxDmypwDtIGLk8jOKZHauvmY26Z6ZqpidogX+SML5cWa
	8tqdU2jcvt6tKO+4r2F57CLIWHsBjr3tPVWMX+pSScwWiODMQHAHgvQUGo/yfzB7wSDhg/ZNuLD
	grCXUtNOBe+Lnu9uo9sMoClu3/IxpkMDBjTGqts4Ml2wA6IAzf8lb7fGcEdXVtmLSmfxb0IMcKQ
	L1ooRYpKQ0r6GMCQ4as1M/R8vrbQF826RZip9zvfoVTzUiKqT11cATJuG4iNtjoYp7HPwonTsHn
	Su3aJRoQ3AOXa7s2WsSdGOPhlovAT58p75lfxaB9z9k8CLmpCRm1hn
X-Received: by 2002:a17:90b:4e85:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39e54d185a6mr1369298a91.9.1789687955043;
        Thu, 17 Sep 2026 16:32:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35d9869csm7412912a91.4.2026.09.17.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:34 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 1/2] bnxt_en: return status from bnxt_hwrm_tx_ring_free
Date: Thu, 17 Sep 2026 16:32:14 -0700
Message-ID: <20260917233218.1160001-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233218.1160001-1-joe@dama.to>
References: <20260917233218.1160001-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwrm_ring_free_send_msg() already reports failure to its caller,
returning -EIO when the firmware rejects HWRM_RING_FREE or never
answers it. bnxt_hwrm_tx_ring_free() discards that value.

Return it instead. No caller acts on it yet, so there is no functional
change; this only makes the failure observable so that the next patches
can recover from it.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ca99f4b1a63c..ac7716dbf88d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7660,21 +7660,23 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr,
-				   bool close_path)
+static int bnxt_hwrm_tx_ring_free(struct bnxt *bp,
+				  struct bnxt_tx_ring_info *txr,
+				  bool close_path)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
+	int rc;
 
 	if (ring->fw_ring_id == INVALID_HW_RING_ID)
-		return;
+		return 0;
 
 	cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
 		       INVALID_HW_RING_ID;
-	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
-				cmpl_ring_id);
+	rc = hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
+				     cmpl_ring_id);
 	ring->fw_ring_id = INVALID_HW_RING_ID;
+	return rc;
 }
 
 static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
-- 
2.53.0-Meta

