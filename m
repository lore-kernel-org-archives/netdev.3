Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37935AC0E;
	Tue,  6 Oct 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270220; cv=none; b=uxkKvuwLbIHyK13C7AmFP/3wSrjFNJy6QZuCL0gOy7JqxygAkIBakkYRFNzRNWd1WMy5lbkXzd5yqKtUJ+CsueXNDt8fNEolB7QJWxKbfdWlEssSNHSzDHegg8rEVROyOQ1kjixR5e+kqgyD7lrV41TAxnVPfvIeC/QrKZn8AuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270220; c=relaxed/simple;
	bh=LlKfrJ1WtrfDdFmcf1k+ByL6a8VyZHha9YzY7BKXGRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TOz8yIpQzzhQqrXEmlfN9Kh+ii1pDpMYM/QeWLjOl8sNeCfUkXp/bo8pukiSjZmwPVCMBRucWZSsGBEK1hm45qtd9Ku7fHRWug8x2xVYDkhedxk77vTBTBsFCTAeGnlLz+Uajbak3RcMIEe/+TpLqog5nMImL+mCRFMwlOj9PJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Bkd9Xfoc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Bkd9Xfoc"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 49A6A20844;
	Tue,  6 Oct 2026 09:03:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nppFf9WWM_jJ; Tue,  6 Oct 2026 09:03:32 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 902F220719;
	Tue,  6 Oct 2026 09:03:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 902F220719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270212;
	bh=NR1D7OhiTibJGz0il/urzfzlktoxnY8udm4EkhrqyJU=;
	h=From:To:CC:Subject:Date:From;
	b=Bkd9XfocnzjoF2y/QquErA7R2eHLUT/V630jZ3q1GVRuLcbWhwEgLLr/CqCIPOLvY
	 01T0um1NTgGoDPT0FuMG2snPGN0CdEjgVtGFH1yHk2GfiHjuHYeopObo9ys+f1UpTm
	 IFBipA/fN1OVjyB6gVFhQ7u8onWvbtHXg6JR4PG9jqSPEpZD6jirPQJowclVxfEZ3W
	 6u6ynaqa1HXP4zMc0cb8c2GPhcVDztUp6vG5lqkAShWeeBj6rRssSEKZGFwn2vQIGA
	 5Cof/ZpKOsxsMXTBiS6hp/A8xSMXdHjTtYER2tls7pxO5WN/nrMeORdn4/wpSuqOnr
	 QcEy05hE5lVoQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:03:31 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable+noautosel@kernel.org>, Sashiko
	<sashiko-bot@kernel.org>
Subject: [PATCH ipsec v4 0/9] xfrm: state: exact mark/mask match for control-plane SA lookups
Date: Tue, 6 Oct 2026 09:03:15 +0200
Message-ID: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
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

Also reject marks with value bits outside the mask (state add,
ALLOCSPI, policy add). These are misconfigurations anyway, since
the extra bits can never match, and break exact match added here.

This series does not touch PF_KEY, which no longer receives
non-critical fixes.

state_lookup_byaddr is out of scope. This is only fixing spi based
lookups.

---
v3->v4: add 3 patches to reject mark value bits outside the mask for state and policy

- Link to v3: https://patch.msgid.link/migrate-state-fixes-v3-6-836125bb53dd@secunet.com

v2->v3: mark match use only values and no mask in exact lookup

- Link to v2: https://lore.kernel.org/all/migrate-state-fixes-v2-0-c3e2767f0d96@secunet.com/
v1->v2: few more wildcard mark check reported by sashiko and Yan
      - keep wildcard match in xfrm_state_update() (UPDSA)

- Link to v1: https://patch.msgid.link/migrate-state-fixes-v0-8-a69e8637ba3b@secunet.com

To: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
To: Louis DeLosSantos <louis.delos.devel@gmail.com>
To: Jamal Hadi Salim <hadi@cyberus.ca>
To: Antony Antony <antony.antony@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

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
 net/xfrm/xfrm_state.c                              | 101 +++++++++++++++++----
 net/xfrm/xfrm_user.c                               |  81 ++++++++++++-----
 4 files changed, 166 insertions(+), 48 deletions(-)
---
base-commit: 86de3a1118a16dbbbe5fabe9aa20ffb93c072ed5
change-id: migrate-state-fixes-063ee0342611

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

