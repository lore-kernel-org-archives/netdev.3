Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C82EE262;
	Sun,  1 Mar 2026 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330744; cv=none; b=aaiCmZaeETZFS+V8vWLzubuaVfB97l2MTreXjs1PEuhBfrlr8LiIa8s65uTV1ySSVkbVx/QmZhA/xM3jYyfrd8HwA+esxo9Whs8z3RxPTrVM5KiGEKrVxoWo56FSw+czhhCl4vOWQTwbVXdIpQqzwzHtZ133434F5H3z8djG9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330744; c=relaxed/simple;
	bh=7AT2OuJbEYaeFOWUkritLUcUxbuaElGtSVRpK9XkyH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlLfLw6m71WFIQf1Y158g70vuQiHziVYpMiFi/DpdOtbenRwalTXcce7P7rg22THhd6XqBqOCl/0N0DDO+sj/J2+h6l6H/j9AycClswxWkke/fY6Z4rbpUgrnEgan7KSQPuyNlZ0q4yW+56JKWNqhU4+h0SIygrFmX0KafGDsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apQ7eytK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apQ7eytK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175ACC19424;
	Sun,  1 Mar 2026 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330744;
	bh=7AT2OuJbEYaeFOWUkritLUcUxbuaElGtSVRpK9XkyH0=;
	h=From:To:Cc:Subject:Date:From;
	b=apQ7eytKwnjDqu7nPPcbqMta4vQzSPuybbHWWBOJKLpkn8yhsff2e78UQBAW3eiv8
	 0hforTCOf8ldmj9f5Db2R8AXBO1fLLKeWGrLTT8pE0n+C44zE/LE8FqI+4esdnk8AH
	 Qqn3ZFfyBYMP114il6oh0J1P68tXhY1eX+FhfM8GsUBWNIxwlItBxVz+UUpe4KGi/H
	 ii/YQaQPWLGayqCDD3Pmeywbffk+M0pfPkWCq5EGhCKIsGahCONjuZRlhXOOrdf7Bx
	 Uk4gTCdoLho4TNbvzpR+7qoe+/26jiyy5uy1nKfIO8/ghN848DLL2/k0XuVmJViV2N
	 xAmA2vK8AS+vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: arcnet: com20020-pci: fix support for 2.5Mbit cards" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:42 -0500
Message-ID: <20260301020542.1734518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c7d9be66b71af490446127c6ffcb66d6bb71b8b9 Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 12 Feb 2026 20:55:09 -0800
Subject: [PATCH] net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
converted the com20020-pci driver to use a card info structure instead
of a single flag mask in driver_data. However, it failed to take into
account that in the original code, driver_data of 0 indicates a card
with no special flags, not a card that should not have any card info
structure. This introduced a null pointer dereference when cards with
no flags were probed.

Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
com20020pci_probe()") then papered over this issue by rejecting cards
with no driver_data instead of resolving the problem at its source.

Fix the original issue by introducing a new card info structure for
2.5Mbit cards that does not set any flags and using it if no
driver_data is present.

Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20260213045510.32368-1-enelsonmoore@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/arcnet/com20020-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 19e411b2e3a77..dbadda08dce23 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -115,6 +115,8 @@ static const struct attribute_group com20020_state_group = {
 	.attrs = com20020_state_attrs,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit;
+
 static void com20020pci_remove(struct pci_dev *pdev);
 
 static int com20020pci_probe(struct pci_dev *pdev,
@@ -140,7 +142,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
 	if (!ci)
-		return -EINVAL;
+		ci = &card_info_2p5mbit;
 
 	priv->ci = ci;
 	mm = &ci->misc_map;
@@ -347,6 +349,18 @@ static struct com20020_pci_card_info card_info_5mbit = {
 	.flags = ARC_IS_5MBIT,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit = {
+	.name = "ARC-PCI",
+	.devcount = 1,
+	.chan_map_tbl = {
+		{
+			.bar = 2,
+			.offset = 0x00,
+			.size = 0x08,
+		},
+	},
+};
+
 static struct com20020_pci_card_info card_info_sohard = {
 	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
-- 
2.51.0




