Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657A34CFC7;
	Thu, 25 Jun 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397220; cv=none; b=WmQqMcBM/4amAAfzgn4+E0TR4S3PF8WnEvJOrBkuFfI4njyOvS+3VW044B5IzzOwAJU1jpXFg/dZPL7J1dIrCJULJ/oVflcsmvo08lOKXlzHTkYIx7xZwEYiQajKMaI1OFLlfVdGsiJKqRShNBq8JvtFoeGSQUg26vzcuAmUvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397220; c=relaxed/simple;
	bh=NYpgmTNR4/xM3D2xd7xhRv2xvwRB2xQPrSf7HWK0gVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVbbzuMsWBKaVdg0sge9Aawuk5sqLW80CmLKEvS54tBhuDsAKmBFI4ek3z2m85ysS1dunJQJkuApVl6xcFzgGQNJ13JCdcXTK8EyPaecEPOeEfFfrATNLMEswSzhg/gBvzAEfwBOxJKnmvrOTvjObCVOBjs4ZphdF0t+m+KFRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NQxE8IWq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NQxE8IWq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lvGPRbXKE/BaYDQ9KX91PEUDNglqp7DnjlN7P3BPN2g=; b=NQxE8IWqFuTtjXZxjBCYSYKE4Z
	LctK1N10bxrphUpmFxye21882PQofNcmD7T0JlPHSGsfo2mzg9cKsQ+5Cx73D9ZaP+j1YQ1oYX5WF
	yKJxlSIHShXNllBta7N5adQJEOU1u/fKNujzZsps+Nkl08Xjcn6xq/wmzsKDTN9Vvfv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wckw5-009FWE-PM; Thu, 25 Jun 2026 16:20:09 +0200
Date: Thu, 25 Jun 2026 16:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ocp: Add I2C control support for Adva TimeCard
Message-ID: <e44ea342-67cb-4809-9ca2-9e551e433a8a@lunn.ch>
References: <20260625133802.11741-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625133802.11741-1-maimon.sagi@gmail.com>

On Thu, Jun 25, 2026 at 04:38:02PM +0300, Sagi Maimon wrote:
> - Load i2c-dev module to expose /dev/i2c-N character devices
> - Add sysfs-based I2C bus control for Adva TimeCard model

A list like this suggests the patch should actually be two patches.
Also, the commit message should answer the question "Why?". I can see
what you have done by reading the patch. But Why have you done it?

> +	request_module("i2c-dev");

linux/drivers$ grep -r i2c-dev | grep request
grep: i2c/i2c-dev.o: binary file matches

No other drive does this. Why is this driver special?

    Andrew

---
pw-bot: cr
