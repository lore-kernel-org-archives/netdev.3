Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B235D5E0;
	Tue, 27 Jan 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526778; cv=none; b=QkICrdvbysQK56A0HU6W96aglt1RGXtNt++fnSohcP3wrXqPXMdonuGN4YsZ676v08ZH32uuQ+8fUocj3lhI7W4sjMwByhHZ3m18k27YoI5ChUULq0NgzDhtxKkHi3ulGm06RfEl64hzZGbXlN+bTcHgvviwYJ0dg172+d6XF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526778; c=relaxed/simple;
	bh=96z4XgVzZHtuzTcKZ2gDUzqhC3RBDyLxENe2x1oCvv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJvlBO2hRGYAyI/BsIAlPSZ6inC8I3Wgg0cPmfy4ur6P/4YFBM+Ldr3cPJ9BaKNXAKPKP7xYwCrGM6J6HN1ilswJEBW3jeVG5jT+dG2R0GdYnzKB//UNBHptDlOVvEd9XgJ1NUtpQ9AnJ1xGRlZ5Uf2CS+7aXyxPKDNv/lUJpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FbZiLeDn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FbZiLeDn"
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32272e8ed;
	Tue, 27 Jan 2026 23:12:50 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v3 0/3] net: liquidio: Fix memory leaks in setup_nic_devices()
Date: Tue, 27 Jan 2026 15:12:38 +0000
Message-Id: <20260127151241.1144039-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0003b91f03a1kunmaea0ca6058ce1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUweVkMYGUJLTBlIQx8dT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=FbZiLeDns5BfAXIz7vpc1FQHfqHWIDFYrno4jpadcFp0r4UxEEWha6Vq7psVcaRTRBy4tf6Vcwyp04iBEfvxCUy2DLQlLJgq/8XyLY3PfpRMSXFBoLTt/ASSFta42T8s6MPLf2HMMNmr6FIkSBofa0XNKvnKaySiUv3NDklQk3I=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=z86GE4yOzRAkKPpjFUEzc+Uan/XY6Hv3rjuJ7Y4jzfw=;
	h=date:mime-version:subject:message-id:from;

This series fixes memory leaks in the initialization paths of the 
NIC devices.

Patch 1 fixes an off-by-one error in the PF cleanup loop. It ensures
the current device index is cleaned up and correctly handles the 
post-loop devlink_alloc failure case.

Patch 2 fixes the same off-by-one error in the VF cleanup loop.

Patch 3 moves the initialization of oct->props[i].netdev before queue 
setup calls. This ensures that if queue setup fails, the cleanup function 
can find and free the allocated netdev. It also initializes lio->oct_dev 
early to prevent a crash in the cleanup path.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Changes in v3:
- Split the off-by-one fix into separate patches for PF and VF.
- Patch 1: Decrement i in the devlink_alloc error path before jumping
  to cleanup to avoid accessing an invalid index.
- Patch 3: Initialize lio->oct_dev alongside props->netdev to prevent 
  NULL pointer dereference in cleanup_rx_oom_poll_fn().

Changes in v2:
- Add patch 1 to fix an off-by-one error in the error handling loop logic.

Zilin Guan (3):
  net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
  net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup
  net: liquidio: Initialize netdev pointer before queue setup

 .../net/ethernet/cavium/liquidio/lio_main.c   | 38 ++++++++++---------
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  3 +-
 2 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.34.1

