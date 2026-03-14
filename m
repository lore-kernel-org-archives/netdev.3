Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD92FD660;
	Sat, 14 Mar 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504496; cv=none; b=H/O3S4mavDcYecNYZbONiibPt6m1VVYXpGDix9jioWxc0sB356+46Y5Iar9mDw5TF7irOPmd3Rqezs2Yyb3d909zvY7sHSTFJwYpLqzRMb1adRv7wpkX3wtEQjEK9iGpreXF6Up9QGeI2ChHla0Ny5sYJFac+cpAmdz6NG+cIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504496; c=relaxed/simple;
	bh=ExdP+dAYjiIimHv1kpRZMZh/mrpRK0CJBbmfexKsSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF+PRDc0Bzr/0qKJ0fCx9nYAtO9NYd5fgBU1C5KzyRoKEfu7TbRg5Vq9jZqCJo4rRSIFFdfl+DRq+PPqm0Q19Sa5SQr75skuEmDSlAaww09JrbIJ+gsDgS0bnJR0KcNmG79AuYyKSb9ccmbwWiFOtetTV/c6tud4q/0e6x7SBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7s0aMcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7s0aMcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6975DC116C6;
	Sat, 14 Mar 2026 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504495;
	bh=ExdP+dAYjiIimHv1kpRZMZh/mrpRK0CJBbmfexKsSSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7s0aMcsIEaZDtU0C8l7s2afB3W0ytOJfhj2Nex7jwVkUaYgvIGG2KJ5rDsQrNzBh
	 4mfQN7D55/LYAornPIImcBB0/08LEnZRbaIn0KuLYHkoDctzjcWq8BvGPyXlFMKmqp
	 J8FwaV7Qe1IsBEQCJXIEXXXXfRMd9whiczOx/k9/gUli0dGM25ZRnXvRsKl4HfeGHL
	 bBCviMH6kdPMwqra/2ajPgJ06d1amJe3R/C0nmzLEhx9uNmOm5RPbmrLUbkNVUkXNs
	 wjDvrfRSPCDhrJ4IVbbuxFIk/sPXJGrlMf8iGsZBQg/rYMt7pG9sNw7VcGPr9of5QH
	 vOWt2nraNFEgw==
Date: Sat, 14 Mar 2026 09:08:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: macb: set default_an_inband to true
 for SGMII
Message-ID: <20260314090814.290a056a@kernel.org>
In-Reply-To: <abUlANami1hWAfgf@shell.armlinux.org.uk>
References: <20260313142140.4040647-1-charles.perry@microchip.com>
	<20260313190631.382df727@kernel.org>
	<abUlANami1hWAfgf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 09:06:08 +0000 Russell King (Oracle) wrote:
> > I'm assuming this needs a respin now to account for the erronously
> > merged patch?  
> 
> It can be merged as well as the vitesse patch.
> 
> The problem with the vitesse patch is it _would_ break for MACs that
> use phylink and always enable SGMII inband against phylink's
> instruction as the vitesse PHY comes up with SGMII inband enabled.
> Do we know of any MACs that are like that... well yes. There's at
> least one, the thorn of a driver, the poor implementation, known as
> stmmac. However, that wasn't the only one - the patch which caused
> this regression shows that macb also ignored phylink's wishes.
> 
> Are there others? We don't know. This makes the vitesse patch
> potentially unsafe and potentially being reverted if problems are
> found during 7.1-rc.
> 
> So, I think having both patches in gives to best approach for now -
> at least if the vitesse patch gets reverted, macb won't regress.

SG, thanks for explaining! I'll apply this after the weekend.
