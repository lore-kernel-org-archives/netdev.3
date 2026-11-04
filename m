Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772878;
	b=YL8/z3+3GSbSJAfavbYAz0cf5D+2o9PZj2f6UPaKRDXabNKcT2r1CC8E/JSdj0L+8Ll1
	 sHO9fkA/tQaWzBeoaOtTFOjMdhWwQX+vo2xT+sRrCDhHB1NUhGrTYVOzx0InHECmk3tRi
	 ccDhgeCGhpC6MYShtYI5rnJN75UeKaXhgh5vhJr4KKYfsRSntSK4NL+RXdPYoCSEGeTHO
	 vth6XPsMzFRwkeCeoIKd3ArinhbCENhoLLjHse0pSwBvVmo41L47JIRwF6kRSWzELbAWH
	 hpiLBdadeIpLYb1QWAEtBE9P3G0uWaXaUHefvJReZXmYnt95CUdb5QJ93Bh4bhlD7dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772878;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CvfPGziobIrEteIOatX8FyBV7rtb7GgNQIea2gIpbyE=;
	b=Du4bCuHkODjJwY8LRqDFh1k4ULj6z3zAqx/ETeCxYdfmdLegVe6SLA4UioRdnVI80198
	 zwpEgXn4OypAiC4xcehtr/Y1cHCGmmVrgVxC7ld1HorncFvlTeDzZ3Cq9SdE3wsrdSJ0j
	 1RF8W27TcWUUpyzPqQRnC8c1JnbjEukqJC0WeVfwjwl28uV3P9YPR6pn5NkXWC6rKL/rF
	 2Vhys6qHeej5f+fX7VftiQ3Pc477kvsenGyQ956E2O9shHV+TcuD8+XJSlRBdqoMml8Q0
	 onNDf1xjQbZ7BV3LQNPH415s0yJ2lp0lxRFoTIgZfFAX/epBNJFnpdq+SzQuj+vDpqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pzgmwfbB;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A2606A326;
	Wed,  4 Nov 2026 06:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B7A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pzgmwfbB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pzgmwfbBkhN8kkiIQ31P4oJtjcaXPTVCQGoK7E5QgQMNbCDdemW/0QNd5uyezKyBxX1Ztq55FaoYf
	 Dn9YKGgffjVcPB96gb70iuEVmhBxpRguXS9uNpOG4lBjrrhxANBRd4/ijA1ROcL5EKwKNeQy+QaLSB
	 tSzVKA6Pg1fCrkqA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aeacd47e2b-661a6;
	Wed, 04 Nov 2026 14:14:32 +0800 (CST)
X-RM-TRANSID:2ee36aeacd47e2b-661a6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aeacd47cf2-161b3;
	Wed, 04 Nov 2026 14:14:32 +0800 (CST)
X-RM-TRANSID:2ee56aeacd47cf2-161b3
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net-next v2] ipv4/ipv6: preserve multicast filters after a failed source leave
Date: Wed,  4 Nov 2026 14:14:19 +0800
Message-ID: <20261104061419.87989-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

After joining a group with IP_ADD_MEMBERSHIP or IPV6_JOIN_GROUP,
MCAST_LEAVE_SOURCE_GROUP for an unjoined source returns EADDRNOTAVAIL
but switches the socket's filter mode, so the existing membership stops
receiving. Leaving and rejoining the group restores reception.
IP_DROP_SOURCE_MEMBERSHIP has the same problem.

ip_mc_source() and ip6_mc_source() allow an empty-filter mode switch before
checking whether a source list exists for deletion. The failed request
changes EXCLUDE {} to INCLUDE {}, so the socket no longer accepts packets
from any source.

Check for a missing source list before changing the filter mode. Preserve
EADDRNOTAVAIL for the rejected deletion and keep mode switches for valid
source additions.

Found while reviewing the error paths of ip_mc_source() and
ip6_mc_source().
The reproducer uses socket calls without kernel changes or fault injection.

Tested with a UDP socket reproducer under UML using the IPv4 generic and
legacy APIs and the IPv6 generic API. All three paths lose reception
before this change and keep receiving with the fix. Source joins and
leaves, block/unblock, last-source leave, and ordinary leave/rejoin also
pass.

W=1 x86_64 builds with derived allmodconfig and allyesconfig configurations
also pass, with no changes to the warning sets.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---

Changes in v2:
- Target net-next and drop the Fixes and stable tags, as requested by
  Ido Schimmel.
- No code changes.

v1: https://lore.kernel.org/netdev/20261030063603.697510-1-yanxia@cmss.chinamobile.com/

Validation was performed for v1 on net fcc00b15cb21a6de76826e5012b2c758505f5e65.
The two modified files are identical at the net-next base commit.
For the x86_64 builds, the derived configurations disable WERROR and
KASAN; the derived allyesconfig also disables KUNIT_ALL_TESTS. The complete
before/after warning sets are identical for each configuration.

 net/ipv4/igmp.c  | 7 ++++---
 net/ipv6/mcast.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 144fca1..9c38045 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2520,6 +2520,10 @@ int ip_mc_source(int add, int omode, struct sock *sk, struct
 		err = -EINVAL;
 		goto done;
 	}
+	psl = rtnl_dereference(pmc->sflist);
+	if (!add && !psl)
+		goto done;	/* err = -EADDRNOTAVAIL */
+
 	/* if a source filter was set, must be the same mode as before */
 	if (pmc->sflist) {
 		if (pmc->sfmode != omode) {
@@ -2534,10 +2538,7 @@ int ip_mc_source(int add, int omode, struct sock *sk, struct
 		pmc->sfmode = omode;
 	}
 
-	psl = rtnl_dereference(pmc->sflist);
 	if (!add) {
-		if (!psl)
-			goto done;	/* err = -EADDRNOTAVAIL */
 		rv = !0;
 		for (i = 0; i < psl->sl_count; i++) {
 			rv = memcmp(&psl->sl_addr[i], &mreqs->imr_sourceaddr,
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ecef55f..2ade335 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -395,6 +395,10 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		err = -EINVAL;
 		goto done;
 	}
+	psl = sock_dereference(pmc->sflist, sk);
+	if (!add && !psl)
+		goto done;	/* err = -EADDRNOTAVAIL */
+
 	/* if a source filter was set, must be the same mode as before */
 	if (rcu_access_pointer(pmc->sflist)) {
 		if (pmc->sfmode != omode) {
@@ -408,10 +412,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 		pmc->sfmode = omode;
 	}
 
-	psl = sock_dereference(pmc->sflist, sk);
 	if (!add) {
-		if (!psl)
-			goto done;	/* err = -EADDRNOTAVAIL */
 		for (i = 0; i < psl->sl_count; i++) {
 			if (ipv6_addr_equal(&psl->sl_addr[i], source))
 				break;

base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.39.0.windows.2



