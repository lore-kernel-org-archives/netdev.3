Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29671387378
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688155; cv=none; b=ZaCO+W202eOj0dSkAnKDLCqWLL8WVMxch9YZ2LGB2LXXqCKb3hlPpl7MOtVtMD+58gdAxX+5BhyrmC9puOaYkCKfQCjhQ6+y8leBpCf6IVX8K/s2vm4UFyPhacOQIgn5owAZttVwWNqlS/BrAgn6FpGhArTWmEQjRM+WC50+S98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688155; c=relaxed/simple;
	bh=+P7Xt7nZ/rs5MQ984OvTDRhexWfbjPqWE6PBUm5OBaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPrgDBmnMvb3mnczwVpKglxVNlSqlQcnbPqtUrvJZhECIDk6n3d2OSEW4Xlv1EpXMyHe9q1d3ngTiQDAwbgN2qjCwRZOmw47F76waznqcWzW7p5uAkEnvXOuQEykWSBXqDlh8TMClaMGAqljrkaG1atEENMa1RU3QBaW+YSSfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=QLwpcVnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyouD2V2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="QLwpcVnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyouD2V2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EA7C7A00FF;
	Tue, 25 Aug 2026 16:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Aug 2026 16:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1787688151; x=1787774551; bh=Z7l1PQTd4fIWPikb8sujI
	dOt8iPjusN0D8LY70zc6ZM=; b=QLwpcVnZ0qjVswKoWwqxEhif2/vHKad86/gKo
	aXRFHLo9bRlGXxWZFeyr86ilbMwsrV6YEehL6rPEj0sTgiyYKmJTBqVLqSfvHsMO
	n6H9DzsnD6e6ikay5lZf3f/VtPt6ioW7frm4HPUZMErPni+7n61P861ixEzzyGF8
	USkWjeMMhx+LESIr76CdXxG1Ba2YFdJaYCmsGIdJysyhfd220aocscBGWs8H0Euk
	tlHqRxDLfw0InyqV5geu6rJdAsvUN5tlx1tHzMPomcejwgiRyRP+ym8DaK343GEq
	pxfunHFTUXI+miksVeYXT/xnlj+6gllZOouXEt4k4NmemAVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787688151; x=1787774551; bh=Z7l1PQTd4fIWPikb8sujIdOt8iPjusN0D8L
	Y70zc6ZM=; b=SyouD2V2qHwWflKBIVQ7yFbHs7H4TOw49gbcguxMFE2+gAIBOx6
	1p7siepG5ucIc881vIKLjf0HuXDKj873oRmjVF9OQdfNxxc0AyfWvszwaWUTA3mD
	M25xvKxVipYOlIzqy72bQhmsQ6jHD3lzd438LcFA8OE5jdN8l2D57Xgb0MFqMeU0
	fTqSAty1iWiP7UOK5CZTro2B8tsBSLtaRK8xuON/jyUczpLl3tRB7bWuhUAeq0Wu
	xq/P6AswhIoi3rbahXxYz8xNh6noUAvpwOEEhz2wqILam5rstN3OE5v5zxHup2qw
	3QzV2L2Jx/Z6ovIdLH6s2Q6BH+BO3HE7Lcg==
X-ME-Sender: <xms:1_SNanROs4ueK_AxYiQOtPOEwSTUqkKlrFUl4R8LDVgnyCeg9Z0dYw>
    <xme:1_SNavIdL9HSPCg8imwhAjZpZnPre7fTFSiE_QXuKzXHzAN0UPRMbSTJH4RXUnznA
    V-cIYmyE3tJjIl9XV0kAZ_ez0Qqto4M2IjTzLqGV-5Be6cDoeYhsyY>
