Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590458;
	b=5HyUQaeUcPHF57G84qpl2aSgzAW2N1+IID4GzhbT/8iSIewlYZq9e3Xw1pMuyj0Q4HJy
	 f/U+66+gnb9CqI2VSOa5kAQwDJ3BCGFz1KKUPBysXqiVeaGwSyLO1ufcIHgs/iZMO3ShJ
	 uxDlhoUptIk/flnBA6uMjzauEmA77PKZIDTs4EXsK8vuazL6bZRu7VAxUlZiWzPC4XSl1
	 g7GJnByIrZYzRFOAVmX/KLt+8eNSDnyg+Jem4enxz6czzF0gfPpPnPxaaWuvr3qFuAJlT
	 /LjtFsUMUuadAK82uJ0rgEASFDyUwLSnepaL4KwVTQQL5QINWV61ElRyeU7itBvE6Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=B3Vx6nCjfDKI1O0Rv8fJf2F45AGRs7XGpGz0epefQ+g=;
	b=UCo0zTfkHB0NQw8yVBxWJsg2skpVYfaRLloooQsu0Om0oyBiAQlJtdUd3QuFxzZuGATY
	 NIQufZk681vLeYv1yLTCgiBdvxxohrlTknJcxd3c5vJ0DQsKkZg3P4DHHO/odPdSMI3gs
	 N7mRhU/uoxjQMzfb9DlJ1MTYy2n0bh0XMY5hl2f7F8dfOIaw8VRgy6flVJIMa3LzYCwv2
	 lBPOQnpyg0vpCaUh1QRjwCFjjkcoVYlKbLMnfBIvGcCaB4V9roxQ6r13/Hg5SNV/+tPXh
	 mji9Utr9Li0qtrVW6chaNeRkflPrjT63UBZ/LYY+JiJ+J3qm7UTSnSSyVCr0NEs918Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hJJ59iRH;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59D606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F59D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hJJ59iRH
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ae8607e8afso5101717b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590457; x=1793195257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3Vx6nCjfDKI1O0Rv8fJf2F45AGRs7XGpGz0epefQ+g=;
        b=hJJ59iRHC30A1gTQEDDDJVoWYsaG51zZ0HYS7C+ZOOzLNVAelcvR10wRjWsY9ejH3Z
         wC3hyzj2R+YckUSh1v8I1lPXjZLv1pZHyIwdZ980uL+nKX+qKSwB59KdlJkEsBRE6QYP
         V+BwsHpB3//5jRd/RY8u9WCduv0+JjzSe6wDFNWm2AFKR5Yo3qAcYvURTDcT4I+iAV1I
         PfEIYvl7tQxRj10Br6pEjSE6BpgCZgMLEJZQDahTuiNqgNwWf3wE17HUnkEzYq6V9hBs
         sm8GJrQHoxJUkpYinHbCMQUg5RploqWOK9VOAf7XD3YDhPnLKcHiWbG4IBZwDZ7mkovY
         C5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590457; x=1793195257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3Vx6nCjfDKI1O0Rv8fJf2F45AGRs7XGpGz0epefQ+g=;
        b=WSP5dPDK+EZ7WC7c8/1W6GDX6B+3qFYH3w4uopt3O0n12FOik+60Y3LsL1HawQqK7y
         DbfdeHaqjNIEc+LFpvZeVIAPXFMOJFvZp26eX+lx/E39OnEnc525B2Ucbm3HPr+1jtN5
         kSjG31VBiQQ1xKwA/9o96sJajT/SihipgXu6ZuHlotHJwANiiHLVuEhl4QfWsqil5FpA
         Df98Ovd0Qau03UeCHp715b97H5CoGclNO/K7WC9OCfB2QzF1/eAihpIL7VITV/DgEF0u
         7UA7BOpneeOFZmNHFMhZPz/cuvCfsDCap2ZoCxbTOq511bu6iXSwGLABKbnaT5+x2JI6
         d/lg==
