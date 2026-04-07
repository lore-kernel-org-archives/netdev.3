Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B23019BA;
	Tue,  7 Apr 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551537; cv=none; b=WgqGtZJsWQagBgXVCoJFV5o3vgBJowKJMiMb244q9Qyrw+1I7QWjl8puucL236tE3WMXLa7ezEYHSTKl04UQPImO542p1tjJQ2AYWDao/kAda/e/OQsK37Rihqzb1H/rY5z6g29+aamz6v6aFgn2R4WOd7G6U92ceQrw/DPtfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551537; c=relaxed/simple;
	bh=oSSyq82gg4+z0T2Bj9hPcbh0EZYmNYhgRVeE/ZrjDi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1eLFEKYKj0kyihWZCsgAPDn9YLx/8kzATsGjkwiLHsG1ZTkPIjtn3HuI7OzOU6lHfKNbbYeWrknhgJ/ltepRGAbNyYeiHs30gAJATd+uUGsK0bWxqho9fQpiQDDdkhnrBtw6mi1ulpCRZEwxxPG/3leuvpNra2Tc/c6PnC15LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAOQQwad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAOQQwad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AADC2BCB2;
	Tue,  7 Apr 2026 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775551537;
	bh=oSSyq82gg4+z0T2Bj9hPcbh0EZYmNYhgRVeE/ZrjDi4=;
	h=From:To:Cc:Subject:Date:From;
	b=CAOQQwad7n78Z3lS8pJeYaz+je0pxVkDDESU3pH+mXwVFpuWfLBPbG0r3D6N4Ywa2
	 kcut2MBtiu4CaHYXnaWqlq3k0J688g86AEt15kBFaHU1fesFyAtpzdJe57T6WCnZ0F
	 /owDW0+jMLigAcxnVku7GdnJqvMadIf6dCgW/GOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-hams@vger.kernel.org,
	Yizhe Zhuang <yizhe@darknavy.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] netrom: do some basic forms of validation on incoming frames
Date: Tue,  7 Apr 2026 10:45:31 +0200
Message-ID: <2026040730-untagged-groin-bbb7@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=oSSyq82gg4+z0T2Bj9hPcbh0EZYmNYhgRVeE/ZrjDi4=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlXjmgd/PLvkeoUldTbvF8qOA4ceNG3eHPOfZ4k9tXKV 06Uf5h0uSOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAm4n2OYb7jye8bT0vt0JYI V2te8N8toGTJtj0M87RqP7o1thqJfqlMu7D71vcfuxwjJgEA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

There is a lack of much validation of frame size coming from a
netrom-based device.  While these devices are "trusted" doing some
sanity checks is good to at least keep the fuzzing tools happy when they
stumble across this ancient protocol and light up with a range of bug
reports.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: linux-hams@vger.kernel.org
Assisted-by: gregkh_clanker_2000
Reviewed-by: Yizhe Zhuang <yizhe@darknavy.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/af_netrom.c | 6 ++++++
 net/netrom/nr_route.c  | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index b816c56124ab..b605891bf86e 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -885,6 +885,9 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	 *	skb->data points to the netrom frame start
 	 */
 
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
+		return 0;
+
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
 
@@ -963,6 +966,9 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 
 	sk = nr_find_listener(dest);
 
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
+		return 0;
+
 	user = (ax25_address *)(skb->data + 21);
 
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9cc29ae85b06..bf60f5682a4f 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -755,10 +755,10 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	struct sk_buff *nskb, *oskb;
 
 	/*
-	 * Reject malformed packets early. Check that it contains at least 2
-	 * addresses and 1 byte more for Time-To-Live
+	 * Reject malformed packets early. Check that it contains at least
+	 * the network and transport headers (20 bytes).
 	 */
-	if (skb->len < 2 * sizeof(ax25_address) + 1)
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
 		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
-- 
2.53.0

