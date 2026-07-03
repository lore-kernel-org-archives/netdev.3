Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC336A37F;
	Fri,  3 Jul 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057690; cv=none; b=ABEJLb5mkHT/rRAeAfmSF1lQlnypkaeMa4ytMrnCI9zANPIyhH1bbN2hF77LV2Bq7u9ICMlFgGnGkNemXevsNb4GD2OrfoKPGejSHl04NGsqDAtecHK9zXGW6g3uVxhzTbSWwBtv8mH00eTyLwV2B6tOSXRJ0RVR1qaBDHEU1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057690; c=relaxed/simple;
	bh=D5Tn7XSFgByn7QwJJG/6rIf0djjid49NJAyfwKWss0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MV2BW7tLTmzL6ATtRupORoeJMFIOaOs1B6KjGfbCnzMDABiXhyDIH7PffpqK11zfKXy5hw0Di0De7zh1N8IPnikiQdY3jJlYvK7SJq9epEqqEKJ8dj0LfECopD3qNEX3aa5A8IYurfH55+O0+SJ/30RSRaehNye1rrpOecrGNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aTjcfCWg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aTjcfCWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057669;
	bh=VM6lGt+VL7PBeCZIokU43y2WhkC1SDBJ5mIOBu9HVy4=;
	h=From:Subject:Date:To:Cc;
	b=aTjcfCWgnbBNA+UULIUyf5cZtRtRn9zVIgpCLr6dh6aMeC4IDJuRn0sW7OkdgLq82
	 Z6GaUmgrPVZXcJY7NZDXNzkweOuH0EQlmScCPOVDxEleLcv/PxKVVKVxlIuwC11tzv
	 YZsI3Z5/cByUx2wDv764dhrqYn/S8kWkb8OHxF6EfAQ7c8oil8/8iK+z44cDOVESCL
	 Fru/UIJIJvfi/VnsCwR+PmYizeXTAIFxQx8xDf1U7dvo6TnJauYAOUQ3HmgFUGyH92
	 AlnZfuhfJ5ee2yPfHx+5aymB6Wp1xTFDkaD0U6mqZqE52yInKwKPP4q7bcW3VhSRlq
	 FU4DBfnxP5avA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id C324D660CA; Fri,  3 Jul 2026 13:47:49 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v2 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
Date: Fri, 03 Jul 2026 13:47:20 +0800
Message-Id: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhMR2oC/2WOzQ6CMBCEX4Xs2ZIWsBBPvofhUNpFakKL/SEYw
 rtbwJvZ02RnvpkVPDqNHm7ZCg5n7bU1SRSXDOQgzBOJVklDQQtOOa2IwpmMMkwk+o6wdLxXzbU
 SipXYQIpNDnu9HMgHGAzE4BKgPT8+di+UYSf+vA7fMbWGM7DbBu2DdZ9j0swOzNle0v/2mRFKG
 i5KxnrJ666+S6tQWuODizLk0o65iNBu2/YFBoM8MewAAAA=
X-Change-ID: 20260604-dev-mctp-usb-1-1-6fd854ad13e8
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

Version 1.1.0 of DSP0283 (MCTP over USB transport binding) has been
released, this patch series updates our current v1.0.1 support for the
changes in v1.1.x.

The major change in v1.1 is the introduction of "packet spanning" mode,
where a single MCTP packet may be split over multiple USB packets
(themselves forming a single USB bulk transfer). This relaxes the
requirement for USB high-speed mode, as we can now send MCTP packets
contained over multiple 64-byte full-speed USB bulk transfers, and gives
us an increase in the maximum MCTP packet size - we now have 13 bits of
packet length (previously 8) in the transport header.

Handling packet spanning introduces some complexity in the transmit and
receive paths, as we lose some constraints on where packet boundaries
may correspond to USB transfer boundaries, and may need to retain state
across separate transfers. To contain this complexity, we introduce a
new library for the transfer packing- and unpacking implementations,
"mctp-usblib". The host driver is a consumer of this library, and a
future gadget driver can use the same implementations. We can now also
implement tests on the API boundary of the library.

The series implements an incremental shift to mctp-usblib, then
implements packet spanning mode in the new library. We have a few
changes to prepare for this, in altering a few constants and
behaviours as v1.0-specific. Once packet spanning is implemented in
mctp-usblib, we enable it in the host-side driver.

To: Matt Johnston <matt@codeconstruct.com.au>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Changes in v2:
- address sashiko reviews:
  - rx mac_header correction
  - rx/tx stats fixes
  - limit non-spanned packets (where we have no ZLP) to max size
  - handle transient rx urb error status
  - set skb_drop_reasons
  - kunit early-exit cleanups, take rntl lock where needed
- rework tx_qmem locking and anchor handling (we don't need to unanchor
  on completion)
- Link to v1: https://patch.msgid.link/20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au

---
Jeremy Kerr (12):
      net: mctp: usb: Include version indicator in max packet size defines
      net: mctp: usb: Use packet-length max for maximum packet-size check
      net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
      net: mctp: usblib: Move TX transfer processing to mctp-usblib
      net: mctp: usb: Allow for multiple urb submissions from a packet tx
      net: mctp: usblib: Add support for multi-packet transmit
      net: mctp: usb: Accommodate DSP0283 v1.1 header format
      net: mctp: usblib: Implement receive-side packet spanning
      net: mctp: usblib: Implement transmit-side packet spanning
      net: mctp: usblib: Add initial kunit tests
      net: mctp: usb: enable v1.1 packet spanning
      net: mctp: usb: Allow multiple urbs in flight

 drivers/net/mctp/Kconfig            |  16 +
 drivers/net/mctp/Makefile           |   1 +
 drivers/net/mctp/mctp-usb.c         | 276 ++++++++---------
 drivers/net/mctp/mctp-usblib-test.c | 389 ++++++++++++++++++++++++
 drivers/net/mctp/mctp-usblib.c      | 589 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h        |  91 +++++-
 6 files changed, 1207 insertions(+), 155 deletions(-)
---
base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
change-id: 20260604-dev-mctp-usb-1-1-6fd854ad13e8

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>

