Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B014B04B7
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559851; cv=pass; b=gLXYQMWCNVJG4EB3Xbg3RnbMQQXeheT3cZmE+mi8+LSF/hLGjU5cJ+hAK50xjMfULkZgs7zx3Ooppz0bUSOXlkQjXuI5yQiKmdiewpbf2YfYl6l3qjo6QbmYCVTTgjK1dbdgijeliMUpWSrH2546ShmmmkeTShebNPXCX0tFfxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559851; c=relaxed/simple;
	bh=6OxGGo9rHtJUdtxDtXsF5BXnh0GOGtaHRjQHud8eF2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6HFWMhZpjujV0Uy432gpBebSLAtoXTpGg8sygTufk0Z5fTlhHt7osmZuQtmTN95Aq45D60oX7zLdTFfCExQc5NiSz8xGeo5Bk1uP/1EnkmvnKKcacf4bVcvissVl/sIGyvbuFgO4hNZjfQHl3IilTtj7Z+60GE+7qSw4B/g460=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=NcIF9Ti7; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="NcIF9Ti7"
ARC-Seal: i=1; a=rsa-sha256; t=1786559836; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z3OcAlT60Zi8khCSusUVeP5n+CcdZmMyVfUEBFCEvaQt8xVhE6oJcb6TY7B81lVrW9cRMAJ3LNJVe3kW3l163gq+zAoMwxgyxbl8Jw6I9xGVewa3/jHg3KqKWdE5q+tDpBUOeUV/nzOYL3F4qzZHC/6uxsKmue7MEo5DhsH/bc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786559836; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DbYXfr3RS7dAvaEKLcbAGsRp28n21BKalgtn8AghcbA=; 
	b=B8Kk712cZMSejvSONYhdj1f8OqoBSWL4oGFn6z6EsHqaIHBJrBy2cvynrT2H3p4reiMRTiDrTKT8oYN3kLvGRCVfXOy6yDxJeMimyzfZE9gdGslOcoy089PwXDm/zFvKE8kShg5ABl/IItM65nuj6N8JKSTq/gVyRkXt4TPbAfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786559836;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DbYXfr3RS7dAvaEKLcbAGsRp28n21BKalgtn8AghcbA=;
	b=NcIF9Ti7iDXfH9DwZCigVpty91c8pejbOAkC9S3P7tufrW0jCK4reASBsmFWkfh0
	fFhK8nmSzCLWDzfK0Fbc1uwZ/8inaaHVXUXfOo+jY8w4/U+OgBviZVzgQW1b2O1BC+9
	TIAPzbPPYxSKBnrXSCvgFDqLN9lR6P0MSHV7BbsdLHMESK2Lz4YYrF5RQms2KuosRn4
	BWaI4srkVUMls544iwoFH7ROR71lGu4fJp0fY+H9n1UaOuKZBOfkp5RztujpSgnKaW/
	8a9r0GoTkYL4qQIsgeJhzFcepWOFVetuZnsGH9Wl7NTuATY7x1fih8B9pgBKig07+gK
	WOWKiD8xdQ==
Received: by mx.zohomail.com with SMTPS id 1786559832300779.3296265120495;
	Wed, 12 Aug 2026 11:37:12 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v8 net-next 0/3] Implement PTP support in netdevsim
Date: Wed, 12 Aug 2026 20:37:05 +0200
Message-ID: <20260812183708.312412-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v8:
- Fix the lockless tstamp_config access in netdevsim with
- Clarify the TX/RX timestamp handling in netdevsim comments

v7:
- Moved the test script to tools/testing/selftest/drivers/net
- Optimized implementation to avoid potential edge cases reported

v6:
- Enable PTP Mock in the tools/testing/selftests/net/config

v5:
- Rebase

v4:
- Check if Rx timestamps are enabled before generating a timestamp
- Replace bash selftest script with a python one
- Optimized Tx timestamp generation

v3:
- Fixed shellcheck issues in the selftest/net/ptp.sh
- Added selftest/net/ptp.sh to the selftest/net/Makefile
- Modified ptp_mock to use spin_lock_irqsave

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests: drivers/net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c              |  11 ++
 drivers/net/netdevsim/netdev.c               | 107 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |   1 +
 drivers/ptp/ptp_mock.c                       |  26 +++--
 include/linux/ptp_mock.h                     |   5 +
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   |  82 ++++++++++++++
 8 files changed, 226 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

--
2.55.0

