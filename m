Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92C317150;
	Fri, 15 May 2026 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850856; cv=none; b=DvSM9Zq8ZwRHMmICphlOG1wLCLOLSakyNesBtiSImlFb3jW9bw6MwS25N6breYW2J+OdqSJ+CvTdvgq198b/ypn5BS6uy9xzo97m3TkgryuRh8WNtxF+ohS84TcvAWRZ+ZEgWoiRXb2lQeF9u+r2nImgflabkE49XuZRKwwY1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850856; c=relaxed/simple;
	bh=K8+IOdK6mfi+tlOyO0LvfPWKRPiT10gc6/h3f/mbymM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX1ge1tzvF3VwFzSghjZzlw10dMKCF6bJV2zRvOTbLOOP1tSAalkwGARAqB3El/biX02ZCcGaoDBaj8FJ+jnYbE1xnlnwfstFINlZAiot0R+VzU8QbDEVHyfXSTqNt7b8TQLx6u6THst4okyp8xUpAwuX+QLjuGhJb4VxfKE+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GDb9KE3d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GDb9KE3d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1O3Uv9ZACqlT1DjzNL55O3hGy5mm/f60RLVWQ8N0rvQ=; b=GDb9KE3dc8qmyI0VEzFmQ754UX
	AhMwsKMwKCOBjsy2MY+59KnOdLreZtA9w1qLHxsKCSSQuVtbXRKdfyj0QKkD5afAtyMA0LK3ObL30
	qlfGJTJDYfLT+pMTnzVEQDLgvaRPUTslm1VeNk6uhfDBBAjuw/n940U/2W8iRDykFW8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNsMg-0034A1-U0; Fri, 15 May 2026 15:14:06 +0200
Date: Fri, 15 May 2026 15:14:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine
 delay model and HSP register description
Message-ID: <0581dba0-c500-4a21-935f-9324692fce78@lunn.ch>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083136.175-1-lizhi2@eswincomputing.com>
 <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
 <29bee81.8323.19e2a8bf746.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bee81.8323.19e2a8bf746.Coremail.lizhi2@eswincomputing.com>

> This will help determine whether this change should remain in the net
> series or be moved to a follow-up net-next series.

net-next. It does not fix anything which is broken, and bothers
people.

	  Andrew
