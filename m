Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC184FC333
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417885; cv=none; b=jVgiuiaZdNhqV1zKM1/0n9EAH8FrOkRNuqkg/rULuIW7mPvkp1pJXTEUoQkYQfjxUwrSBn2J82DFfXhmrIzL85sPHqpuMILFnI81/omZsaqcVNR23v2O6/XOZ6z7eVpsoZLK1B1dAh4Znftp/s4gz9NKKsASpsuDU4j8lm4ljAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417885; c=relaxed/simple;
	bh=p1EJ3Mjc5nJGteUiFCelu7Pkg91i/fkjkkkh/ts8Tfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gh0uEu2xI53g5YZLDhKZ8SQZnJwGnx5vrFPGGgLBiceCbdjfi0DLpWdl0A7OqHXBlQuqCo6udvgUyPOzEnZyKIYdrY/cevYidcxORJclTznGHzYD5mvHzO9QqgkwOzKAKGvIUkdQPxd8qgRHnlZthDTWOh8wzfBFYoVaSA2sI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XzjUlJeJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XzjUlJeJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-918f75a68f0so32503686d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417882; x=1793022682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbXvQLGgZpsimSrfs+W8d8Jbr4mc/fISMihOBkAlu6E=;
        b=XzjUlJeJJQEKnxh7ydUiW15tuKNLnxjnIUXhxrF6nd5rALqkzmHRIFOzk8kTHGGiGi
         JwwAH177mRDucdqi27vf4e6/dy7q/33pTcivY/C/zsUGeZ5tCajeefSN8RltOvk9XmUt
         TjTXrUleqj2trw4SDaalXuoSzoV95df/Nyx2lEcJp2jOOCbnVbZX9OEplL+UccpDdhRV
         fFTGYeNQwSUOjF0VWl5TeNI105kKiLU6NNr9AS9vlG8NPvn9fS4jQWAvrQy6AHqhe2Y9
         tnmD27gtmiIFPtAmPcvc6Sp9UZA8js6s7dDGokkK90f7RX0utscKq+EsJLKLivWcAI1I
         L5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417882; x=1793022682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbXvQLGgZpsimSrfs+W8d8Jbr4mc/fISMihOBkAlu6E=;
        b=a0GUWqhDLJZEQNiAS5vsbi7SzQv1DSLQcw/HX1+7k3/B4WxuWIlfC5UT4/jwOtHxsL
         64791Q9L36B5aJzRFWUjAiYcy5RhHmQAHD07e6/401vvCgKioGTeas5gQhui8v5jM6HY
         J1EEPgg+S5UyqpdSdJLEJY7DDGeOyNsyuDs3VDkXrKluDEtMGx+UGYJfVUsIz5/tZ5m0
         o+t0agmAAiR0c2oLg76/b8st1dp9RiqsFUovESBI60MKNSNi5teDw+kguxQzCDNPN7FU
         3LYj0vG2dDRzRv30ckSZ1NbbVPAeekPuWj4rtPGlB80CVQYpiK1/GopdI67JVe11ShtS
         vt5A==
X-Forwarded-Encrypted: i=1; AKwUvByEYFXYsHfk3F3dXp4WO48Xw/jyQEGW0tCfhonR0ZF+jUo1EvCQYSPu0eASKJ9anZUsq5CD64o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC/F1h3moUqXwPeHX+d8DgB/Nfp9P1SVKTvunrhYMp23eVvQSA
	HheJDNwhRKim38beA7rdKGzLhcFaS3Lc9IrjTjMm3zLc+m9xMfXQZ8B5NRJM0iOEA3Y=
