Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3487394793
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601198; cv=none; b=iA5p4fJm4foYF9CfVxmtHDrxx/463Q7kGswdJCVjVrqmGTH410YDZ4u5J9NktYxyY83Sii6oLbG5L6T7LDLsDmS3kZ4BYKPrbXPDkElcXPzKO9dDxY7M5dg8IjyxdQvxyDTWO+ZfE0SI8aX6h2xIwvXcNBfpY3xLa9DI48uWeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601198; c=relaxed/simple;
	bh=8PyIgh0sL1ujfxgcdMkLoGO4mkPKg8GqTTZBkBw4pYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHF4W1UAbZ44emZ1ZHJzaqm/FUWQAuQBjqyJaaFDYCib4WmHx+oI7+N6PHypOMFxBYzRfK5wohhAvYrcB77KBTU+jI21G8jSdzgzURltNi4lGvhMIpk9WxStX/jtA0uqEwp6rlrSxMHA+30LLU5MQ8gXO9cTEjrkQPK0bVJH5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ+5kfM9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ+5kfM9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d560775ca2so13766885ad.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601193; x=1789205993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwjXdJ9yHMPf8cuJfw2JqkCHRNV8vSE7ZQQojK6Bpag=;
        b=jQ+5kfM9v017KBogo1YJa0gS3wfwCbID3CBJpJBP9XyJopf/88uSiMEFRPDUesBXlN
         CK35yyAbpZSv3GGs/9wK4GBg0oU7JGlydWMztxoEJcFrKpDh3XlXNFCqEE5I/O8CsD/a
         Wfue10jOKmxuT6S9WZadeCLZxQyQWWK3zuqdk1P/bSFHQ314Nvh/k+SmcT83jes4qudd
         uD55Le05dLkf2kpfMbZkUph9uNqENo86rEIl5BGBFXIQgdlNX2R9/qSJmgSa4DWFPn0V
         w/2pkpYORa5rtZ3KKM/z1M2xRNd8RbV/YX/Kdqek9N7rqDudFwqyZ5rR80CI6tpVXVGu
         0MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601193; x=1789205993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uwjXdJ9yHMPf8cuJfw2JqkCHRNV8vSE7ZQQojK6Bpag=;
        b=MAbCOGEkExj5y1XgShhVMRqOFR6ttk03QUhgzUHmvpfHR6vt4mLkS08EkMbAEupLG/
         frioF1swTtO8UnniYxccG84LiaLSAKB0mDSC6VgH6lRHXc+HVdnhPWbryC47xkk+zIR7
         uEjPIu5X8xdD5MMCHpOMFxvbnkSyZnH65fG6NfGzOjh0wyQVjulCNdlgkSGpLWhRl4Wp
         gXbxP9Ys/ra4EnntseYa6KzIWYQUAudJJ3f5m7dtfMb2+0h2A6UKmbSNUhj5bLZco2sl
         dKXItsThGdLC8x7N2AX6u7ej2Tmbo2midhpUatOPah2JMJ8Oaa1Gj+CaP8947YJLIbGm
         5wTA==
X-Forwarded-Encrypted: i=1; AKwUvBwOLRxqVJy3s9uP/TKc1sTZRNu1J0WIJaaPcpYamh+fsqSmy+84pI8RSHUSW13pSZMlYtBdLfU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVbNRGz13eW1x6ynDlFBEmTk8Veouj29rVT8tP4UR4YpIoOPB7
	vkiUJs0CkUBbdzelCG+s3UpabuBVTHbM9Wfebfku5Hx67VosFtJmCmO8
X-Gm-Gg: AYBFou1oH7EaA86uD0wBF64krMYLu7W6yvEDHSwIkr/qYGSBPiQQDG99bqnVjxmpNIw
	AygjL0H6vLTY0I5JxCvHqY7ddWSJ0tYOijZ16jec2ELPmAvvzWVEw9aoCXsHuN0X59FNFw4gG9W
	3IZsG1/PdLvXQoCVJAb5ifExbsfhrQmlNbISzidXLBroiEBlTapsKcnWvpjbqlAisxwlWFrWZwg
	yJZa0joUhFFzO9/TZ6HtMQfz+7v8LoNlatE0ijybRvWAv7NpN9BZ9KSi4mM+c9ia4TKDbTzHcmm
	hDS2Rt/HfERKbw3iheZs/NFdxMoafdrGDNxUll4vAeDwgiowhGYriz/qo/Pn09UA50rYlKXooMA
	TAAf6/XXVIJQ5+bVIkNFqRU9eGBm0TWL4iFkv4SZF10BI3IV/B9A5WRzKHDKyeg3+XQJR1G94ba
	qaevAsKJrfUgJoPkHSGlPAUeB5JwvT+1tjFAegbog7IVzcVdSvdMuePr4pS4uy8w09g92HBEly+
	9lyMu9gR7PJVMZTaqJNK0wLsZvbZLljSQz9AIo=
