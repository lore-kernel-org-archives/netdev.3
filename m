Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44728688C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291487; cv=none; b=kizJzhYJsYoBZdUMDwCRZkA9esfOMh2aZ+onZlGD0g2fLG63VsGQkAS5VasicAyoYfEe49mFAQIUz281R6NLcesO0XrzGf+yJmfv1lcoGqLiU9xhxRtaj3B5eKy5AH/WqMhVQCOXp7kPRcu3MdlYo32ieArvWtNz2iQc3JwNMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291487; c=relaxed/simple;
	bh=flvQXJwYxQzImdEpjPa/q4K2tmrj2oOcdMd9zvRpMS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRZsNPTHNaBk7X+49ITCcRSZYzeZY1JlllsZi1Kk8lmbbznp5zdqZpc6Uu/z6TiVG2F8ARVmzxIfEZutpoGjZL7QdpGwIZKh3N08dfyn5/Y+q1y+/fj6eMFhE7nQg14y+TgGaU0KcCQcTpjeT04HaOFg+Z0F4XTVdPCW2y7HKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekku+KDl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekku+KDl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a2dcede83so608773b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785291483; x=1785896283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKxp8OyC0qry4zNtvMecpuE/hbir09TCLAtTFykGWS4=;
        b=ekku+KDlzq1of1zy6AJw5ANEEmLG0934EBDvIE+aL5so1pNR3+kdJHi5bJ24Z+K8In
         GI5YDsgPDUB2JiZadUeVGbMpzlTh80bbmjk9dFwnYoUkwSywbYx9LyZ+i+JBNID6SVAi
         yRqA6n8GTBug8C0zwyP8w6nqYCVNGh/qHoTD0STUYMAtabjNAD61/n7ozl3UHGULZXeu
         oH+MWGL5nuAt4suNDm9rxNue4845ql627egNW6ft8SB/K3UIdjFc3yQWlDNjVEHeKfYQ
         x5bYmakow15gYyeNyZPDx4nUOCm3BgAF8fz2NC5FCXG/9d9wiwaq39kWjS4nFocgO44n
         L0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291483; x=1785896283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKxp8OyC0qry4zNtvMecpuE/hbir09TCLAtTFykGWS4=;
        b=LnANSxlM/9zlzzpHOmiMkJxcZkg3RAKgQnwqYCO3SN91iqnN2l6YkL+k2/dclVC9OZ
         K+SgS1W+MvhQnFrzaBg3Rl/hkDvCl63DHV+6kl14pCCRXWs4YZB/mR+ipOqsV9xc5hyA
         tAG5eUCz6EB9WYDlE4gTOe8NajwRPTbWq29fX04d8O3iHxNVnnxNyRT+Qetlk0vlJNmX
         7t7OIJbJ44+J/AXp+b91AqytPmXQsmZK26XK1kFMhhzsieWiDSju7TQnM2+X5MDvurXP
         NLEf2JcPqK0mhJ4H+AmkgKwPEyeLGmLCvORnZmL4YODFWVnHkUpUCl9s0rEfAxzfjMTf
         vgJg==
X-Forwarded-Encrypted: i=1; AHgh+RrwQKO/KWUv/J9sDwE4/gyL5nISWJw13tgkhMXWLalqzSVr3j2ApnhOGAz90FzDa5uFeQ+dCBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVHyi+cQNngiVUnsKWpnVlONlO4w57u+sJnQSI1Rr1b6ErOkc
	iZw6tllhGTxhP/S6O4ncHnHbiVNmIRWUOaSGyi9fwNZO2iVHUi5Ako0=
X-Gm-Gg: AR+sD1363BGZEfYQj+uGsom7QufcWVtVeQ8srMBHPKRnyh2INjxlEGLciXc/B02wBAj
	/XZRpnpLY3CNmUTm1oJD1A/yIp0rCW1SL5d6VrzonMdIWmj9Bpwk8oav9qhDfAKhseCZania09R
	YW0CsgtjnSz61dGdOSyAmx/GV1JbPf1x4mIC1xhmmmjcZFRIZz2O0bvg2IiYm+hz+Myd4AjU0PZ
	ZE3XqZmzID5ZCqGdZ6PhK4Tk17tpkmyo2/J+yz0pKj7CWXYyZu/hzNQylLwZeZDOjFUH1TYRfCW
	pjox6dAmvF92NsoV+1o0gMOebHMbGAFZCup21yhnWTzgHE0CBYtVtf6P/hayFH861Q7GtfViti1
	F5J1pYcQAHiBwyU44gDSjufIZKxn458G5mLJ+Woaq6Hqvlq3x6+rIdymO0hlmuKwcOskldocPl6
	fwKfA4N0smv4msLNlq87JgmyeWkmw2Grz+4On0gpnxiBUGnqGx7CEyLsvoIPfUvAm/g4JjcqFXF
	Gu52FjMr3pXlzNEq9yGeM/mtyyBRao2FlmZ7UDwuua/0k9sguyB4Ei2CZXIjWzixcwaE+bPeU+e
	vLqPtdu8z9RivwMnDc5tYzM=
X-Received: by 2002:a05:6a00:805:b0:848:86cf:267b with SMTP id d2e1a72fcca58-84e9336c482mr4934959b3a.61.1785291483412;
        Tue, 28 Jul 2026 19:18:03 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm605327b3a.30.2026.07.28.19.18.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:18:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] ptp: fc3: unregister PTP clock on probe failure
Date: Wed, 29 Jul 2026 11:17:50 +0900
Message-ID: <20260729021750.49181-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_register() leaves a registered clock referring to the clock
information embedded in idtfc3. If either post-registration operation
fails, probe returns and devres frees idtfc3 without unregistering the
clock.

Unregister the clock on both post-registration failure paths.

Fixes: 1ddfecafabf7 ("ptp: add FemtoClock3 Wireless as ptp hardware clock")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/ptp/ptp_fc3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -835,11 +835,11 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 
 	err = idtfc3_set_overhead(idtfc3);
 	if (err)
-		return err;
+		goto err_unregister_clock;
 
 	err = idtfc3_init_timecounter(idtfc3);
 	if (err)
-		return err;
+		goto err_unregister_clock;
 
 	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
 		 idtfc3->ptp_clock->index);
@@ -847,4 +847,8 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
 	return 0;
+
+err_unregister_clock:
+	ptp_clock_unregister(idtfc3->ptp_clock);
+	return err;
 }
 
 static int idtfc3_load_firmware(struct idtfc3 *idtfc3)
-- 
2.50.1
