Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590443;
	b=1wXKv/vChRS58ri4QNE0oFFyYFfvyTWruvunfkTW6rOMPOW84GQvlMgNiTyE3/jDplEp
	 R7yhdDlVW6VSEG1amzasp52f3POzkzqODI/J6zQK/bEr5+E4ikWYdUTpp8PRAY85NiLTG
	 1zpaxCzVJZiRAKWqRDeghqWUthcek7Y+xezdJtlqiq7Fzl6jEVN+7hLnAsxkRz3X1X5SA
	 NRRvleyWg5zh3KWEGl5+uw8O4jwqPYSvx6Smzgpt50evIH981S3hMMLFL2RBhktJorjFT
	 l14l4wRb23mzC4hIJH+qaW1BEtNWXn8UTm1r1Z1MjOMgqclcNeQfURZLHLDJhPqGumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8wxt1Epm3k3rT9QE881oEaKsrBbXJoueUEmgjTPk70U=;
	b=H4tfylbZEcOGiPz2H1owrSIpe+Jksr/52jB9i4lsKlLgGIeHxAg4s2FbWurRfz4KanmE
	 NOJtcUsHOHTEE5OBMaox0VwyvorazcA1Akl9L0VDqXlJmNnGutU2dm0i/7DFFjD94vo3a
	 AdjdalSONaFUKSchly7ckC628AoS/vi1jA6CsO8dwSGilpuHaMLiAkfpZ+wNdWnQoCIOb
	 /1qkcwWhszLe3kCk6AItnPwmBBpn15nvQ4NjS/i0qXL1FJ1CleKKd7Sh77nEdhpZRUpLI
	 jKaSV0BqgRqW5UgZZS0S0L976c3jpMTXa/48xnZQ439o1Mv4LQyx2xFiqlYC81kRYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PdY5BImV;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3760A261E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D3760A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PdY5BImV
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679a420b5afso725618d50.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590442; x=1793195242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wxt1Epm3k3rT9QE881oEaKsrBbXJoueUEmgjTPk70U=;
        b=PdY5BImVjgJHIXVX+psSuGYSEZe7qrDN/7y2PCUuRdP96lDCwchI2U8DaOY5YbK8lf
         p7V03G/NxxSaLFhjvbzMxdCm8jkm6yYd8PRcI5euSwt3Y4Ja9hcQP2Ph90DeXgqlQaIh
         YzSmHKVFrVEyaTbysVuEAmc8WpWDD/axG5xAdN7qFD37jxIAmjf6iJjw9wrUxO+MeEK0
         rpDVnV8/Rf8IGGtUh36LT5tR3vvE1FOhJ3h6D3bdkF5eMp66VQ51rTKafX9vCX1nZHvf
         Avl0/+5xJwjblcspqe7BkfQUpxTZeOgYNlmRvsJt92YtksQcHOIh7NLfNH6nQUlQDObE
         0Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590442; x=1793195242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wxt1Epm3k3rT9QE881oEaKsrBbXJoueUEmgjTPk70U=;
        b=Cinj+9eQnfjpklOfXImLk1Wpk+r6L6GDTfT1WNz5v655GvxZnYM0Nr2IwwpcVA8tJW
         YqZBxoSTkL4jd3qonLTmi0wRCFPDC87dVYeu3lJKBiKo+K1Wmt0y6Rta8tZ4sbmyEQZP
         6Y8G0wncOm7SdXQEKCyu3zKXl4doZkQpmbMEoCo0gDi4jY57yRerrc4NSCCcizdDUma6
         KsgO2tp5RPGSxbqBPLVypfiEktFBUUKbAY09/NPI7RSkoNIvrVL/W7jGccKvGnJvVOtd
         W3DLrz8PMvwj/qR7o+QpgepgvwnBBn4pkqy/NiwWGtL+nWC6zTaqbbaUEZId6VK7a/LO
         czrg==
X-Forwarded-Encrypted: i=1; AKwUvBw7xyk57Jhx3h6XamS/ejLzz5x+mFEgD/Vaw392rHpaLcS2lK8+RwZqwIrTQnZ6W7G6HI0T1RE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLok8srysLWysgjR5kAkUJHNQEZtGL59Fd+2cEuhTCJMOG3kG31
	t8O6qjA8cZvxLstG4BfMvBsVgQYIjeQfavfr1L57fKExdItrhIBbTb/SA604sRYEU6g=
