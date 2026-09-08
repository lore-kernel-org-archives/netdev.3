Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461553CA99
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891556; cv=none; b=tBc3h8YsPRcehje8TvyMVPcEuXLslF9trCxFyAHVcPIlVZ0I3A4Y5dXbEJzBPBO3klk/riNrqG2PnMzxCjzdRi167lLfryuRdnxpG92IcqHuPcvXxheLjI252ZniP9CnNQYzDZrRC0qfYilJ3Q1UCZFjV3RnXtLFCmU6F5VhTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891556; c=relaxed/simple;
	bh=MGruBxHqmw+8DA/tW9oN2q2MpKChQPxRGWLWpXrDrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BioHqLWoBvd463pudRAswvE5xkKrGrw4KyxP3NcJ08FEAw2LcUfeH4GR8TL1PGuOnKdios00mXk25y+v1kggZz5CnoZgMHVKUSsn3rWGO7iPspnJGKVnYXL1hzF6Wd35X1bfpOy3CA/xhR3cvdEaBM9jgKG4cUbhM8U9/hDEO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=N7jneFtN; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="N7jneFtN"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 37BDF6B28B25;
	Tue, 08 Sep 2026 18:13:09 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 13D3B6B28B22;
	Tue, 08 Sep 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788891189; bh=MGruBxHqmw+8DA/tW9oN2q2MpKChQPxRGWLWpXrDrxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7jneFtNZ1k27ZRZazPxNAwptbudwW7JfDoZne0nSr0XSsAdddxq5klmYoooCFjyM
	 mGaTA9H2hOS8n47Ht7uUe8HKlFLqNTwy99TY7hUBtAWYWu0lGJXk4Ydm3Yy16nDcD0
	 QPyjl1HWCNi/T/CFlm8D5A93ww4Bt2UtRomr1gOUhnlATzRs/3LxuQgsv0mgN8ve+j
	 pDxFRtFD/lo07QSwPyqa+Uz5A8MeVNpWUd1/gsfFHLTQVsrK+XXas9sq9Xy7LxSb6O
	 Jb66yTSm+ufWQzTwhzCJx9JEiEPHccTPTX2qL0up91U2pmYAlSMyAByiGiJndrdCDu
	 gqx5I/l3lSjSw==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id 731E3B3F3162;
	Tue, 08 Sep 2026 18:13:08 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v2 2/2] ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
Date: Tue,  8 Sep 2026 20:12:25 +0200
Message-ID: <20260908181225.31712-3-green@qrator.net>
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

ipstats_show_hw_stats() returns as soon as IFLA_OFFLOAD_XSTATS_HW_S_INFO
is absent, dropping the counters that the message does carry.
__ipstats_show_hw_stats() already copes with a NULL info attribute, so
let it, and skip the record only when neither attribute is present.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---
v2:
 - Trimmed the commit message.

 ip/ipstats.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index f7a5619f..4edfcebe 100644
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

