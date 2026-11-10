Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278598;
	b=nMM/kCEtsbiKafamuc55XUlMKVpYgHVkFT6y1BZPGs8VKzEaWYt+Ub+OA42dnmdeVpBD
	 9tnofA0Ff9/KuOPnHHh58k2x6pROWAhMMiZJ3OXHWV7IrUSoiM3F5G6hw6Lga+8ju4j8J
	 qK2pt81/QsQkwC/SjIFU+3bTnk9zggDG6P1nIlUIWEffLsx22Pw5vkMk1yFHj993AQ8ib
	 ub8GVU3E83veQ7iPd0dq7qfvE8fFeZ+VGvmYdpfUjZdvtwC43/zlTP2p+4Tfwf00aCeRB
	 l6VRtBQTDmTnKcyLTfL9Z2AmGvblcZ1+0F5vkGGz4s3Um17oYll/fJkGLMryCH+zK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
	b=McFyITvoCwyU2g+DPexnRCKPtkYX8ASDyxCh3T8i3PTSxpqGlwKidExXDkP1y1JJGH+d
	 H5ry5oX6iTGX313HcrhVG1tdn0uI1MG7K2UcckUZsz+Zo/AA3cFR+iaVGPL68DoTLWh99
	 MChq9WQN/vYuin2ptW186pYkcm+DjtTixRY0ZpKyI0CGDLI8Mj8i8Rg0j6SLy39ARMC+7
	 TgZFzI6dU80gb7PZr5lJWwm7SpMtD4+vXFeU6h7eanr19S/w5s9Sj8loII5E4osytiWNv
	 N1Xj/zIu0crhxWbPP1pg7wh9aaqDK6qmK4vV4Sc3ZE4JJ/7ogwEGXFeI05a+g2u4HgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBu9LWnL;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DD606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99DD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBu9LWnL
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so1103397e0c.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278596; x=1794883396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
        b=xBu9LWnLWf46ZCP0jEtKFb+vag8+4+ElYNpiqCWP9K4TXSd0Q+qLEU7P3j9k6huyiI
         UELrZLzvOPtxI/v6tG3UKpQzpsVD6aWGBENeo5R3BPxLjhv/7Ch8hdjnisN8vuh7u3fx
         bZ0NteATxmHWyhCc2008jryBqnHoCxEnXBhptlq/t0hAIRAWe+3Qn8Osam2MJR31Bd6C
         CsS8qtawC32yWLcayQh8E3/fYSG3pE50coT0iH6pH1+S2aqz2lWb8V/QJFAtFphHXh3D
         JTXlRJZRrMPIfnIL6ejiNXhhANTjjL9wvSq7UqgabpRggIAUTLWXzzkqSo/WbQWIzDRf
         laHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278596; x=1794883396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
        b=VOgz1DU5T35wcUBahbrOEfNaeQXbXb1zqWxjPPbLhMuazdfBIoRNIFz2NXyQctcKsM
         RaTDCZXZJcOmlJ3g7iI7NXjFNcQWOmmKMEgZnUX9QWvJtBGqyPpJaQAyvDvWoyRPPEgU
         o8VmJNHJjROq+GjzPpViMrZKarGqEl0pHJ73bDGJKI6m0NFZLu5CW92gPhM9ac6PY5HR
         hiRGAN/ZoRuuUXCnHelStq1LMpSgt58kGgVJcNXXkEhB2aqMD7HFLVLRXOyoM0DKSbqC
         a4zHfrLSA7xjvQUMZoG5uvKX9U4N4aPim/4Qy8Ozld+UJbUPOPEkKk9zNX6ZLFsAngXx
         N35g==
X-Forwarded-Encrypted: i=1; AL+hErEvWNY1w5ax1dacf8FKvRB1x+sxVVwDm4PCa3al4o8k1zvg14uRsGYEUGF3t+m3WbcuMR29puc=@vger.kernel.org
X-Gm-Message-State: APuU4Z++xWNQFRZh+Ujdz2fGZxbVBlF12gjSUFD4ysv3KBF9szZad2Kc
	HXWDrNf8a2Hm2KhBtV//wpLE5JTbZEDDE+38yYj/eSPQaL0wrzw5nvFYEULw7w==
