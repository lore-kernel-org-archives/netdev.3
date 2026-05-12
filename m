Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240739A047;
	Tue, 12 May 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580255; cv=none; b=OEMYRcJmW0ypK0c8Em7F1SAefXUeA9ZtwvCzcmSjwsxbi0KRPEpYB+W1palRSGSUrZCC38NXRbYfcrZ0hVnct13Vy7yQ2v+XcZ3pt5Qu6GIMQs47W+zr7iHx4025ZZiqELM0re5LeKur552qiVrvVlyefLRlvRcW6aGrbzAGAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580255; c=relaxed/simple;
	bh=4T7sBzDVIK9OOISmVLAv6YbgORhLKZfrSlJGZE2S7lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=SXaK62hJHQGLgAjOsn2d6S5k+izMVRM2f8q7A83J4AxDo1NS3eRPekSj2/6nyD3jwObO2G6hR0b+KxnvD3EM1W+JbQFrHrnOOl660IddHkOmKEM2whg99l2NSKE37C83O4b3j8P0mOq+LjmT88UsZn8mMnAbaLl7YVbZ+mXsd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUZ+Q55N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUZ+Q55N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19734C2BCF6;
	Tue, 12 May 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778580255;
	bh=4T7sBzDVIK9OOISmVLAv6YbgORhLKZfrSlJGZE2S7lg=;
	h=From:Date:Subject:To:Reply-To:From;
	b=TUZ+Q55NdfOUKjlqXp/5QJE1PjIcN48PjgitbG2XKGVBYSQGIX804ASqEmSmFKCgF
	 XA4ZUiMGLaIrAbCdAeE3JUwyrd4XhzctB7RDXVipdsPrf1twziBDT+Hzqs/tihWpfz
	 UTLXZ7/OWXPXx/Fyov4BNAHVVIfu57ufUBxFaOFVv9OTiFpfvlAg5x7mxRBZHftfrN
	 gASV/GXvLLY2rga7cFuj0V7GjcQge0rzJmZVdt9oVAv0sJEe/3OApReHCSy4p5afuy
	 9Pxi6xA/8UoKNq5iPcG0w82pjYQvzkkCjK+keDW/lJmefLC36rYrA6TNMfoKXLNcGa
	 zTODueVA4TRWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B96CD4F21;
	Tue, 12 May 2026 10:04:15 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Tue, 12 May 2026 17:55:11 +0800
Subject: [PATCH] nfc: nxp-nci: Add ISO15693 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nfc-nxp-nci-add-iso15693-support-v1-1-3394e5b9dba9@amd.com>
X-B4-Tracking: v=1; b=H4sIAP74AmoC/x3NPQ7CMAxA4atUnrHUBNUFroIY8uOAFyeKAVWqe
 ncixm95bwfjLmxwm3bo/BWTqgPuNEF6BX0ySh4GP3uaF+dRS0LdGmoSDDmjWHULXc9on9ZqfyP
 FEiOtFNZLhpFpnYts/8X9cRw/CqmvuHIAAAA=
X-Change-ID: 20260512-nfc-nxp-nci-add-iso15693-support-6bfbb676a78d
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org, 
 carl.lee@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778579715; l=1156;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=kGkeRYAHg70oAWwZuY//sniWB2ZJGuNwncL9XW7pfMA=;
 b=CPTRDl+CdKUptz9w2XaHxxn82KTCf/Rpa8uVCdSG2GyjZdV42HXxjHh9dghUbuSNCFxb35baf
 iax1syxQuw4DN0wGir8gLb+1svpuiEzkEW5o02/DPepj2WAdHDJIZZI
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com

From: Carl Lee <carl.lee@amd.com>

NXP NCI controllers such as PN7150 support ISO15693 Type 5
tags, but the driver does not currently advertise this protocol.

Add NFC_PROTO_ISO15693_MASK so that ISO15693 tags can be
detected through the Linux NFC stack.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
This patch advertises ISO15693 Type 5 protocol support for
the nxp-nci driver so that Type 5 tags can be detected.

Tested with PN7150 controller.
---
 drivers/nfc/nxp-nci/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
index 66b198663387..448e5a4e7338 100644
--- a/drivers/nfc/nxp-nci/core.c
+++ b/drivers/nfc/nxp-nci/core.c
@@ -25,6 +25,7 @@
 			       NFC_PROTO_FELICA_MASK | \
 			       NFC_PROTO_ISO14443_MASK | \
 			       NFC_PROTO_ISO14443_B_MASK | \
+			       NFC_PROTO_ISO15693_MASK | \
 			       NFC_PROTO_NFC_DEP_MASK)
 
 #define NXP_NCI_RF_PLL_UNLOCKED_NTF nci_opcode_pack(NCI_GID_RF_MGMT, 0x21)

---
base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
change-id: 20260512-nfc-nxp-nci-add-iso15693-support-6bfbb676a78d

Best regards,
-- 
Carl Lee <carl.lee@amd.com>


