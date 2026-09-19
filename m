Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B4384CCE
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853804; cv=none; b=tTnwRVlCOtmhkbSXaqxvMzdwlaEPHZ5f7JscDUsqqPP/KD4YkYfiP6wriqwiRMhZKF7U49MDe8M9c/BaRCG/Io3llKLhLjyuwTkf5m+sgw39kbdwRVSemMHy0czHWZp0dheSufAHt6LARTqn91XdYSOwdUmeCM06azyl1G8WRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853804; c=relaxed/simple;
	bh=f4jMlkPHKrAKKCAbmRgO9SXJibE/v5rzjynGwirQG94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njZVxJpyqLuhhjlrfls1JCyB5E76icnuVL6SaO0by689ZfCFmSo3mKAM/TQ/rb/obV7V9N6A+Xjzy5FwHJAZcxGcPXSP24l7b9bR9Yh+oaExl57cHddcTyTO3dn8zbqAOwjNwlz0hLe/p9596Chbmxv7lLWIv1ZcWyd8+rzWECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNZjNf6m; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNZjNf6m"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so520635a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853798; x=1790458598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0F2+TaLfY1370Fmjz4vA1G1drB2ME0rZrVv4cP5FmI=;
        b=QNZjNf6mcG+sXELrLVRpcyszE/dGrRRbN/a9QzlBsKwnEVmSyWk5QEJm+vtt4IisHE
         YhkigFLKGP87K6tjTPmj5SzFUBAEHRXNaYcIC4RATYaY8fhMmMSK+4/if7CZSlMlaIsC
         2wfP5oY36GmzFqD1TTc/dw2o/yWv3ZDch092QrZEKKWBEhZpHwVPaIszJj41/EANgEYC
         eNOmaXF6vJ6UJdT3r2cQXNqF1dTOGZOIzS9oayiGop9FTSrLKz4YJMghQ2QR18nyaul7
         C0GniPEm4waO2tWd/c7JDzn3w3EwQ70UeJsF/VClmxlewZVVIUyqpC72aNGFsFApQsHh
         tOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853798; x=1790458598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0F2+TaLfY1370Fmjz4vA1G1drB2ME0rZrVv4cP5FmI=;
        b=iXHRxyPJwVIEZydfhKZu9cIgBabCqGkQiXnYz+DD6PErgla0vrKv/glNfpdzHEosc/
         7YBe44bT8YGcKOyL3vlSq/z8Frfu53o1FBaOS7+FcV6WNF8XpvuAK2C/WjKPjnEcREZz
         328GGgd0+MUusNLdy9U7wIx4F52JSdEJh4+xC6MFCVD8aBukFf6ddGKz2Gb8ybShzqBl
         jkTbtOc8zLGDjjpmo7M+PBK3+LwWhw5wc25yOlsleLV1uGr5omwBGgYeQUtmFSeuR9K4
         4WIQ/fdGFsaaScQPNiQFerU8Iw71lD8UAa0eVhjYHgepLgt3N2YhaCOGDWlX2eSkZwV2
         p4/g==
X-Forwarded-Encrypted: i=1; AKwUvBz5lZJYLogp5cSxUwTvzPGRDN/U2B8XALeSpKgHVdz6j+ld1QYPPLvBhv3SWai03pI1/s2OZ7M=@vger.kernel.org
X-Gm-Message-State: AFuF++nNVdB4vcVwwLREsZQZONrFsDaRNENIz8cOL6iQWInCOL7G0AfV
	Qk9FD4HGHH+I4DNNecA44hX+ftA6qLcRux5rViIro5x82zoumJ5K+GFPmt/eCwO9
X-Gm-Gg: AYBFou2pkC12tPTgzKm2IkTPtsQ2xrMWizJ5QjqgWfAwZ7IM3Vg2dt6XdhvjHYxfWTG
	5N+Q4B7t4R1SOFoP6JBrGMkAsjTGMR6uy46Pi6fxSvUU3b8QmDGhTYikg94DP7prJKS/HOcgWd+
	AtcsF8CYklACKcoCAG6paX6kHdvwR4i2FUCYMfaCvPP0ds4LbeBPgXCf4WFKHhA8/he04ZbYtfH
	nby7RO/RZSmKOU6wzV31ko8gUABMQJ1189fzflJwZ3iHZ0FTRG7DGqzVEcBt2e3AxW4UuEXKxOb
	/NdJQaHVuPpd3K6Nri2kX+hK2cZmhz1KN2HJKOHxwo4FO8emSFvQXICKm0ZVjWfT3wB/UxYSrL7
	ntT8c3ZkmVezn9cncxqv6+oq+UcfKezEdWEIeaRmvJjSYoU9wbBhOUYL1XLtpM8/bRekmDMDo+1
	xgrQAG77e3pG3NKmNyCXajwmpuNXCUnnlYufvdq+z8omjhf3JXfu8s8QYiwNDrgZ0QVaL0nnRPK
	90jhhOZmTgQCY3uJ1JGv9iEt6Kb/fzoPPiZ+VZfaAh1xHuPWvfZZSj1uW2GJ+BlxdmzG89c7HeZ
	jb6GuQhU3Q==
X-Received: by 2002:a17:902:f68f:b0:2dd:c100:2518 with SMTP id d9443c01a7336-2ddc1002552mr38696415ad.33.1789853797865;
        Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba48bsm12783535ad.45.2026.09.19.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mac802154: rx: fix beacon/mac_cmd skb leak and short skb_trim underflow
Date: Sat, 19 Sep 2026 21:36:36 +0000
Message-ID: <20260919213637.3314421-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two sk_buff handling bugs in `net/mac802154/rx.c`:

1. In `ieee802154_subif_frame()`, the `skb` passed by
   `__ieee802154_rx_handle_packet()` is already a dedicated
   `skb_clone()` owned by `ieee802154_subif_frame()` (with `skb->users
   == 1`), and all normal return paths consume it without extra
   reference increments. However, the `IEEE802154_FC_TYPE_BEACON` and
   `IEEE802154_FC_TYPE_MAC_CMD` branches call `mac_pkt->skb =
   skb_get(skb)` (incrementing `skb->users` to `2`) and return
   `NET_RX_SUCCESS`. When the worker later calls
   `kfree_skb(mac_pkt->skb)`, `skb->users` only drops from `2` to `1`,
   permanently leaking every received Beacon and MAC Command `sk_buff`.
   Assign `mac_pkt->skb = skb` directly.
2. In `ieee802154_rx()`, when `IEEE802154_HW_RX_OMIT_CKSUM` is set,
   `skb_put(skb, 2)` is called without ensuring 2 bytes of tailroom, and
   when `IEEE802154_HW_RX_OMIT_CKSUM` is not set,
   `__ieee802154_rx_handle_packet()` calls `skb_trim(skb, skb->len - 2)`
   without verifying `skb->len >= 2`. Ensure tailroom with
   `pskb_expand_head(skb, 0, 2, GFP_ATOMIC)` and drop frames shorter
   than 2 bytes.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/mac802154/rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 19b5382e85a8..dbdaf5962ca7 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -287,7 +287,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
@@ -304,7 +304,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock(&sdata->local->rx_lock);
@@ -487,10 +487,15 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	 * solution because the monitor needs a crc here.
 	 */
 	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
+		if (pskb_expand_head(skb, 0, 2, GFP_ATOMIC))
+			goto free_skb;
 		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
+	if (skb->len < 2)
+		goto free_skb;
+
 	rcu_read_lock();
 
 	ieee802154_monitors_rx(local, skb);
-- 
2.55.0.1082.g2b9226bbc0-goog