X-Forwarded-Encrypted: i=1; AKwUvBzUTfnE1xi+ne5rj0KunZL78AZDx6sygXThR8aK/X8yY2vqOFKycgUSPUI+mtHfX3UIlK62uU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTmfyeKKFQQlM6KxbeIaySEpuUDzi5JgOZAm4KNj+xRc7Z9HCj
	YWn/wCn28ps6AOZML5hGKpNiBu8qVDsAEHK4dp2UUPw+8DpmZ//TmrLnqOmQdNUMa3g=
X-Gm-Gg: AYBFou0gx36Mnx3E+h2gFmI5PpdrizpIEsKTsAJEf83m+ip9jHnnY5E2T076dzL3Yp9
	5dwTLMDC45LWRCmcGe/lTr0563JGW8EsGP1daYSqpiamZ1o60ehyCRNXQTbbc+4V5LYAVn1auVY
	MgAFCsuZk9BP1OSFx2mnSbtheOZsDz5/kd1oykFOljy88BV1WTmQ/sQveQED5+0f14xkAV4F2Th
	wO0ATy6+7RnnGumOM1APK4/JKwWJDQsSB0FG7jl5TMPP7iafeNqApUspOdtwd3iwt/Uh1a3XArp
	HN2CuTWN6kkBG0P+azp4a/GhLqIEDHfr5P6j5V9wC+WXza8aER4D0u5h343rFua3WaVYk7MpXJ9
	BfyjR+cWWotGMOQ/z0oHFH+OngvcZmwO24ZZ5BKvHY70zNN3GLjUIjUtFAj+dIE28afTYNdQU1W
	cNCzzq+PnGtkPoSG1Q2oV4XCMKb73cdc6ItLgAvjTePPfvKKcybf8OpZvTgl8uFX7Ygmk5RTRjU
	+D/Er3050bme6AZTLsR6Q3r39hRvq4fp3S7Es2rrkh10he86Tpp3j+8/YckR1vC1iiL3w+w
X-Received: by 2002:a05:690c:4:b0:873:5c6b:a314 with SMTP id 00721157ae682-8b134389b4dmr10867637b3.66.1792590457017;
        Wed, 21 Oct 2026 06:47:37 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13018e0d1sm11045597b3.41.2026.10.21.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:59 +0000
Subject: [PATCH net-next v2 15/15] net: update comments that still describe
 the skb BUG_ON()s
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-15-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590424; l=2172;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=MDGe2ZQJ+rI3P7PzLeUdDmFI72t2b7q58f2qUsQ4Bag=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBAD74Tlz2UL8T7L2mQyY7NisozlhPe3QQxIgCRdFLU8kx33xd6A5QYzW2kATM5/cjWZtxWiPe3
 SKnGmgkQI4gA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The skbuff BUG_ON() conversions left a few comments behind:

 - bpf_skb_net_grow() says skb_segment() BUG()s on a frag_list with
   head_frag set at the downgraded MSS.  It fails the segmentation and
   the packet is dropped, which is still why the skb gets linearized.
 - The skb_to_sgvec() kernel-doc doesn't list the -EINVAL that
   __skb_to_sgvec() returns when @offset and @len run past the end of
   the skb.

No functional change.

Acked-by: Mina Almasry <almasrymina@google.com>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/filter.c | 6 +++---
 net/core/skbuff.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3ee1a093337e..f5bce0dc43fe 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3696,9 +3696,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		shinfo->gso_segs = 0;
 
 		/* Due to header growth, MSS needs to be downgraded.
-		 * There is a BUG_ON() when segmenting the frag_list with
-		 * head_frag true, so linearize the skb after downgrading
-		 * the MSS.
+		 * Segmenting a frag_list with head_frag true at the new MSS
+		 * fails and the packet gets dropped, so linearize the skb
+		 * after downgrading the MSS.
 		 */
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
 			skb_decrease_gso_size(shinfo, len_diff);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c5e28a52114b..e0c8f2f6bfac 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5551,8 +5551,9 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
  *
  *	Fill the specified scatter-gather list with mappings/pointers into a
  *	region of the buffer space attached to a socket buffer. Returns either
- *	the number of scatterlist items used, or -EMSGSIZE if the contents
- *	could not fit.
+ *	the number of scatterlist items used, -EMSGSIZE if the contents
+ *	could not fit, or -EINVAL if @offset and @len run past the end of
+ *	the skb.
  */
 int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
 {

-- 
2.55.0

