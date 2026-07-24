Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883FB3F328F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927286; cv=none; b=dK7wHqELNNueNNKYm8n2QlqWU1ULeMxrDCTBVNcd6Hsh3y8Jow7vF3DVwzCuI681bmtRcWKSP8f3Dz7AzCnC74/Giw1yvWW1NPr2PJNCFWfAs4uHX20vpmBOmro8dulTry0rIcMMcbw4VtYUoAKI3oXsy6tmz4zKykhGnk8zr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927286; c=relaxed/simple;
	bh=T3nldn4EY+Zh5g2FRSGG9zabahFL+CL1qnd8U+C3K28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi8ixKXbWwODXF2wr40Xe0urSQNsvUBZOfcNmKa6ENXm8IFdZTOvAxsIxyFtIvL1qaeWaxQHqWibTSn7MQDScyLY6ALvvBe+ZqOjVuVx9lg+qbR3sA6g3av03Ibk7eKF1jADhL5idrHZFcX4K/3HxLJSL23ah6MEkJ+jln6OhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXvaZhkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXvaZhkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95811F00A3E;
	Fri, 24 Jul 2026 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927281;
	bh=ebkS+t7Pxl7cmYDikrimbDtdvi7qBziHb6gLH3Ncwz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXvaZhkUmXo8OFw+F6IULspWj2F+pYNDtu88IaKb3iX20Ll0i7oIG+sv+bDeb/8rC
	 eyJTqoAceTipjAhpZu0+tr9Ie4/afEU0Ef3xbZ4jwCcMk1nDi9exNR0fPiiGMl+eHg
	 Vi2mDRCEk5HpvEqyZRwRldHsoWtybrifWIIfKLffGEDjvJIK07rE45cTn+uCNp1VKR
	 dgYaaRhTCHxIPiIcxfgCXVesk2UavcOQ2AtVmGl+BI5fUIGcYFGNXL6lN7/cu3wcO7
	 g3xjSJvSm0LBKMhowxi06KP0jc+c2BYVRVtguXEPLlotgG7H+vM7IA+bF3T3TeNcV8
	 R/JBUzpaddcSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] net_shaper: add some notes on re-parenting
Date: Fri, 24 Jul 2026 14:07:56 -0700
Message-ID: <20260724210756.1553565-4-kuba@kernel.org>
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

Clarify the re-parenting expectations. Specifically that @delete
on a queue removes it from the hierarchy which is a bit unusual
in the overall API structure.

IIRC the implicit delete behavior was introduced because otherwise
it would not be possible to remove a queue from the hierarchy
without changing at least one handle of the shapers. Normally
"removal" is done by "adding" to the new parent, but "outside
the hierarchy" does not have a parent we can point at.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/net_shaper.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index c14eb87efe5e..05cb625b0fe5 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -107,7 +107,12 @@ struct net_shaper_ops {
 	 * The @leaves array's size is specified by @leaves_count.
 	 *
 	 * @node and @leaves may or may not already exist
-	 * (see the "Implicit creation" note).
+	 * (see the "Implicit creation" note). If @node already exists,
+	 * the @leaves should be *added* to its children. In this case,
+	 * the @leaves array only holds new/modified leaves, not the full list.
+	 *
+	 * Re-parenting @leaves is implemented by a @group call on a new parent.
+	 * There's no explicit call to remove the children from the old parent.
 	 */
 	int (*group)(struct net_shaper_binding *binding, int leaves_count,
 		     const struct net_shaper *leaves,
@@ -128,6 +133,13 @@ struct net_shaper_ops {
 	 *
 	 * Removes the shaper configuration as identified by the given @handle
 	 * on the device specified by @binding, restoring the default behavior.
+	 *
+	 * Note that a @delete call on a NET_SHAPER_SCOPE_QUEUE shaper also
+	 * implicitly removes the associated queue from the scheduling
+	 * hierarchy. The driver must take care of that step.
+	 * @delete calls on NET_SHAPER_SCOPE_NODE should not require any
+	 * implicit re-parenting in the driver as core will re-parent the leaves
+	 * first, before deleting the SCOPE_NODE shaper.
 	 */
 	int (*delete)(struct net_shaper_binding *binding,
 		      const struct net_shaper_handle *handle,
-- 
2.55.0

