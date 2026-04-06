Received: from ie.d.sender-sib.com (ie.d.sender-sib.com [77.32.148.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B1221F1F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461571; cv=none; b=p5XwFjn1Nx6TEeRRJxloBGFGjoR40oW5Twpj7z2RRfqUcCSnj+SDD+hrpuXaJ9jg2zP0d4ncCfafzs5yalRFTR0zpiEl4NUjlv4unuiu9PDyzC8DTqOigcPpZYtwAfHolgExzaJOs2B8n5PjPFXkqWaZyqxwiHmGMzWSz4jltCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461571; c=relaxed/simple;
	bh=N290AWiFEHAAiPU29ssnlMzp/XNYahkGwbt5U10QA/E=;
	h=To:Date:Subject:Message-Id:From:In-Reply-To:References:
	 Mime-Version:Cc; b=dinFonazGkKZ8z6U/CPeC17zOsFkwVjESxzIis6XEzJ02cIupWqCUxWyooRUBAUGOF8hHK+O7WEJdkEm4rg8cytwEE2qESdv8Bc0LZkqf1OMrqQ9qhhl9flbm12UvrBdTXClo6wBUEvq3KvLqvzuSrp3dtxLKYot94XOsyHTR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=ie.d.sender-sib.com; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=OZUzNLml; arc=none smtp.client-ip=77.32.148.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ie.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="OZUzNLml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c127.dev;
 q=dns/txt; s=mail; bh=9qBxcin593450fPqTE2zgVJwATrkI1D81Rr9zKWIaJY=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=OZUzNLmlGYy/FNpKNu7zYmKko8jet6ClU038LHXwq/5DIddKKJZQeBajO9BPKspKImnyKApFvnWd
        h8JDv3m4GoaMzduv5Sqbinqy7mBdgoAqA6uVimoS8LrPzYQnAhbR8VjPY/c3pFxrnjkXP3MyueRm
        a4dL9fX6NyptB41NISI=
X-CSA-Complaints: csa-complaints@eco.de
To: <me@ziyao.cc>,<davem@davemloft.net>,<kuba@kernel.org>,<pabeni@redhat.com>,<edumazet@google.com>
Date: Mon,  6 Apr 2026 07:44:25 +0000
Subject: [PATCH net] net: stmmac: dwmac-motorcomm: fix eFUSE MAC address read failure
X-sib-id: y5ksn4U2JckkeK36xJycl9yqU9pPGFvklHJERENhfYMQEZBKtRHCy0Dfp7VgX2ZrFNiyv1zfOHnfVUrbDgy0x_mPih0JdzLolOwKKj5xYlrUN_I68u1tGK2dvtk6urznkXCLR8QO-n2i7c9c_Qd5NER6-l2quzmYcT8n5imlRXG-JTkR
Message-Id: <fc5992a4-9532-49c3-8ec1-c2f8c5b84ca1@smtp-relay.sendinblue.com>
X-Mailin-EID: MjQyODY3MzE0fm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNDA2MDc0NDI1LjE1OTQ3LTEtY29udGFjdEBjMTI3LmRldj5%2BaWUuZC5zZW5kZXItc2liLmNvbQ%3D%3D
Origin-messageId: <20260406074425.15947-1-contact@c127.dev>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.57:6940426_-1:6940426:Sendinblue
From: "Johan Alvarado" <contact@c127.dev>
In-Reply-To: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.53.0
References: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <ggo@tuxedocomputers.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>


This patch fixes an issue where reading the MAC address from the eFUSE
fails due to a race condition.

The root cause was identified by comparing the driver's behavior with a
custom U-Boot port. In U-Boot, the MAC address was read successfully
every time because the driver was loaded later in the boot process, giving
the hardware ample time to initialize. In Linux, reading the eFUSE
immediately returns all zeros, resulting in a fallback to a random MAC addr=
ess.

Hardware cold-boot testing revealed that the eFUSE controller requires a
short settling time to load its internal data. Adding a 2000-5000us
delay after the reset ensures the hardware is fully ready, allowing the
native MAC address to be read consistently.

Fixes: 02ff155ea281 ("net: stmmac: Add glue driver for Motorcomm YT6801 eth=
ernet controller")
Reported-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Closes: https://lore.kernel.org/all/24cfefff-1233-4745-8c47-812b502d5d19@tu=
xedocomputers.com/
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
index 8b45b9cf7202..663d87ccfa0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -6,6 +6,7 @@
  */
=20
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -334,6 +335,13 @@ static int motorcomm_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
=20
 	motorcomm_reset(priv);
=20
+	/*
+	 * After system reset, the eFuse controller needs time to load
+	 * its internal data. Without this delay, eFuse reads return
+	 * all zeros, causing MAC address detection to fail.
+	 */
+	usleep_range(2000, 5000);
+
 	ret =3D motorcomm_efuse_read_mac(&pdev->dev, priv, res.mac);
 	if (ret =3D=3D -ENOENT) {
 		dev_warn(&pdev->dev, "eFuse contains no valid MAC address\n");
--=20
2.53.0



