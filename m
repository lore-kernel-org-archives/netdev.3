Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931192F290A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763215; cv=none; b=Xuyz8LlXBm80bKJZNTEcUkIjUohYqBCXuKl6SscMCZe/EZ+vGy+ucQKbCajEa2lFNK/4+AYmc7qAtDb3vzCpH0M+5RRGHkXXoELK5Q/bbKSd/JQeSuSkCWLukXH3v7xVSVVd5121TQPDP9r0EK9+hNARBK1hic+8dfyDt5SJ1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763215; c=relaxed/simple;
	bh=wBsp4REBjZxx2LMkB6n+TaiQB+duZW7Z72oazxn3+h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3EkL1D40qm3T/G6UTUBxXoiSLS0Gi0rdwmJiGCK2sqGxdJgS7a9UXPmvfe0VWlYyLd5ZJSu7tFG7yIC3xyuWj+raS5nReiQTmDtOvtltK+aucO4C0LvFNFJZlRmcXpSwoHFt5QxZw3TAvt7yKqsVseu5lomL7imsnqskhipiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wo3ImZl8; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="wo3ImZl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1773763203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOtUHslmgMBnfqhbb3TaLA6XQwEWCd77fBUOyuR84VI=;
	b=wo3ImZl8L5m0tnjl90e3gGe5fbZsOFbqqRjfBZhvxFzx7nOdE9E35FY+PL9DD/JHjLVeOK
	GCBAAYCnx0nG0nSNR0SlzHa7gQukcg8q2cdS2zBPnw8XfkmGnYWMcifi4w5tDxcsFaQFnd
	w+bHe1jQd4GbPA1HBOyggu0pq1Z1NMx9ZLL/pk+ac4QSYyzYD4obiHsM4zl0ko3fRcJban
	s3e+fKHS/k7+Z63trGnfGtmEYKQyr9U52ZK3SSRTpFB+aVCGJctMrSEVx++6wmSTP4KlbX
	P4lFwYziZNAeRqJACzP0x9ctBLzpnySqOGVzUu4Aqr4f0L5UkooCb3Pa5fA8mw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2026-03-17
Date: Tue, 17 Mar 2026 17:00:01 +0100
Message-ID: <20260317160002.1869478-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit cfc83a3c71517b59c1047db57da31e26a9dc2f33:

  batman-adv: Avoid double-rtnl_lock ELP metric worker (2026-02-21 13:01:55 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260317

for you to fetch changes up to 0d4aef630be9d5f9c1227d07669c26c4383b5ad0:

  batman-adv: avoid OGM aggregation when skb tailroom is insufficient (2026-03-14 08:29:47 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

- avoid OGM aggregation when skb tailroom is insufficient, by Yang Yang

----------------------------------------------------------------
Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)
