Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052694;
	b=fcyqOThqDsgOyJGSiBaFnaybqdKFZQKgfqDwZiDKP/bjMHHNT2zLPmRbroZb8ESElHq7
	 IKToOX64bUMPG2gf/74cKGPN1k/3JC2I6G1Wpqq/czLsoCTyQQkSPi7rKfu3+U4eqpkHu
	 EkEJgqWjhJ9cNGS1E0cW6pxNFXyM2vZrcfdhj+Hvy/grmkSH3q0Qr2SZl1qOKNvx8CKrX
	 kuVzNzx8HSKa3QTZH3iia6SqCP9i+8GgqBt/ISER80tWPh/hY6JykmQNYTg8kCo9ndXMT
	 32gEzjXa9jAI1rEFZUdGNWDKPW92hP7edGzBfEHhXCg2dgia4MBtlwHbDfXhR1WsKCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
	b=1GoJ3mNWPMaI33ePxXfdCmIpwjlyqz7vtAZGgpCP+GxtiCqg2iIqZGOrfqjH9lBPR2wM
	 AgoAITUmhkZeOCvub74BYgoMw3ElkSV0tJwB86L2kEx0UmRiD49ZG50T3Fux9Ekc3y/r/
	 PH0SwPvzz9knyCBOk/6G70Krh5kQC5cZosI2BriXEKoR+R+IuPeIdp/0qnWOa+625cyEk
	 nnKfUKI8vmjv09WejGdGhSTmIRW1N4gju9q1tbz1bmmlk4n9ow1cFWKWR5VKFQVvKTj5E
	 e1DSvTZJnv9oQaHsBuPLPYmOjeDoa0m80uK4x5BExS4b+5pZbvEBF3pz8LmP3pIvRoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jShPicuA;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669A606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A669A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jShPicuA
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so33814455e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793052692; x=1793657492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
        b=jShPicuAEHrkpvl28vBmXFaPHG4zMpZwB6uvHO8oy5BS/uTEy84mPFM8nGV0OnKk0R
         Oc7ITf/ojDJUjaCGz+DjnTUMH48wJqVbAU4L8r5EJGKYIKbc9p+j5k/oSCEXjjbnrcoy
         Cs7P+XApdaoteCpo6a+mZU04uzXuJmvJ61OfhP4yBPrS/GcsWi05k8sjsaAEV/v6WmnX
         zDUzeAM4Uui7tjtKh5QgIbr1LjOQDjp44svvKSFTzCz1L29c2AU08ETWWDpkoJGP1dmZ
         Q1ZHCAB9cdFV59oTdY+E+0GsM6nhfx18VjuGMln6hwnYC6DxD54wqiiraUJGNXKJZ7Sf
         erbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052692; x=1793657492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSlFXJXkUUOmnhxM2S/IZTz90QMtJhrhBFHA3HUgSEc=;
        b=SSa4cZpoXgAp2zdQqGLPtpmf+NM4llgDrMR9QttN5DFe2FlUpkFK6KUDrowCWPfOEg
         Gr443r4N4jx3fjqz0LsMXEqPr5bN9/LcHhgYbt66XqjeS7BZAIHvh/gK1uEqZgzsuRf6
         QsZuck3lz/ORn9Yiz5/HbSPTfqrCBGWvkZR+Wqn64Th/GbrFh6OcN9tK8v0w/qdC2bJq
         7L3nqf1KvY7XixW4NTqVHA2Zpc/Qasck8/idc8CCLlEpXxfzHmqfiT4HnTtSo8DgIZsb
         7YYFMR2KGBiBKOVOswzQuh34qyoJBhH20/7zWXfsjoh/TKgTFwldZNJXF3j/Lu6NKz1G
         UPlQ==
X-Gm-Message-State: AFq9FYIxQ/+9Jl3AzXs5gYuauFsw6EGV00xJn5blCZq7ZeKs+nBqGANb
	ToghxtWCYdbONlbRlcTmi3u7dFBgGWDvnkBFGnEnGw0437pZ8khb3hiKVYquVsla
