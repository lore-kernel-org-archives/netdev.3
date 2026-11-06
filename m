Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994700;
	b=OGWwRggOpxSXarQkwD+SMb2mC/TjHTmzbYNocgshpi3ucqfhAtXtttp72i7n1kUd1xY/
	 IFviE12imwtw86EGhgik5jwsIgu5Ij4iwxCcAuM94pT3/jphT/bW1zMDZqZbVC0HVeZil
	 Zagv0bqaKY+xZX5p1tR6bORxxZjrF35bSJNbfw2HLqn5ns3GfNljd9jtTZ8GgI+GbLSbo
	 DMnFg0ISbDa09x82i6/fQEDxg+AMirEAWGcapvd4c6CeYRvygueGeZdheitB9l3QUwjB4
	 5Kh3k59mILc8BYIm3VaCZNaFMopx8I3dm2kxP+m3qvu54ChGLmbqkfelD+sYb7/styw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RDKsoNr2jJ1IMKU8z1NYqPXUJQ7ll2AvH1O+SQHtBh4=;
	b=fB9tlg+P56CrdwByPRnGCs+gt6HVrV2kzjW4Yse3S4xwWj6B2BaWVzvR/wDBkSQu3yrI
	 pv5uLalURO2Mh4i4onwME/LI7n6bXc1yM4JZ1+bwThIEoC6QKepyAzlOP1/GbGAOrMhCY
	 PSiSLjWRIG6z+6hjXj75JJ7mOrkavALNKRbWHbvmtqNHa6x9sGuS/FCfAazJ88uCQ9dtS
	 wUeq+uwP1jWCYh7qJhfijTS71wg6d7hw4CUgGjI8oswFl4gGr463SilT46K1MPoMj+rQ/
	 pXr5rkd0ixeLhfafDdv6/yJ7nldZGsNAPhOmAD3/KRRl48n/yrryGqL8hSzxzpKV/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf8ezrG+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F16606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf8ezrG+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C051F008A4;
	Fri,  6 Nov 2026 19:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994700;
	bh=RDKsoNr2jJ1IMKU8z1NYqPXUJQ7ll2AvH1O+SQHtBh4=;
	h=From:To:Cc:Subject:Date;
	b=Vf8ezrG+u1nx4JuHzfyKNxU4FpRYa1EoH+nr+NZvdNnQzS5ugDhzJ/tpQyBINxR4N
	 MKYhLBwDHYunS6tVkxL5PD3Q9tYFolJCeZYGjPBRoNH/RxACOUF8ze2GoaOrIo9Ysl
	 f7Uah+xiA6jK/14O6tpP95cz9yufJXK26oprqBy/HpZbV2aEAEf29AJi9fsW9diMYh
	 NShLakFgB2yJKseqlw5XlqLRa82rJ6i0+GUcbth3oqVyv6u0DfkwnykMmaFmytyDl1
	 tv6o7AUtMSsBnldTmDX4dbJIrhumFJHxTrsnAU+5qN/Oz+byswtGIgW6u3yhOkkuAW
	 sJbPXnXqRheTA==
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
Subject: [PATCH net] net: gro: compare skb->protocol in gro_list_prepare()
Date: Fri,  6 Nov 2026 20:51:36 +0100
Message-ID: <20261106195136.2496777-1-edumazet@kernel.org>
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

gro_list_prepare() checks whether a held packet may belong to the same
flow as the incoming one by comparing the device, VLAN tag, metadata
and the link-layer header, using dev->hard_header_len as its length.

On devices without a link-layer header (hard_header_len == 0), such as
L3 GRE tunnels, no compared byte carries the outer protocol:
skb->protocol comes from the tunnel header. Packets of different
protocols can then stay eligible, and the GRO handler selected from the
incoming skb->protocol parses the held packet with the wrong layout.

For example, take an IPv4/UDP packet held by UDP GRO and a
VLAN/IPv4/TCP packet received on the same ipgre device.
vlan_gro_receive() reads the first four bytes of the held IPv4 header
as a VLAN header. With crafted values, the held packet survives up to
tcp_gro_receive(), which uses its UDP header as a TCP header. With a
short linear part, the FIN/PSH update of the held packet's TCP flags
can then write into skb_shared_info.

Nested GRO handlers (VLAN, GRE, IPv4, IPv6) already compare their own
next-protocol field. Only the outermost protocol was not checked.

Compare skb->protocol too. On Ethernet devices this is redundant with
compare_ether_header(), but it is cheap.

Fixes: 60769a5dcd87 ("ipv4: gre: add GRO capability")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumaze <edumazet@kernel.org>
---
This issue was discovered by an AI code review agent. It has not been
triggered, and the fix was only compile-tested.

 net/core/gro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20db6b8b996179f0b81e38393d3864a..08e4731ddb7e6e371790d70a97db2cedad420706 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -374,6 +374,7 @@ static void gro_list_prepare(const struct list_head *head,
 		}
 
 		diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
+		diffs |= p->protocol != skb->protocol;
 		diffs |= p->vlan_all ^ skb->vlan_all;
 		diffs |= skb_metadata_differs(p, skb);
 		if (maclen == ETH_HLEN)
-- 
2.53.0

