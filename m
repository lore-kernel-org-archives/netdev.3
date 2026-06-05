Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13935A39D
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644304; cv=none; b=Eed7s5tFP7Ce4wYFxyQm+chd8Ef5EElhWv0/c/G3UOSzqnsbYl2j4zhvPK6kYmWgkiuC0yILYMlyWhDR9BKKIm+6AGDnbzRvcPTKf3TlqZoX05mRNChwJVgCoHMuiaRSq/FC3E3jcBhR3Mky5DhxLtcZIMK6ZD7IkWMaNwPrTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644304; c=relaxed/simple;
	bh=/UWkZ1dUTXtRj/99R69UG78iWqI3oJXS3iUTrt8A1po=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KkeGtCQLyObUYcApR8rS/GhJEjb94LLTqaRjVj3OlW8xI/TSkmNOXAGLlXBBdcTzvtk78wI94XPFBGHPGxQewJSm0aI/ZCjWOJu73mq/T70Nmfeidis3vJ4HYH+tfM+Fo1/xN4Q8fsQ8AY8BXCLM4u8e2bNsfEM2ADCpeoSbFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZsdGUqWu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZsdGUqWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780644300;
	bh=P7iqWUt3w20kciwIHEW47L5qMSmYSuFRjHdYSJz7fWY=;
	h=From:Subject:Date:To:Cc;
	b=ZsdGUqWutWg2Jrbh8KVvouQ4hvzAWWm3D+TtpWNHLEddIR+h7y/8EY6byGBU4r4AY
	 u9VAM7j95cVVcoKQ4d9TQuL6Wjte3f/jQwyDHs+KV0l3v4URzjeBcXnLAdH7qgpEXE
	 cvgsgUwnW7No/C4OQKyQM0m3JYcDhHcPE86bal5MPOgLGuIfwpcPGKqY5CHSF/+nWg
	 2/Y8Y4sNplu6fWJsemsLQw6riZUsPwCe8/Za+JnLP8q4kNsQH3UN+hT9lz5gw8e3Yg
	 SgtRW3qxZ/PMeGPFFX+Vn4f+367FHgQJNBADIcuPXeCsJq0pvi9xhz3Zl9ba5Hwajd
	 nWQL86VDZMNtg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id BD03B60516; Fri,  5 Jun 2026 15:25:00 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net 0/2] net: mctp: usb: minor fixes for MCTP over USB
 transport driver
Date: Fri, 05 Jun 2026 15:24:13 +0800
Message-Id: <20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ15ImoC/yWMwQrCMBAFf6Xs2YU0NEX8FfFgkxeNYKy7SSmU/
 rtRjzMws5FCEpRO3UaCJWl65Qb9oSN/v+YbOIXGZI0dzWgcByz89GXmqhPLyoJ3RQXHIQbjYjj
 21lGrZ0FM6+98poxCl7/UOj3gy/dJ+/4BH2/t3YAAAAA=
X-Change-ID: 20260605-dev-mctp-usb-rx-requeue-f4fd05fd8125
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>
X-Mailer: b4 0.16-dev

This series adds a couple of fixes in the ndo_open / ndo_stop path for
the MCTP over USB transport, where we are incorrectly sequencing two
error cases.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
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

