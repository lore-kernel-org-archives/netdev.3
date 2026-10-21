Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590445;
	b=2KRDozUTmQM0n4XM07BhNZPmGRr43Bz3i+24YwI/HGR9pIUWsanhHGJUCv90P1aBx4v/
	 5EDrmZ2vxSGIeAbwEiV5qCFXNC552mfP6+kdA2Xe/w//E4RP4aEWNz7BbZba47V5EwdXB
	 rTJLmYYAjFxaKOE1v3pqVG/YJ+qYoWN3DZMexR35xVBxzuVuvEfR3BbG+udwzVIvlPN/t
	 wTbJApGThDDmLHoGBizsAojuHwnP/V71YbHpR20asg3SNzr6BsPpaXuC+oLGR/8xgCEza
	 RmEfJeTihKXxcDxUdDxIm5njGaS/vktD2zG326WezjvxEgu0xcC3tITm4orMVLUFcZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i59cwFpnwV4ZWelO27hAghlfIgiy6O8zXnZ0ftvy/nk=;
	b=fDD7bAeH60h1Ei2r0LCuShXmJDESNXN/OuozEGrY33g2q/3xTd/490IDFO0uFeYg8QQs
	 rZ5QCIfnNz0IRHyM0wM9B8eaC5Sh45qw+k192dbcXpHIHNQsKuAxmTKynUij4+Vb2eYoB
	 /fs5CxOPHnB2EiCYhrCc+37908/Lekqugo1RqJyaqln43GD0rfSVnJZ3dN8W422MqYv2K
	 X6/YHScf6pEzCFdiWgkvjoygAVaVUDTaSmlxslk4H98SzTdyxmcJLnoQGb36IKsui78XF
	 vNu0XCw5g3D23xOJRa7A7rutLXigO81BbwCJ5NIMf+BGm5PFHQhPwLOg+Fszq3slfqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dlVRUFoS;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18660A2603
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B18660A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dlVRUFoS
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677bc4704cbso661546d50.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590444; x=1793195244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i59cwFpnwV4ZWelO27hAghlfIgiy6O8zXnZ0ftvy/nk=;
        b=dlVRUFoSC8H0EPVDszS9nPkSl4BZw3HPmJ8SKr/Qi0yP7486QklMD86BFPFLxcuIN2
         PuY6fPGyLvTQzuDr78mXrMpfkDHb8Y4Tv3VJf05c5QNeg3n/MRH5v5U1Z6mFL7EpFgmm
         eQrQd7SWxvJisCd18pC5TML646y5DYDRAeUKDy/jV2wH+Ezfwy9xZ5ujWy2xav/aCV0v
         XldBxxqvwDgVFoGdKmGupWa4OKdUiwLwmUslZV70+Ya1UnI3rk/GZrIRwwfcdO5cHBSm
         8xG6KpvcPPv1U5y05P3584zgjnurTdQuTi0EKWZSxqh6Xtg8vmsryIhsvKRw7MGNaapx
         G4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590444; x=1793195244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i59cwFpnwV4ZWelO27hAghlfIgiy6O8zXnZ0ftvy/nk=;
        b=ZNE8Uj31k3596j37g6TEhtQ93cJ3kRif34ODAqbBVeAjad0KNCw0lhI9cSW3ngRoHO
         J6X/WTELDLCjP7BTwvy0NBxyQdlxvAVgl5tV7VZsvm4Fyc6i4RfCQcZgTc4Yqkpkhp+B
         ZmFF1H4ZrylZYHHppwZNQnbT0eywi54CkUN9qQxiUWJQWNurz6AGq1H5Scgeu5Fq0Jgu
         qCBtGR4Xg/2n0zlnR3VJP8Tsuh6fqvdiD1HvshdDWahXJqfqmQVHa2w2MbYuiDK8cbjD
         JQfRDdZZ18RufzgGmeEDpHAmcF12DADsXhi92+gFePnwZDe3Q083jKmGN/l6IEs41+UI
         O2ig==
