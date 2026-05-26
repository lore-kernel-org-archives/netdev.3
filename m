Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895C37104C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809759; cv=none; b=sRWiRQ8A1oNVj05imNCue8QtH6gZI7wmvYP5F3EYsbig+/nKYaKtticnXlTggZlg6do2Id8kPzsfWDKKcCoFZSn4RTWI6q/ebN7/mgXC+Jfy0H/FYmXvRi+AQBISfvcbU8rdmwnUO29avFJNgVMLjcFw01X0U9FNxgBp8EW0p00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809759; c=relaxed/simple;
	bh=zBrt+NjuVFua6vF6RWs0TRUcpTJsvTpIyvDT1PJjrlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MY45iUZAkgl7dpYQDKopJlXV1S1NxFjoZkxqSdlIumrSIUGRMGhbPlDtp+NJ0tmLmhBZQT7O02UIFPixH4B5JdbWD+h42DdYOlFmnYp5Hwwwwx7/w3jrUlUI0Az6H94YPPF3jd5LR8/2G+sUYYBxldD2Fopd4Z+97E1Ld3M6L7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc/lGsRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc/lGsRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C521F00A3A;
	Tue, 26 May 2026 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809754;
	bh=VhyF1ahid+9l2WIwh+CjhCoYJrWZGCWAmcNR4dZIBhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sc/lGsRSY4My+gZyMf27T+/KTTsA9BPW7SzNYD296XHUOlAn5/pQ3vr2/hQ4hX9Tn
	 n8lXA/AtFo2k1aK/NKWEdgb6J4vcFbUL32iEEkGi3htr3CkLPXdFKDFlr+EVCEo6Iv
	 TtaS4R6W4Iq6rzG5eCyoO1c9jnFMnujtxsDdRVm9ku/CZEmf8hFSZWEXYDNGqYsuIr
	 gtb9UtzUsV3/3204/xzfWt7BV8pKmr0hlER5Eah+i32g05pzcrw1DcNA1NbQkSC3wi
	 Jg6zwfMWGVSouVFwZA9k4RUVb9NARpwiEWF6Fpgal/vEl9b8VrCQD5SqTF8ug1thL5
	 2j6NfsvOiNFfw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	liuhangbin@gmail.com,
	chleroy@kernel.org
Subject: [PATCH net 08/10] ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
Date: Tue, 26 May 2026 08:35:31 -0700
Message-ID: <20260526153533.2779187-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strset_prepare_data() passes ETHTOOL_A_HEADER_FLAGS (3) as the header
attribute to ethnl_req_get_phydev(). This is incorrect, in the main
attr space 3 is ETHTOOL_A_STRSET_COUNTS_ONLY, not the request
header attr. The correct constant is ETHTOOL_A_STRSET_HEADER (1).

ethnl_req_get_phydev() only uses this value for the extack,
so this is not a "functionally visible"(?) bug.

Fixes: e96c93aa4be9 ("net: ethtool: strset: Allow querying phy stats by index")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: liuhangbin@gmail.com
CC: chleroy@kernel.org
---
 net/ethtool/strset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index bb1e829ba099..94c4718d31ae 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -311,7 +311,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STRSET_HEADER,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
-- 
2.54.0

