Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559139;
	b=Wox6Fc0656UnltiSeqB1z7JU82TSQK5x1IwaofZRz7kVnbIKDjkYRqHOLl8gpMXER/GT
	 DDTomFtd44pKzO047VR1nP6YaW+JSby/SlaeiUZttFBVsvxmIhf4vgIQBZ5OR5hkj8Pp+
	 vQAqACBWtWVwsR30KMymGfHcGvfTqLKx3YPqWzmaqi0jnkv9IEdgMOk7JsyBlq0Ii1Hrh
	 PIZ106VPHlZqJhk/iNCp31bdGjJkFicxBgTy4ZiMG4hOgWzBOpmckxe7NS8A71VvbK9wH
	 mgwcRDHpSfQTbboW2tbRpU+S4aHu9LiumkodUQa9o2lRjYJGXi5+iKFig5nfq71STqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559139;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=8t4QuEM/UAFTQif1padG43+4xJsVO798G1x6veCOSgw=;
	b=XsqqhDxNqcc20XuU2noZ0mFUZA53bjpoXDh7PHXQwMKGmomDHA07izykyMOoKrNFSxSu
	 PL38Nocq+MYeRmN9mYrNuqPvuQV/t3ilfaOvEA9wCpMBaB4dIm4B3Q4OYKp3Dn8IqOLkn
	 jRL/owTDBOHUVP/07dLltQROfjmEp+akeQgr22xiA9OcU6s6/LFuTd4Cvb8G+n0W463j5
	 sb3hNcM09UzlOITgpubu5W9k5PeCrz/tPGsF5uqI58tMG8h4PCY14cRWT5/d0XwKelSth
	 jE6cuu10K6iKNxEud2HhhLIyLKeDldrKkj1frhdyJdl0VR2Hs5aXp0FMGiHgjxKsMbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IhrZGzHH;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6E606A31C;
	Fri, 13 Nov 2026 08:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IhrZGzHH
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 893454E415A4;
	Fri, 13 Nov 2026 08:38:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 339D9601D5;
	Fri, 13 Nov 2026 08:38:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4206B11BC06F0;
	Fri, 13 Nov 2026 09:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794559134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8t4QuEM/UAFTQif1padG43+4xJsVO798G1x6veCOSgw=;
	b=IhrZGzHHEal3ZdOVMwhzsvbm5iuwEnp5xHC0dulEJ8kc2vnVnVCp+mqGoO1a8XACcjFo3L
	CemyoCGSjPFSqj+xVQN1dhltZ0iVnQmkCOSBvXU15Dmbd2Ahmr83mLPMw8X+qgICiJrJrp
	SjwpXfrk0UcG4L72AZvp4eSvVUTv7Ve1b/Nd6cfIkkTIyTnqxwY1wg/q+RN66hpFjGpzXa
	nK3gkzC44IvPJpC97sGgzIcepYInwd3pCKGgdYMEZqPIcGqMsC1oOfuloeDHhED46S3COf
	CUuazr2dgS4G//37WSqK+pD/JNz35R1ayU9FGStfzCq/CZMKpQ3u3/D+P6Wh6Q==
Message-ID: <85370a77-e2ef-4eae-96f0-7f591625f47d@bootlin.com>
Date: Fri, 13 Nov 2026 09:38:41 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: rockchip-dwmac: Add
 RK3572
To: 1579567540@qq.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 David Wu <david.wu@rock-chips.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
 <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/11/26 10:56, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> Add the rockchip,rk3572-gmac compatible with the snps,dwmac-4.20a
> fallback and require rockchip,php-grf.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
> Changes in v2:
> - Add RK3572 to the shared Synopsys compatible list for consistency.

This doesn't address Andrew's request to deprecate the tx_delay and
rx_delay properties for that new SoC. Even if the board you're using
doesn't need them, we need to make sure new designs will use the
generic properties for RGMII delays :)

The older rockchip glues have no choice but to keep accepting these for
compat reasons.

Maxime

pw-bot: cr
