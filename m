Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55F48A8C2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594717; cv=none; b=mLIISa62zw9YAEfIoK70kR1+O2Nik5c4/rj5bf5jPghMwDbaG0CGy6TpKu49Y+cSJYKt+qe0K+JbEaxVKf/5GNXDZHbhIc4mblJ5aoy7Ec50eXOYRxCxaVZwkOwAsS4XJs7IUq/n6g6yizhc1APGXKwO4Ss67huRDqs1jwyPpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594717; c=relaxed/simple;
	bh=uNlx2hpfeoxZRCqrhu5DYCSMd8YIQavLzVraY8D2lTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N6ywRxYfFvUtlcM9v0T4sn+6CQzIx4We0Z9FK4b9gAz3V8V4E7rqNnUONCWFv61l0TZnVYYMAcEy/VlheMvDysKzubqv3JVSI/PuEaw2Va3BJu1H5pQk2fCKl9zrlk97dk0mJk7BpVIVn8QZH2oCLpfHZU2hod0MtUhDMsRAKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj0kr8u5; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj0kr8u5"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so47798b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789594699; x=1790199499; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=njMIgBpCOlJ4XFoV/IxBhtjHnwV8oWctBsfBYWR97cs=;
        b=mj0kr8u5nIcAGY5nkxZEouP3xp80gEeNBe9aVeDIhTFcv+6BHMLFauDmdUQ3idyWq2
         07UJNqlgiVwWCqmkGNXq1fdvXDjbfH8l6h9oeVPX+eCTw9FusWT+x6GBCIVeIfoWiZcG
         nqKs1j58WLOOPrAdsl6DYtacENy+Onti+o9ahmHvEeqJvRTrR8N1KjgcCCp4PieX+cka
         v9P5moaGEUThjY7G/MGZul7T145Z5P9PO8SwrYNp/mbgUckmqkRj7fTngk1oao/qPRqS
         33k7FhK4c2lM2RivQlwT6F7oVoUi0VA8ANkJJ4qk/Zc2j68qrRuzTo/8FPbHzQL+fVya
         vD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594699; x=1790199499;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=njMIgBpCOlJ4XFoV/IxBhtjHnwV8oWctBsfBYWR97cs=;
        b=Ye91pTmPwVwLDSNXr8YhNTy17nBAT+Apxi31D0iEoqMXYueqNWkvlYFFJ7j1grFMuv
         d0zOEamiE2VCu6aoU1uLpUJYVSahf6bw1VA5vp9gUOWEzghiRTwFmGrPeADjITUFmaxl
         L71E8WiI4L1QViST/c8ALPd1piw5c69D6Tbrlqif05vtusBNZVuavUQqf6Hnm2NRsz09
         GLMf+YTpXB/6Cv54rGxgspdwGO0TRyUdqmh7J9gBKdyPq/jVZTg4QywoauI4xqAIZNZI
         LW/N7B401L/bnPqubt3jQUWNROoiYfErvXd5NaSmn+wuYYlGCSAearSiZTZuWADZ7TU2
         /KWQ==
X-Gm-Message-State: AFuF++nCeBYCfXurhWBhmWCrsLD8SswzUZE0LVt8SPNk6edgPvcpivWR
	am6u2huhrQ3yzllE83LaUkGj/naRquLE66sNbQ4w5mFudT73/zwkpr3E
X-Gm-Gg: AYBFou1v15RLJmH+4UnqzF5B2E9c+kf5wLjbiAWvo/XT92GY10gDzM2Q0Acaz2JtMZ6
	VWLTug4YNtwgnNino5A3zRQhouz7bNDOsiKEcfEy1bM/fKIrQkbdaaaAyBV/HT68C9SQE3AC4FK
	plncDG/DIaTWt16KExr1Gv9DJf2AWSYx7lP0xN7oOiZCqr9HoAnAB7lrOAiIs5k+4V9fnMjDJEU
	FOTYojGkRvV4q/saega1Rnwu3YB0JQEwQpySktl9dQGFHv6ububB1dKsKUd7axjUFZDWy8gevPF
	a38h1Ytp83HYeOR8Wwcf26GZsxuWcnrFvLB0HbGzPmyomu/zrqAg830dRGh5CP+90WltVuyb3yA
	0/nh+JytKUKtiRT3D3SKMSD6eFc8O6kbE6w8ynXIK2IJQlz09e+zncF+UdX3HrK+KrMQ7u+ofSk
	47Fshj8u292jRi2GlZIPdkHgojC419y2VeizsUgaYpOUkHAny6mupr1PvZRNv3B5JIaBs4sYGru
	rj8IN3g0A==
