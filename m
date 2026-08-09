Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548973603C7
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310512; cv=none; b=tphOrPuW00DWUmlXg+t3wu0IFkQ9NxHEt3PF/oF7w/VtyTHe3ofGlNfhxbnKmnQbB/6q2Q3Ubo1j0AxNmYjrDueoJBSsokQavifA6nwMuJZNyWYa8V4+/ERqimvnBhILNUrLS6dFuOPh0vJ68GSpwRQaMv1HvOlnQfgQJaXBeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310512; c=relaxed/simple;
	bh=oHT1gKHnfejl2OEHOjPKNjWuUyd1JIlt2oe3G1d1SmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+OHt6SGbX62OnCJYKmq3CELWXA51S9WZ/8CTI0eOc42vaypCRo+HKQ64HywwzV5qEOQkceeNQM9KbITj3OrmSSpvOAWId0lB+N6wwXDcSPdd3DyD/qKm2v/5G/6vLtvoAVg+XcIdxmKXwbhhNlcPBAdgq+r7m4RpNG0AWu2acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Qt75lWUM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Qt75lWUM"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de008b020so726251f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786310509; x=1786915309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c3h0H1pvMWd3/i3CeHvPF5Nq9sUVt4NBUpBA/8VVJdg=;
        b=Qt75lWUMmbKanZ61youfc3lXVTszzALKxksE3fomtSHgqHz/BdYfkOKNAzCSShg0Bm
         NLzI7mfjRyUbMDZvYJGs7MJodfzITd51MoNdol57/HPs5YrtIRhgrKZXS57SRdTUQ2Bq
         l1paanBQNxc6+iSO1/jdzpVdpguvIMP7WKu+AW45SWuVFMfUIeuiRUCTq0V97wr3AQHM
         dU4Tvm6l/vjMbd04MyxZY7sMoZHs/I1ObRxnItIGf9bdJZMJsu87vC2oQvwtJUx/FGIE
         HcRBfZ65sJp0OYprX6QM9pypGy9su0Jf8DEQyO8PBmTqJPFxrRPNB0zfcfOWGdRdaQwc
         bGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310509; x=1786915309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c3h0H1pvMWd3/i3CeHvPF5Nq9sUVt4NBUpBA/8VVJdg=;
        b=nUD1ZbW7hPFjY6kZnuC0/8hK0vCqwkzsddjjOefMWQtNnNjW58t7/QAMxqB4neM45H
         T6q82OLeLH6wzFhMkIRwSh3H9r1OQGY4+pH2Nl1Rz/pIcDyicu8bZjj0LP5qiOxy/wdE
         ais6+j1YzRIOcx9hgF4Ga0GxaXeQc2a/d9k3ULw79JNjh03dwlmwaUXJEbZdrZNxS6sZ
         zjo6xIq7JR6lSJzORKph1OKZ77LI618ybAh9JmlHRP9Xn0mEQXEXS/5jIcWqPCiTXa80
         vtzuuUR+zWc2LZeKwTkVBFdl3njHQiYdjpu8v6W/XOgwQWxDRQrDauWZPscdNzOLMuR2
         r02w==
X-Gm-Message-State: AOJu0Ywitm+s4BPEV4AoOwvQ9NpiOGjIX+QXM1JDaHcfogdHk3ORZzQX
	6M61rpVin9upNoW0LkXWEzO3wWz7zykVAh/3dOHSRafWlf6ujrjPPnQdBNU3aRXQSbuBbmxCzPk
	9OzcbdkxXd4WvS9b6SUXpxzYULdxSX3FAImFQaY+acEjGNFNnN5Obclh8U7uhsG+o
X-Gm-Gg: AR+sD12C8j8DkAhM3Q4Lyb3pY4SS2wTA48fwIkvAF49O57lkdSZ+zBqDAHSGSeoMwj3
	Y3F3Gv+fs+EmQ58jBbGXlkKx2QPo52qKJ9QZXSYcPz2DXLB9FEoq6P7HwMvqySpiCKvuOfgD63m
	t02BdfhFMWuEHwsRo+zmQ8JErRc2TUX+GhNq6YOXTI9iFt83dH7sAwv3ELFo5nvDYOE9S5pYIgQ
	g9KlD3B4D/Aqr4gfrWrdY6tgH9R3zizr6RJtKxTGU6Q8KjCLm6LU06wFvSJHeh4NXAIQT7+tRWH
	ggcokyTNkiOM+BZw5krwKy8lPhbRMProwYNT7CKYHhghvE2bWD8dyAGrY5vQt4jA7u3BHzdFuor
	THQZsiqhYeerI+tG0YciZW6QjTCqa43ZLnVrb6ijqzJ7YbseppVyBUwIu36GOmZSlrsvPdhv6Nq
	ua/oLQsgPjK0WtsPzYJal0Y8G+Wz3o+wjalTxtU0ArsV74oK6H4PWgpc9ubQE3Y92VFMht2ht+f
	l4M1GJrmJ8J
X-Received: by 2002:a05:6000:1ace:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-4813196655amr18835087f8f.11.1786310509591;
        Sun, 09 Aug 2026 14:21:49 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:58c9:fa0e:8293:9eba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm24976651f8f.32.2026.08.09.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:21:48 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/4] ovpn: finish crypto callback cleanup before peer release
Date: Sun,  9 Aug 2026 23:21:27 +0200
Message-ID: <20260809212142.2249027-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809212142.2249027-1-antonio@openvpn.net>
References: <20260809212142.2249027-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Crypto completion callbacks hold both key-slot and peer references. The
peer reference pins the netdev, and dropping the last peer reference can
let netdev unregistration and module removal make progress.

Do not release that peer reference before the callback has finished its
own cleanup. If ovpn_crypto_key_slot_put runs after ovpn_peer_put, it can
schedule an RCU callback backed by module text after ovpn_cleanup
rcu_barrier has already run. The TX error path also freed the remaining
skb after ovpn_peer_put, leaving callback cleanup outside the peer/netdev
lifetime window.

Release the key slot and free any remaining skb first, then drop the peer
reference as the last callback action.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..9526f8096da6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -204,10 +204,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
-	if (likely(peer))
-		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -302,11 +302,11 @@ void ovpn_encrypt_post(void *data, int ret)
 err:
 	if (unlikely(skb))
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	kfree_skb(skb);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
-- 
2.54.0

