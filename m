Received: from cvsmtppost20.nm.naver.com (cvsmtppost20.nm.naver.com [114.111.35.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79823E171B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447988; cv=none; b=oyiHsyK6bpmAUaGwfsrRq3afA1/CViA1mwKzc/Toc/xHpFoYQqq185MrgGd+ZTwNsUb/37RrFTQyk2c7uaA8LfKZkJ7sfR5sUlVJ/aWA3IxwXgB0nXCWkYd7EIrgrbTFnf8T2OAMj7L0Cyo8lHsSHiInK0qIuZPV+H448IjWo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447988; c=relaxed/simple;
	bh=hbqICua+cWQ7ljOSIYlpjCcGsS8vtyUpUiQ8PZiLX4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM3xKpp1GhGclMqpshXGhZkVXfKu8mP2l5yk9evFSUs/Rt12raVZnM11mF5ZeFJzlgzbkxZKrNXNSL+Muh/dn7zPllYpbzZKH31IAdxAojXD5dBeJW/Tl2YrGf0aAdhpurrwvGgeX06L2ehTB4JCB3nXXaG6bTcscgw7+9MzZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=M6kKh9BT; arc=none smtp.client-ip=114.111.35.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="M6kKh9BT"
Received: from mvsendbo24.nm ([10.179.34.213])
  by cvsmtppost20.nm.naver.com with ESMTP id 9YuQtNsCSqiF0KlMLZJpdQ
  for <netdev@vger.kernel.org>;
  Thu, 08 Oct 2026 08:26:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791447978; bh=hbqICua+cWQ7ljOSIYlpjCcGsS8vtyUpUiQ8PZiLX4A=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=M6kKh9BTfgkYMI7kMDatmPe1Li1sJlz7PV2XWdPDMwE0wNPAZvYqPLbtsIDg9XAfK
	 qFFcyuHLlxpMx5uNi/JrewcAxWwHFAH/5wosjdugqRcxbrZ1fC9apYuqOeTFusgu0N
	 3t2HfpKlpfwg0PeqyXve66ifQcMMHJJIIIYY+PWY3JSWo3rK8hirEud3dRWn54ZxW1
	 T0DKHC4dN/YxVmhxqTyzSrEQcGuqqxlh9KMjNVKRvYSMMPbew3tT1puiDH4G3853TN
	 I4Jj2o2pPD1DocWvqvzDma6FvkgRSdz3prCij1otawexXpfUqTY7MSfn6zR4wF6sDn
	 F6rpt7P//3QBg==
X-Session-ID: A357ttzmSyG6lkD3gbywSw
X-Works-Send-Opt: OlRwpzGdjHmdKHFOMr39Ko3YKHmZjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: X9bwFAulFqJZ+Hm/FqE9+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp009.nm.naver.com with ESMTP id A357ttzmSyG6lkD3gbywSw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 08:26:18 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] macsec: ignore inactive receive secure channels
Date: Thu,  8 Oct 2026 17:26:12 +0900
Message-ID: <20261008082612.350120-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive path looks up an RXSC by SCI without checking its active flag.
An active child RXSA can therefore authenticate and deliver frames after
userspace has administratively disabled the RXSC.

Restrict the receive-only RCU lookup to active RXSCs. Keep the RTNL lookup
used for configuration unchanged so userspace can reactivate or remove an
inactive channel.

All three baseline runs delivered a valid protected frame while an
independent state dump reported the RXSC off. All three fixed runs rejected
the frame. RXSC reactivation and RXSA off/on controls retained their
expected behavior.

The demonstrated impact is a revocation and integrity-policy bypass. No
memory corruption or RCE/LPE primitive was observed.

This change was prepared with assistance from OpenAI Codex. I reviewed the
source change, test results, and this commit message.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Assisted-by: OpenAI Codex
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 78a19b1346321..02157c97e0004 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -989,7 +989,7 @@ static struct macsec_rx_sc *find_rx_sc(struct macsec_secy *secy, sci_t sci)
 	struct macsec_rx_sc *rx_sc;
 
 	for_each_rxsc(secy, rx_sc) {
-		if (rx_sc->sci == sci)
+		if (rx_sc->sci == sci && READ_ONCE(rx_sc->active))
 			return rx_sc;
 	}
 
-- 
2.43.0

