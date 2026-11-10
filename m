Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301462;
	b=DbgQpCLgSgpDkIw6oG4sW75/mPYnVOkaD9pnJY95KkdxxjBaEqWJXfA+jM08qwl7QiYg
	 2Ly3Rjg7Lm677J/F+LP8eel/Qz/mxvIx/V57Id1OhyY2AdpBl4xv/AV3s+u9CTEkqKr08
	 dXS1ud1EaCqBDR1fp4ylnWJs0l1T2tq+n8Wd6PVp7C8SHvmLw9NU/g8JdIT3rgv+lN69n
	 7Lce3/Q9kV+ZSwItKa7svP+SVjCGte39lzV/nuhYoW1Aif6Gj5fdeyxpCH1gKq1TIg0/G
	 wcQ75Tf3knfzJ51URNGT2BmAHmVQGm6RORFtgFNeZx0Bmrb6MLLEtafi9QOzvsYuv2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301462;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=QjOWBD2wK9FWKJjffqgJNIwrhO5izEVXWqMljHBOgpY=;
	b=AIN8RvMo0O0B7MdAhRRnzEinjPimE0Kg6UcWEVeuV1X6hfjM+qqV791+arhjylBLVLi3
	 uNdFG94i9/dnpny3Uju7h97+KNTlop2SQDp3I43gTIf2XtJOMbHTAx+JLV5dGr7D9JiEi
	 kP8f+7jsTAPrgnWe6mHWIQ1xWy5NL+EqCYUmjUOHfDjrLXfYOCSCfvmPNjlm3VkN7uDYP
	 DvRqKhfstsZPGPZBRnwzq3/JMdLBREGUHqxGThbnFjipfIrLNElamoRwf5bxQvilAjdpY
	 nd/2h+WeiSPRllWL8CiaeleKw/EC/08TlTxuBGWdNqVYG3W4BqIfeYHkx1zZDE0SlwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776E606BA2F;
	Tue, 10 Nov 2026 09:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C776E606BA2F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAC34PoA3vJqGSuzAA--.1413S2;
	Tue, 10 Nov 2026 17:04:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
In-Reply-To: <20261109163715.GQ18859@horms.kernel.org>
References: <20261103102852.1340530-1-vulab@iscas.ac.cn>
 <20261109163715.GQ18859@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 09:03:52 -0000
Message-ID: <179430143289.3004751.18290661828922794973@iscas.ac.cn>
X-CM-TRANSID:qwCowAC34PoA3vJqGSuzAA--.1413S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFy8Xr1xtr1fWFWftryxXwb_yoW8Jr45pa
	9aqa15Kryvy3WxG3sFva1kJa47tF93JFy7Jrn8Gry7ArWDWr1kJF4S9w1q9a43Wr95G3y0
	qw47ua97ZF47WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUDdgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUHA2rylNU3RQABsy

Hi Simon,

Sorry for the slow follow-up on this patch, and thanks for reviewing it.

I checked a5f199a8d8a0 again. Before the conversion, a failure in
lan743x_ptp_open() went to close_phy. The conversion redirected that
failure to close_mac, while the RX and TX setup failure paths still
reach lan743x_phylink_disconnect(). I also agree about the NULL check.
Probe creates phylink before registering the netdev, and this error
path is reached only after lan743x_phylink_connect() succeeds.

I missed Chris Babroski's earlier patch, which covers the same failure
path by connecting and starting phylink after PTP and the rings are set
up:

https://lore.kernel.org/netdev/84c495b24206953fb799d4070c4d99ff27efb829.17920=
08404.git.cbabroski@nvidia.com/

Please drop my standalone patch. I also withdraw the stable backport
request for it.

To answer the discovery and testing questions, static analysis flagged
this error path as a candidate. We used DeepSeek and GPT-6.1 Sol to
assist with reviewing the candidate and preparing the fix. The finding
is based on source inspection. I did not reproduce the PTP initialization
failure or test the patch on real LAN743x hardware.

Thanks,
Wentao

