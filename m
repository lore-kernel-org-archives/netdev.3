Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D83976BE
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233009; cv=none; b=lxzEOGMXacyvTDIFhOK6ljYwQEIZ+ku6nycbTouxp3tpAsMdGP59RmQRTWi5RcnsBo8HPVYMQVtC2QdvOz3sO9SqZt0WNLiCDoU9ENkjzVKKFVr/OkNDL1sgqmFkxKqoay9Po4M89K6Ggh/mSF9xsLn+eMBZvQcumKpF3HYlvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233009; c=relaxed/simple;
	bh=S2bSzsC+6DNmP9IeeRPhsgkZ6/wbPvV2aIyitKXZwUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8RVmFKePDVYjZKe4KqqrUrH08SaZfdskfTNejJ0dp5kQ6muK4mGpEhYEhSikhx1GVAhDvTUgWEeJ5pWw2ZRNAIRbwDhXDN9gmc0pqi4Qzi5L07eSG1wn740visVDdxi3i5h97rqv33SnOCLA6/xlJR6WhK8IP1NeB18SZkIc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JxTaGg/c; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JxTaGg/c"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1616053a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233007; x=1791837807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAUoc1AegHAUd9YwluHKd3zoCDjJ912NV7KKWDUbB5k=;
        b=MFUiTzuqqXYpLGsSPMlaHnJGDG9YdzYrW9gwbn/aWBKpDUmpeKfB/K7RiK67fy43Ic
         LxkX7IMZbOfGno15gK/uO6h3ryBslIgCedJwdID2XIMAh49XsFVQNIuFmCMfawDzBxfZ
         bHvA//8M76Y/szZgWyBc8Hgxm0BPkTkYWQ8BY4E2T4zr/cxj7hc+9ByhS4hhv44M375s
         Zd6HaNlOoiizjCgT7cyxYjYUYN87tlMWnFpyTrWWfTRZaAr02fjedapmxwD8EY/sdvk+
         tH3WmGhoCGEy85CgQTkVARQzNlh1D2rlcgCGOztrAxpxS+AvDLUKr1f4fGmHMCJVFV+u
         yY2Q==
X-Gm-Message-State: AFq9FYKxh5gGZrPioGiM0muBzleFp19GpZAtXPr30viZrL893Xdo2BId
	oVM0MRU8hwvc0EH91L7kMe5WMXTqku2noeuMRIHNnOW2moMtQTr+/aL1UESrwggqD488j82IKUR
	uQJadxjFquqbLnc6kbWqMR2DMxIOpKTU/EQqLLtg1btvWPiNADwBj0It2LmnnfVMBad8uuDRGbs
	zgyCbQNCYR6zo9C70dhaaTIcs7m39KTIxhr1/COWztSpXBgqQ3p/k8/5TqCuS0NNOSUnbGOHi4J
	C7gU6p3SUA=
X-Gm-Gg: AYBFou2Gbvj0o4rM6TYhZLPloXm5GLQvukqhRBcl6xLzeGirrlfeuk+F05A+5O6SlTA
	qwVAG3+EOJ70OFDMlwnuQYfTITjMzt7UY8x1atfciNB2Bossfa8iRcjJkHiLpcGbeBPF7ipg2V3
	OT7bWDs2nqqew0ESg3nP97LdV2wDxoh/pR7axYHgn4wVMdgc3S3Yx6EUSm+MKlkbZn3G1f7WTS7
	XGUuClx1GzkG2zyzGbCqBoGxeWpEEHPIjdaz1KgqnJPkmoeLHtvjnmeZTVhoB8tNB8IZ7OYlgB1
	CkMtW7SRPqBYGxXYhHFdjMAR9Exiempjqj4JM67AN8fc8v73SJ5FRymNKv8AeiCnETYyAErbMx/
	0sliYh9+e/K16gUqhyupKT+D1G+cpF2+ilZHS9jWIKjYpCu07RQtqarHZExqzNNDpp56wpUHPya
	3tydCkbxX23sWJJ20PCTjRpANyvqe7TqTRIIBBSw==
X-Received: by 2002:a17:90b:5285:b0:3a8:211b:6c6f with SMTP id 98e67ed59e1d1-3a8211b748fmr2622241a91.67.1791233007393;
        Mon, 05 Oct 2026 13:43:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a8532a5b58sm334873a91.2.2026.10.05.13.43.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:43:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a438816dso59213466d6.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791233005; x=1791837805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAUoc1AegHAUd9YwluHKd3zoCDjJ912NV7KKWDUbB5k=;
        b=JxTaGg/ck6FgnzbHNrerfrqhyAoJZ4bZ7zNPm4N1cFC2AaXmAj1ZM8kkiNNBM8vFkb
         iTvOGsRgXvD/j2v+wP1AomIB89a2rIUf8YlPR3VMchOppV6/sziYvdfunqHIGByXYm9g
         m67OCGdD8yx9hPV8ZuVzTbNFKpRFa4CLcLVe0=
