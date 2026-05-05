Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04861DED5B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945624; cv=none; b=h5dpKeBXVkTLpce5hMGokBOmh5xK/h3vMoSs+xz1jK0vepwRA7/n32rcbM61RlCRn4bruk4XUgRuym0xIcMlrAsGqbYNXdPIzMPuc0s9X+q1PxDXw1dvRnafiNo+WEyZYyM6qeTAoYZ0ggoH5kAGIVDnI9RCi6wha6aumIix8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945624; c=relaxed/simple;
	bh=xaD8YBLyzNsHJm9/b7lK3y9pjsbIP17mG8EUOH9QUJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTlnlwDVRnVXy0e0yYXNlQwbGMiXwDnepXIEC0vqVuDMyf6heCrPQzEPMjjaqkkvkoK/eYIlNSZgo1UVmsWPv927WyH80SExAIFUCCyOPpVC+/jRuXrdSo1Qf7bSP9asaEx+h6SEQV4k1yVVH0HbxQ0eBB6ICD8vp/V4LsA8Lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il85HRkE; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il85HRkE"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12c8ccc7755so6735808c88.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777945622; x=1778550422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1prNxGjvUSN5AMOPmrkHQUe6tyhve21JS0LFJgrx/Ek=;
        b=il85HRkEwD/oFc7eIJz3rKHamNOf9cyQ/MGNsCzRIQCtxhl8ZPXc0k0Jo1lha43n9E
         EnWhjMo95Y4O2bA3ZUDlgt0D8VegitR8787yPNEIP8vAlmWt938GyMkLSJJG0VgubBQj
         ilXRLi4W8555cbv3IPV3ZkVpoIuPEQeVcHeQewj4SfO/XBL1tYXZXPTiTrXwvPsirJtC
         UBQBgJWMSfMHsq8qrnsLSuWDvWkFWBvS/mjKwtssI5wJFq7mrqIs/ncYXtAvTox81cQe
         WmDQJVU+WAZ6cAeGc6EVQWTSykEpnolWoYyBNvfCDjzrH1CWvU9usdmlM8Yo783IZUE8
         pXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945622; x=1778550422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1prNxGjvUSN5AMOPmrkHQUe6tyhve21JS0LFJgrx/Ek=;
        b=sLT4beKmMu9NYYr+4YAVUk+aFr9tMwKGoJcdXWR2Pl5iy7HR6521LxhIf1roOu99EP
         txfcW4J9s/9nASnXisSPUu+MSl9TK+CnW94QS5EZJK2oReZTEV2TzFksw5vL4i12PKvq
         NPHfASU+udFLZL6QMEInxh2H5s3ozDV9deorf6BuUwR+4IXkKtxa8805rh3QB4Cw9obe
         jPssyC3iLRz+6OmCt3ArDOsrZ1ppNlrvuCmXjBxyF622tF+32oDlJCGSKpVN0MmKghk8
         7Ar6X5dpsX0cDkUFCI1CRYleF8SD/+hJmS26qp+/bk1epMV+Oc9QDgvBgZeqx83mnoSO
         jwSw==
X-Forwarded-Encrypted: i=1; AFNElJ+OGNex6cJDFPGAzHhhLhMYB+OFXZit8OeauECDVQFnviuQyMSNaWeIQcTUQVRgSQyfB0y3RnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVniKY2q/IJNKz+1TsDup03wnep/C4gjw094aw2v1DWUNBVjCO
	+lGUI+miH/+oMvLrnOWDDwa5x6jPElHWOjLqtMWSUpT9NkVHbgCbNpv4
X-Gm-Gg: AeBDietQYSEPDnG3AfCKNdDK+gbIzcZg1OA5nIaeaidNcIc8hIKbreo7y9Uzr7hfARo
	Q3qWVVEsLRcPUf9x0wczbugORIQ9nF/2au+FPd6okMSXZoUY2BvhOnfASIt0zwKUj/IW46jScQU
	ecI1ieymwDvJae09asHSFlWl/1Q2T8XebR7dmkUJQPGNbLg8pQBuQR0ImyJNPJdTNbQDMNIZPYb
	Vq5k8NS21ijmNHozEy95NtnhuMTbfCOALCYQEgBeAMZH4LxpgRcEj8tdtxHcCI4hhtKLO5MwmeR
	D4/6DqT4RFC3/j5Meom8XWHEkgj6nPbu8H/KbkAhw1mKhdWZAsYMv18hypcJj9KE4eGkRvoHcX2
	udlyUS9OrXqvcjgGDssOfT1/L6dRA44O0qH/YL/gt4xoz0ClPitsE0gmD0o/r+j3sQVbjP1lk4W
	s8+U7gb/bhwBSGL4zTZYDcuHXSBfGJT4mXE6gEOwPD+EQqwbxO23FGRrnuwmKjmt8QcjYAnzQ/W
	amVuviZQ8m3JWsCz7BidbBKoNtnLZJrN2FpL1afgWitJ9kLUoJ1ENWfo9YKByDojBrJu7foyTbr
	ZRomSGoNXWX/m6IH9mvdP1pf1x+8
X-Received: by 2002:a05:7022:6093:b0:119:e56c:18b1 with SMTP id a92af1059eb24-12dfd821b1bmr5903248c88.25.1777945621785;
        Mon, 04 May 2026 18:47:01 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm24874944eec.8.2026.05.04.18.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:47:01 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH net-next] net: usb: mcs7830: adjust incorrect comment implying a vulnerability
Date: Mon,  4 May 2026 18:46:30 -0700
Message-ID: <20260505014634.49100-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mcs7830 driver contains a comment indicating that mcs7830_get_regs
leaks uninitialized memory to user space on some devices. If true, this
would indicate a security vulnerability. However, I investigated the
issue and found that it is not true because ethtool_get_regs (in
net/ethtool/ioctl.c) uses vzalloc to allocate its buffer, which zeroes
the memory. Update the comment to explain this behavior.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/mcs7830.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index d6698f30218d..dfdc7bd74166 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -22,7 +22,8 @@
  * - implement get_eeprom/[set_eeprom]
  * - switch PHY on/off on ifup/ifdown (perhaps in usbnet.c, via MII)
  * - mcs7830_get_regs() handling is weird: for rev 2 we return 32 regs,
- *   can access only ~ 24, remaining user buffer is uninitialized garbage
+ *   can access only ~ 24; this is not a security vulnerability because
+ *   ethtool_get_regs allocates a zeroed buffer
  * - anything else?
  */
 
-- 
2.43.0

