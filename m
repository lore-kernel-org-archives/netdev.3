Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B83ED3CA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649571; cv=none; b=JpwcD04ejxK88AvDIFCBd/2M6Pi1oZxDJLZbaUhmHQEeUiV1zomyExw1+EK+AkMikgNZDnPrVEdpiYSMs9DPmDv5yOD+1u8YSJ96TPvGCgLcy/SIFu6L50VlxKBesnb9fp8ySlxPQoEKRmZaawjtBxnX/rjDGQqKMAH3CSGfEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649571; c=relaxed/simple;
	bh=s3lKfO98g1fkAUIiHBF2xGlcclcvUp1uJzEWq2ievqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arZI4a4pAG4s81WPc0qpZ5COcQ5+6kiVms/rA0NGvOWsLZ0rTMeR1dVWWDFXJZxVQjyJ03Cgmb/jHXnsmHw8WeJv8ZFjriOWxky94yEMdRch+Enb0nWGjyPbKYfExotoyIVbUM8ZtVzr23x0FgPVsuqoI2jNlwrV9Ne3Y3n9y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsUeuDzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsUeuDzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300691F000E9;
	Thu, 13 Aug 2026 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786649570;
	bh=GpR5660k7x9K8bJ2RYXN+bbRAnDmFGa4QuoxJ3KDc6Y=;
	h=From:To:Cc:Subject:Date;
	b=hsUeuDzBQybglI5+rj2BALEmsXi7XBRaVlpBlMwe8Q6nIvL5K8rSz1sIBj1863Gkc
	 PajKkFh9PXambv/RTB+bbfrdEkPjC1Gy/TbKOidTn8eE0FSrYg6Wp5WdXMfV0XbCL9
	 rxnMZEGoqa3Tyw7ENCoQLmeg4BZiYPUuRyqS1X/VikOF+xChv4610nxBjDzzQPT0Fe
	 4fSn4M/VjHDTuk8F5uKZJwcamkSxTrxwzoUWFDD4XW3S/LUspLE/XsKTJyiDS0tEf/
	 By3q7U5CUKb/4UwdKlYKhLkjJ3MkwV4qax+mPZPvHyh9EkfGjr973jfsbYXIfsddOK
	 TjmJRmdZbJQEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] eth: bnxt: preserve IRQ affinity across IRQ reallocation
Date: Thu, 13 Aug 2026 12:32:46 -0700
Message-ID: <20260813193248.2578626-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt currently discards the IRQ affinity when changing ring count:

  # ethtool -l ens9np0
  [...] Combined:	8 [...]
  # ynl --family netdev --dump napi-get --json '{"ifindex": 2}'
  [...]
   {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 70,
  'ifindex': 2,
  'irq': 170,                << IRQ 170 is for NAPI 1 (second to last)
  'irq-suspend-timeout': 0,
  'threaded': 'disabled'},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 69,
  'ifindex': 2,
  'irq': 169,
  'irq-suspend-timeout': 0,
  'threaded': 'disabled'}]

  # cat /proc/irq/170/smp_affinity_list 
  1     <<< system config script set CPU 1 for this IRQ
  # ethtool -L ens9np0 combined 1
  # ethtool -L ens9np0 combined 8
  # cat /proc/irq/170/smp_affinity_list 
  0-31  <<< system has 32 CPUs

After this series:

  # cat /proc/irq/170/smp_affinity_list 
  1
  # ethtool -L ens9np0 combined 1
  # ethtool -L ens9np0 combined 8
  # cat /proc/irq/170/smp_affinity_list 
  1

We recently added the ability to networking core to track the affinity.
bnxt doesn't use it because it needs TPH programming as well.
Let's align its local behavior.

The loss of IRQ config is a real production problem, but it also breaks
some of the NIPA tests.

Jakub Kicinski (2):
  eth: bnxt: decrease indent in bnxt_init_int_mode()
  eth: bnxt: preserve IRQ affinity across IRQ reallocation

 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  11 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 131 +++++++++++++++-------
 2 files changed, 98 insertions(+), 44 deletions(-)

-- 
2.55.0