X-Received: by 2002:a05:6214:29cf:b0:917:aeec:a168 with SMTP id 6a1803df08f44-9195ce240f3mr163407686d6.2.1791233005488;
        Mon, 05 Oct 2026 13:43:25 -0700 (PDT)
X-Received: by 2002:a05:6214:29cf:b0:917:aeec:a168 with SMTP id 6a1803df08f44-9195ce240f3mr163407326d6.2.1791233005069;
        Mon, 05 Oct 2026 13:43:25 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593b457sm96914086d6.4.2026.10.05.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v3 2/3] bnxt_en: Fix driver init in kdump kernel
Date: Mon,  5 Oct 2026 13:42:45 -0700
Message-ID: <20261005204246.3822563-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005204246.3822563-1-michael.chan@broadcom.com>
References: <20261005204246.3822563-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Fix and strengthen the FLR sequence when initializing in the kdump
kernel.  If the NIC is behind a PCIe switch in synthetic (smart)
mode, the switch may need to see that the BARs have been initialized
before it will pass mem read/write TLPs to the NIC.

On a Dell system with a PEX89144 PCIe switch, echo c > /proc/sysrq-trigger
will trigger fatal AER without this patch:

bnxt_en 0000:67:00.0: enabling device (0000 -> 0002)
[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 5
[Hardware Error]: event severity: recoverable
[Hardware Error]:  Error 0, type: fatal
[Hardware Error]:   section_type: PCIe error
[Hardware Error]:   port_type: 5, upstream switch port
...

Add a new bnxt_kdump_reset() to do the expanded FLR sequence in the
kdump kernel.  We now disable bus master and memory, save the PCI
state, do the FLR, clear the BARs, and restore the PCI state.  The
BARs have to be cleared to ensure that they get re-initialized and
visible to the PCIe switch.

Since it is the kdump kernel, we make every effort to continue in
the best possible way even if pci_save_state() or pcie_flr() returns
error.  After FLR, we poll for an additional 5 seconds before
aborting in case the device is not properly returning CRS.  This is
similar to the 5-second wait in bnxt_io_slot_reset().

Fixes: 8743db4a9acf ("bnxt_en: Issue PCIe FLR in kdump kernel to cleanup pending DMAs.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Poll for 5 seconds after FLR and abort if config space is not responding.

v2:
Disable device before pci_save_state() and pcie_flr() and check for
errors. 

https://lore.kernel.org/netdev/20260928041712.3467803-9-michael.chan@broadcom.com/

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 45 ++++++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ce8a82d3453..9ea7e172787e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17119,6 +17119,43 @@ static void bnxt_clear_bars(struct pci_dev *pdev)
 		pci_write_config_dword(pdev, off, 0);
 }
 
+/* Clear any pending DMA transactions from crash kernel while loading driver in
+ * capture kernel.
+ */
+static int bnxt_kdump_reset(struct pci_dev *pdev)
+{
+	int rc, i;
+	u16 cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (pci_save_state(pdev))
+		dev_warn(&pdev->dev, "Failed to save PCI state, PCI restore may be incomplete\n");
+
+	rc = pcie_flr(pdev);
+	if (rc)
+		dev_warn(&pdev->dev, "pcie_flr() failed (rc: %d), trying to continue\n",
+			 rc);
+
+	/* In case device is not returning CRS, wait 5 seconds longer */
+	for (i = 0; i < 50; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if (!PCI_POSSIBLE_ERROR(cmd))
+			break;
+		msleep(100);
+	}
+	if (PCI_POSSIBLE_ERROR(cmd)) {
+		dev_err(&pdev->dev, "PCI config space inaccessible after FLR, aborting\n");
+		return -ENODEV;
+	}
+
+	bnxt_clear_bars(pdev);
+	pci_restore_state(pdev);
+	return 0;
+}
+
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct bnxt_hw_resc *hw_resc;
@@ -17134,12 +17171,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 	}
 
-	/* Clear any pending DMA transactions from crash kernel
-	 * while loading driver in capture kernel.
-	 */
 	if (is_kdump_kernel()) {
-		pci_clear_master(pdev);
-		pcie_flr(pdev);
+		rc = bnxt_kdump_reset(pdev);
+		if (rc)
+			return rc;
 	}
 
 	max_irqs = bnxt_get_max_irq(pdev);
-- 
2.51.0

