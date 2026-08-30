Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580C3812D2
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114064; cv=none; b=HMRI6Sa+CLhFkgJwG89CBOz1Y60CgwEnEirZib14PJ38YHcWxJAjbS8InZj1Wex/KPPQf15sSDM60bM8TPD36D8eYCRc2yruEpF1+SAzSY/Lf8afdQJUbjOBiU0GOXp8Cew0Xzo8f79YjKKUmAPX9RzhXIzLlWYhIJeV/bWI0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114064; c=relaxed/simple;
	bh=V5BahRuGduMOtjErC/5xcSsV9ljItK472tfqJYNHQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNbQZlcGukxbmGOAObaufcM6E2cwOa6GNAh/SnNwa1ZPbRZbrLm+tm8fPtrfMxEZ2XmVVdmEDJG9KAgjuQLS3dcQ5FiQuuoOeMSCHh2ACNSvt4JV0L7Nz3SwcGhx7AD0CJbJn2VGRt+ST1R35rjRZ2RRu+WyumhCsbXuI16Mon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=BGFrKkf1; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="BGFrKkf1"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 930736B28A83;
	Sun, 30 Aug 2026 18:21:00 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 698206B28A80;
	Sun, 30 Aug 2026 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788114060; bh=V5BahRuGduMOtjErC/5xcSsV9ljItK472tfqJYNHQ7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGFrKkf1bT13NiOAeIdoMIltAV36lPVpYYczyBxej4Wp6vf7mjtnStk+ozapcXP8w
	 nBmPYLB9lZY5++9NsJPLjDnKk7Q75GpPBpz+AiLFtw2QpzttfGNs1XCtpD06lb01/W
	 CZMVYUDrlBU+YEddiHkUx9i/Bwq5iZWJ4c5UCwZGsDiITMtSEpUffPPu3ohh85Auuc
	 agCi5hi+u8oAIcYCYjNA93epLkcdPXqLeShy0AcaBylcj38mP4+FAkK/w9I8a/vXxe
	 0CLxILB/p0w0iokLt5ipzDtOQ4LwbzMIylYRkV41N2dLDJzmOmeSkHa+64EucPyw/0
	 z95h/e6ZyvwVA==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id 309A0B3A8ADC;
	Sun, 30 Aug 2026 18:21:00 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH 2/2] ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
Date: Sun, 30 Aug 2026 20:19:49 +0200
Message-ID: <20260830181949.1096-3-green@qrator.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830181949.1096-1-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipstats_show_hw_stats() returns as soon as the
IFLA_OFFLOAD_XSTATS_HW_S_INFO attribute is absent, silently dropping the
counters that the message does carry. __ipstats_show_hw_stats() already
copes with a NULL info attribute, so let it, and skip the record only
when neither attribute is present.

There is no known way to reach this through "ip stats": the l3_stats
descriptor always requests HW_S_INFO next to the counters, and since the
previous patch the two are reassembled even when the kernel splits them
across messages. This is a hardening measure so that a message carrying
just the counters is displayed rather than silently discarded.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---
 ip/ipstats.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index c531885f..54b8267d 100644
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

