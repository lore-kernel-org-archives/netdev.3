Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213460;
	b=gani+FA0xHMM894ieYPXAuWiv2e7jnKSABBNtuhT710W/DMH+A3x+2iGi1oGyuA4wpFW
	 7YgnH/OUL/V4vbA97sEyn9yKeg+cip2yqrer3a/aT6rxaPD5zrUQ5Ujw4UnPVChTUVAVV
	 M00KlCXp+7OPM98F7VJrF6Y7TDclIOVeqLCjfCAGM31FreLvTo9dUed5WX/bXlTI/cH37
	 hF24Dy5zKReIcLUI/xF92S19nNhzioHwo29ZvkrGRhHS6ryY+jbWgR6v62RXQ2Tgsks3q
	 y5ATESIwhDd4MQySaVOQCOMu8XH75CDCldeF6fR/5N2Ecchj39OJBscn9BUOg8I6phg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213460;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nC1Wszvh4Y9MkwTmdjUSmc1pvfFIw9wR53jTSHBM7fo=;
	b=rXMB3b90GuzoV0JAxwo4EctDe23zi2ADNaPqOk4q+C4yPWcfIpajvNUbxBDnCLpZ7M6v
	 +inllXkmF0nN7s4CCtpWdDQMUbSbTRBwHgx/9yxPrpN2M9GBA+cTaJc8GVyHWZCjYUa65
	 fNjAgBKh4tS0SMYZFGcXihrKZW/k8WhV87RW5XGLhkqBPStg3nTJZLd3QGDQDjKMWvT2w
	 PhLzuBgky7ehX2dbe8GOzDu0wCimjakwLSHSgZY0oLsxABmS7T333YLSdiNpf9p6z22yV
	 2hfQY+KfcwQgpa5QLN7bN9jng2Hdt65J9YulA6iQAaoL7hbn/O3Qvp3K3VmcBtISipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zLzYjUX5;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E700606A31C;
	Mon,  9 Nov 2026 08:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E700606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zLzYjUX5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=zLzYjUX5q2OAokroJ266wewJfAlZdbX8Yu8TWv+pWhkhAy0NaATWmXoq6ABRfIAcqU/BUjUsni+RX
	 3U+Ap6P8w9gqen79WBoA/fgS9MmlOTdDK6wAOYG4Bjrl5lZwoPjj0tmKEQk2ZrREqRBsaTFnFwOYBs
	 xwqdMiiGPwh0thZI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af18636a24-c4277;
	Mon, 09 Nov 2026 16:37:13 +0800 (CST)
X-RM-TRANSID:2ee76af18636a24-c4277
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af18637b98-8865f;
	Mon, 09 Nov 2026 16:37:13 +0800 (CST)
X-RM-TRANSID:2eea6af18637b98-8865f
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Haokexin <haokexin@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()
Date: Mon,  9 Nov 2026 16:37:09 +0800
Message-ID: <20261109093500.54322-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <179335102798.3327.13730382084781364050@kernel.org>
References: <179335102798.3327.13730382084781364050@kernel.org>
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

Please find below the additional information netdev-bot requested
for this series.

How the issue was discovered: manual code inspection of the error
paths in prueth_probe() while auditing the SR1.0 driver for
probe-time resource leaks.

Whether the issue was actually triggered: no, it is purely
theoretical. The affected branches only run when the "ti,mii-g-rt"
or "ti,mii-rt" syscon regmap lookup fails, which happens only with a
malformed or incomplete device tree. On a valid DT these branches
are never taken. When they are, probe() fails with -ENODEV and the
of_node_get() references taken on eth0_node/eth1_node earlier in
the function are leaked silently; there is no stack trace or error
message pointing at the leak itself.

Hardware the change was tested on: none, it was not tested on real
hardware. The change only re-routes two error branches to the
existing put_cores label, which is already exercised by the other
failure paths in the same function (e.g. prueth_get_cores()
failures), so no new cleanup code is introduced.

Regarding the Sashiko finding: the same leak in the non-SR1 variant
of the driver (icssg_prueth.c) is real, and it is fixed by a
companion patch submitted at the same time as this one:

https://lore.kernel.org/netdev/20261030085651.1944-1-laixiangwu@cmss.chinamobile.com/

Best regards,
Xiangwu Lai


