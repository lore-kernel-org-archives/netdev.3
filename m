Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825281;
	b=gBT11e8BDj6vwFuL6bOBBjoGWKxtkUlz6q5A3LHu9T/vCJTISDuxS1BfpSe0JXMm84uT
	 9Wemch0M3+TCLE/AOttuC6zJI6tvfjorF7S3Tipw2gdW6P1TgKNmw55Bd4ygimu/iPY3t
	 bnO/TMVrRPTyInpv5uv2tPnkPvzus48c0JS0zQDriaP3rL/rRd1g9ueZpyhXXB6dP+Oga
	 DaGSSPc/RUbwiXwc1ZNuMFexMM5PCD/RiXQZ40uEhlKf/TjHg3vBfC/cptjYqEng4dVbS
	 eaTntr9tNydC5Eo1Hr9YjV/j+sTyvWYpnvBQTfipbN8pmE2Al606DK2gMdKdfFzJNyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=buSYjS3GdLDfaKyeptPicEQ91X+3t3GOSNONVwKle3Y=;
	b=N8kxgtp7IEO0F9hEiYl2ka//7mQNBnPPiOLKFhw0u69Ttc2x5E7G8F2ggvhtDU2jka+G
	 gkIxsxJ/RjCPQLW+7L0t8JMa7n1+iGMbc7f+AljUgRCzwY1w1OdLnODBB0wVoYXZaksE7
	 cjJvmD/Uniy/SDg3k2+J4BJgjyd6zh7sEotVB91M/Zkbm6++tzM1pWFvQqQHwdD04lY4J
	 gkOIqlqXsr6vc9FkQOktNJULhpiPZ+qgdtdjHQY8a7EpvFgBtF7LbDiH1oPTZXmILzBRf
	 961VYBrHOJztBwju1X5cMs6XbANn9N6tW/zg517N/Ie/pTzgydtj62RtXMKZaam7Crw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n5JRV+li;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0A6097323
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E0A6097323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n5JRV+li
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f20b304c0so109597085a.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825280; x=1794430080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buSYjS3GdLDfaKyeptPicEQ91X+3t3GOSNONVwKle3Y=;
        b=n5JRV+lili6umKLAoMjLsyydR3GILW0jpmcjF4t+2wG3MeNkqWudVHHnDvvNw2IxIY
         4YoB2T3w1rO+Ul88DOh1quzTgya5Pgjb8Zmq6YEi+dZyBypWpvL6gUQuW/Y6hDbCZS+B
         rzQH1JO+f1YEV5ZE9gLDE9zGacbUis90IUUODmhv3NKo88GOv0hmhGvSzEqCeDGdWKTE
         eB0Xi1w7QK3T3HH9l0SDtZJzi3zAHV3KwRnudkzZKPuCqEA/9VM3rT0CO9k0kD9yBAby
         47+T5RvOUYoOdXpzc5wHZ9vIc5llJgaD5VQ47+eXu0LP8RFj5BDDvReP40IxGdGFEMYt
         r8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825280; x=1794430080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buSYjS3GdLDfaKyeptPicEQ91X+3t3GOSNONVwKle3Y=;
        b=F3QgN1IcQgyGR26SLc+SIuW8mduVHWLgLubhgbqtmzGyHOQPwSNDNPR1DZEUJUVe1L
         dYlfiaqUxjEViYFLXB7tiatGFhD4KnqTsWDRY2Wgz4jaWVCk4xJl7vLpa2m+Yht9cXcy
         8OrWSeBoz0GfYH7xdfoaw3jviWs0+mEmsKOLKuD+ihkTuFLOWcOIZq48uk4IImrUGP3g
         4RJhz8wl+jr5ZjBXqsZCMubOtmwSVR9sqc1jPBpSN32byKcqL3juvl6VFcC/n/1oz2Wa
         jSB5mhl+/nVNs5qy9bcIDKH+eKR+V5k1Yv573LADsjC8+Ko5B8tnXpniHP/HZ/1fq4el
         BBxw==
