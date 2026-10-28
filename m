Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196813;
	b=RTJgHk48Z763VErkjCO8its5drDK6xbCmqNiysnl00SD8hEb88VpdYHPVPImekyr1cbr
	 oI7YzsmkW0JEv6svSWKsFUh/Y/s2yNUIoPx6zKMVjyE/N2nnd77pj+jTlDtLVxQ4Lsbjn
	 g+tr+sklqojPLayTTgNXRXg5hw4SeJzT1tp9WYEks+B4o+6AswNaPV8fM8s7U710z8U74
	 l1NbVz8vnOABr+wONrctcoPyovbDxxdhNhSDeQIS0W3i7jYWHW895ZwN0s1U0zFSqJn1v
	 URC5n776JL9P2DjoIXlOwXzwkTWPiLUP7TqqfSV1fbfqV9hsMC8VwC9zYsxhwJeM6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cB7rYoNo0LqZe8zAkmS4kIYgrBoAJBjqJBOLwdbnCZs=;
	b=5Kbo7qyFN6SYG9alKnBh87wKL211OhetFdOweRX2WISln3HRdUyhIToPfezCvsyAeJNU
	 i03iPqQc6KKt+R5aqt/aJ0ZSeDhSTDV0beaq+xuTNp/1GpEn+Do4tvilyRY7gjqLrGqMx
	 GfBOA5bNK2sbg8xJtPHZWE4Czcp+b+L/BkIQ7Cf6F4x7yAyEjA2zdNmJr5nsoDx+qkSat
	 AsEvIdT9SH6z/k5MiornF59jpxr/+J6oL40h9+AxH9JzUr1wHgPSOQW1pojYRFJdPF3l0
	 eahSErr//j5Aeia7UoKYDsfuHQOr1g3XX4SQZZGkrI/WBAHVFDarQ3bVE6dn0vmrxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an8TKsCx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28556606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an8TKsCx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E681F01828;
	Wed, 28 Oct 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196812;
	bh=cB7rYoNo0LqZe8zAkmS4kIYgrBoAJBjqJBOLwdbnCZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=an8TKsCxohXQsfZptlP0O2cRqZRATWhX9x0gIGeyH1ywVhNryi3KA9ZK3C5SjW4qb
	 8GfyWOQdvk4QAtp85QKD9c476fl00aUefZBc6a6MEGT/jpRk9qGJuznLX0YQBzQ9/C
	 /ArbUV058DnUQzSglL5pCU3vyWCHvJ+zve7HpvoT7q8XYxJga5DtQDhlA34dRqECt3
	 0SxS0A6wrfpT3b6tM+Tl+fTBKVZuggYyEOVzROArMGokecu3APdg4FdxqJ7tewVw7W
	 LH0Qb4CuWe7Zk9YT8JgztijmWB/zatec8u1ytPLSKe3GxflBwYXtmv/sQb6eDdfA6S
	 xcSfsOwoNqaYQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	AutonomousCodeSecurity@microsoft.com,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net 1/2] net: gro: do not undo remote checksum offload on merged packets
Date: Wed, 28 Oct 2026 15:13:24 +0100
Message-ID: <20261028141325.2103814-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141325.2103814-1-edumazet@kernel.org>
References: <20261028141325.2103814-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_gro_flush_final_remcsum() calls skb_gro_remcsum_cleanup() to undo
the checksum adjustment done by skb_gro_remcsum_process() when the
packet was not consumed by GRO.

When the inner handler merged the packet (NAPI_GRO_CB(skb)->same_flow
is set), skb->data might have been moved past the headers:

- skb_gro_receive() uses __skb_pull(skb, offset) before adding the skb
  to the frag_list of the held packet.

- skb_gro_receive_list() uses skb_pull(skb, skb_gro_offset(skb)).

grc->offset is relative to the original skb->data, so the 2-byte
read-modify-write done by skb_gro_remcsum_cleanup() can land in
the payload of a packet which now belongs to the GRO packet.
pskb_may_pull() can also be called on this frag_list member.

With fraglist GRO, this can also be a use-after-free:
pskb_may_pull(skb, skb_gro_offset(skb)) in skb_gro_receive_list()
or udp_gro_receive_segment() releases the first page fragment if it
only contains headers. NAPI_GRO_CB(skb)->frag0 and frag0_len are not
updated, so skb_gro_remcsum_cleanup() takes the fast path and writes
through frag0 into a page the skb no longer holds a reference on.
The non merged case, where frag0 is used after this pull, is handled
in the following patch.

Headers of a merged skb are not used anymore: the skb is either freed,
or its headers are rebuilt from the head skb in skb_segment() or
skb_segment_list(). Skip the cleanup in this case.

This affects VXLAN and GUE with remote checksum offload enabled.

Fixes: 26c4f7da3e41 ("net: Fix remcsum in GRO path to not change packet")
Tested-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 2300b6da05b2728ec40f42228f8fa9c195d8479c..b560e866683b03314b3e80a887ac4467d1a5acb9 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -351,7 +351,10 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	void *ptr;
 	size_t plen = grc->offset + sizeof(u16);
 
-	if (!grc->delta)
+	/* Once merged, skb->data was moved past the headers, and
+	 * the headers of this skb will not be used anymore.
+	 */
+	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
 		return;
 
 	ptr = skb_gro_header(skb, plen, grc->offset);
-- 
2.53.0

