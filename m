Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295906;
	b=sQwGOqjJK4yTiRnk7l7Zmil4uyTXlCJa2XmF4/mrs94DwT+s8j945kWnqhyYmWAL7gC8
	 Cc2PEfiTHXQAVX+BsCwguR83mJkL5qUfpWbwuQfxVoKujDMZiUs4knxWzC7uCjgL2mT91
	 d9bQtgcKWDt7ffgYjSd59/Nqj3ExKrk3Q8MPzaBNE33w2akIjaK1Nb+ANul/n/KpqVEya
	 sQX6EG3xC+6HwD0JFdt6YpXuYwFGrgI9tFnqGHWeYMSn8N80KnZeE8lTfcLBMDaBRRcD7
	 MfqOK7d8vBffLz/tAEP4Vd5fShbEC0YLfXq7m8JiYtay3PiIp61jLvUKbi4yEL+6P1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295906;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n7wwb0uzmhfZxhSJHZrgJrb4K/zWUbcQx/RDNUytUQA=;
	b=W65C25rbJ6bu5lpGffPDBIXtDJaQIeeeUoWMsNrkE4qZ5lDQYXVig48I+th1+PbvDpMc
	 gmQ7yFyBWpi+7uBbY/nQEImexnAf8zkp+A/Xw2Ic8Nnhjf892kk2LuM8Xo/mc4gKACEzR
	 38H3mXFzFT9I9pUlAjGhwXFYcO6z79O0dJcFAMIc873nRv5eZKtexXmRmqfO5fbCbKaXc
	 m8Jua66EVMAseDPI+ivlprg+GRC2S0Lb5IDwWnDJr0y1JV+aozk5VtNEofzgEnUxjrxMa
	 W6AtmH3uDzKsWChPXFXhHvFOXyR0zwS8gYy8IqbCDJQsA5EUlJWcDJAs0NBsOCkgATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZEKGhX1A;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753C606A31C;
	Tue, 10 Nov 2026 07:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8753C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZEKGhX1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ZEKGhX1Avnq50VfJEKCf1mOb+GdCs5V1+zERw14z0wP9wjbMo79dnJKcLbdpAwX3+SkCrc03X05Op
	 HYPoWKIQceTWA+iCKDpHYf1Fs/I0+wkeRl2IAV/3bQGN7cbwPZvxj9mif9kt7S5nM6i2svQjH+5BAw
	 dhmsV4nzjc/nBs88=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af2c85e69f-d197c;
	Tue, 10 Nov 2026 15:31:43 +0800 (CST)
X-RM-TRANSID:2ee96af2c85e69f-d197c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af2c85c276-ac084;
	Tue, 10 Nov 2026 15:31:42 +0800 (CST)
X-RM-TRANSID:2ee26af2c85c276-ac084
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	jan.kiszka@siemens.com,
	diogo.ivo@siemens.com,
	haokexin@gmail.com,
	horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in prueth_probe()
Date: Tue, 10 Nov 2026 15:31:38 +0800
Message-ID: <20261110150500.3142-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <179429318364.488859.2256720144223130993@kernel.org>
References: <179429318364.488859.2256720144223130993@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find below the additional information requested for this
series. The same information was provided for the v1 postings of
patches 1 and 2 here:

https://lore.kernel.org/netdev/20261109093000.54321-laixiangwu@cmss.chinamobile.com/
https://lore.kernel.org/netdev/20261109093500.54322-laixiangwu@cmss.chinamobile.com/

How the issues were discovered: manual code inspection of the error
paths in prueth_probe() while auditing both ICSSG drivers for
probe-time resource leaks. The port scan issues addressed by
patches 3 and 4 were found in the same audit; the use of the
uninitialized reg value was also raised during the review of v1.

Whether the issues were actually triggered: no, they are purely
theoretical, all of them require a malformed device tree:

- Patches 1 and 2: the leak triggers only when the "ti,mii-g-rt" or
  "ti,mii-rt" syscon regmap lookup fails, which does not happen on
  a valid DT. probe() then fails with -ENODEV and the references
  taken on eth0_node/eth1_node are leaked silently; there is no
  stack trace or error message pointing at the leak itself.

- Patches 3 and 4: the uninitialized reg value is only used when a
  port node has no reg property, and a reference is only leaked for
  port nodes with a reg value outside 0/1 or with a duplicate reg
  value. On a valid DT (one port with reg 0 and one with reg 1) the
  loop behaves as before, with identical reference accounting for
  the accepted ports.

Hardware the change was tested on: none, the series was not tested
on real hardware. Patches 1 and 2 only re-route two error branches
to the existing put_cores label, which is already exercised by the
other failure paths in the same function (e.g. prueth_get_cores()
failures). Patches 3 and 4 move of_node_get() from an unconditional
call on every port child to the assignment points, so for ports
that are accepted the reference accounting is unchanged, and the
new error path only releases references it has just taken.

Best regards,
Xiangwu Lai


