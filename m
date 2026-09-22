Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6964FDA59
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061126; cv=none; b=Gdq+0XaHM4PxPSbC0XMZ4Q7Nv01QmMEZZeU01Gt8Hh1HiEd+nQq5TUAZoRve/EswCTm+L+vDWrOi0yQzPjMDMTPnwXp/qo06rBFAc2hT2fqFcJlmXnszT5/GX/PrmnIbe1Y+RhcBfPox1ArbixyYoGhdl2sL0FPQePWNttaDtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061126; c=relaxed/simple;
	bh=kgjY688mplAdGhSTn31JDhepkJAY0gXeuAm8BDIPCmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya2U+ARv739inJXE4+JhG1YzvXkQrE4/O4gUM5bHs44RkH0HcKo3YLN6DrVpQZDM82j/78zEDluF/1TcqWzaNOyhQ2vsXkqRA/O2GL0Prjhq0p/JbFb3qWke+6L8mH4j7LMolZd3qkPrvY1D+8MDSzYz81GDCp91wgGJZWfzNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XJlJCFVx; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XJlJCFVx"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso4041286a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790061124; x=1790665924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHxz3lJ1rnpXdcv0GZzxFy5K7MzlBbx4/kmDfl2h6nw=;
        b=XJlJCFVx8KEBMTKcMsEk1SlZ25iPQp/2VRyqCqJ5XLzEmJuc3UJNqHUMXl1IEXBfI2
         eTD71HzX5PZq2mkoQYuo7ryhPNym2kb460/ELCy8TqJUaGBtz2F/xatVhJcvrq+e3p6g
         uwzj2+q3QT8BWGeqy9YuC/IIUg7+p8xUKBfCpqWuy7dW8dWfY9378mu8Bd15bNybUyM3
         GULIyFmUfCu+UdwO3GRfqAgIrd9UEdpI3IBJiD2YlJRnCCU7StEYHkrUSiAZTtiDJ6bP
         PD/GVPBEZV+S/Y0kQ54mtz/rfQYZN/w+QHFzVEjPFSYY/5GRyUBsZQyDJLiFQf1th/pN
         UcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061124; x=1790665924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHxz3lJ1rnpXdcv0GZzxFy5K7MzlBbx4/kmDfl2h6nw=;
        b=gTl6oXNbgWBIkoug/far5qR+75dmmZN2ktf/g2xohNbtC8epkcuthZ4/vmiuKHRvjr
         DrX2hJWH7HX4jsSGhCtUp09gZqszfoNtaLOZ8sgoL/wnfZ+IxGxsUuC8cT5vg8CixyhM
         gA2OE79LldJ2VofXgLohIvuwIKUsSqKcgjcDzg7bi7N3j5+BgqZZNlqXhGd5lqiubeES
         LIhyEz2Pk73X2HaLthijT2Qd7uxD2sN/z2ULTGiHu70RfB/ru3mNDdAaYb7iZXCZpSZ4
         cE8XcEDfRD6bnb21azLdv61z84MZFWJMnz73LxAEFeTJhJjcnmdoxXU0OzpPiRt4SMrb
         FDuA==
X-Gm-Message-State: AFuF++k4EGGbrHjcgk8RwXthFQ4iwT1u7UQUj2q/Sla6JUxEzuxrKb+Z
	e4d0lBjQNfDuS/tnA4iKu8rosXw8RzviHDL5JOpdoNfVs74NCFJ1YM79M12OpGitImw3euD961C
	lQ4MNw0fREAw=
