Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944C388E61
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739890; cv=none; b=uUUWJ4KxnxMLONBGxLLSlbRcC1Ay09vSPvl+uyZi8GnNHKsGjWWuwbaebmUOVKIen5cdbRqqSfJ813exJSdxGCjLI7Uhs+zHopjmp/4VPKg+hf8Y75isuqeApRnYIWLRBYs/SRjedWwF1rTUyG/B0lw6HDxkKiOqXG3ncFvAd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739890; c=relaxed/simple;
	bh=PUtCH2mIavsa719O4vEdePS3+ukWIimZPi7womHrDik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6HPtUJBGcM1C1oAuJWyN2QLYGl1mzHLiL7nrHgYWb+mjOjnTqMedFdbOt+s6/alxF0P9wmFgVzRCA3thDGapyJPccA4PGZIYlhqesGISSefxcqev56uh3R4hbyzC0MbWOQtn3syTBjWzwLkhfON1VWH0Ma7XyT6L27MWsxmkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehBABrRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehBABrRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271961F000E9;
	Wed, 17 Jun 2026 23:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781739889;
	bh=PUtCH2mIavsa719O4vEdePS3+ukWIimZPi7womHrDik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ehBABrRFTO7Z4VezmK8POW8KuVNQovjhhnh0LvYAr9CxzY9wDhDUhg3LD45I87Dv4
	 yVaXjElmqTiOGfUCCkGLSEDlUikyey6Hj1t/E3GXCm0FBI2r9YiB/4NLRexOgcpMzX
	 awUGf/LqdpMHOA2U3MBYFHGAp+TPb0OKXBeaT/TTCIL6/xqWIN3b9b1XSt23fBo7dV
	 swkPqyyicZWs7gYYC/K3fCIQU2IpiFqn7qURKIuk7nwQeDcmMMAB/TITf/sqYdZKez
	 Nj+2q6teMCNzp047kNGlXZkX08sThANjueFzWweyMgEjQyo+RuBRMnuneWQJ7bEK4J
	 Gk4OarN5j/NNQ==
Date: Wed, 17 Jun 2026 16:44:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Stop TX queues on error path in
 airoha_dev_open
Message-ID: <20260617164448.31e189bc@kernel.org>
In-Reply-To: <178160729880.2156257.7978513589649053826@gmail.com>
References: <178160729880.2156257.7978513589649053826@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 18:50:39 +0800 Wayen Yan wrote:
> In airoha_dev_open(), if airoha_set_vip_for_gdm_port() fails after
> netif_tx_start_all_queues() has been called, the TX queues remain
> started while the device configuration is incomplete. This leaves
> the device in an inconsistent state where packets could be
> transmitted before the VIP/IFC port configuration is complete.

Not sure if this was superseded by another posting but FWIW
this posting did not apply.
