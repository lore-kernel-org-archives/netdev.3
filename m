Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A13E1692
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032089; cv=none; b=Xt/8uRFM9yCqIixXpvMVLUm8PTOoUh3j1sL/4dG75FTQhs2TVvHp4YD2qmvhO6ydr/xUjOr/et6sHfRUVXwXQSi/JSqMJRrOTiLjjFaU2hA/43z+bLW+u0RrvDujuM6k+4SYH1PNX/e6/2sQ+QekKIa2MpJGICjbLEtq11u2agM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032089; c=relaxed/simple;
	bh=lqugDnkcZG+wJrTKXhe2FeSS7T7FchAtGKPCQMrDjAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMg9j8kls2c0ohP3Dm7sPZWiMv26pioDW0eAY+PldCqHmvx4qecvOY4gLrYc/qzROGmwdTjqnxmBwFbPY6KhaW4Qn4jHIeCB02r+I/tHA+Q2BZE9hAiW3SNcAAmBxj9GX+HQIeYV4Qaf2FN4noYiOk1WZaq2hDZuW9RhWsArdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=cen6C54K; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="cen6C54K"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 2EC976B28B0F;
	Thu, 10 Sep 2026 09:21:26 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id D58316B28ADD;
	Thu, 10 Sep 2026 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1789032085; bh=lqugDnkcZG+wJrTKXhe2FeSS7T7FchAtGKPCQMrDjAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cen6C54K6mJoWn65EDQIJozCg7utKay0pqF4IJzPDNCZ6pOvJFsfFUrc0BkckQcYr
	 zI7UYSFOqsFmPeXmbDIjQt7aByz9Fim3dM33q9hN/2cLBU3ZcBMY1sRRW666Rzi+VB
	 djDIhMVJJDYKLYwqOziTbHDCQWimb9ZZ4rgpvPuKSJeQAv63Ha24rzg4aq/F0k0gO1
	 3ErM2OJYIM+bCiWElisTRNplhQPzZj8sUX/zRmBjVzD/kL+6Ml6RCPFI/Yu0EpZtMF
	 eP+AkqFi57S/NDKgexSac9OC+HTeHfkpdeXynzkCywuWCMYuZN5aO4ajpSb02lUksS
	 oiv8cArYX+AEA==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id 87787B400948;
	Thu, 10 Sep 2026 09:21:25 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v3 2/2] ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
Date: Thu, 10 Sep 2026 11:20:57 +0200
Message-ID: <20260910092057.3980-3-green@qrator.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910092057.3980-1-green@qrator.net>
References: <20260910092057.3980-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipstats_show_hw_stats() returns as soon as IFLA_OFFLOAD_XSTATS_HW_S_INFO
is absent, dropping the counters that the message does carry.
__ipstats_show_hw_stats() already copes with a NULL info attribute, so
let it, and skip the record only when neither attribute is present.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---
v3:
 - No change.
v2: https://lore.kernel.org/netdev/20260908181225.31712-1-green@qrator.net/
 - Trimmed the commit message.
v1: https://lore.kernel.org/netdev/20260830181949.1096-1-green@qrator.net/

 ip/ipstats.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index 1d44fe47..59cecfe4 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -472,13 +472,16 @@ static int ipstats_show_hw_stats(struct ipstats_stat_show_attrs *attrs,
 	int err = 0;
 
 	at_hwsi = ipstats_stat_show_get_attr(attrs, group, hw_s_info, &err);
-	if (at_hwsi == NULL)
+	if (at_hwsi == NULL && err != 0)
 		return err;
 
 	at_stats = ipstats_stat_show_get_attr(attrs, group, hw_stats, &err);
 	if (at_stats == NULL && err != 0)
 		return err;
 
+	if (at_hwsi == NULL && at_stats == NULL)
+		return 0;
+
 	return __ipstats_show_hw_stats(at_hwsi, at_stats, idx);
 }
 
-- 
2.55.0

