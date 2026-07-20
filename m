Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31F431A27
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558506; cv=none; b=UvAtLCmxI2nFQi013U7IZTggLIhIueJvddvrGy5igcKcUNakOmaCfgVAJFkhRQgZjSyWAoL/N0TInb6LaIeHasPrj/KnoH0pof6X11n/Tn+3KqOyPXDMxysi9vNOfGty2or/h1qluIkvZlJ7byoEpJ9dfsD6XK5OK6qw6VzdbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558506; c=relaxed/simple;
	bh=ZN+Gspagq1DSI1BqGu1pGiRI/0LJs+zTie5Lx5uTn7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR5Fl39fiN2+FwVPrZnMxZjv53zT/II4TrQ2cI/X+BqnNsYylJcqOXrH+zbWLaQQb7wPxuHWrzAxFHyZ/+44/39ysUFtiKIJQcR9dLXIKZVnjOQ6+EiJA10NDNtd6Wp1J5xA6LM/7/LVZZIIVSxzWxHvatHJK8eVSLC9x9v1w+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P3RTaZr7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P3RTaZr7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso32035685e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558502; x=1785163302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy38S7j197pJcEB3NOA9lnctPRrRAYWG2UNLZRWX3ns=;
        b=P3RTaZr7TGtZu1ZquYsL69eM4B7OZ0URflBEthzLENIbccSdZrdzmZy+cNRD9Ef3nX
         E67NmaRto6cTj0UPafzAHF9YFxOcRnS9SiUpzogZH/X5FLg5cnfi94vapNS9c7CV+AXR
         5V4JFIc6CghhoyBEcfqWP+Xm8Re++gsYWdyKKCb1px6Pl5tvGmcme9LcXzrLdiPbUivA
         lmfXoAsdppO8bEwojz3vGLaZeD1mO6QzSSFRofGbNThmedI+KTE0BHTpXc7u9DLuO88n
         rO4ssq+WHLQXMcfZClZG7XyV4TP2RxFjkpzic4uvgwXsZrLvhQ59AJC20+PnXEWstESx
         XTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558502; x=1785163302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uy38S7j197pJcEB3NOA9lnctPRrRAYWG2UNLZRWX3ns=;
        b=E6UtIvgwVBv7nAo9LeEsF9G+TLNucTANJUJ5aId+RhWTEwFSAS/dlVFm/cSKLEHzBd
         Oyib8vuU/k/luRU50aMQCQDxMvrw05L28nfrewkx+mx5BjCHvN1tlFlIM9wj0LmU8+ht
         2RRmqEJz+AlPUeRJI/18z0dbM9lnwVttrl1tePqVzFXJKvnmC+kNGqrEFnLwnZ/vcsMU
         HJ9T7RhiK3RS2YsAEyTekmMTc8/uD4ps4bbjfXBCB+JOUHUUVZMM41OlWtM57YtNSIJB
         Q0zI38t2FDChBCqakrhw0G9D/wysU+1lZe03pFypGSuIMnrpSPrmqmLr9V/EO2/KuLgl
         IPTQ==
X-Gm-Message-State: AOJu0YxnZ1QVQLuiE6LRh72PaxGb6z30EsfX4/PRifj0jJPjgk+3TkCu
	0OhnO4Vn1Aq0bGxF4QjJ2Az+tzrdz8IaYPZs892oMdJbHw20dYkaaKUmPGN4l8edkKIqgHVA1/L
	hqMA/CEv7ztLMcav/5wRzVKQ38zHjwLrXd7TJB6TIlOJyHuggtQFeL+O3Pn7aJO3v
X-Gm-Gg: AfdE7cn0QDDCfT0Uf3fLBXx8Q2o2svpSihWz1P92IdxHivX73dqrmRKRSBFVvoCYs+l
	fpwXPIETJtSP5L+yCDiWTrkn5E7w9VZRNXhNUbVuzkhYu7brz1+FLmV2BMaP+JH+u7W4VxKR3Lo
	3ffySck0dn8FRXCoKcjuPRVeYxlozfTHTDVTAcyqql4ALdmYXcD8jWOBEy/KqDEf0ynB4gDBnpk
	OWqD1S1RFRI+zoknrHoVXvqjyRWESxMBigcZ55sSEKuMF+wGJm304BmV44dEusCRJT1aV97Cqgf
	rVf47BL+1Od2gQ3V5hLDhV+856w21kxmCE9S+BiqUv4CjVzdjtM0S0mHaiUuc8hFkRZAp1dl5bK
	rkN7/Js2qCphUSEfumWNXFo92wVqacf2YTSelyaaQCX4gb7R9l/jShysjwQ9+8rV6NbbOyogCUc
	E4H3j1SKBHsY6Ca0n1I5EzYSRinQ==
X-Received: by 2002:a05:600c:4ed2:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4955fee6628mr38242785e9.0.1784558501713;
        Mon, 20 Jul 2026 07:41:41 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/6] ovpn: hold peer before scheduling keepalive work
Date: Mon, 20 Jul 2026 16:41:28 +0200
Message-ID: <20260720144131.3657121-4-antonio@openvpn.net>
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

From: Shuvam Pandey <shuvampandey1@gmail.com>

ovpn_peer_keepalive_send() passes its peer reference to
ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
currently queues the work first and takes the reference only after
schedule_work() reports that the work was queued.

Once schedule_work() queues the item, another CPU may run the worker
before the caller gets to ovpn_peer_hold(). In that case the worker can
consume a reference that was not acquired for it, corrupting the peer
lifetime accounting.

Take the peer reference before queueing the work and drop it again when
the work was already pending.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1844d97154ce..2b6096d8b1cc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1284,8 +1284,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (schedule_work(&peer->keepalive_work))
-			ovpn_peer_hold(peer);
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			return 0;
+		if (!schedule_work(&peer->keepalive_work))
+			ovpn_peer_put(peer);
 	}
 
 	if (next_run1 < next_run2)
-- 
2.54.0

