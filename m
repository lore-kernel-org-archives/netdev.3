Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825288;
	b=2u09NAenMJxuosk8EaH0SLFTLvUe9ISMX874+YH6a/6JAtts5o32dc2zNHjQO34cchAY
	 YEpgNS7Hb/UfwKOW+fpkQiGVH1h76vBK52uordruxu89bt9wacoFAod9YBYL+qHY2bJXs
	 tcHarRtJg8fKqpIVlA1iUnAHJ/6uJBWgYOdWCzXCIoRNz8gpEMjwlmRehPQuPJ4FUD2Rh
	 b8Zfs1QqizBnI/YvnD9uWMVojPckzg399+fSD1CResu+tn7Y3nfdjNrZJ2zEj68GOtY1Z
	 uDFltAjCcj5QLe1SPtLYtkuvHMSNB1I6BiZOnoSwdtYWXJrkPqENH16VVYxe74lERBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
	b=f45g1+CdLSCatlTmxwL2/zD6SewZf1fl1ZbTNHfN+u0DAZmdDaO6b5vGDe5Rz19nY0+7
	 C0e2NkjH+vvPB1zMUCXrDr2zeKz3ItCY9sVP2QMVXb5F4W5tcjSdQeWAsca6yOLKasC7g
	 UabWPaDdLLr0tJ6eG1TWJstdEUKHjiaNuTB1ZfvE+cABtmr0rC64j833YNKslstbi0wgo
	 Z+PNHCx3VLtTbqhqf54P2CSYBXm+TeJFzQmrqRwiSxZ9Qi58JVK9u2KUtCwwRor1JVQGq
	 Rq+11em/HHAgsNIPBhz/fdu4keuYUjnJZXP6ofPQRbUudbWnvMy/qvtSQYSUS1s2Gqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cyY7Nnw2;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583F609692D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B583F609692D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cyY7Nnw2
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f3c8958d5so127163385a.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825287; x=1794430087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
        b=cyY7Nnw2AC5c8RU6VlTJA7JMfhNPSMa5/IfHOpHz9VxoJnJDRJyFQohct8J++mHgd8
         JeVKSfc7e4f34QKH4djlgXhoslOyXTjJXCAK1bXxAm+53RSN9f4JJLLSKAPtQg439jkY
         rDdCQ3fq26S9cv5JOqnjXApm3R8sJAhiXqopLNpEHECEZ46GtWoOSH82eGaENheCoEEm
         odnZyjCrf7//Z2eCuWbnCP4iNJ4+rLrojDMKVFq6IgBRmQHD+CMC9i3cR3W+U6W+EoV8
         W5/lM/ibmdQN+N2U2gPEEW5rrRna6L3f6f+YVb64jDUxicwSD+WnkYkhFbWeaPZ9JrMT
         B4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825287; x=1794430087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vm4X83cKQV2cViXLrBy8CdaLxj8kNgfl4SZFvLru4UA=;
        b=ZmkwjNANfoQG7abTs8erY82kldpU6S+AKAHcfe2GEMCfQRC6Cx5VuUqjr+druFu9iQ
         yfQ0tGPXpSHDAWs4KhXJxd45giYXDDZPIEtv695V1yvUWTkf3sM+gQ0UeYMQJuxhE0pO
         OhjlJSEjYmBhKEO6hOW8Yqrda2RCgqdr39Nbkt2Wiok7sa9qAoL60dfdeqy9OueTkkuV
         G9R4uq61vto5vGN8OnzKtlu8OF38YXOb4OmeP4HjcXiaP+XIfPD484OdTfJJHIxHY4LO
         4y2ik40st/M20EQjJzKSaIdQUXmCJ+uoJJJ+utx33aB09igXbG6qd80ZxiIBhoBgwgxy
         nqTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0hjI78Eb3khdCTx66uSiZotQ1uN7UA6mj9i9BIVzv+sxVd1dkt0Rj6rYlpppRQ/oIDYWBCM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KtA5G9rBvRbyVP4XpE+/Yj3FsOFCJCMi4AaxlhtEWwG3L/IHL
	o6JuJUgj2QWdvdiEBCvmhf3+JtoTQkPIHloMCVaW7mWBQdmEbbSKf3vSXSfaP7kullA=
X-Gm-Gg: AYBFou09YbiyOKLXwlMZg1htjbfVOYznaAoCZJbGedSQ4G4iow0NOHbxygNA3seI5dT
	SkREVFryoy/eptfhpfOc0FPR5rQGzKpL8J5VF0CYWFDm84hS0OjhlXPPN7CzM6u6gdbSSrJEonx
	c4GbToG1Z0+iWkyajd77FKGq3yi8LG08PWftexQQx4jVul3rnOSt/TFgn6zWdYACPOucMYqIsul
	zkqkiSuSwM/MXxhfv2EKFOrUqkdtctCIYa3Q13wOrugF8O9lMpzrV6kDQKGjVgJoyjhT5zKExk3
	KbiaZ3hxR83PR3eswV6PSnhDYfeIaP8mxKWCwfTXYZKvbuaQs9JvZp6tSBKJU8+d2+E1cxQnfHx
	1YGrNewY8UJH3cC+RWgq2MrO3TKPXtoTkCvDD1mFzoxQ0JAiCMivl5hemTDcDxOJOuxQpWGJOFd
	q8QqnaDtduhNSrQIB214Tuc6XcGc5hc0ISN9Gd941Y+BPyuNR4ZtyVRw0lWLNiIBMAwqojNsfAj
	iQTAKlTgWgOfZKkvmLn3OMw2s2mJjb04B6P35h7mvPgIx1YdTCKMJqIaVUWJaeMVh7sJArTKjzU
	b5WoDgUwyJUiGWKRqFvEhPvXRrRsDYHSLbJGwQjeUNdYP5lVEOTe2nAfYTzXIYqbt7w=
X-Received: by 2002:a05:620a:4043:b0:93f:31f0:6a7f with SMTP id af79cd13be357-9442172a5c1mr3191494585a.69.1793825286622;
        Wed, 04 Nov 2026 12:48:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4899dc6sm292004485a.43.2026.11.04.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:26 +0000
Subject: [PATCH net-next v4 14/15] net/tls: don't BUG() on leftover length
 in __skb_nsg()
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-14-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=1573;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jtewRftckK13p/nQalxWcrhfGpFqhqstsSARsz5AoHI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDKngciEsEX8JG2Ad0fN9Mloe1uVw1/l2WZ7sISbd/Ng5VMersZpizDOJC2J3tEMBwMooCA/YD/
 B+ZXmrDCaGAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_nsg() counts the scatterlist entries for a range of an skb with a
copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
skb runs out before the range does.  tls_decrypt_sg() calls it on the
same range it then passes to skb_to_sgvec(), so a bad range would BUG()
here before it got to skb_to_sgvec()'s error return.

__skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
and tls_decrypt_sg() fails the record on any return below 1.  Return
-EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels, and say so in the comment above skb_nsg().

Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..748ae27f2b88 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -142,12 +142,16 @@ static int __skb_nsg(struct sk_buff *skb, int offset, int len,
                         start = end;
                 }
         }
-        BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
         return elt;
 }
 
 /* Return the number of scatterlist elements required to completely map the
- * skb, or -EMSGSIZE if the recursion depth is exceeded.
+ * skb, -EMSGSIZE if the recursion depth is exceeded, or -EINVAL if the skb
+ * runs out before @len does.
  */
 static int skb_nsg(struct sk_buff *skb, int offset, int len)
 {

-- 
2.55.0

