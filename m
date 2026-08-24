Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C337C118
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594809; cv=none; b=bWuyOmyJ9sxEkcihQlc7uS6vUWpimamDR+CEaICkNOGC8jtOmhX/7h2LIFJQ9ZyPVS99HP3HVbk8nG/KO40lddZ53OXy0/4Thu3V+aDDy2beo7XgCoz6RIjkWa+QzqqrminP5rqXlBCfoMAMZUJAkJc4hY1RtFvzxclR5fvJvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594809; c=relaxed/simple;
	bh=El6uhCbfAIyCFmVUCSbf6VYtuke7x6Eci5neK5eZnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfjYZmPp0M1ftdBP9qXtlB56yroyY5EjMXjeDBQro71njwl7cvbKo4lWZvdrLTvxjQjWi4WUZhfTWmk5C7yTM0heHGEtn1Yev4HTx1HPwpiU4Zwxf8qw+Iuak9Uz22hJe0bUn3ITZj+mPpjcpasgyh/oyxMFNwaez3jraJMuwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuzayVxv; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuzayVxv"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so183859e0c.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787594807; x=1788199607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s04gzc+LgdPNYBRS3T5gtZw38JIFIXNwORrO2Yf3TQo=;
        b=NuzayVxvNvUBPmetiiJcgbGzAI0L8JR9i0NGRs7tWmQm9/MlktBEyJ5B1VStON1EIQ
         EcVY3OYQR2Gt5+ATLfqRRgj3lu5tLTyb5fqY5tW2E29Ub7vtGp/UN6arTOvWBcT12CyQ
         VroPfJikJLXjogb5ubCQ9G7ZFzxm5qSwKShG19UiuBnHY0xBsY26+3+jv6WJol4pdHHh
         sj1c4lheNJQuTufQW44AirohKFhJ+Sud8FINcZP+X/+Jj+e7ioswbaheTCzdHz+FxUSO
         QE0XIFg4WGqvn52RoAjHg+dkbpNm0emfjWse8eoWENkwEYjx+myUPzOjnQnKCvXY8a8L
         cWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787594807; x=1788199607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s04gzc+LgdPNYBRS3T5gtZw38JIFIXNwORrO2Yf3TQo=;
        b=OLObO4lwFwPngu8YuHbobOuWU9AQSrNy86QckwU2k1to2Ps8km9QK5lsay7sHQm4f2
         ckU8jiu5fbb1c0WrnKYJumVRb2YZyomA2f8ysmOt9kTtL7pgoH9YB/wn02n7KghUxyxE
         AXjiC8keznfkx1a8Tv/XwnEkGNp6jb0CjvSb0b8s6KM9EDXpylJly571+pUq7g9NS8z2
         Fej06PinMn0F0KToZ0ErhcyVVylDzlgs70KwDftlInoP/cQdnMn+0iQIg0Zibevc1TRj
         ajmGvg/ZO6VUrTj1WkhO4ujKnY0Se5iI2+hCWZuZiSaSddmnLnq0ClR1t7bwqOwQjCEH
         VNTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTmUozGQ6D/QCypY/90Dy+T9QlPb4Q9VyOlnGTQPf1JFk65vHpu4529eJIJJSZl+klUSi6PBk=@vger.kernel.org
X-Gm-Message-State: AFuF++nordVpYOnlFhfAjqAAQVQum0RwTxloL2C+hlUQgae+F7rRKNfT
	TsRHFZ7uQ1t48PsIZlPa7mHPAt9NYpd3qUiWJYi281dz6FuRM03moNTK
X-Gm-Gg: AR+sD11ZrTk+vKGGdPrzsyVfurFvcp15CVMhHLcR7+FFp+mnzHn2aeQHdRGF70QIUt7
	vpFVnCfRpyyXHkHr5y8kY71sHV72uACNaL8y42wtDg4g8EE+FX8h0hyRKlFZsC97QkKFzU+b9MG
	lrSnL9iCpGV0yQjWwnSoXc53JbovCRFoVE2UY4Knkji2mOiSeKI7qyBxeLJxeYDbPeAm9wui2Af
	sJMS9P9FOKI5JhBiXTiqrGxtOE7xIBQfk7Rj3bLJLsCRBPG8WeoPwKgCqmezRRQqmKb0FtOwCh0
	qGSpa6ZtiTsLMxk3lpva2HwpaBReJX1w5nZjK73oeFSBoWYo6i0PNsJxT3qalrZXai7DgcqLTlT
	xtbzwt0qzldUBnDmJImLJELAaO1KHwmWuwepibvcMPGK+hk6XfQ+/5SuAlZU6RJ5WtqxcOc4/0W
	D/TUK+7cufpMOZycNGkS2ECZ0AHJKkX3gLJ2PiHQQpN3sM3QaX3ICvhvF8otvaEJlOtyWHXFm3/
	SWbMBpmABnfqCr7RqeSW7shJGxErIojlEEDL9BNpgd10Qn6cp+Gz90=
