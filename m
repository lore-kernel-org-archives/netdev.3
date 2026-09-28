Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341DF495AC9;
	Mon, 28 Sep 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590312; cv=none; b=cnzCh5CANRAW+yGF1t43NoMsJni9YSPXej5sqsBazZDc4y/SalwHByJxf9lwg0zMmKX1lrHyr9ZWDqTPYoqr1CT6d8lhzv9LsgnkB/2lgQbfWZtFCDv+hs7bcJGDmt36154tHCy+ITOX3M+NYKfH/Fcx6VTxXet+hxNR9gSvcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590312; c=relaxed/simple;
	bh=ug9+vDb4JAvcThVCQioo5T7rt5lj00hB9m62pZsMdfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV1h/2VCi5uJH3BvGD2Kw5uCaZtPrDFVKLkIY/SJj7KIKZq3hyPjYzajc9SPNO35HOMJMcFaDl0BwTXrXSt6doU4hQ/2yiDe4JnBCcKry/yThAvSgPVsn13G0NyT/OLXOh1AQLF78c/fPocKpffyOdTK6xfCCPlN4oiuPX133FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwoVBfyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwoVBfyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EE21F000FF;
	Mon, 28 Sep 2026 10:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590310;
	bh=tthv4QNOxOyNYtXYDtFNIpSdoxUs9R0nFoXW+8tjMSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IwoVBfytMJ26vx7VRAjMPhHT0Ffqs9BQ2ZYP5kxEBmUKcaENGeb7zDmVhkFzibn6v
	 FGbmEXCW2QqchMYgGz+BAGy01o3uVy2GPxor17HloaNN2XR86uXtZccdGBPIwnUfKh
	 tWzlQ/+SpPqsAtvY3LPK3BzBo3StorOtd+GS3cabBU2BTMW1Jkw5oZU9nKz3SLB+tW
	 DhcMb81PbLLGB/Je4qZCirvJq/uEC5UWHsagVyNJYbIhnTHTnABuzc3xbGKE/CA+tg
	 4lEqXPf0pyEt8il2auF3DzVUOPuaecCCTLSkEFpIvyxPDc+ckY/S8tVYMSxOlIyiFt
	 bog7FN7tam35A==
Date: Mon, 28 Sep 2026 11:11:43 +0100
From: Simon Horman <horms@kernel.org>
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: make ports inherit the switch base mac
 address type
Message-ID: <20260928101143.GO13925@horms.kernel.org>
References: <20260928045012.30178-1-quentin@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928045012.30178-1-quentin@q-lab.dev>

On Sun, Sep 27, 2026 at 09:50:12PM -0700, Quentin Freimanis wrote:
> When the switch uses a random base MAC address it does not mark each
> port's address as random:
> 
>   $ dmesg | grep "MAC addr"
>   sparx5-switch e00c0000.switch: MAC addr was not set, use random MAC
>   $ cat /sys/class/net/eth0/addr_assign_type
>   0
> 
> 0 is NET_ADDR_PERM, so userspace thinks this is a stable address. Fix by
> tracking the base MAC address assign type in the sparx5 struct and
> applying it to each port's netdev.
> 
> Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
> Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>

Reviewed-by: Simon Horman <horms@kernel.org>

