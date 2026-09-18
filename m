Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63036492E5D;
	Fri, 18 Sep 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714147; cv=none; b=UDacV62r7N+37JfrWsFO5xNksIpmhnRB6d6tl4xg4w1stuM6lzDR1WeyWqp/RMF2sR46jMFDh4bq9ah1tSwAGz77y+3K0ZltvVPdqfaDljBiyntcc7woWFxjFMBn0+k/NLR8ATWjc0gmZQdDrTB42x6EqNZOQ8sh1v3J9DfUoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714147; c=relaxed/simple;
	bh=i890Ourl1qcXzdz90Xayde2jMF+U6S8vloI9S8dbH5M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Tfxi8BRSVdNB01ZCi+ZWqEIgTmxf6qhHch2zfTRXjzVcrUdYSsi3tMrplOYVxNneDlkZIB+QZffpWeAbJNxbi2OBZC1Lb0/IKC6wKVgEt6EWmUw8BPiiHutswrCp2ikcjegf5YukaZ5r6XyhNNZnJ+FELoauTJy4hS6opKEHNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxXdLO3qxqa1QNAA--.39122S3;
	Fri, 18 Sep 2026 14:48:46 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7N3qxqmB8iAA--.7665S2;
	Fri, 18 Sep 2026 14:48:45 +0800 (CST)
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yao Zi <me@ziyao.cc>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
 <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
 <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>
 <a10c8361-648e-476b-8b04-8716ad274fc4@lunn.ch>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <36a43b65-f94e-4836-b511-715fb136c10d@loongson.cn>
Date: Fri, 18 Sep 2026 14:48:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a10c8361-648e-476b-8b04-8716ad274fc4@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c7N3qxqmB8iAA--.7665S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw48ZF1rAF4xZry5tFykCrX_yoW8KryDpr
	45Ja48u3WIgF15G3WfZ348Cr98Jan7trW5Cr1xtw45X39Fk34DAw4ktF1xGr1jkFZrJF12
	vr18uw12vFn0qwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==

On 2026/9/17 下午10:45, Andrew Lunn wrote:
>> Before moving forward, I'd like to share an alternative thought.
>> As noted in the earlier review, this network controller could be
>> used across multiple architectures. To avoid the redundant churn
>> in the defconfigs of every single architecture, I am wondering if
>> we could unconditionally set it to default m in the Kconfig instead.
> 
> ~/linux/drivers/net/ethernet/stmicro/stmmac$ grep default Kconfig
> 	default n
> 	default y
> 	default STMMAC_PLATFORM
> 	default ARC
> 	default MACH_INGENIC
> 	default ARCH_QCOM
> 	default ARCH_LPC18XX
> 	default ARCH_MESON
> 	default ARCH_MA35
> 	default ARCH_QCOM
> 	default ARCH_RENESAS
> 	default ARCH_ROCKCHIP
> 	default ARCH_RZN1
> 	default ARCH_S32
> 	default ARCH_INTEL_SOCFPGA
> 	default m if ARCH_SOPHGO
> 	default m if ARCH_SPACEMIT
> 	default m if ARCH_STARFIVE
> 	default ARCH_STI
> 	default ARCH_STM32
> 	default ARCH_SUNXI
> 	default ARCH_SUNXI
> 	default ARCH_SUNXI
> 	default ARCH_MXC
> 	default MACH_LOONGSON32
> 	default ARCH_VISCONTI
> 	default X86
> 	default MACH_LOONGSON64
> 
> No other glue driver does this. Why is this one special?

If it is not proper to change Kconfig,
I am fine to modify the arch-specific defconfig instead.

But by the way, I noticed that there are the following code:

$ grep -rnw "default m" drivers/net/ethernet/
drivers/net/ethernet/stmicro/stmmac/Kconfig:221:	default m if ARCH_SOPHGO
drivers/net/ethernet/stmicro/stmmac/Kconfig:233:	default m if ARCH_SPACEMIT
drivers/net/ethernet/stmicro/stmmac/Kconfig:245:	default m if ARCH_STARFIVE
drivers/net/ethernet/spacemit/Kconfig:21:	default m if ARCH_SPACEMIT
drivers/net/ethernet/marvell/octeontx2/Kconfig:54:	default m
drivers/net/ethernet/hisilicon/Kconfig:106:	default m
drivers/net/ethernet/hisilicon/Kconfig:134:	default m
drivers/net/ethernet/sun/Kconfig:77:	default m
drivers/net/ethernet/sun/Kconfig:81:	default m
drivers/net/ethernet/sun/Kconfig:89:	default m
drivers/net/ethernet/mellanox/mlxsw/Kconfig:37:	default m
drivers/net/ethernet/mellanox/mlxsw/Kconfig:47:	default m
drivers/net/ethernet/mellanox/mlxsw/Kconfig:67:	default m
drivers/net/ethernet/mellanox/mlxsw/Kconfig:86:	default m

Thanks,
Tiezhu

