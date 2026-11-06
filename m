Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989212;
	b=ssQnemFKqGX3/35L8WOMCRa7JRJuY8Okj3HlFFJvL/53S6kwf+V8w8js6C1U4aJNKuS0
	 eayEYMIFJ6IlAXPj/1w5mGaAdtdMX8kLE+Ad3Qc1zb4NXTH2AmdU3HsjpWDSRnq1ICQ5C
	 ZhB12x1XhCCRgZboWhvf0qC2HZmfZ6dARnGRoaAWnJ0Ku0vQ9GhPGlNFIp9dTYmpD7tK4
	 uLdj+U+DVO213OYSJ4SD0unxG1cU097fjq4e5Qashcf554ofd0PPVUPNkbERFOD7K1Ooq
	 uKV79yTYY/Ddj+Qq+oN0egZy3Pm0gRTxJT3ZqaV5ERyoEXccSoW2sauA1SJRpdDvhWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vVMMjsoejtuZj+6jaOVjoI+Z/1D0Mv2jKvwK7taNrxA=;
	b=LAKUttT7owHUsZpzh/GYLiGke7qD0MMxXtcmAbJkmiiSEhTvtwBEDQDVzCNXDyrmaJhG
	 qJ+pNOhicSb6j0r7UfLeuoFHoPFESwoUaxl2LpWs5ZEsEvf1SkZzuugGJmq14jNRJzjuC
	 4/suObqpKXJx+vqTKX6AYn41MwqSXNqJ1kh8qPWnD4TmUuve1FgHmkYeF0P4VQudoV3NZ
	 +tJnYuvVihcyaQ/Wi4fqvmOn0C57Z9sKR9CTKUxJx4ytupp0pUHx4B9VFqOlzJNhuaWaE
	 a4aZlke4ATuyW+kcNFbi7HyPEuMUCsZj46Jpq+9NOEOAzst+tj4mkIjMCfbYKeEOhXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M77jK3Gd;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE30606A334
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE30606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M77jK3Gd
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso892420a91.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989212; x=1794594012; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVMMjsoejtuZj+6jaOVjoI+Z/1D0Mv2jKvwK7taNrxA=;
        b=M77jK3GdF10MK0SFm6xKbtL4I00S0TgdZ1/xKISKVEwsLGZwbFJ5bkE2ZalS2qQ+HZ
         e/gRLQ+TmqQtBTZ0nZkGwRkfBPJcDoulaP6hf1G0DgprojSww+q87VTESrOXgN9oMJqz
         9S2bO4fxfoXa5ZYXnfnby+Runhw1YLjcmb/ssfDdRHSuVztt/GupfikH681rI4O5JMVf
         uCLqpC2RUcmtYHzdtuI1Kc+UaOBbJJOTOH5XQr+Y1Ccr4AlB6oV0YlEVxDRACnCycsz2
         wLThmIvFat6LnreBgVQ07hlVMVodSdAKEMskqAPxFztARFTEVSTaueF+TfUN6Q0epKnu
         tx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989212; x=1794594012;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVMMjsoejtuZj+6jaOVjoI+Z/1D0Mv2jKvwK7taNrxA=;
        b=smyJAWTpDTftldQPZ74YcRZlZyGUNnhFLXDB2Givj4CM/MRTOZyG9dDVL96rgSMNRe
         TuN+lR9IWqK0k4oWW37A5VleKv9HOdvgneUKDDu/cALoI6AOFWLgBsq/VOSPz/2J09mH
         UL2TmKb3XHwph8ScVzjrfrCKnc3iIxRE0pd9fUEEG7f/aW/kMitv/k/oVSHhEZE3iiUl
         d6dBIPiWYfdWlZ21yvy0BOc7otDbJ7okGGDmd+uucfTYFk60zPxD+L/fATSaMIhq7LWd
         Bk7h2YtFujGf53m727DGQLRQ/zgbdvwKctoL2ORY/9qi5KMiL9xWa4REN0GkxXB0m8E1
         ImTQ==
X-Forwarded-Encrypted: i=1; AL+hErH9SoxX5XPoAeAIzsroSZXhhXl1JvWDWyV0zQfTdlT1n+Wm1hJmWHhNGqnAO/nARweh7TApUDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p2bXMMRMyXmvWc/KSRjx6foQvf4RmvEZhXB3/BwvF3jAv+E9p
	QLqtO5mfN7fb8zU3SfLv+5rHYEGHGdEOzPsQ8uQofEWEF+KXsY4hUpy8mhI2tJgzKh2gMEhWOtK
	BPnGFAQ==
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:3ae:825a:57e3])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec8:b0:3ac:ad90:7090
 with SMTP id 98e67ed59e1d1-3b0db72df0fmr3414472a91.67.1793989211751; Fri, 06
 Nov 2026 10:20:11 -0800 (PST)
Date: Fri,  6 Nov 2026 18:20:06 +0000
In-Reply-To: <20261106182007.374660-1-weiwan@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106182007.374660-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106182007.374660-2-weiwan@google.com>
Subject: [PATCH net v3 1/2] net: Make PSP skb extension survive packet scrubbing
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
reset the extension block, and re-add a fresh SKB_EXT_PSP extension.

Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com
Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com/
Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Wei Wang <weiwan@google.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/core/skbuff.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 93c2f440b9ec..ddbf0f3342ca 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6369,6 +6369,31 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 }
 EXPORT_SYMBOL(skb_try_coalesce);
 
+static void skb_ext_scrub(struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
+
+	if (pse) {
+		struct skb_ext *ext = skb->extensions;
+		struct psp_skb_ext tmp;
+
+		/* Nothing else to scrub if PSP is the only extension in ext. */
+		if (ext->chunks == SKB_EXT_CHUNKSIZEOF(*ext) +
+				   skb_ext_type_len[SKB_EXT_PSP])
+			return;
+
+		tmp = *pse;
+		skb_ext_reset(skb);
+		pse = skb_ext_add(skb, SKB_EXT_PSP);
+		if (pse)
+			memcpy(pse, &tmp, sizeof(*pse));
+		return;
+	}
+#endif
+	skb_ext_reset(skb);
+}
+
 /**
  * skb_scrub_packet - scrub an skb
  *
@@ -6380,7 +6405,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that PSP skb extension is
+ * preserved across packet scrubbing by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6388,7 +6414,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
-- 
2.56.0.455.g6c5a503b38-goog

