Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606688;
	b=K7gZXIj0PYAm0Gq4MPQ3k9nBtBIWWGRvM73hn0+Vl+pO+wNvuS1D5m4WrYXfxrvW2HN2
	 ZLUpBKpvuxkdPG32nfXBSzFYXrGULN2JlHhSwuLPbfQ0BiLKRBVwvE9e2whT1dcf7h6WX
	 Wxto2oCo/jrSA+AmkMFgJ72Bcb0tqbCjTJniUHXAgL1C07bIKz9AWlPiax/1j4Eryy+fU
	 z3yByES4De6EefGCjfkihatNFFCljE2A6I5g95JnnEQUcfrxAZTQhEBzzF+mjh5q3CNpC
	 NSqWXQyEwhlEFGUoWa8eCDd5POFd3jeieyn9UHLL4sjYT+RGyn0Z+dH04DyVjOBBipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606688;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy;
	bh=6RJ0CQHp/QxtCPIy96jcHfDUTMuiRv/YGBWzxp706Ow=;
	b=W2IHhc2aAnETxSO1bJQDJtQhnXJObsAYQpRMhfKfu83y/BWcnp+P2HTgyzCJDtDXFBsV
	 XAuIeqYan8FodnrvSFwNp83JnlpPJ//B4z5gplqBqPenz7oQsaAgFQZAyfgQCmmk/tFso
	 /nvZ3XQavJnAzXmArqnVtObnFFnXELQJg3j74PGjlLaTVpQMIHnlfNFu6UNAfBC7ApusZ
	 xrUtkZWaIjWLku/tO2yIjXqY8WMTBC/BwxBEG3wbm2OL39f/07LpqiDoVt4F6Z5wPYRsv
	 9NUH/Xu2m6roKW8fcwvTIGHLsOLnYsqnux3hMG1OfJi0fAU0KvqMqZaT/iZ1a/lVHFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=pMWSg15B;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2B606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B2B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=pMWSg15B
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 53ED220799;
	Mon,  2 Nov 2026 09:04:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54K2tooOxFF5; Mon,  2 Nov 2026 09:04:38 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4DAA5207BE;
	Mon,  2 Nov 2026 09:04:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4DAA5207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606678;
	bh=6RJ0CQHp/QxtCPIy96jcHfDUTMuiRv/YGBWzxp706Ow=;
	h=From:To:CC:Subject:Date:From;
	b=pMWSg15B6HqiqO0o/bV/nLiTdl0retf56R6axpfqFH4JhYyUEFr/Z+6OY0n3EFnvm
	 HeJOM4Po8jQph73OpCwlbPTbwcnghU2JkuFtFDelx68gG4CewSvdo6R6qRxvIU2x6x
	 o8wAiwjl3i9O3x3I5q3bpM79jI1TPivgCwXfKDg4Lu18uhhnRXZPB9mO04l5gQa2Cs
	 EIOY9JVzxuRgXPTtyLhwIi+YpJ2amFpneYS6j29sEJjH5+003GjHK6bpyKimay5Y7T
	 c++jAWBrPACSLJdHPB3ssuTpXJ5x491EuZhimITGXWgWNU6CZ6M+m9b8rca2xNmwmw
	 3eTqd4qJvdRRw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:37 +0100
Received: (nullmailer pid 2505887 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/14] pull request (net): ipsec 2026-11-02
Date: Mon, 2 Nov 2026 10:03:58 +0000
Message-ID: <20261102100451.2505200-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

1) xfrm: retry inexact policy lookup after node reinsertion
   Detect a concurrent change of the inexact policy tree while it is
   searched and retry the lookup, so an insertion can't make it return
   the wrong policy.

2) xfrm: interface: validate the IP header on xmit
   Validate the IP header in xfrmi_xmit() like the IP receive path
   does, so packets injected into an xfrm interface can't reach the
   output path with a malformed header.

