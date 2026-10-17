Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988173C9EF6
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233754; cv=none; b=o816UQWMHQKd8Ul1POOXAn+dGR449N91rTI/Q2iCNcbKZqyGN5AOTBBrtWdl+YxCGEgPHxMnvDv5iIFiXlB82NoGaV5hUbyw/TryZOVx2tQI1aubn/Gj4HVZhU8mNmoDpB/ZqMS0w4Kuw3WhrrS03OlFmmv5qIDl/Qw/Zmi8l0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233754; c=relaxed/simple;
	bh=sfCwJjD+s4NP+ARvNmfLGDhpLIDDa66YO7c4mUqTLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6ZtgbHx/9V5o1JN+YuyPc8CndG5LzH31lJeqXfoaTu2xQ6SN54vwuLIotXlai5kkCJEfSV1L5S2EpIjhL+XaAa8W4pRI7fdMVJHsomc7TGnujzR6y071E6c5mh+czuBIY2rCUwHbjuxZlaiPf/0lNhPvzZn9GOVbKseYBf7n6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp7va0eC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp7va0eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323DD1F000C4;
	Sat, 17 Oct 2026 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792233753;
	bh=OOPCWh6WUJxWnAEoeevpek1Xb0Wqo2+eLx3UhWC2zc8=;
	h=From:To:Cc:Subject:Date;
	b=mp7va0eCz0KzafsUX+uL6rT8Lvbh7fCfMCoIOmeDBYVczE6ByDJDbd6FfeAeNwqx3
	 qCVYSiYYUftYidebJf6j9cZkh6crm86GB1e3Ywhakb66hk9xAVThxY661GgL5WzYtt
	 aYMftlaPNCQQguNzQuE7f7SmEUCbzNbhNR5GqQRKvLSso4pI0QUlA3VT06UhzTfTCh
	 w7dtY+T4wEoHLn5E19X8RX3YGtpm91vvzRDLxs2wq92KO7Un7Sw794XN28oWW547hI
	 alvvBwd1hSF8ZjibAJS7h21oP7HJ6ZNq59957jXPL4kQv02i3raTMGBipQ5Wgxjjyq
	 gIyoBlZvo5WOQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
Date: Sat, 17 Oct 2026 12:42:28 +0200
Message-ID: <20261017104228.3418775-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_vif_xmit() hands the skb to ip6mr_cache_report() as an
MRT6MSG_WHOLEPKT report. skb_realloc_headroom() copies skb->cb[]
into the report, which is queued to the mroute socket, where
rawv6_recvmsg() reads it as IP6CB.

By the time the pim6reg device transmits the packet, skb->cb[] is
not IP6CB anymore: qdisc_pkt_len_init() overwrites iif and ra,
and any qdisc installed on the device (fq, fq_codel, pie, cake...)
or a tc BPF program writing skb->cb[] fills the area holding
dst0, srcrt, dst1, lastopt and flags.

Since commit dd433671fef3 ("ipv6: validate extension header length
before copying to cmsg") these stale offsets can no longer cause
out-of-bounds reads, but the mroute socket can still receive bogus
IPV6_PKTINFO ifindex and extension header ancillary data.

Clear IP6CB before building the report. The skb is freed right
after, so nothing else depends on its control block.

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv6/ip6mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 36f117ad367081444a96b5486add69bd7dcaff1f..3a551be30f153ae37c49bfa3c4777ae66f729a43 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -653,6 +653,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	DEV_STATS_INC(dev, tx_packets);
 
+	/* skb->cb[] holds qdisc/tc state at this point, not IP6CB.
+	 * ip6mr_cache_report() copies it to the report delivered to
+	 * the mroute socket, where it is read as IP6CB.
+	 */
+	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+
 	ip6mr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
 			   MRT6MSG_WHOLEPKT);
 	rcu_read_unlock();
-- 
2.53.0

