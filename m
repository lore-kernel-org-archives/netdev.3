Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2784175A9A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325225; cv=none; b=XgySJSVkFCvCy1AsQ/ygWqi/AqSKJ48YQE7eKB2q2CTIS3U96bR7PUT/zSavv+HoRAY6auV6wX9pC4rNW9ViUovhwS2RVKg+DgV5QgUt2x3npTQYkGTiO5YKtuzhif6lLCmjJCRLfRWGGLnV7LphFpx2h4du6133cra7itsJl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325225; c=relaxed/simple;
	bh=E4qfukHzSfC4cQ+cN8PXEJ4HHX6YwxMYViD4qrrUYT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMzeK+gosSWl4NCMfvAcUWqIU5WE293VetIUTszIHX11D7X2zrDVO8nwSgJ4tharZrcFa7cm7iBpQwKCxIgnllWUfpK9IC7K5JFPdgJPc3bPCDmmiqgpYv1KdwLSghLDCXID9fwyIKxfNRUXBGx+BhrHIsp9tUnm5Acs/sprkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtEuCKO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtEuCKO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F276B1F000E9;
	Wed, 24 Jun 2026 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325224;
	bh=3iuwuH12g8hq85AIV/aRBUBlA7FrLlqdK86rUlQ7QF4=;
	h=From:To:Cc:Subject:Date;
	b=CtEuCKO1jNVYnSKOyxZU42rayPM24g8HeBeJnVUD7nxPipINKcdkDEwPiqXFlN5Cu
	 awvWIqxh9cOW72PEQhLwWoAywWeIFVPU3LYmd5Q4YV/tmuBlUJvlXlc1IFzVRE5hSo
	 KKDgiyfdUn898JJu0gfgiSChtKHErQhIbgP89Xp/Pv5jHcjiCOttjHY6ngxf+nXYQm
	 MLanR+Gl9vUkkC3S2EDozaXBIBZ5qMQE2IrH4yBHshP8UTO9poUG2oYAzihl9ELltY
	 NYTwIIeFqSmKa4MSfticqcun4bzWpz23O1CE6h5ezAPNVwKS6Zq8wTcCY4Qljb5qkf
	 I98L7izEBxzMQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	sdf@fomichev.me,
	dongchenchen2@huawei.com,
	idosch@nvidia.com,
	n05ec@lzu.edu.cn,
	yuantan098@gmail.com,
	kuniyu@google.com,
	nb@tipi-net.de,
	aleksandr.loktionov@intel.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/4] net: avoid nested UP notifier events
Date: Wed, 24 Jun 2026 11:20:14 -0700
Message-ID: <20260624182018.2445732-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported that recent ethtool rework leads to deadlock
on stacked devices. VLANs create nested notifications, confusing
execution context. Bringing up dummy causes vlan to bring itself
up as well. Which in turn causes bond to ask for link state -
a call chain traveling in the opposite direction.

  bond    (3) bond_update_speed_duplex(vlan)
    |           ^                v
  vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
    |           ^                v
  dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()

We locked the instance lock of dummy at (1) and will will
try to lock it again at (5) - which of course deadlocks.

For non-nested notifications this is avoided because NETDEV_UP
is always run ops-locked (so that bond asks for link using the
netif_ API which assumes instance lock already held). The nesting,
however, makes this problematic, we cannot carry the state of
the whole chain back in the opposite direction.

AFAICT vlan is the only driver which causes such issues.
So let's try a localized fix of deferring vlan auto-open
to a workqueue.

Jakub Kicinski (4):
  net: turn the rx_mode work into a generic netdev_work facility
  net: add the driver-facing netdev_work scheduling API
  vlan: defer real device state propagation to netdev_work
  selftests: bonding: add a test for VLAN propagation over a bonded real
    device

 Documentation/networking/netdevices.rst       |   2 +
 net/core/Makefile                             |   2 +-
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 include/linux/netdevice.h                     |  21 +-
 net/8021q/vlan.h                              |  11 ++
 net/core/dev.h                                |  11 +-
 net/8021q/vlan.c                              |  76 +-------
 net/8021q/vlan_dev.c                          |  60 ++++++
 net/core/dev.c                                |   2 +
 net/core/dev_addr_lists.c                     |  77 +-------
 net/core/netdev_work.c                        | 162 ++++++++++++++++
 .../drivers/net/bonding/bond_vlan_real_dev.sh | 180 ++++++++++++++++++
 12 files changed, 457 insertions(+), 148 deletions(-)
 create mode 100644 net/core/netdev_work.c
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh

-- 
2.54.0

