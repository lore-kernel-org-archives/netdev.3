Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAF475325
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799843; cv=none; b=QSBAtdM/YkxORoe8Fr9xkTnNvq56n5eO2kS1p5KYmgdeXjG++Wl9jrlJkQ26P0OTXtBV1fnkWYzqldwFs71afS0Z85tGtH58H+2zB90a/2U8y1+rtsmOfzf40jSndcd2puYsWhDLlUPZLYmgvk1Kzm77KOU206H3dzs4P7Yh2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799843; c=relaxed/simple;
	bh=C7DFAyYtQTsJcXCP2mKvtachpHkj6EQNB+bwdyFIG5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okhNCgYZmFF0ls5YjAe2sK2FCVQ93d2twbnvqZ2M+PCYx7hlNfKENrpoxwE/dK3xW69nEVRtHO6KDePLQo0wvgkcp0SG71SImnZxfT4OX6Hxne+UWOxq2okFr55naS6BIhJFW9RbjFMu+2EjF28bfbFBLpo6loPyVSN2l7my8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLZqKO4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLZqKO4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7791F0089B;
	Mon, 12 Oct 2026 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799835;
	bh=FqZ/8nmWNeGu8rw19biGCW0dw9zAMtjcV265Zp117aE=;
	h=From:To:Cc:Subject:Date;
	b=MLZqKO4a0ZNT615r39WQz0ZLvmzAlZPtNbBLPs/qsZN4fkx9xh6sTvgC0Yj6mOZrC
	 FXMNyVOlGJ8Sn/VQgUIins0uwGN0dIMvgaRKiGeXzZpy8Q7YaMNavHIoEvM/z+iqTV
	 au577/YeAwAGzAesW2Qw/cx3UFMEAxrFGPTnbegQKInDNYdo7Bg8h7+Pn1wGNDMAIp
	 WPjdsuf9dYfl65nKTo04FwLIZzQP+XIBdBdaVplVa8YvHOsyylVu8UPNkXrIaJag4y
	 M2GfhgdLa6JvNmv09kBb2c/THFQaFJRHz7yCg7xhSS1ReU9pZBSteRod56d43RlG8Q
	 aZyiLtOioFn9g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net 0/2] net: fix sk_mc_loop() with request and timewait sockets
Date: Mon, 12 Oct 2026 12:10:27 +0200
Message-ID: <20261012101029.927296-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an out-of-bounds read in sk_mc_loop() when skb->sk is
a request or a timewait socket, by using the full socket.

Patch 2 fixes the route lookup of cookie_v4_check() when the ACK
carries a source route option, found while looking at the above.

Refusing to send TCP packets to broadcast or multicast destinations
is left for net-next.

v3:
- Back to the v1 approach for the sk_mc_loop() fix: checking the
  destination in TCP (v2) does not cover source routes, multicast
  typed routes on unicast prefixes, or the TIME_WAIT reply path.
- Add the TIME_WAIT case and its Fixes tag.
- Add patch 2.
v2: https://lore.kernel.org/netdev/20261008114942.1376889-1-theodorlarionov@gmail.com/
v1: https://lore.kernel.org/netdev/20261008100423.1256884-1-theodorlarionov@gmail.com/

Eric Dumazet (1):
  tcp: use the echoed source route in cookie_v4_check()

Theodor Arsenij Larionov Trichkine (1):
  net: use the full socket in sk_mc_loop()

 net/core/sock.c       |  1 +
 net/ipv4/syncookies.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.53.0