X-ME-Received: <xmr:1_SNapFN_1kdYlOFJblX2BeGXjgwWEUIbsY084z56JtVR5H07D3zFWFNnk0Ssd1JDfKwXPEkLmKj-s6F9dw>
X-ME-Proxy-Cause: dmFkZTGDoqFr/vY90EdJnJRmAHEHX6Ty31Q34m/6ICY1KHEPIFKGuWT4Okl3dFDBPAfd7d
    KaLE/A4x+ev3Be80nmQg49sVpLy/hqDhDdlg38UVpZEHTNAtubi7a8Pl8PrMQVv3I3QxQa
    VNn9OVUXGsB/5hfElx+zKVotBYgk0Fr/IXaxXApzr5wtZ1jsomS/uva8SVpNcU7vO2UGR7
    Qt65r2hIwS+GwROoYjg/bm+evqZ78Z9hfDPOTZ01VCloKqciVw7vrV3qxmOVvMNiX4GtKK
    0YWdEzhjDhq/55GHrzygup7pkZOtrPxnb/QAnqV7mLDvTbm4SeMvVEJz6TGcRgWqONVZm+
    xhAThIu0PJ1c7mQip9rP7caIAmCEb+S0LafAqNCm0u1VjscXPsXFVyylamTiE+Ez25zIHp
    t0D79ZXwaAiB6ilREB9ScaszZvDDYaYze9RM2Rwi+vrD5ph8tkuIXPsLCrJ5AoTiFt9vqp
    n9lQBBwoJWP6rTtgabSIOSaezuCbPqstPvo8sq3NoBt/UROLF17Xp0PUzXF2EGLdppbZtL
    jwQO1C0tgsVnsmtFmjZTIYpQ5tQ+S6zeEv+wsHKDpRNTHtBfMXr+IG2TmDU0O8VKZninb6
    CFv6vybv5XH2CpMI4+/fCG64O7hQqXNjbSwzVwwxL1h0cd1dmYwDn4zfrNQw
X-ME-Proxy: <xmx:1_SNak3sfVaMIMPpTXgmMD9lV7YU5ero85oMinKGP5X_NmU6WXz_pA>
    <xmx:1_SNapLV0CtTBwwMBBT5sKSLwuvsR3FuBaCLIQJzoBHXxlP6u8dgTA>
    <xmx:1_SNah1nDtQGRbP4fz4iz8YFl_TySgNxlWR_Oj1s8UVMLNUYEJ2KdQ>
    <xmx:1_SNalnYb-lPcvqIymwV6SB-gn8cVtOj_Ep6GXfjYyoS_KqPtYB7Qg>
    <xmx:1_SNaq4wbI0AXCPZm3ylZSpJLVeCB8bS7KYt8-HITBkAWNKDZehyEPcE>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:02:30 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v4 0/4] Fix UDP length overflow in edge cases
Date: Tue, 25 Aug 2026 23:02:11 +0300
Message-ID: <20260825200215.90326-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

These are fixes for rare edge cases of 16-bit UDP length field overflow
that might happen on netdevs with MTU >= 64k.

Exposed by the new WARN added to udp_set_len_short, reported by syzbot.

v4 changes: Fixed IPv6 commit message; deduplicated code in the selftest
and fixed pylint and ruff warnings.

v3: https://lore.kernel.org/netdev/20260822115717.1161782-1-alice.kernel@fastmail.im/

v3 changes: Split IPv4, IPv6 and selftest; limited the clamp to UDP
sockets to support UDP jumbograms over raw sockets; added a selftest for
raw sockets; added the kernel config check to the selftest.

v2: https://lore.kernel.org/netdev/20260813120351.2807829-1-alice.kernel@fastmail.im/

v2 changes: Restored the MTU clamp in ip6_dst_mtu_maybe_forward.

v1: https://lore.kernel.org/netdev/20260805205957.1652619-1-alice.kernel@fastmail.im/

Alice Mikityanska (4):
  net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
  net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
  selftests: net: Test UDP length overflow with PMTU discover and big
    MTU
  net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

 include/net/ip6_route.h                      |   2 +
 net/ipv4/ip_output.c                         |   1 +
 net/ipv6/ip6_output.c                        |   2 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/cork_fragsize.py | 140 +++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py

-- 
2.55.0

