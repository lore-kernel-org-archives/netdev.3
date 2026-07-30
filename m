Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB739446B;
	Thu, 30 Jul 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445888; cv=none; b=fpAmMyrDsf8lZnHu+N2R85gjtFptOLii9LhAoHKvgm1ed79QLPRhT4iLvx7N0EBXcofEDsbSrAXGJii1XH8oMDpbS/9/SzGOAapb5BRC78pTmaNEvjVMxf8qKMMUUiE7wj+A/v9I4H3svJjcYW3dWjWNKXrt7LnxV6ePlide+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445888; c=relaxed/simple;
	bh=vguYnrv968SIFndWBxf3ttUcQ2HQUqM9AQgTLfM5au0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2RDoYq9jF85cczsOQKGEpmSiG3T9Ds8jJgNY15TC7WtOHT8dfKYPNqyX85xlSbSdPgrkrYidqJIliHknjE2AgSx6kT0j4IIoRaKIg/mqc5A3Mu1/ZxeaxUVoJ/fNCLwDfFvebHZTCkEDesQUvSOz8bpaPEa5ivGSQ3kUvnugxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4YiJRBOW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4YiJRBOW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=09fcXTAgsKEUEyRixaZS58XnfkzLWLnI31Z4WuGsMbg=; b=4YiJRBOWtkIu9AD+Oc4ZCVzisI
	ukmi0rpfrd/RjxDifadSDc9pdryFAwbqMpMJx2As0mleUhsCKNmnf43fHxJJebP+h7kypYIYv84hr
	udbL+lF2KMcv5+jyn9khD9zLKVEolmx0TDeIHt8rWI4Z0sCkSSdpQm33XqsqGBzPuqWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpY26-00F40m-GW; Thu, 30 Jul 2026 23:11:14 +0200
Date: Thu, 30 Jul 2026 23:11:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <c7a20740-c34d-4812-8d36-09af7998cc35@lunn.ch>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <4703e62868c862be4cef4933c7a7466310acee7a.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4703e62868c862be4cef4933c7a7466310acee7a.1784945329.git.daniel@makrotopia.org>

On Sat, Jul 25, 2026 at 03:16:03AM +0100, Daniel Golle wrote:
> Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> SMDIO register access. The switch's MCUboot bootloader exposes only
> clause-22 registers; the clause-45 MMD interface needs the running
> firmware and is unavailable while the switch is in MCUboot. The MDIO
> bus lock is held per-transaction (not across polls) so that SB PDI
> polling during flash erase does not starve other non-switch users of
> the same MDIO bus, such as separate PHYs providing WAN or management
> interfaces.
> 
> Unlike mxl862xx_api_wrap(), which takes the bus lock with
> MDIO_MUTEX_NESTED because it can be entered from the accessors of
> the switch-internal MDIO bus while that bus's lock of the same lock
> class is already held, the SMDIO helpers take it with a plain
> mutex_lock(). They are only called from probe and devlink flash
> contexts where no other MDIO bus lock can be held.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
