Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DB42048E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497101; cv=none; b=IHVBWhv57ACQiHgGFvFMb17WatYBgn282ZAzOUuX5TAoiOJewzy2pFyZyg21856a9b82mEkBRtLUIlHxozj8b3YWaaPhiTm/NFYXkyMLvZkCbPuJS7B1EzSmuJqVdHP7GWeTPqZ1b7UNuYfyVt/9okla/jlHt/iVfnoaCnAc84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497101; c=relaxed/simple;
	bh=3wpSjBY/I7g9gOZFmdzHZU8Of0zVvJGk1pU2XSV8U1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu9sgvZlPswpa36JgDbVgk8WfHob2HxjhecR7LL+uTsMGo00iYpw6ZGbBWxtqML+RZXVa7VTqWR2wg80GGTvTeZamP6lFThqfEaYyITPGt5anpj6CSqo1KLFOnr+qJ5me9a9seFjP8WcWfvvmwgJiuZR+qS0O8NrHRahC9FZupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjoretWQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjoretWQ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c315869241fso654705566b.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497098; x=1792101898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zO/pByUBdtqSocQGJbztOlhRBCY/I/SOyW+XAegmzr0=;
        b=pjoretWQ1lfnXtw77Mau64GEICTpwnZ/rDJd6NRMzJzTZ4fL/liIAlMxb7dIGXPOsG
         oA16EoVkCzwnK759EeAlEMsWcd+K0nb6NP8PmR2w7/w3tFQXnNvfRuwEkps6a5aBljR7
         vSxUa2zfJ/d89rfnJSzRn/N30FyKbAd4zFUBbmSu3VLcOiS5C1wyKAJqgFm0dvSeUFvS
         wdrwOiAzg9/h+W0WyFm9U+ycu4eRurVN3Tijcr6QF0HV1Ocv/giJvjT74tWuaLNiqwtL
         URkMY5zFG6zOkHt6s97OMhATBkc2j1JGsUz8A2e9Y1K5Sy7eCShXFN6zf2IPwElFsFOL
         je/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497098; x=1792101898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zO/pByUBdtqSocQGJbztOlhRBCY/I/SOyW+XAegmzr0=;
        b=SqpkZ3GIzlAwVuf/2vFzZoCOLJsmxbYd3PJuHXM+9Agn++PiNPW+jmZhBKdZlLM2H8
         bxXLkR5bBUqlV6PTzELcUBwXZa/lDTNM0FNTPtTNWSdFgtzMAMJIZVm14PLLtBgUsMY9
         ab/+sgGFDSrdBPoSiUXt9gaJdfi0MGhLv+nm+Q6g7uenHJwOajQR/vIw6ptr6+Aoe9Pj
         iGuCAZCPyMiVgQnMPhMwdugCpfQT3aGp+5pVaLVOUmZQzqRlHUVyKtxLBmNeeKqvgRkE
         ogR+sjjeVMfJa+QH0CAYhAgP9mVYKrZf+dbNEzU8UpSd4HDnVbqnFwz6mcyAxaGUrSA7
         TlLg==
X-Forwarded-Encrypted: i=1; AKwUvByp8skEQNIvKhc/UGv25w7X35sGos3h+AbaIoybL0nq9dI3msqsRdKavxjBMSFtH0ypA8MopeU=@vger.kernel.org
X-Gm-Message-State: AFuF++lLq53xg25YcV6MDwcAgX6m2YtpkcSncxod9ftm5Q0Y5olYRThk
	ZTkLLbgwR+uuZhvSfr7pwk2X/joG8gMDWvbdjLnX4PoiPiVP2MkfIQMY
X-Gm-Gg: AYBFou3auweFBGZTse1OVIL8RX8QWStcMeVRHrIh8/0nLgo83O4VHdOAYP0Fn/WHK4R
	Ono56g3UUQ8A6PN7Z7LxxduJa3NSRa/9Ie4LWdpX+QOM9NW9E4EdKpb6b6RUTuD1+8f1A/tXr79
	03pWGTXjtLuerVZepgx9dJ9zCOLq7IFUO3oRDOnm5oaZBCuOw5JnV2NDA94Sb5lIMYrZ1WrNtKy
	aP+MoO6Ujk7APR2W2PC7RbeVu5tfsNhjAzdhDRL4qW53MU6tVvFMxcPwm4V/abTJG10IEA2JV1s
	G6E6CnpcD069P7E/pAeaqrsgsQZsDsIzgfv093lKe1AzS3FHnP9oqOifsEcfCcuHryRuf3R+Bm8
	KeRFnkfTiSD3kOn+GnZmCjGqJATdYHrvYyEe/KM3LNXQocOdJQI0j+OFM70l48XPvWaKq9jZrfq
	ZC+FMsshDJJ/OHsTRNg6J4j3OlUqVLDZkcacSewMUERjXvNw7TirejW9ePN9KK3HcsdZOJ+dCru
	WvxrfRFR7a6KrDPTNH7nlyfvYSWkWDJXB95qBT2
X-Received: by 2002:a17:907:3f25:b0:c31:82aa:dd4c with SMTP id a640c23a62f3a-c31a9d15f06mr9124366b.24.1791497097994;
        Thu, 08 Oct 2026 15:04:57 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a74c48sm3718166b.43.2026.10.08.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:04:57 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH net-next] tg3: normalize inherited M3000 register byte order
