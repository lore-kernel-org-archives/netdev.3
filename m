Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672935;
	b=pb/gnc5F82QHw1V0K3pvrdpBRh962+lrVm4aCebqikOs2ylKL8ue4/KThoaf+/Rv5T06
	 PKN+mTxqieIq/F7Mf7qnhlMxesM5rDiGQ3ERD9u/1zoqiw5STfqXTcuGXtd1bwCo8LX9h
	 ek/gFAKA0o07fot5FnY0UJd5g0sbobLaPrAIhayqVRfulsTGfB1JjLsJfmQUTEmJMoyf0
	 WFU3n0iPw8tImfmSRWrj3gEwRTlJxWnu2bCbUqR3wC9cCR6yddRRh0l2aE+SbV3z74BUu
	 Dh1rnIA5zcv31EaGWpvFIEmmFj+mH/u6KdEU1YcWMJ6DpH+ja7VSrXIDOgE54tgHmfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MLIaIMsqYL3SSjD9c7Tzup1bl56m63w7tPTiVpME7Yg=;
	b=1DZ3IMMlhLWoNMvm6VYyuEcR8YdiYD4Ao9enSaEcJbR4ZWk4hfl7QMsQOIKsAD/r4DK9
	 e3TzwpMBRLR/E/u0kgRZZ33y1iS0EG6bEv05DSPfREESNVkVdTGT5ubG1exJXhsOX1IgO
	 DwN6r6ygfPbeOF8kT2ZniHxeS7OBxLIbApSveXB9/hk4fkWocDVyUkSzHEHr4IKZ2FaOg
	 A6gq0xNgBe9ykIz+hzm3yH63o65yz0L+OZmMgsNounRUW9xFf2zbyMVDMTxISbeBiEaa7
	 zUYk6jx2eXqxpWjO1NjTHh+2B/sSG5xBIwK5Y2Rd3RgwJBKRIs2mchZGLxhJt7zu5Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ETRdzzT5;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A2606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ETRdzzT5
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53653e30353so63928261cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672934; x=1794277734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLIaIMsqYL3SSjD9c7Tzup1bl56m63w7tPTiVpME7Yg=;
        b=ETRdzzT5k8oGByWiEZB13wH5huqNdoM23XSUCXhHBYLCGTri8l3cxXWsxxTszipH+E
         Jpmdiz3UjhCEkY5LKFFIS/hUMg77/+9cI0gR4/b/vyZL9ePDiSN7x/FIV9bxXZ9KLzOz
         GJsxSvQ8f6W2r+wp2d9wt1RpTHePvZ0Hc2zz355laTt97Ft9PEnLy1GbbN4/pXDYFnJJ
         IFsNYwuBBYmkpwiiuJeFXjaKXAGAzNxw/CncLXMAdjzp8bmGQqE+67kAQo9RLNipTZ7T
         dlORy7yZKtMoz1APRjToMnuxjLOPtpmebm7izBaR75lHLWMRzz5HiUUUWBHQxj+QAGJQ
         +SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672934; x=1794277734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLIaIMsqYL3SSjD9c7Tzup1bl56m63w7tPTiVpME7Yg=;
        b=fUXX74B2Q9Rn4UvQVwFVjYnFjProBDFfD5DtT9p4pQBZ3Qv5mJN4abeAZzm0SF6E//
         H09fcWKXRMGFEyJEnnV9McZf437qi6ERv3BbvWcLtHPjMhuYFal9w93vUm6RVwMr4U3g
         /yqL7Woa8jsrMlBj1XTA8Z2g6Sff7BZtje5Fph9d9tpFv9XM3b91ZVnvvS5zPa5PcKMT
         xDf+Jwn9MBuE5uNEHiU2qQQ9VaaiGeHWv/Y7EvkrXiVvS4rAoId5dPVix0i3F45UWSEM
         5chV3tjVYxQpWNJPfgLfA8/lKlgsQ0wq6clKJ2TcsCXPhPwTxvl421xdKgxlc05YCTa3
         380g==
