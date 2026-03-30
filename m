Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97903624AD;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838717; cv=none; b=mJRwM8BknW0NKqM2Yi7V1lw6sp4iBaqAr5luf9uAiivqpLoY/l2DVk44piLAqdChM+4ogLB8kr6BhtkqeihPRENt2Y2YZSSQ1VJVS3CXxKxC4wcSeFA/WylR4oJXcww1WtKEIrz0BjeIoWqn2zdYmwXSOzwOne1bsxJp2JnDehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838717; c=relaxed/simple;
	bh=GaJWaVTbn/UL3B4IZ3JOup4VGmfvjwuuWoZ7Ej05S78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBcnni6rdQNOYMh0XAMz1/NYUr9Lt470JwkDcYOfKr5XQAkTHEMrgc3DPm49xngeEraRoL1XWEOXdgn3zr2yEEIznLJjnhRF0sLmrtdeMfk3UogWN3QdyMut90vgN5LDUx8/ctm/TCzGMR7z/riMOTPsXb3H7E9MawrGfW9wyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQGV700+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQGV700+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC36C2BCB3;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774838717;
	bh=GaJWaVTbn/UL3B4IZ3JOup4VGmfvjwuuWoZ7Ej05S78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hQGV700+6LhlKQwO/S8a9eBKtBSNfc3TP44zUTXLlIbneYF6O0aAdcRt7yYPp6hPX
	 xWAtcgByJEDOzAQQQxlt3sL5gIutmSgDpKfEKTupWOU2ZEjpxNbVaJUrDFWCw0ZZyU
	 iH/3ALKITj1l8Y8ytdXmLmIq7NF7JxvypW5r9zSFzGKD1fpxB24vGfEs9AfB8M46T/
	 GzIicKx5Q5zbGKwH9dK1V5QosJRKeC0m0LGSOctB1MV58fGbbzitjXRGuFgXygXG2U
	 qttNoQXrJlgCaEkFpM0ODpfp/RmtG7ObttGEijvY3HcPYLO2zjz+jujzXRJEVM9XRI
	 C5YtiJjbnAM+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AA7FF4935;
	Mon, 30 Mar 2026 02:45:17 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sun, 29 Mar 2026 19:45:18 -0700
Subject: [PATCH net-next v3 2/6] enic: add V2 SR-IOV VF device ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-enic-sriov-v2-prep-v3-2-19a477549ef6@cisco.com>
References: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
In-Reply-To: <20260329-enic-sriov-v2-prep-v3-0-19a477549ef6@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774838716; l=1690;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=1chUHjnI8ZuULFMfvuOuwWNT2kAEAJEGnPmXwEaCezM=;
 b=H+q9+OEhmhKeDoujMW8Bu9aj6WPZ0kaGAZzEO0JhldRqzOszBr1aLbQe2bAnRC9zEaG4FaRx/
 VTCnuDrEiFwCUl+UB3pi8wFddWL1qqW74DNtT7/uXZdL+5WnyGTy4QY
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Register the V2 VF PCI device ID (0x02b7) so the driver binds to V2
virtual functions created via sriov_configure. Update enic_is_sriov_vf()
to recognize V2 VFs alongside the existing V1 type.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e839081f9ee4..e16dfbcd2c22 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -66,12 +66,14 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET         0x0043  /* ethernet vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_DYN     0x0044  /* enet dynamic vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF      0x0071  /* enet SRIOV VF */
+#define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
 
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET) },
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_DYN) },
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_VF) },
+	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2) },
 	{ 0, }	/* end of table */
 };
 
@@ -307,7 +309,8 @@ int enic_sriov_enabled(struct enic *enic)
 
 static int enic_is_sriov_vf(struct enic *enic)
 {
-	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF;
+	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF ||
+	       enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
 }
 
 int enic_is_valid_vf(struct enic *enic, int vf)

-- 
2.43.0


