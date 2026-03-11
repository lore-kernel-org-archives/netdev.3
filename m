Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD8301465
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262325; cv=none; b=QY0REsWKAFZ65Z8SVUV+2ZC73urH6tWV6cNLOfh7fMc4DSKGIbQtT/wFO5a8Yi3+peJEydnOnvQbqP8XWvHBt41umdXb2spu52Q2VIBbozEcjMJCXAG00Vhrep3N9JBotfvcDLM2GCrz03xVV5l+i9QpJu9SPk90g4YzTtfrF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262325; c=relaxed/simple;
	bh=ScFO38GIlbs0Cjax1hMaBrK/ROUrNfJZ83yhGXwC35I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNiVp4yBr3Cwc+3bsGgbY9hJ1uFIhLBx5eWxqwnQfR2L7wU1lZ8zm2eYRCf7LkaCq/TNbyNyL8pSe0KghSuytKDBCjsX+Nsgi7/lQwdl4SO0kPK5CUhhuJn1WXh19vlr0jal2izlBWxbdkoapouVy+vL5ythQ4tGo/fuXy2B3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FpHJK5D7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FpHJK5D7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nC3EEV59VHc90/tf0FPOwaIrKtADzP+3bZxUQIxMwmQ=; b=FpHJK5D7KhLe7VbliorxzB6eA6
	F0wvRAp7Mmz0A7oS3ZH5L084748GjUxsl0DqIk6174vwtpLCQygjrGm0GyYmHuDrASDjYM84b00o9
	eZJ4YY6dgk2U/xq4fA7FGQf12DF//A1/8QPyFq+xdNxxMgivfWXav5m5FVGcoEckxLqvPs4isA+ul
	TIeoowBgvNl6xMMn/3FoG35GveFuY/6PJ3bNNZukGZM5bUkxHnRI4IE5Bhp06tV0kakYJtAF2u8sU
	QjSkE4z5+J0X/t+3XXUthnS7SBv1FZUQ3pQ73fhK2ZVbpobeylL1ws/SBYE0ridhTIRb5KRwsABBv
	xzulroCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44872)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0QXA-000000006us-0L8I;
	Wed, 11 Mar 2026 20:52:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0QX8-000000006ak-2Jhy;
	Wed, 11 Mar 2026 20:51:58 +0000
Date: Wed, 11 Mar 2026 20:51:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org
Subject: Re: stmmac: TX stalls with head OWN=1; requiring manual DMA kick
 (6.12.63)
Message-ID: <abHV7rDryld4A-S_@shell.armlinux.org.uk>
References: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
 <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 11, 2026 at 08:46:04PM +0100, Andrew Lunn wrote:
> On Wed, Mar 11, 2026 at 08:34:36PM +0200, Tomer Maimon wrote:
> > Hi Giuseppe,
> > 
> > On kernel 6.12.63 (GMAC, normal 16‑byte TX descriptors), we observe
> > brief TX stalls when sending small packets.
> 
> You might want to look at Russell Kings patches from this week to
> rework the descriptor handling.
> 
> Also, please don't report problems on dead kernels. 6.12.76 is the
> current version for the 6.12 LTS. There is a small chance your problem
> has already been fixed, and you are wasting everybody's time.

Yep.

Not sure they'll materially affect any problem, because I try to avoid
functional changes in stuff like those.

What's missing from the original report is a description of the
hardware. stmmac drives multiple different versions of the Synopsys
IP which have significant changes between them. Which platform glue
is being used, which core driver is being used (dwmac1000? dwmac4?
etc.)

Also what isn't mentioned is whether this is a regression, or whether
it's something that has never worked. If it's a regression, which
kernel version previously worked?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
