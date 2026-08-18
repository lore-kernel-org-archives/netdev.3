Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDE2B9B7;
	Tue, 18 Aug 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065574; cv=none; b=PpYtjVx68XkqMEZSTRzsR2QOXXOVbC6psvjdQaOH0akCzC/wxLPAGXCDOuTLz7wgPA/3e5izoQt/jne6jcAXwrU7ibe68neDWWQtevY0nCbGAdM2A8WMeAR8A0TFvBkNVk8AaD1FY/63EDiZPqEsi3E/pqBpVWNWH4iydcrpMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065574; c=relaxed/simple;
	bh=YIXMxRnpjCRSDW4R7aDNUedpnqYorHkPE7F1Q+LrrEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAjzGDL4f5emCvd1a/CkPyMhXxM1hlzeiSS7jZ2BnDCayWUmw3LhOSRQuiuBgQyLoip6uG/Bj4AhVFrm+qA4fVDo6Tgy7HLIo7bam+bsSN1Lq2Tj6TXrKZlIEjw7G4uxuyviM2+k/7xmAX5p0GgTRHnQnR4njrc/UA/iXP0950g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQXsKlal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQXsKlal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6F1F000E9;
	Tue, 18 Aug 2026 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065573;
	bh=ITs5T67azxU2yDbF+KTFMYbje3vayL/gBQ8dH2jJ59M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CQXsKlalp1p4YcrUPK1PuHpP3QqG0VN6pQIgr5/9uyzn6mN0WCx2zpwns73b+Bf5+
	 uQ6ZI0Vfn95tf4rv/maQAFv1nTq9KUoTaFYYOV4BSzy60v8uWTPEgy78qoHm7WxtGZ
	 0O+0X0x7EmOXbis6GHM6gQC/MuvG0JODc6n4ypHziWpWz2jQo7g4TDBEGG07NJy0uS
	 sbCDJXuv+Po4NrteuokDToWplmhD/zW5Ec5Zc4GJPmAz9yD1dSMtPjsS6+3DwcDt0X
	 fpNECqnrjoOlFC3rNLxMuqaoobqiKfLQ+JMSF3pckX6c+GgN4gx7FUFFeV82Sqj1Zt
	 cQZ04VZZO0VkA==
Date: Tue, 18 Aug 2026 08:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hisilicon: hisi-femac: fix NAPI teardown ordering
Message-ID: <20260818080613.045d764b@kernel.org>
In-Reply-To: <tencent_1B2B4E438079BF5595B1F50C45FF9067BA08@qq.com>
References: <tencent_1B2B4E438079BF5595B1F50C45FF9067BA08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 17:13:29 +0400 Jiawen Liu wrote:
> Remove the redundant explicit NAPI deletion from the registered-device
> remove path.
> 
> The confirmed lifecycle contract is that unregister_netdev() performs
> the NAPI teardown. Probe failure cleanup before registration remains
> unchanged.

We discourage pointless code churn like this.
If you think there's a bug explain it better.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
