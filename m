Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334712;
	b=En9yk4UXFZn03bHGis/LgRiFYigSUjxz2GngyNQ6h6+R4ByrE6k9bpvPWuzQiSL89qoV
	 YwofOe939Z6u4eTwwu30ALj1LmLJsi+FH+00oX5zSEiZUJd+Z/W+z9cxh5NaeEXm4NVXq
	 jN02qEEaNgcH3l4Ru6pJclc6u0c4+RSBZavCurrF8N6iwSlzwhOj6JziZxQmsRFD2UL5l
	 ouelThPm1QA/7hsveLtgu/VnDJHYriWfBdmORGS5X4ukF7xiXbJ5fnQZU0+LshuHeFfYG
	 MwKRIt6gfRP/hDwRQ+ZQOzyI80fFo4wc1sYT1/w5cOsp0bEgzwItxXSuUX8CnwlzpfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
	b=eZtNzn481sk6HQWimIl4/iSARxGTW3ySboYTsvErnVDSRV3hzcIVEoFBd9I0xzc6ndjb
	 +4yTB81I2l25blO5jW8QocCjt6w7FL/0tCJyUQajDlIK4Ay/HTFWfELVT1d92iBcPoHsq
	 CcS06qhVrEae7wDnzb/a/cP2nMvwM03xOzj/rvZFqHIonKhdVjmTfwjDAKX4mSluCYuzV
	 35BaEHlY3rv70Ee5+LstSdYiNqKE/vosLGWgXZiD9aM8JxpD1CwjBjV0UCrm2Y/uFgyRK
	 oJjcsKieUah5lbXBH552LInGqxC2DUV4xtAB2sjUKh7MuiKb/nOgUJwJ4napfyA6GjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bn+lZmgA;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F915606A323
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F915606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bn+lZmgA
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdae10aebfdso235895a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334711; x=1793939511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
        b=bn+lZmgA+J+K0XjBuCBZNUoxB3sifXpY12KNQK8KWDfMsytY/wKL2pHp1dJSeGaE7D
         ZEQazoGfio2Txj+JSTcIdJp8Go/uOHd/z/DwJda2mi+om3+f7rBQoCQjudXJzEtzSRbU
         cWGw8il0bjvGIaTWl3bxtswJiBGYmiT2RsV5EssKW18Rx9648jrtMBg8BMZ4bLo3ZqwP
         sB6MXxj2q/+KqtpYAfNKggECAH7Wdd82b7Sl5NZls6i2eWJ1WMouWQnM+ptnw/hfiHit
         ObpC5AdyslPLqOAFvuWsvcN74r/8beARAhhFgy8UE1fkPiglm5jiYEv5RQgilBA4E9sx
         PfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334711; x=1793939511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZziXw8Mhu/MliXEzo41WRhscDvJYaH0eawGMV1Y+J3k=;
        b=b2SXUGSvCtASeYnayAH77yv+Gl8OxWPEO1wW4EEa9uR1wtM7WGK9/GQO1lJ4xVqZyg
         rkASyo3rCxxXGqhhq2038xAEGsamsVDwJjf4ZVY/XRzvTXB6dmeUkZa4YpeRKPirypBh
         EbAIix6NnzaD0V8brvBFUxWt6ecz/KmVYS3c1VHYWJ0sL3yKgmwRbCH9IlEyN3bHTzR2
         DEKvFQbxcmJC9nJTZDx3C0A6FbruxZFB89qqoQdpTW3cskfztq+cqhHTCz/NSpUfBp9a
         m1/7D8Uu9KI7Vl/s/XgnHyD4yng03qU0yu4zP0KOzhkN97vcbKnLnx6H0g8Lg8ermZqr
         /okA==
X-Forwarded-Encrypted: i=1; AKwUvBxre0aW0AIFXd09IVlm6Jn00WUWQk7HDX5Oak5OR60uDh2k/EG8RakeFKeTHQvBEQJELYMbMKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4ymrbIHzNURUzhp/A1gwdw/cLC8r0D+6kMaGOhQsuw7NnnO1g
	J0REkQaMIkoo1jMVK8OGGQG0jMc3eakyfpMto0VFQwQIK11NitTeYbacGeMUfypTnouKeyHSmCa
	uSqhGyA==
X-Received: from pfbgi11.prod.google.com ([2002:a05:6a00:63cb:b0:8a0:4085:d831])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a94:b0:3e1:8a37:bf1e
 with SMTP id adf61e73a8af0-3e928a78297mr835173637.42.1793334710498; Thu, 29
 Oct 2026 21:31:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:44 +0000
In-Reply-To: <20261030043145.2185700-1-weiwan@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-2-weiwan@google.com>
Subject: [PATCH net v2 1/2] net: Make PSP skb extension survive packet scrubbing
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
etc.) and virtual device forwarding/redirection (dev_forward_skb,
netkit_xmit, skb_do_redirect).

When a virtual device such as netkit is associated with a PSP device in
another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
__psp_sk_rx_policy_check() rejects incoming TCP data segments at the
socket layer with SKB_DROP_REASON_PSP_INPUT.

Introduce a static skb_ext_scrub() helper in net/core/skbuff.c to
preserve SKB_EXT_PSP across skb_scrub_packet() while dropping all other
extensions. If SKB_EXT_PSP is not active, skb_ext_scrub() simply calls
skb_ext_reset(). If SKB_EXT_PSP is the only extension in the skb_ext
buffer, nothing needs to be scrubbed. Otherwise, save the PSP metadata,
reset the extension block, and re-add a fresh SKB_EXT_PSP extension (or
clear skb->decrypted if the allocation fails).

Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com
Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com/
Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Wei Wang <weiwan@google.com>
---
 net/core/skbuff.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 93c2f440b9ec..5c4a2e982ebc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6369,6 +6369,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 }
 EXPORT_SYMBOL(skb_try_coalesce);
 
+static void skb_ext_scrub(struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
+
+	if (pse) {
+		struct skb_ext *ext = skb->extensions;
+		struct psp_skb_ext tmp = *pse;
+
+		/* Nothing else to scrub if PSP is the only extension in ext. */
+		if (ext->chunks == SKB_EXT_CHUNKSIZEOF(*ext) +
+				   skb_ext_type_len[SKB_EXT_PSP])
+			return;
+
+		skb_ext_reset(skb);
+		pse = skb_ext_add(skb, SKB_EXT_PSP);
+		if (pse)
+			memcpy(pse, &tmp, sizeof(*pse));
+		else
+			skb->decrypted = 0;
+		return;
+	}
+#endif
+	skb_ext_reset(skb);
+}
+
 /**
  * skb_scrub_packet - scrub an skb
  *
@@ -6380,7 +6406,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that PSP skb extension is
+ * preserved across packet scrubbing by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6388,7 +6415,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
-- 
2.56.0.317.g454f8302e1-goog

