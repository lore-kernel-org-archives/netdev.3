Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E393322C7F;
	Thu, 22 Jan 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094381; cv=none; b=W8fhlWScOP6Npuhrl0ezGU3P7HqB2VQXKAw8953O49ceVUhl8+6G5VsmilN9XMbT7Oq32fShjkgHYip8+eQji14UVZXkTfOKbPhKfuY7KQohStOZiXZ1ZpEmZSCSsYejP7gBFcxC6/Y7BIjGKHTRtXFKrGtjtyFatt2WJ8VktdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094381; c=relaxed/simple;
	bh=IVgR7JzQlHJmesyTjWQjjWW4v/SgRoCQ/+97cLwJOkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRRultr6xe5uSX9e58QGk2zpQY+ibH7B4iGJ0BoCS0VpCROer+Mzs6G1tjuMcA95PDTlF9S8Mz5S7Inyoq0XiiHXcvgfP1qx9+PMXX489tqUDDuijf+DBioZwpAw2m3oTJnigexE72BtWzAuj9cfQGi7v1qk8x9cRKtYjbKAmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.187])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319dee97a;
	Thu, 22 Jan 2026 23:06:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: andrew@lunn.ch
Cc: amadeus@jmu.edu.cn,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dlan@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	spacemit@lists.linux.dev,
	wangruikang@iscas.ac.cn
Subject: Re: [PATCH 1/1] net: spacemit: display phy driver information
Date: Thu, 22 Jan 2026 23:06:01 +0800
Message-Id: <20260122150601.586846-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b4e0b1d2-cd6d-40f3-89fc-c1bd41c82480@lunn.ch>
References: <b4e0b1d2-cd6d-40f3-89fc-c1bd41c82480@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be63dc98403a2kunm36ae2a8f92c99
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUgeVktPGh8ZHRhDSEMZGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSkNMWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Hi,

> > Print the PHY driver used and interrupt status after connection.
>
> The standard way to do this is call phy_attached_info(). Is it missing
> some information you need?

I initially used phy_attached_info(), but it was too long and printed
phydev_name() "cac80000.ethernet:01" twice:

YT8531 Gigabit Ethernet cac80000.ethernet:01: attached PHY driver (mii_bus:phy_addr=cac80000.ethernet:01, irq=POLL)

So I referenced a part of phylink_bringup_phy() to make it look better:

k1_emac cac80000.ethernet eth0: PHY driver [YT8531 Gigabit Ethernet] (irq=POLL)
k1_emac cac80000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off

If we're going to use phy_attached_info(), I think `mii_bus:phy_addr`
is redundant. What's your opinion on this?

Thanks,
Chukun
