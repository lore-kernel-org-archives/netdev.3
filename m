Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3C4F93D9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417895; cv=none; b=P+AaXzJjCawJE/FXXGaW+tzWHuXmuLtZh0oghpP0+1zuU5tS5vRPBpekAC1GnuTYuzjsCOyAtue+iiIhsSzi/QS+NBJvQd7xQsXTcVc+gS9bIFCdaQnXJ10V29yd5rKEhNtElVU/U9a9eY2rQzFnY7jhTEVp+P2akKx2N/+g9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417895; c=relaxed/simple;
	bh=6Z8CiNviIyVdg98sCBaRoAUJsHn+RV3Sx5RlE56aqBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pi+ou9i7skFLZGrxgtukuFg/Ae7NAM1iys1Fi0myllHh7NULWtjtIoMuC4oWMwiSm8l8wQWZzwTJDlX6sEToizpGCzuZ8OllUB5RfcmxY9KQIBbIsm817a9bnRt5xcdp2b6mUVHkaiAdtMZwy4SIgRrxk6z5NEnYdq6Vj3qjJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=bQ/T3EWv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="bQ/T3EWv"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f079a63b8so201014485a.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417893; x=1793022693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nH4MPLjNHd0ezQ30G0wFNIQg5eWAqIll/99R00Ry+f8=;
        b=bQ/T3EWvXpvQBfbySB+faBw9gkHTec01pATJOxR9/n64bQq4YgrX713hq2DQBXGtJP
         LZCqRm0J1dPctv6yJVE+iUfYkIPx2Ii7//gTF6PGdgQxGrErcoz2H2I8F7wG1hsg8FlL
         Ykzh6iA+WxT0McvcBp2WP1ll+JMrb3QSbWX8+t2xfp/hnYKkewu4NalJsUuXItcWUbdU
         MvgWUDTxlAVWJmocuXXNbIYkIALUEQKRAHbB8w7rRe2DGm8y6WAUG30IM6L0M4Q0gsC5
         tSSJoyrRhusoTWRTfnAhwbzulzYNCK2gdC3Po7SQs2OjAialJoQPS7zm2frYotEhmZNi
         NUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417893; x=1793022693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nH4MPLjNHd0ezQ30G0wFNIQg5eWAqIll/99R00Ry+f8=;
        b=RllLzyCR3aUbN+trsI0YWc7/yyXbXtJKp4qXjb1mx8lnLsDIJ/o3LxJ1chPcV86cbg
         9KTW4A08HmmvDP2v25jIi7mxzDdQobcotMB8qJcDw5Ic/1oBWkjUiTD9GyTvf10I1KIb
         jvUAZpc1lVJ54fzQYmRjZVsdvei/IELSTrAEZH2Ktz1UhHzeZ8kamcvTHD621q0EjgvI
         02vzixGBEY+P7IKBXczTMQk15R5kUOtKfqFIp7tcNPKrmzPmVuTlYy4pv5En6z18f//r
         UR61aAR+IVD58ABz1Y+mZIey4e5KbbHt0O319E8Uc24tZNs8cLM5AidFtCqSIYhx9ZcX
         buNA==
X-Forwarded-Encrypted: i=1; AKwUvBxhHhiVPitpyAXoAqcArxLSAq0eF/hTlBzVV75i7dFo7X4DtYZ9MXL2jfjwvsRsU/nW+xj/g1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRim76R+Hv0/M/Qu489ySMI2vOO56vSYK1MzkGpEMWHXCzcuzq
	ZypUAsNoXVY83PkwUEppIOJWSxyPjMGnPX88fryaW9cas2fM0u0p0VlKUiSsUfsi1Vs/qI082z0
	rSqs2
X-Gm-Gg: AYBFou2GWdkAMOl4mx97doztae856XjYKeiBNo4NaWXRkron9+DoRsSRJNZxBtYlWPH
	G997n+1x7LyYmVoY2l9uYIyfYZBbyZb7suc7ZFEuaKMlF11Hwz6sfEs3VHOhy/5ddoVGC4/o0q2
	GmK6xU6ZTfNAA7oet+TkF5PYq7sYjiTbN36oysQ6j99r31ls4iketGsS4Hsh591i6TQmS6vh6BL
	pnWQrDtQGY8fGCVm0lB+MR/KeJGW8G93mWRbfB2BmRQElKC7tPtCHw6PUdnVgwpmFSvBsOkPh/n
	JCOg8O9Rk7ilFI0imG0lSi9Xk9isy5S5lTVztPG/PuAUuTzdJEmF5r9jjwl1/ZXuuhdlKR4bNp8
	d3cigm/2MOvrAQcxtasOSwZcKWWiUmTEmQCqiKQxepmI84KNJjhZXzVj+r2vfwE0pR/g0sjIcDl
	Oo23ExA+H4hKIIFXz9wLf0V8nVxQE8vpJmxISB7+DoFC3i0M32Lm2wIPnZ1LupA2VmTtYT9fIou
	euFZ6Drdyhculg=
X-Received: by 2002:a05:620a:4109:b0:93f:35fc:5266 with SMTP id af79cd13be357-93f35fc586emr874742485a.44.1792417893366;
        Mon, 19 Oct 2026 06:51:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a19ce5asm982035485a.32.2026.10.19.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:45 +0000
Subject: [PATCH net-next 11/15] net: skbuff: refuse to segment a nested
 frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-11-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=2113;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=6Z8CiNviIyVdg98sCBaRoAUJsHn+RV3Sx5RlE56aqBo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPevlwc09v/MSkDiCKh5chGO+Z/rqVC5uo+IAjB+VXJ5WH8Ns5cSB+345mYyBpXOXcO+Ul5ANjw
 NRhLiDZ+GoA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_segment() walks head_skb's frag_list, but for each member it only
looks at the linear part and frags[], never at the member's own
frag_list.  head_skb->len still counts those bytes, so with a nested
frag_list the walk runs out of members while it still owes data, sets
list_skb to NULL, and dereferences it on the next pass, before any of
the layout checks get a chance to catch it.

Nothing in the tree is known to build such an skb; GRO flushes instead
of chaining an skb that already has a frag_list.  Check for it up front
and fail the segmentation with -EINVAL, with a DEBUG_NET_WARN_ON_ONCE()
for debug kernels, like the other frag_list layout checks.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 56cec58bccb7..b6ada54ecc57 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4962,6 +4962,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_segment_list);
 
+/* skb_segment() only walks one level of frag_list. */
+static bool skb_segment_nested_frag_list(const struct sk_buff *head_skb)
+{
+	const struct sk_buff *iter;
+
+	skb_walk_frags(head_skb, iter)
+		if (skb_has_frag_list(iter))
+			return true;
+	return false;
+}
+
 /**
  *	skb_segment - Perform protocol segmentation on skb.
  *	@head_skb: buffer to segment
@@ -5023,6 +5034,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
+	/* The walk below never looks inside a member's own frag_list, but
+	 * head_skb->len counts those bytes, so it would run out of members
+	 * and dereference a NULL list_skb.
+	 */
+	if (unlikely(list_skb && skb_segment_nested_frag_list(head_skb))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (sg && csum && !gso_by_frags)  {
 		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;

-- 
2.55.0

