Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C06431A53
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558514; cv=none; b=U2d7q+cBwLIxQBkGBjCnfI3viL7mN0TfU3dvy3fuD/7/fHrVzQJDWF/YixETAyBv5KxxWpUTG7aBlLNYUzyyOiUlH5Urj8cncXesl4v8m0ecP2kZv66eMy+/0XeB7LsrGy0TW7pMpWv3/AbstV+eYb9adXCQpVs8vdeTBJl6e0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558514; c=relaxed/simple;
	bh=rLbahskUWmdvg0TEOq7A7JyfDReI5tB8Azb+s1oz3as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdjYTUEmJcfSU+jUSYQvNNs5W8MbEISBKED7RNoYp7JfGLFVgu6zeTxHA66cGZ7Qs3ZYWYIz+uH8v/8k2mamM2M0Z/SdUO6LwKa8xXKGJ7i8PezYbOZuBbQYfEcZQbokzrLSofEIp6FbaKUDkquaw1hWVM7Y9LERcJqkA6EUZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g8wDRnwn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g8wDRnwn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f71156e1aso763219f8f.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558506; x=1785163306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQCDxzW4gWw6YrpjPRk1psnyOFTFFG0NnXk2Shp+4Hk=;
        b=g8wDRnwnlH64RoOPef6CFKxe1sKnF5wwsMl7xA6HqAye+mKDTZUhRItg3a33q4dKxr
         CLD7TXVHMqJOQ53uOR4jL/3uCb9ds35BnK0Bd8zVyo9VaXzq1ubEVGp7qvtYUMPmHNdt
         ehG4EWXrlMCCwpboB4mpHH/+QrraW8iuTGZRbHILeWzoMk1USU8Z1JdO00EpDJD6wpek
         7FOdRzI746Tz6rn6YYZa/ScBbtinOqcOsQXO3ozmEOZWbZeeQiT5/PoFQbxlIwL3JQg+
         R4uN/GAZLpbrzYXx/qMNOq0mgMDAaJM+uOJeXzgDkIHFJw50MMpDm/0f9OTmstRkOAki
         GwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558506; x=1785163306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQCDxzW4gWw6YrpjPRk1psnyOFTFFG0NnXk2Shp+4Hk=;
        b=Sr8c2leEpWBgn3ucSjfkOHkQAd3Lt0fX0q20E7Zoy/rD92TaXjiGqYwKfGuJiSMieh
         LXv6eKN7Z9BhkFsub6p4YB7ThOtNYLQcEU8DN9Cc+Mus7bmw9f0mrJOxacLNKZh8gF7T
         nqGRddw+BjTVC1IN+X9nijpyF/NntSMmyggMfCpJzVODP9E4rD4iMMq9rBddf6+5XvFd
         MIGU+vOLo4wOH732H6pnXzqrOifuZMvfYPBFkXEj4E8r0Nw49fgnBdaBFaPNIg+Nduk0
         +FKTdlAf7REm+btWl9lDlaFzHfplclN09wI2rIo1WFGfa1lH+VXt+xOPCKw3LgWDfow5
         TXNQ==
X-Gm-Message-State: AOJu0YzKfqGWLuSfJkqfpyzDAtw5GOHagZZLh94nbW6krB59eB0gSaxk
	jOtt3itPNedr7B3ZR1jJGVHW6kfpGsYdRdqw4gBVE801cTNrEXQQkbm44aezal9n+xXWbBWcymu
	hEOKs0cAPvKV9OO/J11dlrAge+FLni3D25+nyccZ2NcExa6JmNVJV7dJPAAQrJx/u
X-Gm-Gg: AR+sD139VnxdPuoUcBlGVC5DRL55N5aWuU8uoUuXsDok4bFQSAW7Imc7mAVHIT0zqjY
	4AXd9fsA2fVoKcHVy477W9vN8Ae5NwreQVDBx+BJmiHalpyVh9C2mnZTm1T8MvCFNgKqFc49B5E
	/BldQLh1vi0GbRWm6g9Erit+07vzrp6OGspZhMaKssXboLlDQ0Pl8AiFna0mlMreePPsPl1qz52
	fuowsXck/HCZB5IMBsqPLnFP/u0IGTz8pCbw0uAhqusuQpZ7JRClTDoLJUX9lKOdRYIoii3V0cG
	2Mb5RVliL5gzUwdfNFXVhonvXX+lpVxaWFDw6aO5QbwreqfaV3aKHanAfi41Qv49Kl0EeaceBMP
	EHdLhvGfWSsLAIS3RFlKxVISY6vteFsEbIm4LTO8Im7FCpYSGeDMPsaQp4nvOz7+sWdKbr21q1q
	XaG1YX6313XxaUkcKWvnpPDQiEIQ==
X-Received: by 2002:a5d:5886:0:b0:47f:7d1c:c76c with SMTP id ffacd0b85a97d-47f7d1cc7cdmr2060715f8f.19.1784558506346;
        Mon, 20 Jul 2026 07:41:46 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:45 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Marco Baffo <marco@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/6] ovpn: fix use after free in unlock_ovpn()
Date: Mon, 20 Jul 2026 16:41:30 +0200
Message-ID: <20260720144131.3657121-6-antonio@openvpn.net>
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

From: Marco Baffo <marco@mandelbit.com>

unlock_ovpn() iterates over the release_list using llist_for_each_entry()
and drops the peer reference inside the loop body via ovpn_peer_put().

If this drops the last reference, the peer is eventually freed. However,
llist_for_each_entry() reads peer->release_entry.next in the loop advance
expression, which runs after the body. By that time the peer may have
already been freed, resulting in a use after free when advancing to the
next list entry.

Fix this by using llist_for_each_entry_safe(), which caches the next
pointer before executing the loop body.

Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2b6096d8b1cc..8fdbb5050690 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,11 +26,12 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer;
+	struct ovpn_peer *peer, *next;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry) {
+	llist_for_each_entry_safe(peer, next, release_list->first,
+				  release_entry) {
 		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
 	}
-- 
2.54.0

