Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B032E6BD
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906359; cv=none; b=nILVSuVwNpue2DVIVwgbhYriDnpEwaDkL7u73tGxWTDPW6BDJu19SCRLmoimDOI/5MIrzqR7h5I2xKvNmMvaefdLEiTkUMCFeDd+L8QP46NxX8ImYVvzWWq72RAIww7yDfSEqbFwjoO/chL0DcdczVkKPm4CGhjYzJ3ioiDeroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906359; c=relaxed/simple;
	bh=NH9650joR4S2M0tpmlUURAGIA17SLpGHyaVx878mh7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6gWqAB1wX4H/Onktscb9j8TRhHsNZDCGcHjrHFj8vNDzGfzXxwZLiNMSuROBKuWi5zF9EnJcgbFhwMbv6GUaVlJh6TqcCPnPO2KjP1OziGZRGyIVaZc2szdemeLIREgsLzmhwF43yGrr4BuYJmNAEn5ykemjiLOk8O5sFREIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA/CAu+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA/CAu+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBEC19422;
	Sat,  7 Mar 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772906359;
	bh=NH9650joR4S2M0tpmlUURAGIA17SLpGHyaVx878mh7g=;
	h=From:To:Cc:Subject:Date:From;
	b=sA/CAu+xlv+GPuAg3npwBl24SRhNxxCIHx2Ne+iGSNJzxwNDYtCLg40N3YPJMjXD7
	 Izm0zw0SsSK01f8hyw89ncZ25VYGgQ9oQJVCqvhK8mrgMfd02ye/3eU1UcNzWk2uGN
	 rc+/yTDZzk7HrdAcE4P65Bx8mddPI+5mV625lfXEwI+1TASynKuWBAUeTsco5USH1c
	 4XzHyEWH4CeD9rEwwQIPzFFXaupQSg5PAHr0UqkwlIiZ3Q9g0cqgWYYDQh3k/HuFN0
	 gIyIqV89oz8jUcb7m1Wfm9nKEAwCxDJ75+YEaB7g1MN9tqyH0pMapnJyeBLtY+B7y3
	 IY8z5KO2XjpWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com
Subject: [PATCH net-next] tools: ynl: cli: order set->list conversion in JSON output
Date: Sat,  7 Mar 2026 09:59:16 -0800
Message-ID: <20260307175916.1652518-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NIPA tries to make sure that HW tests don't modify system state.
It dumps some well known configs before and after the test and
compares the outputs.

Make sure that YNL json output is stable. Converting sets to lists
with a naive list(o) results in a random order.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: gal@nvidia.com
---
 tools/net/ynl/pyynl/cli.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 94a5ba348b69..b452d4fb9434 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -78,7 +78,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         if isinstance(o, bytes):
             return bytes.hex(o)
         if isinstance(o, set):
-            return list(o)
+            return sorted(o)
         return json.JSONEncoder.default(self, o)
 
 
-- 
2.53.0

