Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658021;
	b=fiPGuto4O49G6H1SdHb67Q1uZoeLJvI1ySBKdaVc3sCdX2VpQqYp3DLE0FjxDiS8cBp8
	 9k1LXt+RDeBLFti+KJvhq3KeoDuFVZeMHsH9MLrlHucOGwG7apaTOtzjUodg8iiutPomc
	 J3nQ5HRf8RHtRLXU3k1ZwWxjhE5tlb2yiRUNy/c12Cc7Nx/A9jaMHJP5/IAd1X+FmuW8g
	 JfigMgOyA+/f3Mwsezv5rHv6ZSH8ds8jNG4XLP5mAw+CdDXyWRFX+IhbgOh6wZdA6VYqP
	 qzDeyjtVKHckdWszjIRgVSlxdBFukiJYsfDlOb3lkDYlgfvbSoD+in4phfxychU4L4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
	b=AzFfeiXxgnMZwjhtLqrJ92YFEinPOWyg4iFjvNFR19bxGaEwhLOeatE5EuGzi/e9bLFO
	 Tpc0DA0DRt0oS5qzKMU6LhtoICBV9SksZ/n/Qy7RrL/ZoE6owryB89TpjHNvN2yBypyeM
	 31IvtVC49eemcdilPc5oCPs07S0E0IZ2ky9RPZZgS+9va6yQH9dCMFaHjyV27GKJEWXJP
	 2Sj0ZTRts50b3aYKex4YvlphmpkYM5KzAaMjLJpyNNe/vl7BglS3b0BydyeLNEXE+c5rJ
	 4r/CyAQOT++Bsw/37v9oUNSXVICeH41+a+CwC4Ka/7ab+E6dCT0N9f21Xw4ZZwBJ3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJsgLaiy;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69542606D807
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69542606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJsgLaiy
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so2665864e0c.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658020; x=1794262820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=WJsgLaiyFWH3yZDo/24vhifFvQJoqbaSVBGEmcXUKvU8bJyPaXDbZv3KIRZGNZK5Va
         KOosJxWAmg4Ceu3szZ6RQxccpK82hsNpeEp3EcasFwF8zxHiMG49RKmLB1+9GlsENLzj
         ygSWBrcMuhZy2QqFjFywZk6AWG0ExFYROIJ+qTUtwpbmLrQjsuewnq9eBljKWf1v6FaU
         pWwP1H5wH1FmARwh/PXySglLBakJ/uVb4fdR0bDJpZRVmVahjZkA+eF8ds2SO6l5gO8j
         slxkq8RHQ+8pFR9J5lJVdiyycHZANNMZq/e0xTdi2vQZ32HeQr7IEN/a2I8xPEMYfJvP
         Qm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658020; x=1794262820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=10kTrBhngmtgUUOWqvUAr4pbC11iqDQ3FO7PjqeZ5XFY0zA1vlYopxdsRk2x8Cnjnx
         52wS/HvCVpgQTR00yaZf6cr+ANSWumleqR5mcGjHoMJ7ptmk8yO14jFgy3syH7qzeM3z
         CV2AXHkuqOwkvP4ZCUQ3g2uJLcpX8gHqawLm+Br8vrGoSxacquR/Ht0sacQSP+d7VRwO
         EPnTmPziw9wYPQ4q7MAB4c2oEGCg4XHyZWaMTfWDWztH++tAysZMvGAfGZERnczd+YIp
         4NGCdDAByn+a9bL1KI5IQq+aY95Zwl620JOku1KEmnLWIvDXLqPUwf3W+8AISeQQuVVZ
         0BJQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2I46DsM+AKoqmIZKYxdKDEQXZNp3dK1DE0FFMusqe+/lI7s/+1ClIjHTC5zZZKpEd60Kyepg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9841eAMukBY2Kmi79hG/yHv3qLDpzOh9az6Bt9t2DmdrOJQAsW
	neZrXBk8JF0gc2YesfNeEqHf7ttiHnKf0jaHq2r/BW2FVQOKkGKmGDSB
X-Gm-Gg: AYBFou0NjnxuwQdRLxBzKYS3Z3Z5jLYEv4VXZRcK2Fw4OJEh4jmiMHImuh4NK1/rbve
	v7ZZIIUsuChnDNbXjeq+eDPHocZkiJKjYE6GO71GCzMbzfmHBDKqjJOnmzxP3iGpYYlzWkQpCak
	S3BU5TX74Kf0DGVJ/PwX/mBjqt278+LcezepwvwqdDGMLe6g8XE7KB3sKgQf3utoiW6dicW53iN
	SkKVb2QN9NAlyX1EwcsTbfl7yCgZE4oUru7LBIfedO1x2sH7S0zmz3s7VA3zLc6dDJYYCm3fhZ2
	OoeKy8X1vKuJckqqrVKlGfnRUtGn4ygvWcxiJ9ExE/RnA/ldO1BEuFrE8jLhIYuWnjX1aJ/dAZR
	58WZrb7McLZeQUbVHdA3SSuTM1RHRva6hdgRPylEADf3JtxAHL1L/2hAm5HctLtJJJc2vRAli09
	agBPm9RHlUf7nz9DVyH1chtOhkFV+W8boNIUFLo5OF+yRWsnFQmrJvTtrsDWMf9rjg9xG9Xcohc
	UoVlHvaRG+PFbBDIG8YsdzV2N4yUbYZOHdg2U3eAyG3UDtbpbAA29o9YpCtbJKKy+9E2HRj/Vd+
	mfb/ZY84qEOnxTdlqTYVOScLLTFBuCJL/N/yG8ZAYvVzdwlwesz/QWahEU5Ii4lM1yQGZy+1Ms4
	IUhgWBKvcGIalj8qBW8lb2dUXc1LBOfw5zWxVh0At3aRIoz3BVnqK1vxd4PTE5BsSz2OKA2trfn
	n0eB4=
