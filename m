Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A084CCDEB;
	Wed, 23 Sep 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164967; cv=none; b=FXd67OqQ0+1hWfyAAwruybBO+CcO4Cr/KhbMCAdkiuq/Q6irajKzvsNLEyfWHIWKIu4aVcnNGQh/fXXDOICR9EL6kQXkXrI7N0W7r7jrMPUjSKcfrzQf41SOUbKmc0ifDxvzRF/BmiWJRP6e0YBpdLcSiiI0TETykmk/tXJgJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164967; c=relaxed/simple;
	bh=Tjz6WacIRMWzXb0FO4mz/4dyBfn5AlLTlVpLxjQQOIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPZAuK/385K2CV4SkBeZTCuZnCs7eOxistyOOctOMtXFWZyqcHft8VGQhDNAgH+de/vnXJgbT4dKHWpifwBAl6H44s59gXSfz5DEBXcBQ4f4S1ricHqGMjH7xZYA3vkWdg17VB2RAt7Hh6ydvDUgUfN3Ls0YJMCAqDsFu1yyBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 91B6342AEC;
	Wed, 23 Sep 2026 14:02:34 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: ipv6: seg6: report lwtunnel setup errors via extack
Date: Wed, 23 Sep 2026 14:02:04 +0200
Message-ID: <20260923120228.172643-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790164953658

seg6_build_state() rejected invalid configurations with a generic -EINVAL,
so "ip route add ... encap seg6 ..." always reported "Invalid argument".

Attach an extack message to each of them. The checks themselves and their
return values are unchanged.

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
 * format fix
 * use NL_SET_ERR_MSG_ATTR

v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
 * dropped tests

 net/ipv6/seg6_iptunnel.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..9f1aecc4f215 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -756,8 +756,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	struct seg6_lwt *slwt;
 	int err;
 
-	if (family != AF_INET && family != AF_INET6)
+	if (family != AF_INET && family != AF_INET6) {
+		NL_SET_ERR_MSG(extack,
+			       "unsupported address family for SRv6 encapsulation");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, SEG6_IPTUNNEL_MAX, nla,
 					  seg6_iptunnel_policy, extack);
@@ -765,8 +768,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[SEG6_IPTUNNEL_SRH])
+	if (!tb[SEG6_IPTUNNEL_SRH]) {
+		NL_SET_ERR_MSG_ATTR(extack, nla, "missing SRv6 SRH attribute");
 		return -EINVAL;
+	}
 
 	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
 	tuninfo_len = nla_len(tb[SEG6_IPTUNNEL_SRH]);
@@ -776,13 +781,18 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	 */
 	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
 		   sizeof(struct in6_addr);
-	if (tuninfo_len < min_size)
+	if (tuninfo_len < min_size) {
+		NL_SET_ERR_MSG(extack, "truncated SRv6 SRH attribute");
 		return -EINVAL;
+	}
 
 	switch (tuninfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
-		if (family != AF_INET6)
+		if (family != AF_INET6) {
+			NL_SET_ERR_MSG(extack,
+				       "inline mode requires an IPv6 route");
 			return -EINVAL;
+		}
 
 		if (tb[SEG6_IPTUNNEL_SRC]) {
 			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
@@ -798,12 +808,16 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	case SEG6_IPTUN_MODE_L2ENCAP_RED:
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "invalid SRv6 encapsulation mode");
 		return -EINVAL;
 	}
 
 	/* verify that SRH is consistent */
-	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
+	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
+			       false)) {
+		NL_SET_ERR_MSG(extack, "invalid SRv6 segment routing header");
 		return -EINVAL;
+	}
 
 	newts = lwtunnel_state_alloc(tuninfo_len + sizeof(*slwt));
 	if (!newts)
-- 
2.47.3


