Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762B38F255
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800740; cv=none; b=P1n94gbPQ37ReehyZ9m2/vlABmbbUhn1yGjsKXCYRH4xG4qxFhpIuXDNSaBolsir/cKdpw5tKOSij2AVZLyuJBANDHZSsXwfg6+awNGpFqYv+cw7YJfjQZlLHZR/lPQq0oRIeTuUrt/guXbYXAb3Q9g81LsfSOhL5Tj69JqdQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800740; c=relaxed/simple;
	bh=xIacHn5f4ZLdoUT+AHk7QKDEnIui8s82/68l1Pivobo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yzqxm70OHYvTi71yovm8d6NAueRX47zU2iy8PPd3xc9KepzWN1LwMjRNyhuOlzFTF+U5KeHUZj/aCWEYOgyKaHwyBAYBaEt1FOzCMzVljbOVH/WcDDs7aik78OUFSG6r7PlNoHPoGtQffF4rdqJqUvb06HNCxxCaN/QnyUgj4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TazIoc9l; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TazIoc9l"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso1085086b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789800739; x=1790405539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K14gEIiwRJ26lA+Mkn6qqcGlhkPWo02FPF9k8+47c18=;
        b=TazIoc9lqAxRxK5U6qO1Vcgn9ReoWfYqCs+c8a9YueCFILgq4P9JtZhxe4Tt1ouS2w
         SQvZqF2BZsthPraEgW6DnuxO5lixpg2jmFoFlQi5bKVASozKu+oG2pyy3xBf2kUf5g47
         YFdsUmlTnEh2ZIUNx2cDw66zxlP5YeBIQcPDxEkKvq7JQq8wNRUqg23BH2luy6GwiHJe
         uquI3yjpjj6o/yyZoQ8RyC1E2V8s0qujO9EATYvU7wkoDhSD70l1XmhNzYHiSCvxDeWQ
         e1jgENAVtZYT1iOuRcaM1zld/wgK2V2qioBID1qFd1NOQXPdCCTklF9iArNajOBnG6Gg
         Movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789800739; x=1790405539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K14gEIiwRJ26lA+Mkn6qqcGlhkPWo02FPF9k8+47c18=;
        b=gOB8GY3ZsDY16RQy42auewijsO5Whnb62GiURJl+16CwQGpK7pKyjOmLpxp/kaGtPr
         UUT0uKabDOpUqGlIq1RffEMMsqWKezOGCacL87itz/vXA1Ix67uWqw3V1b/eBAlnV2dd
         9rqCmOQZdHh07cIknJjFNI6NhpaFA4QAjU1xQUerD+9HRcBkz9C+i7M0IJ+teCkxBNXG
         A2+U6TG3K/ol5AMiisVvHPTUgwVpId6UgunBnoSWoTdh9IvDAPBydTgIOdd+3uX3JsLq
         C4BZKdA92SHekoXiDVUgCu84GCv1BPsqcvJ7oYTSh4wL+w8arjtA8HHeW89SrCMsb5hC
         WQ1A==
X-Gm-Message-State: AFuF++lT1/XF2zOaYVrnqpnNFMQ2OzIoAQ27YK33U8twFYnGMism2Hbr
	UJjOPPBkOM7nwv/lkBce91LJBy1uTtPORsrPWdfgeJDhQupjAtDHAzOCtSj5ndDW
X-Gm-Gg: AYBFou14r3XYO54o0zasN6nurUVqn1io5kogbTPS9rqyXNYnFCuT2wZMvQXJwRtsjNE
	gadfiu2ZBcV1jF/ziw3CyjmUTSOVR3h3ihs4OXSEz465TuPIVzxtN8PRMAU3xma4XT5z1XjHeB7
	9HmBRAv0w8QRB5z+HspeQvGk3GDgZ2vv5laVZBNitB1oyNlUbD1I9AzMxpZTeVCWAJ5MD9vOs6P
	ie334X66dXhxmqkr2rv69F0s/4H0fDc6AUpkWfmVP00sA0H1+9MHjHvvlMXHJLLgB0KS/kJTyev
	IQsze1lXAJwTMgilbPEbqCH8ECfAobs3vHHHETlsQ3sEE/8023Nkc4PpiU9mbxX+Cy2VfqMNYPD
	7XQ2BhO4eXt/uaWCWLXFQ6ILSBmXqFkHPqBWTKMhmZIcnCJiKKQs86W94J5Wr8GrK1P2GmDgZu/
	96vYysAB2cyTUU1U4sa8dzU6fK/vJPEvoVubh0jTu8CLpo7wfVUSQ6L91vfzUV7tZM7EdqDGN7Y
	faCgqA0Or3yFbCKoMFDwczvAsAxPFGyUg==
X-Received: by 2002:a05:6a00:2e11:b0:878:34d7:6995 with SMTP id d2e1a72fcca58-87834d76d70mr625344b3a.37.1789800738978;
        Fri, 18 Sep 2026 23:52:18 -0700 (PDT)
Received: from abs.sf.dndws.com ([50.35.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f5464sm678077b3a.27.2026.09.18.23.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:52:18 -0700 (PDT)
From: Tao <gongtao0607@gmail.com>
To: netdev@vger.kernel.org
Cc: Tao <gongtao0607@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 2/2] net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583
Date: Sat, 19 Sep 2026 06:52:12 +0000
Message-ID: <20260919065214.31604-3-gongtao0607@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919065214.31604-1-gongtao0607@gmail.com>
References: <20260919065214.31604-1-gongtao0607@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MT7531 and MT7988 switches, trapped frames forwarding is directed to
CPU ports specified in the MT7531_CFC (0x04) CPU_PMAP bitmap. When support
for EN7581 was introduced, it was assumed to follow the MT7531 model.

However, on Airoha EN7581 and AN7583 switch IP, setting MT7531_CFC alone
is not sufficient for trapped control frames (such as STP BPDUs) to exit
towards the CPU port. The switch forwarding hardware also requires the
MT7530_CPU_EN bit and MT7530_CPU_PORT field to be enabled in MT753X_MFC
(0x10). Without this, trapped frames are dropped by the switch forwarding
logic and never reach the CPU conduit.

Include ID_EN7581 and ID_AN7583 in mt753x_conduit_state_change() to set
MT7530_CPU_EN and MT7530_CPU_PORT in MT753X_MFC when the conduit becomes
operational, matching the handling for MT7530, MT7621, and EN7528.

Fixes: 2b0229f67932 ("net: dsa: mt7530: Add EN7581 support")
Signed-off-by: Tao <gongtao0607@gmail.com>
---
 drivers/net/dsa/mt7530.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 863f2079833f..9693a55f553e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3309,7 +3309,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	 * interface is up.
 	 */
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
-	    priv->id != ID_EN7528)
+	    priv->id != ID_EN7528 &&
+	    priv->id != ID_EN7581 && priv->id != ID_AN7583)
 		return;
 
 	mask = BIT(cpu_dp->index);
-- 
2.55.0

