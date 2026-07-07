Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263342A7B2;
	Tue,  7 Jul 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434565; cv=none; b=FXI4vEew0dI/JZ5T8xX9lgHu1+ukyC//LLoTyivG2MTYrcu0rrAU0Oqi+10gZTsdXf3Zm9KZU+In7lJbK5L2Xc4wPEFz0SJWjgonuxskk8ty/4bQs8HQAnUCryQJHwzlCVTSSZXPiabwIJU4ROZrjGJrWgAIvoVmq82PqLXiiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434565; c=relaxed/simple;
	bh=XCeUN31RRqvHjE8tsS/+R5plAJE6K3JyrDdgdl1SP2A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=foYHBTVsnSzSPLq+27GjZQ/NI5eS5l77eE5UG9stn0k+hLizrW0u0GswJU2AzbFGUnxYATyQKqkjo6DtOo6DwhA4r3NyonKr/oB5AG47teKmx4SHw0vnS078MVIUqRktyLsiPIZmtfxJZRog/3gwyawmvWajB8IFTI4dRvXE9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wh6aG-0000000089p-2Vgg;
	Tue, 07 Jul 2026 14:15:36 +0000
Date: Tue, 7 Jul 2026 16:15:20 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 0/3] net: dsa: mxl862xx: support firmware update
Message-ID: <ak0J-HgzMRea53om@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MaxLinear MxL862xx switches are running a ZephyrOS-based firmware
which is stored on a dedicated SPI flash chip connected to the switch IC.
When using the switch with DSA a method to allow the host to update the
firmware is needed.

DSA currently doesn't support devlink's flash_update method and
implementing the necessary teardown and subsequent re-probe is not
trivial.

This series is marked as RFC as I'd like to receive feedback regarding
the use of devlink and the teardown/re-probe implementation.

Daniel Golle (3):
  net: dsa: wire flash_update devlink callback to drivers
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  net: dsa: mxl862xx: add devlink flash_update and info_get

 drivers/net/dsa/mxl862xx/Makefile        |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 434 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  15 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |  42 +++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   2 +
 include/net/dsa.h                        |   3 +
 net/dsa/devlink.c                        |  13 +
 10 files changed, 516 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h

-- 
2.55.0
