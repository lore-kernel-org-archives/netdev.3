Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000734F96CC
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417878; cv=none; b=juqhbUXoBgkLSsqpVkBFJeb5LiyQGpF9VjR9uejR/LzgTlDSnHTcahUiioI2SAaWTFzM0swy9WfEzqrckadtjr+Ohm9cCUnegOiq56iz2PaXEIWxWxBIs4nPjJz/5eTj2yvwPUlt9fGjxZDzKoYEKp3+0YdPjPh8SRmh6rOsX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417878; c=relaxed/simple;
	bh=+TWKmcN/9YISrCDdUhnWQSTAcvPk81OG628CQR0a1S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rop6bYMdj4wf7uQNSYf/xpLL6alihVPuUxOrIFtjhfdxoNf2Hr8BTMiRm2RBu1/9UvZflcLMiJkKeEX5p0G5GiGOdRecqWN+GSrAS2bB+LDZFbo/koiJvWegWupYA3MU+K/H1dLM2WpPOarUEQto2XYoMD3DmJWN5mfzWNj6C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=S0VEALCl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="S0VEALCl"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93ead211f14so242744385a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417876; x=1793022676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5hhezvrkrPsILbBbBLRGuH3wT+463IdJ8u+tbtUXF4=;
        b=S0VEALCliCRB5bwPY9+ChyAhrutn4uXK5Ux14fIhVM6n9B9s2u4KfP9sH9/h6mSyKT
         9VVNWoqt29tPllv1A6CtU1vIXunS+iVVWRzZTmHdsxQ+c/rQTaGIhdh0JhyamWimi15B
         mLe+bFOyFziOIbqgcVF0x9EIwj/+g3tdKBoi2yjyhg6aS6vnFZ3dt6KbxClTkv6t8UYS
         +fcGee1FPUtxLmY1wgMfaRrxB8qbW5EJ8/o89NvZPLE9dWiAkfTh/vvMESfkx4OhdcZN
         XZiqHst9FIHv6yaqNg/r4yk630CUrRK77HdB9F2yLnOWhE+RYNErsh75w9zOZmNBL9YJ
         DRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417876; x=1793022676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5hhezvrkrPsILbBbBLRGuH3wT+463IdJ8u+tbtUXF4=;
        b=WgsuP6AnA3JCJ8YXYg7fYo5RBz30v4J2B0AfX50WzJG7VJGd9NZ/njBEhoMII55Klg
         3itsSW12dNdhKp6X8prQq0CZeF6X6WjDCeV/RmbWOgkZNPMn4qYotSK3gv7r2FVyiTcF
         uiU/RuGOKmpIh+ur1jLy5xIBnY5jluPe8QGj25pqa3ky6jRGaZcoejmO2lsGyt4gkbqn
         UoRJ9RrWKeiI+3dGnfIvKGu1OAHBD+KnB2Yw0VS4fvvMmC6DOH8UTnPEyuql5bJhh72X
         SIhLIszvLdwXXS8dXgCF6THV9JAfcZFhsUwZOb0lcQyzV4r/okv6Y33vmqdCxtwWHS9P
         XMuA==
X-Forwarded-Encrypted: i=1; AKwUvBwnlnsFbnd7bt14r8mbZdGeAYwONpjo9TMcuQYl5ELK2Y339qW6KCZuH+LOe0pPLRc00StZNzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk5ifmoZTCLZ7sCKVHn+25hOCH8jefPltBScryqIzcgdCXGaeB
	w4PjWs0QFyIG1PuqjkVCOCK9IfaIabPmvGC8uXDX540AvA5J8FO/zizrymqKKZwkk7M=
X-Gm-Gg: AYBFou0HdTclqwuT8xlIlsjZ3nC8T1xKNSI0C9ungjo6XDaQsVIwUf0Q2YCcj4gOmUs
	N7cJvsabNNTYY8IsMDl0eGH/DP9IMSFJAA0OwVFaicXUViIefsVn8pH4dTquHAuXIv37cv/wWUG
	zGmaUSBpZakA6tMo53Hb9eXf7bBiR61UJVXSWyV1OPqUHj3t/WgPm7VRkgo7JWhcMfL3maFpt7G
	vUJwUsCJyF1T8JoTmLfe78rj7TLXqDan53faeVwmlUoEE/kQBu3hSZHQ+Mr5sZ7TidBfB5YTYYf
	rI1D4a4LwbppRJg0JPvkaGauQIgY97IaWb5nSDzKqDwiHBwwiq4a/3UjoPYegy6tDeAc7fzXy3U
	3ERqrtrMJpRpeViD3LrrGwuG9i9Hj8QpflABNIyv99srq695kFUKlQOY1zUc/VBKGhAsEcAUi/t
	+3rI24NPiThJTBs+79AkTMrYhvOwmyigCtVf1o66+rkz1IAoK3+j8YZVy/tK1bD7rRcGoSEj+re
	DwU8Svv8X7b/R0=
X-Received: by 2002:a05:620a:a0c6:10b0:93f:2571:c30a with SMTP id af79cd13be357-93f2571d926mr888761185a.30.1792417875823;
        Mon, 19 Oct 2026 06:51:15 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bccc721a8sm97777206d6.12.2026.10.19.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:39 +0000
Subject: [PATCH net-next 05/15] net: skbuff: fail pskb_trim_rcsum() when it
 can't checksum the tail
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-5-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417848; l=1264;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=+TWKmcN/9YISrCDdUhnWQSTAcvPk81OG628CQR0a1S8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPX/xL5smxia3f6ZS9PJYHyB/T8o2gs9Ov0UWXx8FV1o98bw8LukMOYZJRi8edA9qG013xP3J8r
 M73yrz78D0wI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For a CHECKSUM_COMPLETE skb, pskb_trim_rcsum() subtracts the checksum
of the bytes it trims from skb->csum.  It gets that checksum from
skb_checksum(), so if the trimmed range runs into unreadable frags in a
frag_list member, or past the end of the skb, it subtracts 0 and
leaves skb->csum covering bytes that are no longer in the packet.

pskb_trim_rcsum() can already fail, and its callers drop the packet
when it does.  Use skb_checksum_full() and return its error.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 88ed2dd99dc0..de433d452939 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2829,9 +2829,13 @@ static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
 	int delta = skb->len - len;
 
 	if (skb_frags_readable(skb)) {
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		__wsum csum = 0;
+		int err;
+
+		err = skb_checksum_full(skb, len, delta, &csum);
+		if (err)
+			return err;
+		skb->csum = csum_block_sub(skb->csum, csum, len);
 		return 0;
 	}
 

-- 
2.55.0