3) xfrm: zero-initialise km_event in the replay-notify path
   Zero-initialise the replay event so the netlink header of a
   kernel-originated replay notification no longer carries
   uninitialised stack values.

4) xfrm: espintcp: reorder operations within espintcp_init_sk
   Publish the ESP-in-TCP context before installing the socket
   callbacks, so an early callback can't dereference a context that
   isn't set up yet.

5) xfrm: state: reject mark with bits outside its mask on add
   Reject a mark with bits outside its mask on state insert instead
   of silently truncating it, so a lookup can't be given a mark that
   never matches.

6) xfrm: state: reject mark with bits outside its mask on ALLOCSPI
   Apply the same mark validation to ALLOCSPI, keeping the state and
   policy insert paths consistent.

7) xfrm: policy: reject mark with bits outside its mask on add
   Apply the same mark validation to policy insert, so a policy can't
   be stored with a mark that never matches.

8) xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
   Match mark and mask exactly in the SPI-keyed netlink SA lookups, so
   a catch-all SA can no longer shadow a more specific one.

9) xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
   Hold the cloned state for the whole migration, so a concurrent
   delete can't free it while it is still in use.

10) xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
    Remove the hardware offload of the cloned state on the migration
    error path, so the offloaded SA entry isn't leaked.

11) xfrm: include mark in MIGRATE_STATE SA collision check
    Include the mark in the SA collision check, so a migration that
    only changes the mark can't install a duplicate SA tuple.

12) xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
    Pass the extack to xfrm_init_replay(), so replay window errors can
    be reported to userspace.

13) docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple
    Document the mark as part of the EEXIST tuple of the SA migration
    request.

14) xfrm4: use a full socket for local errors
    Resolve the socket owner with skb_to_full_sk() in the IPv4 local
    error path, so a TCP request socket isn't used as a full socket.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit c9151088f1674fd29ff26a20f5fc687acf53a2f0:

  Merge branch 'net-psp-avoid-conflicts-with-skb-decrypted-and-sk_validate_xmit_skb' (2026-09-16 19:18:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-11-02

for you to fetch changes up to 5def91015ba7b59de62a81384572da7281b8a033:

  xfrm4: use a full socket for local errors (2026-10-27 09:09:36 +0000)

----------------------------------------------------------------
ipsec-2026-11-02

----------------------------------------------------------------
Antony Antony (9):
      xfrm: state: reject mark with bits outside its mask on add
      xfrm: state: reject mark with bits outside its mask on ALLOCSPI
      xfrm: policy: reject mark with bits outside its mask on add
      xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
      xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
      xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
      xfrm: include mark in MIGRATE_STATE SA collision check
      xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
      docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple

Chengfeng Ye (1):
      xfrm: retry inexact policy lookup after node reinsertion

Fourie Zhang (1):
      xfrm4: use a full socket for local errors

Qihang (1):
      xfrm: interface: validate the IP header on xmit

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Shubham Antil (1):
      xfrm: zero-initialise km_event in the replay-notify path

Steffen Klassert (1):
      Merge branch 'xfrm: state: exact mark/mask match for control-plane SA lookups'

 .../networking/xfrm/xfrm_migrate_state.rst         |  25 +++--
 include/net/espintcp.h                             |   5 +-
 include/net/xfrm.h                                 |   7 ++
 net/ipv4/xfrm4_output.c                            |   7 +-
 net/xfrm/espintcp.c                                |  43 +++++----
 net/xfrm/xfrm_interface_core.c                     |   8 ++
 net/xfrm/xfrm_policy.c                             |  14 ++-
 net/xfrm/xfrm_replay.c                             |   6 +-
 net/xfrm/xfrm_state.c                              | 101 +++++++++++++++++----
 net/xfrm/xfrm_user.c                               |  81 ++++++++++++-----
 10 files changed, 220 insertions(+), 77 deletions(-)
