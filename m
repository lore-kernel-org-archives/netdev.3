Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672951;
	b=RS3/lPhSqfKygnmQ42eI+BE9yj7+XrP4if7ehU+SCmFPvou45Ffx5B7s8veFK2ogLfV3
	 BWyglAgMTcoDE8ps4kR5aWTCyEXdvhdlslOHGWO1JzsPtmCLUQgPummIASwpwuGiZ8I7f
	 AkAgUDvPnMWszukssyvMPeSsEdhIC+oZMDrxeWkKAJf+spyfuUDuJiDlXSWPsVV10rJx7
	 l7Wy5Xgn7zIHuPDmus/yQq6Ch8Jp3hkzn7Akxxfugym5rAnuUaTglqTvPuhdb/w11JcKc
	 OUNjgXnJMIua6oHHvvf1lDgWa0NqKbQLNAn67Q6JXl6trIAeg2zc6vfjFGdKsTrN2IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EA63ABVwcLs3h/JxipVqiXIy94JHS7osXg+Mm97gaVg=;
	b=U5L9kx1P+U7SMKuy0y15hNul441JBB+qTiRQVQnfoZb1wMdL7HkRJI+2iy07Dk/+RLAY
	 dfF7yl7ri/+HUUK65UngRO/ScPRxoV7r2NqBYgSkWaAmEPu4BG8ND+xYQhKAOAV2585ZO
	 haYLOBjUMXjundYutVZbTtJOgh4imDtdu3wGzNxHCmUTwge5oIo5uYLsYcc2UUgWkbyif
	 Hhsno1qYHwGLscoSJYiYUOELMzSRfKjbkWGIgqxFjxqDvYAfMxmYbx6/v1W3ZcaulgQZ/
	 NTEJX/qYsuW5cO93oj7KOoovFLdpOK2gcNn8E8VY3esw9K4VMe6YkXMXHK9apM0PUKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bfMerUn9;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D6606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744D6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bfMerUn9
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9441591aa5cso27425185a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672950; x=1794277750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EA63ABVwcLs3h/JxipVqiXIy94JHS7osXg+Mm97gaVg=;
        b=bfMerUn9HoBVFsYzAqNI7qQpcQyNwjGSN2axSAsHu3CVYVi2AxWKjL0/q7/z9jPqQA
         tRkHoEr+SG7KSFiFmIKTomnB/tc/E57hoU5P3Fx286fgRI7m/rDdZAJAga8//Fo52X5J
         qpH+30siiz1K6aer27OW6I27M2nN5nRv+6imMMgHerlYixUZXX7VRTO5axHBwPKt0bfs
         RfszUU+M2GfhbwGVflG4cJg0Y2ee6CzB/gEpsN+D4GGt5F/Mxc70URvTWZV9Dvyq3D/e
         GKEjkWGcz3FOk+pV7F46Vk1z4nGUrj7B5dxIN5KSZMktCGg/wvDpV9hJQ+Ad09ntBEnt
         ZjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672950; x=1794277750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EA63ABVwcLs3h/JxipVqiXIy94JHS7osXg+Mm97gaVg=;
        b=MJDwahTSx7jxRoA54eZfJMBsIaFMNRltLTsYHbFHVNK3OEdAHnunLNA+5UbWv1sziM
         8yYVozUHSrVwtRrJ9Yr9EtRw082T5u//N69gYmpuh4x43urLluZM7JLmtJzojCzEZDB3
         q1/GBXnqC3yUoKJ206xFZMGP8zTDbqpIQ7o872jU5+BEpJbJyfJQWinMC/bam0cE0pat
         HazhYowi7jovhvTPb1WE6depwlz4nxfiYJAOVRAH+QKD+VFvmbpZ2cnKtgIVwJ7mKjcL
         4n0PAfoX0Y/M9SBDkOHo/4H68KFqGdW8wUV77bz9a5o7qCvbm01dTk1R/rh5BIkkwgcY
         JeNA==
X-Forwarded-Encrypted: i=1; AKwUvBz3vSnkUxA6EXqJjiEI1nYZS7Bi6mCZ6wTPfr/MAfM/IHUmb8ZhpqVqNn6EMrwGSPcsWDBVVwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwyKQQXzRYI7x4TdurWlRXZv1DxxV/VtHCP4W94pDQB+xasLoa
	bo/DMW/KRsRigsQU58pxt+qecGho4qXlasIREzlL43I1+PkofcwmpZ4XkHJteQ/Db9c=
X-Gm-Gg: AYBFou1SpU7ZKwAFoTxlCQceBaeF3FXpG7z4DvabYnN0QDG3Jo/l08fHF3ZXD4WFMCE
	bO/BG5Mdo8GMMjV2k17jpBckyOAbxnJod8QCrQs7zYrv5Cwl9HDvbm1KxUGj+f+6ztR/2WMayRs
	6de0O1EK7IYIm96inqakBxtr8UzrMu27rP6aDUiPbnMRVPQY6phjpFO3q9BY78nMm7kzX7iuo8b
	j6evfilxyJR1ZNOkf5bJekKXEbUhIM2n+lhLotS/DczN91HFMFAjhV8AMo3bkXnoP9Zca4/m12I
	zNoT+gOK7JdzTGWgYQb3mMn9jLY7CDsaSF157O9SDWxz7Y2AHDgOKLrZDeARbJP+kW4+w3oR5by
	NjsioFDMr/lVRNuFy0Ks2Q/lkfia2ll4NNfZMlH2PawnbmNwjixJfvYAt9inic3XZHWVJK8zGN0
	m4txgqui50STS16G6Ed62aMxkd0H5dNIvuIFozFaDOHB27W7hJgvgY4t7anrbczSrvvmjryfsL4
	Z07gi/Z1eoI8mgHzjbZMoVovXdj6U8KzOk9A6Wkk785u2/eMP0l9NGTxRxZTHcoIp+LwS2jNvzk
	s992T+Dlw2Zr3kQXzS8/n76iEnLTYzLbniyoIUTHa7sxng==
X-Received: by 2002:a05:620a:17a9:b0:93e:5ff9:a8f4 with SMTP id af79cd13be357-9442135f4e4mr1720591185a.0.1793672950127;
        Mon, 02 Nov 2026 18:29:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ae63fesm971577285a.42.2026.11.02.18.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:39 +0000
Subject: [PATCH net-next v3 13/15] xen-netfront: don't BUG() when
 skb_copy_bits() fails in bounce_skb()
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-13-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=1213;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=m7OgokcwaZHLGjQXMpKbgpowrvI9FQDluMyHz8mi3Ig=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG6bjet0JqDvVFJtGL5dr8aWS2Y1CrqqPkeXYvW304JvA/+zhQI48mUWQjXqe9iWtZ3dd/1Xbtp
 dxeEcxZi/5gk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

bounce_skb() is an open-coded skb_copy() into a page-aligned buffer, and
it has the same BUG_ON(skb_copy_bits()).  skb_copy_bits() fails when the
skb's lengths don't add up or its frags are unreadable.

bounce_skb() already frees the new skb and returns NULL when the
allocation comes back misaligned, and xennet_start_xmit() drops the
packet in that case.  Take the same path, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fdcb91042f29..17811d81937c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -695,7 +695,12 @@ static struct sk_buff *bounce_skb(const struct sk_buff *skb)
 	/* Set the tail pointer and length */
 	skb_put(n, skb->len);
 
-	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+	if (unlikely(skb_copy_bits(skb, -headerlen, n->head,
+				   headerlen + skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 	return n;

-- 
2.55.0

