Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626E41A936
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927287; cv=none; b=fx5QA0mnAHNMOx9ovuflsaj8hyiSMVal3ncOL0q1zGaVM3iMqsXfd7w0lUvyKuYYGcvglP9GBH3EEiIzPUi/8sIrkzDYQh84Fj5x0g2nw5lEohuZdn3kVHSk8uodeuYpwcUjR5PFm1+PrTjZrB8Qz1lSwJwnpLxZsnOPBO1BAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927287; c=relaxed/simple;
	bh=9jqXNdDXQ5Z1fXAsQzd8FcgXPVzuqMSX7gH9I6ww4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbFo2W4kINj1aVxJgKDjhY8/3oZRFgRqs9GN8VuU/qRPhJex02fX56VYmP7e6e+Bl7KJHK59q5CXdPqQtubnoiyN6zZgMQaKz71rsZnwinl3xpTLFrjaZ8P3ppxsoY02zMfjnowlmDcA2Q/10Lf/88xg+SU4vfBiuhDpkzOB0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu+G3UV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu+G3UV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A41F00A3A;
	Fri, 24 Jul 2026 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927280;
	bh=tONd1PiyrBVGhm1wyV5SdRZ56dHbbHUhtGQvt8Sfc4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iu+G3UV0V0C6dB5/zv7fIjFE7niek91CNwc031ZsOuSvoKrmM39pj3C/AE0MonkJ5
	 XNSSZ/YpsWhYpjNAPcQICFVRe5H8K0b6zZh10mBgPS6DTWWI/aok5pvUnFMbiwEiNx
	 RiylXEP9xIRHi0Y+1Y35zIhx8omydhLJFtTPlrkPXjpK+VqmMc0SV+8c2privvbzOy
	 9NBNPMWSHYcp+Vg5TIojOi8/ntZ2+Nef2nOIRizdVyIRzyNpgs0K02f3BU0jH+Tmbi
	 9wtKB1J+tqLcJFTyJ/A4R17l+0gS7C8N+737KCLdtezyvr3Q88/PVizWwxj3MzFniv
	 8HTyAXmMUWYgQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] net_shaper: remove incorrect comment about group leaves
Date: Fri, 24 Jul 2026 14:07:54 -0700
Message-ID: <20260724210756.1553565-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724210756.1553565-1-kuba@kernel.org>
References: <20260724210756.1553565-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is true that the user-facing group() operation can only
be invoked with queues as leaves (see net_shaper_parse_leaf()),
but the driver facing op is also called when we delete a node.
When we delete a node we conceptually call

    group(parent, node.list_of_leaves)

to add node's leaves to the parent. Node deletion "mid-hierarchy"
is supported so some of the leaves may themselves be nodes.
Therefore the driver facing group() may be called with nodes.

Remove the incorrect comment, and add a comment about differences
between the Netlink API and driver facing API.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/net_shaper.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 3939b816b001..0fcca29207ac 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -72,6 +72,18 @@ struct net_shaper {
  *
  * Each shaper is uniquely identified within the device with a 'handle'
  * comprising the shaper scope and a scope-specific id.
+ *
+ * Driver ops vs uAPI
+ * ------------------
+ * Members of the driver ops mirror the Netlink uAPI but driver calls do not
+ * map 1:1 to user calls. Drivers need to be careful when assuming that calls
+ * disallowed at the uAPI level will never be made at the driver level.
+ * The shaper core performs automatic reparenting and cleanup, generating
+ * additional calls. Notably:
+ *  - @group calls in the driver facing API may have nodes as leaves (user is
+ *    only allowed to construct groups with queues as leaves)
+ *  - @group calls may update leaf's parent if the parent is about
+ *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
  */
 struct net_shaper_ops {
 	/**
@@ -82,7 +94,6 @@ struct net_shaper_ops {
 	 * The @leaves arrays size is specified by @leaves_count.
 	 * Create either the @leaves and the @node shaper; or if they already
 	 * exists, links them together in the desired way.
-	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
 	 */
 	int (*group)(struct net_shaper_binding *binding, int leaves_count,
 		     const struct net_shaper *leaves,
-- 
2.55.0

