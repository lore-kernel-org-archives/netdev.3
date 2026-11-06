Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994980;
	b=H2aa038RMAq4IFa0vXgAYl5+EJP3Wrt8QQftuQAT6iVUWMltbsimjyXm7a860fLMcMxF
	 dl3og/CIBGq6H68Kr1ReCo57P3VLPmXZpmkZFB2/GloUBYidFk3jK8/Jrwz3938J5S42R
	 EjEpleqpA71uPzbA3VWCFf+rVQxpfGh0BcjWkC9Dss7Db/Eq5QEAXH4ytKX3dxzbJcVLg
	 sBLv+CNkp/H9SY2GhnQ7TWSYs4k1e4w62+UY3V+ZVK0xTB0lJZphvdt6H1frVHaclrRli
	 zkweS+zFkihoAzH5VsckayLKERL6MKV3900MZzfRDf2xd0gRYGm3B4YYdEduJJH1GQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cKC44C2FREKnmCaYP9Z7jZKScgRafwsnBCvLqvPRQTQ=;
	b=1Gl6XUkVjPGlcMazSeJo5jYWT6+AihnaSQz421wv3fTSHkMjvzRpWe6biLgNNdgW/JxH
	 zsc46VwwkRLHFhFpcHgndiQWm0CCrdNkgfk1h+fcY1hdb+/5i4ZC9EtZ0qPdltLZ09eXM
	 JsgTsjVPYzT4d06zY5NxW5wUTZ9DS8s61R1vUIxHvocZ13KHMEYJptKjsF+m1AXlVB7Vt
	 GY95Dg0LWLTFTQegn4jae9MbTBWVFXZt5VsT697KvnXlkApM9uvE7wdm1/UqQ34lHVQfw
	 nZmRKFLYOkTO/SSuLsrQgsn44vQgToMrjk9do4PNiq1MldvlI/+8xv7kbZCsCVP6axg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L5cf5ON/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F50606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5cf5ON/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D0A1F0089F;
	Fri,  6 Nov 2026 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994979;
	bh=cKC44C2FREKnmCaYP9Z7jZKScgRafwsnBCvLqvPRQTQ=;
	h=From:To:Cc:Subject:Date;
	b=L5cf5ON/L/AtairjU62knfXLMwOCOKoXNud6213wv3PMlY2KwgqPwXlbvkqScammN
	 G+iQClPz5fHqc1SpL2VaSsN6HsQ2QxYc3cOfJCXLywpNe0S90NkUsjEeBuUoX9ZfEf
	 5WwZCfbDryNRxLbDrragtiBPaeVYkEeHqFMRwMnobwzEScajypbDfsow/rBnLBXRNk
	 P+iHwTUKiglR/o6/tsSP9cvylQv5cln4gqFsdpfV9hUcU2rakFNMf8qGmBcHLOXoKi
	 Ow+m98uQamL9t1QCjNyHr68/vsjI6GeffRK8vbVxkAgNUGQ+Oe4S/IxZE6/fjELLRr
	 FoS71us8YOu6Q==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] fou: gue: check IP version of held packets for direct IP encapsulation
Date: Fri,  6 Nov 2026 20:56:15 +0100
Message-ID: <20261106195615.2498766-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

For GUE version 0, gue_gro_receive() compares the base GUE header and
its optional fields with every held packet. For GUE version 1 (direct
IP encapsulation), it skips this comparison and selects the next GRO
handler only from the IP version of the incoming packet.

A held version 0 GUE packet from the same outer flow therefore stays
eligible. For example, a GUE/IPv4/UDP packet can be aggregated with a
direct IPv4/TCP packet, and inet_gro_receive() then parses the held
packet's GUE header as an IPv4 header.

Clear same_flow for held packets whose first nibble does not match the
incoming IP version. A valid version 0 GUE header always has a first
nibble between 0 and 3, so this also separates the two GUE formats.
The reverse case is already handled: the version 0 path compares the
whole base GUE header, including the version bits.

Fixes: c1e48af7960e ("gue: Implement direction IP encapsulation")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
This issue was discovered by an AI code review agent. It has not been
triggered, and the fix was only compile-tested.

 net/ipv4/fou_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 076fdca44f518016e71ba0b3b68c45b3c0858663..5c3c8f55d0570424203e2b664a7b806c51d86dbf 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -364,6 +364,18 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 		default:
 			goto out;
 		}
+
+		/* Match the encapsulation format and IP version. */
+		list_for_each_entry(p, head, list) {
+			const struct iphdr *iph2;
+
+			if (!NAPI_GRO_CB(p)->same_flow)
+				continue;
+
+			iph2 = (const struct iphdr *)(p->data + off);
+			if (iph2->version != ((struct iphdr *)guehdr)->version)
+				NAPI_GRO_CB(p)->same_flow = 0;
+		}
 		goto next_proto;
 	default:
 		goto out;
-- 
2.53.0

