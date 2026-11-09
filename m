Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239655;
	b=CUvsKhLmk/W8e7Gq7bXKOE39r4ClOZGOCmPAkDc0AvGBrBILm8F/YGa0HWLMzVpwwVdV
	 QA/nZD33Gfs9szRRhymSXIUmztSyd5+oMLBB1mvp2jeq/ZEBcUtCbBRcwji2Jga9DBB0m
	 6cB9J3fbe3Q2gVykyG6d95fytxPtN8yekBzdEarCONjt/aIxcY/0c1t+YBcShOIn1CwJV
	 9oRgVITplDO4U6KoFqIWxhoh3xFakRseXrO8vsV/401sXdpkqPg1YAgydaUuuwdG5rOTG
	 2sn8Ak8yya7Thyf1rnatwolJHEQH9SNFrQ9AJ+huWU2U/WPsSZaXvKqX61tYj8XkGgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239655;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=gTMNEF6dJw/O7kf712eKlMX49QBXLH8dHRmAe13jRSM=;
	b=Ks2E6nwkPxy2GvDtDJOiRFghcauGdzodRcKk9su/ydE3HZN9PPxuU7IwhnbfGNfviI9B
	 9wvQrLznpKFopx4R4aU3dirv7KXYAcx9dzRzZfmAJoy0xZu4LJYZK5+ExxkUDIJJRrJXr
	 tz9sJYwlqCD579vsYkFOf2W2xMekktRwv/p+IVjHuwhViV/OVHxyu9427auKQ8vPu1Pgi
	 S3rpDYySKGdNVlsrDiJc06We0gBlW9P3p/+Qyy3lra9XZxZihzhrdt7a998ZLZ+m4jdyq
	 t2RjoQGTQ/rgHnQbrtepivQJ7XhmqdcYdUGzgugwMdMHWhwrt87SyQcpwlTG5z7hUEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6A606A31C;
	Mon,  9 Nov 2026 15:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1ED9D48124;
	Mon, 09 Nov 2026 16:54:05 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
Date: Mon, 09 Nov 2026 16:53:08 +0100
Subject: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
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
Message-Id: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
X-B4-Tracking: v=1; b=H4sIAHDs8WoC/yWMUQqDMBAFryL7bcAsKtirFBGrL3VFUsmmIoh3N
 7WfwzBzkCIIlB7ZQQGbqHx8AptnNEy9f8PImJi44NraojGybnUXoIhdvyzGlhW70XHDVUkpWgO
 c7PfwSR7ReOyR2r/R72vGEH8/Os8L8jjE5HwAAAA=
X-Change-ID: 20261109-ipv6_reset_all-1452fdf29254
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>
X-Mailer: b4 0.17-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794239643547

Disabling all.forwarding resets force_forwarding on every interface, but
leaves all.force_forwarding set:

  # sysctl -wq net.ipv6.conf.all.forwarding=1
  # sysctl -wq net.ipv6.conf.all.force_forwarding=1
  # sysctl -wq net.ipv6.conf.all.forwarding=0
  # sysctl net.ipv6.conf.dummy1.force_forwarding
  net.ipv6.conf.dummy1.force_forwarding = 0
  # sysctl net.ipv6.conf.all.force_forwarding
  net.ipv6.conf.all.force_forwarding = 1

Writing 1 to all.force_forwarding afterwards is ignored because the
value did not change, so the interfaces are not re-enabled.

Reset all.force_forwarding too and notify netconf listeners.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 net/ipv6/addrconf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d9d13e78bf13..9007a58039e6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -905,6 +905,14 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
 						     net->ipv6.devconf_dflt);
 
 		addrconf_forward_change(net, newf);
+		/* Disabling all.forwarding also resets all.force_forwarding */
+		if (newf == 0 && net->ipv6.devconf_all->force_forwarding) {
+			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, 0);
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     NETCONFA_IFINDEX_ALL,
+						     net->ipv6.devconf_all);
+		}
 		if ((!newf) ^ (!old))
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_FORWARDING,

---
base-commit: fa5196392691051963726787944db872420dfa75
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261109-ipv6_reset_all-1452fdf29254

Best regards,
--  
Gabriel Goller <g.goller@proxmox.com>


