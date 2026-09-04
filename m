Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C55249EB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549283; cv=none; b=jWFVN1bKUqX8HYav2BGxx2Beqvs2FYc7pzWrUkHl8SE+vYzFRh9bV2Bm8zVNs/0VKUyZPxR/rNnF7QLPRvcqjTntAPbHXD17hqCBjGreEPw7j1gVjTdT6Gf2zJk5KjQnlXarBvBF/SHuBuCEZ3un4sOuiP5onN+jxsEGAW98Q2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549283; c=relaxed/simple;
	bh=GeVp1Mz+axot10gKV3Dg9Mk3fC7EFPoush7Hwz68ocQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMROd3ZbjQA55NY+Mehi2vW1JoEH9coZiwi4QztlYxy4BU5HHZsT2JLB/9a8f7ZFx3FmNv3YTGpWrZOY5WVdxSNw8fhCXEwm0fMye+GQqA11YuYQnIcEJgE6okUGI6kU7ilaiTumnTDp3UzohfaBS8hZSJhSwIGeJABNsxQOGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzQfgGmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzQfgGmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99E01F00A3E;
	Fri,  4 Sep 2026 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549278;
	bh=xLx8IUu4uAeQCGJD/jiZY0sqeMRa7BgUMlvYlw+pMiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzQfgGmrqvICQiB8RRtXHacQytH2ifHFU0F+M8M9m2E6IMtGtY+jHXQhUcUQHfZK0
	 CLegSIABEHntl1/vNZWNd2amPGw738r4QrUcOhKcDe0QfWoKQAHN0gg028Ky1XR4Ze
	 9PHvvoQCBT8nnYTnF631JYQP+DGh4M0K2UkJHYT9MqBbb/8a20i5WGBd7jTzqUdwD1
	 co2tXMHfxqnNUpw61Kuvk8vlZ5BJ5peUe4OCujkxsIVen5JMBr41QJh/TY0GG6q3+U
	 V3s6iE7vMdMjjMZYvum5yOFcNq1Uz6Kej2f5OC5qO1AlGRo2N15RGkMiJhQWbIs1LG
	 c0TCLHQ41+18Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] netlink: specs: fou: local-v4 and peer-v4 are big endian
Date: Fri,  4 Sep 2026 12:14:11 -0700
Message-ID: <20260904191412.3872344-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191412.3872344-1-kuba@kernel.org>
References: <20260904191412.3872344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fou_core.c uses nla_get_in_addr() / nla_put_in_addr() on both, i.e.
they are __be32, and port / peer-port in the same spec are already
annotated. Without byte-order YNL swaps them on little endian hosts.

The generated policy goes from NLA_U32 to NLA_BE32, which changes
nothing: lib/nlattr.c gives the two the same length in nla_attr_len[]
and the same range handling, and neither attribute has a range check.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 2 ++
 net/ipv4/fou_nl.c                    | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 32d34be1dc63..1d0db6ba7e52 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -50,6 +50,7 @@ kernel-policy: global
       -
         name: local-v4
         type: u32
+        byte-order: big-endian
       -
         name: local-v6
         type: binary
@@ -58,6 +59,7 @@ kernel-policy: global
       -
         name: peer-v4
         type: u32
+        byte-order: big-endian
       -
         name: peer-v6
         type: binary
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 309d5ba983d0..cdb174b92cdd 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -18,9 +18,9 @@ const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
-	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
+	[FOU_ATTR_LOCAL_V4] = { .type = NLA_BE32, },
 	[FOU_ATTR_LOCAL_V6] = NLA_POLICY_EXACT_LEN(16),
-	[FOU_ATTR_PEER_V4] = { .type = NLA_U32, },
+	[FOU_ATTR_PEER_V4] = { .type = NLA_BE32, },
 	[FOU_ATTR_PEER_V6] = NLA_POLICY_EXACT_LEN(16),
 	[FOU_ATTR_PEER_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_IFINDEX] = { .type = NLA_S32, },
-- 
2.55.0

