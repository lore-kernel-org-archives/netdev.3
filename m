Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79148BD29;
	Mon,  5 Oct 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209209; cv=none; b=h3oGwPex1DLsnpqwQzaEMM/U7Ef1K5de3BM1AqVWGGzXbPsMfz2TfuPcuj5HKgi3X7KwjqOQgw18YFpCvoe6RSneWC79jS6IyPnL7WJxPNGnlQPuN5HdB796qMb+dhKHCORRbOe5uSw6/Ub+60fhI38L4v+UD1TxyocTuH6pyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209209; c=relaxed/simple;
	bh=p1HsFVRFpCHQyno+iaA9TH4o+Ur+oGzvppKT1DuYC9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWpWydgQnGkqQ15BPjgbQL6JfjdzNugdqWh80j7IUOyNBMXAWDIyaK0U3StJMheRB6a3LC1L4qx0/c9z8NKxcvrzh5CblZpU+IyTFs+Nm5T7Dv2mdNnVGe1YZo1QqL2P38Rf/ITWwGTi95aYEAi23KsX6mTJ0o4kcBFFAR645tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6A62E453DB;
	Mon, 05 Oct 2026 16:06:43 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: ipv6: seg6: report lwtunnel setup errors via extack
Date: Mon,  5 Oct 2026 16:06:34 +0200
Message-ID: <20261005140637.644840-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791209202531

seg6_build_state() rejected invalid configurations with a generic -EINVAL,
so "ip route add ... encap seg6 ..." always reported "Invalid argument".

Attach an extack message to each of them. The checks themselves and their
return values are unchanged.

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

v4 (https://lore.kernel.org/all/20260923120228.172643-1-g.goller@proxmox.com/):
 * use NL_SET_ERR_MSG when the SRH attr is missing
 * use NL_SET_ERR_MSG_ATTR when we have an invalid attr

v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
 * format fix
 * use NL_SET_ERR_MSG_ATTR

v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
 * dropped tests

 net/ipv6/seg6_iptunnel.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 69a6ef5c5317..73160179a545 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -762,8 +762,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
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
@@ -771,8 +774,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[SEG6_IPTUNNEL_SRH])
+	if (!tb[SEG6_IPTUNNEL_SRH]) {
+		NL_SET_ERR_MSG(extack, "missing SRv6 SRH attribute");
 		return -EINVAL;
+	}
 
 	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
 	tuninfo_len = nla_len(tb[SEG6_IPTUNNEL_SRH]);
@@ -782,13 +787,19 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	 */
 	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
 		   sizeof(struct in6_addr);
-	if (tuninfo_len < min_size)
+	if (tuninfo_len < min_size) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+				    "truncated SRv6 SRH attribute");
 		return -EINVAL;
+	}
 
 	switch (tuninfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
-		if (family != AF_INET6)
+		if (family != AF_INET6) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+					    "inline mode requires an IPv6 route");
 			return -EINVAL;
+		}
 
 		if (tb[SEG6_IPTUNNEL_SRC]) {
 			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
@@ -804,12 +815,18 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	case SEG6_IPTUN_MODE_L2ENCAP_RED:
 		break;
 	default:
+		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+				    "invalid SRv6 encapsulation mode");
 		return -EINVAL;
 	}
 
 	/* verify that SRH is consistent */
-	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
+	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
+			       false)) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+				    "invalid SRv6 segment routing header");
 		return -EINVAL;
+	}
 
 	newts = lwtunnel_state_alloc(tuninfo_len + sizeof(*slwt));
 	if (!newts)
-- 
2.47.3


