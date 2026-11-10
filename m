Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335766;
	b=lrxOzYKZinUG3dsIVh/PNdp3cblGX/RPKbK2JEDzukc4Wvvr6g3Jvae4RgbomnXIylsL
	 oivOy8NtUtHzkNivNGtQGe9LV2ra/A3tCWIOiWzcKLGpBo7R0d2U+UVSMKdmSlPMy8Bwr
	 GX/Sef/t0N1+zOv19TMDc0KQ1EN6WL69yqexeHAiQHveNKFyxFIj5QNyp8eYtyoi8m+In
	 gNOpu2F1XzMTS1izWKmGb8qMmpw341Mcev6HSiZOGwpEDCCSxeFbbC8XXm9UFkz50Hhia
	 ZLgtvxSt3JgctSldzVE3lJTFVFDJQbd7nA1AwtmuwPlXo3VSYXD4doRkq10hB2A3d3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335766;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Tn7lonQfS7EeySjdPzobFE0NrPIJGEwMFpYBf1OhsrY=;
	b=uSoqIie3/kcnIQ+02qdeCTJOMD186up6ilPjm3hUt9uAm7a/lDluRd/qaIJ0CYdSvwT1
	 lWQ6gicqsEpachhhK+6iYFAgg8tYTHbjNZBWOptw76m3/NG+DyHaoTL807atIFSQ1h2ZK
	 o4tno6KE5UpMZoHalVIbKHEf1Uy+Ua8M8UuJfBr46w8eJKsG75xhaTfevSkcjDulQepJK
	 KrPvAJMGQbk15rI4Ou7J5MgscVf6hpfqOZF0fg+s6dZxcaLaeuMTOw1NNOA/lz/KzazHj
	 sPm6PNCU1pKNQgsGz+L/3+Fg/EqQLK5W8fX3nSgh3B7pNerzddCdT2O0NcMmggD5tdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpjdJGSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D09606A325;
	Tue, 10 Nov 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpjdJGSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A1E1F0089F;
	Tue, 10 Nov 2026 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335765;
	bh=Tn7lonQfS7EeySjdPzobFE0NrPIJGEwMFpYBf1OhsrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HpjdJGSjhBuA2WwjnLbFRsqr6B/TkZPFFJ4mFatHjrQCMXrhYRkJ4oNxiA1nw8k3d
	 fSuMfRU7PpMBCPfjsILliRq4BRE6aLDK3Br/M44DI8z0C62fSZPPhWMwRmgc3N4xyu
	 fRKJ7JfZRXnddOdn/mkSnJaaXlsFJM04ALW7y6pKaJPoSpGQhFFeco2x5aaBArUNFN
	 q7CqFJd3CQtcBa0Qbf50zZK94UJSzcSP9fWLkY+/1tUTE3mS/k/E84nK2J22G/murG
	 TRqy89yZs7UCaeR9oFfPqMf1d5jhySx/UdjDDrXvda6L1opivteaY3FLHxYxQrF0/I
	 i++ETrIEaOQJQ==
Date: Tue, 10 Nov 2026 10:36:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hariprasad
 Shenai <hariprasad@chelsio.com>, netdev@vger.kernel.org (open list:CXGB4
 ETHERNET DRIVER (CXGB4)), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] cxgb4: clear the sge maps and bitmaps freed on
 adap_init0()  failure
Message-ID: <20261110103604.3e841182@kernel.org>
In-Reply-To: <20261104103309.24360-2-fourier.thomas@gmail.com>
References: <20261104103309.24360-2-fourier.thomas@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 11:33:08 +0100 Thomas Fourier wrote:
> This bug is theoretical and was found statically.

Please don't bother sending such fixes, there's too many of such bugs
for us to handle. And clearly nobody cares.
