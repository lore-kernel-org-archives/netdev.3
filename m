Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88D4B04B9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062183; cv=none; b=V46r0hUkjzLF5XoButPvuUzz7K6Zy+hmq96WmCXb/Ed1R1l3j6kL/cvCg9DXUPSDxecbN9UX5QixkjeC0lm9Y5MBq5rGqa7pEXtIphyXhc5lJqDuCf8WJqy3HiuYSzdakgpUis7MYZDnc13Y9pIkjrMRbDtYNZahlsdpUpKhMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062183; c=relaxed/simple;
	bh=oHT1gKHnfejl2OEHOjPKNjWuUyd1JIlt2oe3G1d1SmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpUjf24kgPGxeW2xLYspHjjZb9RriJ5ha42KUj0R9sSFYEfT9uRlMCS13unwrG0DBig2dSK49uUqIN9UDujfeLMwXDUX8QQHh4y4QSp9XvObibqoMsEgwXw2/QG2N/Z2efsB5orF7QQERgH1DugdsNnFSsIUBqjZMyldkntYyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AXlVDlst; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AXlVDlst"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1735583f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786062180; x=1786666980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c3h0H1pvMWd3/i3CeHvPF5Nq9sUVt4NBUpBA/8VVJdg=;
        b=AXlVDlst5RAzgIpheZqqHvoeZaK9tDJt3wpYR3igDWK6Kq2HRYeYW7xg0Kv/3UD5K0
         GwGT3Sl9uh6Tf9Tf1hJygfn/Q/vCu9Uwydbqg3dUs3IWhDsEh/eP6seB7n8R0DrbIg4U
         mHAxC4iacbwtzw4fBQ2Xspw9XMIbBlxGu7k3f4okfrpjtTs2SPUjNBGPZ2RPoYnl/iKm
         YJNyT2Rce7kOS/Nvlv5h+yfgnuW2w9Otjjx+oIJX+8s3RdyqcIfT9qlq4qYCWQgMAjko
         lHb7S+zbcX1q8+ew4ew8KIAGWRAIJLd10gNm/GfEUZbHwgUuTPaf0MaiNLawV8X+clVN
         cipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062180; x=1786666980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c3h0H1pvMWd3/i3CeHvPF5Nq9sUVt4NBUpBA/8VVJdg=;
        b=l6KQuvBmxL8epeGC/zRNu9LyEDAxl/sz5c4iOQD0rZbi8N0gbeXRMqyeraQZaBjmqE
         GF1p4oA0uQT9MNQrRUuB57gkOpCHrQzR/mLeXR+uNYUqal1ruCpEhev7VzeF+tXCSxWk
         rHFdFT7kTgosFSTTXpmUXu+r4nX745o5EplzFz7KIEshXQ8/M/GdBNn4QFEsAOebngAQ
         HGgA/Dafc0vXTMMhUCr2vsbmI9ewjgEC0C30xwT4pv7kaXsungjF27cRrOesflDKv6Ml
         htiDuMHaJO+t6yVGCrpBlh5VuQrAQVbSg16ybT7cM+jNKfKlej6Nx6b2ldPommasPnb0
         lN5g==
X-Gm-Message-State: AOJu0YzIbAkzZqU0Z7ay+c5GoHw5+5S+Vrw3HGUgboWtxr+Jm9+0gWFV
	s4AZRCNT73iOD5kgV+g3wJSEiM66nxqD+IYhONLBgynVqB1xx4vvVxO7VFIRsgfNulslvyw5hB4
	TO18904DjZQSkUrtj7997sPIECHtlg8a5Do13F3YHnNh6Wg9td0ojQnKR+Z5F3hEJ
X-Gm-Gg: AR+sD10KJF+ubdpq5g9t6ZuH0SG9sRz6+RwtkkALtD5Id3nNPa0eMPKSt0M3z+5kXIk
	c8ISq2k/oA6WokKoSD4skBKwwXktp8ybsRRZRvPnhn0JOA3k409W3B34DeGajM/6wdkgFeeN7Kn
	9nDAcKeKdKxOtO7INF5JnKgFwSra8vBEywwrCRxPa4G3UP/HkS6cGe4+fQz2abUJAQzB17/O+OW
	X9KWh8qOrJ8YHSc2+qKqsdO/wYyCEZM68n385SuzerJpFTNY/hs+wHAayg1Bl8xGWdR2zrcf5Pw
	v4KwdQ2TvJUAdZfb6gmrvyZJVO/vXzh9mq78UfJn7UJIGPOv5/RLko58ugO4RObyRT4QNNBRkGr
	1VkZIqHtQsnpkS2xHs622O//q8INfB6czXIH4sL9JwqweC63fKEo0l0y7z7ENd1nq+XalTLftXF
	crHStlrF1SD2P2r8RG5HU5yiejxO42nPrMtRZgx84DqbbCRIZr0w9pv6PTEKBZfhxOecIZTcP9x
	awTd7Wcc2uLrbzOLryaQqs=
X-Received: by 2002:a05:6000:25fa:b0:47f:f3d4:26da with SMTP id ffacd0b85a97d-47ff3d426fdmr20169970f8f.11.1786062180068;
        Thu, 06 Aug 2026 17:23:00 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:6db2:29ac:6c1f:5e1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm359215f8f.22.2026.08.06.17.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:22:58 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 02:22:42 +0200
Message-ID: <20260807002250.1817498-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807002250.1817498-1-antonio@openvpn.net>
References: <20260807002250.1817498-1-antonio@openvpn.net>
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

