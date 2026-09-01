Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B83FBB46;
	Tue,  1 Sep 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229654; cv=none; b=qtKXcaiDuo6vlw7DGT2bu4dCKORpyyyB05ntFl0wFeK+LzaJJQEUG3K+qmwImrqE5wYdCJxqrVm1RJKGEKSHs2VyFu/6DQch6IF+hSCfhqLDQvDx95V2TKgmQbbJ5QntmpDCc+Rw9BDBdEbZ+W5h8cfgU/mkfWZNmhBKl64AbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229654; c=relaxed/simple;
	bh=Mhe7v584R/LptRRkHUOtCefrgqdzU6Q/A4TF2Ip3AAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR0EINo/W99j3StgmtXrgUD2bKNFhMDRiwG/apfvzw+R+th42lSvB9ECtlHbq8K3TFxsLP+DK0ng0Ije3uiUFqLpDTg+BCPCJKtex0ydbgowFKQFfyJbipB1ZCvCli0agMqY4JLtGMysjdHrzJB1SXl81HAfy4SMp7eEOcz08jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jPiNNpOH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jPiNNpOH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hPQ/QWdQE++cI/dDAEep87CH0o6JrpMqbXjWWZ5hibw=; b=jPiNNpOH0wMr8nT9x1pMTr+d3E
	z+4wzGLd1OTDx1WY4AMnOJ39x/Ny76GH6nO5wDSJemlYpvg22Q1W6g8ouHPmFLWOaI5RzyJT18c8S
	JhEilL3z/Rn/MW4xDeQW4EIPtMt+UqvgheuMUbTpv8da4wIBdXvvmzOybMwXX/09Ru4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1EDW-002I0k-6i; Tue, 01 Sep 2026 04:27:18 +0200
Date: Tue, 1 Sep 2026 04:27:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
Message-ID: <bb36094f-07d1-49fb-be2a-ffe126e1b919@lunn.ch>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
 <20260831150816.1020883-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831150816.1020883-3-suraj.gupta2@amd.com>

> +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
> +  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
> +  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
> +  Ethernet Consortium specification. It has no external MDIO PHY

What about MDIO bus?

	Andrew
