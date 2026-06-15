Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D619A2A3;
	Mon, 15 Jun 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519657; cv=none; b=j7S/cYLXG3OraxPXUD6XBTSo9VaHM5km52CMdf8m4lXoGWt6Qz3XYDz3RuTBLNOf5+tTdPGQXzMq9Pe7aGy2uB4hDCGjSp30xiuIHdpyA/uNP507uXVlcuC7Mh0pB4idDm+pvmVD6cT5fLsvI2RZjL0FNEn4WUTPYSwOZubW9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519657; c=relaxed/simple;
	bh=89apKyoVyx0NU3Q5QdL0cWDoy6xVDB2ZD2br42avnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjh6JNJWbT0cSojylOx977iFxVi8V+FO6wPcuZ5HMV0ECJRgGaJ7mKBOmOKqtzX2mY3b+ea6Vkr/9syHR4P/0/GWran8VyO+adjX1cwG8ioF4PIcj9iO3EaTMpfuFQz4GR1WaN+YMlayJQZMv/wFvwLbYX07X+0EhcvfhKj7WBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkt6tDlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkt6tDlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E11F000E9;
	Mon, 15 Jun 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781519656;
	bh=Yq8kBNPmxB2ckY04TeWOViDae28qQtfQoD0vJLW20hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fkt6tDlH+w/N+P4fpIgDcfDg9soPXLOeY6i+dbDff/a/8jd6bT86JVIRvtfQaq2tN
	 d7P82EF5JiVClS0K6GeSUxEGGTxSoO6j0TUktovHCdH03D0H9RxOJxH5TEle02Ho+O
	 nhIBX5Z+QBs0GH1XoFBovFhN+sXw9oqxkxFvld6qcKvZsl4Tc9waTT+35rZNZpIQ1S
	 LmxwnqecSysi7o5oFxS0hUqgLa7sFhrMBnVsc+KetRv50409sZ5ISGV9Ea7ia0QTUj
	 9Hoo/wDBrenEcjkMdyLyQgfsutonXLbHjw8l6jDyoVVFnzDtsp6BN9MlId/snVNTgx
	 yIxmVOUCFH0lQ==
Date: Mon, 15 Jun 2026 11:34:11 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: jelonek.jonas@gmail.com, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, bjorn@mork.no
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU driver
Message-ID: <20260615103411.GF712698@horms.kernel.org>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org>
 <ai_ITHd_xxt7an4q@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_ITHd_xxt7an4q@pengutronix.de>

On Mon, Jun 15, 2026 at 11:39:24AM +0200, Oleksij Rempel wrote:
> Hi Jonas,
> 
> On Mon, Jun 15, 2026 at 10:07:33AM +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> 
> It probably sounds scary, but sashiko finds not all issues in one time.
> Bigger patches and more different included frameworks - increase findings
> probability a lot. With other words, it may more rounds than expected.

FWIIW, that matches my observations too.

...
