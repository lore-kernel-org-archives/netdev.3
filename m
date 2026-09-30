Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46B4D17A7;
	Wed, 30 Sep 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772132; cv=none; b=Ec06Kr5xEx/4vW1XweiuQ6pB5jRiv5/QtQ1g20FDqppzNmUYe1ggjExzrL1d+/p9FQQTrIfws1xKIjDZRthc4kMhuhLWYchspD2FoGoSu9uKLzzJc8ALXijqzoSs0BbHgP032du6sGgUrFxSd6aYaDixBar1JnSgcju8GPJ+yEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772132; c=relaxed/simple;
	bh=K8yFZPtVaq27pZ3GwdZmq7Pyix5CFwKmZvMDSe2iQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1h3eRrTZNJOE8puP6CLS1Droz52/UfzBUiONDFe/gVDJJ0j0kj8DO5V544QRAfoAjVIgTEWak+EvQnF5oj84hJuvfNhamwyH4QkMW2hgox6aBM063pJD4EnXG2ga0fQAS3y0I9NuTAcLBCOGtj+FR/e3krnMMool6ii2dIpgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hxoB9l8C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hxoB9l8C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HipuZZ8U836Z3uRF9YQjUwkQCSQcd1gaCfT0jU0DqRc=; b=hxoB9l8C1W5ivC0DWIx41Ju5eA
	W9xGvGeksF3cNp+coN4K7qUhWTqEeq0ppc/Ef5Rx49h60pXmOJWpd7+62Ga33GtsmYRbL1kkLQ1JH
	n5pkAIkvopPXeEE1MzMuhPr2UAKWxBroEKB99vOn70JyBiros8xsztphNPAaO3wDOMUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBtd8-0089hZ-Ux; Wed, 30 Sep 2026 14:41:50 +0200
Date: Wed, 30 Sep 2026 14:41:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] net: dsa: push hwaccel VLAN tag into payload in
 dsa_user_xmit()
Message-ID: <4975c9db-9fa1-479b-976d-a2920d362145@lunn.ch>
References: <20260930033239.57093-1-singh.amitesh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930033239.57093-1-singh.amitesh@gmail.com>

> This affects any platform where tx-vlan-offload is enabled or fixed:on
> and cannot be disabled (e.g. imx-dwmac). tag_rtl8_4 and tag_sja1105
> both carried open-coded workarounds for this;

ks8995_xmit() also pushes the tag. This is a new patch:

commit ca30cd47fe7fd1a7eabf6ec120b8d142cfd7eeef
Author: Linus Walleij <linusw@kernel.org>
Date:   Wed Sep 16 12:20:59 2026 +0200

    net: dsa: tag_ks8995: Add the KS8995 tag handling

The fact you missed it suggests you are using an old tree?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please set the Subject correctly.


    Andrew

---
pw-bot: cr
