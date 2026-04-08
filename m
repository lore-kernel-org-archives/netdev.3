Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C69175A63;
	Wed,  8 Apr 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662052; cv=none; b=WqfDcXEhEW0ceT9RVIHpBeQIeUXSanprr5t1aSeA9ZdJFLVgCoMJ1jtxWDs2ODuPHr6L1Fm+a0pMTJfNnsMOLKIgGHU3xo9YS1GZUYv3VyQJBUPqsxn2WgwbUOh8XdOHxhteBVEnGREQhMR6QBEf6LXeoyvWjBOn/5UUppFUD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662052; c=relaxed/simple;
	bh=nWUmJ78jz61+1bcUgL7zyolq0FXkmqQvQJUVweRxjqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbov4+cLncE96ATFaObZ+3Z/3yQorxaHEyyV+2ixs3qmckoPVT8u+4i7Dslu9q8etMxDk1PCTQCMi6jmdOu26u0FNSoravVHvxAUwOb/rK8OgXs6y1qCJ2d2Mxb4/ZuHUcZkpCJ7OksjCEX3QOCLw0a3jWQU1cjDGyBZ+qBIYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BKQmG4K9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BKQmG4K9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=op+B3ErYB5SBcGjElH6T2ek86yNhHxdxH13kWG1CBYs=; b=BKQmG4K9tJCtjhNAXG6TxT0IBN
	Pwo4XyCDvP0dqFbMMGg5bN2g3GV1rsk+ynecpZfDpMTojaOxoOwd/NZSeTZHHQlw66eksRNuugYzL
	Q7YvSmKjwb00aOSNcrav8Jln9k86I2MYVFd7JDLUf+++tiGHCZRsvaZDBxYXONCnpE6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAUoE-00FJBU-SA; Wed, 08 Apr 2026 17:27:14 +0200
Date: Wed, 8 Apr 2026 17:27:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 v1 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove JH8100
Message-ID: <ad9ee916-6f8a-4cb9-8016-54a02b00c7ab@lunn.ch>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408084416.29753-2-minda.chen@starfivetech.com>

On Wed, Apr 08, 2026 at 04:44:12PM +0800, Minda Chen wrote:
> Remove JH8100 dt-bindings because do not support it now.

Could you expand on that. If there are devices out in the field, we
don't just drop support for it because the vendor has something newer.

If the device never made it outside of the vendors lab, then we might
consider dropping it.

Please explain in detail why this is being dropped.

	Andrew
