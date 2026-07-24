Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12B3D4119
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927288; cv=none; b=dBDAIeuQohEMJis5zAW/rHXp3W5PY45IpzDnM4No2jngjNk6CnbjntNE0NaFXXEWCCmH2OSIFMPrSXCDpSatCuV9cvryN/J5HL65/ChAloaQa4I7j5gFfnA/4Qrb+TN7lCJsMYD1hI3wzEgWFSXAWGthNA+84XHApPdAEu/Hyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927288; c=relaxed/simple;
	bh=83wnhAdZeBtZvwOsPyzEqu7qisUhAowN1vVsyel+2qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruS0U4laFYmV41rFg6/4UyPYjTDkX2h6quL5r6DDqyyuh++WFq4RqGdMyvamgNC9lVh+z2gWRwZCcfHh8h9Ggbd38/aFPFHUaNy+Qas4EY9P1r7FvVpyNDmfZQLtiDAYLEKSLMmgeNNpbRexpUNgWY0SBeayokCuh6G6epPGUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3jKbvC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3jKbvC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903521F00AC4;
	Fri, 24 Jul 2026 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927280;
	bh=FHIx6O670asWPym5kD1Y81Gwn4/wmnmIICRVk9zFnb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3jKbvC+zH0WoT4rscNUZ6+rFS3chh35tv5H2vr+OkGWo7yXN2uXx8trbKWklR9Ot
	 uLAax7qdZ+i+tFCyuRvfMW7yNfd1UQZXEUEo17HWIZgBVWTtIlG2n7lEwgDAZC1ve8
	 t4X9FYe1rQT4fhVVJPD8QDX1JqGrH4lvXMZj4YJuYd6nohtkPhOy7E3OrIe//EEoxW
	 yOeLT+QDHHr9KQqFyp/u92BcNgo/FUnk9ACuW6C5qt2vOyfxEOwLrXKLm5kRViyiHl
	 vAKSTrTCP5pZsRO5do4CSW2geCaAQR7RtOtiodNjA1JfurAToYwfmjiRrOGVhDMx7/
	 wJ3kpuASoVkyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] net_shaper: clarify the kernel API / comments
Date: Fri, 24 Jul 2026 14:07:55 -0700
Message-ID: <20260724210756.1553565-3-kuba@kernel.org>
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

The shaper API takes some getting used to. Try to improve
the doc on struct net_shaper_ops to help driver developers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/net_shaper.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 0fcca29207ac..c14eb87efe5e 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -68,7 +68,7 @@ struct net_shaper {
  * The operations are serialized via a per device lock.
  *
  * Device not supporting any kind of nesting should not provide the
- * group operation.
+ * @group operation.
  *
  * Each shaper is uniquely identified within the device with a 'handle'
  * comprising the shaper scope and a scope-specific id.
@@ -84,16 +84,30 @@ struct net_shaper {
  *    only allowed to construct groups with queues as leaves)
  *  - @group calls may update leaf's parent if the parent is about
  *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
+ *
+ * Implicit creation
+ * -----------------
+ * Shapers are created implicitly, meaning that @set and @group operations
+ * are called both for existing and new shapers. The driver has to infer
+ * whether the operation is an update or a creation by tracking the handles.
+ * Removal of shapers is explicit and done with a @delete call.
+ *
+ * The @set operation implicitly creates NET_SHAPER_SCOPE_NETDEV and
+ * NET_SHAPER_SCOPE_QUEUE shapers.
+ * The @group operation implicitly creates NET_SHAPER_SCOPE_NETDEV and
+ * NET_SHAPER_SCOPE_NODE shapers (the group shaper itself), as well as
+ * NET_SHAPER_SCOPE_QUEUE shapers (leaves).
  */
 struct net_shaper_ops {
 	/**
-	 * @group: create the specified shapers scheduling group
+	 * @group: create a scheduling group or add leaves
 	 *
-	 * Nest the @leaves shapers identified under the * @node shaper.
+	 * Nest the @leaves shapers identified under the @node shaper.
 	 * All the shapers belong to the device specified by @binding.
-	 * The @leaves arrays size is specified by @leaves_count.
-	 * Create either the @leaves and the @node shaper; or if they already
-	 * exists, links them together in the desired way.
+	 * The @leaves array's size is specified by @leaves_count.
+	 *
+	 * @node and @leaves may or may not already exist
+	 * (see the "Implicit creation" note).
 	 */
 	int (*group)(struct net_shaper_binding *binding, int leaves_count,
 		     const struct net_shaper *leaves,
-- 
2.55.0

