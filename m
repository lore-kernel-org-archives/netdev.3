Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF734DBD70
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951769; cv=none; b=didVjQJ73ZXxuHIJqjW0mHZ73zwp3f4+qzTXicTD0OI3xnG69llmru37lRlmo2uLhaJCBX1zxOdGCtRW7sP6CHfuiWNFOZGrhe9lrXhu2Dgy+psCM7S9mNSbvdCCwVrwPWIf/gfGL50y05iIhFr1nUvn2+NaSrGFSotEvVdNwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951769; c=relaxed/simple;
	bh=eQRCEWeuQenLohMAayQ/7Eqy93mhz2DxGt9MaVpnEkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv02dsrxrf1w63yJK2ynho/dSoN7uQ7a/aCV9KBVPGfCL2nlJjTW0x3GHXbhWj7nIzv4JtKTZPUNeXxsjmmenFlJzmpA0AskLCtB2EamlJKmrOQkC+M5qgSoE3vaMhOxPzYcFaSUKC6m6ol7xQIsskRe3UtB+ZwsResS3V3N24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=Vp3GObUu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="Vp3GObUu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so42917565e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1790951766; x=1791556566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBwjMAy6b17UOR1h36UJ07paZoIuGQbP8cI4le6OJ04=;
        b=Vp3GObUuUkcQiFIYDMR6c1eDDnAuMAPf2LysZ/6xKgG3GLj0+gLXKD/R6dsWIZWt+k
         KO+iraLCYIXyEoo/x/I3UMuw7r3DooFLNfJ+JKIwzOshYlRSRsmxucURDz8lK6fzBH6Z
         5W5WMSyedWZu2raUquEdDI+G4a7nf0K9geLxqzkyBvLZw8gdNEOndOT53ZHTTzqFr7GH
         xarBO0/iUWXBFM3KS8/TSpv1RuWNPjLwEHaWx2v+7y+wSG0Q627eYj6OE0jBy+orVwpH
         YE64rV5jdAuM8Lwq4KeKVFwiqXlPUwvaiwjOAqarCCsPqCnvT6v9VhcrFILDyLZuLVbU
         DHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951766; x=1791556566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBwjMAy6b17UOR1h36UJ07paZoIuGQbP8cI4le6OJ04=;
        b=TWEfI01TPlRYN9S5gMPuShoVnajg5Sd0KdwnecluZQVAb24n9yZoFSKWkfLK5TFXKw
         iSos+grNNVjj+XwQyB6Qea60376A9p46KFUvd6Ed8JMkrH5qjKDGUalHWucuYlNLZ/FA
         9zJCFt/A8qendKMZLaQvN9hpjc9PatoF6Mzpkd4AKS1BWm0QNer5OvWide58GVWY8iWc
         Qx3VyLwCBUZZ2T/PSth3vkxwE10NwNUTZlAHHH/reEsXwnKHbORvzUVdt6V+D0hwvgnl
         y164z1frRxlXNv84X33oks1V4LjmXGhLMMAA3trUToBCx+uqucBnp6ydhpLaZ6dGX8So
         IpQQ==
X-Gm-Message-State: AFuF++nKR2FdjV5ec8vz3pUtePB9DOVuJ+SiHdcD+NqCNhydG4JJPg/J
	7sMujTN1+6g6sZYpwKUKQAeuWfbQ9pTOgyDAQLl0xmiBycMVo5NZDJArsui091+6UrdQzDzHwoU
	HIXg+50uGsQ==
X-Gm-Gg: AYBFou33xfYRcquYU3rJSLQiWo+0k39+jE5KO+LHRIHgvKC4oHqCPmPZBiV3ARtdISX
	Q9XKN+x9N0rr7mzikLnv7VgwwB1wcLh3M1sHorSuO88Ej1Ys51I5U5v/AQ+WJZbtOtIRXDTqj2+
	PlOL4AUB+oV32VZ5GKOITGf5OtLeroq/65z2MOq5Ah8ivFNvmJ0UXYgdo3CvJdT7N81qKfYKjHr
	rGNzpPkBUT7Hb9h7NPoMU4QkE3A2yYwrZuKonMZWP43C8SWZiEy/RDEclKPazbEs1H0pRtJUfaG
	FUdhhiJaUfttrZ1x8FKYDtpzI3YENnwL+UDn/XO9A7xLDnzyKY6INVLVB6hGXw8aYR+bNhGyI0q
	GHx/2tRNuvVOoDXCP+0nwtrYZGqn1MJ3S92B0qruNPC1u5u80wHbh4z/4piPdzb3JPNMHdy+PWV
	MCteCI8rGyFzCOT+U41/ypqa26WVtt6uJqHFNhGOT9CBGRH+8Cdi9TrONomCe6Il1B/gzLg/whu
	Hv3wQ==
X-Received: by 2002:a05:600c:4f88:b0:49f:fed0:fc47 with SMTP id 5b1f17b1804b1-4a027523050mr51473955e9.1.1790951766149;
        Fri, 02 Oct 2026 07:36:06 -0700 (PDT)
Received: from koen-nuc11.. ([2a09:bac0:1000:2ef::4e:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67cbfesm8715315ad.28.2026.10.02.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:36:05 -0700 (PDT)
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
To: netdev@vger.kernel.org
Cc: quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dnlplm@gmail.com,
	linux-kernel@vger.kernel.org,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: [PATCH net-next 3/4] net: rmnet: conditionally expand skb headroom in ingress handler
Date: Fri,  2 Oct 2026 16:35:28 +0200
Message-ID: <20261002143529.3217189-4-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when the rmnet driver processes ingress packets for an Ethernet
device (ARPHRD_ETHER), it unconditionally calls pskb_expand_head() to
ensure there is enough room to push the MAC header. This forces a costly
memory reallocation and payload copy for every single packet on the RX
hotpath, severely degrading throughput and increasing CPU overhead.

In many modern architectures, the underlying physical driver (e.g., USB)
can be configured to pre-allocate this extra ETH_HLEN headroom when
minting the initial SKB.

Optimize the ingress path by checking if skb_headroom(skb) < ETH_HLEN
before triggering the expansion. If the packet arrives with sufficient
headroom, the driver now skips the reallocation entirely and safely pushes
the header. The expensive pskb_expand_head() operation is now strictly a
fallback, allowing properly configured hardware to achieve zero-copy MAC
header insertion.

Testing this using a temporary print in the new condition showed that
the expansion is not triggered as enough space is already available.

Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index aa5523f4618e..95c3e3934fd3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -114,9 +114,11 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 	u32 data_format;
 
 	if (skb->dev->type == ARPHRD_ETHER) {
-		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
-			kfree_skb(skb);
-			return;
+		if (skb_headroom(skb) < ETH_HLEN) {
+			if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
+				kfree_skb(skb);
+				return;
+			}
 		}
 
 		skb_push(skb, ETH_HLEN);
-- 
2.43.0

