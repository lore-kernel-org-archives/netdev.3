Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211176;
	b=4H61ZtDjHMmgUTrK3y0wUCKrjodd7TpngKt+qI/BQu6sg2N0GdWxuX4bdgVFQi0GHPPi
	 jBASCerjYmttrF7saVIEi9U3YJXY9IH23KtDLgbJnR/lokIVV86x51VM8eq/H9vS6WPFQ
	 l5JJ1b0LORElWF4PsLzISrCJ6k2RcAjhd2m6qEogEZ6V1jYXCnDZBZrOResiuFqCUXD2L
	 VB3F6BNRDIRYr0kWvqkmKVN7vVGRcIUhibHc1BPmZQvx8l6tKQ+ABVtV14ML6jqs2Srx7
	 +PBcEVlMSNKZJDZA6sgZtZmKkm2A1XjUZf2BFPgOKvfHPMZQ/UhCR0XI4oNCBqS78UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211176;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=RmF4p74GyJvTjJ+9yiITFE4p7uiV1l6aM7lFScVEBu4=;
	b=IBnQOkd3xf+c2C9OTVtbhUeYTJQZAcxx9xICx6/HykWYOIv1Z7FXm5XBq9a0KrFCLMoC
	 AQIRjy7iMu6GyP1PS0LDJCS3DtIdyHM6ql+UUycQCd+M40K2aUjbzHUjCPeawC2f5ZXB6
	 TBCQEhhpK8WJ98Y5hXkBYet1faiENphpCkL2BOs31gW7MiZM7XkUWPwvbAtetzAyrG3AV
	 nCNLSV2Zgw4Yp+8a5wTON9eny453aFw3CtENT246q27ivoxjqJDvqASJVOTGtRafYiUaT
	 fZT6VFqVDIODR0CnIOEkEBIWKIkSNPyDuOla1058nIn42ahn9MpGMncun6bGKkHggFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE2606A31C;
	Mon,  9 Nov 2026 07:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [123.116.51.226])
	by APP-01 (Coremail) with SMTP id qwCowACHdf9LffFq0NycAA--.589S2;
	Mon, 09 Nov 2026 15:59:08 +0800 (CST)
Message-ID: <ee3f414c-fffa-41e6-8bec-6af7ce676c4b@iscas.ac.cn>
Date: Mon, 9 Nov 2026 15:59:07 +0800
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
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
To: Ali Tariq <alitariq45892@gmail.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tomas Hlavacek
 <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
 <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
 <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowACHdf9LffFq0NycAA--.589S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kAF1fGFyDtr13ArWDArb_yoW8WrWUp3
	43KayYyayqva42vrsI9w4UKF1Utr12q3WkZr1kGa9YyF98KF1agrWUK34Fga4xCr1xCF47
	ZF4jgayxuayDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUnOyCJUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 11/8/26 15:19, Troy Mitchell wrote:

> On Sat Nov 7, 2026 at 5:32 PM GMT, Andrew Lunn wrote:
>> On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
>>>
>>> On 11/6/26 2:43 PM, Troy Mitchell wrote:
>>>> On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>>>>> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>>>>>   		return 0;
>>>>>   	}
>>>>> +	rtnl_lock();
>>>>>   	emac_stop(ndev);
>>>>> +	rtnl_unlock();
>>>>>   	clk_disable_unprepare(priv->bus_clk);
>>>>>   	netif_device_detach(ndev);
>>>> This can deadlock. emac_stop() -> emac_down() calls
>>>> cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
>>>> emac_tx_timeout_task() starts with rtnl_lock().
>>>>
>>> Thanks Troy, that makes sense.
>>>
>>> For the deadlock, I think the correct function to call is rtnl_trylock()
>>> inside the emac_tx_timeout_task(), which would return if the lock is already
>>> held and will hold the lock if it is not.
>> rtnl_trylock() is generally a workaround needed for badly written
>> code. Please try to avoid it.
> Agreed. If the reset is done in place, the work does not need RTNL at all,
> so .ndo_stop can keep cancel_work_sync() as is.
>
Thanks for the diagnosis and suggestions.

Although, maybe we could simply avoid cancel_work_sync() in emac_down()?
emac_tx_timeout_task() checks for !netif_running and does nothing if
already down so it should be safe. The task cancel_work_sync() in
emac_remove() does cleanup on unbind so the task is not leaked.

This seems to be the pattern in other drivers as well. What do you think?

Vivian "dramforever" Wang

