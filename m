Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077549E5FB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374362; cv=none; b=ih4fOhp0bKZf74Iem9zUAXjZBtt/RDATp6qMOCp8Dkvka0rAH37oSa/V5jb8ecMjZ6oMJO+HI+JYBYMhqWkKHdDfMQmItZmlxqOjM1f79h7q6+nGSFqX7NpIcHnDEmIRnX5GtnZxsV5r25FIFXdbp+Yw7BfPONH/lutLEwMjMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374362; c=relaxed/simple;
	bh=6I9/o2fsb95RZ/cdcrjocTXvh86feiHHlbzI4OFSZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHng0T4XwAuNY1tOAji2Z7wWWuk5fZs0+YKKpDGPD4nZ7ndDCHdXCdQwdLIwqRSDlJGK7AfuookZz/7bftqLY6Ivqdi9JKCxi9pj4i8VquwIAvFG4f9ZvNjTampXAG/1JfPVqQDQIKeFG0o6CkUN5n1KuCABp3HJSJXnrd9kysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoJmO1R8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoJmO1R8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a89d1ca907so753977a91.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374350; x=1791979150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tVHCGk2Xwqu+yf2mIq4Pai4+4x8BJRwBsQH1o/snK8=;
        b=CoJmO1R8F8CJItqw63omdckmRq37yMTeAWntqNbMESDHgmtyncR1PbKgSsADCJiiwd
         odPePWV0/UgnY+j3ODuvLKHam6GSygFqzL0IKKZr4/8/u3OdZWzR6K/k0HyGfP0NLC+i
         zvLUwtMBJv51crxCG08T8RM6K9cNFJ09WQowzShTKWSmohkkp3hjxC+eI5PscMKXM/mJ
         265DQVSrV7AfbhwP6w890rwuZTZifBa4G4kxYIHllXk5n7jPEgvyREXANw7/Jx+G+Fu6
         Lh3Q33Bsxz/7BR6kuvn6mpcIv0dUA4NBiFwFv6y6pmALU1lZYSvWPYJQrsgMEtvAtHpG
         HhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374350; x=1791979150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tVHCGk2Xwqu+yf2mIq4Pai4+4x8BJRwBsQH1o/snK8=;
        b=uOZoaotCSdnr2yZLDlcIxLI+RPblQ6MbdSdmoDOCtCKjnFWlIwrsIUwVBkV4dFB6fM
         cQzJzMbgENjk1kiDLQyI8z3u36WPLsfviqbhvs/b4pX54kvdk7cZS8OhZ8Cnm5CJnF/6
         UbO27U0JERt+wIAXru6N76hUAo6mN8hyBK0NquttUa7CbTUZH5BBmxsWJCDRvOzmCkNm
         nX9IuvWtD6lhB7zA5s+xWoH1/a7SHcrlVgl9E0X7p+Y2/r53eN0w82jiNkuLUiiA5CKj
         3qDw/WSwtOHC/2OcGpMVM3Al0TfPfYMJ8e5oAh+so6elYRG1fHOEKM7j+NVymIUbG98z
         5j3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAbAWHeRU8QgmYzd+xm48xmK0d0xn+xIZ1SnOgvzQxrLwG21w79WrC1PHPcdb/1pVbeJjhku0=@vger.kernel.org
X-Gm-Message-State: AFq9FYInv/GlQC/EmlvApNS0GdFPsnRxiU8cW9bss8Y1JPfhdRHgccP5
	0y77qPYfJBIud0XTbtNERW3X8DBAgHMKUElHJAY71eAf6psXA/dw533B
X-Gm-Gg: AYBFou0VsF7WfMw6gDFuUAVf8euidqICQ8PoZ4SXWFocbU1XuhR13dMEIjDI1Ikfk7M
	8/A+oiQc3sT6X2PN1QgRalF3j9kNMYHwrbsOEPb3N12cJmpYABCi1FrOea1EX4ev2rvIij00VHB
	l4HR2XmVsbU7lEPZUOzY8d9SEEQlQEZzsyu/Bvtf3Ek0T1NRXRHgxkgtw810gZlS66AyKPsYScA
	8uoUFurCccp/jsea0ELD54s7HHuEBNpXZPwEt7/sQpz/wNua55Mn0fSOnHIXuLHfPQVaJvHWlgc
	7Dy8ziAqRqTaekxePjh+Vip+qwWnrhj/isSeZVa5aan5JlrHzSYvgFQ3zuB7v4ushwi7ZGN52MT
	e6ha3PxN+fSV0I1TeENlgaXFf5sv8UTeW4TVfE+VhuzJ31BrYHxaMxkIeLEcqDeUwWKvXeORba0
	kr7sb0bc2E2ZnENJhyUw0eG7xrXrMRqqcn5hTiTLafh04hkooqyLrLjT6mLbwLKJmBFJL8uCqeN
	Ojy+QxzZ4XfihVnlansTEMiNGNZGT7zdSsUXdZtfxtvqjYLTfagQIj6DS80gig6T2suiANIGWg8
X-Received: by 2002:a17:90b:4a44:b0:3a5:37e7:7118 with SMTP id 98e67ed59e1d1-3a8a0741012mr1801667a91.16.1791374349943;
        Wed, 07 Oct 2026 04:59:09 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8987b09e2sm4456582a91.2.2026.10.07.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:59:09 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 6/6] selftests: net: test AF_PACKET multicast dumps
