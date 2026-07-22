Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFE31DDBB
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680198; cv=none; b=f+DJJrCSCXkCaXSiv036ULB4jwKIXIAOPGNoQuKOXlugO26NpPGQ6nsyGMUA2L435mzW8V7nVwJQhaxJloeCTqVXHbBQZQ5+EcNhdZXQIrPunndqyYX4NVNcbrwlpti7rqpGFyDswbx1MXtbiYQ0yJ0Kq36bT2pVhOaB1Lhc3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680198; c=relaxed/simple;
	bh=7vDHYv30wJHT/6LezK03SZspW8RG2aPdp5QyQsiXGSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+slHQxumpcFioCFEumaKSWRYPLO5EC2j8iOi0pGvDxA9mmB2lQIGatyL0U6UAz+TrncGsFYn6+Q7hclCX+VkoAOAVT8JbXVSNUHJTeMQTHL6aLpRUtSpaeiid/XbrNutGXKQRncnL8lSHlkUIGrhmPllnJ3tM4Uh290SJXUWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=sOjr64dK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="sOjr64dK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so6414870a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784680194; x=1785284994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvjGXQh7PPsiiZLRJglIcvVKWgOE/daorW5Ue+wTsgw=;
        b=sOjr64dKGx9UgA8TulDyC6td4EUMx3oOS2/gcb6Kt9O9f8XpwTywWGzgWasWqoIrzG
         Jo99K0DY1wOrYJVWK22w/w6L96AJuvuDcfVHa1ySmlxm9vRbAKP7BdpYai6151HoZTWv
         IzFd+5Nk8xMUX6p1w/4QBOe5Am+TYJIU6xnRc0bZZNSUTb1ZK6MGnaUA3WIimVR3vcbB
         ENbaqozxA/l4CXRr8k2xNlTAxxw1Cbj73mmDQS0Asz3tmmIh2Sy6XPqzGsLvnPocyMkw
         KbuSJqMANT4KKmhe/nMdSaKMz3kBDIVj+tzw6cXI3Eux2xuTTSMpttjOtRJ8WkG1d7w/
         kEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680194; x=1785284994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvjGXQh7PPsiiZLRJglIcvVKWgOE/daorW5Ue+wTsgw=;
        b=aZIaa+hFZfMvIX2nCqk4kpEMYppn8X0AGgzZXAgl0O6tHGo+6f/Ky/p3EjQUsrnx/M
         WDOIWqo41j5SYa65WlYQspubrkJ5a017JInfoHBkrEq89cRymvSvuP+nLGv7aUGkOp0C
         AbObDz/tzfQZW19sNSD0dreRRVHMRNBfKJ7SgRVsL2eiQ4ySi3J8pn1qGjmGZ2XpdzvQ
         HIkYYblb3bibVgueMry/LME2InmDkN8hgxnk42wz1MdmVA4qZgMFx8XVOCxNjIiOVSBB
         gUTWoNbXRWFZzI27pgQzOOXNtPoXL2ioDgIrJUzCIJnRJ8CJ1LB3WFFbLbweE+uftpB0
         busw==
X-Forwarded-Encrypted: i=1; AHgh+Rooh//9zFDpDthLBoEcqfcMS532rFBIGJ4ijJNib7sQDigZihB0AmE37uYC/nibWb3eYazc+Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BZVrLBuLfPKZBk1DV6KfhV6s7nC0rvSotV6dyvWb6gx4pfHX
	UbXBCtuMEetngC+CGw5aUQBxCHeJ7g3FJNRMcbKvn8tM7asJlV60xLZ+Zk9jbTa8aw==
