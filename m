Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBB3E1D0D;
	Thu, 24 Sep 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277421; cv=none; b=H8r5vEuG9Jij8VjtZaFOIgswv1gE1O8swIhVHvaR7wpV84TVLvy8bfdHiY/gCiPw5CR5z7oRTmBEZZghyt6AWmimtYxgIxsnr/Sv9b0vaAMoXAe4nI03teFb7b31UWiplRNH9Qx3RHNoC3fQh1DZZIA2xfEgIX1AqwiWlp2BTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277421; c=relaxed/simple;
	bh=ABk/a0ZJeo+bhveUhniq3EYtEEp0+QNiMk2ovo67Uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrISAt9FKX+BoZKnG/cN10pbbvFnvePdXhXuyz/bo9OXK2GDh5X34xFKdPQdHtUDBsaTdu68j5qP+KtuGOhXR+RStIIjsMatMMIXJho0Cwq1zsxFJ2w19JOAJzx2XH57WQcUq+mNM66xOco8d457CC9iMTjNlNzw5MQj+ZceDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UQdZRQTq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UQdZRQTq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5cDKLpM7uWxow/Xj3HdbMMFz9dBw5P3A067HqPQPt3A=; b=UQdZRQTqu2tk5ervOAxVI25VLp
	DjGkHrC6dJTbVddSSSPRgiCJuIhxa5EwVv+RY0HulDPrZbIjbrmV8Gr4f0h22a+jurAiTimBvvS5r
	9ywN0/Hasex/rjuDJmQRWeJWJDlqkF/NSRMX8NSF0aYrUxnngQUfVkDzmvVQAnjn2uFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9ow3-0074GX-QU; Thu, 24 Sep 2026 21:16:47 +0200
Date: Thu, 24 Sep 2026 21:16:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Kyle Switch <kyle.switch@motor-comm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-vowed-roulette-abda42cec444@spud>

> > +$ref: ethernet-phy-package.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motorcomm,yt8824-package
> > +  phy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ internal, 10g-qxgmii ]
> 
> This should be after ref, but also have a vendor prefix.
> Additionally, the qcom ethernet-phy-package user also has a mode
> property. Net folks, should this be made common?

phy-mode is definitely wrong, it has a different meaning, and reusing
it is just going to cause confusion.

qcom,package-mode does have the same meaning as what is trying to be
expressed here. So yes, a common, vendor independent property would
make sense. It maybe should be in ethernet-phy-package.

	Andrew
