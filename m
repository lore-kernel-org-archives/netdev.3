Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A9257849
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813834; cv=none; b=WTQxGert2rkASFUQrgb+PqeIP/UFm4wdi4g3fYXRzdfy7yKd8etQXTMkIAPbwbXkY7Hgb2CGiWqAj10H+Nj+fTECGd2jrEJa3YrVvsmMzwGaIp3v/x48Dn6y06cCH/XTqt1D/fLeNC6IDIyr+ss3MT49+MG1EDoXfy5rtWSWl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813834; c=relaxed/simple;
	bh=VTg7o1QSJSXTLbqUbjdYnLZhlv8sh4eh+GSfkNPBFi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKAZxzbnvEBT9HPfqqG6s5fvJOS082YIiTxKWMe3iWIk0aBIK8p4+sbjzDrIn8tJcfRxMpHlK0M+2DXPeH02m4FMXVLP9vtXVZXAD3+5NPYq7pBhe1asIF1CrrvVzay2PKrODP0tSoCZLTES2hUqLvX0+5cT/p9rgvJ2w91BJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFuh/v6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFuh/v6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF3C116C6;
	Sun, 29 Mar 2026 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813834;
	bh=VTg7o1QSJSXTLbqUbjdYnLZhlv8sh4eh+GSfkNPBFi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aFuh/v6q5ER+rRx8N7lwOkdT9QR3VHT/A4VOLiiwCEtP/ehWuS6HCt+H+hnEgzdtm
	 ETgWsN4dcA+wyUfkgAg0NkHdOnDnVDz19OiChbvHZt4nzPurZrOSW7xZjnJNZJShGB
	 i6es8PoFi7n8ICY7ZdQj0nyEns/p/es7/4I/qBsDa2zHQPrc/41KhDMqFYerc6MFrs
	 0mxUhl8DPnTQHVuZihDpib14yEyrcka0nqcq8p2TlXCqMOsBlwFmT9R/Cs9AxY+E2y
	 jr28BI3Ve9i6/Gfs+be32hAbAflRrlWpKt9AZMm/bbQ3DCCrJelPGaiwQu/FGXRrXu
	 hDRGh0+YlCvUw==
Date: Sun, 29 Mar 2026 12:50:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v6 6/7] net: macb: add XDP support for gem
Message-ID: <20260329125032.203ff667@kernel.org>
In-Reply-To: <20260323221047.2749577-7-pvalerio@redhat.com>
References: <20260323221047.2749577-1-pvalerio@redhat.com>
	<20260323221047.2749577-7-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 23:10:46 +0100 Paolo Valerio wrote:
> +	running = netif_running(dev);
> +	need_update = !!bp->prog != !!prog;
> +	if (running && need_update)
> +		macb_close(dev);
> +
> +	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
> +
> +	if (running && need_update) {
> +		err = macb_open(dev);

Full close + open is not allowed for new code.