X-Gm-Gg: AR+sD10yGBpBz2AP4ccZEJi5bT+AeyMBwl+PBdgUZ7exkWvLymdSokSjiVepve0hk3o
	EnLL1xmiOC6z+V2b1LaVDI/rEkCkiYjLkgFbr9frO1m+WcxO/z9/zeGBNxChTzzWc6s2JGp7sT6
	Z5Cf+unXRFz7IltuD3P90Wo/Ol5utzJ8d21fJsEtNqKsuMx69fcfaC+Y03hV4U0oAtv8Q/NQ83S
	caxL+SSI0KaN0QLghAQxKh/9ztqugPYFE7+OdP/aZuhhVlGL4L1BX/c0+GwJNo8mT1cyt5o1/jj
	irrCtt8PqvLzSEfzFIFFIe9WMYOTvsepEVhkKWqDPoe1fJ8JxeeZa/PLv/pudyIgbnmFAhOoVWS
	ad0WQdl+SGiuyrsZAi3nehFVabhnnJTj9HcyBTRGVw0aT4a14tFy/4YzjVPcE+o1Yoia4F2Miiy
	TvPcrVHpQ=
X-Received: by 2002:a17:90b:2b4c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38e4b3e1313mr21403938a91.8.1784680193843;
        Tue, 21 Jul 2026 17:29:53 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a8421sm558863c88.10.2026.07.21.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:29:53 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net 1/2] nexthop: take nh->lock for f6i_list walks in replace check and notify
Date: Wed, 22 Jul 2026 00:29:50 +0000
Message-ID: <20260722002951.2614721-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib6_check_nh_list() and __nexthop_replace_notify() walk nh->f6i_list
during an RTNL-serialized nexthop replace without holding nh->lock. IPv6
RTM_NEWROUTE/RTM_DELROUTE run without RTNL and mutate that list under
nh->lock (fib6_add_rt2node_nh(), fib6_purge_rt()), so both walks race a
concurrent route delete that unlinks and frees a fib6_info:

  BUG: KASAN: slab-use-after-free in rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
  Read of size 4 at addr ffff888014607e64 by task exploit/143
   rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
   fib6_rt_update (net/ipv6/route.c:6412)
   __nexthop_replace_notify (net/ipv4/nexthop.c:2542)
   rtm_new_nexthop (net/ipv4/nexthop.c:2554)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)

  BUG: KASAN: slab-use-after-free in fib6_check_nh_list (net/ipv4/nexthop.c:1605)
  Read of size 8 at addr ffff888014a7d068 by task exploit/142
   fib6_check_nh_list (net/ipv4/nexthop.c:1605)
   rtm_new_nexthop (net/ipv4/nexthop.c:2575)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)

Both walks only read the entries and take no tb6_lock, so protect them
with nh->lock; fib6_rt_update() uses gfp_any(), which returns GFP_ATOMIC
under the lock.

Fixes: 081efd18326e ("ipv6: Protect nh->f6i_list with spinlock and flag.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv4/nexthop.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57aa85..c1d3b7d7100d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1597,14 +1597,21 @@ static int fib6_check_nh_list(struct nexthop *old, struct nexthop *new,
 			      struct netlink_ext_ack *extack)
 {
 	struct fib6_info *f6i;
+	int err = 0;
 
 	if (list_empty(&old->f6i_list))
 		return 0;
 
+	spin_lock_bh(&old->lock);
 	list_for_each_entry(f6i, &old->f6i_list, nh_list) {
-		if (check_src_addr(&f6i->fib6_src.addr, extack) < 0)
-			return -EINVAL;
+		err = check_src_addr(&f6i->fib6_src.addr, extack);
+		if (err)
+			break;
 	}
+	spin_unlock_bh(&old->lock);
+
+	if (err)
+		return err;
 
 	return fib6_check_nexthop(new, NULL, extack);
 }
@@ -2538,8 +2545,10 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 			fi->nh_updated = false;
 	}
 
+	spin_lock_bh(&nh->lock);
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
 		fib6_rt_update(net, f6i, info);
+	spin_unlock_bh(&nh->lock);
 }
 
 /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
-- 
2.43.0

