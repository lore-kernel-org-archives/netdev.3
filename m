Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316762E4247;
	Sat, 18 Apr 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526484; cv=none; b=irmM1/LHOcn+p+mp/C2Qu+Jsr+N9NqGUh0rfcH1gU6JxkGpy7XGGgvTJWsuELFBfWFQDwZQjJEblcnkrGuVb9NHO6HTG3CLU2QlwnU4AhmmMhJWtLnxd5gNJFkBDjOXVU4Oiz3UL/F+MfLLzWjFjJ6P76bm+qiZ2l0OaAipFGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526484; c=relaxed/simple;
	bh=rZKakejCw7cT/AyYa+HoyJFN4qmxvDLo09NCX2h2QOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud1z26aNeJQZw/TlIVaTkP4YtVgAuw/Vp9mikleiKLdslHF2GLcAoMX6O4yF2ksRmyg9vXku4hwPvFa6CVI0TVJvsxStvVvev4ALERCU4zktxobIHKuRLZd48S4RZoo944N/upcqm3wKtVQQOB1hHmmjNzUdxF5mCnBi/o6sjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rRT7JDF0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rRT7JDF0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ksoH1aoMGNsEcpTD1Ws7NUKUAmBE8WlYwz3b0oq0Exg=; b=rRT7JDF0B0H6aL5CHPrIS318bN
	QmoXRq0soZotBS39UM8kX98W3J+gV7cTKLaA4LwGp0C4iW85ek7v6OzJR0acbuBolbNE/4hd9YydY
	z/WGW/t/p0xcsmoaiE1T23O/anrFWHW9kb8UqHzQ2PLwBjA2/f5CxiaYeU9lvX8Dh4ZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wE7gg-00GZDj-LM; Sat, 18 Apr 2026 17:34:26 +0200
Date: Sat, 18 Apr 2026 17:34:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hamachi: fix divide by zero in hamachi_init_one
Message-ID: <e1d937ec-d909-4553-9f1e-c89f9b556d6a@lunn.ch>
References: <20260418121804.149171-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418121804.149171-1-25181214217@stu.xidian.edu.cn>

On Sat, Apr 18, 2026 at 08:18:04PM +0800, Mingyu Wang wrote:
> During the hardware initialization phase in hamachi_init_one(), the driver
> reads the PCIClkMeas register to calculate the PCI bus frequency.
> 
> The current code attempts to prevent a divide-by-zero error using a ternary
> operator: `i ? 2000/(i&0x7f) : 0`. However, this check is flawed. The highest
> bit of `i` (0x80) acts as a ready flag. If unreliable hardware or a malicious
> virtual device returns a value where the ready bit is set but the lower 7 bits
> are zero (e.g., 0x80), the condition `i` evaluates to true, but `(i & 0x7f)`
> evaluates to 0. This results in a fatal divide-by-zero exception.
> 
> This bug was discovered during an automated virtual device fuzzing campaign
> testing the hardware-software trust boundary. When the hardware returns 0x80,
> it bypassed the readiness while-loop but triggered the divide error. In our
> tests, this panic interrupted the module loading process, further triggering
> a KASAN slab-out-of-bounds in the module error path, and ultimately leading
> to a multi-core soft lockup and RCU stall.

Isn't that a good result of somebody trying to use emulated hardware
with bad behaviour? The machine grinds to a halt? So it is not
exploitable.

What happens with your patch in place? How are you reporting the
hardware is attacking the machine, and the hardware should not be
trusted?

	Andrew
