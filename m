Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDA495039
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070603; cv=none; b=F348sFy66fFG93Tphp13KgbjvgY6VdktTmZJJsBeNnl0EsbQcjl1yKTMPsLHccpY1JMnql9IJNw2si6TALXlnTiwUBkSlUTKOQFLdRxCdxO18Rb7XM9QHpk9Co1CW4cLdZXr4CCqHXzhMQ0mXmjGLgczBVqICdinhzEPRnOdg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070603; c=relaxed/simple;
	bh=Y5NmeELjRA0H0Z7Tyo9IUDAfF0FiescscXvZYWgENz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFE6mVO5fywfB+qskttQww87BTtbj9Yo9pVDPrlfpSeppUp3bswT0zcJdzvfwmAh9KFRi2q+0pon47xQfuWr3CAyP6Ofxizbw0QZ22cinvKs4t/cPbRyUPRIBtLnlVwyZnAtaQQ/frjKVTJ1MuY+WWhDRP8JijIKT2Fo5wVeTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDGKUvH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDGKUvH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B01F0089A;
	Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070601;
	bh=rVoJYA10hgFRxPQ3FiIPlJNTdopEnIGZ2PfLbBPRUyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDGKUvH1CiZeuUAFDi6x8yOYz09MTUSeFZri8rOAgQ74aDVyeNEt+sq4ZPIK0Tg04
	 FvwkDHtt5dv9TVOIXGG2s2DLblpDQC3QqodhQl6VecO4yqnNNnd5AIfRMmaOyyzdrK
	 Ei591ceQbZQDFRSnHobQ5tB//Ja/lU2wBjHIPWAsd6sKi2HGCamwqXup2m05QD/taz
	 1+CMYj5CMOLVcVITK4Xf26PDrhXyFxgdsMgxTnybNSP9qNGRgMC98BER24P4TqySRk
	 99UCqVqDrRo/0DUbWNq2vaZTEcwPn7loaJ310aqNSir8hJGzS21BS3SIyfP3+YOkdg
	 6dzuY8NxZix3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	tariqt@nvidia.com,
	moshe@nvidia.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/8] netlink: specs: devlink: drop the stale port dump reply value
Date: Thu, 10 Sep 2026 13:03:06 -0700
Message-ID: <20260910200312.2665792-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910200312.2665792-1-kuba@kernel.org>
References: <20260910200312.2665792-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug the comment describes was fixed by
commit 61c43780e944 ("devlink: fix port dump cmd type") two years ago.
devlink_nl_port_get_dump_one() fills DEVLINK_CMD_PORT_NEW (7), not
DEVLINK_CMD_NEW (3) now.

Note that this change is likely a noop. _dictify_ops_directional()
picks the "do" section's value when an op has both "do" and "dump".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index d933b205ee86..0e0791d4e2c7 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1401,7 +1401,6 @@ doc: Partial family for Devlink.
         request:
           attributes: *dev-id-attrs
         reply:
-          value: 3  # due to a bug, port dump returns DEVLINK_CMD_NEW
           attributes: *port-id-attrs
 
     -
-- 
2.55.0

