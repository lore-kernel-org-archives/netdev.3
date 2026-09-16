Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222734AF9EE;
	Wed, 16 Sep 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597316; cv=none; b=H5RSseEJbHuhfouBjrtrFeDhqJT3rrO3cXpWFD8uEUMxcyE+UQANIIN+vNaGfWglgqmqDDytTSPfTrCr6gI2QTfe0oZzuxcX1BxG1cky9l033/ZIEWYyYtS8/xG80aJFMGLgjEF63g8TKRuCGREFOie75sn3yc7SslDh1KUdqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597316; c=relaxed/simple;
	bh=se4pASV5XfoI9vLpP3iw2gFFy43IPBXRTbnLE91KXoY=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=YDdndqbdGforzUM0Gun6IFE44Hht+r8X+DlN/rOBM7E+MF5mh1NrVXadxmsSYji+fc99URF1kIwGbv9hl55Dd29w9c/mrAwKpMa+2phk0r0TVVMIJuLCKlfyHbyk0BWStiTLI6xjwKj3KiyATSNUuOwHiPUBBnggrkxG6J3XWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=dli4MAEo; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="dli4MAEo"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id CCA3E1202B5;
	Wed, 16 Sep 2026 19:21:37 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789597297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vg6OQ8+DdfdspShr4og6MbmJ9ItaSTD/j6F/ErvZGZk=;
	b=dli4MAEouCf+SkFIiSVb48p6LBjx0u28AnFEy8GlBVNNoFifwj862/zkEqDvrIM+FzCmZG
	D1GBPDDKkQCzFLrqsZjX7aCKsfKOKIqiozPXPdg17k5nT8jXsK8045SVet3idiaTmsLOVE
	I5qImLuEqLdq6q/Csw0EmuV8XCBgHkNGHLtM9mSrSC5kDi04zED38LijqUjOJrc5ERRE5R
	UhKN3x9TLAPtQ/nauGxPdI1GzwoxXJRPwOcFSV946iOW2l14TTRHRMJUq5tzIP0lGmiUMp
	6eM5Gq0cbUwZDSP5tSErzWt6FFJDzy9d/Mv982kQDDqCL6eqkYsu6mGRJKQk3w==
Received: from 186-210-028-117.xd-dynamic.algarnetsuper.com.br
 ([186.210.28.117])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Wed, 16 Sep 2026 19:21:37 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2026 19:21:37 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
In-Reply-To: <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
 <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
 <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
Message-ID: <4932edb9744774faf102704ccbc8cdd3@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

On 2026-09-16 19:02, Andrew Lunn wrote:
> On Wed, Sep 16, 2026 at 06:15:00PM -0300, Matheus Alves de Almeida wrote:
>> > If the firmware cannot be written, is the device dead? Should this
>> > return an error, so the caller can abort the probe?
>> 
>> A timeout while applying firmware could indeed indicate a PHY access
>> problem. However, firmware loading failures are already non-fatal,
>> and the callers of r8169_apply_firmware() do not propagate errors
>> either. Making firmware application failures fatal would require
>> broader changes to several r8169 PHY initialization paths.
> 
> But you are making such changes, returning errors up the call chain.
> Why are you making these changes? We either assume nothing can fail,
> so we throw away the return code, or we should assume everything can
> fail, and propagate the errors.
> 
> If we assume error can happen, if there is an error in firmware
> download, isn't that fatal? Should we even care about care about PHY
> read/write errors if firmware download has failed? And since firmware
> download is probably the first thing to happen, if anything is likely
> to fair, i would expect firmware download is what is going to fail.
> 
>    Andrew

You're right. It is one of the first things that happen, so checking it
makes sense. I will make firmware application errors propagate up to
rtl_open() in v2.

Matheus
