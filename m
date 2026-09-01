Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614C17C203;
	Tue,  1 Sep 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221114; cv=none; b=EGqhjEk1hZyvZ15W5eUbnMi6FJsyWlSftC32u0R0XDvRMb0aikyHqw5PKEfH0wzwaymqG3StNuz5OsN6bXIF5FaDX3UnHNBKWcA+jr9Vu4Sk+hjywfqzkO44VzCWZdbvsalLD820G8cXwLKJvnB3/IR4DuBkdTWWuRaeIP1aQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221114; c=relaxed/simple;
	bh=hO77X3TyTYs/OnkTOB73UN2FUv0AHhg7sZiNSWI7sZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZckAwRqKlnyPMocZM/2F5KIJMCMQwvNwDQf7oNDKdxoRJmqYk0wtllFJZluh49VD9TCCEW7LBncr3U93X1zyIKdgYZ7p/o2Dj5lBx/M1Ato39RX86fQ4jx8XyH2h4EEOyMfo+01AoQ/fAEMaPbG4PwpoX15y50XiQhpY2lI0VAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrhEWBGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrhEWBGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0661F000E9;
	Tue,  1 Sep 2026 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788221113;
	bh=FUpcsGsbA02Y7d3jqN5GtM9Hh4BPN5PWXSI2d8YVpjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FrhEWBGxqcGwspjWh1k3Igcoxs3GHdUaopeeioX+qhAlV8Wj9m4sIxvBkKCdSPnfo
	 Y+z3m5R6H0FPYQcYfAZHIG/3PUqiwtxCrbO70T9lEhcOBvrFYIxmNP7hWlsnW1Uol3
	 hW21yWpK6FJJ+ccH/Pet+YYIDYITsfz2ZskvfF6+ttjJ+ziOCzwTIq6wz8r3l0icnQ
	 AFZNdbd/kV9/ftepmoNLeJjQSZ37VsvgLPjextGJEjx6CIhdMdc7qyXz37In0+gm+S
	 tWgMzhiHthZCzqnKnnHrqS+9bLQYkjD3h8AHSgMVZOpl8uKmAq6nFD+rHE39iERpM6
	 ptnQSBvTU32cg==
Date: Mon, 31 Aug 2026 17:05:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Esben
 Haabendal <esben@geanix.com>, linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/ZYNQ ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH net] net: ll_temac: Return actual error from
 of_get_mac_address()
Message-ID: <20260831170512.416ab382@kernel.org>
In-Reply-To: <20260827012439.162651-1-rosenp@gmail.com>
References: <20260827012439.162651-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 18:24:39 -0700 Rosen Penev wrote:
>  		rc = of_get_mac_address(temac_np, addr);
>  		if (rc) {
>  			dev_err(&pdev->dev, "could not find MAC address\n");

dev_err_probe() if you're trying to handle rc == -EPROBE_DEFER

> -			return -ENODEV;
> +			return rc;
-- 
pw-bot: cr
