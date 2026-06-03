Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF233949;
	Wed,  3 Jun 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453238; cv=none; b=hMq6p7NylXUW7/jzlAU5pOKBVJQjZJQY99ijkgAi5BQMirFR6Yi0NTv8bIru1SRd6PTL1Vx1ih8QsXT4HZJuWi7VvvI3YzJs3x2rEd2r4X0kiF8sEFXprYXVzXP1eYAlsQcS7EQGaBsbwIwTHTApO/6us5gkBQRZmiCN0onlyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453238; c=relaxed/simple;
	bh=M0icSYUpwjidM91a9CSaBCLnufhdPEAGwxRPFHGLfiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS8A8uAZKuDaJU9zy6CW93L37eT3Et0SF369rEbPpfgJWLl/a+dlYL2zHiBNJg08SXZ5+iN0sjNHQ41GWS5YB6ZzySpSAXumIJtzMxPIZhu5ot8GvrsHamDmAEVEZaFG8VHUMf8EgiBidG1X6CbBJM3Sf7OoKuEIRsqaeQuDp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtp/jnQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtp/jnQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2381F00893;
	Wed,  3 Jun 2026 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453237;
	bh=M0icSYUpwjidM91a9CSaBCLnufhdPEAGwxRPFHGLfiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dtp/jnQjLfISW5AeF6ugLMKcDnl1cN6dIeAAR493UwY7/EkiyxqVRN9CK6vqFd0ck
	 QxNxZ9EMEyJlyUiwzuTDy+GqVundBap7i3o6N6dxVb1Hl1tBAJawSOuEtnOkLOrLbw
	 qaUHp+bYH48EMzYuNvhUbRJ5uxPavglTOsPbyF67nhhBhBPa8KiGNfJseAuo/NUkZG
	 klVmPnVvgvNND4Vm5mdAPKs0D1xICKktO781r2sfBjDMBlMErQB/K1dfunY65317R3
	 QqNizdA408DBoUnryzpa6mUkutnxX0uITxFWGY2Kdd7314Q6IWXMPIClivSYUhk2dw
	 t76gxwoljQmdw==
Date: Tue, 2 Jun 2026 19:20:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: Improve Tx timer arm logic further
Message-ID: <20260602192036.7cc25ae8@kernel.org>
In-Reply-To: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 23:46:59 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> There is no race concern: hrtimer_start() is internally serialized and
> safe to call on an active timer. In the event of a race between
> hrtimer_active() and hrtimer_start(), the worst case is calling
> hrtimer_start() on an already-active timer, which is identical to the
> pre-patch behaviour.

I mean.. I wouldn't say that this is not racy. But I think you're not
making it much worse than it already was :S

Could you experiment with deleting all this local driver logic and just
relying on NAPI's built-in defer IRQ mechanism?
