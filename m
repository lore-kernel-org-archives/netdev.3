Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189465;
	b=EOSUWfQMNDoL4ihTMNtXX0jHXWiNa+1vUQ0zj77POIpguQ3faDUB58BGXIG50U7RIkXD
	 E9zLXR+7LrwsunhOSXrj2M+Go0TzzMkiqeQq7vXGH9lMpI1XUQNeA7Vzz84v47Tiv58EG
	 g8Nk84wOZyic/IoCrmTrniNX958fiPZZ4301zO5WiFQXujRdvXnEe3l0KePkVmkgeHYEO
	 RzTNFoJJc1x4nPwfmPh1oXFffZHThSaJBKT85xT29T/7Xxpdi6FRc0B06AJDbzSqtY80P
	 mqV5mkuQCbUwnS75G9EuLHopqAoIEwZ05ItgsxgbgqAO5SZOP7pBpj6j/HxchXtPeMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189465;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=sm1BiODDX+3Q42f0BoXQJdYDF4JI4ZR4FmWTuNbj7uE=;
	b=NY6QOENr7H8tkC+HgIDwHO5RA+uBeYzRxc+PBCsbKyPwUFL1DM8M8npbNiu+3z4NAW3+
	 4lIo7tFmStC/5Pz9AKJEI65j4bafXRmfe9S9izRrcbRroj981FdHuAYv61eBILBBIdCph
	 aQe6AICebWJK0J9Pw3/381bNFev7bYwWCVxWGc4OIxl7yL1m2XcrU/B3tS6xCb/mejHkV
	 gOQBC2V1116k1GsASfuO7l3XfDOeSxyjABnuU6eWptvU2vAAruDHYnAxPRoVX88kM3KFJ
	 o+I+rOeZoIgqaXzFZHhJmV2Vd3UkCrSVKRJ42C4bya7/dxfdrQk9x24imNnMT7AWwNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF40606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF40606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5205B43210;
	Wed, 28 Oct 2026 13:11:01 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
Date: Wed, 28 Oct 2026 13:10:44 +0100
Subject: [PATCH iproute2-next] ip: netconf: show IPv6 force_forwarding
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
Message-Id: <20261028-ip_netconf_show-v1-1-a20fc6b20025@proxmox.com>
X-B4-Tracking: v=1; b=H4sIAEPm4WoC/yWMQQ6CMBAAv0L2bBO6qKF+xRAiZZH1sG26RUkIf
 6fqcTKZ2UApMSncqg0SvVk5SAF7qsDPD3mS4bEwYI1XW2NrOPZC2QeZep3Dx5wvLbnBugYbB6W
 KiSZef8c7cExhyYRGaM3Q/bUuw4t8/l5h3w9bK1+vggAAAA==
X-Change-ID: 20261028-ip_netconf_show-458e9b193239
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, Gabriel Goller <g.goller@proxmox.com>
X-Mailer: b4 0.17-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793189460681

Allow users to inspect and monitor force_forwarding, which enables
per-interface IPv6 forwarding independently of the global forwarding
setting.

The sysctl was introduced with kernel commit
f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding").

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 ip/ipnetconf.c        | 4 ++++
 man/man8/ip-netconf.8 | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 57bb99d1f061..915d84ffa403 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -109,6 +109,10 @@ int print_netconf(struct rtnl_ctrl_data *ctrl, struct nlmsghdr *n, void *arg)
 		print_on_off(PRINT_ANY, "forwarding", "forwarding %s ",
 			     rta_getattr_u32(tb[NETCONFA_FORWARDING]));
 
+	if (tb[NETCONFA_FORCE_FORWARDING])
+		print_on_off(PRINT_ANY, "force_forwarding", "force_forwarding %s ",
+			     rta_getattr_u32(tb[NETCONFA_FORCE_FORWARDING]));
+
 	if (tb[NETCONFA_RP_FILTER]) {
 		__u32 rp_filter = rta_getattr_u32(tb[NETCONFA_RP_FILTER]);
 
diff --git a/man/man8/ip-netconf.8 b/man/man8/ip-netconf.8
index 7fe3e5f35803..558c14eb0a45 100644
--- a/man/man8/ip-netconf.8
+++ b/man/man8/ip-netconf.8
@@ -15,8 +15,8 @@ The
 .B ip netconf
 utility can monitor IPv4 and IPv6 parameters (see
 .BR "/proc/sys/net/ipv[4|6]/conf/[all|DEV]/" ")"
-like forwarding, rp_filter, proxy_neigh, ignore_routes_with_linkdown
-or mc_forwarding status.
+like forwarding, force_forwarding (IPv6 only), rp_filter, proxy_neigh,
+ignore_routes_with_linkdown or mc_forwarding status.
 
 If no interface is specified, the entry
 .B all

---
base-commit: 204a721033556114c81c47d00375f2d52e98e463
change-id: 20261028-ip_netconf_show-458e9b193239

Best regards,
--  
Gabriel Goller <g.goller@proxmox.com>


