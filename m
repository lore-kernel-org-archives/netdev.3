Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9647CC8C;
	Wed,  7 Oct 2026 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378482; cv=none; b=iaw8wEyAB6rggo/a86Ra1C6kqxW0cESP5l+DHEu7fD0HAo9+K8k/7uKxPCb9kBad4lh2fTJl9g4y+DU9GrAMphThzUeUgv8sXtLY8rIHFumft5VGRO2fNZSFt1GhJ9NYOMBPC7WQjeZR12PmxkbGX2w0k2eFOLQCQAEDJ/TJ3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378482; c=relaxed/simple;
	bh=rcJJmr6UkaVaH3hf3Hr6Zl18UQZS8c38mNXAiMvdzyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3sE3qTCSIJ/h7m/ftai9+MsjeBP2BHvJvdUkiPsUxuCPTQs8VOpPqmNgBPOtSqE5cvmgnqEQLPMbyzE0+Sg3EHRy91VXOX1M9IpmjjnXxuaxPmTcCZYm8eZuZtkzVA4Qcq/fS9R15vK+mvs6zw1xZez+lNJdNhOBWXPbUW5iUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bsVEMzM0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bsVEMzM0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8w/4mogQP7NjT3W1Df21Pjp1DKD/NsiEZgMQYQygdxE=; b=bsVEMzM0Sv/E2aebn1rJLn6sNv
	MHp3d7OXh7rqbnXFnR17Fo3kl1yRMwzXEIzSETJ9y5TRHpCSo0lbqhL17WdAKZOLsBfdF6rGvpakW
	PZN7g07PJCUm913G1LhIzajk1wJER8Azlaw8PsfveBRL3Fd1vBvGvyC1526+mJIlEcuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xERMy-009Sey-Iy; Wed, 07 Oct 2026 15:07:40 +0200
Date: Wed, 7 Oct 2026 15:07:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <565e4b5d-4539-436d-8183-df183a9fde5e@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-4-tanure@linux.com>
 <c70d918e-7944-4229-b997-7f07d924125a@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70d918e-7944-4229-b997-7f07d924125a@linaro.org>

> > +      properties:
> >           amlogic,tx-delay-ns:
> 
> Do we still want to support the vendor property on t7 ?

No. As part of cleaning up the RGMII delays, this can be made invalid
for this device.

    Andrew
