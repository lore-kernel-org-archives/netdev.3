Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC7414A1E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488836; cv=none; b=tr8wQm9xy8DNKohEAN5DXSJyyu6Q90PBfOmgf6XDMoD5bnf7HGVCr7oYSFZZ5LEhEyKU25DAYkZvox32yuR/lItgFSkKEtvglQQHVXbDQJlbGk+gMTjTEqDETALFBEpl/8NGCQGYJvRAU/2ojh5LUH3l/NNboPyr9GoJfqewTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488836; c=relaxed/simple;
	bh=7cxNku7gTYI/Cv1fpALmMU6ii1JdOKHDwL2ikCoiy90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaivvUKeMy9U6HaJ6s5FVVoM4KT0fDrAVZTUDlxHTE5Hh2T2xubpgWHuXpsZD/bNrdqucWI8mPxGewzSQ7NZnNJ5t+NjXjRzkDuvRiF/SPSfBd31/y+LZr2M06s78zaGTlX8be3PBagbJPi2zQI4PVVo/4bbHEjsttDnV1s93PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfYYkbpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfYYkbpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650641F0089F;
	Tue, 15 Sep 2026 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488834;
	bh=JG0vr5V8lGQTlAlBH3hwh0wWhgHI5smyVii0Yxj5/2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfYYkbpS++IhfzhT5vsD8gj+iiAKi556hhsgGIEydbOi9bpx5biPHqMos10Vwjyan
	 LAbhVVCid9rArwUoWIVa/5gtOhTmk4I+XdCOa5vmatzT1e1uO3dPLZ3y5+m8olwMYM
	 9KM7rLFeoft9frvPsM+Z4/z6vRKcwabRCaoNgBPOKc1xgOolVL42sOMVxYU5d+Gz+v
	 MlIrH5gU+pIMW4unHfzV5U0OyAKp6NYinlpr3bGtk8S0lTrBCUX8u+P3QFXqzJrAh0
	 iCisPDHBqmq+/cm29pm6N5lGI0V+eZBxFVuoNFFmB7tedB1NgNc9GRvk9IObqAl9fs
	 rYQiarmf5pqVw==
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
Subject: [PATCH net-next v2 9/9] devlink: validate the port index in the rate set request
Date: Tue, 15 Sep 2026 09:13:41 -0700
Message-ID: <20260915161341.1053476-10-kuba@kernel.org>
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

port-index is the only way rate-set can address a leaf (port) rate object,
but it was never listed in the request, so the generated policy has no
entry for it. The op declares .maxattr = DEVLINK_ATTR_PARENT_DEV, so the
attribute still reaches info->attrs[], validated against a zeroed slot -
NLA_UNSPEC, length 0 - which GENL_DONT_VALIDATE_STRICT accepts at any
length.

devlink_port_get_from_attrs() then runs nla_get_u32() on it. Handed a
zero-length port-index the kernel reads the four bytes past the payload,
which are the next attribute's header, and acts on the port index those
spell out. Since we're reading a linear skb the OOB read is still
within the same memory allocation, it's just garbage. We also do not
echo the garbage back to the user so it's not an info leak either.
Hence not treating this is a real bug fix.

rate-new is left alone on purpose. It creates rate nodes, resolved by
name through devlink_rate_node_get_from_attrs(), and never looks at
port-index.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new patch
---
 Documentation/netlink/specs/devlink.yaml | 1 +
 net/devlink/netlink_gen.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 4fb64e71063d..1de0daa0f921 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2447,6 +2447,7 @@ doc: Partial family for Devlink.
             - bus-name
             - dev-name
             - index
+            - port-index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 43ef6864d462..9e1b4c081a7b 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -618,6 +618,7 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DE
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
-- 
2.55.0

