Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716797;
	b=iaq0LQbO/GDxCO6QIHaiHZBqNGTOcVT7aXvf1FmpZ7fiNgfCvq6+0IDsVPHInVIF3ZER
	 cGQjOlVgOkbmpPOk5LUxm6SabO4VgoUL1MMim4tjrSgCaRZj3vMVxOfGIKla29du9a01z
	 qxqdhnj/J31QUJwgTB11+WKdH5GCKijnonmBfGojyf4zUvLOC6ELPQY1VgpXdZi3BqZyL
	 TpUI53IwOmLiZ1aS2vdOAxa6hH45YSKrshTbWy5c9owoEkIAJEgeUnNyrPm6+tIfAckUN
	 d+4ZDGJp3ch3JLVQ3uWFBHNy09EsonB0YZf1wVociWghQXgFtQK5DdMfxRGdFpJBlog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qwzDXE7uMgYzr2LALcYpN7OIf8wwLpLfy0jma6A3Wno=;
	b=hBnhqE3cn1vkgL4p4ThcI8iknBM+vpDd2Sj/M8LC+IDRLmJjI2NCBavRSqdwL0J/kEBP
	 BFCdvZD9uBZMybxIsaCCq1py6/R3mqo6uKmhcGl4trllz7OX4S64Gvsv3jIfPb2+exHzr
	 oaT76CWfPA2aEF2mSkOjrbtdryJk2PHN13z3ygs0hOpdWM5zzvBZqUwCPUkk/GizpFGFF
	 MvcxdorAv6tuOwtrX7Kj7zzDF3lnADhiruhpWu2gnileXBIwRTCQXjvYTiF/Hkru1D/pT
	 bUAHflGlNJNHLrP2IuDQE4tKaG509+w2hOpI2TGTHl0Lo48UNfknjLuxTfK65B1BkFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0InhKW7;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F70606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F70606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0InhKW7
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-368581df789so334654eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792716796; x=1793321596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwzDXE7uMgYzr2LALcYpN7OIf8wwLpLfy0jma6A3Wno=;
        b=e0InhKW7gLeCEc0Iv1Lj9EUBFyMNPdb9KWqt5zOitlonEcFpbklZBhIG6kcwfSCWEU
         QIFXohUeHtAf6b4yWKZTGNqK2sbUon3Zh38wRmwLaM2FIEz4BWkY3tmvOq8fGpXDpcsF
         o2MjKFrVB8FA4EdKZ0OMco1IvhepfmE4uNSV9GX0Ag9+FnG8dMfbRM/ZLgJneoQYbfSH
         /o4Pw5dSZEKmTx1t8vuF2one6ce+FfhA96v7BaLmTcsEYoAnzu5tK09r3UNye/133h/9
         E5stzBCmhYSIexMpRFR0GnqKbQaL2A6HW/MQH83kKKx+RfaQ3C6hTmAqoZBgFrY7t5Oo
         9fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716796; x=1793321596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwzDXE7uMgYzr2LALcYpN7OIf8wwLpLfy0jma6A3Wno=;
        b=fHguA0gsX0FG/FNf1PUhoqJYirwO8IsPiDmEYnsXsrathwA44jCmiaMJ/+XvGWnEHA
         BZ70Bc7OJVHetgXJAHZWvaQ5FKnVE9krOzmbl/1rd9G8fB/ZFl/Xp+19NKZU/r/SZFDf
         HZ95JTX67FZ8Ex0IRRnpmjG8DhDYY2iezhK7PaFrulf4zEoOuQIzSG7XRl3uJHdnIV3V
         9DQ/RNyR+ZepZJOC244T3VWhxu4WzTQs83N+xru6F00Vhh84pEegJDC3lZiZcBAEYptI
         2MDwdAoJ5O3DhOSMaeDVIrMTPGQ2hrJmwMI/JtLLwop8rXYJYMSzDC4Sk3ubJZIH4xfO
         mhNw==
X-Gm-Message-State: AFq9FYLVPHEsQ8e8do0CnImjWArx8EDmG3Xdob8ItaFQrFANnanCc/ls
	pun7qbhgxUVsNFzs6d57B7fjLal1EiDnOeFPh3o7kLEM4L3Nubf4f8IFD6JsX7Xk
X-Gm-Gg: AYBFou1sQkjHnKYRE3hZ8ob0hVnr3ae+x0T1yaQVWPlLXWltssYnqVTN4GSc4zf3KOY
	fUpRT1oO21aFO3/xNmc+rQRBhFunNkD5D69SnBvXaDSViRgnKh0B7aZCiNUceRd5k16pL2fOgq2
	f1ZKXft64wNkkvuX+07IZpYKMT4ZZyZR9L2yCS1AdaCB1PccdHqrEgSUf37/KwepschUb+dr/XX
	9Loc5mtojvLvcV0OD8hykcYDmm56M1e4m4fcFp2kgGxzaggldgoSAvQXeZFIFbRvuRdAqDdLOVJ
	WfZZS2WTbWh3vnrJxLHSd9+ou0+e9DagMgbr5btySJ90BKFoX8FQbHQjvzORFstMY3JtIzqbgSB
	iiSdJjSsPg3DUZxC3az5gStsapMxGAC/GZQiKk//KQbf2z7CKm+q0MlMOvoJkKJos2K4LQBDztA
	XeJATyvtr94BCJklC8aot9g21+xPNsFHAbz4l1ErwQobXuqSpxmQCNiE2tqAntqTDheup/qOHi7
	oNjggveqMSAcUQ22fEUTJKma/m78XYJCUkaje6CUMLHgRRTylNK5KejVgfl2Zvv4DO2DVRfbcnC
	y6drC0PRy/FAzxDfo9bc08JvPfWQwu0jgL0+NuhRdjBxjWjav/i5SLY7ejxhHVEsZceggw5a3eK
	yPCW9ni84Avm/NCFNtdnGj+KZFAXs
X-Received: by 2002:a05:7300:ec8b:b0:368:d722:48ac with SMTP id 5a478bee46e88-368d7224a10mr3977854eec.14.1792716796168;
        Thu, 22 Oct 2026 17:53:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9a72ff2sm1686107eec.0.2026.10.22.17.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:53:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: fix oversized RX frame check
Date: Thu, 22 Oct 2026 17:53:13 -0700
Message-ID: <20261023005313.3946390-1-rosenp@gmail.com>
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

The RX length sanity check compares the length reported in the RX
header against BGMAC_RX_ALLOC_SIZE. That is the size of the whole
fragment, including the space reserved for struct skb_shared_info.
The data area handed to the hardware is only BGMAC_RX_BUF_SIZE bytes,
and the frame starts BGMAC_RX_FRAME_OFFSET bytes into it, so a valid
frame is at most BGMAC_RX_MAX_FRAME_SIZE bytes long.

A corrupted length between those two limits passes the check, and the
following skb_put() runs past the skb tailroom and calls
skb_over_panic() instead of dropping the frame.

Compare against BGMAC_RX_MAX_FRAME_SIZE instead.

Only compile tested. Not tested on hardware.

Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index b3a92ae95de3..6873c7bb7a14 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
 				break;
 			}
 
-			if (len > BGMAC_RX_ALLOC_SIZE) {
+			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
 				if (net_ratelimit())
 					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
 						   ring->start);
-- 
2.56.0

