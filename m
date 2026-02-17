Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4681FC7C5;
	Tue, 17 Feb 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324427; cv=none; b=OosNpZgNHegNcacL1ZKb229EgutLswsc4MTUDScG/tXgeCpkQVN1AACUD8IhcosN/sc72n4310/Ay9GBLZ+U+Tu5tds2yzYD3qwNPBmKR2o1FHAG/ZstZAAAHZ/tPyhqk/ACJMHPLMBxqnbEhDTilaNr4E0wxyEGhq4APL5voRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324427; c=relaxed/simple;
	bh=q6Fo4ZwzmUE3lUt+zcQu5s9lDaBPTZzG0ajXYOcqaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGK4xLaqu4l6NWtL2n5gj4wPjf0GKP4tdC1CRO711BoavrlNPnPX+YNJKlQVyoUgK5VlY2KUgiM16zKzFXCAqLR8MWIAuC/aGZqS0RER/S5wowGw0B1296c337VJGBlekryV2LskjuibovqmLkFRPYnRafL2ErTjzADF/mMoyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=palePRL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="palePRL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D906DC4CEF7;
	Tue, 17 Feb 2026 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771324427;
	bh=q6Fo4ZwzmUE3lUt+zcQu5s9lDaBPTZzG0ajXYOcqaTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=palePRL9YBCK5h10Ts4JFCaZdGBqpOYL1BzQZduHFldePB7esVY8W5iDdwlUCyueT
	 9Sl4RAXrDauV0Jfvq7qm6A9Ed6/9UjBNedpawj3s6GzDIeoxIpLAi9ECOKitvV2Ysf
	 qn1S1302CScHp/YQnDLlQN2AuprOL/WgHph4/fEM=
Date: Tue, 17 Feb 2026 11:33:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH stable v5.15,v6.1] Revert "wireguard: device: enable
 threaded NAPI"
Message-ID: <2026021715-confetti-endanger-21eb@gregkh>
References: <c05f3968fa63b630ce22d65aa03e6dcef4bf4e83.1771277247.git.daniel@iogearbox.net>
 <CAHmME9rsvaargjbZO8SkswOToUATuWpkQDVykEUty-kWPyu7gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rsvaargjbZO8SkswOToUATuWpkQDVykEUty-kWPyu7gA@mail.gmail.com>

On Mon, Feb 16, 2026 at 10:33:53PM +0100, Jason A. Donenfeld wrote:
> On Mon, Feb 16, 2026 at 10:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > Technically, the backport of commit db9ae3b6b43c ("wireguard: device:
> > enable threaded NAPI") to stable should not have happened since it is
> > more of an optimization rather than a pure fix and addresses a NAPI
> > situation with utilizing many WireGuard tunnel devices in parallel.
> 
> Indeed.
> 
> > Revert it from stable given the backport triggers a regression for
> > mentioned kernels.
> 
> Thanks.
> 
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> If that helps with Greg queueing this up.

I'll go queue it up now, thanks for the revert.  But it's ok being in
the 6.6.y and 6.12.y and newer kernels, right?

thanks,

greg k-h
