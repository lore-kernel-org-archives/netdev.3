Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5B339366
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857271; cv=none; b=oyX0gxu7CkGBTPsKfKBHH2iEeQnN3d2VJy+JJNEXkSVfEn4wcahsNxw3/ECda4gDHZiYPlHFjmKj74YueOV98vv+Z3xGrY2DQx8xmYGLIuJuF+hqo8BjzZ29sGnuAUGSQbNoKgMojBJYOajTJQ6b4zfAkx4ZOFRz41TuFPreEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857271; c=relaxed/simple;
	bh=lRCb6HkDic6hHzHLZUcVbPGPOfOs3Lh0b7gVudKpq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urb3lzG3Yo6QSJhkGnzXJGgGNfNpnBBOK1RIqM6e+xBtPyHovCYtDe7SneSOM0ST/rXPDBCFWyhFLUtvugVW3mwe/fgIesKqghSP+DtaqCxyaWashKc0vWKbpq1eoaA23mRddz1nmwAF3Q2gogjtnBOUnPO0Z62dVvxXIYc4do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNXKsDay; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNXKsDay"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso16092905ad.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857269; x=1790462069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ZPy0AencS6Jmk3FwXF8rlSKFKsz3ZBOP8R9mzvOloo=;
        b=BNXKsDay2MRDWXW68TGfSfCa+wk5ml4yBmB4TWd2ZM0A6FG+wXn55zpXTrKdzKnq+E
         l81D6lQEOfd3YlmNfX/xs3PD/ox/yK7uJKHQWMYdq/o72dRFNk1Hgd6eUk/gSPaLzjil
         m1Gbkc5xFR6oRzg7g8ZPDcBI/LwOsgOSIElH1XJzF0WL0Mq85SJoAVaQA2mPbZB3mReN
         nz/AEK11pLrL/+7SHlV1U51uPP2K3ykpDKVq9Goj1yxTFOD2dku7WmTclyGasoeHYNtR
         IIM6jAbJayoeoXhB6HVrFaZq8ZqrFfHIYLMYm6rfsh2zaPpBTp5ptospJhvkQvMIHKqt
         OgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857269; x=1790462069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZPy0AencS6Jmk3FwXF8rlSKFKsz3ZBOP8R9mzvOloo=;
        b=hIpZl6Fo+AV5WGbA+UFweVowwRFXbscWw1ZxRAv9q5BMW5eIyeguCM9lxqMtg40gGi
         fssCl9xBUbrkzJgjPpNy/CTZQJrb7af+oqQrmQLRrHDx2TjXNDiKX1208e5Gfn+RufFX
         rh2n+RUKrGXIzREvj8RoVX05SXvSzzqy6swc9fBlh1tONtNmqhR04n1+fQ1bKEcPx+Eg
         ZVpbBl8fbBNOboIzQAk27DTg1C3TmihNkRWMS7+ViEOayP1Hj2e54H18laR5MMTJvsy1
         u65bDS+q5cXwkSz7bunc07T3bB1D0FP1Epy6AXRc1OCl8kP79DJd39S/WRzpkmxMzd2K
         DOMg==
X-Forwarded-Encrypted: i=1; AKwUvBwpODQIPu50ApGTKBlfYZMBkKBwtfnO9LBsnp9EI4rQ6sddQmB3lz9ZMkXHMUTltE7U8jAENWM=@vger.kernel.org
X-Gm-Message-State: AFuF++njHUAAw+WZvMt/Yh426am7eeD24CAv4qfSSWzupGYqFnmA0xtK
	WBPIUSVwywiigy6LneXE9+5VCuISnaGm8bam93sSQZ94mz0CwqYb13rIYrg+GQZQ
X-Gm-Gg: AYBFou04qdaXkJQjSWeIruJ/NZc71rLTxg+lfqKWnuaSUHISP6BCDGMqB+UHP/hJtbE
	NlhGXAagYK20d3x9mevc27BI8X6y8EMuxdgj93b0VlDStrpZJl6YsOW6mI1tf1zZNonzY1L6LkZ
	YbviaAdL/bh5dadXlDlD4MfKb0U6DvD2TIT7aX7gEuDaZwAqAhNB9ESKo4Kp/TJBxpfRl0n8NRZ
	rcrhwx3bMsEEz9GbzEehA5T/xuG6DsglVyk14MmryGnqfEz1mkZeXAv4xVbOkRkfLQ1mNgxmDuz
	g6t7y/YAvCNUDD/eTUAPYzOP1U2JD1X9TbiMqfRejOMyNwv+gGShWB1/26LAhLI6c4wytOIDPKD
	z3VRsv7sUWDAwiMCMMlBkArZ/aT6NXVla9HELy8EQZrGm6zUp2HbbjaPUIplnfQKZqkHlC7YMBu
	z+hqmpQlYwk3FgNtSg/+DZpRsmBUJuPOT6Dq1bTTocpicHMFmRj63+JnMiR26LvIYSpB7uNNTKt
	g9B8InMKigKSt+Az1BX1A0gFKraHvWw+/r9m1CsSxGy7d03MenZLugDa2qFTmSbEPNLzcl1LsQs
	rHaL7jpAtg==
X-Received: by 2002:a17:902:f78e:b0:2dd:c100:7cb8 with SMTP id d9443c01a7336-2ddc1007deamr45185035ad.52.1789857269496;
        Sat, 19 Sep 2026 15:34:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17d6c70sm13223915ad.62.2026.09.19.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kernel@pengutronix.de,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: j1939: fix transport session leak and socket bind/connect validation
Date: Sat, 19 Sep 2026 22:34:27 +0000
Message-ID: <20260919223427.3881575-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in net/can/j1939/:

1. In j1939_tp_rxtimer() and session teardown
   (net/can/j1939/transport.c), ensure active transport sessions and
   skbs are properly cancelled and released on error or timeout.
2. In net/can/j1939/socket.c, validate socket state and address fields
   consistently across bind/connect/sendmsg.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..712bca1174d3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1672,10 +1672,15 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
 	if (skcb.addr.type != J1939_ETP) {
-		if (dat[3] != session->pkt.total)
+		if (dat[3] != session->pkt.total || !dat[4]) {
 			netdev_alert(priv->ndev, "%s: 0x%p: strange total, %u != %u\n",
 				     __func__, session, session->pkt.total,
 				     dat[3]);
+			j1939_session_put(session);
+			j1939_xtp_tx_abort(priv, &skcb, true,
+					   J1939_XTP_ABORT_FAULT, pgn);
+			return NULL;
+		}
 		session->pkt.total = dat[3];
 		session->pkt.block = min(dat[3], dat[4]);
 	}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1d4af472de4a..889d4718c46a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -470,6 +470,10 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			ret = -EINVAL;
 			goto out_release_sock;
 		}
+		if (j1939_sock_pending_get(&jsk->sk)) {
+			ret = -EBUSY;
+			goto out_release_sock;
+		}
 
 		/* drop old references */
 		j1939_jsk_del(priv, jsk);
