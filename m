Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806248;
	b=sW9UPum1aR1ZtVYR1tZzKhz4sZxpzUJSB2z9ARuWXSuOP60pvpedPiSpwCGQpntqsH3B
	 kURzh+EPBHujF4snh3zrxSYmCR7WP3zSOwPJb4xN3pGVXlVFx3QCfFATVlFzyEqMkD8Qr
	 fivVfqnl1IInxlz+DSMFXkLx9CKJpgcLGfJtpl3gBQv1Y24va7v0ebrhxJQuPP+XnHXYJ
	 VoTI0QgLyT7OTT97RC4z0yyqbYFxCZPdG+6nuIXsDP60sXJYtRkDL9lDSJyfXwpnAEpEQ
	 ePxe+TWXdJxyn53Fb9V631jSIoAt9aT1a1MbC7SOn96Wfb+6P5q7tjqtLfTXlFzszKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806248;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=PF+2F/qylNUl5uG+AA1s4jIY53tBQkCikmrmstbxPec=;
	b=rRB+LXZT432XuLXx36+MRwhjh9jm/tt0tl0EHxDlWhqn0/gKXuGHFAiGQlbgeFGSimpA
	 cIj60JcSOlqs7PK7KgO/NGgYra+xKb1Pfa9f+Okgm2X7oXa6nRGRGWqPYg9b1J1Wmpv+l
	 BFriL6qA4mKn6tcoNinkZ486EFyCENWa33gXz1IUfLWOdPWSWD0I8LTnKgN095ork5qfc
	 XayITXsHVNRvEau+DS3feItgJt1VlnsQB6BKzJj0V1hy+n4hP5n+xvNTlLspnYCJYPfTV
	 yUKBD0R+4d18Yl6iNRTGxWaWt8SmB2gbX1m9dTYbXdgkrIK3MhRQTBTgpsZHU/oe5Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD11606A339;
	Wed,  4 Nov 2026 15:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD11606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CD08C45307;
	Wed, 04 Nov 2026 16:30:43 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
Date: Wed, 04 Nov 2026 16:29:44 +0100
Subject: [PATCH RFC net-next] vxlan: always report local address
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-vxlan_preserve_local-v1-1-e9b51f2132b4@proxmox.com>
X-B4-Tracking: v=1; b=H4sIAHRP62oC/yWMTQrCMBBGr1JmbaBprRK3Qg/gtkiJcaojYSpJD
 IHSuzvV5ffz3gIRA2GEU7VAwEyRZpagdxW4p+UHKrpLhqZuDlrXe5WLtzy+AwqYcfSzs165drK
 mM2iOugNBZZ6o/LQDXPrz1jEmxVgSXP+H+Lm90KVNDuv6Bb/H/geJAAAA
X-Change-ID: 20261104-vxlan_preserve_local-c3fa959e9715
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabriel Goller <g.goller@proxmox.com>
X-Mailer: b4 0.17-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793806243156

When a VXLAN device has no local address, link dumps and notifications
contain neither IFLA_VXLAN_LOCAL nor IFLA_VXLAN_LOCAL6. If the device
also has no remote or group address, userspace can't tell whether it is
an IPv4 or IPv6 device, even though the kernel stores the family. FRR
runs into this when it finds existing VXLAN devices after a restart.

Report the local address even when it is unset, as IFLA_VXLAN_LOCAL
0.0.0.0 or IFLA_VXLAN_LOCAL6 ::, so the attribute type shows the
family.

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 drivers/net/vxlan/vxlan_core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 223539099778..95dcdf610cd1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4773,18 +4773,17 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (cfg->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, cfg->remote_ifindex))
 		goto nla_put_failure;
 
-	if (!vxlan_addr_any(&cfg->saddr)) {
-		if (cfg->saddr.sa.sa_family == AF_INET) {
-			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
-					    cfg->saddr.sin.sin_addr.s_addr))
-				goto nla_put_failure;
+	/* Report the address family even when the local address is unspecified. */
+	if (cfg->saddr.sa.sa_family == AF_INET) {
+		if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
+				    cfg->saddr.sin.sin_addr.s_addr))
+			goto nla_put_failure;
 #if IS_ENABLED(CONFIG_IPV6)
-		} else {
-			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
-					     &cfg->saddr.sin6.sin6_addr))
-				goto nla_put_failure;
+	} else {
+		if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
+				     &cfg->saddr.sin6.sin6_addr))
+			goto nla_put_failure;
 #endif
-		}
 	}
 
 	if (nla_put_u8(skb, IFLA_VXLAN_TTL, cfg->ttl) ||

---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261104-vxlan_preserve_local-c3fa959e9715

Best regards,
--  
Gabriel Goller <g.goller@proxmox.com>


