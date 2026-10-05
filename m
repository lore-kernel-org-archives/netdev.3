Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206631F998
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229488; cv=none; b=pcdVZA2qJeu1CoazG42Vs+kCJACb4KMnGWWOxgPDyg2mMV4q0ZvL312T5oWeSQjVyK2ALnFH1+ZG6pLH+W24g3jwwHV+jns8S2H0wQtmnmeIZgaxz5ctUkuA0E5A5WOp/0o1IzZ/LS0WY5djEO6lnubLHtaZnZcbJK13aXZfAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229488; c=relaxed/simple;
	bh=RAcmLIZbF74IDHmOv+Wo6nZ4HbhoJhQu1vSsH1jTlxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACNNiPFBo332SjQVL0T3pEkqjjy5e6d4s2Gd5BxzKNfqFPOuY9gfOGgcJP0q/dk/kG/CVd000Onn0DsUGuDnq850dAC1Keq/+YfMHgJ3C+eSlW+lRkOtJvO4UMHNmPiaLv17JnASyY4XLzkdIxLTLVgVz4pPHxbqG0Ue+zouThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrUTsTVN; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrUTsTVN"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5d082395235so23515e0c.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791229486; x=1791834286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KtUYzFwhZtwaQXN14llld4yjEEP+XGlokPKTsSdPx0=;
        b=jrUTsTVNpapk88JgRQ41x7XVS448PS6WMa60KRuIRripQpe29KydzBaLhGBkPV5TxF
         30BYyBN/XJQmw+gMgmo8nE/DWUJzawopAcb0Lzjj1Ekbp9l0rT8H986IS6grsAgo9/7i
         xlmFlMdvBT8dp4aWxfGtE/w+8ZqYcaRUD509RFVxhzKGy3J1OVlV6+QLPzEdwIq14Xpz
         oKodBWg7n62hC91YMBJWEE1fdwZ5DasQkPubegT8gjpq5YhvvWEVI5BrCpchlLQ6E5Ny
         o6Fzibbecc4QRJO9SXbO2zDV7S077STlv1bsQa9ogIlPZoNZttbWbrIxCAcVFKDBKpyy
         ArYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791229486; x=1791834286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KtUYzFwhZtwaQXN14llld4yjEEP+XGlokPKTsSdPx0=;
        b=FgsiASyxGzU5L7TiIlie+6oz/e40hA9IY26N82gKomQOvsXO7lofqAGgfJER5ukkiQ
         k/TO0Bi7fy6Knb+mdXhyJLFkm+Jv8afy6ZE/ipsLyjbaeDTOCJYFOVMG9sPT8v/CY3LC
         yCwuwHpPQFN5NhnxNCjUGOqqjszrBSJ1OjhF4yQFxD5WE+0GvAKMMEWptcUliTXEKHN/
         3Yqus29RbemLuFUa88fJsKM7/N0CMO3QJGBsIg66I5wZrDgFxz6r8d4iBihPiPuv48+J
         ZvvnjsfjoxL0ekTyaZpH38c++6WRYRopTgGM1zoyFHkyF3AIRcQ3QlIAoyu4V+O1BX/G
         hnkg==
X-Forwarded-Encrypted: i=1; AKwUvByTwhkGrIwyJZgmqTwvM2nL9w+VOggsaHQZ5F7E83aPgNdxyT5Zce3um3e5rY7IFZ/gXwXVOK8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUZxEVBVNqwiLM5z9f6rTcdr2BtyKBvUY8qE9izCfS4nPn0eMR
	NkyP9uVUa5E89J6xygfSM3rkDS7gNLBzTxul5HPfOb8IHK2HqHH7nJl3FJ6NLM7v
