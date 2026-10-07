Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA7472F60;
	Wed,  7 Oct 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365688; cv=none; b=nfQGKJ5vQMS0GS6Bdk1s4RMfxVVtUChtRkiGlP77manA55Z1QP25l0wzU+EUhQJT3mpt/9367rbRmu5gcYM/b3Ml9LiuuLRypb8clERg/IZ1hLrtztvFjAFmLJA0AqXNHqQGo9YSOmUGu5otwZM/LEQPSZaOlQzjklmD4tVPYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365688; c=relaxed/simple;
	bh=B4t87OPPrBWFtF8Zvkeqld72opW5xTPovELNKS4HIyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7i7NgIgAT/y6Muxi2Wpg9tLYiuPZ3XAIgJzIFb88c2wqVahvLwm2ZG7S7Ib/IghGKubyZY+LlhFbLoWc4eD0WXlywsi18I83tCzEDUYcJKviR9wgSMy97n/wtVkOBDenh6J5Fe2ZZo0mfErysaP7LuQiPGLbddTb2g3DzmxSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yBSvw+7h; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yBSvw+7h"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 66EDD207B3;
	Wed,  7 Oct 2026 11:34:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ergP5rW1aZBK; Wed,  7 Oct 2026 11:34:28 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 68A1B20764;
	Wed,  7 Oct 2026 11:34:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 68A1B20764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365668;
	bh=1x6T6/E9cQ3auVKfuusxtpwsh/uuy4Y01QN+oeQwJsY=;
	h=From:To:CC:Subject:Date:From;
	b=yBSvw+7hu2RPP/Zk9pklaq8+5GOQiuJjYnD7S+zRgNLr7dYgFPWvNSSduvFe9Ialk
	 ZsrHn0TSv4JJiUcqhdv3sS0mPjNDuwvKihIQA+DOfWe4lUo+Z9tmenDeW4w+ZT53AW
	 fN8cQzGAShfbL3pvMhdxIrydAG9fXU7ouMMS3W4PtMs7BFgjwlSHYIbC4DsoNPHmFk
	 2+Lu1gmzPShmIbHqd5X/gQCDs2NU1uAp32D+6E2citRNdLMvlBBZnfohVInO2s9srH
	 Z0AulFXFAp1CfY+xVR9uohwiDoq1Wmibk1qTnd3D7xq6A47OugWCWU4pWFyHGJFFCv
	 0uLXJPPvFuuwQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:34:26 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<stable+noautosel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH ipsec v5 0/9] xfrm: state: exact mark/mask match for control-plane SA lookups
Date: Wed, 7 Oct 2026 11:34:13 +0200
Message-ID: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: migrate-state-fixes-063ee0342611
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

While looking into a XFRM_MSG_MIGRATE_STATE issue reported by Sashiko,
we found the underlying problem generalizes: xfrm allows multiple SAs
to coexist for the same (SPI, daddr, proto) differing only in mark,
and every netlink method that resolves "which SA" - xfrm get_sa(),
del_sa(), update, get_ae, new_ae, expire, migrate - uses the same
wildcard mark match the data path needs. A broader-mask SA can
silently shadow a more specific one:

  # ip xfrm state add ... spi 0x1000 mark 1 mask 1 (SA_target)
  # ip xfrm state add ... spi 0x1000 mark 0 mask 0
    (SA_decoy, catch-all, added after -> bucket head)
  # ip xfrm state delete dst ... proto esp spi 0x1000 mark 1 mask 1
    -> deletes SA_decoy; SA_target survives, untouched

xfrm policy had the same bug, fixed in commit 4f47e8ab6ab7
("xfrm: policy: match with both mark and mask on user interfaces").

Netlink state lookups using spi use an exact mark/mask match except
for UPDSA; the wildcard match stays for the data path and state_add only.
This series applies that fix across every affected method,
not just XFRM_MSG_MIGRATE_STATE.

Also reject marks with value bits outside the mask (state ADD,
ALLOCSPI, policy ADD, MIGRATE_STATE new mark). These are
misconfigurations anyway, since the extra bits can never match, and
break exact match added here.

This series does not touch PF_KEY, which no longer receives
non-critical fixes.

state_lookup_byaddr is out of scope. This is only fixing spi based
lookups.

---
v4->v5: policy: drop the redundant mark sanitize in xfrm_policy_insert()
      - tweak commit messages

- Link to v4: https://patch.msgid.link/migrate-state-fixes-v4-0-d5054459fc78@secunet.com
v3->v4: add 3 patches to reject mark value bits outside the mask for state and policy

- Link to v3: https://patch.msgid.link/migrate-state-fixes-v3-6-836125bb53dd@secunet.com

v2->v3: mark match use only values and no mask in exact lookup

- Link to v2: https://lore.kernel.org/all/migrate-state-fixes-v2-0-c3e2767f0d96@secunet.com/
v1->v2: few more wildcard mark check reported by sashiko and Yan
      - keep wildcard match in xfrm_state_update() (UPDSA)

- Link to v1: https://patch.msgid.link/migrate-state-fixes-v0-8-a69e8637ba3b@secunet.com
---

---
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

 .../networking/xfrm/xfrm_migrate_state.rst         |  25 +++--
 include/net/xfrm.h                                 |   7 ++
 net/xfrm/xfrm_policy.c                             |   3 -
 net/xfrm/xfrm_state.c                              | 101 +++++++++++++++++----
 net/xfrm/xfrm_user.c                               |  81 ++++++++++++-----
 5 files changed, 166 insertions(+), 51 deletions(-)
---
base-commit: 86de3a1118a16dbbbe5fabe9aa20ffb93c072ed5
change-id: migrate-state-fixes-063ee0342611

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

