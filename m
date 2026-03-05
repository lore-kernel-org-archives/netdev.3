Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018A39E6C0
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723164; cv=none; b=epz2TuE2Ii5mcPoFk1vLwKlMUUgejPUPNmdWdBfd9p6yt3LrP21E07Fmgg41KrbuqZCoQEFwB3KoNfWV4PHqXxIY1AVcHbzOhkcMHoUgBWEwa+6+K3kHXnsiVdhFFivtxVmEIbyrbIeuqR9Cd0Q6zPZ3vOfVMiCRwAanR93+Nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723164; c=relaxed/simple;
	bh=EfCC+MlopX1V3+iT0K/95ARlpQmltB9xkG42WiYBics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw7zNiq0WtwXhWiskXBvYcMFHe6E1B1k5/mssO5eeb/YXXnuaoGhkSRHvN+hd14yqTH0bzVWGLG4OXi6yuO+UBPcMlqsHYmyuTG9DZXA7Zt+DKQfatMuT/+jFYSPZApG1OcKsI8Lfi7qBXVEzdG28cHnCSKGj1c7MXpB2PuzSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtR5OOzO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Unl9YLfR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtR5OOzO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Unl9YLfR"
Date: Thu, 5 Mar 2026 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772723157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4GyX11HRuTrFAqczXtiZogHHPj7fKRTEbZ94l8Nrb4=;
	b=LtR5OOzOA/cWFAw7OWsccMkgN3wChl9hkNLjVf5KQNKMYkPz4qczSlAAUBLM9inqPxKHI+
	JleICZPKKTZhU54kHoUnKmlbxhKw4UJBwx2jI6kWV8CXD8JiA64iYbBSX2xLfkFf29+opI
	0CGnmgvgf4nyu4HOqxfgVRnpa1Pk65230S2uAMMqRyejrCVnNwi7RgCXoDQsEgvdytK2Ng
	0SwUFZuvtzx36QRshy4RPWmu6PaYsIX+ofjmDaRNrCqb8vkF/TmQn2UUfDKrL3yl0gPfn+
	Ek2iO907gQI32GlnWhlrTIaZrEihxmpz5/skmmqlnnW9alDk4Cgrrz/l7HaCCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772723157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4GyX11HRuTrFAqczXtiZogHHPj7fKRTEbZ94l8Nrb4=;
	b=Unl9YLfRdC6Vse3NxIoqiXXm09Gt3q8HTj0VBCeB7L82UhHfMCwPq1Glnsu6ww6rMQIl7w
	5V2J0iAFUfAyEZCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260305150555.Y7QGGWxj@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
 <20260304145821.TQhzhhjF@linutronix.de>
 <willemdebruijn.kernel.1d699189fce58@gmail.com>
 <20260304161255.VV_7vPBw@linutronix.de>
 <willemdebruijn.kernel.1f5b6b3e8c22d@gmail.com>
 <20260305080731.xnJ0XtTX@linutronix.de>
 <20260305064111.13fe5e0b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305064111.13fe5e0b@kernel.org>

On 2026-03-05 06:41:11 [-0800], Jakub Kicinski wrote:
> On Thu, 5 Mar 2026 09:07:31 +0100 Sebastian Andrzej Siewior wrote:
> > Let me redo this with the skb-extension variant. 
> 
> Expect opposition. HSR is an Orphan full of trouble already and what

it might be an orphan but the handling of sequence numbers reworked
recently.

> you're trying to do very much feels like a one off hack to me.

It specific support for PTP support over HSR/PRP, yes. So nothing else
benefits from it.

> Can't the Tx path be done with an egress redirect on the HSR upper?

For the RX side I need to know which port received the PTP packet and
forward this information to userland along with a possible PTP
timestamp and ensure the HSR stack does not forward the packet on the
other port.

For the TX side I need to be able to send the packet on one of the two
ports, be able to let the HSR stack create a HSR header or use the
provided header which should not be used for any checks (de-duplication
and so on) while sending it. Here is also the possible PTP timestamp.

If it wouldn't be for the HSR frame header on the TX side where the
packets originate from the node (sending PTP SYNC, PDELAY_* and so on)
then I could directly attach to the two slave devices.

Sebastian
