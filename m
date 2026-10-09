Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8C4DEC15;
	Fri,  9 Oct 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559229; cv=none; b=etao94Wj6VoJPcszPVDYVYEiE6IEn5XO7YcSkx3ssjhRK0WPf5iIE1XP18a55XqUvu43RpEGzc1E48SA+T5FKsCxXeuf3/Ar2q5is1LAq2C9+iWB9bx00OrVrUNU5pQf5a5r84Fqre5qq7i3bkNxetYAf6M9LPJZHASVmfk7Zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559229; c=relaxed/simple;
	bh=fTcOwCXJBoEKdjXvf8bN4MoiJ4xOloa7nuvRAx/pEik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3R8j7jiorEv4MdHZK18/hZ7N8i1BPFn3Vb1OV1cQgQz7dqzMdJmyfu52ePn2SAvw/vCtD9FtWr6KSSzpVac/Rr1KHMI0Br4rJ7LbQ5CfIFJUizx8JWURwdrrMIxBT3FWxicfqL5OqiGykCVTAolX8CQa5GFwNfWZemRMIL7hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 77D68430FB;
	Fri, 09 Oct 2026 17:20:20 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] net: ipv6: seg6: report lwtunnel setup errors via extack
Date: Fri,  9 Oct 2026 17:20:13 +0200
Message-ID: <20261009152015.462383-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791559219587

seg6_build_state() rejected invalid configurations with a generic -EINVAL,
so "ip route add ... encap seg6 ..." sometimes reported "Invalid argument".

Add extack messages to the checks that lacked one, and use
NL_REQ_ATTR_CHECK() for the missing SRH attribute so that userspace can
tell which attribute is missing. The checks themselves and their return
values are unchanged.

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

v5 (https://lore.kernel.org/all/20261005140637.644840-1-g.goller@proxmox.com/):
 * use NL_REQ_ATTR_CHECK() for the missing SRH attribute (Jakub)
 * reword the inline mode message to "inline mode requires the IPv6
   address family", since it also applies to IPv4 nexthop objects
   (Andrea)
 * consistently call the header "IPv6 Segment Routing Header" (RFC 8754)
   in all messages (Andrea)
 * include the offending mode value in the invalid mode message
 * reword the commit message to match

v4 (https://lore.kernel.org/all/20260923120228.172643-1-g.goller@proxmox.com/):
 * use NL_SET_ERR_MSG when the SRH attr is missing
 * use NL_SET_ERR_MSG_ATTR when we have an invalid attr

v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
 * format fix
 * use NL_SET_ERR_MSG_ATTR

v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
 * dropped tests

 net/ipv6/seg6_iptunnel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 69a6ef5c5317..0d39a38a5dd2 100644
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
@@ -771,7 +774,7 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[SEG6_IPTUNNEL_SRH])
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, SEG6_IPTUNNEL_SRH))
 		return -EINVAL;
 
 	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
@@ -782,13 +785,19 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	 */
 	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
 		   sizeof(struct in6_addr);
-	if (tuninfo_len < min_size)
+	if (tuninfo_len < min_size) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+				    "truncated IPv6 Segment Routing Header attribute");
 		return -EINVAL;
+	}
 
 	switch (tuninfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
-		if (family != AF_INET6)
+		if (family != AF_INET6) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+					    "inline mode requires the IPv6 address family");
 			return -EINVAL;
+		}
 
 		if (tb[SEG6_IPTUNNEL_SRC]) {
 			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
@@ -804,12 +813,19 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	case SEG6_IPTUN_MODE_L2ENCAP_RED:
 		break;
 	default:
+		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[SEG6_IPTUNNEL_SRH],
+					"invalid SRv6 encapsulation mode %d",
+					tuninfo->mode);
 		return -EINVAL;
 	}
 
 	/* verify that SRH is consistent */
-	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
+	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
+			       false)) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
+				    "invalid IPv6 Segment Routing Header");
 		return -EINVAL;
+	}
 
 	newts = lwtunnel_state_alloc(tuninfo_len + sizeof(*slwt));
 	if (!newts)
-- 
2.47.3


