Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2753AEF53;
	Thu, 16 Jul 2026 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238473; cv=none; b=Dsvj0ZTU9v/TX60k2s5oG3HswjOJQZDWnV+vMNlEDiiAIJ7cVbKmoq98kID9aK+9uCsAHPw08lflnWvX2njbvN66jNzUiACm2+0IzzhTYtOhYnpSlJ2UeCesFd3lyIXI4fa8y85oTIbhnIFt/5Xr4dmauG69PSD9x6b3lT7jdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238473; c=relaxed/simple;
	bh=SCP5vSspLwmjnjt6JQ/eCVJ7Hj5onjVMARZH/tKBcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9Wh0+4r4s0cZWtjPtyA70qxBLNXF7Ql04zIOzVF2+4U0CjyKhU8yHP6ieMttZH/TOhzJiwmqOzn4yfCEZfTxIorlsj6mgw+SwUi+tEG/rAtAfi2P7FsmjOoDeX4ZGt8PVW7zLay2vxVfEeQNEkWu8UNOfCEUOzcXyE3rIpsj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x+3W/Rst; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x+3W/Rst"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o+Ass545k6w6Fj8Enob1p3mv+kPnP8r1DzVN8pwwt7o=; b=x+3W/Rstc4h+YIWcn9ZgbRe66m
	KYFxrTJnJk6VZmbgGQ62/MdOLrRCAfptPjbks5PcnijVSWUurk4aAtxWbqUnEx41gETATvcBN4FLf
	60NYRNjI6BjkZLyPfrOUkbdXflmrX+5zloB48JQestTUFYsQbCmI9gMkOk6kxELt0Cds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkTvi-00CeeE-Tu; Thu, 16 Jul 2026 23:47:42 +0200
Date: Thu, 16 Jul 2026 23:47:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: tresonic <tresonic@mail.de>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
	rmk+kernel@armlinux.org.uk, kuba@kernel.org
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
Message-ID: <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>

On Thu, Jul 16, 2026 at 10:10:25PM +0200, tresonic wrote:
> Hello,
> Please bear with me, this is my first time writing to a mailing list...

Thanks for the report. Nice description for a first post. Lots of
useful details.

> Since commit 1b9707e6f1a9, suspend (systemctl suspend) causes a full system freeze on my laptop. Fans and keyboard backlight stay powered; the machine is completely unresponsive and requires a hard power-off (holding the power button) to recover. I could not get any kernel output from the hang.

1b9707e6f1a9 makes in effect 4 changes.

Can you do some testing to see if the changes to
DMA_CHAN_INTR_ABNORMAL or the changes to DMA_CHAN_INTR_ABNORMAL_4_10
break it. Or both, but i think that is unlikely.

Once you know which of those is responsible, can you test to see which
of DMA_CHAN_INTR_ENA_RPS or DMA_CHAN_INTR_ENA_RBU broke it.

It kind of sounds like an interrupt storm, but that is just a
guess. If it is an interrupt storm, it suggests an interrupt is not
being disabled during suspend.

   Andrew
