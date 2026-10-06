Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926504A3D28
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306649; cv=none; b=We9/v1+U0GNDYNhlp/keLsFXWohDFfbNS7OgYqWamMGR/2kE0l1pY9BSsF6s9o3V6FNFBFFY5DDZY7+t8jDru490MKmMwqEoAJ3nYPM5Q2SM78RG7gl9LrlSszuKRJRedDkHO54tsWAuh306qqYE8mMauuHvd/PrWOkht5Plt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306649; c=relaxed/simple;
	bh=lJrAgLEquvUX1E4IKZjAcGvvkK1qqPcK3iaWEt+L6gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsSqG9xbWQ+9FmqHls8hquac/UEmD8nwH7JurRNHRZ04xr2qjGCHOdS+b0OiOOZ1VdujMOOo56uzDuo4K7Ip0RbLKXvWZPh9Er658n54H1kgd1zCUrLZYbFhjjwPMethmaJ3Jv3wxNMOTe1eIZgb0AOvT5cciO9C0he+JvMzHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ac+zni6z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ac+zni6z"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53440816851so34692351cf.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306645; x=1791911445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEopBC3xbTUKixAlJNKMf+PRWcHDGBdCeI5RXcAMmts=;
        b=Ac+zni6zBUldJuAa63L02dkyFeVgeiPovruR2uI1QtDEYgn4k856gIsQSKq8ncYDlD
         Z00UtTz+CmjAnG4j4r5gqsAvX8lU6YU7eigMVF05srJypxcPDR295xvbDeJGmxKlJppV
         ZbJtxwJQ/HLXTl0ZpVIg1rJtOmTBSjg+9tv6m4exZ4cyBiYdXLEVNc2szsb0erQtxeUC
         BREibI0y9stUNp7c4/r9lwzX5yxn+0WV785j1WCyFQHQMKoUxuhuKFRQUSYHUNJfpz+X
         63mrQhxxcMZJlDU3yL6kf2Gz8FUbPxhcJ/1z6fyYzPhdFqW0vL8AMXJRfnfyFotpEyB4
         o5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306645; x=1791911445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEopBC3xbTUKixAlJNKMf+PRWcHDGBdCeI5RXcAMmts=;
        b=dqCjN/6Ns0WZKavVVO17yiMDR/7mgxGs3BxZgGwbgVVJO6/J6S2DBegeXQ3UCicZOv
         3y7DQ0eu7EDkNG72TQ8lRkvsTIVDxZ81gg0lwrc14hfhzWTehrNdPof1pcjOaCrprJS2
         wm7cFlS3IU4C0hdCexHwRZrQrOG7efeQgjHoEgRwkUEwFtDcgFPOvNzzwmjQJlZz3AXb
         47ew/nKtfI2FS/tpMs4KHLU2iIRpIZ76Nkb4US/OouHPCeOhQ22TzclhoNYsuxF60r8Z
         Y4mC1L77XKEyTXPZsUSK4gqShYEyDymWLyMR/0D2mOTy/MgPwrsTg1hIp3Mv+o9p7Ir6
         AiPg==
X-Gm-Message-State: AFuF++l1Woy9pyKpd0xzeo4bPkv1bagUwBWHnzAFTArEWMsTJq2zHE31
	s8Qmkq2AD1bo91UIRGiN8Edp016FrdGxxEa6WnMJPGU8BKGmooGQrDsPEvmDD3oAV2o=
X-Gm-Gg: AYBFou2Ozq36jtaC8MX2QxugPWIgBkuz7BUHKqKnr077XiwAApE0QKYiBQiVU7Sv7vA
	ddhQEOGKD5ouaYiAfCgCRjDjxCkYwcFaX8F2azSrjstwSNs7BABy8d0mZ2ZGW9WMR+kB07uhE6r
	SAI25deykr2WlFX9wUfXEsRmwS4xYHkEQgxWdet3QMWPuu0O5o/NU15oUsoc+IMWzZBIejkqp15
	k7GbI0iZS/rTl7ygvXFw0AEOwX8CacZxpMFHdEj+bWNTLEbX97qMhGzMPshzwD/n+ZBpMF01Bl5
	KJK/dKqeu8UH4pkbUMi2MInxFpfWxXvVfQgP9v8TN9rY8ozPDSIP9WgzG3ZIjKMmw9QdAgiEwZi
	bNXs2TKCD0QNPVzkyrewZJNBlRVdilFpaEMyHAFT2knrGfwuTpmcZ6d1T13vVv2mLuriAngNir2
	TMHQZfpISCgoUb/Hy+DkP/tIlsb9GB474HNjHhr+tZhvjQ9LIZ1ZFJQZzW2y7Db5rF2/2BdNK+K
	V5ouceZxjHTcog=
X-Received: by 2002:a05:622a:260b:b0:535:1a6:6e97 with SMTP id d75a77b69052e-53511e4f2b1mr179084311cf.29.1791306645443;
        Tue, 06 Oct 2026 10:10:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b682dfsm118638636d6.19.2026.10.06.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:19 +0000
Subject: [PATCH net-next 4/9] net: skbuff: don't BUG() when skb_copy_bits()
 fails in copy helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-4-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=2507;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lJrAgLEquvUX1E4IKZjAcGvvkK1qqPcK3iaWEt+L6gc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIrGd86UTYv0RDVXyeMVh/bQeikE0Xjv0WEtGohvRz8l5EXeQu4E8VR8/976okyGMMjweBIN7wr
 9+jwQsxUplgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy(), skb_copy_expand() and skb_try_coalesce() all BUG() if
skb_copy_bits() fails.  skb_copy_bits() only fails when the skb's
lengths don't add up, which is a bug somewhere else, usually in a
driver building the skb.

Each of these functions already has a failure return its callers handle:

 - skb_copy() and skb_copy_expand() free the new skb and return NULL,
   as they do when the allocation fails.
 - skb_try_coalesce() returns false and the caller keeps the skbs
   separate.  Copy into the tailroom before skb_put() so that @to is
   untouched on failure.

Warn once and take those returns.

__pskb_pull_tail() has the same BUG_ON(), but several of its callers
can't otherwise fail and don't check its return, so it's left for a
separate change that fixes them first.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 405d27e9bc9d..6cd7135e0dce 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2201,7 +2201,11 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 	/* Set the tail pointer and length */
 	skb_put(n, skb->len);
 
-	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+	if (WARN_ON_ONCE(skb_copy_bits(skb, -headerlen, n->head,
+				       headerlen + skb->len))) {
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 	return n;
@@ -2541,8 +2545,12 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 		head_copy_off = newheadroom - head_copy_len;
 
 	/* Copy the linear header and data. */
-	BUG_ON(skb_copy_bits(skb, -head_copy_len, n->head + head_copy_off,
-			     skb->len + head_copy_len));
+	if (WARN_ON_ONCE(skb_copy_bits(skb, -head_copy_len,
+				       n->head + head_copy_off,
+				       skb->len + head_copy_len))) {
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 
@@ -6229,8 +6237,13 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return false;
 
 	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
-		if (len)
-			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));
+		if (len) {
+			if (WARN_ON_ONCE(skb_copy_bits(from, 0,
+						       skb_tail_pointer(to),
+						       len)))
+				return false;
+			skb_put(to, len);
+		}
 		*delta_truesize = 0;
 		return true;
 	}

-- 
2.55.0