Date: Fri,  9 Oct 2026 00:04:03 +0200
Message-ID: <20261008220433.965791-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

M3000 firmware can leave BCM5718 vendor registers byte-swapped while
standard PCI fields retain normal byte order. Match the Fujitsu 10cf:165a
subsystem, IKKAKU model and swapped revision/product signature before
restoring host control; reject failed PCI accesses or register readbacks.

Keep this in probe so failures can abort initialization; SPARC firmware
enumeration skips PCI_FIXUP_EARLY. Normal rebinds and other platforms
retain their existing path.

Use tg3.h's MISC_HOST_CTRL_BYTE_SWAP and TG3PCI_GEN2_PRODID_ASICREV;
the inherited state was observed on M3000 hardware.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
Previously posted as patch 6/7 of the M3000 series; resending separately
as requested by Jakub Kicinski. The diff is unchanged from that posting.
This patch has no code dependency on the M3000 platform patches.

Link: https://lore.kernel.org/sparclinux/20261002161515.932316-1-linmag7@gmail.com/

 drivers/net/ethernet/broadcom/tg3.c | 91 ++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..9335bcc0d8d3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -56,6 +56,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32.h>
 #include <linux/dmi.h>
+#include <linux/of.h>
 
 #include <net/checksum.h>
 #include <net/gso.h>
@@ -16248,6 +16249,83 @@ static bool tg3_10_100_only_device(struct tg3 *tp,
 	return false;
 }
 
+/* M3000 firmware can leave the on-board BCM5718 registers byte-swapped. */
+static bool tg3_is_m3000(struct pci_dev *pdev)
+{
+	struct device_node *root;
+	const char *model;
+	bool match;
+
+	if (pdev->vendor != PCI_VENDOR_ID_BROADCOM ||
+	    pdev->device != TG3PCI_DEVICE_TIGON3_5718 ||
+	    pdev->subsystem_vendor != 0x10cf ||
+	    pdev->subsystem_device != 0x165a)
+		return false;
+
+	root = of_find_node_by_path("/");
+	match = !of_property_read_string(root, "model", &model) &&
+		!strcmp(model, "IKKAKU");
+	of_node_put(root);
+	return match;
+}
+
+static int tg3_m3000_fw_byteorder(struct tg3 *tp, u32 *misc_ctrl_reg)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 prodid, expected_prodid, normalized, readback;
+	int reg, err;
+
+	if (!tg3_is_m3000(pdev) ||
+	    (swab32(*misc_ctrl_reg) >> 28) != ASIC_REV_USE_PROD_ID_REG ||
+	    !(swab32(*misc_ctrl_reg) & MISC_HOST_CTRL_BYTE_SWAP))
+		return 0;
+
+	/* Standard PCI fields are normal; verify the swapped vendor registers. */
+	reg = TG3PCI_GEN2_PRODID_ASICREV;
+	err = pci_read_config_dword(pdev, reg, &prodid);
+	if (err)
+		goto config_error;
+	expected_prodid = swab32(prodid);
+	if ((expected_prodid >> 12) != ASIC_REV_5717) {
+		dev_err(&pdev->dev, "M3000: unexpected swapped product ID %08x\n",
+			prodid);
+		return -ENODEV;
+	}
+
+	normalized = (swab32(*misc_ctrl_reg) & MISC_HOST_CTRL_CHIPREV) |
+		     tp->misc_host_ctrl;
+	reg = TG3PCI_MISC_HOST_CTRL;
+	err = pci_write_config_dword(pdev, reg, swab32(normalized));
+	if (err)
+		goto config_error;
+	err = pci_read_config_dword(pdev, reg, &readback);
+	if (err)
+		goto config_error;
+	if (readback != normalized) {
+		dev_err(&pdev->dev, "M3000: host-control readback mismatch %08x\n",
+			readback);
+		return -EIO;
+	}
+
+	reg = TG3PCI_GEN2_PRODID_ASICREV;
+	err = pci_read_config_dword(pdev, reg, &prodid);
+	if (err)
+		goto config_error;
+	if (prodid != expected_prodid) {
+		dev_err(&pdev->dev, "M3000: product-ID readback mismatch %08x\n",
+			prodid);
+		return -EIO;
+	}
+	*misc_ctrl_reg = readback;
+	dev_info(&pdev->dev, "M3000: normalized firmware register byte order\n");
+	return 0;
+
+config_error:
+	dev_err(&pdev->dev, "M3000: PCI config access at %#x failed (%d)\n",
+		reg, err);
+	return pcibios_err_to_errno(err);
+}
+
 static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 {
 	u32 misc_ctrl_reg;
@@ -16272,8 +16350,17 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	 * sure that indirect register accesses are enabled before
 	 * the first operation.
 	 */
-	pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
-			      &misc_ctrl_reg);
+	err = pci_read_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,
+				    &misc_ctrl_reg);
+	if (err && tg3_is_m3000(tp->pdev)) {
+		dev_err(&tp->pdev->dev, "PCI host-control read failed (%d)\n",
+			err);
+		return pcibios_err_to_errno(err);
+	}
+	err = tg3_m3000_fw_byteorder(tp, &misc_ctrl_reg);
+	if (err)
+		return err;
+
 	tp->misc_host_ctrl |= (misc_ctrl_reg &
 			       MISC_HOST_CTRL_CHIPREV);
 	pci_write_config_dword(tp->pdev, TG3PCI_MISC_HOST_CTRL,

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

