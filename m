Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A774EFFC0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659757; cv=none; b=NYK3x4qcKAv6JscWA08lVfet1Q/O/akQU6t58D8BQD0ucWX3g2ss20h1yZs1wkzHlESWx43+GNgMF/hewMC8RG0ZPPnrpGE//AgATb2BIRu6C9N6o+eJOVdkpN9Wh7rmcMa2U5uI/99IituGegciNnChk8MG23GS2tYIsYVn5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659757; c=relaxed/simple;
	bh=ASjXerlgHuHLZi9ir11bs10laf040P4sRHhl/1YcaeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRfygx/tM0ENO4rMjqSBExa+L6VDWzLInXcm/k1K1Nv26yIAcM5twKZgdQUKGfvETzpBD1S1drzYCMet3313pNZk+1gpMThYblljuR/Dtjm2gijDZk4smDGvCUXvaY/6I61fwXI795GkGswJWXqlKtRzRuUSvUEMv9MbA9w48is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qPyeDytc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qPyeDytc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 77C981A0936;
	Thu, 17 Sep 2026 15:42:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D55B5FAA3;
	Thu, 17 Sep 2026 15:42:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F31B11C7B08E;
	Thu, 17 Sep 2026 17:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789659741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=d2rqoANqapE2XLn2dSVmJasoPdWmDd7pHjTlHIBVe84=;
	b=qPyeDytc6bpI47/fo2F8590mMjNdIVvnDgNp/VK4Fun4Y3og5etZTf9HZSnkI4+3OzQ6ui
	jXA5j99C2SpiNChuy0wB6OnT4BxlkK7QQIR7s2ruzKCH8PJoqknJd4iMxSTzqSJdLk6v6O
	VNIiUKQCUgol/O0uD8gShdUWovfZ2e968YGZAHdfv8cjpfrpucZ5pq3iftlkGv/UAoXt5r
	bHLNUdt1TX1ITell1ijyNgZf3H9KcXb4cVsRgppayH3PaCSjnCyjx3seeudIuAfQfS5cRX
	H6jB//8zMVCx8Hd4eEVW2lHB+VCKeakjp3nWhkRaOb88otGc7XjhwS5c6i813A==
Message-ID: <067b8ae8-7de4-47cb-bf49-ec6fde1f34d6@bootlin.com>
Date: Thu, 17 Sep 2026 17:42:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 1/2] net: stmmac: selftests: Prevent RXC from being
 disabled in LPI
To: netdev-bot+sashiko@kernel.org, peilinhe2020@163.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 he.peilin@zte.com.cn, jiang.kun2@zte.com.cn, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 pabeni@redhat.com, vbridgers2013@gmail.com, xu.xin16@zte.com.cn
References: <20260914150612.9798-2-peilinhe2020@163.com>
 <178965769776.22033.13374439300724313005@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <178965769776.22033.13374439300724313005@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 9/17/26 17:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] The last paragraph of the commit message describes the
>   `eee_rx_clk_stop_enable` precondition backwards.
> 
> --
> 
> net: stmmac: selftests: Prevent RXC from being disabled in LPI
> 
> The patch wraps the selftest loop in stmmac_selftest_run() with
> phylink_rx_clk_stop_block() / phylink_rx_clk_stop_unblock() so the PHY
> does not stop the receive clock while the MAC is in loopback. The code
> change itself looks balanced and is a no-op when the phylink config does
> not allow RX clock stop.
> 
> The question below is only about the changelog, so the diff hunk is not
> quoted.
> 
>>     As the NETIF_F_VLAN_FEATURES may be empty on some platforms once the
>>     software vlan stripping is removed, the phylink config attribute
>>     'eee_rx_clk_stop_enable' may no longer be inconditionnally set to
>>     true, hence allowing RXC to be disabled during LPI on platforms
>>     that don't have any VLAN features.
> 
> [Severity: Medium]
> Is the true/false direction here inverted?

Yeah should say "eee_rx_clk_stop_enable' may no longer be unconditionnally
set to false", my bad...

Code is correct though.
> 
> Related to that, should the changelog also mention that
> CONFIG_VLAN_8021Q=n builds are already affected today? 
I'm fine with it.

Peilin He, are you ok with changing the commit log if you send another
iteration ?

Thanks for you work and for including this patch :)

Maxime
