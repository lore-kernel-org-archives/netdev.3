Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57172223DE7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894900; cv=none; b=sCw3ioIXvPVIBg3b0fq6lREsuC3sAyMVPnBs5N4kFs7YJhRqdKrIRZkxlWRAu4evT+rZQy6L4UI5y1p86zUEbqyd//W8AsrDmiO81h6RpmpmFCnGv/J+ipbEt19Rs/EMMzBPgYoO0xHZ1Rm0UxM0eAPLeYmkNFKhkCX0b5JLbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894900; c=relaxed/simple;
	bh=YogHmOpF4A3GhNzX/JlPwki2deFWzLDehVMmjrxi74w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6xc9sdBn8qNVrTXbY/0a8mmmJPK8hZERP3GMJAPeuzVwy2UgkKEFxTOwYyebb02Pnr/GcZNXcoAVQb4mjQToaJzHE8bBlSPB6cb1ghJH72QYW0j6jN+flGfpZ/nJ0ujg3vFinHSbufthMATaZyIhN6sCijgc0PCjnJFEFc2Z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HbFCm6NJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HbFCm6NJ"
Message-ID: <e4e4b73c-3a0d-4245-9671-304bea0a50ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776894896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8baY9fEE70ed+r3IdwfqVGWeo+synaNC4tXtFwpdhuc=;
	b=HbFCm6NJCTPdHyJAPvard6jLqweXUGSr1xNAAFPNDVD8YGxCXfPlN577b6fXjB460bsT6M
	k0a8dsL9I4L4fakxwH2g3c9kZHxua7Hab9GnMB5A3/MWNgzTPr86dsZWCWzOQZA94NrMgt
	LpDdKzL3VcISC/pjtYAQvJA4IFJrsd4=
Date: Wed, 22 Apr 2026 22:54:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/3] net/ethernet/zte/dinghai: add hardware
 register access and PCI capability scanning
To: Junyang Han <han.junyang@zte.com.cn>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ran.ming@zte.com.cn,
 han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
References: <20260422144901.2403456-1-han.junyang@zte.com.cn>
 <20260422144901.2403456-4-han.junyang@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260422144901.2403456-4-han.junyang@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22.04.2026 15:49, Junyang Han wrote:
> Implement PCI configuration space access, BAR mapping, capability
> scanning (common/notify/device), and hardware queue register
> definitions for DingHai PF device.
> 
> Signed-off-by: Junyang Han <han.junyang@zte.com.cn>

[...]

> +
> +void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int32_t off,
> +				     size_t minlen, uint32_t align,
> +				     uint32_t start, uint32_t size,
> +				     size_t *len, resource_size_t *pa,
> +				     uint32_t *bar_off)
> +{
> +	struct pci_dev *pdev = dh_dev->pdev;
> +	uint8_t bar = 0;
> +	uint32_t offset = 0;
> +	uint32_t length = 0;
> +	void __iomem *p = NULL;

Even though the changelog says that variable declaration ordering is fixed, this
patch (as some others in the series) still has the problem.

Also, please avoid using user-space fixed size types, kernel space uses short
type names, like u32/u8 etc.

Try to avoid meaningless initialization as well.

These comments apply to the whole series, not only to this single patch

> +
> +	pci_read_config_byte(pdev, off + offsetof(struct zxdh_pf_pci_cap, bar), &bar);
> +	pci_read_config_dword(pdev, off + offsetof(struct zxdh_pf_pci_cap, offset), &offset);
> +	pci_read_config_dword(pdev, off + offsetof(struct zxdh_pf_pci_cap, length), &length);
> +
> +	if (bar_off)
> +		*bar_off = offset;
> +