X-Gm-Gg: AYBFou0gTt5StN2+d1bIBFhbql+NK1TOqPWTqsHjrJjB1XwaJay3rqqc2jxLDTKQagx
	V+9xrH/dxruDmrg0lW5WWW9+SOtL8iqM7Uf1EE/xYm7ahudCQLOFJal0Xu+/Axbb4mHxt2IibKW
	IFncuRSAiGxHEsunOvE4c8GKU9vcHrDzk9vKjFgrl8+7jE7iDOTKkvwPojRTTTFLloa3MoUYmt5
	SCjHExvlFR4heWlJFP/WQn6bDMMYhP8qr4YnCNax406w9TQ5sAmE73UFuyhlq1clTgT6szmu8XV
	Lw+YJ1PqrD/G2lMsgJUUG3LRS5ItsE82LOeP50DQaSG97tuQfxE50f3NCk2v7RQZ+/jFwqHmU4k
	upva/H13IGL4JaB3Rbueqn645zQxpFjibBNC6Q3O3u+0lIUHD1WylTvs9jULVe4nTqgbOJVV/VW
	ol7DXKhN/6u7ROniADkB9zFqABRQn7ndeJersiqzfx2fuPo7tF80i7E76hrTexQmqrMt7D6JCRx
	Jd/bp5yfOGgiEdz3klaZR56XGlJRl1iM512q4Y4SI4Bf9x1M3HFt/JWK7u6ndFY4l2Kuz/tDpZD
	BAsjZ0UE4b0csD5PDg==
X-Received: by 2002:a05:6214:29e1:b0:91b:5d39:e145 with SMTP id 6a1803df08f44-91bdf63bb40mr141562036d6.58.1792417880639;
        Mon, 19 Oct 2026 06:51:20 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bd276eec4sm88112796d6.2.2026.10.19.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:41 +0000
Subject: [PATCH net-next 07/15] net: skbuff: let skb_zerocopy() copy a
 short skb without head_frag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-7-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=3126;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=p1EJ3Mjc5nJGteUiFCelu7Pkg91i/fkjkkkh/ts8Tfs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB3VQkhmVt4VPOky68kfBhcPE1aOMyFJILHR1dQhl/DSlceDdzD2F0Osxoak/AkI08GCT1eWZyg
 KcJIYQOtx0wY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in
skb_zerocopy()") turned the BUG_ON(!from->head_frag && !hlen) into an
-EFAULT return, but left it ahead of the small-payload path.  That path
copies everything with skb_copy_bits() and never references the head
as a page, so the check doesn't apply to it.

Open vSwitch gets there with an ordinary request.
OVS_PACKET_CMD_EXECUTE allocates the packet with __dev_alloc_skb(...,
GFP_KERNEL), which gives it a kmalloc'd head without head_frag.  A
POP_ETH action on a 14 byte frame leaves it empty, and a USERSPACE
action then queues it with queue_userspace_packet(), which calls
skb_zerocopy(user_skb, skb, 0, 0).  That used to BUG(), and now the
upcall fails and the packet is counted as lost, with a WARN on
CONFIG_DEBUG_NET kernels.  OVS_PACKET_CMD_EXECUTE only needs
CAP_NET_ADMIN in the user namespace that owns the network namespace,
so with the openvswitch module loaded any user can do this from their
own namespace.

Move the check below the small-payload path, so a zero-length copy
succeeds the same way it does for an skb with a head_frag, and document
the -EFAULT case.

Found by the Sashiko AI review of v2 of the series that made the
change.

Fixes: 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()")
Link: https://lore.kernel.org/all/179173804997.434549.4450793967361922984@kernel.org/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3b2a3747f009..735dd25213bb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4014,8 +4014,9 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *	Return value:
  *	0: everything is OK
  *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
- *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
- *      payload would be mixed with unreadable frags.
+ *	-EFAULT: skb_copy_bits() found some problem with skb geometry, @from has
+ *	no head_frag and @hlen is 0 while @len doesn't fit in @to's tailroom,
+ *	or readable head payload would be mixed with unreadable frags.
  */
 int
 skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
@@ -4026,15 +4027,18 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
+	/* dont bother with small payloads */
+	if (len <= skb_tailroom(to))
+		return skb_copy_bits(from, 0, skb_put(to, len), len);
+
+	/* Without a head_frag the head can't be referenced as a page, so the
+	 * caller has to ask for it to be copied.
+	 */
 	if (unlikely(!from->head_frag && !hlen)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return -EFAULT;
 	}
 
-	/* dont bother with small payloads */
-	if (len <= skb_tailroom(to))
-		return skb_copy_bits(from, 0, skb_put(to, len), len);
-
 	if (hlen) {
 		ret = skb_copy_bits(from, 0, skb_put(to, hlen), hlen);
 		if (unlikely(ret))

-- 
2.55.0

