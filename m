Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C2334C1D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307844; cv=none; b=iPZPiKiwMqYdmTFSN6SVE0KMkfQQiVI7Y8Ime9nx0NtzSEs36Mp8SiIzslZSyfXhNH10bjLJfOwhynURkS/WlEbsg3M8FmRJ1yatId8AjhKl4bKgnyGtxPOi9scxEhVepzW10ISYikmfvegrQ76YSMTZol7AEgYZwEJSDgalgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307844; c=relaxed/simple;
	bh=0gAdO/SwN8Fp58wkZDB0kZjqmSJEq4AXmgOgIMcTAiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngYNOSA6aiau76jgMb1qIPrz51KBfzP2rUJXSZZTJ3KIaDbdmWAHskhSpzz6NXFlCQbsrvOrfuBKM+UNGh9KXkpD9XukpnnfJBuu9kLloB+D/1FagzJa9HxrFuacTeW94UvOASd/O2VJ9TT50Yq8VA4JTz8560KkPhSc5Kh+p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LTvKZyHX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LTvKZyHX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A87FD207B2;
	Wed, 29 Jul 2026 08:50:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1zmSqaRHO00V; Wed, 29 Jul 2026 08:50:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 12658206BC;
	Wed, 29 Jul 2026 08:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 12658206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307839;
	bh=2P4tFeQkFbTndjB4sG+qvM+qwToEMTsyZ/hkEritd74=;
	h=From:To:CC:Subject:Date:From;
	b=LTvKZyHXCJcfIhaUeVI9BiEa2ZyNHaGpe6A4P/+yFgnSjDWyTIxm/VCven0r6Q/s7
	 oJZrgYblJqHGpEKa+oNyiLyBGdvRaT2B/Un11A89Rxwa8TJaJfUhGyIBRPn4TvEBs7
	 toVPjlpsX0zuqIgwko2o+Omj4ctMg1Tykr8JLWN1EPkaJVVBn/LKOh/5HnJQ5tUWq3
	 VjRAGBhT2ReZgy7soMXaZA6MtMz6oh5vkTk1DPI1rkPEv1CZIsOsmCbcN9SvsngnZE
	 Xn9CXe92cGG7lg/HD0AbImzd6qkPZJTy0CPbg5BL6xJaeBAQj0JHlzsNF5Vg6mr5qF
	 L4XKXZXksRUrw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:38 +0200
Received: (nullmailer pid 1592273 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/8] pull request (net): ipsec 2026-07-29
Date: Wed, 29 Jul 2026 08:50:10 +0200
Message-ID: <20260729065035.1591985-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

1) xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
   Fix an off-by-one in xfrm6_input_addr() secpath depth check
   that could write one slot past xvec[].

2) esp: do not unref managed frag pages in esp_ssg_unref()
   Skip unref in esp_ssg_unref() for managed frag pages, avoiding
   a page-ref underflow when frags are owned by a zerocopy ubuf.

3) xfrm: espintcp: fix UAF during close
   Serialize espintcp_close() with xfrm_trans_reinject so the
   saved skb isn't freed while still in use.

4) xfrm: drop ESP-in-TCP packets with no ingress device
   Drop ESP-in-TCP records whose saved ingress device can no
   longer be resolved, avoiding a NULL deref in the XFRM input path.

5) xfrm: avoid lock inversion in nat keepalive work
   Walk the state table under xfrm_state_lock but defer per-state
   x->lock acquisition until after, avoiding an AB-BA inversion
   with SA deletion.

6) xfrm: Fix skb double-free in xfrm_dev_direct_output()
   Return local_out()'s result from xfrm_dev_direct_output()
   instead of freeing the skb unconditionally, avoiding a
   double-free when netfilter or another consumer takes ownership.

7) xfrm: ah6: validate routing header segments_left
   Validate routing-header segments_left before rearranging it
   in AH6, avoiding an OOB read on malformed packets.

8) xfrm: fix xfrm_state_construct() auth-trunc leak
   Track the allocated x->aalg directly in xfrm_state_construct()
   so attach_auth() doesn't overwrite and leak it.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:

  net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-07-29

for you to fetch changes up to c12cbf56320fb633484ee0ca1fb7d68d6b64b213:

  xfrm: fix xfrm_state_construct() auth-trunc leak (2026-07-28 10:48:18 +0200)

----------------------------------------------------------------
ipsec-2026-07-29

----------------------------------------------------------------
Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sanghyun Park (1):
      xfrm: Fix skb double-free in xfrm_dev_direct_output()

Xiang Mei (1):
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full

Zhiling Zou (1):
      xfrm: drop ESP-in-TCP packets with no ingress device

Zihan Xi (2):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak

 net/ipv4/esp4.c               |  7 ++++++
 net/ipv6/ah6.c                | 29 +++++++++++++---------
 net/ipv6/esp6.c               |  7 ++++++
 net/ipv6/xfrm6_input.c        |  2 +-
 net/xfrm/espintcp.c           |  9 ++++++-
 net/xfrm/xfrm_nat_keepalive.c | 57 ++++++++++++++++++++++++++++++++++++-------
 net/xfrm/xfrm_output.c        |  4 +--
 net/xfrm/xfrm_user.c          |  2 +-
 8 files changed, 91 insertions(+), 26 deletions(-)
