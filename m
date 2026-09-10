Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4B40B119;
	Thu, 10 Sep 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033673; cv=none; b=McRdWixKlrmxp1hh6AdpfT6Y2UOnu0sPrApPcAkAze6nMBEErgIG9VxEj8js1jTxrv1H/jICTSEFWCixZZzS9x0eetwb4FAE34NBQRxng6xzIQp3qqVJu2S13X8jAjgqn9ZfHFDXX67HqWZOiyweBze70MHbHQxg9AUhrrFh7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033673; c=relaxed/simple;
	bh=zY3E7Rwtj1gtZGHIFPCBwT7Yh7oH0OzzJSkAPcpG3+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iM4HC4mcxz94/mwBaRPd40t0/zxMcl7LIxO9MYQCOlOTmoZ6m4xbUJyKZa4UJn65oNqwZlhwUxCuQ3xfuTS/xBh90zdEBrEtAJ/yuLKsOBiWnRJZ5EZ5BsM09W0fysba34jbT7QZXPMwiADFtXZx1KuUoBjdPH2CVyRk/CqaO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aGKaYUMT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aGKaYUMT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KCr79xkYcyz1HfRm8DU/7nnwvnzqQzzUAvlI70pi3Rc=; b=aGKaYUMTSZa5/cAEeI1PSI9Af0
	LBlYc77JB9rgNelzyH4+QzLIVffzoWAmaEw+QwoxmWgKgTBUk3SacrnbBEpVTbgxbW1WaZvdTCv20
	zt7S/EAxy4N+mJXBcFX0XhMHdssb0TgvHRjUDE9Qt7o74pdZ2FjRZEx/taPotEwyMYSZfaPbEQ1zF
	eqt9fJCp2or9yz5TeldamO58gT7nubWM7CKRuvu0+1fwURwdxd2of1BigCMop/3/+J/V5wtdMG/Zo
	PHyTv40iXyLymzTCJHkbnZCcasBFjjESPFIZ0aMdxlktsfS3uib5F2qYHVNyNeKYWiVV0d+ucZ+K6
	JUS8B/IA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4bNL-000QMr-2O;
	Thu, 10 Sep 2026 09:47:24 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: a sockopt_t quirk for the options that
 write past optlen
Date: Thu, 10 Sep 2026 02:47:10 -0700
Message-Id: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ58omoC/x3MQQrDIBAF0KsMfx3BuDDoVUopxkyToaDiSAmE3
 L3Qd4B3QbkLKyJd6PwVlVoQaZ4I+UhlZyMbIsFZ522wwew8tOZPbePVjqTsTV5y8MnNq/UOE6F
 1fsv5Px8oPEzhc+B53z9Ghle+bQAAAA==
X-Change-ID: 20260909-getsockopt_phase6-c7c96a21b062
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=leitao@debian.org;
 h=from:subject:message-id; bh=zY3E7Rwtj1gtZGHIFPCBwT7Yh7oH0OzzJSkAPcpG3+s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqonym0uTDzUbpDIX/EQ7qtrro//wAbetMTV0p6
 Y1pGBLHRxOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqJ8pgAKCRA1o5Of/Hh3
 belFD/4igtHJBC8mnCu3vEs1a4d0vgAP01yp+aeZR9ea7z45maSgwRjoivU2TE9jITKO0V5hJbj
 JyKOZ4Bap8s+78zXLbRONxdFQnnamtMrDBb0t5bmsiASK+E0EQBcIvFpCWfqHbVd4JxthoV1Upp
 IxQhVu7Wn4o7eMvspt2NYPPBx+g+buf/WK2rbvzOY4kZx4mOqtI57GX2prUvAiQBiSIzXSjatGA
 QGgL08nclt0IFnqwqpfKYZWa8xxNi0GgHsUHExq+k2WAKGGhFNrC0gsvB2ybJt6Rt5OsXIjXNwP
 lnu4uxwbimSwRC4jFYxyF/o21ZSvMlfudxeshsF/Dm1V7YGOBnkE00A0ibCGaH1zI4RtSvx9amm
 o2qnvWOXhbiipLJ+QpMQOrUB0ceqjZCjxXom+LO8Z0SmWyU7eIjk6jEE6QycIeDT1JuN4yWu/HZ
 ADpAN+AJTyQ2v5wNmEE+ytH7dcjOAsFIT+ov9X6kZGv289mYWueGN9B16Ippfny1fc3uUYyTLQu
 vrJYBp/xwjt54MZH18OCxYVt7q35ySdvOZkcBEkdEt1ABvRk+mQErN52tHc63yXlJ0jQgqS9H7p
 PY4JPvlnaveI2ZTP5x7AsOe9ZZoqrvUso2q7SkvXBIvmSBeIK2S4Da/EeOIp6BFys66oSCS0Vyg
 +vbd9jN0N3jVTvw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This series continues the migration of our protocols to sockopt_t, as
described in [1].

There are some protocols that use optlen as the header size, and the real
buffer size comes from a field inside the header. This means a bug, given
that optlen should be the full buffer size, but there are indications [2]
that we have programs that use the bad behaviour above, and we want to
avoid breaking them (or, honestly, avoid being cursed by Linus).

That said, create a quirk helper that preserves the same behaviour, even
using sockopt_t. The way to do it is simple:

1) Only do it for userspace callers (ubuf), otherwise a bug here will
   corrupt the kernel instead of a simple SIGSEGV.
2) Expand optval mid-air based on the header field.

IP_MSFILTER is the first user, and the smallest one: a single caller, no
compat variant, and a reply written front to back. MCAST_MSFILTER on ipv4
and ipv6 comes next, and TCP_AO_GET_KEYS has the same shape. Do this
quirk on IP_MSFILTER to make sure the dynamic is ok, so, we can expand
it later.

None of this is meant to change what userspace sees.

Link: https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/ [1]
Link: https://lore.kernel.org/all/20260806-mcast_fix-v1-0-bed0a5518e57@debian.org/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      net: add sockopt_expand_out()
      ipv4: igmp: convert ip_mc_msfget() to sockopt_t

 include/linux/igmp.h   |  3 ++-
 include/linux/net.h    | 25 +++++++++++++++++++++++++
 net/ipv4/igmp.c        | 23 ++++++++++++++---------
 net/ipv4/ip_sockglue.c | 10 +++++++++-
 net/socket.c           |  4 ++--
 5 files changed, 52 insertions(+), 13 deletions(-)
---
base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
change-id: 20260909-getsockopt_phase6-c7c96a21b062

Best regards,
--  
Breno Leitao <leitao@debian.org>

