Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213513B58A;
	Sun,  1 Mar 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329115; cv=none; b=adV9ugSMGrDlidjIIGM2i5Lc4qLzZL+NLbd6D7G41FKLzcW9Oohs0jCDCczwCTsaNqOTECXegy3wwZpTK90L5ViSggQs2BU+mZBP2jItpd0Rae7CMqoV8P8M7KbX4IwZqhZeWovAU38SUNIMaT3C5aLMYRcyqgd5ybC9DoGNXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329115; c=relaxed/simple;
	bh=AiC6q3F96abTYLeklV6SiLk8mbghy5VVOMdu9Lpy1U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qs0SAsx3GKQYcCtUplrow0j79v5iopLfgSq86CGf897z5p9s10L8PxbImBrV4pgK/td8yxWpFNyd73+mkBZuDtyJpeQVfh+s7AHdG0aY6mKNvu6wj544zQW0i7q51PaeJTGOKtFf/KjapgVczYVWraAdqTFNN66f+zydMtG+kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOx35ZsJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOx35ZsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C3C19421;
	Sun,  1 Mar 2026 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329115;
	bh=AiC6q3F96abTYLeklV6SiLk8mbghy5VVOMdu9Lpy1U4=;
	h=From:To:Cc:Subject:Date:From;
	b=oOx35ZsJHKprepxekIYK4QwXpDdaWIe9WSNylP6d2H7dEbE80mETJjIwh+OHHVAxb
	 wqdPy+3FA1S2zsZvjxe8vJArQWlVRELoTwixEDlydEd5k4gprW+guuM3k1X4psZIHP
	 LigIT3viDNsBEAHI4JlgOvKt4jUP0rAur2xNPh4OCrLDwNIjyhRPsX2C0/1ehaytoX
	 vDMnsYJYyfAAcy/dmDE/SHv4eZPMoWy3D8zoZuOl7re6VKS1Fu9XjZBhO3sPtBOQLk
	 XV3j9mv1v54ugcNhr5kEVE7ZxF8XC92w/Rlvk4OEw54K62UquAGy+pv+4aKdo70ln6
	 oKghrQxYp4REg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: marvell: skge: remove incorrect conflicting PCI ID" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:33 -0500
Message-ID: <20260301013833.1699089-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d01103fdcb871fd83fd06ef5803d576507c6a801 Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 23:17:14 -0800
Subject: [PATCH] net: ethernet: marvell: skge: remove incorrect conflicting
 PCI ID

The ID 1186:4302 is matched by both r8169 and skge. The same device ID
should not be in more than one driver, because in that case, which
driver is used is unpredictable. I downloaded the latest drivers for
all hardware revisions of the D-Link DGE-530T from D-Link's website,
and the only drivers which contain this ID are Realtek drivers.
Therefore, remove this device ID from skge.

In the kernel bug report which requested addition of this device ID,
someone created a patch to add the ID to skge. Then, it was pointed
out that this device is an "r8169 in disguise", and a patch was created
to add it to r8169. Somehow, both of these patches got merged. See the
link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=38862
Fixes: c074304c2bcf ("add pci-id for DGE-530T")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20260206071724.15268-1-enelsonmoore@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/marvell/skge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 05349a0b2db1c..cf4e26d337bb5 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -78,7 +78,6 @@ static const struct pci_device_id skge_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x4320) }, /* SK-98xx V2.0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },	  /* D-Link DGE-530T (rev.B) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4c00) },	  /* D-Link DGE-530T */
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4302) },	  /* D-Link DGE-530T Rev C1 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },	  /* Marvell Yukon 88E8001/8003/8010 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) },	  /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, 0x434E) }, 	  /* CNet PowerG-2000 */
-- 
2.51.0




