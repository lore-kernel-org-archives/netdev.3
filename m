Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1D3F12E2
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812486; cv=none; b=olP1vQXpZ6gMPlvUk2GC0YZLOYUJNQxYAssw3/Uq7nEXFchXtHsO9eyhEVhaNW1fy9URPiIHU6VCm7OOn1Vq8Qd+x+TrZaARSLaSMiLkl6eWGIGZIOozbILf7JCqz90UqRUUZNB/HUqbdmu1s0xJK3scTqbP8XMcAAdiFaaro98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812486; c=relaxed/simple;
	bh=SLfJF+f1phQyf5LKp3ecFcQcmYovSj6A5k7lfOkQV0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfBC6H3oHR4w6MNBD3nAdOuLjJtQDqfyAt2Fn5bQY9HG5rcVSr1JCC1TNEBvf06l0Utxr2e1QbNncPCCjbzSF+ciH5JViht+uXsvvNMRCaOKZkcv2t8FTlqjHFWtGIbgfa8PjCC3r/tKfSDAm2RlZe9eWkOAWIabCHdJGcynsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GO49zmrB; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GO49zmrB"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so3638539b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812479; x=1789417279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iMNzlSvlaMkiP/A6FBG1e+Aok0NB3tA8jnJAebpaqaw=;
        b=IpdkOZa0Q49214UECg+j4FkBRCbbNh9o72CjFvgBrb75+R+1gkb9VHKlma6PFUOX79
         ioZQU3svZgqSA7iZDJ0pajfILR2R1Cg69odUYgNj2ecwvE8jx42x4bkKDtzUcCQX3ISY
         tnUqO+YFC28NYmCxxyE1qo60g+Gxmw4CpEltMYUV4FjCMFvMCdXNzmG0E/0liEhegqHp
         9X9gfh0F5rh/50yV08QVpqxShYPJWkwMJc72zRHLFfgNc+16Q53s+4LHPdC8jWctyA8T
         AV0T24SVFmTbNHYms2LYLJDUtiDQpS4ApLpEedBnWLxnzVUdcWk11FbLgmJ7J0DDc6yh
         BMjQ==
X-Gm-Message-State: AFuF++kW91RBpsBrwruB8lpLbiiaBmWKXnSNMl6HqHFuobflTCDK9OC9
	HAsdRS5701NC/8DuLUOeRVIgLqPP1+GrfZEbe0DiQsv32zVnRSEd2Wy7rmLkvGoqlJCnP51buAE
	FAiQHLIJ8L3oBh4FcdbspcSIw/Grs8jr5lZyC2NMqsVrCPbVpB0pAy69IOxg+lIolsMu1mYeHcJ
	HviMGpNqH/HdqAWTvWiQWn2tQBd2lEogSzI0hVHiaaN4B50gF4SY7Chz5R3FO5KA/sdu2U32G/F
	9r5sZLEjDQ=
X-Gm-Gg: AYBFou3DuL5p0ZrM1or3THrNJ1b0RZ5KCaEz0MQU0iinHRyBS3r1peYlsOjUh3cWTsp
	4ThrBQAiPb3MXjJTC/O8455g7zL68lXYz+yRwguqGJYzGA3hcZeGMb+CAP8TDVEq2qNRDyAdZoY
	H7Fij9YV9+keuaWBzaVJxhGSJSEaK4WthrDRg9wlJA7kqQ7NKou4OMfjp3KZ9K4Ty0CYAnDM0ZG
	US0Hrby9Ue6QmjpQDVHV1qk/2C7KzPF/XCMg/Fg6hAgZJW0TWIJqKlid0ipsoGsMlivEU8/A80l
	kR16j1sAfLBcU335aVqHLKSgGnQkBSHZBb88jDfyZ8DduRwUvkdPml/XegL7HSJTUBLvup7/1hL
	uZ3PR6hqNimZwrQL8VR52cRXs6gTkz32KwWp1QLiXrwFHySwGXKGAJ4vnkvaoZ8bg0N85Ln7CXz
	H0Tk8CiHrUqBcpP2x2mhxIUcspcGL1lmlUe7CpjQ==
X-Received: by 2002:a05:6a00:4f8e:b0:84f:dd30:1890 with SMTP id d2e1a72fcca58-8616a4650cbmr32337270b3a.15.1788812478965;
        Mon, 07 Sep 2026 13:21:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8614e59f912sm3408671b3a.2.2026.09.07.13.21.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:21:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ef04756caso74152081cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788812477; x=1789417277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMNzlSvlaMkiP/A6FBG1e+Aok0NB3tA8jnJAebpaqaw=;
        b=GO49zmrBh1rPwPmT98bOao46u+UKCwiNpHqdcmYPhCOif6ADT8cVmNbUeZkkRS4lYJ
         IeUXNQpIXupb/RsH2eqv16XxijoOtQmyVZPM0yiGfGgeYGZthjc18sCI73z4QQWXGmCf
         HfsSOZvPaBDoIwKJ8+MOzthFTbR/XX1bHFn1c=
X-Received: by 2002:a05:622a:4a89:b0:52d:8743:bc83 with SMTP id d75a77b69052e-530549f8267mr27752961cf.34.1788812477582;
        Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4a89:b0:52d:8743:bc83 with SMTP id d75a77b69052e-530549f8267mr27752461cf.34.1788812477145;
        Mon, 07 Sep 2026 13:21:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541992e4sm94946891cf.21.2026.09.07.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:21:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Subject: [PATCH] PCI: Add ACS quirks for Broadcom BCM57412/57416 NICs
Date: Mon,  7 Sep 2026 13:20:20 -0700
Message-ID: <20260907202020.2525301-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>

The older Broadcom BCM57412/57416 NICs may be multi-function devices.
While they don't advertise ACS capabilities, peer-to-peer transactions
are not possible between the individual functions. So it is ok to treat
them as fully isolated.

Add ACS quirks for these 2 devices so the functions can be in
independent IOMMU groups and attached individually to userspace
applications using VFIO.

Signed-off-by: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..191dbe87a09b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5182,7 +5182,9 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
 	/* Broadcom multi-function device */
+	{ PCI_VENDOR_ID_BROADCOM, 0x16D6, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x16D7, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x16D8, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
-- 
2.51.0