X-Gm-Gg: AYBFou0Rff9WE3mazBpq6/mR7DafJ3GZxP1/S9RXirhI0yISNO0T8T1T4UmYApDi5FS
	PVY2EGCA/lCb8S1BIS0llYA+x0dqhcxsHoc9IcFGqm+6EhOnkySQ70E1Cih8T+AKQyHTNPBVIQW
	5vDm5/ixLhxnqaZGD8Q5lbmGVNfhftYCvvAjMMozMvZYqtZpOTRF4D2dcvwquqzbX2MM4eTAmfR
	/ImES4jqZAOHtgMW/iM6lqECBS7v2JdF23KvsyC3sGLb81hu4Qbp5o+W/cB6zXQWHq6Z8dM5sl8
	5TCv3gQu4Ic6/ZcTfI/G+y7q2Pz+dJ8JrKMZs+1KGPI2nJ+aIu96qv5jfQwf6t+IFUtSrk32lYj
	Zberhh1ABh0xdOSV1p6sab4hBYacmsEAZt/IenTEtSLhzueD9PlNHuu1VqG3v0msveGEdI/GROK
	v9ccqi2VFdeQR52+8pSKKmjNh1/C8VuTb1vTIK/ucMElfz18pkTBzxQMOQMRedHI1oVrT0FTX9c
	/6F+7ikxTVkJZYfD2u5BeQ9fVZWCQ2DXqYkFbRBi2+4qOJrgZBn9LVPZp+4sQZ12ZBzBb5S
X-Received: by 2002:a05:690e:140e:b0:679:9942:8977 with SMTP id 956f58d0204a3-67a0e034ce2mr861218d50.7.1792590442281;
        Wed, 21 Oct 2026 06:47:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e501bf6sm1068068d50.14.2026.10.21.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:52 +0000
Subject: [PATCH net-next v2 08/15] net: skbuff: make skb_try_coalesce()'s
 len unsigned
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-8-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=2184;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=GLGsUKpELPU6q+dQsnPVRh/KHoYno5QlglXwcqwsDWs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHtIQpXIZEHUiTOUwL7sUcXUNd8TtVIN+/3dZDmNgDJuDjg0ASyNkhneJ5Ri6l2qmlypziQED+1
 55FOiTpYFJwc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_try_coalesce() keeps from->len, which is unsigned, in an int.  A
corrupt from->len above INT_MAX turns negative and gets past the
len <= skb_tailroom(to) check.  Commit 279877d86c82 ("net: skbuff:
don't BUG() when skb_copy_bits() fails in copy helpers") moved the copy
into the tailroom ahead of skb_put(), so that check is now the only
thing left in the way: skb_copy_bits() clamps its copy to the negative
length, and memcpy() takes it as an unsigned int, so it becomes a ~2GB
write past the end of @to.  Before that commit skb_put() ran first,
and its overflow check caught such a length before anything was
copied.

Keep len unsigned, like from->len.  skb_tailroom() is never negative,
so the tailroom check then refuses such a length, and every other use
of len already takes an unsigned value.  The truesize sanity check
compares the int delta against len; spell out its delta < 0 case so a
negative delta still warns now that the comparison is unsigned.

Found by the Sashiko AI review of v2 of the series that made the
change.

Fixes: 279877d86c82 ("net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 735dd25213bb..5c89c463f234 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6392,7 +6392,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		      bool *fragstolen, int *delta_truesize)
 {
 	struct skb_shared_info *to_shinfo, *from_shinfo;
-	int i, delta, len = from->len;
+	unsigned int len = from->len;
+	int i, delta;
 
 	*fragstolen = false;
 
@@ -6463,7 +6464,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		delta = from->truesize - SKB_TRUESIZE(skb_end_offset(from));
 	}
 
-	WARN_ON_ONCE(delta < len);
+	WARN_ON_ONCE(delta < 0 || delta < len);
 
 	memcpy(to_shinfo->frags + to_shinfo->nr_frags,
 	       from_shinfo->frags,

-- 
2.55.0

