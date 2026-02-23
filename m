Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A911A0BD0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837527; cv=none; b=anz9StxH97kgGVy+SL1UXo+NYRa4X+ZkXxWleuuuAt9wv2z6CtujuYI3WE6f0gp+7B89ddbOKRq1rzFPdIoPRXRnxtuHiQQJnpfTVhnVQ9kP5u+Vw4Y/fFcVC/oybs17jDQz4GOTewicWGwcqi94AmQ7nMgN+RsKvEBaPEONRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837527; c=relaxed/simple;
	bh=bIQj36vxHDVfijwClNAE/sNVlBQdCPUaF/ufxATNvoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7VrGkQNeYOmB6wcgFNsF1IhNliznMTSbTPPYfL7mne207fGdtNa7+PJauaLbPNpJh5pQD/L8m8NSM3z/eFCBNc6EkDOePKKWfreUuHwedXlbb7lbRsZCUZfGCGco6O+woaEqUXVNSpuDss7foM9H6kOzyCsCT41DKNbTOE6kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2Hx9Gepz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2Hx9Gepz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C1FBA3EE3;
	Mon, 23 Feb 2026 10:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771837523; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IqM24HUBx3cfLWsQpseWG4fOPvlVrmRI7X9pBQoZT0o=;
	b=2Hx9GepzOXyqwtle/vKjmOpammEIVtPkMFnokrCDdzVMut2oQk7NUn9jrqldSaSFXzPEgR
	TMx82gUh/ud4emfgRVo8KissRIrit0ZsIDk6cEVZwXgrywEfRMFPVJxxKU1+xfEJRJ2i6J
	01wSSRT9pBa6uEY9/2mGu12QXBSeaqxKW/eDVtRBWC79uyrxPNkStTxt3CKLREzLRynqkQ
	7QIF03wW6fvjy13z8tNRFGjzAHJINjzJ8tdyZDOGMJhJX0T3kavhfPVaxYUe8lzk0PqpYE
	FMnidEWx6tdnxXSJnPRka1YBi+tnOirNwp2M+2sV4rqTYxdJEIF2h7cvOEcfWw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 5/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Mon, 23 Feb 2026 10:04:12 +0100
Message-Id: <20260223090412.44070-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260223090412.44070-1-nb@tipi-net.de>
References: <20260223090412.44070-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable IEEE 802.3az Energy Efficient Ethernet on the Raspberry Pi 5's
RP1 southbridge by adding MACB_CAPS_EEE to its platform config.

The RP1 contains a Cadence GEM_GXL MAC (revision 0x00070109) paired
with a Broadcom BCM54213PE PHY, both of which support EEE at
1000BASE-T and 100BASE-TX.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 178c0ddc78cd..7377c0f0c040 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5536,7 +5536,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.39.5

