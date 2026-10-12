Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664B4DA9C3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839291; cv=none; b=pmzsNtGMd9QVqUWtyZMJ0aqA0hdyuGCO08DDs+l2rHBAFYgaZ2qde/a9iv56xvgdDcskSCCqERYtG4hcCXsn1XU3Rvq7C2BN5R0s7Q2dKf5DqvtU57GeG1o+DM86uK+2yp1xsaDgA+W0i2BBD2vcH12zWjgQ+4DvKh2/GOQCHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839291; c=relaxed/simple;
	bh=jsl71V5FtC06/50t0daXqqjNV/VyEyXzqcTiVIacV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cH5wLmtlHFAB1H66SuhScclaT/cdVmxokG87l9Mcj+M2dgyPpIFeb8Yi6Br9tNzKgMsj3PCCl3PfmaEpSUsI1xMPrnlU+W0Mh/li6fyCnrzGG8VtL42oAodPE/m11fm6PZOpWWZWAII2my3KCxh1fRhtq2wOGQbvhnTe5u3irgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9j1vyDX; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9j1vyDX"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5d7daf06158so779143e0c.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791839288; x=1792444088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uap5kT9XS9XvCOY+jEh6of0VhCK5p2hjX0LTl9bySnk=;
        b=G9j1vyDXOEc4fLsnZ7c8uHPDNTk0igRuOWOel8qlsl4E8qvej4t9DpSKroMjgspDGc
         JDnjNWMh3KXZ+TUGw+VlYLUcBV+AqR+JsL/vDK83YQP5VDpVsBmlhsiuwUmkC9+UFiBi
         qV1NK94k/IYYn2BmdtISu4Glt/5ftws2ZsaDFnrKM4JO2PS61y3Va69+Puh87VpUyI40
         XNhm7UoJwWaeXINH3v1yinoi0M53iWNtvuzIO/4j8TqQEKIfwFvEF5BYopUE2D0gT2EN
         5Fdqs//LahvRinYwGTR6mQmtnUyIG1TC/jZ3dcwiDSTRy9dKw3TAmANyQQtzrx6Wm29B
         OE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839288; x=1792444088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uap5kT9XS9XvCOY+jEh6of0VhCK5p2hjX0LTl9bySnk=;
        b=dzhyX80+wUuzhW2hXXixE3uWdG9zbD5ggCt7TWTOKNjDW3gCpv97Gv4zCscOhomsNd
         FYstwulaS5bOHlRGoZrdTJx7dOxUCJOgHLAWmRSLO9FUi3hvDvWBGDj4msjlpLfWQBuS
         CdcPAJUcJWSpKFR+JjUUaSbrL/jm4UtUzzMYaG4nvLuTj1r7JEjykbvzEpb5sHpXNzjq
         SYxU90u1aEKgh/Agu93/Lp6bQ7SpIMuekx85Y4xoiFuo5fnVCiivB0+HTtUeu37QH5mj
         4Puoc1fIFPUqLydor+uafnu4yafwVIHzN5x9Khw/2smdNdzrZik2+Dyzh4xta893Kbl2
         4szw==
X-Forwarded-Encrypted: i=1; AKwUvBzFAp2J8DR3kfkH0WyeKxP7cL+P5BNIYV8R1MQmqsXHbqIC4B3QpY4Fcgou+YW7Ui89ffwwRJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlTVVubCQoLEb2K+TGVI3l3cQ7DQ4BHPBNyKCLUvqISj2jnQiV
	v2xnA1SAeZACpucYiDcQfPdvKC3eBZEmTUppGzASJ2qNUkGrIrmDtDoupikYKw==
X-Gm-Gg: AYBFou1MFumt7Cdoe818WH8w85VpndxLUdCQZN+HBhNjY2+jxsSfkpyM2vAi3O5kL76
	4JEGQ1VwgGibqrCf4H//k1jDGwY2Cb3cjkrKI8SO+c8hhYMC0Y5dO91N+GveF5EJeStyU4x/MaY
	UD1+V/GV86yKFOANN9Sq+fVN7LAzfk35VJOBCZisCPFWzrn8OU/x4OvVnqeCMEGp6ZGC0nH0LCH
	Q9cnNL1BTpjbEs9RvbgVJ2YoO2LSGsW/DYLBoEohqAPeL8pHgUXfvPh1HhsP3TI+dPJp3u93POi
	iFrMTxuNCeEH4uTQSGizGKO2YNCpsW96LvL74OlEDC+fr0FOePq/siioFT7QvFT7ju5j0fi3z1F
	aFoxDnCYArZaHaSiTrNuLoAd/GRcTPpXkTch/WHkvt9TdxzHlsbTnGOoCRzMH2g3XjxZqU3O7ix
	1OVyc+wx7h603FwkzTNqiVA/tsjT5puXI4S+ipM051p1mtElZJapdfFSXmlczPcLZzq7NQyY4G6
	K3rmCgZw3fD6jRYaPYPx54EOqwyS6g2XpuBp+M/i5kiukJSl+fV+C+hwY89NgMv
