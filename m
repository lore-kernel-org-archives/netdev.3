Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CB420486
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169403; cv=none; b=PQqmVZuakLhH8zzxgN7BeQyftGrxw50YygyPnjA9II/GXfpyfKj/qBu9BEnmYEmvxGf8KduhoA+d5LYdQxwPCHLI2ZtAOqhIZmXpK7Mb34TNynyM1/eOhov+iwTe8wNwhibUvW/sg4uyQC71BUVwZGtvYl3VjX6RGxkj+aQlLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169403; c=relaxed/simple;
	bh=owxlVv0NTodEMofS187k6m0iu1ihISZwNmC818aAeOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUnO3HBBs+PYrrw6GOKntdczLLNzkgxtyp4aZ/gAb1Piet1cSQ6moWVeLz7HJBvufcvLN7/UURYzQO+48ZQv7hI4jSpRvYd7Mof/Z5V5tOWPaEa/hlPGRtOGhCZ2GpXsC7gIp/wl6BPvubDEd4A/bWzKu2OYbw+AHEBFUW1K4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD/G6nnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD/G6nnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47661F00893;
	Fri, 11 Sep 2026 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789169401;
	bh=TtFPnMV7mJ7HDAksQCDVvS1BylVl7Egm6+ZpOarSR1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SD/G6nnj+or30q+UZXDrs1xxDaBBvwUPRDPLKbI69FK0TwX5RhYkF5+vYr7sLt3Xu
	 vLxjRXWzB0vWnkZ3ydVHlXJrSqNrQEvEAF7g4HGabAPBDd+0H9PIHfBER9CrLfIuE3
	 ELBZGaGaWPNvvqOwvLlAGYmSxuVuqt7MA2J3jElxbQn6HJsUxroq0XsdSnneR1lCmC
	 xFxm5OqCNw1nj8dxR9gVPiqlt2pu911zIMF0Qp5x2iJwzIKg94WJi3L5MguZkGi5/Z
	 5YQ3+cv1w2Yb7MIYjLRjnCXrbHx/ZlvtwbQV+WMSWKJMo8f1G/6jbtto1I8Gtrf371
	 IWF/AI2NBXy/A==
Date: Fri, 11 Sep 2026 16:29:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH v2] Add config phase for dp83td510e phy
Message-ID: <20260911162955.5afea33f@kernel.org>
In-Reply-To: <d304c248bc54092d2302adebc2076ff2a9e7b3e4.camel@sprinte.eu>
References: <d304c248bc54092d2302adebc2076ff2a9e7b3e4.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 10:08:43 +0000 Julien Blanc wrote:
> Add a config phase for the Texas Instruments DP83TD510E ethenet PHY
> 
> The config phase currently sets the following properties from the
> device tree:
>   * RMII / RGMII mode (note : RMII master / slave can only be set
>     by straps and cannot be changed at runtime)
>   * RGMII delays. These delays can be enabled on the phy side, only
>     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
>     rgmii-[rx|tx]id which enables only the corresponding delay.

Clang says:

../drivers/net/phy/dp83td510.c:701:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  701 |         } else if (phydev->interface == PHY_INTERFACE_MODE_RMII) {
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/phy/dp83td510.c:710:9: note: uninitialized use occurs here
  710 |         return ret;
      |                ^~~
../drivers/net/phy/dp83td510.c:701:9: note: remove the 'if' if its condition is always true
  701 |         } else if (phydev->interface == PHY_INTERFACE_MODE_RMII) {
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/phy/dp83td510.c:675:9: note: initialize the variable 'ret' to silence this warning
  675 |         int ret;
      |                ^
      |                 = 0