X-Gm-Gg: AYBFou3ypKSmP/xxG62FzIFcSxmZWoGy8DfZjiYovmgeayL/xttFb/2LS6uByeb1hJG
	sYeIDWzZqY6PPd9pXZFo7lODmQouF1utWhcm8GQUMUDWzXPEIjhqssnENN1hd6N7u4zOOwWEbTr
	ae1pW3TySnbzZWa+6+MmalRTvZxJz5KRELnooSiucfrl1pomNlWVbMoJ8Kgy7nesl1gDGZAi/0b
	1fP++N5zTloLOkERn/PSwSSs2m3X7TUFWJy5gc4HQAWcTcsr2CtZOJaGwOn1GS3onycH3gfETG7
	dsfc8iYpmUGvvcUs4H564kTT/HK2GY/qYPMG9won1q4n0geCQwY55STbGIMv9/inWE2gMtvGR7l
	qZZJbOuyc7eHcWVF7wjPSyrJddpd61Im+VvAB8Uo9/rb1DWKdn0COJjlQh31/NTC/2Dii58pe3x
	y60w+4Gy/64oBfUiu/SJ5h6Zji3IrmB56nSzvN0WCdkHxkxqjQ/37uzNc0vvQmEBZlGMU6g2STR
	+6CDIsedNpGIp9ywXpF96JSRrjjD9R922F5BVF5nsJrDj+rmYu9NM8BbLtG59SX
X-Received: by 2002:a05:6123:4211:10b0:5cd:a80c:102c with SMTP id 71dfb90a1353d-5e530df9933mr165974e0c.7.1791229485835;
        Mon, 05 Oct 2026 12:44:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54e8006d9sm412861e0c.4.2026.10.05.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:44:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-10-05
Date: Mon,  5 Oct 2026 15:44:36 -0400
Message-ID: <20261005194436.3594085-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 848a7a91c7f03675d3bd8db6f7721cbf9cb50e21:

  Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown (2026-09-28 11:00:20 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-10-05

for you to fetch changes up to e32d80293a0e1a160d5e5101daa8c82148c07510:

  Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10:47 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_sync: Fix command skb lifetime during scan setup
 - hci_sock: Serialize dead-device detachment
 - RFCOMM: free the skb when the DLC has no owner
 - RFCOMM: connect the session socket without rfcomm_mutex
 - RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown
 - SCO: serialise sco_conn lifetime against sco_recv_scodata()
 - ISO: Reject concurrent BIS listener setup
 - ISO: Serialize concurrent connect calls
 - MGMT: Fix status of pending commands flushed on power off

Driver:

 - btintel_pcie: fix TX descriptor bounds check
 - btintel_pcie: use managed IRQ teardown
 - btintel_pcie: Add shared HW reset for clean start

----------------------------------------------------------------
Aldo Ariel Panzardo (1):
      Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()

Chengfeng Ye (4):
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: hci_sync: Fix command skb lifetime during scan setup
      Bluetooth: ISO: Reject concurrent BIS listener setup
      Bluetooth: ISO: Serialize concurrent connect calls

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Mikhail Gavrilov (1):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex

Palla Raghunath (1):
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Ravindra (1):
      Bluetooth: btintel_pcie: fix TX descriptor bounds check

Runyu Xiao (1):
      Bluetooth: btintel_pcie: use managed IRQ teardown

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Add shared HW reset for clean start

 drivers/bluetooth/btintel_pcie.c |  17 ++++-
 include/net/bluetooth/rfcomm.h   |   1 +
 net/bluetooth/hci_core.c         |   4 ++
 net/bluetooth/hci_sock.c         |   2 +
 net/bluetooth/hci_sync.c         |  10 ++-
 net/bluetooth/iso.c              |  52 ++++++++++++---
 net/bluetooth/mgmt.c             |   2 +-
 net/bluetooth/rfcomm/core.c      | 134 +++++++++++++++++++++++++++------------
 net/bluetooth/rfcomm/sock.c      |   5 +-
 net/bluetooth/rfcomm/tty.c       |   2 +-
 net/bluetooth/sco.c              |  87 ++++++++++++++++++-------
 11 files changed, 238 insertions(+), 78 deletions(-)
