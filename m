Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606043;
	b=JLGENgUdkREUieW+7JktxeVU6W4guTjWmw7GG1ATTQ+Lnr4o/ZW7M9TDtwbMgRdNi2HR
	 4Bs5k8gwmFKK0/WVP9Z/LvRtWZ9m3rxeP+ZIuBYKYgR2m4JlK0COLR7xwXc8lLTaax4l/
	 Mij1UTcK5+kjQXoywKKLg1xO71KLmPgH0a5thfRslQttqVI+Vyerhal3rnRFoldziq9Qi
	 ZFZUbnhSI+QLFatw4f50dr+9cnot7jRZwXR/rqVhsVhHjULiP0G4U95qV99kMj1+rT1iz
	 sASBUshzuiAGltp5JEdurhLUvMh9f0F6nr4Ax/lpBq4S99DUlxLL3SBHlsiarYbM36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606043;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=F5vBY1gPtD652vCrxBwVeVr/LompxEXIerO1EpMdQsE=;
	b=4FqkV2z4+aoN7vf2yyW5jsDTjjeZkM8t2Jool2wFJ7HsQFjdPWUWgEln1TwD3Ajb/SbU
	 jzcq1GUqZFpV0SVmNxaejVm8O0YzAKuWqiJrnfIWDiua3wQaqdzUBBlqN5u30rsMEiUFJ
	 RiiqqjZHDLyy8yxuYGCVn/LhCdqKuHQDLZN9l9mSor0C+gNhOoEIobMx9V7xSwTQduZN1
	 Bw5i+16bn/UykCKuIVCySdtq1amqcMkBXfa7HD/DABForm5HYFSr4ZdR+HUIpxw1O1DGs
	 nA+5vpq9cV+HkpNEd91RUcznGtml6mG1oq0L9+l31xYLfH78aROTjLUEmjUQHye2ZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E60606A336;
	Fri, 13 Nov 2026 21:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E60606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [123.116.51.226])
	by APP-03 (Coremail) with SMTP id rQCowAD3yZq4g_dqwtv5AA--.12651S2;
	Sat, 14 Nov 2026 05:40:10 +0800 (CST)
Message-ID: <0b6a04d7-d15d-4362-8e75-4f7120b277cd@iscas.ac.cn>
Date: Sat, 14 Nov 2026 05:40:09 +0800
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
Subject: Re: [PATCH net v2 0/2] net: spacemit: Fix TX timeout work deadlock
 and RTNL in PM callbacks
To: Ali Tariq <alitariq45892@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 Tomas Hlavacek <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, leitao@debian.org
References: <20261113132435.434615-1-alitariq45892@gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20261113132435.434615-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAD3yZq4g_dqwtv5AA--.12651S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1fJr4fKry3Cw15Ar1UJrb_yoW8XFyrpa
	yag390kw40gr4Ivr42vFs2yF18Cw4xt3yUJrsagrWrZ3ZxuF1xCry2gw15Xr17ur1fJryj
	vFWjya18GFWqvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU30PfDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 11/13/26 21:24, Ali Tariq wrote:
> This series fixes two locking problems in the SpacemiT K1 Ethernet
> driver.
>
> Patch 1 fixes the TX timeout work, which ends up waiting for itself
> through cancel_work_sync() in emac_down(), so every TX timeout leaves
> RTNL held forever.
>
> Patch 2 takes RTNL in emac_suspend() and emac_resume(), which fixes the
> "suspicious RCU usage" warning from phy_disconnect() on suspend. It
> depends on patch 1: suspend disables the TX timeout work before taking
> RTNL, so it never waits for the work while holding the lock.
>
> Tested on Orange Pi RV2 (SpacemiT K1) with a lockdep kernel: 12
> suspend/resume cycles without the warning. The board loses its network
> after about a dozen cycles with or without this series; that is a
> separate issue.
>
> Changes in v2:
> - New patch 1 to fix the TX timeout work deadlock (reported by Troy,
>   approach suggested by Vivian)
> - Patch 2: take RTNL before the netif_running() checks
> - Patch 2: drop Breno's Reviewed-by, since the patch changed
>
> v1: https://lore.kernel.org/netdev/20261105123441.2524171-1-alitariq45892@gmail.com/
>
> Ali Tariq (2):
>   net: spacemit: Fix TX timeout work deadlocking on itself
>   net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()
>
>  drivers/net/ethernet/spacemit/k1_emac.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Much appreciated. This series is:

Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>

Thanks,
Vivian "dramforever" Wang

