Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C4211290
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108255; cv=none; b=nEudwhA47OOIfzou6L/7CHMdd6yA1OJ2YpL/Hu2dBHBigsh18mKmTxukerQmp1JflNaAqW/a5/NhgCKmsqYN96jQvEGpskZppmWrVuPRZl9gcj1zlT3DhkdDGasnHLobTMnjePD3+9jyhlQRP4f8a6mq/5u/1lWrf+L4nsgYrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108255; c=relaxed/simple;
	bh=J0CauotReGtom+w6hSEbxetaIq/O2FJrmGCwZk5QjMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6QBqeRiOmtugqhmC45tWFmdT6w81FG0OAX7FaYLwEkwQnnb/fv7QKzfqk/t2z564HLWVItqve30rUKRqJyV4A3tJmQu3gNmrDI83ICyR+UAI9OlGPuBRHeIXhDKjM4/SOAAWLWrbEkk1wSIKVKwJ2k69dTLre36J2sYAROZgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWSb94mY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWSb94mY"
Message-ID: <321bcf2a-1a38-4a9d-bd0c-15dcd010fb5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772108251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r79B4jGU+gUv6qbYfEqycoR/cDElV3OxbWLQtQjD2k=;
	b=XWSb94mYw/7OQjbkbeEkIuMmYg9iL3Ma3Bn0VbujeXpTyQPYJjrptp3AMLVcmxFfuS0sIN
	rzdrbheuGr2Mu7yx+uwNq+a/GVPwJuQfbleHKBiJWCSJ30GV3Uz0sRl26gmsDKfeFLLWm9
	fjvwMlG/xGkzV2AerqcHvqJi0h8fnm4=
Date: Thu, 26 Feb 2026 12:17:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260225102938.4131-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260225102938.4131-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/02/2026 10:29, Sagi Maimon wrote:
> Add support for the Adva TimeCard model built on a Xilinx-based design.
> This patch enables detection and integration of the new hardware within
> the existing OCP timecard framework.
> 
> The Xilinx variant relies on the shared driver infrastructure, requiring
> only small, targeted additions to accommodate its specific
> characteristics.

What are exact differences between this card and OCP design which is
also Xilinx-based?

AFAICS, it's only flash base address and fw tag is different, which can
be moved to resource init part.
