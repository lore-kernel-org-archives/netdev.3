Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E036F8E1;
	Thu,  2 Jul 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972269; cv=none; b=Kk8ghTegQh/eYsimdZ3FUvPQDUxLZrSP5FUbN+vDsZaN+AGYeCaVhaHHXrOaKIkbFtu3KTdQeE9f0FZlrz7yvhj4z6aYQze/QBbEh0MaAKxE5k/TcRginyx+8sWi0fUGHKXl6ZPWLSPBFEGads0UZgPGYHynTon47eEPVU0a5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972269; c=relaxed/simple;
	bh=MqwwRcnDNEpGOkNLc4FKOScxcGu1la5VJmsL8YrGeWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkLSo0kfOpeV1zoF+UYdiw/3YYD/9HS6+MK1BAcd5jEBjsJtG0rZriQ8uYWj32l5VwhCKfuq1uUEYzT+gWBiml+OHdEfj+6f3js603C2yJqNjErq2uRL2oMP3+A/OtYX/y2RYMk1k+Qjp/NU1G4ZLRE5dbqyrmYhOtvevaRC1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5mH24OP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5mH24OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD651F000E9;
	Thu,  2 Jul 2026 06:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782972264;
	bh=X/yx1aNzDDVIfUuAIyrB/O24EmFTN84NPUcrSMpCOXs=;
	h=From:To:Cc:Subject:Date;
	b=N5mH24OP9n73BW6cv05AYzqOse/F5qGJVU9szJTUweqhIAFXvIoXa2Ko/itkiemAq
	 LQMaiwsxYeccuMAedWP6QENrezjTpGbcOZ/fHFGUgc6KstTieINHQzypcWh9PT/vt6
	 EYVChAfLqu63bK4rZWF1PYAJHxaY6EDZ8ec/dM+1iGDAnFTjJyz9Cixs75Snhz49Rv
	 T+gw9Ir/pRTD/d4pQ1BtqVVFIgEuaJrf/365Pv1v37ALY4tAFs0cxnJLhGXNemUH79
	 UMjkFv3ImwGreqSH/yXXJYrIpqIxqZ5hapO29myNfQ4Zcmq/eQqJNf+YiD0CTLfIo8
	 O9KTFF4ItRdew==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] ppp/ppp_{async,synctty}: drop unused {a,}syncppp::bytes_{sent,rcvd}
Date: Thu,  2 Jul 2026 08:04:20 +0200
Message-ID: <20260702060420.95023-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bytes_sent and bytes_rcvd members of structs asyncppp and syncppp
are not used. Drop them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
Cc: linux-ppp@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ppp/ppp_async.c   | 2 --
 drivers/net/ppp/ppp_synctty.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 93a7b0f6c4e7..583426d06381 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -49,8 +49,6 @@ struct asyncppp {
 	unsigned long	xmit_flags;
 	u32		xaccm[8];
 	u32		raccm;
-	unsigned int	bytes_sent;
-	unsigned int	bytes_rcvd;
 
 	struct sk_buff	*tpkt;
 	int		tpkt_pos;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index b7f243b416f8..0b1bd1635c39 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -59,8 +59,6 @@ struct syncppp {
 	unsigned long	xmit_flags;
 	u32		xaccm[8];
 	u32		raccm;
-	unsigned int	bytes_sent;
-	unsigned int	bytes_rcvd;
 
 	struct sk_buff	*tpkt;
 	unsigned long	last_xmit;
-- 
2.54.0

