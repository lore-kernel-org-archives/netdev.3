Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E33371CE5;
	Wed, 18 Mar 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867330; cv=none; b=IOzpETT2uxLwfg0ld82ctHvV9eo3bA5F8pgzNeDBKid2DIfvS+jBpOlJr5zJ8miPVgd8g010eIEkn15aYiIJv5FBPxTdHEChxs2tetxNhoeLuJNiUjoOih61KTYpnFrQgUT7fWVaqqZG9bnVVEA6T+MdMeaKGDQ5R77wYa+MshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867330; c=relaxed/simple;
	bh=Fp9bALpijpzXu+imzgpBrk+XvdkS4v41RnkuqBBMaF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCKquHNOjc+8AYvafdPUDOlMrSz4PxPlz3aMnc//VnI9m9YVPYAm6kRlPzUDGfLowSwltFzmjWKEBp7a7oPriLpeemReMBu3gR3OiUZ1dIWCFT1/Ybo6pbOh3zZqc6DdJGswY9G3HoYn67aQI+/Ke63pKC/RrScDX4OlmM0q0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z1VQV0FN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z1VQV0FN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kuoyiBA04+iSz14CVjPaHNmnrcrBPP6a7V1Lj2dm2g4=; b=z1VQV0FN8EHhr8Y8+igyO0s8jW
	q7WKrpZdMXE+1xpafHD065FeBD32JrJQiFzvfPY7dXDCpSZusHB/q5YH3gFU1vZ3JpdJ3+9HG0SzU
	uF0zItgapdYlEyIuTxKjdsoYIO7JSoVBpSICXJPN7S5X1ZKmbh5P8JupMYL74scEVOfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2xv6-00CHrl-Qk; Wed, 18 Mar 2026 21:55:12 +0100
Date: Wed, 18 Mar 2026 21:55:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: add LED trigger support
Message-ID: <b42fb036-89da-48cd-9525-d05a065096d5@lunn.ch>
References: <20260314235916.2391678-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314235916.2391678-1-github@szelinsky.de>

On Sun, Mar 15, 2026 at 12:59:16AM +0100, Carlo Szelinsky wrote:
> Add LED trigger registration and polling into the PSE core subsystem.
> Per-PI "delivering" and "enabled" triggers are registered for each PSE
> controller, with a configurable poll interval via the DT property
> "led-poll-interval-ms".
> 
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Please also Cc: LED mailing list. Ideally you want an acked-by from
the LED Maintainer.

    Andrew

---
pw-bot: cr