X-Received: by 2002:ac5:c9b3:0:b0:5c5:d799:5b87 with SMTP id 71dfb90a1353d-5c641a10e48mr228912e0c.6.1787594806770;
        Mon, 24 Aug 2026 11:06:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623eb64f8sm4337455e0c.12.2026.08.24.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:06:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-08-24
Date: Mon, 24 Aug 2026 14:06:39 -0400
Message-ID: <20260824180639.3570348-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 7cbfb180945ce529608e4d4e24a6d483699fab1e:

  net/sched: sch_cake: fix autorate reconfiguration throttling (2026-08-22 13:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-24

for you to fetch changes up to ebe6674292fda9a58e6f3adffd6d277560857169:

  Bluetooth: RFCOMM: serialize session teardown (2026-08-24 13:14:43 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: use skb_get() instead of skb_clone() for req_skb
 - hci_conn: re-enable advertising only for peripheral role
 - hci_event: clear HCI_LE_ADV only on a created connection
 - hci_sync: Clear HCI_CMD_PENDING when dropping the last request
 - hci_sync: add conditional locking annotations
 - hci_sync: do not leak an hci_conn when a second LE connect is rejected
 - eir: Fix OOB read in eir_get_service_data()
 - mgmt: fix 'hdev->discovery.uuids' NULL dereference
 - L2CAP: access chan->conn safely in get/setsockopt
 - L2CAP: reject accept queue add unless BT_LISTEN
 - L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
 - RFCOMM: serialize security confirmation handling
 - RFCOMM: serialize session teardown
 - RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop
 - ISO: fix use-after-free of listener socket in iso_conn_ready

Drivers:

 - btnxpuart: Validate the FW dump header length
 - btnxpuart: Check remote M.2 connector availability before pwrseq
 - btmtksdio: Take exclusive ownership of the SKB before TX
 - btmtksdio: Fix out-of-bounds DMA read in the TX path
 - hci_uart: Fix false success return in hci_uart_setup()
 - hci_bcm: fix usage_count leak when autosuspend_delay is negative
 - hci_h5: fix usage_count leak when autosuspend_delay is negative
 - hci_intel: fix usage_count leak when autosuspend_delay is negative
 - btmtk: Do not report success when subsys reset fails
 - btmtk: Do not discard the subsystem reset timeout
 - btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
 - hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

----------------------------------------------------------------
Ali Ahmet Memis (1):
      Bluetooth: btnxpuart: Validate the FW dump header length

Chengfeng Ye (2):
      Bluetooth: RFCOMM: serialize security confirmation handling
      Bluetooth: RFCOMM: serialize session teardown

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Guangshuo Li (3):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative

Hang Nan (1):
      Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

HyeongJun An (1):
      Bluetooth: eir: Fix OOB read in eir_get_service_data()

Hyunwoo Kim (1):
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ibrahim Abdelkader (1):
      Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request

Ismail Tarim (2):
      Bluetooth: btmtk: Do not report success when subsys reset fails
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Junjie Cao (1):
      Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728

Lorenzo Stoakes (ARM) (1):
      Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

Pauli Virtanen (4):
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
      Bluetooth: hci_sync: add conditional locking annotations

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Sherry Sun (1):
      Bluetooth: btnxpuart: Check remote M.2 connector availability before pwrseq

Valentin Kindschi (2):
      Bluetooth: hci_conn: re-enable advertising only for peripheral role
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Xin Chen (1):
      Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb

 drivers/bluetooth/btmtk.c        |  11 +++--
 drivers/bluetooth/btmtksdio.c    |  33 +++++++++----
 drivers/bluetooth/btnxpuart.c    |  39 +++++++++++++--
 drivers/bluetooth/btrtl.c        |  13 -----
 drivers/bluetooth/btusb.c        |   8 ++++
 drivers/bluetooth/hci_bcm.c      |   1 +
 drivers/bluetooth/hci_bcm4377.c  |   1 +
 drivers/bluetooth/hci_h5.c       |   4 +-
 drivers/bluetooth/hci_intel.c    |   1 +
 drivers/bluetooth/hci_ldisc.c    |   2 +-
 drivers/bluetooth/hci_serdev.c   |   2 +-
 include/net/bluetooth/hci_core.h |   2 +-
 include/net/bluetooth/l2cap.h    |   5 ++
 net/bluetooth/eir.c              |   3 +-
 net/bluetooth/hci_conn.c         |   3 +-
 net/bluetooth/hci_core.c         |   2 +-
 net/bluetooth/hci_event.c        |   7 +--
 net/bluetooth/hci_sync.c         |  16 ++++++-
 net/bluetooth/iso.c              |   8 ++++
 net/bluetooth/l2cap_sock.c       | 100 +++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c             |  18 +++++--
 net/bluetooth/rfcomm/core.c      |  14 +++++-
 22 files changed, 220 insertions(+), 73 deletions(-)
