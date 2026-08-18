Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C58446070
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045374; cv=none; b=JO33NHPagGHEqOW1Vr7dZoXn46ruzkK8i22fm8yyieQ8crdwOh84e35WH+i8mmFBvavURD6RQrjh/cpoX+bbQ45WPKZgdbr5PmfsLKW+1jFffNrtu/K/5MxybG4t1oy68cgntx3YPZ/ceWz6v9DIuKqSGXwBkrlQb53QOO1IJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045374; c=relaxed/simple;
	bh=L3FYYrOSyU5ETXCZXJJnq2QpjX/jt5aJmWW2ue91zfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIqzqAchz5NMMGYApl8gqX8qlhnIniMXZ2eChJmhFoDsjFwIvZ7vJBz41ppavsM2GMA9pEI+ArC/OPc5WWFByJ+Y0MKpe5lwsnvp2xWgTt6KECjUxLrX9tJvGEWNkKXdkMP6XsYz7qTMGes2ZJG6jHHKeGXw2jdgUdVXvR0QMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=0MjJHN3A; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="0MjJHN3A"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3D8D9201D3;
	Tue, 18 Aug 2026 11:29:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YqNJBE34Ur51; Tue, 18 Aug 2026 11:29:29 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D687920728;
	Tue, 18 Aug 2026 11:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D687920728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045368;
	bh=/uwX9P/e2NDlpTeL6Nts4OO8k7bWpySkX8p93hCIcaI=;
	h=From:To:CC:Subject:Date:From;
	b=0MjJHN3ArLxMT/4wHaiY32YJM3qudKo/Z/DBZEsDT9g9z5aXvLz8y0XUToaTwSwiH
	 Ae1fiSqgtTS+PpgRCONfJnD7xXN2fW7q39LqUk/KE/dRS/VNnvo7H6a8xkZo70NRRs
	 OfPe858M5thBEyE5ge92QbVmC6FjQq8cuKG8As6AgR6M4uZYvXNKBC9z8xIKwhgD/u
	 3QaXz5VZeG7f50oAt5RKZaBQy8JKbWEugbZVoxmsuFzfkXNcqginsfq54m5RJVLQim
	 +jDRubCZEijL+pk6lzVMhTQQBcu5/8ZSG3X3R90NWdH1rLwrGTFKEJytOGgnNVpES+
	 4tofaEcZt2ceQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:26 +0200
Received: (nullmailer pid 657478 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/10] pull request (net): ipsec 2026-08-18
Date: Tue, 18 Aug 2026 11:28:31 +0200
Message-ID: <20260818092920.653034-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

1) xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
   Tighten the secpath-depth check so a full chain can't write
   past xvec[].

2) Add and revert "esp: do not unref managed frag pages in esp_ssg_unref()"
   The patch does not fully fully resolve the issue, a corrected version
   will follow.

3) xfrm: espintcp: fix UAF during close
   Synchronize espintcp close with the xfrm_trans_reinject work
   queue so the freed socket message isn't dereferenced again.

4) xfrm: drop ESP-in-TCP packets with no ingress device
   Drop queued ESP-in-TCP records whose saved ingress device has
   gone away, avoiding a NULL device deref in the XFRM input path.

5) xfrm: avoid lock inversion in nat keepalive work
   Split the NAT keepalive walk into a reference-collection phase
   and a per-state lock phase to break the AB-BA with state removal.
   This patch has some issues that are fixed with a followup patch.

6) xfrm: Fix skb double-free in xfrm_dev_direct_output()
   Stop freeing the skb unconditionally in xfrm_dev_direct_output(),
   letting local_out()'s result indicate when ownership has moved on.

7) xfrm: ah6: validate routing header segments_left
   Validate the segments_left/hdrlen invariant before rearranging
   the routing-header addresses, avoiding an OOB memmove on
   malformed HDRINCL packets.

8) xfrm: fix xfrm_state_construct() auth-trunc leak
   Detect an already-attached auth-trunc allocation by the pointer
   rather than inferring it from the algorithm id, so a prior
   attach isn't overwritten and lost.

9) xfrm: bound nat keepalive state collection
   Replace the per-state allocation in the NAT keepalive walk
   with a fixed-size batch that drains under BH-disabled locking
   and resumes from the cursor, bounding the worker's memory.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:

  net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-08-18

for you to fetch changes up to 4e9442ce551ebd84b52ad649df721e2dc28af95a:

  xfrm: bound nat keepalive state collection (2026-08-18 07:35:01 +0200)

----------------------------------------------------------------
ipsec-2026-08-18

----------------------------------------------------------------
Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sanghyun Park (1):
      xfrm: Fix skb double-free in xfrm_dev_direct_output()

Steffen Klassert (1):
      Revert "esp: do not unref managed frag pages in esp_ssg_unref()"

Xiang Mei (1):
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (3):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak
      xfrm: bound nat keepalive state collection

 net/ipv6/ah6.c                | 29 ++++++++++++++---------
 net/ipv6/xfrm6_input.c        |  2 +-
 net/xfrm/espintcp.c           |  9 +++++++-
 net/xfrm/xfrm_nat_keepalive.c | 53 +++++++++++++++++++++++++++++++++++--------
 net/xfrm/xfrm_output.c        |  4 +---
 net/xfrm/xfrm_user.c          |  2 +-
 6 files changed, 73 insertions(+), 26 deletions(-)