X-Received: by 2002:a05:6122:790:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5ec6851ce52mr5132479e0c.1.1793658020346;
        Mon, 02 Nov 2026 14:20:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm11306519e0c.15.2026.11.02.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:20:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-02
Date: Mon,  2 Nov 2026 17:20:18 -0500
Message-ID: <20261102222018.2610820-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:

  ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02

for you to fetch changes up to 60b10121db602a43ada3dbc39792bbf93d25991b:

  Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Initialize IRK before publication
 - hci_core: Initialize link key before publication
 - hci_core: Initialize LTK before publication
 - hci_core: Fix queuing rx_work while workqueue is drained
 - hci_core: Keep link-key filtering inside RCU
 - hci_core: Initialize advertising RPA work only once
 - hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
 - hci_sync: re-enable legacy advertising on resume
 - hci_sync: pause advertising for the scan address update
 - hci_sync: Update the CIS host feature when enabling LE
 - hci_sync: Copy the LE accept list under hdev->lock
 - hci_sync: Protect resolving-list lookups
 - hci_sync: Copy the resolving-list IRK under RCU
 - hci_event: Clear explicit connect state on LE connection
 - L2CAP: Hold incoming data until encryption key size is known
 - L2CAP: Ignore connection responses with wrong ident
 - SMP: Protect link keys during LTK derivation
 - SMP: Protect LTK encryption with RCU
 - MGMT: Return RFKILLED for Set Powered on a blocked controller
 - MGMT: Clear disabled connection parameters when loading none
 - MGMT: Fix discovery stuck after a failed Stop Discovery
 - validate retained LE Create CIS command length
 - validate retained LE Set CIG Parameters command length

Drivers:

 - btintel: fix buffer over-read in fw payload
 - btmtk: drop zero-length ISO packets from endpoint padding
 - btmtk: bound the ISO payload length by the controller's MTU
 - btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
 - btmtk: fix error handling in btmtk_usb_isointf_init()
 - qca: Fix the WCN3950 NVM baud rate offset

----------------------------------------------------------------
Akhil Arul (1):
      Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained

Binbin Deng (3):
      Bluetooth: hci_core: Initialize IRK before publication
      Bluetooth: hci_core: Initialize link key before publication
      Bluetooth: hci_core: Initialize LTK before publication

Catherine L (1):
      Bluetooth: btintel: fix buffer over-read in fw payload

Cen Zhang (7):
      Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
      Bluetooth: hci_sync: Protect resolving-list lookups
      Bluetooth: hci_core: Keep link-key filtering inside RCU
      Bluetooth: SMP: Protect link keys during LTK derivation
      Bluetooth: SMP: Protect LTK encryption with RCU
      Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
      Bluetooth: hci_core: Initialize advertising RPA work only once

Chris Lu (3):
      Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
      Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
      Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

Ismail Tarim (1):
      Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Kevin Dewald (3):
      Bluetooth: hci_event: Clear explicit connect state on LE connection
      Bluetooth: MGMT: Clear disabled connection parameters when loading none
      Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
      Bluetooth: hci_core: Convert hci_conn flags to a bitmap
      Bluetooth: L2CAP: Hold incoming data until encryption key size is known
      Bluetooth: hci_sync: Update the CIS host feature when enabling LE

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Tobias Wilken (1):
      Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Yifan Zhang (2):
      Bluetooth: validate retained LE Create CIS command length
      Bluetooth: validate retained LE Set CIG Parameters command length

 drivers/bluetooth/btintel.c      |  24 ++++-
 drivers/bluetooth/btmtk.c        |  49 +++++++--
 drivers/bluetooth/btqca.c        |   3 +-
 include/net/bluetooth/hci_core.h | 104 +++++++++---------
 net/bluetooth/hci_conn.c         |  92 ++++++++--------
 net/bluetooth/hci_core.c         |  54 +++++++---
 net/bluetooth/hci_event.c        | 212 +++++++++++++++++++++++--------------
 net/bluetooth/hci_sync.c         | 223 ++++++++++++++++++++++++++++++---------
 net/bluetooth/iso.c              |  20 ++--
 net/bluetooth/l2cap_core.c       |  26 +++--
 net/bluetooth/mgmt.c             |  51 ++++++---
 net/bluetooth/smp.c              |  53 ++++++----
 12 files changed, 609 insertions(+), 302 deletions(-)
