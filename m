Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033E3C5DD4
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394586; cv=none; b=JqRtShfK1q0+nm9yAOcT/yYAGbNcJPCTDWCu2fEouKqqqbRSZN90RNitYYtl46pi8m7ba+yK7grVgT4+szi5BFjXnL1NrDiBTxfXXUpImIIUJ1Vpp9TxKcE4I8O5OT6MyiSSZK1HIyujdRSCkbPnrb1jVhXAhk+kr/h99NXle8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394586; c=relaxed/simple;
	bh=cSmudJHbwRb7ftKNmXOyT01jlhInPfXyvTA0bqzaBtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxDjE9gX893HLIrEHPt90+U4HZtATAnrn30qGj7VSK5b5GYDVJL59v1efIeQmg/hewIEcS/MXzC0/CPQVA/QDMXlReOYky64IN5eLPbhiPLM9kNvkIt9TICzfvkwimSnTlBuS/2uvJGzQH438FbYWGuv7wlsvWz5epdJQRXsMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ucmxq6ln; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ucmxq6ln"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e515769d3so173964385a.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394583; x=1791999383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkXLYOq6wxEnThc2GKl43lmdMZEROVt8Vlb6zLp/IGQ=;
        b=Ucmxq6ln9k/FVB0Sq0+2mtpnrGgKcdjtc2C2NEbqUeW980aElEOVK4bSDOm2Rl8wJR
         FMlbQzvADxtj1Rif91nsGWldlzgwZbftBZZefqymQSOf2P5q+DFFoqDZ+Qrl184vZZQp
         JTe7Y346KVLSxYer1cKKihAmkc1UlH8pRmUEoZ+GU8EHSkKoPyewD6HbvVbvc8rnz6CG
         pzeIQ+1pJG4BxQPpVD2Z8h2SbzS9KiFVrRqgQKv1YHg4ZWSe7LLUqvBeeXNB6pzJuj2C
         kOrKzmqHp34AIP1qHM2x/p0KFDHOYcCQsMdqOxNGxxPCEOjTH29wh4utr8fq7Ja3YLnk
         ctgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394583; x=1791999383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkXLYOq6wxEnThc2GKl43lmdMZEROVt8Vlb6zLp/IGQ=;
        b=rXiI4flVRQKjITH27WSidVLa91//xzWecIkZQ8t1ry9sIW6Iwx1y+oS12oRX9lRCCR
         yap5o+EyQMxQJN4W+LTqg+JWapPn0rRrV+myGjQ7NwUMaGF3VghIAhCPoH7DxgyKyoNr
         rq8WbjEdxQlXzPYxc+FunS9SWq0pFFQsTD576VCfAMyCjkU8V8wjlsSbPdonjZXuWILt
         KGcTPIWHNSJkL824fYTLBUnui1Sj6Jp/Gd6tzh6Sof6D1wo0XD3TCVRRFDxLkqOoFSCI
         RxAWNFQdep/HjWwY03/1JZtdCgvXTbkIne/9KH7OzN/Tpk8W/WToMVmMt3EZLcd5zFZH
         2+Ng==
X-Gm-Message-State: AFuF++mZQC0FXfOoUY0gZjIZGcoRI0QnSVKigh7RpijjPFpJ5idWxRsa
	hkHbmMqk3D50tMNAXt69wJai6YoiSaSyeNU+zQadyzHIVqPSnRukUaoj57EhyszmDfw=
X-Gm-Gg: AYBFou1Exnw3jznPzVKmrmNp3wsNy5iKIdgA/Hd81e6B7NDZpmZnHkp9LI7tIyGgzXD
	7l1TZL2r0SchghezRsuTxcvXAiPbkX+Yo8Frt1btic5ZF0/BpIFz0oNApBXniS+M1Kic/9IEa5o
	p700z5zZCH85YY9/EZkpSRBkXjWsF+1sxDwLAohGjiNDfGfv+KLHH5znO7edJoSHvs6uU/jpz+i
	6IC936YVU60fDr3oiHiw1SCt2xBW2m4cBpzoH4PUMkNKTZPyI2w7UKqLNXd55tCznmxkY8Vaoia
	Clis7/c9sRIeK1iTo4B4Y70GQ3TytLU1N9bWdv6rEO9vmYQFY4A77H7bDcENM03ORFl2p6mL8Oe
	ztmrhTnJk1V6YwFmLASahSUecbMNYMIxkmvYUCQ0xCxX/niQi+OSNJuWrgfi8B+vNOcd2FylwUt
	99YHeVztML8IPsCDptUsm8jB4Tm3EMVx/wMM6OUzoXWdMFEnzifP3wvPV4veSZSFCl2RY8xd7z8
	HbnSunILDaQrrH/rDHQLPHW6g==
X-Received: by 2002:a05:620a:46a0:b0:93e:5016:e3a6 with SMTP id af79cd13be357-93e9b71c5b3mr603215685a.26.1791394583188;
        Wed, 07 Oct 2026 10:36:23 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991a5b12sm269963185a.32.2026.10.07.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:04 +0000
Subject: [PATCH net-next v2 5/8] net: skbuff: don't BUG() on a bad
 csum_start in skb_copy_and_csum_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-5-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=2105;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cSmudJHbwRb7ftKNmXOyT01jlhInPfXyvTA0bqzaBtI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBpiN2WNeEIoX+g7s52V4F2BSYScskxIKcuTqYzjcLkjR7WDGGCfC3rjhpSFWB2PS/aejdpTZtl
 1F9LMUs4JNQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_copy_and_csum_dev() copies everything up to the checksum start out
of the linear area, and BUG()s if the checksum start is past the end of
the linear area.  It misses the other direction: a CHECKSUM_PARTIAL skb
that has been pulled past its csum_start gives a negative offset, which
gets past the check and becomes a ~4GB copy.  It also trusts
csum_offset when it stores the folded checksum.  So far
skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
but once it returns instead, a bad csum_offset would write past the end
of the caller's buffer.

The function returns void and its callers are drivers copying a frame
into a bounce buffer just before handing it to the hardware.  There's
nothing for them to back out of, so check both ends of csum_start and
that the checksum field fits in the frame, and if not, copy the whole
frame with skb_copy_bits() without filling in the checksum, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.  The frame
goes out with a bad checksum and is dropped by the receiver.  If even
that copy fails, zero the buffer so the driver doesn't send stale bytes.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 32d7f5ed25eb..c896770203f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3977,7 +3977,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
-	BUG_ON(csstart > skb_headlen(skb));
+	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     (skb->ip_summed == CHECKSUM_PARTIAL &&
+		      csstart + skb->csum_offset + sizeof(__sum16) >
+		      skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		/* Send the frame without the checksum filled in, or send
+		 * zeroes if we can't even copy it.
+		 */
+		if (skb_copy_bits(skb, 0, to, skb->len))
+			memset(to, 0, skb->len);
+		return;
+	}
 
 	skb_copy_from_linear_data(skb, to, csstart);
 

-- 
2.55.0

