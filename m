Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333537FF54;
	Thu, 10 Sep 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078790; cv=none; b=VsLkpOKx6D5sS+E9F8sYrzGhYe1XPSQC95MAt/yCwQw1LHDbMDKeplBbHNyJ4QrKVaOU8+mZmqTTGbu/VvQ4iKAJjJk08/pk84cFOo3/R0e/J+x51xsfkEF+zQRQ+JRSySgbwoj69r55WLyDHaqvdY2qrL6N72rtB8xhx0krpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078790; c=relaxed/simple;
	bh=8jQRgMB/Vi8pb/uLewwm6d/XaELBNMozr2BCT2sv1Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/KfQxVMC3lvFyozsW+0Wa+OyzZisAU4AmX7kljC95op2ol5wYg7ypP/fA+qIPiZhkFEEPRVoGVvHPIW0StgpFB9hcnYba3EpXI/4jBSnD6tzhbKZjythSgEGSF6iHPFhKTESAmrf1nKEL0qTcI4LB/OaJIOsIhl4xttCELfW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bioGOhLc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bioGOhLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=8jQRgMB/Vi8pb/uLewwm6d/XaELBNMozr2BCT2sv1Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bioGOhLc7DU4o1BjUvXH1vLmDmJ0657m2kDr7tXv74XY5d8ImFyG3mOOZPznk+IQU
	 28ffXMheWIkneozGACqXlC03lH+jq78U4OB49P8IjjugAAPugTJVxLmva6vMWtWUa7
	 0ffX+wHU0E9mzCA02crTG3ExxGco63WQVBghpisboY1sJRvEAZExic8gjnjte4+h1y
	 xWWTV6klTomx0BIECDjHTbYEXBZvusxI09+sV6eibOMpzMNINdacIWJ95jyLha9SuM
	 P0onbC9zpA+1PRj5DG3BjdC4LXx6FBciUneOKD8JilIaoYH0LBgUTzT3UDsT1Vritk
	 J4qrHxFfZ4vUg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 037B46010D;
	Thu, 10 Sep 2026 22:19:38 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id CF6F4202113; Thu, 10 Sep 2026 22:17:36 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 4/8] netlink: specs: rt-link: add C naming info
Date: Thu, 10 Sep 2026 22:17:24 +0000
Message-ID: <20260910221733.1021864-5-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing naming info needed for C code gen.

Add headers to Makefile.deps, so that the local copy is used,
except for if.h which is non-trivial due to a compiler.h include.

Rename snmp.h header guard, for Makefile.deps compatibility, this
is opaque once installed by scripts/headers_install.sh.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 25 +++++++++++++++++++++---
 include/uapi/linux/snmp.h                |  6 +++---
 tools/net/ynl/Makefile.deps              | 11 +++++++++--
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 61ebb9a2bad5..a74108072ce7 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -58,6 +58,7 @@ definitions:
     name: vlan-protocols
     type: enum
     enum-name:
+    name-prefix: eth-p-
     entries:
       -
         name: 8021q
@@ -305,6 +306,8 @@ definitions:
   -
     name: ipv4-devconf
     enum-name:
+    name-prefix: ipv4-devconf-
+    header: linux/ip.h
     type: enum
     entries:
       -
@@ -376,6 +379,8 @@ definitions:
   -
     name: ipv6-devconf
     enum-name:
+    name-prefix: devconf-
+    header: linux/ipv6.h
     type: enum
     entries:
       -
@@ -501,6 +506,8 @@ definitions:
   -
     name: ifla-icmp6-stats
     enum-name:
+    name-prefix: icmp6-mib-
+    header: linux/snmp.h
     type: enum
     entries:
       -
@@ -520,6 +527,8 @@ definitions:
   -
     name: ifla-inet6-stats
     enum-name:
+    name-prefix: ipstats-mib-
+    header: linux/snmp.h
     type: enum
     entries:
       -
@@ -640,6 +649,8 @@ definitions:
     name: vlan-flags
     type: flags
     enum-name:
+    name-prefix: vlan-flag-
+    header: linux/if_vlan.h
     entries:
       - reorder-hdr
       - gvrp
@@ -727,6 +738,8 @@ definitions:
     name: ifla-vf-link-state-enum
     type: enum
     enum-name:
+    name-prefix: ifla-vf-link-state-
+    header: linux/if_link.h
     entries:
       - auto
       - enable
@@ -794,6 +807,7 @@ definitions:
     name: rtext-filter
     type: flags
     enum-name:
+    name-prefix: rtext-filter-
     entries:
       - vf
       - brvlan
@@ -806,7 +820,8 @@ definitions:
   -
     name: netkit-policy
     type: enum
-    enum-name:
+    enum-name: netkit-action
+    name-prefix: netkit-
     entries:
       -
         name: forward
@@ -818,6 +833,7 @@ definitions:
     name: netkit-mode
     type: enum
     enum-name: netkit-mode
+    name-prefix: netkit-
     entries:
       - name: l2
       - name: l3
@@ -825,7 +841,8 @@ definitions:
   -
     name: netkit-scrub
     type: enum
-    enum-name:
+    enum-name: netkit-scrub
+    name-prefix: netkit-scrub-
     entries:
       - name: none
       - name: default
@@ -833,13 +850,14 @@ definitions:
     name: netkit-pairing
     type: enum
     enum-name: netkit-pairing
+    name-prefix: netkit-device-
     entries:
       - name: pair
       - name: single
   -
     name: ovpn-mode
     enum-name: ovpn-mode
-    name-prefix: ovpn-mode
+    name-prefix: ovpn-mode-
     type: enum
     entries:
       - p2p
@@ -848,6 +866,7 @@ definitions:
     name: br-stp-mode
     type: enum
     enum-name: br-stp-mode
+    name-prefix: br-stp-mode-
     entries:
       - auto
       - user
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..26bdabc502fe 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -5,8 +5,8 @@
  * Author: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
  */
 
-#ifndef _LINUX_SNMP_H
-#define _LINUX_SNMP_H
+#ifndef _UAPI_LINUX_SNMP_H
+#define _UAPI_LINUX_SNMP_H
 
 /* ipstats mib definitions */
 /*
@@ -372,4 +372,4 @@ enum
 	__LINUX_MIB_TLSMAX
 };
 
-#endif	/* _LINUX_SNMP_H */
+#endif	/* _UAPI_LINUX_SNMP_H */
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 2771375339d9..8e136a5df899 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -40,8 +40,15 @@ CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
-CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
-	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
+CFLAGS_rt-link:=$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h) \
+	$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,_LINUX_IP_H,ip.h) \
+	$(call get_hdr_inc,_IPV6_H,ipv6.h) \
+	$(call get_hdr_inc,_LINUX_IF_BRIDGE_H,if_bridge.h) \
+	$(call get_hdr_inc,_IF_TUNNEL_H_,if_tunnel.h) \
+	$(call get_hdr_inc,_LINUX_IF_VLAN_H_,if_vlan.h) \
+	$(call get_hdr_inc,_LINUX_SNMP_H,snmp.h) \
+	$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
 CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
-- 
2.55.0

