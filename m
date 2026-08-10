Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215735B64C
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384915; cv=none; b=b3yaQjO72rSx9PMaSari1OQguGGlcQNKPtS/WrlBvXnX3Fyobgan8dyUbthbzKF4fIj7pbs0yEA3f4h/NRk4hAb9kVFJJHPtN+opi8WaHymtpVXZCJVHQc/ueC0/z/pjS6sQHuZNPkPx1ZyP9SO40FZ/SmJIPcrgwE12jvsZX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384915; c=relaxed/simple;
	bh=tkSchSFp4xgTTAdZ0dmhJNFX3SMXVsUXoY36/f2E1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTtcweBGQr5WHztMAaCFjcROiLSkq7k1AJRgiobaxjv4Bdyp80sX2cJ4LjrLKo9cb1oEqblB1H++0XaIjnhizWLq6cdJozoe7zCZioS+TMB92N38bHZQ7vJz0X+lrnfrlfB+AvjYzTBWHIN+rQ1YMCby3g4p1vU2mxiuJ/OdV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9ZSzVIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9ZSzVIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B017B1F000E9;
	Mon, 10 Aug 2026 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786384914;
	bh=6areEHj8cE2ql0cL4pBXm2JD7AA23Hb5Qa30Qm1ev9I=;
	h=From:To:Cc:Subject:Date;
	b=b9ZSzVIkwnuWDWt3IGqP0IL5sAicss5P6IewQl/XAOR1RWW2llEg5HnXHdRP+NfL3
	 YP/WD2qAFSS77O7TSz+LPK3TvF1sMGeyxP0AyI1kv7bHEp46ahLhG4ZFnXU7laHAbS
	 y/T6LTcuCqOGl9R2j54Z/zc7pd4SAlBlHyUUH0X/vuqpaVxejRDq1HAFbt+bnx6m1U
	 iCxTTUqVp93G7BaVvVc/AulWv/wLLNPhJHcW2cXfdrSTTwr9np+LbeyrDpI06LIAwq
	 p5fJi9cidNr9MVfxY0AJpB94Bx1G3NiTS9IqHfSJCG5vxRg9JvrycTEh6s3VAbSzJa
	 Hg+sp4uxuioDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jmaloy@redhat.com,
	tung.quang.nguyen@est.tech
Subject: [PATCH net-next] MAINTAINERS: make Tung an official TIPC maintainer
Date: Mon, 10 Aug 2026 11:01:48 -0700
Message-ID: <20260810180148.680425-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tung Quang Nguyen has been working as the de facto TIPC maintainer
for a few years now. Make sure the MAINTAINERS file reflects this
reality. Dealing with the flood of AI patches is a significant
effort, and Tung's work and responsiveness is exemplary.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jmaloy@redhat.com
CC: tung.quang.nguyen@est.tech
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a82b6ec9c567..ee4a9da0eb83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27257,6 +27257,7 @@ F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
 M:	Jon Maloy <jmaloy@redhat.com>
+M:	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
 L:	netdev@vger.kernel.org (core kernel code)
 L:	tipc-discussion@lists.sourceforge.net (user apps, general discussion)
 S:	Maintained
-- 
2.55.0

