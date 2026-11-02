Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609223;
	b=FPSt6cRMtxmBjiSq8pysdZFN4mTBKhBpRDtDBPsFtJFA+u034v77F8Vomy0AQ+FtUlwg
	 jN4Q0jD8ifDq7NQEmu4XhM9Cnn39tpDaqO6m6nZzSZ6g8DjgfMtqk9/ajUP9gp4vegadt
	 5dFUkc7ZFha5weVpIjc7IN4s4S0VPZppqFEovg11JBLULOhnK9rRwjeOzuok3DOIB+pjF
	 3HhC7dBE23NAi66ToCDiOXvH7bgYWhtfFaZNMhcTFsiV/xUjMliwqsRxZdy6Mcn8Pg+Sv
	 73ahRNh9/67GII4XAIUP2mxxGauNLNihRhGNewyMhfnz3iw99yM9mq/1H2e191Z6f1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609223;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yuiWaWQDrq0Vg9DrcjhhGqt3JHN8TGxGS0CrvgppQHM=;
	b=h3d6LY7sW6/fUyC99LihgX5IhUvkFNooFa+l2cLjt3Mmz0r26DTIT2iulAjcHass9T7m
	 yHMLXYUKUXEguu/XuuKc7sNJ2LNCcdjmjyS3GuG05YtE8+hn19+NnQiOkKUzrA8QxqF8v
	 Lv53qoHYWHtYSLAqgtOJ/TUPaFzdWXTAhrF1+CKMJv/6IcEJSqnZw8wSE9jC+CAzlp5WP
	 TKuCgm6nKvd7mXOCTqskQ0EsTsXAwi/dWB4S9O0LgE6mvGXopUBPH7D6vjkKz1s6ELaIg
	 0wvG2NVOm3l8UcK6XfNlXnkXELeLlPODucEyZ+xsUGQ1PNRh5ydBXqeMKqrisO6xdqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=Z1HGC3Hk;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C243606A324;
	Mon,  2 Nov 2026 08:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C243606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=Z1HGC3Hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1793609222;
	bh=yuiWaWQDrq0Vg9DrcjhhGqt3JHN8TGxGS0CrvgppQHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=Z1HGC3HkR8D00Uh0FiLWurch+GQd10bwl2o2HDqhQXQmKVZsWi2pnIo94j6nTnyWI
	 TePKg9UI0on9soMqJYZ2ICUTB36Ii7//aTV+5o5DRK54lTOlYvhqAfbIgo9+RlVUUh
	 vXMW9ff3cdv1Jb8B1C8oAJw0+AFj+IvCiYR6Zra9xCqFH+Im3iei2uXeYIlafn+hz5
	 7/xaJcTPgVCNaaUzNFGJxOQL540GjMq2Xol/1KYHRCGo4Z6ovG5ogoLfPVpTQArYAg
	 tSDTMGktKaG+xIgwD+RxTVMYCExwE6jmkcCKDjFhRBN3r0PjsfvpyY0xO+mXfMnIvX
	 5lWwKAUA9c+OA==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 22D0F81455; Mon,  2 Nov 2026 08:47:02 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	thomas.petazzoni@bootlin.com,
	alexis.lothore@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: Clear DMA errors for multi-channel interrupts
Date: Mon,  2 Nov 2026 05:45:58 -0300
Message-ID: <20261102084558.5105-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
References: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
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

On 10/30/26 11:22, Maxime Chevallier wrote:
> The Multi-MSI interrupt handler doesn't clear the DMA error interrupts,
> and this leads to interrupt storms when one of these interrupts starts
> firing :

Tested on a YT6801 (dwmac-motorcomm) with net at cb284914e749 and the
glue unmodified. Without this patch, a 64-byte UDP flood
(iperf3 -u -b 0 -l 64 -R -P 4) hangs the machine. On this board the
stuck RBU also keeps the MISC bit in MGMT_INT_CTRL0 set, so vector 5
fires about 120k times per second. With the patch, the MAC interrupt
only fires while the flood runs, about 1k/s, and stops afterwards;
same with eight streams plus a TX flood for 30 s. Throughput is
the same.

Tested-by: Magnus Leatti <magnusleatti@kernelriot.com>

nit: "YT8601" in the commit message should be YT6801.
