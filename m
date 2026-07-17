Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA953BBFDE
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327016; cv=none; b=UU9Pr74SD7S2SfB6SQlHYTXEiwz++XhqPuhYGfa2DxcEEAHCLfhBd6pqHPJ46TnhxLSQbnDTolR3lRahgvdBhbtSkMthom6jbxg+Sh2BoLlklkMxQOMfrD9nBUB0iCUyRRZfr2syIqOBeeG7EZe6U0CO3sXkBL1weSsmuKC0+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327016; c=relaxed/simple;
	bh=aQ8xeKK/QEDNrvP4rM1dRQxJyepWfSl7EFB27FzfcqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQsqzxlPZFAnuka1mCbz659TrFRaQaYsD2A9O9NgjzuTK5gtSiafKb6r/bOc3PWlHPord7MxgXIuIEFMJ+NyH+W0BtOK3xvrlcO1bpnDa/hHA5Nx7m59HlpuN5OjE0iF2QDXxGk/esV4E7Mqhb+PrReFquRqCESG4MVG15vsY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ5x5+R7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ5x5+R7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1553923a91.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784327014; x=1784931814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIZmkObDSv6f/AX6/iEiLoE+ADhHAYxlNT1uy/tTSWw=;
        b=AZ5x5+R7vnjhXldy/G5ZWwxagUEwua3yxLV+CyTwuR5TJVmUw8RxZWwi/Gs2/6R89w
         VQuckyocE79V9Y2+GqwRLufUtKU3m8cw7XPQD864B4qSdwuTNFkhxQ0NMsJG40yXQLgG
         mx0VrpTN++eytQQfR4x/ntwKlXQPf7rn0zw3duxJjzfABy0w9qkXup/E9NaqURkB2Qgc
         5S8kc3wS9srFEDpthIxufIxfqWFTlFEpgHp+W9TPCP00AyRoPTynGJ1PS6NVsdSdyiz2
         TcIXtZ5EBz4B8NMmoIQ5KVnWu7VkepCwCQA6R3vcGapCFZ9VjFtdFZGzFS7aiKLeE630
         Icdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784327014; x=1784931814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cIZmkObDSv6f/AX6/iEiLoE+ADhHAYxlNT1uy/tTSWw=;
        b=b1Xvx5Bwyv+OAMS99wF4hUu5jteGP6A2qNWokVPhiTBP3leHT5pgzGy1XgcQF3II7A
         GLoHyD5Q6SLFRMJ5lFlZXNjnCiNun0po3gG/Y334kol0udY4yD6Mf22ejWo3ozUrKBCH
         z+r3V7Mp0x5xDKlg+Oj4Jkuorwzee5pYNUSiBaVfIQBNbdwfO7pZz9cqFz8zv8u9nblc
         7CavK84aqQRRmgNReP8lfHl7T1vQc/kFEEwvNvxcDlgsip4hFKzLMg3FB5cfAYCMxYxT
         1XGff8e8T/s6HYbAxCBL/+SAywvBOkUaeroRKBYmHyVR0HJmO/jYv+5VlUkmpes3sJO3
         vfNw==
X-Forwarded-Encrypted: i=1; AHgh+RoBTST0X+AAbJAqLh241Fa18urFaPgUFCgzhpnXfhU1liCCNmfUHYTe4NVze0PeRSZsu8Co8Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hZl6V+HGfXvRYDSrI44ir0gkp6wiEj8opXg9prb+UiimjnCd
	3ugdQEtHmpVteLUazpnQBK9ZvYDcs4jgYhJ5MVrpVD3srqp+mOb27bWV
X-Gm-Gg: AfdE7cnEAuercvSkE/2jJK1bn+QAAFbZj7AYblQjCH6y1o+PeaUWLmGpUuTqcP4uKUW
	MWSr1FMTF0Nzo0Si6M68sbVciooWnX+jiPtqM05FxMLEoo9HQ691r/6Prf0plXjiaon1pFKV72P
	he0OC+GXiVephYjTgRM0n51lhWUUvl11CbS8ZkjUYj+bhMKdaQ6xyzaD2w+En/dKMaYEUK2LTXJ
	HTAM/4yN1bwzK5RmTa36VRIRNsIJD/7aZYsQfczRRWlMK2ZLBIfCBlKtyLjoo3cMe7En8sp7Wn/
	fUSiev5PuiqQjfOzULzG/3sM6I7wwHNfNB4/rm7GMFC0p8TJqC6jHfPuSV/llXSVVHhrO9V474j
	mG4OXIi59NrQKj5Dg2xhXErdgyb86P4987TFRgr6pthu59VQ30boclOXBHZLiu5AITTBAKcwGr2
	V7osvuJHkt3muKQUmwxLDLjucs7y2N
X-Received: by 2002:a17:90b:1d48:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38e4b610362mr3640057a91.13.1784327013929;
        Fri, 17 Jul 2026 15:23:33 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:9278:f508:9b9:d937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afd2dd6sm1749467a91.4.2026.07.17.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:23:33 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] ipv6: report why a route was deleted in RTM_DELROUTE
Date: Sat, 18 Jul 2026 07:23:25 +0900
Message-ID: <20260717222327.7398-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel deletes an IPv6 route on its own, the RTM_DELROUTE
notification does not say why. User space cannot tell a route that
expired from one the router explicitly withdrew, yet the two call for
different reactions: an expired RA route means the router failed to
refresh it in time, which points at a misconfigured or unreliable
router and may warrant action such as disabling IPv6 on that network,
while a zero-lifetime withdrawal is normal, RFC-compliant operation.

Patch 1 adds RTA_DEL_REASON (u8) to RTM_DELROUTE notifications and
records the cause in the kernel-initiated IPv6 deletion paths:
RTA_DEL_REASON_EXPIRED for routes garbage collected after their
RTF_EXPIRES lifetime ran out, and RTA_DEL_REASON_RA_WITHDRAWN for
default routes, prefix routes and RFC 4191 route information routes
withdrawn by Router Advertisements. The rt-route Netlink spec is
extended with the attribute, the route notifications and their
multicast groups.

Only kernel-initiated deletions that user space cannot otherwise
explain are attributed. User-requested deletions are self-explanatory
to the requester, so they carry no reason; the UAPI documents that
absence and RTA_DEL_REASON_UNSPEC must be treated identically, which
keeps the door open for attributing more paths (nexthop removal
cascades, device removal) later.

Patch 2 adds selftests covering all three producer paths: a GC-expired
route, and a default route + PIO prefix route + RIO route advertised
and then withdrawn by hand-crafted RAs over a raw ICMPv6 socket (no
external RA tool needed), plus a check that user-requested deletions
carry no attribute. The notifications are decoded with YNL, which also
exercises the rt-route spec additions.

Yuyang Huang (2):
  ipv6: report why a route was deleted in RTM_DELROUTE
  selftests: net: verify RTA_DEL_REASON on route deletion

 Documentation/netlink/specs/rt-route.yaml     |  33 ++++
 include/net/ip6_fib.h                         |   4 +-
 include/net/ip6_route.h                       |   2 +
 include/uapi/linux/rtnetlink.h                |  17 ++
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_fib.c                            |  19 +-
 net/ipv6/ndisc.c                              |   7 +-
 net/ipv6/route.c                              |  66 ++++---
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   7 +-
 tools/testing/selftests/net/rtnetlink.py      | 181 +++++++++++++++++-
 11 files changed, 303 insertions(+), 40 deletions(-)

-- 
2.43.0

