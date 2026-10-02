Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435024E01E9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957841; cv=none; b=MjGij5PdMfrKxfm1G+Py9pyRN63v0qGDSfhfqP3XgYWnl0KmbZH7eKlCNXGWG4lIgfl0/C5pFbRmmyY33DZLAQOg7YKVd0Y5n/Zeow2RiWMAmHBACjPwuwvhkwQcmTiYgos5PkmIjinXw+iIPt2UYr3kd7eLHGVN9iAGO8XCwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957841; c=relaxed/simple;
	bh=MyBN7nnBw3QNPXaan5Cq3lLqlU0H/yPFUpqJdz0cWdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdeHf/RgMeb3Kdkuvoo/qrtgg1fk+tGXNpVpqSDg+fmTpHP8kIbgZc3+dhVsduk4cKUCbjKjMHH5z00gzRGI9DSNt8aVjMZaHNpBMfmaVQAxPTqKzw1F0j0OLXqBMPbLzowpMfR/E2fB7/P2ogZX8GptBSAs3A8NQdck9ijDZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIZmf2lG; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIZmf2lG"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso12112570a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957838; x=1791562638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WnmIAjuSEnHEbu2FskxY54VtxWjUv46LMUAmUQRpBk=;
        b=PIZmf2lGRmxOScwuaRvB3PEAbt1nnUTKXz6leG3cIOT3b8NgPFUax4wk4Ihyjq5Qji
         NiIsv3GRkm3/XcvW925tPM4t7AJUwiXmazcFOv2uSul+L8JtLYg1OvK7V05TTat+QhZh
         mrS3GJuL9SnzopetrVT5LuwplO1TnH6d9jOi3erswD0RXB4CBj7eyaD/K8OZXR9sISNL
         5VzV9A2Yb7czt3bLMy4rmlKMoofR2TiCtcKLSxjLpm2FMPwPy8YoOjhED05G/mDJypP/
         rwm4b2nqJ9/Nauq0xwMSYyixXoDQmQMy+8FZqDjz4LZivpKGNlh8a5sTc8XSA7M3qkHY
         Ov6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957838; x=1791562638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WnmIAjuSEnHEbu2FskxY54VtxWjUv46LMUAmUQRpBk=;
        b=i+29cQFV2BTAL5HntroZGLMb/o70gReCjbD8VukmLG/uHPERkWa0Cy4PSJp+VH5c4V
         mEqGYeimLsLKsWVlBmiCVBq+8CmI/qewa4b5Y2ryaPcvE7FmZn4W9GruejtmREVv39UI
         64eUbz62c8GRH3qk7zv+McZhEc/W+qundZEyP+qmA8d2dy8atPPEcO+8dsbijg9J7FL4
         PbZsOYyU1Vqzg2P0N1+i06qMZm3Ha9i/XokWEJYmY/q2Dg/e9LW3ssOvz5gxYIcmaecY
         7v1tipxeTIVMiLnPDibI4+K8XVwrUzUjfN+cm0i4SFUB9p6kEH9B+FwZ7EUQm4ABLOzy
         bkGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlknAuSdDX9Nzk2PCokEcjQIv21am0GNHf80MyvV2FUb9SMNcYGvydOZQjNvOVxXy6rM6LKqk=@vger.kernel.org
X-Gm-Message-State: AFuF++kmIW3g1aWntUPg8LFfwtoiCOxlHGuSME1zspPkBEts3i5RU5io
	SMjinqGhzBv7MyaaXXc8UYOP1BYpJXhlyTuuF7oKkgN3sVZnOBbGo6tL
X-Gm-Gg: AYBFou0TmnKz9j81WgtE0/zNV4GWHHSHRqNFi3It/epJ2yUuZGiMFVqGZ5FXl9OpcQ6
	bz/DvWeMhikKV5HwIv/A0YFS9SasUzICOJM7CqcVejGfTYnaJnRfBLsmymVJ1mdB/gF0adFSMIr
	maGqxvNjnMhv34LTtShTYXTtBZfbjnPBKZTxNM+rnuz2tDaAK3qtXME+P1WUIgxcL/SwwfcwNWE
	kiQdmTHXIIHaLV0+Wf+rm/cSPhZu8J1fWrvu6ZuS1sdnR46nKVgjawjuk3aomF8hbgIITBXAKvH
	wLo2EaMdu4xKXupk9DN9e3cSeuXHL6c90QQNjD9Wm9IuPnh3lg6QPP3QMVePYP7hdGmd98SjBU+
	BrX/lo2PM/1PBmK2JBN4caYsFafk+C8YAZgYn6JyF3dr+9oyebHe4foCkdfBYirX0cw5DBE+0k5
	9fdbCIZQveKmxJkZ0hP9xYDfTarp3dSHGp5LvhtvlW2pv97fnsS2lioOVpm5vuNM4g0pY8X2Ehq
	FMCM35bZUFdeAX6yxRC0R0CHiGTcNpFQzM+/cg6W3No01f89DA=
X-Received: by 2002:a17:907:9693:b0:c29:3c97:c994 with SMTP id a640c23a62f3a-c2e4ae1e30emr252668166b.35.1790957838142;
        Fri, 02 Oct 2026 09:17:18 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:17:16 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6/7] tg3: normalize inherited M3000 register byte order
Date: Fri,  2 Oct 2026 18:14:28 +0200
Message-ID: <20261002161515.932316-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
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
-- 
2.43.0

