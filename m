Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D32D238A;
	Wed, 28 Jan 2026 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569708; cv=none; b=qdbsGMtHm6SGT1Bbe9hGbruCbI6uZk9VxjyJe3fbtLshLsMqXAyyjSqDlqdU+5LsgZ/KWgJqAybspitu34iPdKxSDuIthJudi06r88ebjk35dVEon+ER9abyvVyxdG1lMZvf1dwMVammpU35lBtudcXTMKexIWqF5DfMdO7xi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569708; c=relaxed/simple;
	bh=efAM1MyZfelBoM/Wl0wv9C48hXEXhh1GmBmJr0Fb75E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5EiJ0IHEoBqf3MvpDUxEJ14HPDtmnM682arKHpbempwNEEqOsPwkdYtDhlYNnRE0DP+0eiUoxRnrgGUhqAm8UgkHfAYM21vu+f942pmVAdYG6pdy6gWaeyAFQGzOXQnAYoj7wCX49o/belVrNY9WH32wqA250gVAsAZn+j6+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [123.118.222.47])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sw+bfXlpAQvXBg--.33087S2;
	Wed, 28 Jan 2026 11:08:12 +0800 (CST)
Message-ID: <dc31ca81-1854-41ba-a448-718ba1f781da@iscas.ac.cn>
Date: Wed, 28 Jan 2026 11:08:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: spacemit: k1-emac: program frame size
 registers for jumbo frames
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tomas Hlavacek <tmshlvck@gmail.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Yixun Lan <dlan@kernel.org>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
 <20260126171449.83288-1-tmshlvck@gmail.com>
 <9f424b4e-b83b-47a0-8637-3df25e504be7@iscas.ac.cn>
 <20260127172401.4bb7bd83@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260127172401.4bb7bd83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAC3Sw+bfXlpAQvXBg--.33087S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY67k0a2IF6FyUM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF
	7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43Mx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fwIDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 1/28/26 09:24, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 12:58:21 +0800 Vivian Wang wrote:
>> Oh and... maybe these should be priv->ndev->mtu + ETH_HLEN + ETH_FCS_LEN?
> + 2 * VLAN_HLEN perhaps?

... yeah looks like I've simply messed up the whole MTU and max frame
size configuration thing.

* Tomas: Do you still want to deal with all this and figure out all the
MTU stuff that needs to be fixed? I can give it a go but I don't want to
steal your credit.

Regards,
Vivian "dramforever" Wang


