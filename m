Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA222347500
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524930; cv=none; b=BNSj673otpXpgt+DN/twQh2qe4gH6LHReiXYWJhgmZGg6eZKJRaX8sJd/6mzhH5tmWzv9IqSgytLZidbsGDdpLyXkycd2Dxxn8X03WyIIyPx/wj4D7gLNaGJT+CDnwLnXnMlyp8VKJXFpY1EPbMQwI+29sc/sBAKRxoZSbM6sI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524930; c=relaxed/simple;
	bh=1wdRSlmdiSjm6HkzZx4Oit4oKCKb5sPKww7jEUIB7lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKO9NXGuMsAiUuBggWh3d0sGKYTGCiy6Cu9I1+NCllRI/4qx+TJUolP4ato6+kVpVMvVAClkI1ASL5RVz9WgMIw1abIsMuGGiZAvt/JAH6rhHJVLk1errp/1ScEC5tFDRcgHQhYlUfoQUthEmwaephW2OkKB49jT9uanvz/rLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvt99tFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvt99tFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D083D1F00899;
	Wed, 16 Sep 2026 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789524919;
	bh=Ax9xUzjMNo2LfNWMGkdDIqGfgMqrqIgx6xtdtKyUHaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvt99tFtcQ7S8SU68Dv3wYaC9yHAgK3jyuT86CWgbXh7p13efrL8jpivEYuVACO1w
	 qc94l2IerPHtzm8qOfrfx0O0CBSuUqhyOJkQlKXrKMgGZuzGeCk4BrmSBSdkMdk2VI
	 EBww8m2TSFd4EDZ9ccl2KV/I6bvYmZ8rwWbeW/VX+nw+mXJ5p9D8DB6u0/qjqnsDtK
	 RmgU+8efudgfGxsfpZkpoXL6P8WWMClHEbUgSPI/XT7E2yYJ2TwcI2S77bIdG6pS1v
	 yqqD8PXqO9boDEkrrbpQFiexZZalVUQqEKQwqdyD37xk8svgjzqhckShDXAl4B1zR+
	 bkY5hLX1fd5ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] netlink: specs: nlctrl: let getfamily take a family id
Date: Tue, 15 Sep 2026 19:15:16 -0700
Message-ID: <20260916021516.1701760-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916021516.1701760-1-kuba@kernel.org>
References: <20260916021516.1701760-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ctrl_policy_family[] accepts CTRL_ATTR_FAMILY_ID and ctrl_getfamily()
looks the family up by it, but the spec lists only family-name in the
request.  C YNL generates struct members and setters from that list, so
struct nlctrl_getfamily_req has no way to carry an id and resolving a
family id - the one a client gets handed in nlmsg_type - back to a name
needs a full dump.

Python YNL happens to encode any attribute of the op's attribute set,
which is why this went unnoticed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/nlctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index 6acac4aeab03..a400365cdbeb 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -191,6 +191,7 @@ doc: |
         request:
           value: 3
           attributes:
+            - family-id
             - family-name
         reply: &all-attrs
           value: 1
-- 
2.55.0

