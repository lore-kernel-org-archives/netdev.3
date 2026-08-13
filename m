Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26A3E558D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659649; cv=pass; b=DhkIAPkOfnsm+GNDvr2JVB15c4F6X/Jk1E6pf8zkmk6Hz71hLh2UL3lBq5LsJUVDawZqKS1rFxuL+Zu3ZzulLpPAQS0RCaqJivx+LBYoM3AOjxzUt0dGZCG8yBtkIlIN3hw+vWvPneCv0wxftHZxAoBsge+/tdjqDLeQBFf5fjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659649; c=relaxed/simple;
	bh=mSCv3jSltX9Pw4bMKVcd/4VfBgps++tpXs6Ijz3KCqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQDx8mEzTesVnEC8MDkY50ufSsjw7ygnWQuuoww9D2ehhKHy6SasnG/EKHdGcIxi7QYqm3o4FkT4vAcSVkvIrFRYzCxjbBPbJH9FleVbPxgzWfsVjnccoHsAoTJUe7DeGcp3GhoJ/p7SLgmJFg6oxiyXEr5PeHyFFobx06fmNuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=VPFQtXnj; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="VPFQtXnj"
ARC-Seal: i=1; a=rsa-sha256; t=1786659630; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IxXIlAYAnuXrNtp4aCksIgfFVdTqVF19fxn+wtdWyn9m4gKIggTzGAHawZtKaEN6dpPj0Z45Fhpahanl28VP5A+68nlgx4qMs8UC2WwltzTyhV0jqDMB9RQS9dVxaHXhZPax1Sj2oVW6S/HYJjRBg0J7j89RfyxLaZ5JDDgVN1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786659630; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XjTknpwjJprvkX+R8Ap3PB5VAe16/r/lP1Gi9PJWz08=; 
	b=FN5sKTjl58PHgGtoVzoC4HPJtINBR2WUVMnOYe4+cfwb75oRWcu/yP9hfQjmhK5EBTjU9arLl+6iCozgvzDb1robzjd9fY3MgMWvLvo7srK5ZLLDV3pBClnP7as8BWPhKXqmv2Hoyq9UbfyAvtDgFYESiq7EJ/faYmzwC98VVpI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786659630;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XjTknpwjJprvkX+R8Ap3PB5VAe16/r/lP1Gi9PJWz08=;
	b=VPFQtXnj0gc0PtgY1ITL6RVkG87Se6vX+XCs+ABLRaHfOEyWOdtpZXCxemLyfjb/
	pe3ccM8qAnBflq+5oB5NTvfdYLx7+1CTG3At0gdLQpbxPg20VrVD/BkEsvZ17J9H1dr
	wafGnMy586NKUpDa/6i5bMgnlD4O34a0p+/gniUoWLNgihaxDE8YToebtxLyFLrqV7R
	hleqqD3qBDoOBvwmvrnfKhX03dP0FIEYLSgGXbxiuj3XfSv5gKX6mocuVM4EPE9pVIG
	og2UaQhi8g0p6nh4ZjY8y/jtzjpjUYhHoyFpSrne6qvNmN87jcNH3aQpcLsh4X6qcym
	F5kJ9qW4TA==
Received: by mx.zohomail.com with SMTPS id 17866596268991022.3257221125456;
	Thu, 13 Aug 2026 15:20:26 -0700 (PDT)
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
Subject: [PATCH v9 net-next 0/3] Implement PTP support in netdevsim
Date: Fri, 14 Aug 2026 00:20:20 +0200
Message-ID: <20260813222023.2460-1-maciek@machnikowski.net>
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

v9:
- Unshare the skb instead of copying it
- Move the PTP timestamping off the xmit fast path
- Sample the TX and RX PHCs with IRQs disabled to keep the reads adjacent
- Validate the hwtstamp config before touching device state
- Report a -1 PHC index from ethtool for ports without a PHC (VFs)
- Clamp the ptp4l poll timeout in the selftest to a non-negative value

v8:
- Fix the lockless tstamp_config access in netdevsim with
  READ_ONCE()/WRITE_ONCE()
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

 drivers/net/netdevsim/ethtool.c              |  15 +++
 drivers/net/netdevsim/netdev.c               | 107 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h            |   1 +
 drivers/ptp/ptp_mock.c                       |  26 +++--
 include/linux/ptp_mock.h                     |   5 +
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   |  84 +++++++++++++++
 8 files changed, 232 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

-- 
2.55.0

