Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com [45.254.49.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81622E8897;
	Thu,  3 Sep 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425405; cv=none; b=SkJd09/J7o8LlOSwwaMyXe0ml4njuIkxnlJwsnSDXoMC4du5gJPfDASFbp+aGWzaYo+vuYuODpOyEYVSgFN6//nmFaMYKESJHzOIZq82MVuqrYNuhZbm+NSVrizmM1l39S9epqkwek0Ywek8SZ5RortUVEvFqJoSVx0lJ9zwiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425405; c=relaxed/simple;
	bh=0W6Z3YRYoJJQNOE9LU6MafCf4XMEQIRbP0XQyvRJZUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rkTFOFsA+peB0WNATL70uIcsX7WOTtEIPXXqUhfPOtD0rIYlUysoEnuccjm4d3R0iqmh6ms18YxiRAtWpTq5mc9k5y6JH2L49RVdxjvp4HnKA5kH4SdhHV6vQTySh0aKnqbSbRsUcTPH/XCQJpC+Wuievv/SXlGsVd6rZZkp+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=45.254.49.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5a70;
	Thu, 3 Sep 2026 16:44:42 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Chris Snook <chris.snook@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Satish Kharat <satishkh@cisco.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 00/14] net: Remove obsolete 32-bit DMA mask fallbacks
Date: Thu,  3 Sep 2026 16:43:25 +0800
Message-Id: <20260903084339.870562-1-zhouruizhe@resnics.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06671161803ackunm85c9d55b5cbf2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkgYVksYHkNKTxpCH0xPGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	hKTkxOVUpLS1VKQktLWQY+

A lot of Ethernet drivers set a >32 bit DMA mask and retry with a
32-bit mask if the first call fails. This treats the return value of
dma_set_mask_and_coherent() as an indication that the platform requires
a narrower DMA width.

That is not a correct interpretation of dma_set_mask_and_coherent().
The mask describes the DMA addresses the device can accept and constrains
subsequent mappings to that range. A wider mask includes every address
permitted by a 32-bit mask, including addresses from a platform that only
produces 32-bit DMA addresses. Retrying with 32 bits therefore adds a stricter
constraint and cannot correct a failure to establish the wider mask.
The DMA API HOWTO explicitly calls this fallback pattern incorrect [1].
See [2] and [3] for details.

A net subsystem tree-wide audit found 28 Ethernet drivers with this pattern.
This series contains 14 straightforward cases where the fallback can be
removed without changing the mask selected for the device. The return-value
check is retained. DMA setup errors are still reported and still abort device
initialization. The other 14 cases are less straightforward. So I will submit
those as a separate follow-up after review of this series concludes and any
issues are resolved.

Testing was compile-only. No hardware testing was performed.

[1] DMA API HOWTO, "DMA addressing capabilities"
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

[2] DMA direct addressability change, commit 91ef26f91417
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91ef26f914171cf753330f13724fd9142b5b1640

[3] DMA HOWTO correction, commit f7ae20f2fc4e
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7ae20f2fc4e

Best regards,
Ruizhe Zhou

Ruizhe Zhou (14):
  net: atlantic: Remove obsolete 32-bit DMA mask fallback
  net: alx: Remove obsolete 32-bit DMA mask fallback
  net: systemport: Remove obsolete 32-bit DMA mask fallback
  bnxt_en: Remove obsolete 32-bit DMA mask fallback
  enic: Remove obsolete 32-bit DMA mask fallback
  net: hns3: Remove obsolete 32-bit DMA mask fallback
  fm10k: Remove obsolete 32-bit DMA mask fallback
  net/mlx4: Remove obsolete 32-bit DMA mask fallback
  net/mlx5: Remove obsolete 32-bit DMA mask fallback
  mlxsw: pci: Remove obsolete 32-bit DMA mask fallback
  eth: fbnic: Remove obsolete 32-bit DMA mask fallback
  net: pch_gbe: Remove obsolete 32-bit DMA mask fallback
  net: renesas: rswitch: Remove obsolete 32-bit DMA mask fallback
  net: niu: Remove obsolete 32-bit DMA mask fallback

 .../ethernet/aquantia/atlantic/aq_pci_func.c  |  2 --
 drivers/net/ethernet/atheros/alx/main.c       | 13 +++++--------
 drivers/net/ethernet/broadcom/bcmsysport.c    |  2 --
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 ++--
 drivers/net/ethernet/cisco/enic/enic_main.c   | 19 ++++---------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  9 ++-------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 --
 drivers/net/ethernet/mellanox/mlx4/main.c     |  8 ++------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  8 ++------
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  7 ++-----
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  2 --
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 10 ++++------
 drivers/net/ethernet/renesas/rswitch_main.c   |  7 ++-----
 drivers/net/ethernet/sun/niu.c                | 10 +++-------
 14 files changed, 28 insertions(+), 75 deletions(-)


base-commit: e16acadb9a0f7a0f04318e4b3a8e89e8ddd0c905
--
2.27.0
