Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD430BBBC;
	Thu, 22 Jan 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088768; cv=none; b=QVrJ49oA3+XsppQnOJE+zlTaobohbfKypl2kf6mniu9o64FyOd5/4jLqqJZSzPZLf99YatPVCAkR2ZkbmB0X8oCZUpY9/sHCjY7lGpUuSycV1J53qG2h9vJkqKy/p8byj/7Kdw/Vlt9IOuOILwEt4wDnBFGslA/+wHhWNwBkYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088768; c=relaxed/simple;
	bh=LxZLDeHZZJyLWDfio9WfcM5mdisPxNR6sL+jZorTumk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQtRQvgBZ4Fro8HiUtsWMetkiGjmcVXyWo1wnSg+cR9fLiY6PUbdqpod+wKUCgyoi0dWeYcYraOQzYlXT4WDw990aXB3rL05KvxHwKYs+mHpKF/x8baKyESmHyC86PebR5XbS1QnFIVocitarHe6q2hBxp/CWhaM2M9xrWj5Cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1gs/ABcO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1gs/ABcO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XzxhA+Nhy4ZZx54Vy5qeNF2xnFTY+RX8ZG6FavNryCY=; b=1gs/ABcO4f/fJ6sCte6yUQLW54
	F6qevsqoMUi7OHuNNKGuSsNSO0rS9J7tXfCVx5OEI/b08ghbKlloonMqBowJ+b5Z3DwW+Aqp0MnW+
	Xta7d8k3Mnx9TT69ws036tzVSHmsU3hVBpYUv3X10LHOR8A8SqTKQpmQwG7oYP+kiIAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viuna-003ybI-MC; Thu, 22 Jan 2026 14:32:34 +0100
Date: Thu, 22 Jan 2026 14:32:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>

> On EIC7700, RXC and RXD experience an internal skew before reaching the
> MAC. At high speed, this can shift the effective sampling point by
> approximately half a cycle, causing the MAC to sample the wrong nibble
> on each edge.

You say internal. So the skew is fixed, it is a property of the
silicon? If so, why a DT property? Why not just hard code it in the
driver? Since it is internal, different boards should not need it set
differently?

	Andrew
