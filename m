Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392863;
	b=0hUT/BoomTA3VH+GovLFibfMVPZKgyGwFhQ8gzp2FZuYL5vkC0TVvcQGOF6rHEIm7Iv5
	 gYPuiPA5htAOJY3SDAr+Gu0c5f7MwiNS5NsYhVM0RlS7ugbJsvsvOhyHj2NdL1Xm3pwNS
	 V+tVKfwEKPZ0McrCWR7UE7xCZzh/TW02E6LhRKd2vU+DH/n/CPMcdpHCC417xhAO2fVO+
	 ldx2qHUDS2mQNtNidqjZKT4ItsPcwZ0hPweBjUXjppeA90g3FXqDZ0W6uBs/idMZrfTsr
	 INFf32MB2WzM5weZsb3rYV4gJkfObGimq8B7gwbwGjjF8D3RSLLpTDJ0fvP/jS4MM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392863;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZXY9RMei14Qa6qZcMDBzjNkR+zAn7SgX5Be6ZFMOjm8=;
	b=FJz6fpRXCx/hnNzYrXH8SL8KXMP1EqeBKFUSbMPO0cRsIy1ELn6ZlLUXtvvPwX9Dj/Yq
	 5C0gdjT7dfEoqGEkXTqJIY4yRSucTJnOO8DbDnqWpnH0BvKSyXlpG4Z/O5RFNTaZdwINS
	 fAbaUnIMS0ottwnAox14tFGBx6Z84wxCm8WVNNAKtT3IK1cPmWr7B2T3nSnYUpu5GE3ZQ
	 070WPrgmJINDGrgs9Aqeeev2CfVcDvOkF2MLhH+gg5LFMLj2E0WqaW3GdEFOniftlISBH
	 FxvwHcpXIfHFHtzGB1UD3bsd12r1UgmVxQSDJXP9Z6QZzeq7eXzSgXIaUbyFUHZsUVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=MZWbUqqY;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2970D606A8B0
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2970D606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=MZWbUqqY
Received: from kero.packetmixer.de (p200300C59740dEd843be7E4A980E9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4612BFA2EF;
	Wed, 11 Nov 2026 11:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXY9RMei14Qa6qZcMDBzjNkR+zAn7SgX5Be6ZFMOjm8=;
	b=MZWbUqqYR13QiKezBgP2r+m2jHP6XRE97evVzFSrx5IZlIkH10fDt01cZ6UcKUnQkg5Gv1
	ExcFwKRlpPsBdgGIfgreWdMWPA9Zj+0p1aUrL6p18YFrvZMIlWtJOmL1R56LNZTFux3vXX
	4xXog+NlCrLa68hbaAliL0mfpTMSicqLCOR12Vol8XY9DYI3b6vSEr5lKJzrAYvX0NZCDm
	dPmha3Cr7GcczHd5666ClwF6G6EMDqKIZzsAbO2vTXmdqxkUDcSbOEWd+rO+umZTQFUSkQ
	KPzBS9L4Kl5BZePIDAU4tlohUw3ECTC6TqUYFEi0/G3cA1F+lXSUmw20a0lmcg==
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
Subject: [PATCH net-next 12/15] batman-adv: use matching return types for bool and void functions
Date: Wed, 11 Nov 2026 11:27:26 +0100
Message-ID: <20261111102729.2096241-13-sw@simonwunderlich.de>
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

Some functions declare a different return type than the values they
actually return:

* batadv_mcast_forw_push_dests_list() is documented as returning
  true/false and only returns true/false, but was declared to return int
* the !CONFIG_BATMAN_ADV_DAT stub of batadv_dat_snoop_outgoing_arp_reply()
  returned bool, while the real function returns void
* the !CONFIG_BATMAN_ADV_MCAST stub of batadv_mcast_init() returned int,
  while the real function returns void

Make the declarations match.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 18 +++++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e7b75e82eb1d8..807178fd28c57 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -117,11 +117,10 @@ batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	return false;
 }
 
-static inline bool
+static inline void
 batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
-	return false;
 }
 
 static inline bool
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index d97ee51d26f2e..d46f3a25ba5f2 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -88,9 +88,8 @@ batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	return NET_XMIT_DROP;
 }
 
-static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
+static inline void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
-	return 0;
 }
 
 static inline int
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 9ffed1f237b6b..8700f92b9bb0f 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -187,13 +187,13 @@ static bool batadv_mcast_forw_push_dest(struct batadv_priv *bat_priv,
  *
  * Return: true on success, false otherwise.
  */
-static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
-					     struct sk_buff *skb,
-					     unsigned short vid,
-					     struct hlist_head *head,
-					     size_t entry_offset,
-					     unsigned short *num_dests,
-					     unsigned short *tvlv_len)
+static bool batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb,
+					      unsigned short vid,
+					      struct hlist_head *head,
+					      size_t entry_offset,
+					      unsigned short *num_dests,
+					      unsigned short *tvlv_len)
 {
 	struct batadv_orig_node *orig_node;
 	struct hlist_node *node;
@@ -278,7 +278,7 @@ static bool batadv_mcast_forw_push_want_all(struct batadv_priv *bat_priv,
 {
 	struct hlist_head *head = NULL;
 	size_t offset;
-	int ret;
+	bool ret;
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):
@@ -324,7 +324,7 @@ static bool batadv_mcast_forw_push_want_rtr(struct batadv_priv *bat_priv,
 {
 	struct hlist_head *head = NULL;
 	size_t offset;
-	int ret;
+	bool ret;
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):
-- 
2.47.3

