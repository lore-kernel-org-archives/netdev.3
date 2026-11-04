Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792136;
	b=V6iiJigrNmJxin2fccTQWQydWoi9EJxKX8hCaicg2k0P5xszAKhZvkT8NiywmvJkrPih
	 aKlOBauhkh+cwhnHtx6Kir4WNyuliT9bHtVMttUDyjSpe3QjTUNjo7cKzlkY/UaoPsNmZ
	 KKtLgTv6m+Yl7dFr7xat8HBSfA1T+Au4vGH4Tgt22nAgMzeQ5Ki2Bt/t0eXuu76mZfCcr
	 oq/xQVzerFdqXSCFt1Dn0Ct2N25jnjXIPh6hYSgiaUxku5+NbHFTARTqeFCaTdB7sW+sO
	 YqmO8ZZGsllFxbxzLXSKthkV907iIf4ukhyySQDaBIQU7A3KlGlRqB9ygOVog1hNKlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DiTNhjiby/N/S8aTfjpWGWUjlVo4gDdyQaJC/ra1gL8=;
	b=5Q5Ltuw1PfFv7Y9ol7eZtgNv8E8dIAiQdCGCKNuwc1MWG9g0jCHQ/q7jqCLMAa9kRur0
	 Tmu0COGStP/j+SQxf1TLEmRpb2Z2sIo47bmbUAsxzmrhfU62BFCdjgkgDU8JCjZ44kLWm
	 Fp4XWnQkPuGRiyDeBic3n22uetNkRxLiG+hFqjLFPyFk5Gh/95kr1vMV2l6oWAmxXkcMV
	 zVGza4BMf5/d4mzhykW0FiJqM/UgsTA6vMiuEZCLme3d+dLrSH8xhl2Z+tuxjlBx/xBJa
	 S923H2KiWQABfL7hHDTRCozvQl3F8/VB0kxrTfYzoCCTBooeNb2MJr34sr4DHOqFkdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afB2dfy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20576606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afB2dfy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC0B1F000C1;
	Wed,  4 Nov 2026 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792135;
	bh=DiTNhjiby/N/S8aTfjpWGWUjlVo4gDdyQaJC/ra1gL8=;
	h=From:To:Cc:Subject:Date;
	b=afB2dfy9O53QJjrcOv0Qvx3ebyGft7SHbLiPWo8PLZLcjzo3GoMaM4E+9vi+Dww3Q
	 49pLLRcnqFD916Kb8Ty03la5kr4fGQJiKXtXyUGK5nV8RVVzV+D5KMhO1VHZ0bHe0k
	 M5NnngZr6gyvmRnQ6d4Ti4iC4sAnqu57L7eLDwbcHrc7HaRhhIHkJKOhXHPIZuKphm
	 YYscFPMMeKSeawMgQtDFCFkEV7OiT7I6Ec9zf/MqJTNyHOqhtU/iJX0RI0S3gEBd3d
	 VNvBQL8VKAVR1jRkENgDJCAyF6zyRQpY/k6KQn9yn4YGaaxPCneSF4FPMWsJ3wXXo5
	 a+/nPx+VNM4/w==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] ipvlan: make outbound skb headers writable
Date: Wed,  4 Nov 2026 12:35:30 +0100
Message-ID: <20261104113530.986664-1-edumazet@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

In L3 and L3S modes, ipvlan_process_v4_outbound() and
ipvlan_process_v6_outbound() hand the skb to ip_local_out() and
ip6_local_out(). The IP output path assumes it owns the network header:
__ip_local_out() rewrites tot_len and the header checksum, and
transport-mode XFRM can memmove the network header into the headroom
when xfrm_skb_check_space() finds enough room, without copying.

The skb reaching ipvlan can have its header shared with another skb,
for example after an AF_PACKET tap on the ipvlan device or a tc mirred
mirror action. pskb_network_may_pull() only makes the header linear;
it does not unshare an already linear head. The writes above then
modify the other skb. If that skb is on the receive path and its IPv4
header was already validated, IPv4 option processing can use the
modified header, write past the linear data, and corrupt
skb_shared_info.

Use skb_cow_head() before taking header pointers and entering the local
IP output path, like ip_forward() does with skb_cow() before it touches
the header. Only checking skb_header_cloned() is enough here: skbs that
TCP transmits are clones of the write-queue skb, whose header area has
been released with __skb_header_release(). Their headers are private,
so they are not copied, which avoids a reallocation for every TCP
segment sent through an ipvlan slave.

If the allocation fails, the existing error accounting and drop paths
are used. L2 mode is unaffected.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: use skb_cow_head() instead of skb_unclone() to avoid
 copying every TCP segment, reword changelog]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/net/ipvlan/ipvlan_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 7ad12dc7845c836bdd04395f153b2b4b397797d6..d2afc2ec896e039d174e2b0ecfd4c9ff6634cfaa 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -438,7 +438,8 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 		.flowi4_mark = skb->mark,
 	};
 
-	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)) ||
+	    skb_cow_head(skb, 0))
 		goto err;
 
 	ip4h = ip_hdr(skb);
@@ -504,7 +505,8 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int err, ret = NET_XMIT_DROP;
 
-	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)) ||
+	    skb_cow_head(skb, 0)) {
 		DEV_STATS_INC(dev, tx_errors);
 		kfree_skb(skb);
 		return ret;
-- 
2.53.0

