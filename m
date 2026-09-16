Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AB53ECF3;
	Wed, 16 Sep 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577422; cv=pass; b=nZlgX4emxhusYWPGYieGXdFNr3cwYyLqNhYy0bewUbwaOHIEnftquv/qXDcvtCMIFHysxZCGJFDP4UY8KXa5Tnc6L8O0rY9B/fmXWZ6OIYodOmpRFQehlmq+xX9JdRgVYyzN+3ADkpnyLjh20q/jiCG3zXqtbX8LU13Tyu45dxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577422; c=relaxed/simple;
	bh=i6EC5vxuX0/Lxjjt2b5P3iBKqz8EIqc8iGLZKY6JBmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4F9WxfExVFFJFrTMSMlcWCE/qDnvNEIp8IF/l9am1JOCu99zvu2+Ps5oGov1S2vHzsnu5/oPnfGEbMhHBLy9Lta7FxWOVsgXDkEo5ZAjeGkMSQXB4Z1evOO/jsBhmJ2N1uroGuGzSUAvP9FfO9xV9YakBIJa9NGyVsIpnQU9uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=ftYpPvZl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="ftYpPvZl"
ARC-Seal: i=1; a=rsa-sha256; t=1789577385; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KoyqZmpQCx0XRpo2HCQbhbIU70ZPCCqaK/vaJSyFpnkAzWwvNw08dpnAiItFh1sMQBsgSzfE1iI/3U5gsKyRUZTtezTF7NF+pvAkBrz7zf85uNhtjseOAdlvQZC24776U0NklesxCprcMrjDMdVdqp+WnFbTAm/GdmPjFgwJLb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789577385; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lCywjmCCkpLsZJq2VCSfSNRtbFNx8PVHX0fH2Mpr6lg=; 
	b=jH4yfcebi9gbbV0VWpx3T2iywy9E4WQnLFyWEJdOxU8FeShNLU4EqbVkvG/YRNGMOIIjP4nacz1taUFkCkCYAuhzGQempFG/HKPrKUdBL0RMr7Uu+0GZD9T5XhWx6iT3NvT65BWHxlEegtchPABfNYkekhWHGzlYtd6jFexMAXI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789577385;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=lCywjmCCkpLsZJq2VCSfSNRtbFNx8PVHX0fH2Mpr6lg=;
	b=ftYpPvZlYUICDJ0K5Wn9rosFI+R8gT+y+ZblVEmHQ5G9p2V8c5ZZOwRi3Z/waG/O
	P17bcf4tgTexjVCeyX7nP/kBWpXlJUOUxcDLOdb6Ut8jNxgwWoUzXSY7Sm1F7U9P7gT
	5VOIwJxVKLxp0bAPs7qia84/TU8JN8tve/9DxwNk=
Received: by mx.zohomail.com with SMTPS id 1789577382669156.6825865686152;
	Wed, 16 Sep 2026 09:49:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:49:38 +0000
From: Yao Zi <me@ziyao.cc>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
Message-ID: <aqrIoiKSN1kMPT0f@pie>
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915073206.6665-1-yangtiezhu@loongson.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.567.80
X-ZohoMailClient: External

On Tue, Sep 15, 2026 at 03:32:06PM +0800, Tiezhu Yang wrote:
> Currently, there is no network connectivity when upgrading to the
> latest upstream mainline kernel on certain Loongson machines such
> as Loongson-3C6000 server, because the driver for the onboard NIC
> is not enabled.
> 
> Enable the Motorcomm PCI DWMAC driver as a module by default when
> building for the Loongson-64 platform.
> 
> This ensures out-of-the-box support for Motorcomm YT6801 Ethernet
> controllers on Loongson machines, enabling demand-loading without
> increasing the core kernel image size.

YT6801 isn't a Loongson-specific peripheral, it's already shipped in
many other PCIe addon cards, and some x86 laptops iirc, thus it just
seems wrong to do this in the driver's Kconfig entry. I would NAK this
patch.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Best regards,
Yao Zi
