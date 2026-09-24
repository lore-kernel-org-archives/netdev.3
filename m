Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0ED2DC32E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210578; cv=none; b=GnS9Tqm6PiSV6r0Whz2OZgLEQ2iRYZt7bA2Cu8Tyy97V0ft6yAR4ZGJNPG5EriNCNQdzqNtmebKoMOJFG1zOSHa7KM8IFXybjghg3AKHkJGYAj2ue7arrTuM/CcFkmvw6jSG31MFQoSROtTRm7pl6IaTmZEDL/erz+nKkFandB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210578; c=relaxed/simple;
	bh=hxqGovgMsPF90CJM4cVbKGbw4jHHI2tasm5K6tbH9uA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhROwMxHWK+MJjxaBoOwJWeqFnRCW6rzQl9/+A7S8XRKcrdWst/DIM1NY6bm/Wi8kbeqC7aW6tWyHUzrraFQKVc5hipE+jTEY6egU28sUCufNfHe7B1jJnc7cA5yLZGWfKTiHly6EhxaJURi1qvVt8LfN+JiRtoFK1GHL6JNHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZeujSOQ; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZeujSOQ"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e87478402so32210566d6.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790210576; x=1790815376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbISbW/zBtA8XTD+0xioAGh9npA0nU5vQoaiw6RwAWk=;
        b=SZeujSOQEMpNZpFxuawW+q3wigUHuCwztlFXz39BumSLoqoYhA05SVFu5u14v2MTgv
         38YkkhPjeWbkqWhe6wg2a9oAQJVJbJpQfMRf7yKE8xsnmKBOlNrSVjzOxRVQs+qHO8oX
         SiOn9lDnVpc04NyExg2OskqGLt1ppVuCJJrvOtbiPemzGNEpfp8yQUW56G754uBYYOaV
         6uuxEib1g0JcpEBopNRkZWZ+lkxX1ftzaXxTX+CBXSr3LM/4nalQnjvkqzr5+w26ir7F
         XTLQwqhi5/6rG2mhF076GLKrn9TpVP8oF7AYTtoxfNiA+noTKs/3MMoSnS8k99bNPNHl
         nv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210576; x=1790815376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbISbW/zBtA8XTD+0xioAGh9npA0nU5vQoaiw6RwAWk=;
        b=kD7qKkBWfWFqieYUlDiylmymV+qnQX+l68eOB7qdEjfpxKogpdIYVJGr0JppgrNarm
         pvU9xpvto3mKY4wwBdYldnKdhPe4z4NauDDgqO0vR8jDOt1vT+5IrnVL8fTsN4xaHYPG
         7td4iyD3/ZfhMkqA8nCVCdCUiMFPuJb/Wrrd83ZSOPWN/FSnPBcJ8qUFPvyyvwOL0DjJ
         4aqFccf5h1Be1z/d3jRK4jLXY7HH0XFIBO3Tb74syLx6mjWW1rIqBseEUjcmjdICrLUc
         /6aAAUGKV96aoeD7CWTeP6n3gp0iAXhR6b31jAsulw526+er+8r35NnbotwVZvYjBhHJ
         KxHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXwLN3OIkABEPnS1EGj202/U8rOegn5mxQAb6qxEpiAkXltdkrwTNasKtl/fr7arg5apryDlE=@vger.kernel.org
X-Gm-Message-State: AFuF++nNs3GtNbABg5ZcWBp04HV9Djb/Y71TvAnLsAPhyzlzjcLGs15J
	656VQjD3Cco1kpgKSeobT1SJvVNGURl0TyPvgGlK+TWBjOF8t5U24nwvMCrpNHzX/4hDRAtFBfQ
	x8BgNkNXo17SFbw==
X-Received: from qvqu15.prod.google.com ([2002:a0c:ed2f:0:b0:914:63b:5103])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5a0b:b0:8c9:c38a:20e1 with SMTP id 6a1803df08f44-91421cb65dcmr1518376d6.10.1790210575647;
 Wed, 23 Sep 2026 17:42:55 -0700 (PDT)
Date: Thu, 24 Sep 2026 00:42:51 +0000
In-Reply-To: <20260924004252.1196328-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924004252.1196328-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924004252.1196328-2-edumazet@google.com>
Subject: [PATCH net 1/2] gve: fix TX drop when GSO MSS is too small for hw
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eddie Phillips <eddiephillips@google.com>, Ankit Garg <nktgrg@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, 
	Willem de Bruijn <willemb@google.com>, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Eddie Phillips <eddiephillips@google.com>

The device has a strict requirement that the minimum MSS
(gso_size) for TSO/GSO packets must be at least 88 bytes. If a packet
below this threshold is pushed to the hardware, it can cause
hardware to silently drop the packet, leading to increased latency
and retransmissions.

Currently, this is validated too late in the transmit pipeline
(gve_prep_tso), leading to silent drops.

Fix this by moving the validation into the .ndo_features_check
callback (gve_features_check_dqo). If we detect a GSO packet with
a gso_size smaller than GVE_TX_MIN_TSO_MSS_DQO, we clear the GSO
feature flags for this packet.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Eddie Phillips <eddiephillips@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 80ab0a449ff54e3d19e9c69226949465d48dfe3f..19829b8e13de28df81bdec0c86e8356b25fe9537 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -577,17 +577,6 @@ static int gve_prep_tso(struct sk_buff *skb)
 	int header_len;
 	int err;
 
-	/* Note: HW requires MSS (gso_size) to be <= 9728 and the total length
-	 * of the TSO to be <= 262143.
-	 *
-	 * However, we don't validate these because:
-	 * - Hypervisor enforces a limit of 9K MTU
-	 * - Kernel will not produce a TSO larger than 64k
-	 */
-
-	if (unlikely(shinfo->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
-		return -1;
-
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
@@ -925,6 +914,9 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	int cur_seg_size;
 	int i;
 
+	if (unlikely(gso_size < GVE_TX_MIN_TSO_MSS_DQO))
+		return false;
+
 	cur_seg_size = skb_headlen(skb) - header_len;
 	prev_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
-- 
2.56.0.rc1.310.g51773c2048-goog

