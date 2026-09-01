Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBB3BADA3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282300; cv=none; b=HFADVgk6krHYpxv0Z0GcwFAToovWVyIMNrnMur08QOb6r8970GxUC+X+zvL+fZLAK3POXaABPdU8fOmPv4g6VmcriCTUxeCGBkOLm2hiMQvfFbeaT4GT6vtQ1W1z5ySJvq66e/hvW6fHJWdWpSjCn/E7iQos2srDRIIJuA3psAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282300; c=relaxed/simple;
	bh=dVdYXr5vmVz6vAaPOz0LXzdwz/HWH1kn9vUr4PTYEOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lk4mx/V3M24/jNwre0UBzbpVyLf/Wf1ZcVm4H7y7uBzeElxNroeYVXvNXgHlEoN3Er8o7C6LgdcWzpReFmFZwLgkkvYndF47NU5GC9iwbPEFha7o9x+xrzOb5+tv2JxpVnxR+4xocAPHbNFG4q59h7L4r2l3J6MhlaZBtcGKllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiXI4em9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiXI4em9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F4E1F000E9;
	Tue,  1 Sep 2026 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282298;
	bh=T4siLDGTE4+D0ZsyiW3q7MDQa5d77sWjQM9vHQabWHU=;
	h=From:Subject:Date:To:Cc;
	b=HiXI4em9aqoMWCf2Z8LLwUAanjsn3jPI1pxMuQpLWD/goPM0N+zAzl4TMI6aErzOp
	 jVKFmLBdq3lTpgoG4+0qXRPU/fce+3LIXs7dIrTxJ074dxCyHPx9STuV/XfBaqfPXa
	 6OXHtwp2QhP5N6djzETiMsF6T31HUUJBt+TrQSALGKEM7UQgAajzYHB/Q39LoeeyPS
	 Qk0mxYw93EtuGOCy1ZZlCkyW+OtHq1Bdych5Wo/KcCf6An+BufayxjbE2dwyR7EIh6
	 QxMvdbeDOWRzzh9J1Ct3bRklhKS9PWG28qyJm707Vy9nIEhUFXJ30y9ib34lOJ8XBs
	 zjr2pwrNq/U4A==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/3] net: ethernet: cortina: Fix RX budget accounting
Date: Tue, 01 Sep 2026 19:04:54 +0200
Message-Id: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqAIBBG4avIrBtQo6KuEi3K/nIWWWhEEN09a
 fnxeA8lREGiTj0UcUmSPWSYQpHzY1jBMmeT1bbWrTa8YpMgjNMjBpy8yI3EqGeLxlWlMxPl94j
 4Q1774X0/cyvHF2cAAAA=
X-Change-ID: 20260901-gemini-ethernet-fixes-e6d2e7c53c1b
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Report the actual NAPI work, charge dropped frames to the poll budget,
and drive free-queue refills from consumed RX descriptors.

Tested on the D-Link DIR-685.

Hi Sashiko, yes there are more latent issues I will get to them, but
my LLM thinks those are on the top of the list.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (3):
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: Count RX descriptors for freeq refill

 drivers/net/ethernet/cortina/gemini.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-gemini-ethernet-fixes-e6d2e7c53c1b

Best regards,
--  
Linus Walleij <linusw@kernel.org>