X-Received: by 2002:a05:6a00:21d6:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-873435a52e4mr1403570b3a.6.1789594699152;
        Wed, 16 Sep 2026 14:38:19 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720173842csm1830615b3a.41.2026.09.16.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:38:18 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 17 Sep 2026 06:38:16 +0900
Subject: [PATCH net] seg6: keep room for the mac header when growing the
 headroom
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEcMq2oC/yWM0QqDMAwAf0XyvIC1THG/MvaQpZlmzHY0OgTx3
 +22xzu428Akqxhcqg2yfNQ0xQLuVAGPFAdBDYWhqZu27l2HJkOLE/FLIo5CIac04dmT9z27LhB
 DSd9ZHrr+tleIMsPtL225P4Xn7xD2/QCdNXimfQAAAA==
X-Change-ID: 20260917-seg6-maclen-headroom-53a339c17dac
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=uNlx2hpfeoxZRCqrhu5DYCSMd8YIQavLzVraY8D2lTM=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqqwxIMgHFbdimLQQJXT6/bd4d8vpzcsOlWPi8G
 HuUoqGnYOGJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaqsMSAAKCRAq19F1Kl0b
 TVHCEACZ9/UU3vbviZElkjvyFmQTHOERAOE/Q9pCAx7PtLa2zcyl4KtncBvLyZLNFL91mjVGS4X
 UuZQkxVcsxZ4KYZh5sCqYWSrs9/j9MjuMAiAWNcYdi2gJEIO9E02P5098MiM+7RnL66jGmUjxCj
 OxEciSNiawABlBH8S4iGyX1UVLPb/CEgHGBdajGIXDNRml3o+jXu4ETBuahtDFFStFz84T55Y8a
 6igo9Mf0xN74Opk7uw2WvQsC3dZdA0UEsgjCzh9u8D77O/YB/7PLgdEiHlAkF07qrBbMuijAHUE
 eybsL9IrCdGQIFKwUJPD1idCi+kdd1xhHKqnrRh1vnaubjydWaw6snYQTlLk4aJepPCS6SjorZG
 DKUEkW4Sp+Ssne88fhU19yy7m1qGVTtxCJdI9U6sUffBsQ5+1Ht6yOeeJpY3h9xqDILFvwjqI75
 sPjcrhFD0Er+jZNGIGS5sUG/aUov6MHJY26aBNE6heavfk+fe8j4iQv5WJRF+nlwywRyb4zMhq9
 8Rx+q6nnbNvgfPqabncqKSLGqdtXHny9C/YrEXvex2NKuzB3RHrwTUJeRWetHdAKwJc7CLR6oAb
 2a5NhbXgQYGpKr03D4vrW7oZB5fY5vYro1QNPPKX5EB7VC0Age9eYqPq7JGPbuvhkC99KWGcYwz
 8+f87cxDWeGHzTw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

__seg6_do_srh_inline(), __seg6_do_srh_encap() and
seg6_do_srh_encap_red() all grow the headroom with skb_cow_head(), push
the new headers into it, and then rebuild the mac header below them with
skb_mac_header_rebuild().  The headroom left after the push has to be at
least skb->mac_len for that rebuild, but the three requests ask for the
pushed length plus dst_dev_overhead(), which leaves LL_RESERVED_SPACE()
of the egress device, 16 bytes for plain Ethernet.

Where the mac header is longer than that, as it is on ingress through a
VLAN device with reorder_hdr off, the rebuild runs out of room:
skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
stores it unchecked in the u16 skb->mac_header, and the memmove that
follows writes skb->mac_len bytes about 64 KB past skb->head.
Forwarding plain ping6 traffic through such a device reproduces it on
all five encapsulation modes; skb->mac_header comes back as 65534 on a
704-byte head.

Ask for whichever of the two is larger.  These requests carried
skb->mac_len until the egress overhead took its place rather than
joining it.

Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_iptunnel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..0e60bbca19ca 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -153,7 +153,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
-	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, tot_len + max(skb->mac_len,
+					      dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
@@ -255,7 +256,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
 
-	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, tot_len + max(skb->mac_len,
+					      dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
@@ -351,7 +353,8 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, hdrlen + max(skb->mac_len,
+					     dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 

---
base-commit: 9a1599eeb8d18a2113e4cabcbd3bec5a8377dbed
change-id: 20260917-seg6-maclen-headroom-53a339c17dac

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

