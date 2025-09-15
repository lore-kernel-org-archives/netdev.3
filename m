Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2D1D5CC7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951595; cv=none; b=X8Fkrgh81s2dZpLFtmIje5uNKG4smdYIjdutyyLKcdvspeD6M3aMpR56B1QgE7+9jn5tdM8O1Zc0cfijRfqAxvKUYn2soFuBDlgmOLEY0XXe4YHT4S2Of0MHQDASPLAHacMQLtITlCRmK+Uk/7RZ1Y+9lfp+2Q2A5Ksn7EE1Lv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951595; c=relaxed/simple;
	bh=xEoDbKqJwwHaXm6SQYluWEJ+7NCUR+YRVvd6mzu1Rm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dP1MUCoawyeAaknmej41P3t2RY0qc5g44rPyrBjNAhisUXLD3Lza0doxn9M7ohuiHZ59QuiaEFjtHgX7bIQOX74k6pC6yfLCAK+AYz8nCr9n5YSR99I/73sJzVYHaagBqw3wiwHyKixLLzNCrJhxbAuBAGxgaaNuuOzQ+4fvVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odrdiDyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odrdiDyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA883C4CEFA;
	Mon, 15 Sep 2025 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951595;
	bh=xEoDbKqJwwHaXm6SQYluWEJ+7NCUR+YRVvd6mzu1Rm8=;
	h=From:To:Cc:Subject:Date:From;
	b=odrdiDytGhqBwnhS2GzfA0ujQvDlj8K5p2E30OoSDGHw2GvkTraM2hWV6YB/1UR8s
	 Ps02f9PDI7omL1PFGMb7rfKgZ4d+4yMhzyTAcCCdTOSGXTSTWJ3i7hsVW89pw7Rk8Q
	 CI/nd+rpZIlZZDaIbLGYLqVNUTnnZjClzOmsleTnwDuYaIfGmZSgsuNCk4mg3Ig8iT
	 M/x8scYmy3qA6ZRSM2spjK5VseBKqLk/ZphzY8zOuv/DYTi45qNYawgdWpO+h+Pu8+
	 U1ILlKGbDFlXwh4DDHvVuUx+vUxS+BZ3zJhnYbphlXwQLulXpfUgBq0E0sqmeLmUy4
	 0hllex6iRdDBA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/9] eth: fbnic: add devlink health support for FW crashes and OTP mem corruptions
Date: Mon, 15 Sep 2025 08:53:03 -0700
Message-ID: <20250915155312.1083292-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for FW crash detection and a corresponding delink health
reporter. Add a reporter for checking OTP memory health.

The output is not particularly exciting:

  # devlink  health show
  pci/0000:01:00.0:
    reporter fw
      state healthy error 0 recover 0 auto_dump true
    reporter otp
      state healthy error 0 recover 0 auto_dump true
  # devlink health diagnose pci/0000:01:00.0 reporter fw
   FW uptime: 0
  # devlink health dump show pci/0000:01:00.0 reporter fw
   FW coredump:
      5a 45 01 00 04 00 06 00 00 00 00 00 4d 01 00 d0 
      .. lots of hex follows ..
  # devlink health dump show pci/0000:01:00.0 reporter otp
   OTP:
     Status: 0 Data: 0 ECC: 0

v2:
 - [patch 2] fix attr ID
 - [patch 2] comment and commit msg adjustments
v1: https://lore.kernel.org/all/20250912201428.566190-1-kuba@kernel.org/

Jakub Kicinski (9):
  eth: fbnic: make fbnic_fw_log_write() parameter const
  eth: fbnic: use fw uptime to detect fw crashes
  eth: fbnic: factor out clearing the action TCAM
  eth: fbnic: reprogram TCAMs after FW crash
  eth: fbnic: support allocating FW completions with extra space
  eth: fbnic: support FW communication for core dump
  eth: fbnic: add FW health reporter
  eth: fbnic: report FW uptime in health diagnose
  eth: fbnic: add OTP health reporter

 .../device_drivers/ethernet/meta/fbnic.rst    |  19 ++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  13 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  18 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  47 ++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |   2 +-
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 235 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 239 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  39 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  57 +++--
 10 files changed, 643 insertions(+), 28 deletions(-)

-- 
2.51.0

