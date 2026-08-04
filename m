Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412A42BC26
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874782; cv=none; b=dKvT1HTvDAqxiwTyKMOrnO1jO0lj5wrRBnwPVSOizm2seprmj88dKljo5B/p26k54cRIeSLajQgqrgVcja1QbaLzYDQmCNhWQQ5i061V8IACzyw2DG9k7KHBW/ZK6BDEaTa+xDJxDAcz+u/DNOQ3j+cPeUG9MeYbcaCiqgUhIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874782; c=relaxed/simple;
	bh=/LJeDAuGWK+Vu0IUbOSeylfhGGJ+OywLgyTGhlrPh44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/lIKXNRgqLNizgcXhG3hMPgNTZtrgC1m72VBp9/fQE/Ad0+xCSrNRZ7wnSIYOnHZra+aeQfHDpc+B/GKe4dMUp5yWek1nPdNHCkygS3EsFcF/dV+kLZiZOY0XpX/AWI1qFA8DTW2lGn4eVhXMUjXwTl8g+yAd8S7LQ/3oh9LBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiIZEpti; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiIZEpti"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so1591069e87.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874779; x=1786479579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKWvqwJnN9M8kSu2yW/P7qhGb8fyraad4Xw9GRMaCPI=;
        b=UiIZEptiUKL/imWbUvNnyYebYR76ismFs9SQ1LhIEKmvAKgkQbr1CbfQF54b95m1Do
         fCPnscCo/oYMjxeBtVV3ITYQrufZceBRZC6xq9d5Oyit6rvh0QY4VBdZqBXYjuKcNlYK
         9Iu9UNc9F6uINlPpeEKpkwZM1OMtxA8okTLUk9WVhZSFUAxyKJKyuK3tgDBWiyFuFSCO
         kzaH6c1mgjTp7jnQINtHzCgeaOggV6Cf/4KsfG3MBAhDDsHweSKw1fIXCvTiOXmcPJCs
         1B5kVCG2ubgh0iBcBF+c8LlYNcvqqXlY8/ZsgwhrjsrgsY0ld9y0rWG8PnamxL0C26w7
         Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874779; x=1786479579;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DKWvqwJnN9M8kSu2yW/P7qhGb8fyraad4Xw9GRMaCPI=;
        b=QQrQMfeRkkGDqohFD/2cIOMlT/yoSa8oGrXN5VpopzKyn4+eLELC+hjRX++KsnRk2U
         B2H73YMKUF8DSnpJM/BPhJz8iezCHqOz4eNyxUK115gO6KMLlUDZjIolZbttKwwL2d0C
         J0ws12A6jnDmtl78pkX9C8GsBYW1skaVaAF849zW4TXZioUt0vMAjNyS+KEiOELW2A8T
         J73BVPWi6KD+weHUNIK/s4QbhlfNaZJu0qiwq3My2K3q31ubiYlDPnxlA+LZl/U8lEGX
         Upx/U2awUDWqGiZQS+ZF68jNcKLGfIQQbj4kWz2059PZ9kL+iCyJrjwCcxMI/MWbnGib
         lMFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRWdE5kYxgXCe4J9GgrXzjQTy4QMq5NybUNiuYyNQFr9aNh74VUGbzWICc8rkmcgxbdWiFe9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVknsZIoD8X10IjIOUEKaQn0vCi++3gI5GVRcmsb5PqbmDf2z
	KdLBt8FYacALTQXw1iL07Iu7szac+NsDdsipKAccNUAcgmC8n1/6iCoP
X-Gm-Gg: AR+sD12NXnld7xj+njBKDUDXBhJtmzVIkGVOJNTeoxoeJk0s6hK2H0wVBHT3tPNSlkk
	R+WfS32VGqrc1ZlLoVonLt1ClUnoldrsyaeRalEjrD5+8UumqxJ75AFWceT8UPsflLj3AaHBlf8
	kWCVRoTpjBagWdOfPqrXYMetKm7GU1V+R0/Iko5meg3dWy7kfxQMqrp0zoaYG6Ox3OSzKre00Om
	457ZI4+xm5GpDPC3kLVvtz72ug/WsSYtPN0VlIbznwB3pI/fq4AhlcR+JPJ/fivYfUAhxu5bDOv
	xiPE0kdpKERa3UHGzQE79NdrDy4mgA++mKm/GwUCcSEW6CnsqPawau16vD1W6E2TKTlr51j5wn2
	53CaZvs6Jm8WeoA/6IKhFnY2VQHjpI0rA157cORn/f+0LfMX9PHFj9cjycBJ7QWORQ4vQA8EjxU
	Xv62yjmJg4jAafWRJ7kMxTRQQQM6/qhYDPEReQlLBivnPrVt8HkrLwKXlw
X-Received: by 2002:a05:6512:a481:b0:5b1:5f9a:96bf with SMTP id 2adb3069b0e04-5b2f485d30amr177786e87.8.1785874778843;
        Tue, 04 Aug 2026 13:19:38 -0700 (PDT)
Received: from luk-pc.lan ([89.228.17.202])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5b2f62af852sm12661e87.48.2026.08.04.13.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:19:36 -0700 (PDT)
From: =?UTF-8?q?=C5=81ukasz=20Patron?= <priv.luk@gmail.com>
To: 
Cc: =?UTF-8?q?=C5=81ukasz=20Patron?= <priv.luk@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qrtr: ns: Raise lookup limit to 128
Date: Tue,  4 Aug 2026 22:18:30 +0200
Message-ID: <20260804201919.1148015-1-priv.luk@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Current limit of 64 is not enough for Sony Xperia 10 VII (SM6475).

Fixes: 5640227d9a21 ("net: qrtr: ns: Limit the maximum number of lookups")
Signed-off-by: Łukasz Patron <priv.luk@gmail.com>
---
 net/qrtr/ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e5b2adb161d9..c5e7e01db249 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -78,7 +78,7 @@ struct qrtr_node {
  */
 #define QRTR_NS_MAX_NODES   512
 #define QRTR_NS_MAX_SERVERS 256
-#define QRTR_NS_MAX_LOOKUPS 64
+#define QRTR_NS_MAX_LOOKUPS 128
 
 static u16 node_count;
 
-- 
2.55.0

