Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7EA415F12;
	Wed,  2 Sep 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341805; cv=none; b=PBdGCtr1mpunJW3mCqi7Henojk5Ax9oxo+qZaJFrsJEW3el/DEN1aGcb7MhQnifCAPga9Rldq9+w16/z2Z8ZFYrhvFHfHSkgTC7NaRTDE0ozopAMK5ho2isLYuxNRJVHeuLzco8Y9e4fCQQOI/GBNHlz6LFWGSg/vYnxeW2E6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341805; c=relaxed/simple;
	bh=IJsQPXCXr4tULo/Kr+T4U9PvR2F+Bxa4mJndpfFLahI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=e8VPsXxHFDS0CfFsTC/vjWlnLrLScnBcDM3vWTgGBdrx4/IN444pBFrJJM/GmwRzI16uLKc8husXns2CqD1tjTLvLMVhlEDJZmRuETbHsRb9t7R3BzImRHgd5C3QQUAmEDxDNDCKKk+gab7m0DkjiCBSJ3ibwuqbsIgQfGgxxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=QtaazmnA; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="QtaazmnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=hzdTECP9t5LIyo2E0vUpY/6gGoGRTkcWa
	WyhcWql2BM=; b=QtaazmnAxhXU/D+3vTe4Iqrcy59NbpGrCridhrapie5ranANx
	GpIlW1O4+bIIfg3LzkVcHvkn7sGxiwjlKzrsAKYEUa8aO3io/oewqDVG0fUWXKxv
	M+VpJQVB4WYmXiYIgVdXT1f67jom6H3BACYmGAsgKum50mlrGeCSsL1AwE=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwD3vwYL7pdqsC0AAA--.205S2;
	Wed, 02 Sep 2026 17:36:11 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: Add
 UltraRISC DP1000 compatible
From: Jia Wang <wangjia@ultrarisc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260901-press-buckwheat-92d17a6b8f71@spud>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-1-f19454814bcf@ultrarisc.com>
 <20260901-press-buckwheat-92d17a6b8f71@spud>
Date: Wed, 02 Sep 2026 17:35:59 +0800
Message-Id: <178834175975.2396555.15844573323623267538.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788341760; l=1199;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=IJsQPXCXr4tULo/Kr+T4U9PvR2F+Bxa4mJndpfFLahI=;
 b=FhRrP1spsli67vfelFfH5l5ReVYzalYwTUSaLAmXskj0j6X7q6LaTFqsaqbE8YWpo4WzfNtzq
 neSovR/+f44BUhgBp9xCxluV4qTzg79/jxc/XfExbnnJd9Dcz7kre9j
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwD3vwYL7pdqsC0AAA--.205S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4xGw15JFy7Ar45uFW3KFg_yoWkWFc_AF
	47C3WDAF4kWF1FqayDAF4xJFn8GrsxWF4kCws8Jr1DZ34Fy3yDGas3tryrZ3yfCF47uFn3
	Wrs3JryjyFnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRBuWLUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAREWqVJKMAYABGsf

On 2026-09-01 18:46 +0100, Conor Dooley wrote:
> On Tue, Sep 01, 2026 at 09:27:30AM +0800, Jia Wang wrote:
> > The UltraRISC DP1000 GMAC is based on a Synopsys DesignWare MAC.
> > 
> > Allow its SoC-specific compatible in the common DWMAC compatible list.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 2449311c6d28..2ed4564ae99d 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -119,6 +119,7 @@ properties:
> >          - starfive,jh7110-dwmac
> >          - tesla,fsd-ethqos
> >          - thead,th1520-gmac
> > +        - ultrarisc,dp1000-gmac
> 
> This should not be a standalone patch, rather merged with the other dt
> one.
> 

Thanks, I will squash this change into the DP1000-specific binding patch
in v2.

Best regards,
Jia Wang

> >  
> >    reg:
> >      minItems: 1
> > 
> > -- 
> > 2.34.1
> > 


