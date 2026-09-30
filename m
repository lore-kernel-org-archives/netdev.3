Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CE4052A6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807157; cv=none; b=FrKyblRPhckl0wnXT18Eek2qu5i1pK8JjZSN0FgOIZfSGruRtvncoDm+yl9j76mK29PJ4OHPvfLPkwLBKkOpghhZEBdS9A5Qsc17F/xDKPqXVH5orjEGiJsJlYFpsalkfNixzUdxTbxF3oLq/OPAhRYW1Qb3YNuA+R9cMTG5spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807157; c=relaxed/simple;
	bh=h9E2N/3xuG3DTI3/VYyRY1PhWfqwaVE9BFuNs3NHnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etXeR8/X12gEyJwyQIfwngyAezsv0/8Kln9omGxy2zj9UACRje5VKv/S+jE9pXgcDqGF3vjov/A3qLQZ7n2Vez3d+AuDlJ+n3Lal9pcytO6WjncZX0NMvx2FtMRGuSf5E/7XVY5hMyezpFqPFcVLDX1PZZIc8hlvVqBPNlUvSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BVQ12XK7; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BVQ12XK7"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so539075e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807154; x=1791411954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=BVQ12XK7Xyqq4KknD0PV83hz+PXYagDo2oQGrE1I+6wUfWlH28TWJd44ue6W7nVnT3
         Gr6PvOl5DaFyuD2QOWTv30mokDzrsJKGwlPwxl/GQ/D5SNhoFmZVp+Mf+VaET/oeK6in
         UsFciZd6Nv3w+KNGja1PjridPIvIHnIas7+7MTGSYaF65L6PppxGSnWg/7CWWZIcLa5o
         Xs9j1nnpBs+oXn4NchDriUkZV+9NxcyWRoASBcGHJwkrR3bs3af5STICliwvcfJcN6OO
         qW1gCjugs6W4mYhe0JqF7IbL0Rp2CtvZAPDeHtNTrU2e0ZnzY8tE6RmeDvGhhD4KH17q
         CICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807154; x=1791411954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQBIYVCvvD3LNcr2ErwxAZMTO18Qu/XXUvQyWE+7Js0=;
        b=a3P6haf+Pa+SWcfZgpNNM3y4Gaf0coylO1qFJh8Y8QYm3VD9yv1Fp8d5NWnkLuduXm
         InOmjWKlnA48OsOkuYZy5ptVH13Sg9J/dXMv1PsBwspeOJeN4pziYV+mbxScsz6JkN5o
         MYdHynmv8j+CVhWyZjalCgIWlnqZH0uQgOcpH7YyWjoK3n66Wx4NYfkUuxXdLK+1duqn
         nfO/15Bbyi+go3dx3AyggGzksMxOEbqSBP6vgQerRJdubn6uOb9Sbtkh471aanaJ2oX4
         ftRaMWTS1Vm2rRwvKnBcYxKxEc4ovnqX7YNnexesWUB3d+PJlSS0N4+HuuBTim3RK+GU
         AeEw==
X-Gm-Message-State: AFuF++mGCLXuYubFHiwC6aC4x86hm8oCDIfQOsTdYRp85Fcz6M9yBmEc
	+dd8hhEb6BAetgisSKDYS2wipLupLjfDGH0xnoIX+K2whL04WmdgRb9JUauynAY36f0wJVwvbD5
	P8TzAbp6BToOxdypzA6s6wPxki16ys77LwFxHo5DYWJXSCUHucXQ3sS/7nAAKDxFZywc=
X-Gm-Gg: AYBFou0dcDoG65fJ9g4QLT0itJVOOlHpvGxeeZpOGLr5XAVNoKhcIh/8cDgUuuLIq/e
	kIdxaxezuWfuaefpZdJ2ZZryPSuiKdYpXfl5VRuomy/hel4xTr2ojeL+mw9MtP+DXFVi9ARR7Yh
	eupzyxjdMeIen5s+6OMrAGrdz0CvKrqSruNVDDbrHsLYuo7L2r0kndQtnB7qPDPlMU7ICIQHzsu
	IfRea0bPhHzqQZMsRgGqcrkgl/Hay17xA7g+JcUV15NgxUPTpPNbGKazypDg2850xIipX1nlQMZ
	JI3TVjxOTfmKoP3sfWcBe8/LEPounH/SzAoxCeMNkh9ahq808EubQK7syQn4cuRH9Vv0jX//quT
	qyyCaBf+ojA8RIcyNzgSNav4xNM+dDjubBbZbBU9gFDpbjjX4Rl4VNactLCuI02z5Np0EXu+CQ+
	zRms00nX1k6lgc4L16L0+Kdzprkzbepzc/G244iizdSBWoks458pYPKoOg1hjTsfDIl+1jvMxDD
	2qnEZpcr8w=
X-Received: by 2002:a05:600c:1c11:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-4a01afff3dbmr57148215e9.18.1790807153893;
        Wed, 30 Sep 2026 15:25:53 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/7] ovpn: remove redundant peer NULL checks in crypto post functions
Date: Thu,  1 Oct 2026 00:25:37 +0200
Message-ID: <20260930222542.3839327-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

The AEAD helpers set the peer pointer in the skb control buffer before
any error return or crypto request submission. Both crypto paths hold
a peer reference until post-processing finishes.

Remove the redundant NULL checks before ovpn_peer_put() in
ovpn_encrypt_post() and ovpn_decrypt_post().

Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da6..f14eb4e6c46a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -206,8 +206,7 @@ void ovpn_decrypt_post(void *data, int ret)
 drop_nocount:
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -305,8 +304,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
-- 
2.55.0

