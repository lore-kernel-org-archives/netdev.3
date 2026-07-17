Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56392FB97B
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284686; cv=none; b=nAie5OFdbJHjzRtQ7eTIbCAZgX/zygq4nGoR7haV4pjlzvtk4bsYeH+/sXKuIjenZhqCAd3fcH+OfGHCQuUZs5lLeG8FgRYeoL8iXXAzXp0qLD2vHJcFd5UKWqd/uF1BO+wE+dZOf0VMxJoTpb6VPZD/f2g8UBhhI88/Q9D5Fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284686; c=relaxed/simple;
	bh=xMLIPdfaRB3C2iAGelA6nq5WM14R9YxvR1LHsjkgaao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5uTs18StCkWS7gnZead1ZyDscRzjjAMesiFgxea4pmea1YS9oNhArKlwMvmVb8ipPBPzVXGcX7S2Piv9w5eyP2QCBfIYAUmkc9yB/+If7C0sBTVgOSVG7DWF8vDTU83DDphCLofq9KubP2pJ8fPw6XuHAP7Y4DX+eknY3zkVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X0eyooNs; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X0eyooNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=og
	fOixQ6j0Dq9m7RRqj0ZVgn72BaBTQIwL3YHftwbXk=; b=X0eyooNs5D62G35C/U
	eMYUzZkPFFOLnhOCNdYw6Htagyrwgyi0h37snAPHs56x1aMbcmVgkJXn/jahU1dD
	4IT5T3eWikJmF8uG3gGcH5vmkRwvX/REsSSFazwe1IWWpsHP69bwdPMKFNczMXcG
	+YSiDW48FbggvApUJYDZWPhxU=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnVWDlBVpqguBEKA--.5251S2;
	Fri, 17 Jul 2026 18:37:26 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net 0/2] 8139cp: fix two TX error handling bugs
Date: Fri, 17 Jul 2026 18:37:22 +0800
Message-ID: <20260717103724.13971-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVWDlBVpqguBEKA--.5251S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKryDWr17KF4rWw15uFW8Xrb_yoW8JF1xpr
	WYg34Yyr95Wr1293Zayw4IvF1Yva1rt3s8JF97tws8Zrn8Crn3trWF93W0y3yUKFyxXa15
	tw4Fv347CF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvLv_UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxAarempaBebFgQAA3E

From: Yun Lu <luyun@kylinos.cn>

Hi,

This short series fixes two bugs in the transmit error handling of
the 8139cp driver. Both are only reachable when DMA mapping or
memory allocation fails, but each can take the kernel down when
triggered.

The first patch rewrites the DMA mapping unwind in cp_start_xmit().
When mapping a TX fragment fails, the current helper unmaps the
stale address found in the not-yet-written head descriptor slot,
which is a double unmap of a previously completed mapping; the
fragment unmaps use sizes shifted by one slot; and the head buffer
mapping is never unmapped at all, leaking one DMA mapping per
failure.

The second patch makes cp_tx_timeout() handle cp_init_rings()
failure. If the RX buffer refill fails there, the ring is left
empty, but the driver restarts the hardware and schedules NAPI
anyway, so cp_rx_poll() dereferences a NULL rx_skb slot and hits
BUG_ON(!skb). Bail out and leave the device down until the next
open instead.

Thanks,
Yun

Yun Lu (2):
  8139cp: fix DMA mapping unwind on TX frag map failure
  8139cp: handle cp_init_rings() failure in cp_tx_timeout()

 drivers/net/ethernet/realtek/8139cp.c | 31 +++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

-- 
2.25.1

