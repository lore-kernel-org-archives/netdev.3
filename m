Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572688;
	b=lO0r1y/Maaxdj4ZuJJakGRfNGEMCX/act2H8SXMnjBfc7tOiug5a9TEKkQG56xdhYrvZ
	 cTSE1+YXT+Fcs1soLw/Rb1koZhCL5eVVvv/tCz/vhVnrGI0bGvpqlTMwTWHzHEb9oDK7K
	 n1KsOLzq/l1a5mBY5sijxSlWJtEdKaG1/GTZKVfx5TYkU0kBT9tT80t4CmLJf3YsmoCac
	 NAxhPKvFlsq+HMBRFfEXFT4VT4sW++Ys0yWJpTzU4oQqcEak8ER78il8A8QEvTLQq+Btd
	 B1OS6Qhvc4wTHpBrwW9oHOwTTq9+apZkbNgTPyCd0XkEgCI107ZEWegy5rtT2keLONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572688;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DNRyrDh1/zcPAMhcUGvhRZdWvJbNtC5hmsKBl7g0YKw=;
	b=OKcvbjPq+GKKHQOd+kWGK/jXptqaStbOK81glpIoT6fPy93TCRsv1IsdlyJlf3bqJoCG
	 wBgXSoG2ziLuJMx28TBE9iONJzbgfmcFuT515FbUNb0PtWEoG7YK+zLpVxpV+xpt/k0cZ
	 zYK7YwtDdGanmpPeGkP7Jj2+sgcRhldM4MSwWLA4T2V6h7tlqEdpUXKlowXuinLp8lj1W
	 V+m0oydFXsOQatNrz+17ChMhBOHowZPUwP5f94290g0hXWB/yyqafCUhIZlvOQmX1/rk0
	 cF5lcdEqP3Y9thIy4Mng0LikFfhE8PnV7oQubFqH0NcbMtyaD8/AITawTe2v0p4YgCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=zYB6vF1M;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD0606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FD0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=zYB6vF1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794572684;
	bh=DNRyrDh1/zcPAMhcUGvhRZdWvJbNtC5hmsKBl7g0YKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zYB6vF1MEU0rjr/ITeF+HxoJe++FsNQgslleNUEOog0REipqAqYGF5Ga+++6HdD7D
	 vKQo1KQBiYLmt1jqXqWeHTX9TwJzZTBzycnbBaR8wiGXAf8NE+5XtSJo/xjgitpkqH
	 aZCHlc1GZZAsvn0cBHCrNopEGejeTbc4F7MPYlIw=
Received: from localhost.localdomain ([240e:3bb:3033:7d41:3d43:876a:14ed:84bb])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 6280BA3F; Fri, 13 Nov 2026 20:24:40 +0800
X-QQ-mid: xmsmtpt1794572680tg20d0l3d
Message-ID: <tencent_0EA9650906180A29A0CE692525D7F5B42D07@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe0va2u4/S2by4RcUwLTJu/8lFDsCz6/mcu3dYEvrvMWf59hr+yj
	 ia3JROjJ3dnkUofIsiUx3LBEL3j/dLJ7K93H4E0MOb5I89W5egD+7kW82JkIZ936fKHrDkdyKOOO
	 mGh6dXVDKwKMTy4hRhBVwzif+RDiGiuuU6JSpKrVpY50/ox+fQdednMGvqz4CzArIgHdAT6pMHOD
	 0Fj2CcnUnAeBQxpzLRSa+3S9mwaUjqQGPzNnb7GcBFd+YvPTaWbff3RACPAOfUdatRadAw/kNR6j
	 YPtKXPFlZFLhYzH+EeKV+JiftJUAsVDtaZbi/Xxbkh0qqWLVzFJdr5jnbF8TT00tS60nEvQyZWOC
	 tWM2bry3syI2yqUs+9oYNhYgSqpz9/OuIERnYOT4fdkia1QzIc4hPlGzMZgfilWXTFu9TlkoJnSh
	 w5iVHB1HrFvAGgUkiRBEL47YI3Si1stQB+tGGWU6qvUEtCOSUlNoJvzrDMG1lE2nZGUK954WYNYe
	 iGhNstKtPl7eD7kI/3i0EI3SMthj6JIT5tIgpetQNF3ctexpgqGTjYIKr0aeyAVFASti+y2QvpA/
	 f1yKsWoHWZAzfwgdI2STw/Cuxu4L4xWtruA1SSeC9xcLcDlgtDXEJYF1AM5Y+ypUeAv+zU7WuafK
	 b64v3cpk9wu6hlviq8khkFAb3ApSski/IW9Uhm6v+YIny+95VXa+mvbB9pvTzLkG+A9U63BJJNQt
	 NoClelwsjAG3mES1inYJP9tyQT9KFchT9Bh54Scz35EZA1jlBNBdhhJ+YWsFylj1gMz540Pk51pm
	 FleJwVUIDndph0DL30deQRc1zylrbgnyXdGjq3nyUhhjN93WqKLF7lgVIxR7ekOsw99CjgIlO6u4
	 Hria6lQjhKDLraAGruLGFrihB1nPe/XDWYDZQCPqA7scqUymiACAX6Sd/ys/cznJPr8osFnCXt4T
	 JQppD/SOTN9Dt+wzHVnzAS1HThMhb26UC+WJxrEjyFAn4gy05CMbNjYQDaKXdqKpI+R/MvnHNfJB
	 jLH+YuV6XxK+TspewKrjfqRdIktV5nimG9nSw5ciw6CN43O0TiMVG7wpFf3BRARg/J8xKWJxJwou
	 aUuTHL
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org,
	daniel.machon@microchip.com
Cc: Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v4 0/2] net: sparx5/lan969x: fix RX ring stall on frames from inactive ports
Date: Fri, 13 Nov 2026 20:24:37 +0800
X-OQ-MSGID: <20261113122439.26292-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
References: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
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

From: Zhang Hewei <memoriaru@foxmail.com>

The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
ring forever when the hardware delivers a frame whose source port does
not map to an active netdev: the inactive-port error branch in both
drivers leaves the FDMA software cursor untouched, while the DCB keeps
its hardware DONE bit - so every following NAPI poll picks the same
DCB again and RX traffic stalls on all ports until the module is
reloaded.

Patch 1 treats a bogus frame on sparx5 as consumed (free the skb, clear
the array slot, return true). Patch 2 unifies the NULL semantics on
lan969x: NULL always means "frame dropped, page recycled" (inactive
port or failed build_skb()), and the poll loop advances past such a DB
like it does for any other frame - dropping only the bogus frame and
keeping RX alive.

v4: per Daniel's review of v3 (tested on lan969x hardware), drop the
ERR_PTR()/IS_ERR() plumbing in favor of the unified-NULL form above -
NULL always meaning "dropped and recycled" covers both the bad-port and
build_skb-failure cases, and the duplicated advance block goes away.
v1 lore link:
https://lore.kernel.org/netdev/20261108184541.74618-1-memoriaru@foxmail.com/
v3 lore link:
https://lore.kernel.org/netdev/20261109164053.8928-1-memoriaru@foxmail.com/

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.
Review from someone with access to sparx5/lan969x systems would be
appreciated.


Zhang Hewei (2):
  net: sparx5: fix RX ring stall on frames from inactive ports
  net: lan969x: fix RX ring stall on frames from inactive ports

 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 14 ++++++++------
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  8 +++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.39.5 (Apple Git-154)

