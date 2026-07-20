Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B493ACA5A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571245; cv=pass; b=VUTJ83bQUXxZoyNgXPvbvH3zlaXrv3VjCotdR+zw3oCPAtzAdi5m29UtvwHE1Dgb/HeQZ+ilbDt0RKH4NOtWON/Kq1ZaQOD2X6js4ZnzG2BmPWe44lhkXkUJ34aICi55tvQ89o95qJo+EPtxKioZgZupmLppjkVkBmbU6xR8LtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571245; c=relaxed/simple;
	bh=5JxTcqn2qO/DXyBRggqSfAhcU4nbisngI/kkfC2K4eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lV0b1aZ21myYR1nUvM4B0clk7F8+ttzoO5pL1K3iU+n1uG/5FgKzUFy4Q4Ph8nJEfo0hkj6jJrV7alIS+DYWw8fdEwylsOOFYSvUd3cwJFNsM6whB0/sOPYT9oUE5KrYPHptNtM9SzrIu//75KhbTNx641CxLjBXEXxiXEiXsSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=UzOu/0FT; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="UzOu/0FT"
ARC-Seal: i=1; a=rsa-sha256; t=1784571231; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WonGgPqzxecgLt4OAxy1IG2XhfJ62edoCIYB7rgZ0mxRTy44l0iahxNNzud92uE5CSQ8UOpnzXLH0uQvZNuDa0N7uGEuc0MFd+oZ0p7xT0SBr2NMsno0lAZhE6BZ9q3NhHmdbLQPyknWU8RXIUtF2qitEJ/a8WtEvC4+bP6voDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784571231; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hNW+b3IQDF/kh+fSEsAW02NIy7tSHfAmPf3CmM/x5+A=; 
	b=Bn6Am825g4dZfICIbEyKX8JT6xo1iWtlvMM8qR/bmNCbzP597mR5iT5MiZAVDwD0fkRwy9phtJmqbPDOC3ErUjZL307/QRRGEPUL/X+Js/aSZsGDm7LpdijAoWuChxz+EfzFV+0c9NYg3pz6ezByZ749M/5vney0W8UYDFyynQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784571230;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hNW+b3IQDF/kh+fSEsAW02NIy7tSHfAmPf3CmM/x5+A=;
	b=UzOu/0FTfgN3dnkuaoHutpS+YctFm18pOjTshmQ0q3evp7b3EkSThb0BkMmFQ6oV
	QTLCOGR9azykxMWovR0y3MqV5Pt0LDDF5ZDb++pXgHLrG/SvfxDJ3aX+IrLEr89uQZY
	YdqQ1eR0im/oOBYZOfDrbkV3+a+JOeqwckoiKlEOQO2qFNqgVTef0//rpn/rRETmRi8
	DqZNjdqQqWUMDBLHX5a+dgJt13NesFskFH/nbzrBlBvrdOr9QyKslRzUu+4ZG0wGBfN
	daVfT4+p4ySMs1kgqgvLoEDkpd1LQsAgc97g0OrtaA6dp8xXKP/YwjfWf4GWD4igBH2
	heYV3uTqsg==
Received: by mx.zohomail.com with SMTPS id 178457122743286.19097741620408;
	Mon, 20 Jul 2026 11:13:47 -0700 (PDT)
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
Subject: [PATCH v7 net-next 0/3] Implement PTP support in netdevsim
Date: Mon, 20 Jul 2026 20:11:10 +0200
Message-ID: <20260720181113.3293-1-maciek@machnikowski.net>
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

 drivers/net/netdevsim/ethtool.c              | 11 +++
 drivers/net/netdevsim/netdev.c               | 94 ++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |  1 +
 drivers/ptp/ptp_mock.c                       | 26 ++++--
 include/linux/ptp_mock.h                     |  5 ++
 tools/testing/selftests/drivers/net/Makefile |  1 +
 tools/testing/selftests/drivers/net/config   |  1 +
 tools/testing/selftests/drivers/net/ptp.py   | 82 +++++++++++++++++
 8 files changed, 213 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

-- 
2.55.0

