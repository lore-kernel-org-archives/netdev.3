Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609643;
	b=IWKBMD1tv1G965tJAZpgdBAR8ZATNpiGfVoAHaOB/3nw3hw8X1Gtp4ozGJlcC/qdFBiH
	 JpIHK5Ca+eFuD4BV4VFe62q6OFq3rBjplizzX3KWyLeg+V2CjGUFSLWbDa8wdw3shnq+7
	 5+8pPzDyMlUfcjQjKDBMInp4y5DxTGPTgETARtGVVwOXXg8H/ry3xROOCGWBUxQ2qciy6
	 DxP2hI8E+nV9iV3A4VbisEY7CyoGiozeUwihB8EXzgFSSgtu+glqgJKTNFdMrL4r7jiK6
	 GH03tHM0tToCIdvBM1ndTk9WhXQzIoRawpAopZWNPq9PRNSgW2BEgzEBSmNsi5TzY1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dyRe6cqepbH4BcsD+uq9N3zywhn9zMc3JHjIGWA0DU0=;
	b=YPB092JCk8C37sdterQnY0dga5UrDWrEp058d0RBIJeCr2wuSzxgN0LoMyzFuv4SL4Pv
	 6uDgxC6EgY4O8mG9Rq8qiyiKCi0c07ksTY5vbalL//+vw3z73Reb/YoCSpYAQUQKduo12
	 uqNmvwl+3IbjGrPS4eqDnF9gAFJSOaSTgkG9v5UBoDbjLH6BPC/oSBOuSA+OBBmOF+pRq
	 UcTNqzhdF0+JbGM7BmgYHmYsiZy6APoPzIizd1IN2pnRbDWTtEQoJdQFevK1kh9ZhShvV
	 gdYpjrBYCRExtqx6nPviCf++9kiN8gTI2b1cTrnjzBoQspdohT1ePFGUoWTzsJJoWrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=0RkAH+tp;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C6606A326;
	Mon,  2 Nov 2026 08:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=0RkAH+tp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1793609642;
	bh=dyRe6cqepbH4BcsD+uq9N3zywhn9zMc3JHjIGWA0DU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=0RkAH+tpk7+TZYfWtxox4JK5uKvPDOp9pMo7DdjLQgqRgwbhm7LoxVdURc1Ub4a77
	 byyAEWm3Xopg/G0njAmcgh8TI1gK4IfpGy1sEeB+T3Bvq2Oc6AyNBGk3lz7U74eU+r
	 yEsFzazmpjpKbkV3PjH7FXdyCWwrIRtZVodZa0Q2CHxighPM+Uc1WZstH19LmM4Q7A
	 84gxd+L7t17IQuxvTX4tMQklTtdXxEn1mJwpdXR29Uh2i88h9VFlZqVkuGQioZuG3y
	 d2zaPvzQ5RmOjbbMwxEIFPipaIbOICLAdGQmSfilBjp0Vtq+iJxvUkyPK3Ie+/oxUz
	 oVf73D2YvAEQg==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 521EC819B6; Mon,  2 Nov 2026 08:54:02 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Yao Zi <me@ziyao.cc>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: mask the MISC interrupt
Date: Mon,  2 Nov 2026 05:53:03 -0300
Message-ID: <20261102085303.5391-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20d4a3c3-99fa-4659-8d5d-eb5eefcf6545@bootlin.com>
References: <20261102080938.2955-1-magnusleatti@kernelriot.com> <20d4a3c3-99fa-4659-8d5d-eb5eefcf6545@bootlin.com>
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

On 11/2/26 09:22, Maxime Chevallier wrote:
> Can you test this, sent a few days ago ? I also saw that storm, but it didn't
> seem to be motorcomm specific :

Thanks, I missed it. It fixes the hang here with MISC left unmasked,
so masking is not needed. I replied with a Tested-by on your thread.

Please drop this patch.

For context, I ran into the hang while benchmarking the glue for a few
patches I plan to send once net-next opens, among them Wake-on-LAN from
S5, which does not work on this board today.
