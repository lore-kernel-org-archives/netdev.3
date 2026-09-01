Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388A44A3F1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292673; cv=none; b=CxIyM4P5y7OA//RqrWTfA/agVH4dnXaPJ3ZLxkvfDjLDOl+fe/U2N5b49AweJRSxbxfpjMqC1m8TbzIHHhzX+jTO7S8bhV+q3i1rRW8Tf4w13P931OiLDtdJpfyHQ9vvo3EgUlgX2vVilW58RFFInZaD2zq8nEZQq8+pQFshiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292673; c=relaxed/simple;
	bh=6lRtu+q/jHvOCC6E2OcEa/mEU8oGJJcQyJ/CyXdIdbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqcsfVLZmSe1VaOghh5C63K4dbqULGfaVuqz46l0zTWlBjCClNlJyPaxqXTnEmbdxKbyVFaSyesJUeHCnJruYh48qt1Dtm4t56dEPF27fLFiKQM2fYwDYuxMX3tyRz8LTMPoLdgPeI4loU3w1mAkxp8+JlS+JJsS0quRoQ416uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=lNPMASeR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLcyeb5X; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="lNPMASeR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLcyeb5X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 47B0B1D00061;
	Tue,  1 Sep 2026 15:57:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 15:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1788292669; x=1788379069; bh=NzJ8l2gqYrNqTlzKO5iT8
	x5q56Ruh0Gt4TLA9dHu3KI=; b=lNPMASeR/m1TOci8gCznlTycK+XH/Kte85eRz
	l857aBSrIz0Cbg7rZYrEUyzV+varZ9tmMzTY301xqAy7KZrbaxbFpSyDorK960YT
	J8wbw1CjkpW0P4DkMZuInOp5BEYW4FmwwnF5KThaEWp7tOn7YhF2SLEHqz6MQktw
	Fb22JFBzwyecjiH/sahwT1AYC+Ok40CyuUb7xPSOxCC4n44ESEOhwpry2EMtdQ5w
	niOqGobYNx1EglhqhCARxxl2c0W/NtF1ieTyPBa+62aopEafc4XYepkXTRxWCIKn
	pHjjTSf/tCsf512wskkvdH/qFLoGlw8dyebI126U15NodOTFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788292669; x=1788379069; bh=NzJ8l2gqYrNqTlzKO5iT8x5q56Ruh0Gt4TL
	A9dHu3KI=; b=mLcyeb5XvWPloSuz597vFYVsmR2MrOcx4tU9LoinwhC1BJ4tutU
	27Km1dwFBlwzZID7QmpY6mb8n3KugT3ZRusV45Zj1RXL+iBQFRF7zjk+SOdt1iPa
	zP9wUcJs14z7DeEF1YAK6Z+IIc7rjCUwJHUz/YYFCQHbFlsUVJNp9AjZOLoO4Xt/
	PGS6m2Ri6tAxoG6VdJ9GcnNnc/U+qIdW3LSdW4R3V7JxhDCIkeZ0Ev50IuSoVa2w
	6/vht21kLC0/M4/yYyRQIBEMN56SMQia9kj1Gw2LB1GyAbp1UbMXdQsTjY189nsi
	Pn/+B5oeUnBRFJr86OTTvwgwhAjt8bD74YA==
X-ME-Sender: <xms:PC6Xaj8wBW4VT3QCEJsysV3l1uM-wwqsqDMtRUlDMqaMXUhx30vjpw>
    <xme:PC6XamGjDPCRnLSPvL4P5Q2KMcHLw0WlU5Kzo0jbp1c55e7f4p4SXqtGKbZsTNDVU
    kn9OZuNzldJ5EwPWDV6X3o8mn1KiS1d4FvXnkIkKgqHeGZbV0Dd2vbE>
X-ME-Received: <xmr:PC6XatTXhsjDeAjG56a-psihiXireeXPECECNa9cKBtgaQM85x6TfZ3j-RJBa16rsTDF0nucequfUEBiysqrsAU>
X-ME-Proxy-Cause: dmFkZTGh6fW3KYDRKdaQ+9gcNeaxz+ljTX5uq4IUmxln/DsLEv/QQoqzzk5yCiFHryHLnn
    RW9Zm2zKCyiVbtVWEM8kUQ92UbEKnCAIYG2n+Rc3LUQ1hrnxhZOZEYXFIUsrORxd1bWDul
    i/F6g+60oAt6y37ZqaqL6XQ5bxMjOlCVQ15LWb82S3mRcuC9X6X+gbL6RxZliIbLoObL9p
    i8Y908u229areyEvUduNRrlit4IZ+O3MjldFA0kodROBothVmBvJZ6Hv5vRjC64KrDzV7d
    gbM04NP/pDVT+8cSDDP32oRLzEFlR78zG8YxbdSV0t2jKK5vi+XxBKUGquWqDgwH0TW1Eb
    sPcb4/QfFgruT/w/7h9PrzXhU+HvdcgH5EXGRaSGHSyXrq7pRFb1xXbKWQrqNUmll15Sv3
    bScF4Ah7muwaOlRhgfLLc6Vcc0SZTKVkhkkUXi5Mkhg5v05bkq2DrbFQbOzEpV17tp/LMT
    Sb9zn3BuPCL8KGaT3UMtWRWN93/QhzUFTUJMXlwIYYTDCH+sKHwAYlQb8GkrxtJk+ceWip
    jHrlpFopyZ/LuaNsxKFDD6j5YT6LW/dwK/jNw0rTVzHV6WV5xsSLpKhT3L2kIpsFW/qFBX
    gKlhHHxLR8WyX83BN0oMJXhg+RJbqvQs1jAXE842jqj8kNnRuDC7jX4DyRqA
X-ME-Proxy: <xmx:PC6XatT8L7zoQacsph-a8DQz9bRJuth9-sIN9QCcNhYNf1fUR9hizQ>
    <xmx:PC6Xag0p78GkxwocQFCM2YQOlgUWu8xgSduXqQzPqvjWhIYtHMMgaQ>
    <xmx:PC6Xanx0XJ0BqLCR0sH3xkR5x3nhdDyBKnAXpcm7qXzIEErqH1v86w>
    <xmx:PC6XaszjQnWjJ8pAOhX1_uDSxZZ1fMDOyZ2BV6kg4nqd5mHwsCAHSg>
    <xmx:PS6XajIPMxWlq9xTL2kcdGq0tCnRAO6sUYKELoo__aeaKaF3gXsvSFEd>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:57:47 -0400 (EDT)
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
Subject: [PATCH net v5 0/4] Fix UDP length overflow in edge cases
Date: Tue,  1 Sep 2026 22:57:10 +0300
Message-ID: <20260901195714.673548-1-alice.kernel@fastmail.im>
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

v5 changes: Added docstrings to the selftest, used defer.

v4: https://lore.kernel.org/netdev/20260825200215.90326-1-alice.kernel@fastmail.im/

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
 tools/testing/selftests/net/cork_fragsize.py | 187 +++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py

-- 
2.55.0

