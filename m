Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382EB3612F6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405982; cv=none; b=iuGuKalS2vBOvVBAFhgdaCpA+U6XhgNnEHG03VPdrskhY12mkdUaHBp1ey8F7vSQUwicXX2AC+NAsaT6a9L6jwhQuUDJygtFLqV2mSOzxemCgZgCDHiM0ZNX9ITKBk9x2hYc6SG6bDHwtgOmu8PL/2z6lJuyvjbo4Mbl494HVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405982; c=relaxed/simple;
	bh=oisEO016+ghNFWxsfum1qDDjmsCuhNSyKfqGsbO4MQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGJ8xJ/+9VltX2gCoaf3f05IyBXHWFPIVJ7VMH+IUVSl8rsxNzIcDoeX5mAx2d7T18FZI3RZloeoT+/krn7GGjYfgeemAVgzJzp8dS/HNoneEKLpMQUpztYQSj38ssyDWOerEX1ZXEl+l1v6R2TF9eIGXFxC549frNHCkKB94Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTf24ISg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTf24ISg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2E11F000E9;
	Thu,  3 Sep 2026 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405981;
	bh=+oDU8dYuXpRDE7B3R4FDnED2XKWN45YNeTQVA5nuAk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTf24ISgr14ksNSIX/ImWj/pWqwNerHALICkWv+g8NGTQBkgMDfZavQYDw1WEvAqC
	 eAp4nMO7P+7SRh5wAW1N376n2dfuahpEonxNgH5TKOYipRy3486a0I3Zc3iFY80842
	 ZZ7K3Cuv6M8p0iEW5A6Yfw6epSuzrau5mMiWqwBJ+eKwRvoSa8abD9ujA4/lxuEo6z
	 aUSOeUYG5hrVNu3yZSFU2xPzS2pO48aQA2pXq4PVJ75+vHofN5gUNxdO0ZPDCoevap
	 Hh54swD/NhdDEt13IDLGdu2lI4Uv8oiFAfeMX1pzqjSg9NoJ4Q3AzimwI8sf1XhOGy
	 gu4YJCI2LY1Yg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com
Subject: [PATCH net 4/5] net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
Date: Wed,  2 Sep 2026 20:26:10 -0700
Message-ID: <20260903032611.3000029-5-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903032611.3000029-1-kuba@kernel.org>
References: <20260903032611.3000029-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6xxx_get_rxnfc() uses rxnfc->rule_cnt as the write index while
dumping the policy IDR, clobbering the input value before it has been
looked at.  That input is the number of entries the caller had room for.
ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN and the ioctl sizes the
buffer from the rule_cnt userspace passes in, so once an admin has
installed policy rules any user can ask for fewer slots than there are
rules and run off the end of the allocation.  A rule_cnt of 0 leaves the
buffer pointer NULL and the walk dereferences it.

Count into a local so the caller's limit survives the walk, and stop with
-EMSGSIZE once it is reached.

Fixes: da7dc8755304 ("net: dsa: mv88e6xxx: add RXNFC support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: olteanv@gmail.com
CC: vivien.didelot@gmail.com
CC: f.fainelli@gmail.com
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513..7f68a0c55802 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2438,6 +2438,7 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
 	struct ethtool_rx_flow_spec *fs = &rxnfc->fs;
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_policy *policy;
+	u32 cnt = 0;
 	int err;
 	int id;
 
@@ -2463,11 +2464,18 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		rxnfc->data = 0;
-		rxnfc->rule_cnt = 0;
-		idr_for_each_entry(&chip->policies, policy, id)
-			if (policy->port == port)
-				rule_locs[rxnfc->rule_cnt++] = id;
 		err = 0;
+		idr_for_each_entry(&chip->policies, policy, id) {
+			if (policy->port != port)
+				continue;
+			if (cnt == rxnfc->rule_cnt) {
+				err = -EMSGSIZE;
+				break;
+			}
+			rule_locs[cnt++] = id;
+		}
+		if (!err)
+			rxnfc->rule_cnt = cnt;
 		break;
 	default:
 		err = -EOPNOTSUPP;
-- 
2.55.0

