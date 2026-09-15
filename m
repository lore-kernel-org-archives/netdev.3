Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12673112AB
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488832; cv=none; b=q8WCsyvrF17LuZH1ei3LAHjpUVEbIYNT9gSlNyfXJi4s6y1EAc5nQbQSw1zZfQt85hJ45kKD80HTc6PhHsW02PRUS6fp3RQEj1cwX3dm4i+iFP89h7ZLHt6eSSOIa08eNiIVhbzQC0LV5k63IWmHz0GHcU4uYxRi+Qz9qkbsUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488832; c=relaxed/simple;
	bh=bpe8oALN7u4lWe88d8XCLms9BNoPvVbb0fixdgKtnTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9fQJfZH9SRkXmzBXHuzGwKZL79FZkvBdiN5rqZszhoNkRljVrrzldB6xGvbau+dyh+qy+MQpKGsmVoN8p6T/G+AU21nVLBHVMBmv7xvfBcoc5bfaPsiixSNTiBYc+wa0t3iwGrBdpNfZzatu/iXX719zyPChkQ6XW0wevRIBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+V5E7ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+V5E7ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E43F1F0089C;
	Tue, 15 Sep 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488831;
	bh=SO2n52F0J4bwdGVbyrgB6iZPqBS968H7gpilo0C/lEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+V5E7cejlCq2rtFjA8rTEeKUaRWKhs4rm7M5O7EgHwdkTvB+P5unZuPtieQ6y5WH
	 Mty4sohylAHjrtc89NEgQrkAfyMK9bHV7txEs+/YOby8QhnHhtM3dFBoeNBG2XNbnh
	 hX73aRI4LYAC3wHuhsYppbaYhfCqhLFuZx3gkPzg7jZwWhEhp7Y/LfSydJzltPfBMQ
	 jfi8u1PX7hu0BfY40ZAs8ZTCqqRarChYuJZ3Hf96CNrEFfoCJiUy+tW3Swc764VhlZ
	 0pP6aw4yNC4dM7S80HKoO+rXSS47EUIt75DpxyesdEfoKqlkGBNpcT+CsMoBr5J+ts
	 G0n90kceAa4uA==
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
Subject: [PATCH net-next v2 2/9] netlink: specs: devlink: drop the stale port dump reply value
Date: Tue, 15 Sep 2026 09:13:34 -0700
Message-ID: <20260915161341.1053476-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915161341.1053476-1-kuba@kernel.org>
References: <20260915161341.1053476-1-kuba@kernel.org>
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
v2: no change
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

