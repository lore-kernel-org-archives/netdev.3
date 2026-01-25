Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01A3009FA
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382249; cv=none; b=i06jMuZ6NeihCUJShOP75Nrx2WXNzNkhPrvg1rAEbKFjJubdg7AzV0HuMuLsm0/jvQ4g51KqVTYEiYcGkyjF9tkmIKeBX3iVYdwQFg5IqDGsssugvPttKoUMK3ZH1KozGP3pMYy906xD4GkOxBXJIvn9BeySC+cclXJCqV2/riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382249; c=relaxed/simple;
	bh=960bktz2ZFqnPtMsf7RZW8qIbtxeJL5lmytaygJqpvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUoE0KNtetAL/WLoItm6Bjn/fjqaaxau2dl0s/5abYJdbyYgBE82hGEXN5cVtNzvRMC30n/PcYKDD/I84R9vTKOET+mKvtpKOnCj0QvhW0+T9GSiWfFu0jSDYChyA1uHFXSRZtE/YstuOCnNPfmuf1U77Umx/2FjvRWDc16v4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBvtu2rM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBvtu2rM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997A9C4CEF1;
	Sun, 25 Jan 2026 23:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769382249;
	bh=960bktz2ZFqnPtMsf7RZW8qIbtxeJL5lmytaygJqpvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBvtu2rM+Zc7GcADmQSJmwr0x9DVRjuNeMrRLAoSLH6Eya2iSWt77HV8KDb2+VoiI
	 REafSykfgSE2CExeF+wCE0VYXbiB4Qx2LBt3EBUU5bFwcrEfIhhdymmUN7rYp0ywyl
	 WJBYF/4YzyjyvN5HyXJzz/rHbRo7ks917U+IuORUridp3Wbc9jr4Th9OcuzMw+it4H
	 bj7bO4p74y1o2kJ7hnOtjAwJ3e402mDTdq9oH0aVJazfhXKHOUPLnhgaowqfN6vpVw
	 WVx6lQNgnkKXGo3thbirZRrCvA8bbg1YxOSvKlmP9pOh2d5tQsECwCpnvVNrXid+j+
	 5+hsFOY8uAu7g==
Date: Sun, 25 Jan 2026 15:04:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
 davem@davemloft.net, alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, heiko@sntech.de,
 andrew+netdev@lunn.ch, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,18/21] net: stmmac: rk: rk3328: gmac2phy only
 supports RMII
Message-ID: <20260125150407.3369b678@kernel.org>
In-Reply-To: <aXaY5nKGFdBhVsnb@shell.armlinux.org.uk>
References: <E1vjEvF-00000005ghI-3CYC@rmk-PC.armlinux.org.uk>
	<20260125221631.3396200-1-kuba@kernel.org>
	<aXaY5nKGFdBhVsnb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jan 2026 22:27:50 +0000 Russell King (Oracle) wrote:
> On Sun, Jan 25, 2026 at 02:16:31PM -0800, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html  
> 
> This, and all the other AI generated comments on subsequent patches
> are repeats of patch 17.

#$%&, should have checked. Sorry.