X-Gm-Gg: AYBFou2r0iW78wbI8tB//+YPlnzUzN4701iIa6sJCHenc0UcI/vr2UUFvWXtozn896e
	6OUVesIkLZxX632oVNTJgje2H9E511uEQOmbT+MrbXNRK8p3hEjrStBr+xOWg7GJSQOSuaLnpP/
	wDJqxbuatQxr8s5uMg/9xN6nqLqKn4DdQAaG4U9FSLmtIHVe98RX2Mutn7fhQC8J/vk4r52kXd1
	JAb1HyTOGipetXW8ByOtpJuz+Msju6SG/G19pmowb0/zgTiBC0nqRq1IJ6+1Xnr061fXlfyQhLA
	b+98Y1T6UC5IgPbp6G2tdhcWCsJEafyOKinR2HuNCyAaPDVBePizr1SXP/EQG4vQOWQzHWop702
	X47b53INqSpihL4jaT8QJPnIjd53ELa5FgU8vSgCw5cXvGAo6g3hyTltJ0zdJNHOkaVMMNmeqXt
	Ew+lUaQFYCaT94IN087olKUgas8uW29x3iQQMWM9TimB1D1RteXj5QOQ2Fi2siFSnJiNojm4BaW
	sMZWbDyBuel3HqIJPqUcUbDeQ+bf9KzEbsJEPJF5zAn4ULSjs/VAr6BWBIriKh3skSwulIufscX
	NxxoMdYfnFwoh8e1oSp8ohoN0wDK3WWH
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a35acb5854mr138706065e9.28.1793052692005;
        Mon, 26 Oct 2026 15:11:32 -0700 (PDT)
Received: from pve.netbird.cloud (bzq-79-181-189-120.red.bezeqint.net. [79.181.189.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm210437945e9.6.2026.10.26.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:11:31 -0700 (PDT)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: netdev@vger.kernel.org
Cc: pavan.chebbi@broadcom.com,
	michael.chan@broadcom.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	stable@vger.kernel.org,
	"Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Subject: [PATCH net] tg3: Invert restart quirk logic to restrict SNP power-down bypass
Date: Tue, 27 Oct 2026 00:09:56 +0200
Message-Id: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
bypassed `tg3_power_down()` on system restarts to prevent reboot hangs and
NMIs on servers where NICs were initialized via SNP (such as Dell PowerEdge
R650 and R750).

However, skipping the power-down flow globally causes the ACPI _PTS method
to trigger fatal PCIe AER events and hangs on other models. Commit
e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot") attempted to
mitigate this by adding an AER-disable DMI quirk table. Maintaining a
growing list of models for a secondary symptom misses the root cause,
leaving systems like the PowerEdge T440 (sharing the BCM5720 NIC) exposed.

Fix this by inverting the quirk logic:
1. Restrict SNP power-down avoidance strictly to
   `tg3_restart_snp_quirk_table` for the specific systems requiring it
   (Dell PowerEdge R650 and R750).
2. Restore standard power-down behavior for all other systems, eliminating
   the separate AER-disable quirk table.

For systems affected by the original SNP restart issue, their shutdown flow
remains completely untouched.

Link: https://lore.kernel.org/netdev/20251221175050.14089-1-noam.d.eliyahu@gmail.com/T/#u
Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
Cc: stable@vger.kernel.org
Signed-off-by: Noam D. Eliyahu <noam.d.eliyahu@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 48 +++++++----------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ce108705bbaf..95827df4cf6a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18256,53 +18256,23 @@ static int tg3_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
 
-/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
- * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
- * be, powered down.
+/* Systems where powering down a tg3 device on restarts triggers
+ * NMIs and fatal hangs during reboot if the network adapters were
+ * initialized under SNP.
  */
-static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
-		},
-	},
+static const struct dmi_system_id tg3_restart_snp_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
-		},
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "datto"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SIRIS 5 1U Server"),
-		},
-	},
 	{}
 };
 
@@ -18320,14 +18290,18 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	if (system_state == SYSTEM_POWER_OFF)
+	if (!dmi_first_match(tg3_restart_snp_quirk_table) ||
+	    system_state == SYSTEM_POWER_OFF) {
 		tg3_power_down(tp);
-	else if (system_state == SYSTEM_RESTART &&
-		 dmi_first_match(tg3_restart_aer_quirk_table) &&
+	} else if (system_state == SYSTEM_RESTART &&
 		 pdev->current_state != PCI_D3cold &&
 		 pdev->current_state != PCI_UNKNOWN) {
 		/* Disable PCIe AER on the tg3 to avoid a fatal
 		 * error during this system restart.
+		 * Needed since on restarts for systems in
+		 * tg3_restart_snp_quirk_table skipping on powering down the
+		 * tg3 device causes a fatal AER error during ACPI _PTS
+		 * (Prepare To Sleep).
 		 */
 		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
 					   PCI_EXP_DEVCTL_CERE |
-- 
2.39.5

