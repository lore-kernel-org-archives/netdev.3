Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02A1A9FAB
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794489; cv=pass; b=fLNVrjIAvOUN728kNROrn81avZWOEDoAXkDWHvI6D8pCXqVU1uvEkbz1ZAgelECcDJvVh1hoz2CTvYTg2LePr8gYQEympZmnUCTDBkKvYx36YIZ+QhHVIo//IkCLwvywlMO8FjRXn3NpM6rlUuqrVek1P9udfXxRNVb1rH5fbE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794489; c=relaxed/simple;
	bh=A2xURprXrDTZAn6XS+MHOj6/Hpbp1ApQ82zp+ucCGHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjhRbVNUoBi5trTU105AuUQidu7gFvsM5B9WGBv/Jd4aEcYydNISW2sD3zgmOp7lF5YB2FNBhHzyP9XquP8xZAIDU2YxmBargYS3K2PB+n41+h1TDuV8C4+jBGC6jN20cS+nmJfeM78z3exSqQkUEkFEcVGTnVpxYPgbcyOgGfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=YHwPwKV0; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="YHwPwKV0"
ARC-Seal: i=1; a=rsa-sha256; t=1777794475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dnywB0pA6frC8jUWP+hrlfgRypxqzGkLAqAgvOcw3oDRSIE6TNLsODcNiH0yU8y2VQhEgMBfjcsLsITU+k5wWkoD0RRSkqmUQlqWkS3kApLf3NCjsIhbrjzIgKX6xbkl+5glnW5JjlEurTMLGFO5p8Ur020Uekjp1ndzL6xMzCI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777794475; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hx7qMxYL+Xd1kXQCd6s0w4EU3m5LLo9zSu5dRqsus3E=; 
	b=iiq9X3KJS6bnFOWj6AUbteuadW4131vrGVf+43R+U5xXdXVK5sfDI+fgeDcfAbN/VucMGDtPQ5l/1XtUHB+xxwL49GdtXyGII9NUubzANW9R3YkSucMX7f1UKM0XrKZaCO8AbNELY2iW9rydPCrhT+V7cC9M73Re5W5kYe8ngkk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777794475;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hx7qMxYL+Xd1kXQCd6s0w4EU3m5LLo9zSu5dRqsus3E=;
	b=YHwPwKV0bDvPZo4BTeierLr0qXfA68g017ngYOJr5zgbui8kyWHey31MmW/3/dcc
	6AIpV2D6LqkeObo77OCYTKPpjVORI3au5uUx0rFiNAta84xW/YJaNOG9uNhLFC0/Ey8
	IWP77LYHqougDayjpH+cey9OHTvJpofv6wN6csLeMXs30EvJL6OvzFgUNV/T7YC+EXx
	HHNjWy8kEOQl6dq6wI5454OGB6DkzKDYV2C0Pbm+ORxofNQ1M8XUlXucMJGz/HIZkL7
	kqwpSAxde4hK4YImk2b6c/XAgKkvOa28onT8Cqfa02afv/9u62kbxQxcIIy5xAbqMKk
	aXrIodxwqw==
Received: by mx.zohomail.com with SMTPS id 1777794472651169.52494029814227;
	Sun, 3 May 2026 00:47:52 -0700 (PDT)
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
Subject: [PATCH v5 net-next 0/3] Implement PTP support in netdevsim
Date: Sun,  3 May 2026 09:47:44 +0200
Message-ID: <20260503074747.1321-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
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
  selftests:net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c      |  11 ++
 drivers/net/netdevsim/netdev.c       |  91 +++++++++++++
 drivers/net/netdevsim/netdevsim.h    |   1 +
 drivers/ptp/ptp_mock.c               |  26 ++--
 include/linux/ptp_mock.h             |   5 +
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/ptp.py   | 184 +++++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/ptp.py

-- 
2.53.0

