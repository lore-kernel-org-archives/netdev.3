Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192538CFEF
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937342; cv=none; b=IJoHFtRz5QnLrDwz2a8KxUpzEVDB80WFCl9DA56QzKoxkc/YUvU1DfW4gthI6WDvWbO/Rjs1vnI3ssIWPEhNOMICp/8dxWl+PzWFpwzsFbGwpNWorQhJD+BJB5IQ7TL8Rah8L/VTIr7LegEn315B9cv5sMDn4s1UEqrHj2iuAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937342; c=relaxed/simple;
	bh=A9SWJGMpGBwC1iuglRcXzbQETOKzmDxhcXeqiZS5Q3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=accsWWhHqmmCXyq3Pl664wg+FiwR1zG66CKGqzZucu4qW9jduSo7VgVszysGYfU3qevGbw7M1uon1Z2qftOkc/iUqE6o6lxYdzZ60MSIHo/gwduuJuTs3dFVrOrc3DTeP2eB+jVCuSwmKs+bAaEJaInXXIRSYvg5TsFGmbifiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfwvN6Yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfwvN6Yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A01F000FF;
	Sun, 20 Sep 2026 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789937341;
	bh=XtWYfxTcr6LWkAM5ZktpDDBTliXVaVkdfS1YcgrN3/Q=;
	h=From:Subject:Date:To:Cc;
	b=dfwvN6Yi8zGRqEnYaISmA/vxwXbveOwTp/XLKCg0hRnzi7+8ZQ0SkRO6psesoLfq1
	 4NknNnN9JeWCQaj1+LsXXW9X7Y3JmaPVe+sH4gDjjlTu7v3hBFzIoWt+ENIM+zhWYV
	 VMHHphoYTp+8tOBGkD8Npy4aj1OebXUhy3byDyFaHZ5AX20VKS8oVragsasipjpozl
	 AaQk9WaHW4jY9WlsHhlS0N7qbH+8hQ0KNsU/gZ3jXDeLFE7Ulf59qD9QOzvg2zDJb2
	 FY35/XlYAOGhslABp5jfT/qTFTgosTFCe2Et1azhChUDW/euszfsHuk3IYZ59HZLOw
	 jDyKmcR0PtOvg==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next 0/3] net: ethernet: cortina: Use page_pool for
 Gemini RX buffers
Date: Sun, 20 Sep 2026 22:48:50 +0200
Message-Id: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LQQqEMBAEvyJz3oGYqKBfkT0E7egcHCUJiyD+3
 azHoqouSoiCREN1UcRPkuxaoP5UNK1eF7DMhcka25m+7nnBJiqMvCIqMgc5kdhxMI1xXeuCdZ7
 KfUS8qswj/UPFmel73w9GxeJucwAAAA==
X-Change-ID: 20260919-gemini-ethernet-fixes-3-f0403653f23a
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The Gemini ethernet has this really convoluted queue mechanism using
a custom queue.

Move the Gemini RX buffer management to a parent-owned page_pool.

This series fixes DMA mapping and synchronization, fragment recycling,
and teardown while retaining the hardware free queue shared by both ports.

We need to track fragments by the exact DMA address returned by
hardware, since RX software IDs originate in the classification hash
table rather than the free queue.

Scale the default RX rings and shared free queue on Gemini systems
with 32 or 64 MiB of RAM, as the RAM usage may be a bit heavy on
those.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (3):
      net: ethernet: cortina: Keep shared free queue parent-owned
      net: ethernet: cortina: Manage RX buffers with page_pool
      net: ethernet: cortina: Scale Gemini RX queues to system memory

 drivers/net/ethernet/cortina/Kconfig  |   1 +
 drivers/net/ethernet/cortina/gemini.c | 389 ++++++++++++++++++++++------------
 2 files changed, 252 insertions(+), 138 deletions(-)
---
base-commit: 2ff4ca33660706f4092866b220eb0c94940f7e0c
change-id: 20260919-gemini-ethernet-fixes-3-f0403653f23a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

