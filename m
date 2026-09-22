Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552753D9C2;
	Tue, 22 Sep 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079026; cv=none; b=arB6LLFJS0Mxlmw1aLcS4JPsIimdxhYNzs0qBrIDb06i7TWIOAGgWdvHesWJIO2MBHnl9/EqUOCdsovv+Lq38RM3Xbsv1gMKrpbj0LyNiv/9wmoHlk+r3gcJuQ863YwIgF59PZJJGtoHAKhBhWBwiK/XQQ1AXGXI+aWGsspMGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079026; c=relaxed/simple;
	bh=JE5bF09adXG/nH4SMmtMhbmk5FMf0BrPFB1V0zr9MKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Tm7xAvxXDe1SZsYNYXE2SCeID7BpEeG4wfyUutb47A17eSNBxUXdReBEYzln0TnLaUKkq0Su+TSJ/aOPKfpBReuOsRIMxdXkt9b57+WbqrK1gIMWCx9GTI+0dlgL+RpJNid7URV4Yp/oeCGN4a2inQw88yiF5UUIdp4l+7qJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lddz+Mz6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lddz+Mz6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F5QcxVqJOnjBbDtIHAhFFpCo7qT9voQ7Pr2bj/R1OJs=; b=lddz+Mz6KDwdP2yoqzae0gEkf2
	vqvZhsJTD08T/pjBJczBRXEB7KIQkbTEt0xO2KuZpExLh83e2gPMGMwWbUfIGvNNYIOaFANhcd/Gr
	+2d8XP3uPhIQ6LSlIVB9LCpF8CeiJ70DLPg9C8/Z84vNfMWnQdFYfj+Uorf39eQBR018=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zKA-006a5m-T6; Tue, 22 Sep 2026 14:10:14 +0200
Date: Tue, 22 Sep 2026 14:10:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: kyle.switch@motor-comm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v20 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <26e31b64-98bf-45d8-8c9b-b7291a3d783c@lunn.ch>
References: <20260917131441.3428554-2-kyle.switch@motor-comm.com>
 <178999667530.2160803.2619551882908404136@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178999667530.2160803.2619551882908404136@kernel.org>

>   MOTORCOMM PHY DRIVER
>   M:	Frank <Frank.Sae@motor-comm.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>   F:	drivers/net/phy/motorcomm.c
> 
> That pattern does not match motorcomm,yt8824.yaml, and no other section
> matches it either, so get_maintainer.pl will not report the Motorcomm PHY
> maintainer for future changes to this file.  Widening the existing entry to
> Documentation/devicetree/bindings/net/motorcomm,yt8*.yaml, or adding a new
> F: line, would cover it.

Please do fix this.

	Andrew
