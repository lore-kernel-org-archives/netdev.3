Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B53A9D88
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696858; cv=none; b=Mu2pgTaWTRyB1cuZfwv6ol8EClFaRU+xo0nSXV6clBkKOsJhT9vlphcqySjrfGLEWV2xosUSjqScm1xL7Qppugv0N4/EpvqDtI/HhGPZvorL4MGJkiNIuvh/kreLYQ7R5GKHtoBOxLY0hZlxrSDQ8DAD9h1bGbjzdR4PGqyZ1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696858; c=relaxed/simple;
	bh=wpjN+RGXgqlQnmx04rMsajg2yRYQms5G25hV8udFr7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTu0Lpf94G3lMYQPYo+6YO3/NA7j2rFiuD+lfzL+1fZDSHIl87NnIykMGCyjIkrgwKUKijICv4PvuXp9zgSqyyZtQU+fYEM340xmrHj3grP/tLOhBBHfQosBMeqx9k2yY45tWYgPckqDAkvNa4vzu7m3OwxInhzTSfHSV9feGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dNT6sHuw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dNT6sHuw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778696855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlNyc17gw2Ti7/hBMrFLpptKaPycSsdcm8axofbmVWA=;
	b=dNT6sHuwynPBxzSrUDMXd9nf1R6f3dHqiukQkvhnwBmTR26Lp7MA4PZCkyqxJygfO2jT3b
	Huoz+znlreNDaVU3kboUOkYELcEnhOwudvN8Bc8737yuFkcE9SqN7layT2UuDPq+GVh54r
	zWaZ58dIpv3zcqFfFr7VROBjmmeyv1Y=
From: luka.gejak@linux.dev
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fmaurer@redhat.com,
	luka.gejak@linux.dev
Subject: [PATCH net-next v6 1/2] net: hsr: require valid EOT supervision TLV
Date: Wed, 13 May 2026 20:26:56 +0200
Message-ID: <20260513182657.20346-2-luka.gejak@linux.dev>
In-Reply-To: <20260513182657.20346-1-luka.gejak@linux.dev>
References: <20260513182657.20346-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Supervision frames are only valid if terminated with a zero-length EOT
TLV. The current check fails to reject non-EOT entries as the terminal
TLV, potentially allowing malformed supervision traffic.

Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
with a length of zero, and properly linearizing the TLV header before
access.

Assisted-by: Gemini:Gemini-3.1-flash
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cb..0774981a65c1 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -84,7 +84,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 	/* Get next tlv */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
@@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 		/* make sure another tlv follows */
 		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
 		/* get next tlv */
@@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	}
 
 	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
 	    hsr_sup_tlv->HSR_TLV_length != 0)
 		return false;
 
-- 
2.53.0