X-Gm-Gg: AYBFou0JJJIyQ2wf0RpgjnNqCBfkbQPu7aEy6ClKuKEF3X8rJRNjBPKduAdsl7hdgXB
	kG2IrapdOYBVcs/Av0xaGZuM+CdqDJvVVvHhzn4EFzReUom0OQ3p8XJFHT4kkmgIEoCqH3k1V6W
	kGGc3jRd5KtWnugy+/u/eiAy+0H2pac3HMvBCJ+P/1Q6Rw12vd+ODc9gXS+H2FjBdXyFicra36T
	gKwqhCpr8sW1BuopNyNuz0sAUywgt/hcNRg6XciRRwg1LFITdW6OVzpl2MiKXZisDdXXHBzRaXD
	gVccKK8npka4UFjULBJSJf3iHuVTsCNQLpZ6Xrsk4l7ZdaxVzDv+r9FqoyQB/JaJRbjZpaFsy+k
	+0An/jhQ38hGeGjnA8WNC4ppbVMvAYt3Db1wfEY0zfOahanRay/7wK6s+UN1K23IKFMl5AYHIyT
	fUn6amZX+CQc3fzVBAcsFzCyRQCvUVnZOToMciwcxTCWa+uefyP8BryV/khgtn4Mnb9qnv3bhWu
	cXRwhbMJ2v6eX9R9nB8LvqdS772/3kJjuZ5O+PQBzNEu1iZIzimTxnULuw/MMfuxZa6N9uE94rh
	6qhz3dwox7Od5JFfNvo7Q/SqRa3xyQ82YjbXvM+WOwugPd07DBGVIF/StehEtG+aoHv1Q7QGISz
	MCXhUa1D+bsgJB6SI9KWcrKLP86lbNPq6/O9pCfn8t1KC9wdYUFR/Obj0npc6bRpc70kzyKQBlW
	NykWY=
X-Received: by 2002:a05:6122:d28:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ee0d1ccb43mr460169e0c.20.1794278596491;
        Mon, 09 Nov 2026 18:43:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58e5d1sm938947e0c.4.2026.11.09.18.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:43:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-09
Date: Mon,  9 Nov 2026 21:43:13 -0500
Message-ID: <20261110024313.2023223-1-luiz.dentz@gmail.com>
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

The following changes since commit 60b10121db602a43ada3dbc39792bbf93d25991b:

  Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-09

for you to fetch changes up to 1f2ac56137c51be0601e18a163d817e02a15913f:

  Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel (2026-11-09 17:04:21 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path
 - L2CAP: Only accept LE responses to outstanding requests
 - L2CAP: Clear request identifiers on incoming LE connections
 - L2CAP: Keep recvmsg from resuming a closed channel
 - Fix not updating of hdev->commands[] after reset
 - reject invalid LE supervision timeout relationships

Drivers:

 - btusb: fix use-after-free in force_poll_sync
 - hci_qca: fix use-after-free in ibs debugfs files
 - qca: Disable SoC debug logging for WCN3950

----------------------------------------------------------------
Kyle Pepper (1):
      Bluetooth: reject invalid LE supervision timeout relationships

Luiz Augusto von Dentz (1):
      Bluetooth: Fix not updating of hdev->commands[] after reset

Stanislavs Nilovs (1):
      Bluetooth: qca: Disable SoC debug logging for WCN3950

YuanZhe Liu (2):
      Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
      Bluetooth: btusb: fix use-after-free in force_poll_sync

Zhao Li (3):
      Bluetooth: L2CAP: Only accept LE responses to outstanding requests
      Bluetooth: L2CAP: Clear request identifiers on incoming LE connections
      Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel

Zijun Hu (1):
      Bluetooth: hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path

 drivers/bluetooth/btqca.c        |  1 +
 drivers/bluetooth/btusb_main.c   | 10 ++++-
 drivers/bluetooth/hci_qca.c      |  5 +++
 include/net/bluetooth/hci_core.h | 13 ++----
 include/net/bluetooth/l2cap.h    |  1 +
 net/bluetooth/hci_conn.c         | 18 ++++++---
 net/bluetooth/hci_event.c        |  4 +-
 net/bluetooth/l2cap_core.c       | 87 ++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c       |  3 +-
 9 files changed, 77 insertions(+), 65 deletions(-)
