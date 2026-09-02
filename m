Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0A476CCC;
	Wed,  2 Sep 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348266; cv=none; b=Mxg5Ac8libFstRL7YgmvOPjyIMKTviWoS5NZgNwxiMxQAfiMvfZLd7Fw/tf7oc+9h6HFNPdDqCCa4iboOjQqyfGFCHtrsba06JgoA6xM1YkMJy/0RCNlEKjNkfaGU0vCfTqwTXwia2OrO0CIsfIy+x9YMoDG0/PS29hGFGvQgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348266; c=relaxed/simple;
	bh=d3enSKxXZb1rG7gux2duaE/k3z2/PeR+urz+rPW91J4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CcB6kMJVSTLFXQ2h5Sr9EDNopQskfyOWhNHLvxPvb5SnOcq/+N6KryNZ2VTc2tLI4ob/pTgiQyJtVSgmirH/DZmQX+MYAeQBeKimF89ccGd5iK9eWsLbiy7KI4n7uWK9jSHG1fyQy1rCCz5gEP4krV0l6B43ptffrXPIhQqQcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x1j4X-000000004BY-2BB0;
	Wed, 02 Sep 2026 11:24:05 +0000
Date: Wed, 2 Sep 2026 12:24:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Antoine Tenart <atenart@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>, John Crispin <john@phrozen.org>,
	Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] vxlan: add IFLA_VXLAN_IGNORE_DF
Message-ID: <c8add19a594ca2724ad97205c9cf3af387a2d6db.1788347880.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A vxlan whose underlay cannot carry the encapsulated frame answers the
sender with a path MTU message and drops it. That is the right default,
but it leaves no way to extend a segment across an underlay that is
merely smaller: every host behind the tunnel then learns a path MTU that
the hosts beside it do not have, so once extended the resulting MTU can
be too small to carry any IPv6 at all (<1280).

It also fails outright where the path forwards whole datagrams but
discards IP fragments, which is common on carrier NAT. There the
fragmenting has to happen inside the encapsulation to survive, and the
tunnel refuses to do it.

Add IFLA_VXLAN_IGNORE_DF, off by default, mirroring IFLA_GRE_IGNORE_DF:
carry the frame and let IP fragment the outer packet rather than report
the path MTU and drop it.

On IPv4 this means never setting DF. On IPv6 there is no DF bit to
clear, and ip6_fragment() refuses a packet that is not from a local
socket unless skb->ignore_df is set, so set it there. Without that the
existing df attribute has no expression on IPv6 at all: an oversized
frame is dropped whatever it is set to.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++++++---
 include/net/vxlan.h            |  1 +
 include/uapi/linux/if_link.h   |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e..21cb7fbfb6e6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2510,7 +2510,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			if (err)
 				goto out_unlock;
 
-			if (vxlan->cfg.df == VXLAN_DF_SET) {
+			if (vxlan->cfg.ignore_df) {
+				df = 0;
+			} else if (vxlan->cfg.df == VXLAN_DF_SET) {
 				df = htons(IP_DF);
 			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
 				struct ethhdr *eth = eth_hdr(skb);
@@ -2526,7 +2528,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		ndst = &rt->dst;
-		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
+		err = vxlan->cfg.ignore_df ? 0 :
+		      skb_tunnel_check_pmtu(skb, ndst,
+					    vxlan_headroom(flags & VXLAN_F_GPE),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
 			goto tx_error;
@@ -2598,7 +2602,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				goto out_unlock;
 		}
 
-		err = skb_tunnel_check_pmtu(skb, ndst,
+		err = vxlan->cfg.ignore_df ? 0 :
+		      skb_tunnel_check_pmtu(skb, ndst,
 					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
@@ -2630,6 +2635,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
+		if (vxlan->cfg.ignore_df)
+			skb->ignore_df = 1;
+
 		udp_tunnel6_xmit_skb(ndst, sock6->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
@@ -3453,6 +3461,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_REMCSUM_NOPARTIAL]	= { .type = NLA_FLAG },
 	[IFLA_VXLAN_TTL_INHERIT]	= { .type = NLA_FLAG },
 	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
+	[IFLA_VXLAN_IGNORE_DF]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
@@ -4391,6 +4400,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	if (data[IFLA_VXLAN_DF])
 		conf->df = nla_get_u8(data[IFLA_VXLAN_DF]);
 
+	if (data[IFLA_VXLAN_IGNORE_DF])
+		conf->ignore_df = nla_get_u8(data[IFLA_VXLAN_IGNORE_DF]);
+
 	if (data[IFLA_VXLAN_VNIFILTER]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_VNIFILTER,
 				    VXLAN_F_VNIFILTER, changelink, false,
@@ -4547,6 +4559,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TTL_INHERIT */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
+		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_IGNORE_DF */
 		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
 		nla_total_size(sizeof(__u32)) +  /* IFLA_VXLAN_LABEL_POLICY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
@@ -4623,6 +4636,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
 	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
+	    nla_put_u8(skb, IFLA_VXLAN_IGNORE_DF, vxlan->cfg.ignore_df) ||
 	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
 	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7b8207505523..85690b817e0e 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -228,6 +228,7 @@ struct vxlan_config {
 	unsigned int			addrmax;
 	bool				no_share;
 	enum ifla_vxlan_df		df;
+	bool				ignore_df;
 	struct vxlanhdr			reserved_bits;
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43cecca49f01..5a2d3a92941a 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1463,6 +1463,7 @@ enum {
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
 	IFLA_VXLAN_MC_ROUTE,
+	IFLA_VXLAN_IGNORE_DF,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.55.0
