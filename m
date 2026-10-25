Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926822;
	b=CBE5BsgWQxeafsjJyzP7wrt67v6ZYNFTElHTIi681oO6v7KFOzI2DvgaZqbmBUSF7Lt+
	 Owea4pLTN+S7gEpZBfo2lljXz2m6PyqAT9LxfqEWKKEJeg/owd41j0JZ5gEL+rKexxMRO
	 hyX4EHejJynUQGwRLt/eEtJWfkqN8GxYXt/2Vdlyk4p9dnha52a2jSLOaA+Y9LT/utaid
	 mDKZ8rvtKLFnY0izWhF6P7RAS8rEid5CWf8OPlBqnz6XCy5XDA3b9Tm9WpVIypZw+EaeL
	 LiVKJKHhpkwhHgRPAlHbnPIbnoNQrdl3Q1NXhR7NOyMqarT4RG1OREDb5PRBdgVDhjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UsLZ2MHhec0zf71UAfPUq5r6bhNgmo6XijO9NYAMMx4=;
	b=cg/ogk/YOWaS1llNe+eP7gtOsbUkB5wB+m2wyciY/T5QvdEk7jx/qMsVWVATMefn3Dve
	 cNeoXtvwX3BAFjhVBKGKt3VoV6j8yPUgsVmkgCU3hRFkdMm1Bhju5lAM7qzqzE2pB8A/p
	 s9UlEwA1L2VUf3sTok/3bKfuv/lPo54kodA/xiVWMntsU/69Of4IgCT5VMv5SgZbNAbn4
	 4cig4wo+CM426SXIZsmwBOQCp/Mj+sbW2Wfslx9IqbDjndENw72X0tJa4U92U1mRcG8wm
	 gGyQw3yRUYcZ3Rt9Zqic9Kp7x1h0n8t+ac5S8JBttggdvCA4B+KV/9xvg7eEMC4jxbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oo9l+/Q8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468A606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oo9l+/Q8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DA41F01825;
	Sun, 25 Oct 2026 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792926822;
	bh=UsLZ2MHhec0zf71UAfPUq5r6bhNgmo6XijO9NYAMMx4=;
	h=From:To:Cc:Subject:Date;
	b=Oo9l+/Q8uTfJApCbWWklJMrX0FMPUGghEbzZYoBtcBiM3AjK+szDVycxu9sCtVBJE
	 9ambDvW9+cDS/PES/26/3rknguV73mXiSndy1uky1H0IpKe8iiRQTCeuqchKglKBI5
	 4aVi9INR5zC/wBGD1IUM2SK87GVG/vvOfYvagbHh7BYLm/HHdveev3pav1HSklXt6u
	 Q/TW+Gjf/+igH04s+lJNBVnz9APnegR3GRdtemDh1kRV9Ei0untPCf+j6fX+v8t6uL
	 8t+LzyUSKbHdL6hPyPdjYikDsz1v3vji/IT3RJ5suydf2JL4GdfOVAelbQUb7uAV2J
	 JIsWpGQxQbjng==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] ipmr: clear skb->cb[] in reg_vif_xmit()
Date: Sun, 25 Oct 2026 12:13:37 +0100
Message-ID: <20261025111337.142787-1-edumazet@kernel.org>
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

reg_vif_xmit() hands the skb to ipmr_cache_report() as an
IGMPMSG_WHOLEPKT report. When the mroute socket has IP_PKTINFO
enabled, ipmr_cache_report() calls ipv4_pktinfo_prepare() on the
original skb, which reads skb->cb[] as IPCB.

By the time the pimreg device transmits the packet, skb->cb[] is not
IPCB anymore: qdisc_pkt_len_init() overwrites IPCB(skb)->iif with
qdisc_skb_cb(skb)->pkt_len, and any qdisc installed on the device or a
tc BPF program writing skb->cb[] fills the area holding the IP options
and IPCB(skb)->flags.

For locally generated packets routed out pimreg (they carry an rtable
dst), the mroute socket can therefore receive a bogus ipi_ifindex
(the packet length), and the l3mdev slave test in
ipv4_pktinfo_prepare() is driven by stale qdisc data.

Clear IPCB before building the report, as done for IPv6 in
commit 238164201431 ("ip6mr: clear skb->cb[] in reg_vif_xmit()").
The skb is freed right after, so nothing else depends on its control
block.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Issue has been discovered while reviewing Ido's series:
 https://lore.kernel.org/netdev/CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com/
No repro, but this is mirroring the fix we did in 238164201431 ("ip6mr: clear skb->cb[] in reg_vif_xmit()").

 net/ipv4/ipmr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index acacaae05cc49dc15910f23f7539865432518587..8b84142fd7754d95aa1f2facf68ac554916efd27 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -550,6 +550,11 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	DEV_STATS_INC(dev, tx_packets);
 
+	/* skb->cb[] holds qdisc/tc state at this point, not IPCB.
+	 * ipmr_cache_report() reads it as IPCB to build IP_PKTINFO.
+	 */
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
 	/* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
 	ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
 			  IGMPMSG_WHOLEPKT);
-- 
2.53.0