X-Received: by 2002:a17:903:886:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2db1232f69dmr109810885ad.4.1788601193200;
        Sat, 05 Sep 2026 02:39:53 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:dbc1:ef89:4dd5:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495a0c0sm20393745ad.17.2026.09.05.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:39:52 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: net: test AF_PACKET multicast dumps
Date: Sat,  5 Sep 2026 18:39:32 +0900
Message-ID: <20260905093932.43726-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093932.43726-1-sigefriedhyy@gmail.com>
References: <20260905093932.43726-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump the link-layer multicast addresses of a dummy device and verify
that ifa_index restricts the dump to that device, that the all-hosts
address joined on link up is listed without IFA_F_PERMANENT and that an
address added with SIOCADDMULTI is listed with IFA_F_PERMANENT and
IFA_MC_USERS. Skip when the kernel does not support AF_PACKET dumps.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.py | 58 ++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 5cc3ebdcf08d..94340dac0e21 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -1,17 +1,21 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import socket
 import struct
 import time
 from lib.py import bkg, ip, ksft_exit, ksft_run, ksft_eq, ksft_ge, ksft_true, KsftSkipEx
-from lib.py import ksft_not_in, ksft_not_none
-from lib.py import CmdExitFailure, NetNS, NetNSEnter, RtnlAddrFamily, RtnlRouteFamily
+from lib.py import ksft_in, ksft_not_in, ksft_not_none
+from lib.py import CmdExitFailure, NetNS, NetNSEnter, NlError, RtnlAddrFamily, RtnlRouteFamily
 from lib.py import defer
 
 IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
 IPV4_TEST_MULTICAST = b'\xef\x01\x01\x01'
 IPV6_TEST_MULTICAST = bytes.fromhex('ff020000000000000000000000000123')
+ETH_ALL_HOSTS_MULTICAST = bytes.fromhex('01005e000001')
+ETH_TEST_MULTICAST_STR = '01:00:5e:01:01:01'
+ETH_TEST_MULTICAST = bytes.fromhex(ETH_TEST_MULTICAST_STR.replace(':', ''))
 
 
 def _users_for(rtnl: RtnlAddrFamily, family: int, grp: bytes, ifindex: int):
@@ -105,6 +109,53 @@ def dump_mcaddr6_check() -> None:
                 s2.close()
 
 
+def dump_mcaddr_l2_check() -> None:
+    """
+    Verify link-layer multicast addresses in an AF_PACKET RTM_GETMULTICAST
+    dump: the ifa-index filter, mc-users and the permanent flag.
+    """
+
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            for ifname in ("dummy1", "dummy2"):
+                ip(f"link add name {ifname} type dummy")
+                ip(f"link set {ifname} up")
+            dev_idx = socket.if_nametoindex("dummy1")
+            ip(f"maddr add {ETH_TEST_MULTICAST_STR} dev dummy1")
+
+            rtnl = RtnlAddrFamily()
+            try:
+                addresses = rtnl.getmulticast(
+                    {"ifa-family": socket.AF_PACKET, "ifa-index": dev_idx},
+                    dump=True)
+            except NlError as e:
+                if e.error == errno.EOPNOTSUPP:
+                    raise KsftSkipEx(
+                        "kernel does not support AF_PACKET multicast dump")
+                raise
+
+            # dummy2 has entries as well, only dummy1 may be listed
+            ksft_eq({addr['ifa-index'] for addr in addresses}, {dev_idx},
+                    "AF_PACKET multicast dump ignored ifa-index filter")
+
+            entries = {addr['multicast']: addr for addr in addresses}
+
+            # Bringing an Ethernet device up joins 224.0.0.1, which maps
+            # to 01:00:5e:00:00:01 in the device multicast list.
+            ksft_in(ETH_ALL_HOSTS_MULTICAST, entries,
+                    "dummy1 does not have the all-hosts link-layer address")
+            ksft_not_in('permanent',
+                        entries[ETH_ALL_HOSTS_MULTICAST]['ifa-flags'],
+                        "protocol entry is permanent")
+
+            ksft_in(ETH_TEST_MULTICAST, entries,
+                    "dummy1 does not have the SIOCADDMULTI address")
+            ksft_eq(entries[ETH_TEST_MULTICAST]['mc-users'], 1,
+                    "unexpected mc-users for the SIOCADDMULTI address")
+            ksft_in('permanent', entries[ETH_TEST_MULTICAST]['ifa-flags'],
+                    "SIOCADDMULTI entry is not permanent")
+
+
 def ipv4_devconf_notify() -> None:
     """
     Configure an interface and set ipv4-devconf values through netlink
@@ -315,7 +366,8 @@ def ipv6_route_del_reason_absent() -> None:
 
 
 def main() -> None:
-    ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify,
+    ksft_run([dump_mcaddr_check, dump_mcaddr6_check, dump_mcaddr_l2_check,
+              ipv4_devconf_notify,
               ipv6_route_del_reason_expired,
               ipv6_route_del_reason_ra_withdrawn,
               ipv6_route_del_reason_absent])
-- 
2.43.0

