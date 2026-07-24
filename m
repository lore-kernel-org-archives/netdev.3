Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BD36B07C;
	Fri, 24 Jul 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870146; cv=none; b=Hkcxf3PeLo8ZQMPCClwdu1JikElgx9/b80rChf7U2R55DiZwRUTJtYpyYjgG0eWzxp+HBhNjFzYjtqwmfiRiarJfSFqSbeZa8F9zWEpveAtzWQTQwJ1v6VX9f79O2/9s+WmciemmdBwPeXTAmX7YFuWQ5Eb780YkBnx4GCPZGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870146; c=relaxed/simple;
	bh=Yn807WZlYUpRmmLrPU6z8OhEtLqgyyHSYoYe31k7T+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ubTagJd3bKV0GozRlxbRwKHnd1viJuoGweXYu0cnnUqpmUgQvpkA41EXuPB8bIowkhdIsfuKO94gjGVt8nCbaYxT7h3uzoMsn+ZVDNZfpmVKlcOesKNbGmdAnrVjTDa0CkWDSg6ZaRbKZnmnSgVnloNlIxYLVpoRHLuDjZwgmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D7k39VTu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D7k39VTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870141;
	bh=VOHRyawGQNoWrmGneMxv4xc3KjMt9wzxCfaOonJ1c40=;
	h=From:Subject:Date:To:Cc;
	b=D7k39VTu/Ich+bS7kWjhKHIy6lnsjf5g9qzH955RI9bxaBqCHPXo+Ciaq9/VMH0s5
	 /Rt0EMNkrKUlr+GR6/+nh69063Z2zgW53wnKv530R/xQDn345oQl9BPZlYVAnP7mgd
	 GY3XXpGVaV+b4FxjsUmxdizBMG8Xz+/hKxSCbisKCQr7Mo5JLSe/PBI9nwPuIxHUGf
	 Hvr1DoJTFdWNciTKdfW4JowSdtPPWxYGjAzUFy82WGiReHs2ZAveeeRHm1YdUJciuF
	 b2VyfkgKsnCgU/wiZp/QnXchK0mBmrIGK/QjXclL5sE7/FClUUHk+bPdFE/QiGz9nf
	 vYTs8qVwn6uIA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 19E7266511; Fri, 24 Jul 2026 13:15:41 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v5 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
Date: Fri, 24 Jul 2026 13:15:21 +0800
Message-Id: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOn0YmoC/33O207DMAwG4FeZck2muEnTsCveA3GRg8uCtGbkp
 KGp707WIjGJMvnKsv39vpKE0WMih92VRKw++TC1pn/aEXvU0ztS71pPOtZJJpmgDis92XymJRk
 KreToVC+0A46KtLNzxNFfFvKVTJjphJdM3tZJKuYDbb6JP7sRP0tLzevBbe3oUw7xa3mpwsKs6
 Zz9Ta9AGVVSc4DRysEMLzY4tGFKORab9zac9ros8bX7tQbGN6yuWZLxxigJhvMHFr+31IbFm/W
 MAzDoe+vM+MASdxZs/SWaJTQqh4MUmsE/1jzP3yVq2JbQAQAA
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

Changes in v5:
- cancel pending rx on ndo_stop, to be consistent with urb-completion
  shutdown
- allow for non-power-of-two endpoint wMaxPacketSize
- Link to v4: https://patch.msgid.link/20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au

Changes in v4:
- fix missing rx cancel on IN urb EPIPE
- add retries for usb_clear_halt
- validate wMaxPacketSize before using for alignment
- don't KUNIT_ASSERT in test cleanup
- Link to v3: https://patch.msgid.link/20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au

Changes in v3:
- split rx urb status handling to a separate change, handle stalls
- merge tx anchor usage into initial usblib implementation
- add skb drop reasons
- prevent unnecessary skb reallocation
- Link to v2: https://patch.msgid.link/20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au

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
      net: mctp: usb: Improve IN endpoint status handling
      net: mctp: usblib: Move TX transfer processing to mctp-usblib
      net: mctp: usblib: Add support for multi-packet transmit
      net: mctp: usb: Accommodate DSP0283 v1.1 header format
      net: mctp: usblib: Implement receive-side packet spanning
      net: mctp: usblib: Implement transmit-side packet spanning
      net: mctp: usblib: Add initial kunit tests
      net: mctp: usb: enable v1.1 packet spanning
      net: mctp: usb: Allow multiple urbs in flight

 drivers/net/mctp/Kconfig            |  16 +
 drivers/net/mctp/Makefile           |   1 +
 drivers/net/mctp/mctp-usb.c         | 348 +++++++++++---------
 drivers/net/mctp/mctp-usblib-test.c | 412 ++++++++++++++++++++++++
 drivers/net/mctp/mctp-usblib.c      | 625 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h        |  88 ++++-
 6 files changed, 1336 insertions(+), 154 deletions(-)
---
base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
change-id: 20260604-dev-mctp-usb-1-1-6fd854ad13e8

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>