X-Forwarded-Encrypted: i=1; AKwUvBx/Qi3IQiUMQ+jwv5Fz8DGZraGVTztOZbp1ck/mxAwmqb7n9svqLq63/sUjlvkpeILY+z+SLvI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mrstZj94TKA0PMAsMq0x9X689mZayHAabmlqmAA0/+7yPSuDA
	nVyonwbNXE1Nfm12WSpccGx9Hj/Hg+HlNuRVJhUHvpVF/AWo0JDzq9glw2Uc3jyP8J4=
X-Gm-Gg: AYBFou2eQI7MJMlzYzBhkPZ9LIs3oxXRxE+bgpnqptnzwP2i63RGIakCKot2b3gtOl6
	gxYvB1/xKoFHdVxKHa+x5j2T/+n6fFBov+hiT26Al9hxqW/cKw5Po9D64Y44ycrMM+XqXpXitW+
	uMM94taE5JZRyVSaA6HcON2K9wLMwJ1lJmx5vDodTeESUBkjfz0xCtoCZhwCx2NQbaG7Jo42nIl
	l6eMy0k/8944r1Rzt5m3ykHCwU87l9tP3dfW72l2AltfscVIymWprUCCzJaCjzIg70HUZx1/UZ+
	ciYNdOX+qgQp3Nqwc2VJmtd4tMt9hz8PgFGhy3mAQecyKUjBy+TjdYD2XGpNDjEgJ0i2mdJ8MKk
	2ZhAcAr6ciG7yR6QRpRYzRltWcooLWJeV7QrI6MagTh14JDqXe3nxe3nHWm5/fojQfTstX79/jl
	c9AmwIXDJH4+4jJTUTSwBSiSsg60CzJRq/wFG4l3P9rnpJISA0n3rO53T0MpcCIBmYVH3X6FYnu
	cETFMVG1YsUNAULy5kKKbULqXBn5cnZCdL0tvLF9gGlTzStKNglb60jkfiwVxOwyy/07ZV9AdQk
	8wD46Q1KdaO/B2XvffHeLP/n3FLJmVEagE1NcGPCn+7LdQ==
X-Received: by 2002:a05:620a:3181:b0:944:907:8f64 with SMTP id af79cd13be357-9442174703bmr2898691085a.67.1793825280424;
        Wed, 04 Nov 2026 12:48:00 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e896f09e3sm18368646d6.25.2026.11.04.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:21 +0000
Subject: [PATCH net-next v4 09/15] net: skbuff: reject data_len > len in
 copy_and_csum_dev
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-9-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=1669;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3g9gWyq3LNSnz8GQIQ6Nd2kWG1X8iSKYPw0MOlaABeg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKwOCX5WX+o2z0CP94Bi0sfWoF2Js1lcQMZ0CTKZpHu/4B9z0ISKOPPwpZOGdR/7NPil22GR5Na
 aLXWG/bs0rA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_headlen() is len - data_len in unsigned arithmetic, so it underflows
to about 4GB for an skb whose data_len is bigger than its len.
skb_copy_and_csum_dev() compares the checksum start against
skb_headlen(), so its checks don't catch such an skb:

 - Without CHECKSUM_PARTIAL the checksum start is skb_headlen() itself.
   On 64-bit the 4GB value becomes the length of the linear copy.
 - With CHECKSUM_PARTIAL any checksum start below len passes, whatever
   the linear area really holds.

The BUG_ON() that commit 56453199d28f ("net: skbuff: don't BUG() on a
bad csum_start in skb_copy_and_csum_dev()") replaced compared against
the same value, so this isn't new.  No path is known to build such an
skb.

Check for data_len > len before anything uses skb_headlen(), and zero
the frame.

Link: https://lore.kernel.org/all/179273112823.3134.12241973533522574538@kernel.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2c246f563555..b017c9f861fe 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4165,6 +4165,15 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	__wsum csum;
 	long csstart;
 
+	/* skb_headlen() underflows if data_len is bigger than len, and then
+	 * the checks below don't bound the copy from the linear area.
+	 */
+	if (unlikely(skb->data_len > skb->len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		memset(to, 0, skb->len);
+		return;
+	}
+
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		csstart = skb_checksum_start_offset(skb);
 	else

-- 
2.55.0

