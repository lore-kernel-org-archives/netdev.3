Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24241B36E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727597; cv=none; b=D/a7lCJ7H99DRkSLrfnFQsZYZl4vd9JK8HDy3kzE+DxZyxMn1oHAjEI8lPIyPV4FObCkekwyzDVJwTbSCM8BPXPFuTBkr56wBcPm4vzKAno0lkxpKfPxbvGOO2WeBhmG2fV27maxylLouwQXHP2K7fMXSXre0h3gv+4Ce0pBgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727597; c=relaxed/simple;
	bh=dijG+0HIV0gEFNoCi2L3dwBYdG0jZbEEdAlhRmZue2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL/8vAe8SvwAbABCnUOReddaNqqXejm9XQAAqw2DCOQAIuM+fCYpBR2UwMRtvCgkvP1ey0/RF6m65UJtdlsh9ZDbdmMmwl8IUL9kjwPdXhngk9nC1ZDdjlMH60LYFnCKZrZ+xdKcTQKLMhP4Piwd+buuVT0eCuRCmxnRmhBjMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap0NjStZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap0NjStZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F091F000E9;
	Fri, 14 Aug 2026 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727596;
	bh=YaXokq/jwa69UJnq1v+qyDsRIIhNY7ILrAsoqR2NL7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ap0NjStZi3zbG96GSxBfMHuLu1HnWHMh6F3irxr3VArBtl+D3HcOq7JFV6jYFV4zI
	 VA13z13mmW7nIMT0ueFOyBp2jPHarEhyxMj07j82WJK3GO88UE/KCriMgyyZUBZjSU
	 lHMBqHo51FhYz80O3dvlLEy8ud0cJanVawQhUCWk1367SkQ/8wmAcZqe9NYL2VKkka
	 wNNKt/q97F+jWcC9TFg/YsoWYlmz00aoXmLlWtAloq4uKei7y63UXq4j2XWIT9++Hy
	 kPbQxnqPvvRO8aIeh13GfAk2u9QlwOGJnExlpX+H2hHP8aIFBOl0zB7LR7qypaiwJ/
	 fVnOtXtTPam+w==
Date: Fri, 14 Aug 2026 18:13:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH net] net: txgbe: fix interrupt mask for MISC cause in
 non-MSI-X mode
Message-ID: <20260814171312.GR265046@horms.kernel.org>
References: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com>

On Thu, Aug 13, 2026 at 03:33:05PM +0800, Jiawen Wu wrote:
> In txgbe_misc_irq_thread_fn(), the driver unmasks the miscellaneous
> interrupt at the end of the handler using TXGBE_INTR_MISC(wx) (which
> resolves to BIT(wx->num_q_vectors)). While this is correct for MSI-X
> mode, it is incorrect for legacy INTx or single MSI modes.
> 
> Due to hardware behavior, the WX_PX_MISC_IVAR register is completely
> ignored by the hardware when MSI-X is disabled. In non-MSI-X mode, the
> hardware forcibly merges all interrupt causes (both Queue and MISC) into
> a single bit: BIT(0) of the interrupt register.
> 
> Unconditionally unmasking TXGBE_INTR_MISC(wx) (e.g., BIT(1)) in non-MSI-X
> mode means the actual MISC interrupt bit (BIT(0)) is not unmasked
> promptly at the end of the MISC thread. Instead, it remains masked until
> NAPI completes its polling and unmasks the shared BIT(0). This delays the
> assertion of subsequent MISC interrupts, preventing timely handling of
> events like link state changes.
> 
> Fix this by explicitly checking `pdev->msix_enabled` and falling back
> to BIT(0) as the interrupt mask for the MISC cause when MSI-X is disabled.
> 
> Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ vector sequence")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>

