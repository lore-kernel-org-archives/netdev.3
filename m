Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97836DA15
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508065; cv=none; b=bbXL1AphzqTS2K7Ggolg9KwEQZIUfpM+1fB+dVmL+kSpy0K3zXKKgCDfpH3OdFJK8wbjQmlZP8hAKJMfrI/BfgJA3l5SvspmcG3YYLSLL97p5lYMXuWaTK3Vpfdgbssoet+9U2b9X+oZy2kNnW14DE0XJ77seACuXxU55e3pHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508065; c=relaxed/simple;
	bh=QQWOQUchSxd2WIKgrIRfwrbBlsYxHLm4VslCY1+A1mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUzxBdIZI41LeiUWTp6X+e99Igzf1MfbK/l8pYoth5KeF4GcjAfhrruaEt3bQj/N5LN8HQYt/wpe8lQ1/M1r3OGlU61XWpEqdBjq4MtS+U7Q4t+CXQ3tQIVfahoUX5bdXcOVyrdrv2WVyKS5zX0tFlbrslo1LWUbWltd8ar9WIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=dppOm9yA; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="dppOm9yA"
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id AD88D2E5E3F;
	Tue, 15 Sep 2026 22:34:07 +0100 (BST)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received; s=20200110; t=1789508032; x=1790372033; bh=QQWOQUchSx
	d2WIKgrIRfwrbBlsYxHLm4VslCY1+A1mA=; b=dppOm9yA7xDIyKpyJUQN4AM2sk
	2c5hABv9EAvMO31T2g6NFNEqk4VZUVS1+9w5ho9FzSfhJVjJZ6hoA/BbKtFUUz6O
	OU5qrh/fEMlmYBRm6xmO5TWZ0hNYJdFPOOohqGqKeNvl/UaJ4V8uGw8cmH84144I
	Lf+eJNJUWLdGjlNo8=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from elijah.armitage.org.uk (elijah.armitage.org.uk [IPv6:2001:470:69dd:35::215])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 29E4E2E5E3A;
	Tue, 15 Sep 2026 22:33:52 +0100 (BST)
From: Quentin Armitage <quentin@armitage.org.uk>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	Quentin Armitage <quentin@armitage.org.uk>
Subject: [PATCH v3] net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset
Date: Tue, 15 Sep 2026 22:33:21 +0100
Message-ID: <20260915213320.1527029-2-quentin@armitage.org.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915140518.GA687229@shredder>
References: <20260915140518.GA687229@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
added validation of IFLA_INET_CONF attributes, and in the process
changed the call of nla_for_each_nested() to nla_parse_nested(). A
side effect of this change is that the IFLA_INET_CONF option is now
tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
commit there was no check of NLA_F_NESTED.

Change nla_parse_nested() to nla_parse(). This restores the previous
functionality of not checking NLA_F_NESTED, thereby allowing code that
(incorrectly) doesn't set NLA_F_NESTED to continue to work.

This issue was identified because keepalived started logging errors when
it was configuring macvlans that it created.

Fixes: fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 net/ipv4/devinet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..5b6b11c943e4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2117,9 +2117,10 @@ static int inet_validate_link_af(const struct net_device *dev,
 		return err;
 
 	if (tb[IFLA_INET_CONF]) {
-		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
-				       tb[IFLA_INET_CONF], inet_devconf_policy,
-				       extack);
+		err = nla_parse(nested_tb, IPV4_DEVCONF_MAX,
+				nla_data(tb[IFLA_INET_CONF]),
+				nla_len(tb[IFLA_INET_CONF]),
+				inet_devconf_policy, extack);
 
 		if (err < 0)
 			return err;
-- 
2.55.0

