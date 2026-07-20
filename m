Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4303F0AB9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558500; cv=none; b=SayzxoL133g+0YB+Vbdg06oMN+RoGJ6cKhqlKxFp8BsmQVrD66IHe7X7wcpMbNe7duCObZ+loptyZBwUZbw4JXmd/yUhmd5mFyZq00xMIemcueus/Xm/cYSDFy2HW5fnrOVdY71AOpMQPozyyMe0DekavMDvHwojm7UMQrbgMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558500; c=relaxed/simple;
	bh=lyMCTI3BzNChXaA5hweF1WA0w9Fuf/a7voTSUQoORp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTAt1Za1q3Mvcx4/avPeB3PYKYyaOpEcFhlDp2W0PDqaj6UDOPlJdDrRGnFdwv2Yte1YOGluhbh+ecxJEkG7VplTLf+zitL0LZK6hnRc+jc+I2YIWiGkm8KlX3TLyHQAXW+9sAs1GuBzngT3wS+mhop0YHLhhRsiaaNPHLvq5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PN7gh6W5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PN7gh6W5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f365afc5aso4919657f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558497; x=1785163297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Npy3AqzrXkfaRGrIPVvktS09A8Y2J2k9EWhRTw05xM=;
        b=PN7gh6W5Gk9rTEXX6suxdLBalIuh0+3MYwI+VdZi6ft8n5Q/KMyrMCOoFxKaBRFiZM
         uRDdfbiFPLPDinesYCosOLDEH909Ru9j/Cq7URVXKH85r74+0fE5Q0jmePaDzPpcOB4e
         6Nx2tAFWpWf5g9iSX/j9LfJOTM15UyWUIpZyS6MvNHf8sEzek6N85OVnVUkA6PICsORt
         ZQphFJtmkycSu8cK4enAsFdQbq8QpK63xbSzD6WGhyFoDQTXTVSb2ZcGbtdCRxsx8xGe
         0/UvXKifBUpkQq+EhvA3GmGYnTEIcBEJ6OK9CwtznhWaB3PkeXlD047juKjAQdWEffna
         VvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558497; x=1785163297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Npy3AqzrXkfaRGrIPVvktS09A8Y2J2k9EWhRTw05xM=;
        b=BF+WZVRTFpbzrjJ55LOPgb1X5nq4IjiYzjox2lmEgETFHqRovQGdFf+4WjspOpOnkT
         o2VK7p6QwuqoteM/xSn7GmWT2TNB9aZoXDaEFaxwckAOZRp6uVK7EnsLvjHAzCJKgePy
         h+xHgocpM6zPUpDZJ0o+m+vQFqjPl5y/I4hRq/73/73lPiHENEEh1ZnLdy5V7F7b+F0a
         q8W94wJrWcZ/73IPV2yj4dHjwxL51Dpn4QuQREzHhX18xIN68FxecnKeh3bn6H5SNnpb
         QW9QN7ho5Y5OPuyClV0A047ZZcdx+J+sXNAsyFfY4FmVLj5VnP1RhRYKsJBxnZfAut4J
         fOJQ==
X-Gm-Message-State: AOJu0YwZ61HdiVF3VoFeEERll4oTnOg+FDZjbQnM3++EqTW5kbNDT529
	/CWndzT38Hf2isOoijI5KUdjlrIHY8npFkba1vlRo93MLnpOh+g29M0zcCWzSTw/+/yyp00LNVe
	0uKen38yhyyrfDthDwUStnkpo4B5PIUknle7EqlaPA1Qh40LryH6AH4EGIthZzcEq
X-Gm-Gg: AR+sD10pcAuhOhIXjTvYKagCIlVPpEO9RuMfRElqvUhAolYwC3FEzYil3AICUbe50SS
	2m4vqFdPGwyjHkGe/T91AXlj+Fk3KEVWv2z3h8QAB/giw6u7vTUeX7LDEmCnm63oujgkF0BRavQ
	Fj0aTwj1ahdZlZ3a3iqtGoiy2lu0tCbam01we7GsnQ+p1WX9k2nOtslNN+zIilqVBL34H8L0GoZ
	ovPmFLHpUt/ZKAEehPuWUF1cHIqpLqiOzLuMpvwtGhFcgZs9h6y9G06UUiGXW/eXRZi15JcpAXo
	3R/J1IeWA30mPFC4eSgVP12rz5JGWCyYH0KpZYYG7FQw4KSKH64LqVSmxi+sBo8Ehfq5Qxsb9j+
	9dRzJX3sW1og4+b7kkSmK3L0Fq2Elvaa9YNXDS5uM7JWixiB3N0fVv9Wo3/AzLTx1CLqb2YV8Jo
	90o29BZbTpX6L9hIre5VoWs3iQ4g==
X-Received: by 2002:a05:6000:188f:b0:475:f0c2:5afe with SMTP id ffacd0b85a97d-47f6233b1c9mr17903774f8f.52.1784558497030;
        Mon, 20 Jul 2026 07:41:37 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:36 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Qing Ming <a0yami@mailbox.org>,
	Simon Horman <horms@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/6] ovpn: avoid putting unrelated P2P peer on socket release
Date: Mon, 20 Jul 2026 16:41:26 +0200
Message-ID: <20260720144131.3657121-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720144131.3657121-1-antonio@openvpn.net>
References: <20260720144131.3657121-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Ming <a0yami@mailbox.org>

ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
destroyed. It checks the currently published P2P peer and releases it only
if that peer still uses the socket being destroyed.

A peer replacement can publish a new peer before the old UDP socket is
destroyed. When the old socket destruction path runs afterwards,
ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
new peer uses a different socket, the function takes the socket mismatch
branch.

That branch still calls ovpn_peer_put(peer). At this point, however, peer
is the currently published replacement peer, not the peer associated with
the socket being destroyed. Dropping its reference can free it while
ovpn->peer still points to it, leading to later use-after-free accesses
from the peer and socket cleanup paths.

KASAN reports this as a slab-use-after-free on the kmalloc-1k ovpn_peer
object. In the reproducer, the object is allocated from ovpn_peer_new() via
ovpn_nl_peer_new_doit(), and freed through ovpn_peer_release_rcu() from RCU
callback processing. Observed access sites include ovpn_peer_remove(),
ovpn_socket_release(), ovpn_nl_peer_del_notify(), and unlock_ovpn().

Fix this by returning from the socket mismatch branch without putting the
peer.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..1844d97154ce 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1167,7 +1167,6 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 		ovpn_sock = rcu_access_pointer(peer->sock);
 		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
-			ovpn_peer_put(peer);
 			return;
 		}
 	}
-- 
2.54.0

