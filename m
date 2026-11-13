Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571659;
	b=CZG7Xcuo5nYIM7MHDprg+k5hHKmnQ/QlKgFhTOnFWgv2QnTiQw4HkedBRt9WgA01+SDH
	 4gcUu7NIo+VKXKNWs2p+guGAqONL52nv9meOHVvK8kEoZQLdm82iJG/rHqCClFr30hTeg
	 z5+4iri0vyQy5CjDC5SB/r+6sRY+Gl+gcUt2vUGLlhR/d4fHIYp46zC1WSFHeaAq63eg2
	 GoIRfsfgqDA3POxpYpdUfBtpo9ZNxYiq2y64CagR1p8RjV3ILdxRSkJAy41vqPkN8mMxR
	 ZESVTYC3vST9FXvO+v2cH5xGfDM2WPwBKmtyc5x8oCupozsbwafXvpTcYHzWYSNMU7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571659;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M/tdBgQ276qOnTC1tnvaUWkC2GAHjWLU8rLI1Cd7uWY=;
	b=rYEuCsD8FM80L06sAI9Auu39AD/SF60pPOCYdnajk5/Cnvw+F88L0Q0y3B8uwcv2bMSF
	 j0QrVOiaWk2d/2qSUD9oGxH3gKBe4faPBGY022QYEvm1+1oOShlGlRDMjHb2kxD1OF2Jl
	 KSeoIAP4rXxV+HDksr+l5LRmNSNDs08tSrAFW2VhH1QmnNFKJd6lmZVwOdr28KZsXZDkp
	 l10wk5eFQ2KkYfPmt3PpOOee5ttU2hBeq1cxHO2x1yuM9GtR+hPw6popvUr024og7eIvH
	 eII9J0vaJygTJE9a30kOt/pCAbTaLWEiolcK3G9q231NRVoFVzKwwPKG1v+n2YlQrCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hj4q1j/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6C606A31C;
	Fri, 13 Nov 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj4q1j/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587071F000C4;
	Fri, 13 Nov 2026 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794571659;
	bh=M/tdBgQ276qOnTC1tnvaUWkC2GAHjWLU8rLI1Cd7uWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hj4q1j/0WU1fsmhSwwReSvmnNQUQv54DMpW8oEDBjp5K7uh5V2mAkl7PS7P8ybjhd
	 +hv+C/H76KNIS1JzDdk3snEmeLYucFLS42WpzB2m3FdleLhlRFMUnlezlW44M2NESi
	 aReCOWmpQG47bz8Fe0+lzTAwdBlasA6orrQFLDfNZOsSGGNUc+5fg7vODdtuwP+BiO
	 4X9jOR0yxAUWMA3foSOL2Kv1H0BFI2tsJgcrMYPZiORay5FVcleAZdTesdiaM/3z8j
	 N4Cl2Th/PCoBv1Px8IjUY17u73pSf7xgNdpml6ZHiNDuV/Hf0o3GdBBSvwbtSk3rPt
	 ZDSdsKeR/JMlg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRq48-00000002AM2-20fU;
	Fri, 13 Nov 2026 13:07:36 +0100
Date: Fri, 13 Nov 2026 13:07:36 +0100
From: Johan Hovold <johan@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
	Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 00/14] security-bugs doc updates
Message-ID: <avb9iICZ5dvD7yR1@hovoldconsulting.com>
References: <20261109080240.29444-1-w@1wt.eu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>

On Mon, Nov 09, 2026 at 09:02:26AM +0100, Willy Tarreau wrote:

> Here comes a new batch of updates for the security bugs doc,
> essentially to make it more readable and to address some of its
> apparent contradictions for those not reading it entirely. Some
> additions were made to explain how to send a patch and a reproducer
> separately, and to ask that first-time reporters send a single
> report at once first.

These all look good to me too, so feel free to add:

Reviewed-by: Johan Hovold <johan@kernel.org>

I'll respond to individual patches with a few comments on language that
you may consider for a v2.

Johan
