Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE9280CD5
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332351; cv=none; b=c/m2BFsbrUFOh7NQF7/nO2Xysk2i0V2nYRj/cjkyPx2CTQwzYxJ7GBMz5kLZzyX7oZ39Sq26Qgm2NU8x2gfEexmIkOAsVvcd+UlqNYDCvyp2dcTbo+tE+Wx9o3Vq4gdQw/BCDKUEqrUDVK6tvoeOpoiplVF8fssQM3hZXeO9c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332351; c=relaxed/simple;
	bh=xTPqnZu8meQr9zKYn6kU+Sjy+hM+55XIhd9WW3MwX/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKd0nVzugIWYHA/D+uoJ+YhNhPC8ieK737PBztp58SA1ys8VsVouKhhIdqMCJSQv3JQDe9HCNoFreQT3HfD7qR1709VftMsgJKZOdeIaVjUbwrnONwq09XsOIfHEclzHclrFqvtTxhKq8VmEngCKq8pi95p35+VAHl3A2V3uxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw94bZRs; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw94bZRs"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a0fd41a7bso108163885a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789332349; x=1789937149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIBMkVsQnc+d88IgxQtwbE3hp2eO368yzTFTV3ZCKw0=;
        b=pw94bZRs7MrpTRj5z9x8HjDKgq3ot412SACs5tnRdfms+dzJxAnPWXzhyZhGHzdML7
         Qtd5q2dqE1V0Tt8EUFw/rvzxgUVL9Ch7jaPwcPV8LZmXWU8xyYzrcu8tTFCVOJMgHUyt
         aarW44CmHuQ744N3I4bzJTOHhdhN6oaG6dQwjHw8NVfQdLwEx/1e78jAVpwe1vcv1001
         LiGqwj2VJSloFLMuyx2qAWtYVDZiblgF7B+fXX15s41XYoSnNL2jMcP4zxXotcB2P9ov
         i7fn6i1QqUmWomPo8l/3UvQis1VlVUwZmGAZoN/lHklpzGVtum/4ugacnmDnY520R5oX
         0dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789332349; x=1789937149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIBMkVsQnc+d88IgxQtwbE3hp2eO368yzTFTV3ZCKw0=;
        b=cX2mbWKGn9BZIYXyQ7/oe6KqJwo7U7x1cVRpnRhkTAVtwsy4CNCxwZ3s3K/6WTzFRy
         a7mnVgVXwwAdMrca+R3+eSLTf8JpOFVMnE2zGs/eRy9B5NnoHmkMNjkcmbYl/QeKm3/z
         5HghlbnZuk8GeXmo1vtcCpdEeo9Ff8XBvev3XOBC+jhVAiVH8UdUEFsPzN8zzDKmtwsg
         /8gu2nzDOdcxd8LBD+KM7J/PGUUzs7JNp42XbcNVsSfQK9/MHJXcZvJInTIcKGz2Ci0M
         HIIbMDVgyTYYNzmn8DUM3KQLEt6uuCt0yxb0+p/r/IzdycFCE9JxmB5bkZYi/Vus0Bkf
         Y/sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDAFZd1QZg1TxbYNKGx7AYRmb/EKfLTC9Q5yhedvIhSSvglY1nrzwIYipN6Gj8rQf7qcxhxmA=@vger.kernel.org
X-Gm-Message-State: AFuF++mIJXnx5QHAMzde0yJi0ikGEyJ7LHO8xCvdIwe7DPfK0oCzR85p
	ADr9ipsJ6wxlxCBbrAeUrAXrb0w0hgYoLDBOiznIoct1wDntG/DW5BQ=
X-Gm-Gg: AYBFou2jUHD9jMTdbaAEjcSy7zpjLYM2yVa3R9B1mHcwGFkS6pDgdq4pM6yCoPoNfR6
	N+RStFOVBpiloR6o6NiX/2zfzZvEgORVCWinPKFrOTmmOKlq7hvNwRihRLPMZiZMsKIxROUK1wH
	ayb9chASMk4j3JAuaA1Cjf5sFLIu/0qCwqMwk/Jy5Of5h2dvtycZIhBknqYUdXVMDlvyUcXvTOQ
	aezp5d5BgrihGJ3B9bAC3igHKz9yFbjj/OiDrOj6d0YbvWn+uqubRGO9+KKVOz3fZz1Q/RCEZ3A
	GLXzhGBcWS1Ke8H8EG8U4pmRhmLuoFTLkXugV+6l6ubbi6tKIJ9SbePImcpPOiqY8QvCZmSSuxF
	Mu9hhRoek3/v/iTvSfKiuzDURAMmQ089ot8XnMqWU724j2a9XUsh1Hc84oBIZErvanr6L4iCxlx
	1weMWghw08s7mF5kDU8HO3xNgskBx73GmxtV7plHoFmQ9B43PllCeHj96DRO/JU/bJ+0ifY0BBg
	T3XJfhW28F0qHPz96cBDeOR0YVpH/tX2Q3hjWKlVNt9b0Bz8MmwHUhEGqWT09K7s/u8ZQC1QCjD
	5E4zJI+jSzOxpZ3Zb5M4n3li14alzm8jdA==
X-Received: by 2002:a05:620a:288a:b0:939:ede4:a499 with SMTP id af79cd13be357-93a035f328dmr1218686885a.5.1789332349032;
        Sun, 13 Sep 2026 13:45:49 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f19291sm837711585a.10.2026.09.13.13.45.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 13:45:48 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: GR-Linux-NIC-Dev@marvell.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ae878000@gmail.com,
	horms@kernel.org
Subject: [PATCH net v2] net/qla3xxx: disable the PCI device on remove
Date: Sun, 13 Sep 2026 16:45:34 -0400
Message-ID: <20260913204534.53825-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ql3xxx_probe() enables the PCI device and balances that reference on
probe failure. However, ql3xxx_remove() releases the mappings and PCI
regions without disabling the device, leaving the enable reference
held after unbind.

Add pci_disable_device() at the end of ql3xxx_remove() to balance the
successful probe's pci_enable_device() call. Keep the existing manual
cleanup and probe error handling unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
v2:
  - Add pci_disable_device() to ql3xxx_remove() instead of converting
    to pcim_enable_device(), as suggested by Simon Horman.
v1: https://lore.kernel.org/netdev/20260911033219.34566-1-mhun512@gmail.com/

 drivers/net/ethernet/qlogic/qla3xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3916,6 +3916,7 @@ static void ql3xxx_remove(struct pci_dev *pdev)
 	iounmap(qdev->mem_map_registers);
 	pci_release_regions(pdev);
 	free_netdev(ndev);
+	pci_disable_device(pdev);
 }
 
 static struct pci_driver ql3xxx_driver = {
-- 
2.53.0
