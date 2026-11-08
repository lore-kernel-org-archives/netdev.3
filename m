Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135637;
	b=N/G7YKdkVlgCMJLx4cyj9w5nt/bpiFCo35pk7y+FT5FiTuidqaRVW453EO8RFzPZvzzS
	 qCAZNH0AftKZiktZkdaCZk4IDacKAfm1OQp8jOMhECge1IZ7WhyRtgdIzLAfa5izMeCAc
	 3RNbi96FR+UzSNewAFMs2JPmqFbtwyJfnYZE2mAONZjfVUaURlVW50gxqy8N6k3W/TSOx
	 UsCK2yWEx1iu13ePDE8WKzhuYCnl2ZTVHBvj7jLxF0kfm6E66REBZcEVgbbzSG6a+mDwn
	 iib0lM3fWsJljfCWRDCROnYLNpBpG6F8T82EC6GOWtxBBcF1vPvb2PCgaw+Zhtz6TVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135637;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pODjinXN0rj0aSYFT9fDdahMqiSMTjVH/SuM/j01pGw=;
	b=QK8V02QcrEYpAb8zAtyFqk9XGplSSkKQaYhGjiap49qiMF9rOBdWOu8upG0nkJuPV8od
	 OaNO0oI3S/vdLugboKGCnZFEcr/PukSwAyczlcz9AsNxb728r+unI/IT0QMdRLcyvfbp6
	 dp5F8eZ9IKl33f9pWLJdqU19L0Qlm7MckZBzEzq0MPDBu4DvK1N+6PBFEGt19YYorKsDl
	 /BWXmkTSAc1Zk8Jx9Cu/MR/w68F/j1YsFMZf4/du79GgbVCkiytEeXPejLwkk+rcS0T/V
	 /wVEoZZRK9nFarxSaHaNvKWOTqYEOI0kszwbz2qX9LgdO/WX1rvlcHzFSZAgv7leTMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77032606D801;
	Sun,  8 Nov 2026 11:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77032606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABH4LVLVvBqs_OZAA--.18738S2;
	Sun, 08 Nov 2026 19:00:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, vulab@iscas.ac.cn
Subject: Re: [PATCH] net: stmmac: Fix MDIO node leak in stmmac_mdio_setup()
Date: Sun, 08 Nov 2026 11:02:05 +0000
Message-ID: <20261108110205.315002-1-vulab@iscas.ac.cn>
In-Reply-To: <20260921121120.GK13925@horms.kernel.org>
References: <20260917113945.2149361-1-vulab@iscas.ac.cn>
 <20260921121120.GK13925@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowABH4LVLVvBqs_OZAA--.18738S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxAqzxv26x
	kF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjUgAwUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMFA2rv4zKyZgAAsD

Hi Simon,

Sorry for the very late reply.

You are right that returning through a label keeps the cleanup in one
place, and makes it clear that the reference on plat->mdio_node is
dropped on this path as well. I have reworked the patch that way, and a
v2 follows in a separate mail, which also records how the issue was
found and how it was tested.

I am going through the remaining review comments one by one now, and I
will not send patches in bulk again.

Thanks,
Wentao

