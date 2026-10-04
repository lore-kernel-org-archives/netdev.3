Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E03955FE;
	Sun,  4 Oct 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122448; cv=none; b=X+jZxnZnbY70YDN8FAXYq60U6MZe8V1odEwkpBMP8GMJdy348VaaR/ihwuS9fn8xaD7GnU3t1SXVxmjdehJJIc0MzjnCbZ1siwrMQ+ateXDLsNsFehwwH6jkSzftQJnG0ohm+Tw2JliUP8l3QNQKfI5+MywkRvaa1UPQOip3hTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122448; c=relaxed/simple;
	bh=yoAGk41uyL+2q/EUAyhsgEK7XJyTnoQmBabiVHAEjLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URs57xeqRbnY1ZXjdunP4n5r3RmjOGbuYdFleBQrAspxNpJTqQGMxxMEG1WgTnZ5ZgLKRLb6VgHrGPaoG1RLoQADTfSWcuZ/KzJeQg9xwN+9hItNjuRxg5tNpEx/VQh250FgRfy43qu/dsMEqcc2xbYwJ7VyT4HO1r+EI6rGk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S5Ko7OQ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S5Ko7OQ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qGPCAmHou9vxvAMRuDHrjQSidmomP8v/1jtQX0JfNDQ=; b=S5Ko7OQ89AgW8CO4JVltQJy50w
	LwSL9hu9QyujvuZYY6fvVOs9DOkwYol48nenJjVmvN+rF0+xJaB037gVN61bhhT2h214gaH8ONdQ2
	cTrgIY2KyQJCQIo2FQ6GUvX/22y2SItRsk6s1LSnfNfVo30AHIJV8QsoYgzkeudBDXrw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMlZ-008swZ-Ji; Sun, 04 Oct 2026 16:00:37 +0200
Date: Sun, 4 Oct 2026 16:00:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] net: dsa: motorcomm: Hoist type casting
 helper into chip.h
Message-ID: <d48bf178-0a3a-492f-b836-1f3de5640238@lunn.ch>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
 <20261001204851.2576101-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204851.2576101-2-mmyangfl@gmail.com>

>  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  {
>  	struct yt921x_port *pp = &priv->ports[port];
> -	struct device *dev = to_device(priv);
> +	struct device *dev = yt921x_priv_to_device(priv);
>  	struct yt921x_mib *mib = &pp->mib;
>  	int res = 0;

Reverse Christmas tree. Plain search/replace does not work here.

There might be other instances, i did not look at all the patch.

    Andrew

---
pw-bot: cr
