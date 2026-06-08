Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D32EFD95
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881956; cv=none; b=drxFawgrcUjoXEUcSQ9/gjBbdUjiSOl03X/h0R1Pm+unujHDcHP9VZvJHI9Gi5b8g7oTO66Gla8/KQD/5IhpEJC40/PP/hwdOYfUuyWMFB/BrMO/Zji4ZyguzoBGPl4qC5o99JdoPl5bUErOb2if59crLTXHsUc8f2LRAth8/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881956; c=relaxed/simple;
	bh=MqMwVxgc0N8B5R7CUE+AAOSjk/65nw13UGGt/jDxPPQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bClGE9mCqCQkau6wNl4TNSbpeD/Pxzi/xQ+37qVL5Hs/Tk42IIMnRYl4a9U2hGz3OKXVF6PF23JuAPuewjvud6XkpYQzprsozqhaRzDelIcKXWKiSLGxilcqXspd3XxsZ17S8dAzhT9/w7SKPfA9IcoEK0Tx3/3ljMFUg+skbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kClg8r9O; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kClg8r9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780881945;
	bh=LZd936MbtfC2WutCr5yZsrKjQIyYVG8U/rPx2puueWM=;
	h=From:Subject:Date:To:Cc;
	b=kClg8r9OYwItVNHl57+QIvpztzfdzBMt5j7MWRN0eKbfmeh8jHcKABN6iLX+wX0Kd
	 LP362Q6cQ261ClZDGX4zEU4QA2PIso3lkGb5ymuc373D3kK8ESg2+Bwzadvfr4bK12
	 vEqD9rEDMguwTBcbJZXk4sYrmUu2LYpcLAvTzTuhRDd7c78tDRfL2uwrpoBgousQPV
	 VfScVGgri0nuWH6Ua2jv+hvrjw/W0rlwuGM4O8G3IbTTwpf/tTHyW1VlajsV8KON0z
	 rYAX1LW9+riPVAJs7ETSe2RZ+C9awrq/ktQLz42oiHRlsOn1y/fk+ighMBPEGVRjD4
	 V6nnjv2u8spXQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id AAD1060876; Mon,  8 Jun 2026 09:25:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net v2 0/2] net: mctp: usb: minor fixes for MCTP over USB
 transport driver
Date: Mon, 08 Jun 2026 09:25:39 +0800
Message-Id: <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMaJmoC/4WNTQ6CMBSEr2Le2kfaKgRceQ/DAtpXqQkt9i8Yw
 t0FPIDLmXzzzQKBvKEAt9MCnrIJxtktiPMJ5NDZJ6FRWwbBRMUqVqKijKOME6bQo5/R0ztRItR
 XrVipVc1FCdt68qTNfJgfYClC+ytD6l8k4+7cscGE6Pzn+M/8gP9eZY4M+7pqmotivJPsLp0i6
 WyIPslYSDcWXYJ2XdcvGN0RleAAAAA=
X-Change-ID: 20260605-dev-mctp-usb-rx-requeue-f4fd05fd8125
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.16-dev

This series adds a couple of fixes in the ndo_open / ndo_stop path for
the MCTP over USB transport, where we are incorrectly sequencing two
error cases.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v2:
- Add fixes tags
- Add re-queue note in 1/2 commit message
- Link to v1: https://patch.msgid.link/20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au

---
Jeremy Kerr (2):
      net: mctp: usb: fix race between urb completion and rx_retry cancellation
      net: mctp: usb: don't fail mctp_usb_rx_queue on a deferred submission

 drivers/net/mctp/mctp-usb.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260605-dev-mctp-usb-rx-requeue-f4fd05fd8125

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>

