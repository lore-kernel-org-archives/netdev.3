Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CB432E79
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785504; cv=none; b=Fsa6xngRZiBnv4WLGuCNkTTOa/0HKtak8xo6WssyTV2+bya/8UYNOz/gK98OkZKqXa21IZLGRJCRVO0cLCIjm8vAl40FrH19sTTRBzAK4BeBlI4wQJ55FU+fSqpsRNpOgEhJ5K4U1qkUvONf/Idm5JuRkSFTWGh+dq0O5jnFs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785504; c=relaxed/simple;
	bh=N7UldYG3BdnhBYWZ6PsEj2346t3wqGl812awmai600I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYN6dcjVuM7gEZfH4OMgdDiBXtWwx48nrdd2ErNlR7NY0YTjmOUaCiB2ss8qY25rUx6Oh8yUd5NUl8gMOEShoyyVInH7t4SG95QgVMa9Nd0fYMkATROIZZDpcDHjkUMIyWCB1dReuIYhGeNO08YNGjpvTvxImLP8ydLsF8a1vHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQr3IMmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQr3IMmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB021F000E9;
	Mon,  3 Aug 2026 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785503;
	bh=cGjm58fTjK5ywjxtmEfC7pLTtVXQsm9otrq3i6vGFtQ=;
	h=From:To:Cc:Subject:Date;
	b=SQr3IMmjW5bCw9+bOJlJpiqddUhnk8ClUuapYo9N8YJ95ArFcboDXUR8JaVxfMJc/
	 MOkwd6IQpYU1NSsS1UfwgStbhFtw6+PmgM+V3841f0I77XJTyqpNbmxXtoRfBwh8Z3
	 VWQI+JMT8jvRseMYzSqdWIFhoL/++fcHXcQ54a/fb8JEzCSXSfeesI9a9B7MdabbJy
	 GE1KqwpyPbyRxOfQYNrNAMHUmVITFmeiPf3ksWpliF6u67w1SKBgp0h5kJ7NU/oJ3g
	 XELWoooSouQyWLJtlZ2MsdUxi5tC76d55X2Ih3UGf+/fFDpLa8nNaRKX6Ru15QuZtX
	 ksMBSMR/zbeZw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	manoj.panicker2@amd.com,
	somnath.kotur@broadcom.com,
	andrew.gospodarek@broadcom.com,
	wei.huang2@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/4] eth: bnxt: fix IRQ notifier bugs
Date: Mon,  3 Aug 2026 12:31:31 -0700
Message-ID: <20260803193135.2030368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was trying to make bnxt preserve IRQ mappings across reconfiguration.
While hacking on that I noticed 2 bugs in the notifiers that should
probably be fixed before development work.

First one is simple - TPH recofig makes aARFs not work. There can only
be one notifier per IRQ and TPH "steals" the callback from the rmap
updates. Fix by patches 1 and 2.

Second one is a deadlock between the affinity notifier and reconfig.
This one is a bit more involved (patch 3 and 4).

Unfortunately, I can't really verify the problem or test the fix.
I managed to get my hands on a system with an AMD Venice CPU which
is supposed to support TPH, but the ACPI is missing some bits to
actually advertise it. pcie_tph_get_cpu_st() returns -EINVAL.

This series would conflict with the affinity preservation which will
need to go to net-next, so I don't want to wait until I can test.

Jakub Kicinski (4):
  eth: bnxt: cancel IRQ notifier before freeing affinity mask
  eth: bnxt: keep the aRFS rmap updated when TPH is enabled
  eth: bnxt: decrease indent in bnxt_request_irq()
  eth: bnxt: avoid deadlock when canceling IRQ affinity notifier

 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 129 +++++++++++++++-------
 2 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.55.0

