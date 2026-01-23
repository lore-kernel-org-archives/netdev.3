Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349F2C0F78;
	Fri, 23 Jan 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197563; cv=none; b=GwYiEOdmc42AYqlFv8wlOOCEpmMWNiAYvbDwOX0daAV4ZluJn9Scq0sKCSG2gh6T9shsWPvdaigpLJPhJoYsH8rOK52pddxeODinYOasWAmk+Hzo/eaBOqdJEqe6FPVKluiGed8ymGSwsXeZ9VJlc9FbuBjXT7LbSN2a+K/nnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197563; c=relaxed/simple;
	bh=KpWHRkgHxM8ujOwupKUgR/mrJU1qGt4znmoaFr2IaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvoykQ+Il3ucHiLsQ6HU2vk9B59seiePpOVzLFfOsJUuh7wJBqZwdrR5W4MyBDY8cSc5+BqVPOJTKT870l7PDMoskK7DfMZTowH3zDdiAhR7EVNywCslstix6zzzUiyUr7XZzzdzBPZPBau3uY0t+SysSH//C4E5OKri0UUEqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6mZiIu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6mZiIu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8478CC4CEF1;
	Fri, 23 Jan 2026 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197563;
	bh=KpWHRkgHxM8ujOwupKUgR/mrJU1qGt4znmoaFr2IaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6mZiIu4EagJqR86BtSnqeUOYWx8dWdbiP8XsAnj0P17ZxbJmyBy0hKs1Vy0xT9JV
	 AZDeAzFK/A0BPplqn1ttqQ5BqllGsww1zwGhKipIjuArS75JMpAlG8jsrqfikuKztZ
	 DjDeUukHoKWX1nAjqwxvROdW2QiuKOjA1cnh5ZS6hulVuMIqBJrnki5e3pRGNZ4hBl
	 pCaQqzR2KKSEWsaNmmaHqPGsN2vRj1LjFrQ8siTpfTpziI5ty66a3ztHeyEMfDVX/z
	 4SpiHTipvYowFCT3y8EarLe8yJk00OnBVIhbG/+57HnPiYRqSE+Cxx4UDpspW3FQoM
	 UfzCRp24d4/1Q==
Date: Fri, 23 Jan 2026 19:45:59 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
Message-ID: <aXPP9_z3Iu9l4C4G@horms.kernel.org>
References: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
 <aXOsp3T2BC5Gxzaj@horms.kernel.org>
 <20260123101807.27beafe7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123101807.27beafe7@kernel.org>

On Fri, Jan 23, 2026 at 10:18:07AM -0800, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 17:15:19 +0000 Simon Horman wrote:
> > On Thu, Jan 22, 2026 at 08:46:09AM +0100, Lukas Bulwahn wrote:
> > > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > > 
> > > Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
> > > driver") removes the hippidevice header file, but misses that there is
> > > still a file entry in MAINTAINERS referring to it.
> > > 
> > > Remove the obsolete file entry in NETWORKING DRIVERS.
> > > 
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>  
> > 
> > Thanks Lukas,
> > 
> > I agree this is the case.
> > 
> > But unfortunately our CI seems to be confused about which
> > tree to test it against. So could you resubmit targeting net-next
> > like this?
> 
> It's alright, we don't really have any tests for MAINTAINERS in the CI,
> anyway.

Yes, silly me.
