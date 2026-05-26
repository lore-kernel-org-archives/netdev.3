Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285DE36F8E8
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809756; cv=none; b=EKiqACJkPz2B+qBBt+8jdakP/uaL7UgKQ6H0cbUiVgBCSgEuGCdzviFIW/aidsZ7ina7kExsQ0sh9T0bffp6Az0ybfn6jxLLovWEnJF9KpJCkS+SbEpeqFpUIRhNbjKvDxrkQq3NtAtzrp4/daCIC+1RJ5r1FhyjL0PdvtFOvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809756; c=relaxed/simple;
	bh=reQpjjGcpSifG1mNxuAnhT60BTmCnEs4iSwSLQtk8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evWAARAwwB2gP0UKSHwij5dCTG+FMS9Rn93ufQcC71u35uBQhVcjzz6lRn+qzxJoTli/fnALVpMmgkBOtLsRdGfYA2RKyTreiknyIrCAmwaRz/tCGRqPURRl/ktxV6HyfFEuWfdcUscz2wdOy+tBVp87+yadZW15PFDGisKy52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdKgFN/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdKgFN/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D11F000E9;
	Tue, 26 May 2026 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809751;
	bh=XM5aSWdgViswtR5jv814/7MjynWrwB1oLc/vb4EYME8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdKgFN/U2TjB913L9lqjrVPVx8WkhG6jv5YeZZ7ffZmHf2r/iQXt6XxiyalN67PsD
	 dFfaquA9t4s7x4DoCZzeonDghq17vaoUSBR4VGL7slo9xFJCoxbPXxC42zCz3Te1ln
	 eLktxDebU7WPtK7jgz/7rgqsW6Tyzos7A/tkxhrStKCj682ncz+v2+elaCVMw+zWuj
	 MyajYuuvC0viCoisN4BS1mF0Fh58/QpNND9Glp/wgCGPuDgExiVARCCp2rchSJGvoj
	 eDcSMISd0PvCm9ZYNG/yYAzoa7agF3l6et73YN5BPiE3pNDKNqjn90WPyhvHNcWbjX
	 oGrdiwhoSz6rg==
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
	andrew@lunn.ch
Subject: [PATCH net 03/10] ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
Date: Tue, 26 May 2026 08:35:26 -0700
Message-ID: <20260526153533.2779187-4-kuba@kernel.org>
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

linkstate_prepare_data() calls ethnl_req_get_phydev() before
ethnl_ops_begin(), but routes its error path through "goto out"
which calls ethnl_ops_complete().

Fixes: fe55b1d401c6 ("ethtool: linkstate: migrate linkstate functions to support multi-PHY setups")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: o.rempel@pengutronix.de
---
 net/ethtool/linkstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 8a5985fd7712..24569e92942c 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -106,10 +106,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
 				      info->extack);
-	if (IS_ERR(phydev)) {
-		ret = PTR_ERR(phydev);
-		goto out;
-	}
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-- 
2.54.0