Date: Wed,  7 Oct 2026 20:58:21 +0900
Message-ID: <20261007115821.11332-7-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007115821.11332-1-sigefriedhyy@gmail.com>
References: <20261007115821.11332-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump the link-layer multicast addresses of a dummy device and verify
that ifa_index restricts the dump to that device, that the all-hosts
address joined on link up is listed without IFA_F_GLOBAL, that an
address added with SIOCADDMULTI is listed with IFA_F_GLOBAL and
IFA_MC_USERS, and that IFA_TARGET_NETNSID dumps another netns.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 tools/testing/selftests/net/rtnetlink.py | 73 +++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index dc8c77db48974..5534ade056a5c 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -5,13 +5,18 @@ import socket
 import struct
 import time
 from lib.py import bkg, ip, ksft_exit, ksft_run, ksft_eq, ksft_ge, ksft_true, KsftSkipEx
-from lib.py import ksft_not_in, ksft_not_none
+from lib.py import ksft_in, ksft_not_in, ksft_not_none
 from lib.py import CmdExitFailure, NetNS, NetNSEnter, RtnlAddrFamily, RtnlRouteFamily
 from lib.py import defer
 
 IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
 IPV4_TEST_MULTICAST = b'\xef\x01\x01\x01'
 IPV6_TEST_MULTICAST = bytes.fromhex('ff020000000000000000000000000123')
+ETH_ALL_HOSTS_MULTICAST = bytes.fromhex('01005e000001')
+ETH_TEST_MULTICAST_STR = '01:00:5e:01:01:01'
+ETH_TEST_MULTICAST = bytes.fromhex(ETH_TEST_MULTICAST_STR.replace(':', ''))
+ETH_PEER_MULTICAST_STR = '01:00:5e:02:02:02'
+ETH_PEER_MULTICAST = bytes.fromhex(ETH_PEER_MULTICAST_STR.replace(':', ''))
 
 
 def _users_for(rtnl: RtnlAddrFamily, family: int, grp: bytes, ifindex: int):
@@ -105,6 +110,69 @@ def dump_mcaddr6_check() -> None:
                 s2.close()
 
 
+def dump_mcaddr_l2_check() -> None:
+    """
+    Verify link-layer multicast addresses in an AF_PACKET RTM_GETMULTICAST
+    dump: the ifa-index filter, mc-users, the global flag and
+    target-netnsid.
+    """
+
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        for ifname in ("dummy1", "dummy2"):
+            ip(f"link add name {ifname} type dummy")
+            ip(f"link set {ifname} up")
+        dev_idx = socket.if_nametoindex("dummy1")
+        ip(f"maddr add {ETH_TEST_MULTICAST_STR} dev dummy1")
+
+        rtnl = RtnlAddrFamily()
+        defer(rtnl.close)
+        addresses = rtnl.getmulticast(
+            {"ifa-family": socket.AF_PACKET, "ifa-index": dev_idx},
+            dump=True)
+
+        # dummy2 has entries as well, only dummy1 may be listed
+        ksft_eq({addr['ifa-index'] for addr in addresses}, {dev_idx},
+                "AF_PACKET multicast dump ignored ifa-index filter")
+
+        entries = {addr['multicast']: addr for addr in addresses}
+
+        # Bringing an Ethernet device up joins 224.0.0.1, which maps
+        # to 01:00:5e:00:00:01 in the device multicast list.
+        all_hosts = entries.get(ETH_ALL_HOSTS_MULTICAST)
+        ksft_not_none(all_hosts,
+                      "dummy1 does not have the all-hosts link-layer address")
+        if all_hosts is not None:
+            ksft_not_in('global', all_hosts['flags'],
+                        "protocol entry is global")
+
+        static = entries.get(ETH_TEST_MULTICAST)
+        ksft_not_none(static, "dummy1 does not have the SIOCADDMULTI address")
+        if static is not None:
+            ksft_eq(static['mc-users'], 1,
+                    "unexpected mc-users for the SIOCADDMULTI address")
+            ksft_in('global', static['flags'],
+                    "SIOCADDMULTI entry is not global")
+
+        # target-netnsid dumps another netns, ifa-index is relative to it
+        with NetNS() as peer:
+            ip(f"netns set {peer} 5")
+            ip("link add name dummy3 type dummy", ns=peer)
+            ip("link set dummy3 up", ns=peer)
+            ip(f"maddr add {ETH_PEER_MULTICAST_STR} dev dummy3", ns=peer)
+            peer_idx = ip("link show dummy3", json=True, ns=peer)[0]['ifindex']
+
+            addresses = rtnl.getmulticast(
+                {"ifa-family": socket.AF_PACKET, "target-netnsid": 5,
+                 "ifa-index": peer_idx}, dump=True)
+            ksft_eq({(addr['ifa-index'], addr['target-netnsid'])
+                     for addr in addresses}, {(peer_idx, 5)},
+                    "target-netnsid did not dump the peer netns")
+            # dummy1 in this netns can have the same ifindex as dummy3
+            ksft_in(ETH_PEER_MULTICAST,
+                    {addr['multicast'] for addr in addresses},
+                    "target-netnsid did not dump the peer device")
+
+
 def ipv4_devconf_notify() -> None:
     """
     Configure an interface and set ipv4-devconf values through netlink
@@ -424,7 +492,8 @@ def ipv6_verify_inter_scope_addr_order() -> None:
 
 
 def main() -> None:
-    ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify,
+    ksft_run([dump_mcaddr_check, dump_mcaddr6_check, dump_mcaddr_l2_check,
+              ipv4_devconf_notify,
               ipv6_route_del_reason_expired,
               ipv6_route_del_reason_ra_withdrawn,
               ipv6_route_del_reason_absent,
-- 
2.43.0