X-Forwarded-Encrypted: i=1; AKwUvBw2c7Coz5jOcVyW6VsA/NV9L2ZeFqq9WoenAtaqCNR1KqLSVkGAjshXEwvD6sjKHA8jjKq06bk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1zAM2MulRRBknsM+9jNLAQnWjTsQMdpLlXwm8/bQqY54RaWHW
	iPqiXSXJUkCzorNH+3xm0b1qREz4NYWPseBeMkRV71FbxYVHiCkY8k95vbHTauOAaQA=
X-Gm-Gg: AYBFou0vBOvDL6co41JnfdWt+jiqvOc93sY4VYSMQp+fMuUJMs4aBztgAhlZzhADDwy
	PNrkF3vim5xphLZTw7iYd2WoPsMwl+DgR6eCJQ+9Hc263X3BEEBtIbxUwe/SOWZrLWDBlLDZecA
	9wyr4oA6oiEjWnPr6YHCpybdsWO0oHoLorBKZZmHp/pEPH5uN4AN8fpCl4sKXmIxJaQNPoeS/Xa
	4uI6F6GZahbSIRS/Zhu2F4JvJeezuZlKrmuIJ5YrgkwLPOodEDd5eBVpuy/laCi56LfPbV9xzx4
	8jns+qyOaCM4HECGqtRkWE0WFgXWbgU3EHRnKxB0SvIBE9vhxw7EG16VjwGQI//mjtt3qgTnyci
	KLNiHg/fQiJrOyPj4QO/V/goPzbkJIFbp0YXgVDxmYjidBBSRRVvBBSD/4tbpJ4iaVZk8uzEhgy
	K3wsloKUy4UNy/Wv70VX31KVmi7ge93+UHX4NMV1Ce7+xpraal1ZSQDmyGAOlWUwCGcGqsVy4HY
	f0uco6LvuoRhaOxLIarA5qBJsAPltRxGrQgnY4l4Riu6NUpOV3hv0So5D+1Pp8wU4VNSdP4B6JZ
	2Z9BwGKKztMYbd0IvQ==
X-Received: by 2002:a53:b651:0:b0:676:a43e:ea5d with SMTP id 956f58d0204a3-67a0e53f355mr566093d50.94.1792590444386;
        Wed, 21 Oct 2026 06:47:24 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300c85c9sm11376607b3.23.2026.10.21.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:53 +0000
Subject: [PATCH net-next v2 09/15] net: skbuff: check csum_start against
 len in skb_copy_and_csum_dev()
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-9-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=1647;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sxMOxEm7hnqJ4JHjLlLYqgrWX5cOQpVgaNwl3bOsGCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ5DZXQlsw5+XJkbUArUHkgGRU3eEEoiu+2jmTppSATvScEPdtV2sfsGUnIAGlonU/HYjZGtwF3
 0pwcvexSMIwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in
skb_copy_and_csum_dev()") checks the checksum start against both ends
of the linear area before copying up to it.  For an skb that isn't
CHECKSUM_PARTIAL, though, the checksum start is skb_headlen() itself,
so the check compares it to itself and can't fail.  If data_len is
bigger than len, skb_headlen() underflows to about 4GB, and that
becomes the length skb_copy_from_linear_data() copies into the
driver's bounce buffer.

The old BUG_ON() had the same blind spot.  Also check the checksum
start against skb->len, so such an skb takes the existing fallback,
which copies at most skb->len bytes without filling in the checksum.

Found by LLM review after the series that made the change was applied.

Fixes: 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c89c463f234..782a6bacd568 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4103,7 +4103,11 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
+	/* skb_headlen() underflows if data_len is bigger than len, so check
+	 * csstart against len as well.
+	 */
 	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     csstart > skb->len ||
 		     (skb->ip_summed == CHECKSUM_PARTIAL &&
 		      csstart + skb->csum_offset + sizeof(__sum16) >
 		      skb->len))) {

-- 
2.55.0