X-Gm-Gg: AYBFou1onm+3rdvRZd7gt2D6oofqjLY52llBOyaYuTxurEY0SEp5Gu6f7maoEM2s8ro
	cdxcu+Tl01NebtRjV7BofOAp9tqaZZxCACg3rgRnvwD2/ZK3vp7jF1QaXL/6AA/NFNGq3gBUNCt
	H95l0iAIxqHPqwtP2MeTOd4gpl3NWzRRQJuqfihOqw5rRG53XDoPX5WV1PwY3kzfBTv2aVD/EaF
	lzEOIccGhhVdruIwF9ZBFaTpR9rSkL0gEnCmqx0fhOPyf2XZKPNRhchc14Q5gA+tKWRsfY5QqRH
	J625rNe4XfWEfTwnocYrdauVnSbgM7FuUXLo4x9QnQwv6cFdS9VwJtCdm0lu4HgYCMS5Hsvs53x
	EBys9DArK8S4J3RdmjQ8bIW3VAA2rJmCJKjTG+lxc5RxBCFjR840A8Gb8OHuwuxXrCqXAdE3Mxp
	CSF3HaCZopzf4Aw3TtBCYwH6xY48pHvpOmBvMQ7fuGAe5//8iT+8o/FvcigxwBK4GsKZAn9L+7I
	n1UEQJAwzwVY+wWGjVmdeDmtGg4Jg==
X-Received: by 2002:a17:90b:5745:b0:39e:6c69:9b97 with SMTP id 98e67ed59e1d1-3a0732633aemr258577a91.60.1790061124057;
        Tue, 22 Sep 2026 00:12:04 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674df8bdsm3051240a91.16.2026.09.22.00.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:12:03 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v4 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Tue, 22 Sep 2026 07:11:45 +0000
Message-ID: <245c47d2af384e34411b848ac8d733db7ed14c7a.1790041241.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790041241.git.zihanx@nebusec.ai>
References: <cover.1790041241.git.zihanx@nebusec.ai>
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
bytes and has no recursion bound. A sufficiently deep chain can consume
the kernel stack before a transport GSO callback is reached.

The unbounded callback nesting was introduced when inet_gso_segment() was
made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
support predated that change, and IP-in-IP GSO/TSO support later made the
affected path reachable.

The corresponding IPv6 stackable path was introduced separately by
"ipv6: gso: make ipv6_gso_segment() stackable". This patch uses the same
bound for IPv6, but the Fixes tag covers the IPv4 root cause only.

Limit the number of header bytes stripped from the original MAC header
before entering an IPv4 or IPv6 GSO handler to GSO_MAX_HEADER (256 bytes).
The existing skb_gso_cb->mac_offset records the original MAC header
offset; comparing it with current skb headroom gives the consumed header
offset without adding per-packet recursion state. Both IP GSO handlers
perform the check at entry, so direct IP re-entry and tunnel dispatch
that leads to another IP header share the same monotonic budget. Other
GSO callback entry points are unchanged.

GSO_MAX_HEADER is a practical header-offset budget, not an
architecture-independent stack-safety proof. The budget includes
link-layer/VLAN bytes already pulled from the original MAC header, while
IPv6 extension and tunnel headers consume it faster. Once pulled headers
reach 256 bytes, the next IPv4 or IPv6 GSO handler entry is rejected.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v4:
  - Keep the budget check only at the two IP GSO handler entries; remove
    the common callback wrapper and other GSO call-site checks.
  - Reuse skb_gso_cb->mac_offset and current skb headroom as the
    cumulative header-offset budget.
  - v3 Link: https://lore.kernel.org/all/cover.1789802623.git.zihanx@nebusec.ai/
 include/net/gso.h      | 8 ++++++++
 net/ipv4/af_inet.c     | 2 ++
 net/ipv6/ip6_offload.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440c..86ff7e84c 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -23,6 +23,14 @@ struct skb_gso_cb {
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+#define GSO_MAX_HEADER	256
+
+static inline bool gso_header_len_exceeded(const struct sk_buff *skb)
+{
+	return skb_headroom(skb) - SKB_GSO_CB(skb)->mac_offset >=
+	       GSO_MAX_HEADER;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a..fa359b902 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1375,6 +1375,8 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_header_len_exceeded(skb)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c..884a7f827 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -104,6 +104,8 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_header_len_exceeded(skb)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.43.0

