Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C83939C1
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789308758; cv=none; b=bYmBYRHHpfk7FnFj7HfOyIzwqq6d7PkPsVWo3XxwSnevmnNEs8SFAEF2R39NuSjDWjl++xoM8URQCu6uyTM3nevEZXog/39+abhmti4tcqgnsE/kGCspFjppnacCAvsWj1Ma9BPT8sTQEUjEhoifB/KMbQ/VwMkyyJ2uv2DSpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789308758; c=relaxed/simple;
	bh=OWAWubmf4ss7J8Yo4qOqfqNHNCDMJhQKtVRn6E/gf2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4b0nC93eAiLgmPortE9DF+iigktPoMhcHXBka3ODd5qFteID4EABbG1Cjz3UGzcuVVVjtm8oLJq+U2PyBD2dgbVlzN0Z5YyT28RmBHloyLTJmbkbQOiObquXoqpKXBuiyOlnA85tSUtSHgdrBeh7ch/G6JSfMh9QIeyl8x4Rzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sq44tiTC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sq44tiTC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2414116a91.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789308756; x=1789913556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wihnFaWb5iWKnqc8laOseCAwwlwT+036etp63VgAL8=;
        b=sq44tiTCI0EUo5x/dVF1TYevwolBzRo3VRJXwY42GcdaAoARQN6AhT5YINRaiHnB2A
         YPl4JQhNqXFr/P3MXWvhCwX0IswBVVqLGQ+y6Ig4UWKU29sLAUGv4ovLmiJ1QwGkRR/S
         j8VRqlkNy0mSDYn6vZw2mJfiXnN2md/7EDt7jmFig6u5nqJvgUhpzASUSIRvJGiWmNA/
         glI3UCcHqUnkm0vL6VRGkUC6kRFkIX2gEPJOlRsfuYgo2vpjhpOK3ubCO1ycpB7gE+0+
         fFyXbA7udDZiL9Mziea/KCpi1qRlhgDn9rIq5kbP+dqCq0hzLtK9U2rNvNcwNGdX9gGA
         t3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789308756; x=1789913556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wihnFaWb5iWKnqc8laOseCAwwlwT+036etp63VgAL8=;
        b=dU63xxT4RVRNoqz54yIh+SomfN7+AlWxlAc8DB1OvlT2qsFcC6Xs9AS3B7CDn1VQlO
         V0kQhziuL+yu1avEYZDbFdCkB5JUNLPlh/Ct+sJk1+GJGrHOHNpU5R3jb7HORU+RYpsf
         ub/0Wge0bkue2UEbNQLf8k0lBoHXBENse7seTYSQHFkbjLWZ8iSmUahdfO/TPos8rrS7
         4sPoa+n3pDxm+6/SwfOaNdIMFEXBsV8aBZvWJ7Ftize4+swwOm7u616kxgIpMAAzm1Gb
         RpEcrWSRBhVq5jEhsh/Hhq1FF7IRAcF+17uXlmXQXGNRqQsjGGNrPHLe6mbCvoASGlo2
         pM7A==
X-Gm-Message-State: AFuF++lBjKmshRAZG10idfS966gmdcZfawKzH1s3l9SU+6qaZ7QW4lVo
	7cGDvE4AOxHs7RutTq0ZJ4JeKULnTdO6wJFabUsjwtgTnr4Scp9qCRiiA0ppqO40kZwizGOljv2
	2n0IFmleV
X-Gm-Gg: AYBFou0T4FZ54+TQJuc56qsXdnfiWIjqD+jesefSqtLu2m8k9EkDTRcXRnquWl5Xu14
	jm1SdXAxP1So1Kgefb5LlFbdKCKSWhyptNYcKnJmbPHLoYdSLU3WtHlzXRP7KmHtQTlB/qgAuXV
	+Ldf7p06sEPDf0cfgSRFNlTgfxmqnkUaIoFlNGW/suIxnZkH9WU672i/YpJ2YyrUyE2EbUDfMFR
	JZhC4CLnAMvRIBkXgaNvZD3E7zRwStgxTEG9T/agZlWJCOgTU+SGn8CjUVn3+wtp6cPWUKV1ees
	87Ssqzd8d4PgRSASRXI3a0IOFxtJD6JE5RjeWpFyMg9uwkqBrfBMdBAQzQtwaqlnSb7v+hdqT0N
	9sGBTZNx/nUts2NHSkPLgyUXYAziStcY2sPk+LLwlrTVkhgulokawR8Wl76Ak74W0++E6thBvN2
	+ZSym94dvdN87alBtrFVij2EzFf6lG+CZI/5dFDzxH06cUFi/A2as01AC6T+9TTiePtZroo4Jc/
	2IJmUiX41hwje0xrOpDYDZ1IrqlaA==
X-Received: by 2002:a17:90b:39a7:b0:398:9bd1:3214 with SMTP id 98e67ed59e1d1-39d9c223eb3mr22110578a91.21.1789308755971;
        Sun, 13 Sep 2026 07:12:35 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm15481457a91.13.2026.09.13.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:12:35 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	willemb@google.com,
	kuniyu@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Sun, 13 Sep 2026 14:12:12 +0000
Message-ID: <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789302084.git.zihanx@nebusec.ai>
References: <cover.1789302084.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
only state that tracks this nesting is encap_level, which records header
bytes and has no recursion bound. A sufficiently deep chain can consume the
kernel stack before a transport GSO callback is reached.

The unbounded callback nesting was introduced when inet_gso_segment() was
made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
support predated that change, and IP-in-IP GSO/TSO support later made the
affected path reachable.

Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
callback entry. Thus 14 callback entries are allowed to complete;
GSO_RECURSION_LIMIT is the rejection threshold, not the number of
successful callbacks. Initialize the counter for each top-level GSO
operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
nesting is bounded.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/net/gso.h      | 9 +++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad5..2665acbb9205 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,19 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of GSO callbacks this packet already went through. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+#define GSO_RECURSION_LIMIT	15	/* First callback depth to reject. */
+static inline int gso_recursion_inc_test(struct sk_buff *skb)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter ==
+	       GSO_RECURSION_LIMIT;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..e96ef6350064 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..2bd88ba05eb9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1374,6 +1374,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int ihl;
 	int id;
 
+	if (unlikely(gso_recursion_inc_test(skb)))
+		goto out;
+
 	skb_reset_network_header(skb);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c536..391527a1a47b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -103,6 +103,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	int nhoff;
 	bool gso_partial;
 
+	if (unlikely(gso_recursion_inc_test(skb)))
+		goto out;
+
 	skb_reset_network_header(skb);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
-- 
2.43.0

