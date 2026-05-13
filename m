Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453428C009;
	Wed, 13 May 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678952; cv=none; b=iK3sVVBjiMfiRs+cpwZFCvpMwOPJahqcrkg2PEHXtwSuO9mZv2V5H56KzdRflZfqeep0qOwM9m5qXQgyPXnwu74Y2w+c4xPFYbfPxa/m2DFRamWkC/P4OTYZUV9a9CM2DxcaK5qQtDl16c8/BdA8N9AagknJgDTX+eGmEPxpXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678952; c=relaxed/simple;
	bh=4zSEe7Ommd+yxNM4HOMR2HBXF1enjKOZNs8YC5obsxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqCIX+3bJsSc3VK5kJQYx6HYW0kIHMPqVZx2jd+kDRviUn5vkA4jhR6EOuFCpw7TPpXCFlzLHuH6l7Ft3Ets+ZLPrCNe3Pnj6KB786QaEFXONqTGnGEikpBRS2VRvbZekP6Gpdne9b63mzDhoPXQqnzX1cZAJ15b+20Jp5JR94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C226CC2BCB7;
	Wed, 13 May 2026 13:29:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [net] dibs: Improve DIBS prompts and help texts
Date: Wed, 13 May 2026 15:29:07 +0200
Message-ID: <1afbbbc74669f053414dcbabd909e52e7eae66e0.1778678915.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig prompts for the DIBS options read:

    DIBS support (DIBS) [N/m/y/?]
      intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]

Clarify the DIBS prompt by expanding the acronym.
Capitalize the first character of the DIBS_LO prompt, and always write
DIBS in full caps.
While at it, join the first two lines of the DIBS help text into a real
sentence.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dibs/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 5dc347b9b2350667..f2dd4c3e7c5f6d72 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -1,23 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0
 config DIBS
-	tristate "DIBS support"
+	tristate "Direct Internal Buffer Sharing support"
 	default n
 	help
-	  Direct Internal Buffer Sharing (DIBS)
-	  A communication method that uses common physical (internal) memory
-	  for synchronous direct access into a remote buffer.
+	  Direct Internal Buffer Sharing (DIBS) is a communication method that
+	  uses common physical (internal) memory for synchronous direct access
+	  into a remote buffer.
 
 	  Select this option to provide the abstraction layer between
-	  dibs devices and dibs clients like the SMC protocol.
-	  The module name is dibs.
+	  DIBS devices and DIBS clients like the SMC protocol.
+	  The module name is DIBS.
 
 config DIBS_LO
-	bool "intra-OS shortcut with dibs loopback"
+	bool "Intra-OS shortcut with DIBS loopback"
 	depends on DIBS
 	default n
 	help
-	  DIBS_LO enables the creation of an software-emulated dibs device
+	  DIBS_LO enables the creation of an software-emulated DIBS device
 	  named lo which can be used for transferring data when communication
 	  occurs within the same OS. This helps in convenient testing of
-	  dibs clients, since dibs loopback is independent of architecture or
+	  DIBS clients, since DIBS loopback is independent of architecture or
 	  hardware.
-- 
2.43.0

