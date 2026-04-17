Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4E2882CD;
	Fri, 17 Apr 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437712; cv=none; b=Z4/MgnBShDxJ8USSrtzkCYhtA7CB0tB9ENTb/My4WLZ2/W2csyMTiqKms7e3qTycMPgnr2XKunqhXOM7SHQRDAf4Vd/u4UG/CHB+yzhEnL/KofJ9TphJWES3PmBhDJQ2c5HDke/bdiQMaMDE8QRDAUEeX4NMRM5eBV0BW6JYaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437712; c=relaxed/simple;
	bh=TYlSqOszeeYSwrMoI/JAgYy7vYiPOoFhR+pIxbvSuvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLu0SOHueyi3IpQYbRIpVgNYterp+kBS8gVHbZ7cNuNBzs0Z/rByeQBPpauS4Atb5+Kmg9Ehzc8L93nynpuxVVIBMuDunhXqA4pdTv2g8CzGJ/cW8xHDeBuM96lSIWpFhJdxzvyY7xYxNbn0lrClQdYnqWR/TSiPGBtD7MwcD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1NPGVzsD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1NPGVzsD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F0v/lr1RlyvCfC0Fcoq03DcmH0KJc601cMR3ZELVMN8=; b=1NPGVzsDzrUAiCb5DHMS9YM/r5
	mJkgVXVKCck1TZ5q+P7b+7O4/deMM85qN0DwnI92Vqlt7jS9H4C1Q4jNzMdmpTK0bMD4f8dp8G233
	2uAywm3sHNp+Vm8QLR6cyFuEBRaBult2zUGAKRuhYPa9BPC5UiCroWqJfgUS9wnCl5d4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDkas-00GQBf-5h; Fri, 17 Apr 2026 16:54:54 +0200
Date: Fri, 17 Apr 2026 16:54:54 +0200
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v2 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove JH8100
Message-ID: <27151bd8-6a3b-411f-94fd-7b1b932b9aa9@lunn.ch>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417024523.107786-2-minda.chen@starfivetech.com>

On Fri, Apr 17, 2026 at 10:45:19AM +0800, Minda Chen wrote:
> Remove JH8100 dt-bindings because do not support it now.

> StarFive have stopped JH8100 developing and will release it
> outside.

Is there a missing "not" in that sentence?

    Andrew

---
pw-bot: cr
