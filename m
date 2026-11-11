Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392864;
	b=xseFiCcz/GgpKoKnE4RjSMnxJ/wj1EWWQyTwF6pwWKp3gUQNkNlltDHcO1r7OswUdyM+
	 NrdlVqnzgiamX1nvrzOSR2JZ8uYM6ZVHtbhMuiUaDaLzToDnIK7KFF4zXeS3eYJpS3NbJ
	 AhOAaUIRlQYj/dEiIOAZwIHBD1g26tZNY8IxLuqUBr+xxOG+SrzFHk5JBjchPJpk++d7l
	 UYx/KEMI2sZacAqyZNbsF3aCbVZQ+iJZZPkE3fnpE8gm2fxS/WDHPY0mk6LDSjeKby2s9
	 R44id0RRjAu9G+RDsiEqxD3rD/vaF6c/VO51ncU2nDiotYcKoeDh4fy5P7g30LU/9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392864;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=061AyPVq+UbNcTTu8ui/UjYhadGaINZY0Wyh6TQdlnA=;
	b=3GFY6+gzIIRN0lB40HWlrxZjRX9gRi+eYZvvcCLGf1MTdZex8lS0r8ADpVmcJuFWIZpt
	 ViInO8GJjT0CNCkfVcFFkieeIOUWCSutxdY8Ji3Pb98d9wvgCY6C1Qs7jbGO9sILHXPTf
	 4Zw4JDtwdSDV7gkSwPHRbshtGINzNvTK2FowrU4v9e0qur3K1KV83A1yBq6XCJY0DB1xo
	 BkgGz8PvfyhkEFJy+03kkBO6/tUXwC7YevignV4YpjCOW3R+usEtn9y181loSreHtk2/i
	 OfrmGR53spWLtKZJK0RIQCycLXafjCcjUnmIHWpsA/7S/OKilbUBkd8xCnw/MeZCe8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DESMkFGZ;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0A91360A2610
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A91360A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DESMkFGZ
Received: from kero.packetmixer.de (p200300c59740deD843Be7e4A980e9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4EBA7FA2F2;
	Wed, 11 Nov 2026 11:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=061AyPVq+UbNcTTu8ui/UjYhadGaINZY0Wyh6TQdlnA=;
	b=DESMkFGZkfmDTZFvXolYreqs8euou2Bvhr3RZ+PyFs6D1Ek951LUVo+uSQ1O+xO7q+VDst
	w1SRZ+JVhnLe0iwCxDCbE+WLTf+fia2EW8CdkoqExdePmvAhA+bu1msnSSXTdWn866w14e
	/i8+iz8hoHfy2p2/dwKBDVKSUr5Xf5cJcW7JV7jyjY5NofCS5Nbnrj6ZxUsVk0d6e+QkBb
	I1dZZ+Jq+vDWqAotrVv34QNmgMp+RikL5LPYvwE9Ji9FFqzz9BnhpPDA96j790U478j4mH
	AQCd58O8fb21wC4HvCVjPFHHFJ3VWUY805oc1T0G1oDrIp0Rf3sXjhd2HBwbrg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 15/15] batman-adv: mcast: document the value stored in is_routable
Date: Wed, 11 Nov 2026 11:27:29 +0100
Message-ID: <20261111102729.2096241-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

The kerneldoc of is_routable says it indicates whether the destination is
routable, which reads like a boolean. But it actually holds the
protocol of the routable destination (ETH_P_IP or ETH_P_IPV6) or 0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c      | 16 ++++++++++------
 net/batman-adv/multicast_forw.c |  9 ++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 0446324c64e85..1e086a6385261 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -984,7 +984,7 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores ETH_P_IP when destination is routable
  *
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1052,7 +1052,7 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores ETH_P_IPV6 when destination is routable
  *
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1094,7 +1094,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores the protocol (ETH_P_IP or ETH_P_IPV6) if the destination
+ *  is routable
  *
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
@@ -1180,7 +1181,8 @@ static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet need to be sent to
  *
  * For a multicast packet with multiple destination originators, checks which
@@ -1224,7 +1226,8 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores the protocol (ETH_P_IP or ETH_P_IPV6) if the destination
+ *  is routable
  *
  * Return: The forwarding mode as enum batadv_forw_mode.
  */
@@ -1554,7 +1557,8 @@ batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Sends copies of a frame with multicast destination to any node that signaled
  * interest in it, that is either via the translation table or the according
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 8700f92b9bb0f..0120d1ea30acf 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -477,7 +477,8 @@ batadv_mcast_forw_push_adjust_padding(struct sk_buff *skb, int *count,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  * @tvlv_len: stores the amount of currently pushed TVLV bytes
  *
@@ -569,7 +570,8 @@ static int batadv_mcast_forw_push_tracker(struct sk_buff *skb, int num_dests,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the tracker TVLV onto
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  * @tvlv_len: stores the amount of currently pushed TVLV bytes
  *
@@ -1123,7 +1125,8 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to encapsulate and send
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  *
  * Encapsulates the given multicast packet in a batman-adv multicast packet.
-- 
2.47.3

