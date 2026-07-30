Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30C3B3BE6;
	Thu, 30 Jul 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393273; cv=none; b=gNnnZWu85nT+7ylj8M7Wy1iWeyDak+FrAa/p3LdGsQkxrNb6IEvcFE7Xftbd5gHGG0hQt+5RivHdBcgB3dUWxH8UTVZ39uVfZVk7EFriC0xBssn+jUSLQ7PpE7kZTikrnM28fiDt+xdtvHHufWTLwMfNI8J7yEikK9Er5WML5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393273; c=relaxed/simple;
	bh=emWuLtyWAm3XIQ1zGbvXdOPP+TqH0rtLRaY9Jnw/mrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWHjMi4HLuazwuNYKE8m9/itYa54S8PpAqYpwurqzbXVllE0SK2qXH/3ABkRuidJaReWLXylO5oum3sYbLuUAXpyFbX6Ra/qJvlbxGuwvzoK9t5Z/NE0M/9AgzVdeu+oBrybtgSX0HUvFZU6slycLQTzcpcu8HTgrCptG7WPmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fiQD2RLt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fiQD2RLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mk
	CgQoVbIOJ75wrgJqJQCKq/7e7T14j2wx6lUwkekA0=; b=fiQD2RLtPm1K4+sMzi
	qMMRERomWByGyze6th19cRen3Uf5XtWJgYOwwUkJ7qzwlzyZsxzjKtWXU5tY5yoa
	84vgi56QUStB+RH6yQ6dUlH08v/YWolZXDRMJCVqE82az4RpGnolqafCCfGBriTu
	fbbJckziKGT/5ePuk7GW5G6yg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnr7ZJ8GpqJ7_jMQ--.36965S2;
	Thu, 30 Jul 2026 14:33:46 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: sm_statefuns: Fix zero window detection in T3 timeout handling
Date: Thu, 30 Jul 2026 14:33:44 +0800
Message-Id: <20260730063344.770679-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr7ZJ8GpqJ7_jMQ--.36965S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW7Kw4kZw4kZFy7tFWUArb_yoW8Ar1Up3
	98CF4S9rn5JFyUCrn5Krs7JrZ8Kan3A3y5ur9Iya1xAan8ZFn5tF1ftF98ta1rJrZ3X34j
	vr17trWYyayjkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3gqDx2pq8Eq-IwAA32

From: Qing Luo <luoqing@kylinos.cn>

In sctp_sf_do_6_3_3_rtx(), the zero window detection was overly
restrictive, only starting the T5 shutdown guard timer when the
association was in SHUTDOWN_PENDING state. This caused premature
ABORTs when the receiver's rwnd was closed but the association was
still in ESTABLISHED state.

According to RFC 2960 Section 6.1, zero window probing is a normal
protocol behavior. When rwnd is 0, the sender can always have one
DATA chunk in flight to probe for a change in rwnd. Therefore, we
should give the receiver a chance to recover by starting the T5
timer regardless of the association's current state.

Fix this by removing the SHUTDOWN_PENDING state check, so that the
T5 timer is started whenever zero_window_announced is true.

Fixes: 8a0d19c5ed41 ("sctp: start t5 timer only when peer rwnd is 0 and local state is SHUTDOWN_PENDING")
Assisted-by: LLM # review
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/sctp/sm_statefuns.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 708fa07d5fff..b01db33bbc36 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -5842,8 +5842,7 @@ enum sctp_disposition sctp_sf_do_6_3_3_rtx(struct net *net,
 	SCTP_INC_STATS(net, SCTP_MIB_T3_RTX_EXPIREDS);
 
 	if (asoc->overall_error_count >= asoc->max_retrans) {
-		if (asoc->peer.zero_window_announced &&
-		    asoc->state == SCTP_STATE_SHUTDOWN_PENDING) {
+		if (asoc->peer.zero_window_announced) {
 			/*
 			 * We are here likely because the receiver had its rwnd
 			 * closed for a while and we have not been able to
-- 
2.25.1

