Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19A2ED846;
	Tue, 27 Jan 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518572; cv=none; b=uy4Y0+QvEwjSP2tDEVL+fTeeWW88UrWzTTHEyYIunEUf815seq4dBvP1dqh/s7YoG7CxsvY95CqEdg/i2IW2IK44WkktX92emInumnl8esbPehmIrZpY98I9G6iy1Lx0HX7Zo+pLQFOVP15lWYO/dCGNwCJnHBJyMWo4v0Zbs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518572; c=relaxed/simple;
	bh=fEXSkBQhMsjQx3oOttSGODpYBBDiMcCJoKm2GlsgL40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdUPZw7d8k8MkSPYN/FHCD0cu3ob04er2rPQFPK6mc6rigH+wDX+yHdg212aHkWQQpWzQ7mpRTGfkjsLFDcLoM75oU+SHWGwXj4aHkW52RT7gxTfl5TJVyEe/aGsdglhduvGR+rPhTQNIsX4ytZI5QX8zDUON5RfqoIGpoDPb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw7NkTMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw7NkTMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C2C2BC86;
	Tue, 27 Jan 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769518572;
	bh=fEXSkBQhMsjQx3oOttSGODpYBBDiMcCJoKm2GlsgL40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mw7NkTMJnqT9vfiPPVWm1tpsOjm2NmIFfn9n349vwariC7Xp0fwi6zAXPTqr+eR1R
	 JjN9v8moSRiwKsz2BE9E4wcLmOel90g+O0uQbPzF4OorOc+8r1nU8igN3Omvq04np1
	 K4K7+FP0qOChgJEX9apOjtgDga5Htd6QKgUnkeMDpYIukZSXF2JpKa5hwUu68gC0YQ
	 Hr3eNJKpGmxxg4c7Yo2a7HGwv4CJLfRFbH28Rh3dJCJosD003tFHX1lLyWCI7goPHS
	 h9WdDNh44EOD/Ds+elpM4+thlCxWQGpgSbHHbMFH0/equGsJy8ntUjBVbSENgVTqeb
	 mqwlPX3Z3o1Mg==
Date: Tue, 27 Jan 2026 12:56:08 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <aXi16M51PIYl1vfR@horms.kernel.org>
References: <20260123065842.53669-1-enelsonmoore@gmail.com>
 <aXdvRs1hAC5E4Dex@horms.kernel.org>
 <CADkSEUiuANFNO9-A_wp8h255o-+MO6yGTy8iWt+25p0zXLyHxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUiuANFNO9-A_wp8h255o-+MO6yGTy8iWt+25p0zXLyHxw@mail.gmail.com>

On Mon, Jan 26, 2026 at 09:37:48PM -0800, Ethan Nelson-Moore wrote:
> On Mon, Jan 26, 2026 at 5:42 AM Simon Horman <horms@kernel.org> wrote:
> > I would slightly lean towards splitting this patch up,
> > say one for the multicast changes and removal of related #defines,
> > and another for the remainder of the #define clean-up.
> >
> > But that notwithstanding this looks good to me.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi, Simon,
> 
> Thanks for your feedback.
> Would it be appropriate for me to reuse your Reviewed-by tag for my
> split patch? (The only other change is to use netdev_mc_empty instead
> of checking if netdev_mc_count > 0.)

Yes, that is fine.
Thanks for asking.
