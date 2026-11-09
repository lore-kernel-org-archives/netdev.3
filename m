Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242756;
	b=0RHMYOKFz3Ge0oxKaQtv+nOuRvFStbLwpTYYS92yZfOYqYK2gQ28S5VasKgnSMkSJyEN
	 JiXFzeIMeMYgdP67VZdhBDHrMS5OU1CXG0mNwJRRYqW5Ajr2+5OkIsnnY+Mlv5Eek5m/Z
	 dYDEhYA1t3d/XBgf7ZXaCEtCuzjVATMqDA6BA/LDJdRS9GHqF03npfZ/5MJhTMYX0/Jah
	 JxpSHbinYHwtqlzkTxqMKgiCqD5cTUq57N5TKJ+L37MYXqfsoyJNr1qEW8MnQD6mkNzn/
	 7OCnEVzBstq+WM63m2l7SOfnPm5sOtF8j69EKmrA7wQwz8OwyV05iYrYl4lI3V6SfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242756;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=glHxRHGLGburtlVRhRiEZ8wZhPoTMq0AfgvHYwC5Rek=;
	b=XVyfPDbG1lYJG0gjbdXkBax6XBJl+uvzeNICCEBdM787f7Mqyf+3k88jrA5CSyF9b9GO
	 7MivGfjjLDQTRsLQ4YFvfI6PA7TEAlWASBWAEP9LJO5di8H1dvsEC/Ymozke3Now/psbN
	 Vy6Gd2I0uyFfwasp1mOz4jq8Cc2DQHr6jgmhePbRFEBxU6phhaC+ACPxry+I39om7y7rt
	 Mch2shtnfjjOtgVYGuLHZW/vnHUcS0ePVv1tHjCo0fqdPE+X09reGiWBAyBHnHuuf9OeW
	 e++UFa0s2Ey1i0eS8rvIo6AwMQNxYujwiUtauWMF8AkNVvRWhE1gXkgb3mf9gTE51bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Grw9ex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78614606EEA3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+Grw9ex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4179F1F008A1;
	Mon,  9 Nov 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242756;
	bh=glHxRHGLGburtlVRhRiEZ8wZhPoTMq0AfgvHYwC5Rek=;
	h=From:To:Cc:Subject:Date;
	b=k+Grw9exyxqBA5rlN5UUjPeFiBhPPqkbonQSHguvyJWXJrJCLbuwvakQmFZcZOMLy
	 svDgwG9RtFw5lxUL6gyitBTe2UQLa36mNieNbqJLZoungIYjTnMU+zB99EYlqeWAGG
	 0CKzVuKCPhMh2iozu3ANb/5NxSEdcu1iUP+S4l0+q2vHa+WUrxTDo6dmp1PJQRr8aE
	 PqS7dG+Tk2yqOifdSKH3e5brB/0Vk7x7gapMmW4uDfjBGkhBVIDHnfNPkUlDIVBD8V
	 PPHS8DFHeGZkSh1PuJcuzCjbXrwqVzR1Czo1eOmoN7Jp5CQBr97iJca/zoJD6JXRav
	 Py/JBRo+ncqbw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2 net] net: gro: compare skb->protocol in gro_list_prepare()
Date: Mon,  9 Nov 2026 17:45:40 +0100
Message-ID: <20261109164540.3104392-1-edumazet@kernel.org>
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

The VLAN, GRE, IPv4 and IPv6 GRO handlers compare the next-protocol
field of their own header, so once the outer protocol matches, the
inner layers are checked too. Only the outermost protocol was not
compared.

Compare skb->protocol too. On Ethernet devices this is redundant with
compare_ether_header(), but it is cheap.

GUE direct IP encapsulation has a similar issue, but there both packets
have the same outer protocol, so it is fixed separately in
gue_gro_receive().

Fixes: 60769a5dcd87 ("ipv4: gre: add GRO capability")
Reported-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2:
 - Fix Signed-off-by typo (Sashiko).
 - Mention that the GUE direct IP case is fixed separately (Sashiko).
 - Add Willem's Reviewed-by.
v1: https://lore.kernel.org/netdev/20261106195136.2496777-1-edumazet@kernel.org/

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

