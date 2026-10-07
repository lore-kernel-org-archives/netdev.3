Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18848123D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387304; cv=none; b=FcQw8r0ZyvZmbPC8MPllKs03EvPc1Wzri+qTWjTEpWpn3R9qZ8++xmEy4reoFIpN3jqw2cHh9epZ/FgrZdN8bIq+WH83+TlZiNvAxT6Lo9SD+faEAESbhsmh5Pir1tBvtalnKWTyRxsAiguAdM0jEg+kIlcK37TkTFGXVmeEkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387304; c=relaxed/simple;
	bh=L0x4JDqDFna9CJNPCa2uyjPavXu4Mie1YgaxStniy20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOM4t32cBzy8FdjucG8m+PE4Zwob2xRZ83DKRnUl6g7E6F81Um6EKG910AVDCI4Kk2bpszEVt4jo8mGLIZwq+sQ8GsMk4ezGPbR2ttwBBjBg3mafgK7LR439ttXCOGeG3rekJGZ0JBu9KwHuw6cPStfkVaWLE2oKuqyRrln5FGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv3fTSrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv3fTSrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDC1F00893;
	Wed,  7 Oct 2026 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387296;
	bh=wDt3kaQUn+FXnKI+ifgbxqx3rVVB655uDmMqAOOgMOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rv3fTSrPZFEYwkkxtEbBqAjSBGy5JOtcrSRyYGZEYff7pU4M8y90Bwa9YZSIQ+wd9
	 FcjNZXZwwDu//4dpncaFCHioJPFDNK6gUxRl7+GhzZGUH0VPzlKocTP0iOLnrGjMQW
	 4gfZgZEya2A/u2U+2QlQ2mj06gX6U3VR4/KG7oIfiOGJeKx5Oczb3mSspQLZkj7FAf
	 WeDoS6alsW5NPfJJ7Roabf2PLH5EO3ClN5WCtiW0q3mIJrwQJJRiV+5JF+xCGiWCcq
	 L30vHLM/EY/oFalZ+CZS9t/ydZUqKKo5XDJfh+mvyQxN+Jumj0Nj+8nu/zDZgKFnUz
	 bkSLLKEUjpw6Q==
Date: Wed, 7 Oct 2026 16:34:52 +0100
From: Simon Horman <horms@kernel.org>
To: iugfdin <iugfdin@proton.me>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] r8169: flush pending transmit packets when an
 skb is dropped
Message-ID: <20261007153452.GW83879@horms.kernel.org>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
 <179098478410.1174319.17923728268629391314.r8169-2@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179098478410.1174319.17923728268629391314.r8169-2@proton.me>

On Sat, Oct 03, 2026 at 12:08:01AM +0000, iugfdin wrote:
> rtl8169_start_xmit() can defer a transmit poll when xmit_more is set.
> If a later skb fails preparation or DMA mapping, the shared error
> path drops it without issuing that deferred poll. If the failed skb
> ends the batch, previously committed packets can remain pending
> until another packet or recovery path kicks the device.
> 
> Issue a transmit poll after cleaning up the failed skb so earlier
> packets can make progress. The failed skb still does not advance
> the producer index or contribute to BQL accounting.
> 
> Fixes: ef14358546b1 ("r8169: make use of xmit_more")
> Assisted-by: LLM
> Signed-off-by: iugfdin <iugfdin@proton.me>
> ---
> Tested with W=1 driver-target builds on net under x86-64
> allmodconfig and allyesconfig, and source-executing ASan/UBSan
> checks with modeled kernel/DMA/MMIO boundaries. No physical
> Realtek NIC was available; this is not an on-device test claim.

Reviewed-by: Simon Horman <horms@kernel.org>

