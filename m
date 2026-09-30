Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D328CF4A;
	Wed, 30 Sep 2026 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781539; cv=none; b=BvYXHmUu6qfQ6fLKW/CMriQKJsguef8ErXmo447p4+WQRJQxCq0xOANb7N6cLuebKnd8JTVX3OTqlqqqlkwYk2ba5s/gr12TazhoCBDAdfe+YYFAXV63u5r8JEGAt1/hsmEAhh1AkNhaY7qD6W7/aqdqMmmAVy4cvnvkD0Lhb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781539; c=relaxed/simple;
	bh=lUXDcOT/XwJMsHVoxeCZb+FRbrTQRd67zAroXHMYzvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a966NLb/IKxLqTvwv2b/ZYJnvUfqA5Um7KtJ2j3GYir+tunVH3f89yfgeZBNMIyW+q+Jz0T3OdCAZDlZatqkvCRgu1KJTD5yO+N9srxj7PEn5+L4ePiUJd7yfkRMr/PwDd97kctzy5JpsaqMyLEhpo7QRxsYsPLa7U6VcMyc9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=NX4cvaht; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="NX4cvaht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NX4cvahtQBFW2cfPvwirxCpg9ltG8a4nJ1U3f+A+UJhadtw/i3ej4S8/jW+NVerpwnt/FNAn4L6Gg
	 16ggFjpzZkdTzftd8jislxGG6qoWvpamHmCgFRqBvzOYibN805noaAszqhC9Ml2ZtsCtvwKQCKs4mA
	 uPKiRcKQmvrPvOkg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36abd27950e7-5a764;
	Wed, 30 Sep 2026 23:15:37 +0800 (CST)
X-RM-TRANSID:2ee36abd27950e7-5a764
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86abd2783ebf-02a53;
	Wed, 30 Sep 2026 23:15:37 +0800 (CST)
X-RM-TRANSID:2ee86abd2783ebf-02a53
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 1/2] pfcp: fix metadata_dst leak in pfcp_encap_recv()
Date: Wed, 30 Sep 2026 20:48:17 +0800
Message-ID: <20260930124818.114224-2-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
References: <20260930124818.114224-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfcp_encap_recv() allocates tun_dst with udp_tun_rx_dst() but only
attaches it to the skb after iptunnel_pull_header() has succeeded.
When iptunnel_pull_header() fails, the code jumps to the drop label,
which frees the skb but not tun_dst, so the metadata_dst is leaked.

iptunnel_pull_header() can fail for a GSO skb that is cloned, when
skb_unclone() cannot allocate a new header with GFP_ATOMIC.

The dst cannot simply be attached earlier, since skb_scrub_packet() in
iptunnel_pull_header() drops it for cross-netns devices. Release it
explicitly on the error paths instead. The !md check can never be true,
but route it through the same label for consistency.

Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/pfcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index e1cca779d2ec..1d14baf27c64 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -74,7 +74,7 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 	if (unlikely(!md))
-		goto drop;
+		goto drop_dst;
 
 	if (unparsed->flags & PFCP_SEID_FLAG)
 		pfcp_session_recv(pfcp, skb, md);
@@ -87,7 +87,7 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(iptunnel_pull_header(skb, PFCP_HLEN, skb->protocol,
 					  !net_eq(sock_net(sk),
 					  dev_net(pfcp->dev)))))
-		goto drop;
+		goto drop_dst;
 
 	skb_dst_set(skb, (struct dst_entry *)tun_dst);
 
@@ -98,6 +98,8 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	gro_cells_receive(&pfcp->gro_cells, skb);
 
 	return 0;
+drop_dst:
+	dst_release(&tun_dst->dst);
 drop:
 	kfree_skb(skb);
 	return 0;
-- 
2.43.0



