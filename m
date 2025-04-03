Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AF13B58A
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644242; cv=none; b=O7pEb0K3tyrYm87cYsaJ5lS/p3TUG/45pRkTHuULyCDGbSXbS9Tn1IXvAgW2S+zFkgQ2hB6PLWCetupDb2jtq+hR0vg+4nffius8Abc5Vhwo5Dan0Auixidry29o1li8kIvj+InXjaCFRHqXLX01rM2Q7F5FqZNw/09g9mIriCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644242; c=relaxed/simple;
	bh=nQxMKJY1rEc96+xAd6hgOPe/yh8PR+pNCTyM6ajEleM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At3yTTMegTVyiUyH/JFEZKez8ByotzYD86qFRO4n5CQOWhzXEJ5R0aRylx0aLb/1G7PDskaGP+FG0Vz/YkK/mFaxSVHQ/GjNoghYxWlNcGO7UrTEI8mTRViQDIZQt8DgmUoPnErCrN3BVGYtO15jmt4feqtuCez0dp/rsQqk/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN2osj93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN2osj93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61609C4CEE7;
	Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644242;
	bh=nQxMKJY1rEc96+xAd6hgOPe/yh8PR+pNCTyM6ajEleM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN2osj93EEc69cUZ3yk0eUa1LxaVtIos6OdezijO+m0h4wn7OHXWBQkGPSftgnPzj
	 8VvDJfCyihrJYcMyq8tNT/ndOOqvtZsOnzqOfRZSAF7mp1OL4K25Eb35bTS0I4oizY
	 +16hJtfAGPzLlseBQUG4/DlMAXRUhFPBs9BX5VQ4Z01o+4YGQYZiVDaukbkvxGDPpD
	 Y00fApgvYvhfjytwKebMyV1buFmuZb4YYhdxvlYcxBUWAFJ995/9X8PLHtITcQsicd
	 Sr1f/CaMut6z5RiD4KcnuaMhCbXvX4fw5NAo8mopLGY9WfMornTpjjmOYNQlysGiez
	 zz1YhNU30RRyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 2/4] netlink: specs: rt_addr: fix get multi command name
Date: Wed,  2 Apr 2025 18:37:04 -0700
Message-ID: <20250403013706.2828322-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403013706.2828322-1-kuba@kernel.org>
References: <20250403013706.2828322-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Command names should match C defines, codegens may depend on it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - fix the op name in the test
v2: https://lore.kernel.org/20250402010300.2399363-3-kuba@kernel.org
---
 Documentation/netlink/specs/rt_addr.yaml | 2 +-
 tools/testing/selftests/net/rtnetlink.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 3bc9b6f9087e..1650dc3f091a 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -169,7 +169,7 @@ protonum: 0
           value: 20
           attributes: *ifaddr-all
     -
-      name: getmaddrs
+      name: getmulticast
       doc: Get / dump IPv4/IPv6 multicast addresses.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 80950888800b..69436415d56e 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -12,7 +12,7 @@ IPV4_ALL_HOSTS_MULTICAST = b'\xe0\x00\x00\x01'
     At least the loopback interface should have this address.
     """
 
-    addresses = rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=True)
+    addresses = rtnl.getmulticast({"ifa-family": socket.AF_INET}, dump=True)
 
     all_host_multicasts = [
         addr for addr in addresses if addr['ifa-multicast'] == IPV4_ALL_HOSTS_MULTICAST
-- 
2.49.0

