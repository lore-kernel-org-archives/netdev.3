Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91E14B977;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312429; cv=none; b=ANn7oa2MnbpF8OOC4zJbFsEPpnG5hiwgTmRkR2KEXN0NnLEzZG75uVwwi708P5uEMybbm6EWGcpgUJQg+Nvad6kLWLYqu0dSucn3TtIdTO2RooP5MZCgLagqSShiiTylJbbrEAlXM4XKIzyK4fgmyzr9odi8vn8up1oM6JmEoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312429; c=relaxed/simple;
	bh=xqvLGOrD9aa91Zl769RqlD9sMMWqwEf0J95RruWMGUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EwR08kD0nQjhOWW3XlI8eH8l773O3cPdF7jWXgZHZHCa5jlT3e4W0FTD8rmw2+2ePQLeONQG4N5S83/ZNQuX87poZnmJOZqaLX5zqx67cJEMSQcHh7HacyE2oZH6/pRepy0m6+12tV5LLddBov9gzeATt4i7pieY3f5KLzROVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEhmQbvP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEhmQbvP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49368C2BCC7;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781312429;
	bh=xqvLGOrD9aa91Zl769RqlD9sMMWqwEf0J95RruWMGUw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pEhmQbvPyM8Hs77KWQwrAZWlcn3Q/RsboB4o/jROnYTPQgamJFF51Xb2rKTPTrgti
	 fnl0yNGW/z83aUPF5o8L7SefhN3E3wh2ang4rkPox3ZVsaqRBXxo1IqCaAOKtGtoPU
	 khB9ajuT9N5FbO+UpHKYVjWfrI97fHeRdLKgNyV5KNEr+Pk/ZgCpysSTcWvwbuPdFb
	 /HL79qre6slhstg3UohA3d09gU171zn0zUxGmbeIE4HKkCB0n7yReGBEyetKkJrxaj
	 +nxruJuzyZI7++9lEcXcd0ahH9lvbqW5AEdEDgzVry0X+7/jD5gDnIQPsyUnsHjs64
	 71OeIbZYCoIOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E005CD98CF;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
From: Laika Price via B4 Relay <devnull+laikabcprice.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 02:00:25 +0100
Subject: [PATCH net] ip_tunnel: drop stale dst from generated PMTU ICMP
 replies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-master-v1-1-df796e8e2d74@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqAMAxF0a1IxhbaCoG6FXFQa9QIfmhUBHHvV
 h0euO9dIBSZBMrsgkgHCy9zgskzCIOfe1LcJoPVFjWaQk1eNorKW+cMYuM0OkjxGqnj8zuq6t+
 yNyOF7V3DfT9ck/v8agAAAA==
X-Change-ID: 20260613-master-a299166b9069
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Laika Price <laikabcprice@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781312428; l=1673;
 i=laikabcprice@gmail.com; s=20260613; h=from:subject:message-id;
 bh=4DMd2b5yZeVwzvEhHqEHfg7CMqL/k52EB0m/TG6YOcw=;
 b=7amHt50uZ9UfatSs/+QnfsSKjejy7opjoU4KHdTOWwB+mXs1hRLzpmfmh5Q2+zIIoYNh6hLTo
 ejmz52W9TGyDwAdSZL0H09znmI/GeGLqCZfB8Zwhm9AoOKe/48S9uQH
X-Developer-Key: i=laikabcprice@gmail.com; a=ed25519;
 pk=mFSMw2odvyxt1H4QHAdwZVuwHduNzUMDKbWFOcwhDCg=
X-Endpoint-Received: by B4 Relay for laikabcprice@gmail.com/20260613 with
 auth_id=819
X-Original-From: Laika Price <laikabcprice@gmail.com>
Reply-To: laikabcprice@gmail.com

From: Laika Price <laikabcprice@gmail.com>

iptunnel_pmtud_build_icmp(...) and iptunnel_pmtud_build_icmpv6(...) take
in an sk_buff, modify it to create a PMTU ICMP error reply, and return it.
As part of these modifications, the source/destination ethernet and IP
addresses are swapped around which makes the sk_buff's current dst invalid.

If the stale dst is left, the packet can skip input routing and be
forwarded using the original output device. This was observed when sending
packets to a VXLAN over a WireGuard tunnel - the ICMP reply was generated
but it was sent over the VXLAN instead of to the WireGuard tunnel.

Drop the stale dst after building the PMTU reply so that the packet is
routed using its new headers when it is reinjected.

Signed-off-by: Laika Price <laikabcprice@gmail.com>
---
 net/ipv4/ip_tunnel_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3c677e9b..949150e43 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -267,6 +267,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
+	skb_dst_drop(skb);
 
 	return skb->len;
 }
@@ -370,6 +371,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
+	skb_dst_drop(skb);
 
 	return skb->len;
 }

---
base-commit: 2a2974b5145cdf2f4db134be1a2157e9ca4a1cf0
change-id: 20260613-master-a299166b9069

Best regards,
--  
Laika Price <laikabcprice@gmail.com>