X-Received: by 2002:a05:6102:5114:b0:7a7:195a:1b29 with SMTP id ada2fe7eead31-7cb375057ebmr2406907137.35.1791839288359;
        Mon, 12 Oct 2026 14:08:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354016d6sm7389871137.8.2026.10.12.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:08:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-10-12
Date: Mon, 12 Oct 2026 17:07:58 -0400
Message-ID: <20261012210758.275556-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e32d80293a0e1a160d5e5101daa8c82148c07510:

  Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-10-12

for you to fetch changes up to 23ad91f6a21a830b67f5eee790caa0053bd6537d:

  Bluetooth: MSFT: Serialize handle map cleanup with event processing (2026-10-12 16:27:16 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Keep RCU protection through LTK filtering
 - hci_sync: Serialize devcoredump reset during device open
 - hci_sync: Protect IRK identity reads with RCU
 - hci_sync: fix mesh adv timeout units
 - hci_debugfs: Pin module for debugfs file operations
 - L2CAP: Hold the listener while notifying child teardown
 - ISO: Hold the listener during disconnect notification
 - MGMT: Reject quality report requests during unregister
 - MGMT: Fix advertising instances with Global Advertising
 - MGMT: Fix pending state of instances added without HCI traffic
 - MGMT: Fix leaking instance on Add Extended Advertising Parameters
 - MGMT: Allow connection rate request as peripheral
 - selftest: Pin module for selftest debugfs file operations
 - 6lowpan: Pin module for 6lowpan_control debugfs file
 - 6LoWPAN: Use RCU-safe device list removal
 - 6lowpan: Drain RCU readers on registration failure
 - msft: Lock failed probe cleanup against feature readers
 - MSFT: Serialize handle map cleanup with event processing
 - Add missing newline to bt_dev_{err,warn}_ratelimited()
 - Fix tracking of instances sharing handle 0x00

Drivers:

 - btintel: Zero version data before parsing TLVs
 - btmtk: fix skb double free on ISO padding failure
 - hci_vhci: Pin module for debugfs file operations

----------------------------------------------------------------
Bui Viet Dung (4):
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Cen Zhang (10):
      Bluetooth: 6LoWPAN: Use RCU-safe device list removal
      Bluetooth: hci_core: Keep RCU protection through LTK filtering
      Bluetooth: hci_sync: Serialize devcoredump reset during device open
      Bluetooth: ISO: Hold the listener during disconnect notification
      Bluetooth: MGMT: Reject quality report requests during unregister
      Bluetooth: msft: Lock failed probe cleanup against feature readers
      Bluetooth: 6lowpan: Drain RCU readers on registration failure
      Bluetooth: hci_sync: Protect IRK identity reads with RCU
      Bluetooth: L2CAP: Hold the listener while notifying child teardown
      Bluetooth: MSFT: Serialize handle map cleanup with event processing

Eric Dumazet (1):
      Bluetooth: btmtk: fix skb double free on ISO padding failure

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Kiran K (1):
      Bluetooth: btintel: Zero version data before parsing TLVs

Luiz Augusto von Dentz (5):
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
      Bluetooth: MGMT: Allow connection rate request as peripheral

Pauli Virtanen (1):
      Bluetooth: hci_sync: fix mesh adv timeout units

 drivers/bluetooth/btintel.c       |   1 +
 drivers/bluetooth/btmtk.c         |   8 +--
 drivers/bluetooth/hci_vhci.c      |   4 ++
 drivers/bluetooth/virtio_bt.c     |   4 +-
 include/net/bluetooth/bluetooth.h |   4 +-
 include/net/bluetooth/hci_sync.h  |   1 +
 net/bluetooth/6lowpan.c           |   4 +-
 net/bluetooth/hci_core.c          |   4 +-
 net/bluetooth/hci_debugfs.c       |   9 +++
 net/bluetooth/hci_event.c         |  58 ++++++++++++++----
 net/bluetooth/hci_sync.c          |  53 +++++++++++++++--
 net/bluetooth/iso.c               |   3 +
 net/bluetooth/l2cap_sock.c        |   6 ++
 net/bluetooth/mgmt.c              | 122 ++++++++++++++++++++++++++++++++------
 net/bluetooth/msft.c              |   6 ++
 net/bluetooth/selftest.c          |   1 +
 net/bluetooth/smp.c               |   1 +
 17 files changed, 241 insertions(+), 48 deletions(-)
