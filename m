Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30139183C;
	Fri, 18 Sep 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715465; cv=pass; b=H4wwUSonxlxgAUkvodYEZuxc6WulEAadA8KrgRKxa5ZrPNrr+fsJ1fHlda5KyxJsdws/ssap0G+1dJBwTjW1vCK0gTAwq87VwXY8hE/tFj4MmRys3iRCdtZZBsv+fodmrh2xiU6RVoY5ORFXBcLLi3MMauY6GA8UbY1471o/nQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715465; c=relaxed/simple;
	bh=7U/kCA4miHLz0xj4Cu7jK4fk8l32fkZpHR/AcjmKD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URBW6P+QLmoaPyxA2piE40t8Zq+4BbtTwSRMcjmww/SRC1FVmoTNtVo6BBIAyJnBTwvmHEIaKaupQLWaLuHiSIra16yQqkNcKRsyUyAPcfWmCntRa+X7+FKWxAVujjkh8SvOUeFveduPIe1hF9QEU1GqTa8zoFRgmNZN8ewZpKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=WDfK1ije; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="WDfK1ije"
ARC-Seal: i=1; a=rsa-sha256; t=1789715440; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YVuKyn9COxc51SGwpyuncb2W6iNif1OXFlrIfpjEPLhQoE67LOVmNy7iWmKGmzc/mbgRca3f/LhEsqFNKxUstt9Hb36SjtDxUhGGPfuN4PI1cvFIjGEGwISz9x4QYSrPT8173f3xA573M3R1Spx4GdwSd+2wPoopEF1mR+vK+tc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789715440; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bSGtsz29021YzshFZsgFv4CE1vnziRI1M9Rzcu5F50=; 
	b=jSlUKChQ9afYK/5Kf1amEHHSmdTIzm+canKvosPpiqbTDbP0UsaeV4BRLQHwLD/g5YWd/3PDcSrFMNTd7RlSHPO9kUaCF2zLZ5mrNirLD8rnpeH+RqUbEQd/swhD5QH8KM8dD9tdFz5IiOZz3q7dPbyhd1ymljTv5Wws/M2V+x8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789715440;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=7bSGtsz29021YzshFZsgFv4CE1vnziRI1M9Rzcu5F50=;
	b=WDfK1ijeGV61VCWAGM0MX3bB//3TCE7xkJQUu10vHKAai6zMd0Jz2W1eLMya+8TI
	E+VWJoSZCt5WoTG1DUPh/OETSR+GmKhPdsFagcVHFKJiOhAPMhP9dLQIyP5+zborDxK
	3+xBZCmDMdui3+y7hMaVCMTvci5NXuaO9yqTv1sc=
Received: by smtp.zohomail.com with SMTPS id 1789715438115870.2652817308559;
	Fri, 18 Sep 2026 00:10:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:10:32 +0000
From: Yao Zi <me@ziyao.cc>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <me@ziyao.cc>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
Message-ID: <aqzj6CV_xl63JFeT@pie>
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
 <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
 <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>
 <a10c8361-648e-476b-8b04-8716ad274fc4@lunn.ch>
 <36a43b65-f94e-4836-b511-715fb136c10d@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a43b65-f94e-4836-b511-715fb136c10d@loongson.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.708.20
X-ZohoMailClient: External

On Fri, Sep 18, 2026 at 02:48:45PM +0800, Tiezhu Yang wrote:
> On 2026/9/17 下午10:45, Andrew Lunn wrote:
> > > Before moving forward, I'd like to share an alternative thought.
> > > As noted in the earlier review, this network controller could be
> > > used across multiple architectures. To avoid the redundant churn
> > > in the defconfigs of every single architecture, I am wondering if
> > > we could unconditionally set it to default m in the Kconfig instead.
> > 
> > ~/linux/drivers/net/ethernet/stmicro/stmmac$ grep default Kconfig
> > 	default n
> > 	default y
> > 	default STMMAC_PLATFORM
> > 	default ARC
> > 	default MACH_INGENIC
> > 	default ARCH_QCOM
> > 	default ARCH_LPC18XX
> > 	default ARCH_MESON
> > 	default ARCH_MA35
> > 	default ARCH_QCOM
> > 	default ARCH_RENESAS
> > 	default ARCH_ROCKCHIP
> > 	default ARCH_RZN1
> > 	default ARCH_S32
> > 	default ARCH_INTEL_SOCFPGA
> > 	default m if ARCH_SOPHGO
> > 	default m if ARCH_SPACEMIT
> > 	default m if ARCH_STARFIVE
> > 	default ARCH_STI
> > 	default ARCH_STM32
> > 	default ARCH_SUNXI
> > 	default ARCH_SUNXI
> > 	default ARCH_SUNXI
> > 	default ARCH_MXC
> > 	default MACH_LOONGSON32
> > 	default ARCH_VISCONTI
> > 	default X86
> > 	default MACH_LOONGSON64
> > 
> > No other glue driver does this. Why is this one special?
> 
> If it is not proper to change Kconfig,
> I am fine to modify the arch-specific defconfig instead.

I'm against both of the ideas. From the aspect of a distribution
maintainer, there are too many stuff missing from architecture
defconfigs, so only enabling one or two drivers by default doesn't even
improve the situation much, costs (kernel) maintainers' time.

From the aspect of a kernel developer, a bloated defconfig/default only
further lengthen the compilation process, forcing ones that don't have a
good enough machine to spend more time on turning off one and another
options their platforms don't need.

> But by the way, I noticed that there are the following code:
> 
> $ grep -rnw "default m" drivers/net/ethernet/
> drivers/net/ethernet/stmicro/stmmac/Kconfig:221:	default m if ARCH_SOPHGO
> drivers/net/ethernet/stmicro/stmmac/Kconfig:233:	default m if ARCH_SPACEMIT
> drivers/net/ethernet/stmicro/stmmac/Kconfig:245:	default m if ARCH_STARFIVE
> drivers/net/ethernet/spacemit/Kconfig:21:	default m if ARCH_SPACEMIT
> drivers/net/ethernet/marvell/octeontx2/Kconfig:54:	default m
> drivers/net/ethernet/hisilicon/Kconfig:106:	default m
> drivers/net/ethernet/hisilicon/Kconfig:134:	default m
> drivers/net/ethernet/sun/Kconfig:77:	default m
> drivers/net/ethernet/sun/Kconfig:81:	default m
> drivers/net/ethernet/sun/Kconfig:89:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:37:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:47:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:67:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:86:	default m
> 
> Thanks,
> Tiezhu
> 

Best regards,
Yao Zi
