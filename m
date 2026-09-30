Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3683C1D66;
	Wed, 30 Sep 2026 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798701; cv=none; b=LIFJUU2WvEkaEqiVxJVP2wDcfaE9S5WsbmTs/edGAAbQNBrXH+EwoH44tOpbWm/YyhfdPeqSoCKr/4zZMMOsHtr3dQ6HR+n/KupBAQCeOQGNdx6s9iWAMsyJEjs1ztJw/60OLH2GMPmey/SRIXX8D7GPOUoX5wxnDSR03NAf6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798701; c=relaxed/simple;
	bh=GrvWg2VKTXm9Nq1F1J+wYFi8wcxw90xO7m7MsdT9Mhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK27B68We4RpevRQ/Tih3F9GaCrzF5+BvgRx0Z+C9u6wBJBTOtJtNPW0LxoQIOP4YczfYP7hKFdsUPZAkyR4iWHddNLqymUXEkg6rKuiTEkzVcKr8u7gnkyPF2JKkbuqepSaLgiZixdvhJMck/y8/+tOPOkBx2Dy1uKktwxgOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDbqCu26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDbqCu26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9521F000FF;
	Wed, 30 Sep 2026 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798699;
	bh=0RjqPiwf4zVjccuUNwp1GIPjIg7gF1nlAjd1ya5BGlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kDbqCu26pnO6f/I57E5z3KLPWhVRL26kyP2G0IZq6Mjk8+qOkulznShEAeTLz4gFQ
	 xWavmoYk9/reZy1Y7iTnGSb8TZLcNdDwip3Tb780JZSYU9TqpORB9lo4a9LoOESvMR
	 TFvn7a0bUYQI7gfFjOAsPJlW3Cj4N7c9tn1L9K5nh0lVpddpx00x5CuIgDBJPWVWjy
	 UpPv1DGDEjj7/V0RC2Ihgahxtt/RS2MT2qY/dKB8dlFqAIz+x3lzYzfxvZ3CgNeByR
	 buuRQyoGVthtweuZkTJ72F4MF8ZU9EjqHIY50Bn+WRXmqsMKriZyQHfaZqg0E0dqLl
	 TgIC4jvQaObmQ==
Date: Wed, 30 Sep 2026 15:04:58 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, shenjian15@huawei.com, shaojijie@huawei.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Convert hisilicon,hns-mdio to
 DT schema
Message-ID: <20260930200458.GB3971425-robh@kernel.org>
References: <20260925215911.2950356-1-robh@kernel.org>
 <179072142212.434549.1306076815346983081@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179072142212.434549.1306076815346983081@kernel.org>

On Tue, Sep 29, 2026 at 10:37:02PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In the new
>   Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml, two of…
> - [Low] The new schema lists 'subctrl-vbase' but doesn't make it
>   required; the required list is only compatible, reg, #address-cells…

pw-bot: cr