X-Forwarded-Encrypted: i=1; AKwUvBw3DMDtZsfFptryJ3Y3X1ebfZUPdh5JhlzwJm02tTCPLHyNO17/sM3UhjMswxhaLkpmaUVzEBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4bmfqF7qPOkJVmX0GsRzvMkoV0BwLKMZXQ6J3Z1gdmi4BqAkr
	t5zzGfUuITNWR4u6vH5IdD3yniCJBOyPXuOh6xqr9q4gTeWJgPAywPHBCSkLCWI4rdk=
X-Gm-Gg: AYBFou0SbuLRXF+UUWyfTHaD2s/sKfGe8sj9/Yym65DshYfZ59OcsZgwxsherrQZtNv
	f0FAZ1WGx1i43YxtQA8lTnX1g8s5q3DSk30SoDozSl+CD22HRHE2y+1oAGIuX22oYChJcnulTiL
	cIfifejTGdMu62P2CjblumnyLsToBJqkEIM9HbJ3zhzXxejzjPSJVosPymnEPugxTEwSV6cssYC
	4lOE0/Dnrv3pkNziHI6bb9klpD3WmilfYYo5J9r7JelGLpAj8n34t6m1PVOXcTpfgz+sSMlryKa
	Oqgxj2SHo5kM1hhMfOt95BGk/umEAlnRSUHbB2FQYRdgu1LoaQKV0X0LKk0fm7yfg3XCxgxF2g1
	Nqf6uGB/83xw3EWRY6DEP0JTyZmBoPaIObL6SviUCSVDYxVKiYFzbUoautHXc0j6TWtgzAcG9Qy
	Udu2EXOCOaJHAQf6GbI72qGSWXLiOPIOW0q+ZRqHF+HMuZVz1dnmI5Ee6OikKPGbAxrn1ow1Sdh
	GlLJKA1w5RHBA5ngWNkPuMWs6D5zBuNx/Fe7mFdIpvlipfXmdx3zvhXdKJFHfnTgw7EPehSn7sA
	MdH8FeSOcFNzpr+4Cw2/Rj1bQLl9bWqTLkjVsWwGgdEQyw==
X-Received: by 2002:a05:622a:a889:b0:537:83e9:b88a with SMTP id d75a77b69052e-542b64964b4mr199343741cf.23.1793672933851;
        Mon, 02 Nov 2026 18:28:53 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cb5b520sm13795611cf.26.2026.11.02.18.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:30 +0000
Subject: [PATCH net-next v3 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-4-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=1748;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=TlO/AKeZArxeBmRh7l805X0/4fVE3bHDKuOYPc0A/+Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDNO9/a3hdew67VlcDguwy5iB/P7gwRmhlzB8AVvniMlDrIfyz9W9B22je1YjbgzdeslLLgxJZL
 0BnXxMWLQxws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When the device can't checksum the protocol, skb_segment() checksums
each segment with skb_checksum().  If the segment has unreadable frags,
or its lengths don't add up, skb_checksum() returns 0 and the segment
goes out with a checksum that doesn't cover its payload.

Devmem TCP doesn't get that far today.  Its skbs take SKBFL_SHARED_FRAG
from the zerocopy uarg, so skb_segment() tries to linearize the segment
first, and that fails with -ENOMEM for unreadable frags.  No other path
is known to bring an unreadable segment here either.

Use skb_checksum_full() and fail the segmentation with -EFAULT, so that
the checksum doesn't depend on that flag.

Found by the Sashiko AI review of an earlier fix for the same path with
SG off.

Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0d3f0f09c7d1..5f997edf3519 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5292,9 +5292,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			if (!nskb->remcsum_offload)
 				nskb->ip_summed = CHECKSUM_NONE;
-			SKB_GSO_CB(nskb)->csum =
-				skb_checksum(nskb, doffset,
-					     nskb->len - doffset, 0);
+			SKB_GSO_CB(nskb)->csum = 0;
+			if (skb_checksum_full(nskb, doffset,
+					      nskb->len - doffset,
+					      &SKB_GSO_CB(nskb)->csum)) {
+				err = -EFAULT;
+				goto err;
+			}
 			SKB_GSO_CB(nskb)->csum_start =
 				skb_headroom(nskb) + doffset;
 		}

-- 
2.55.0

