Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F43234994;
	Sun, 21 Jun 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782073362; cv=none; b=sqRTaJDKDZiV4rpUhs/tBKjw6giFPWgjAQYXfFByddJ1dba6+OYsUp1sa8aUGcrStHW7Y9z/3kabb4MAPuuQgunDCVxPmkVSIIe2aGV4Ipay6pGrD0j1+Dhv9lf/T+y+Z6BLyr/ueeUPe45NlDNU2XptySe7cvNNne0sfrjIW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782073362; c=relaxed/simple;
	bh=KancFRHJ6mUiJmokl5do0uC7J0HhqofDFYuyZ4ujAcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gESaqQIIp/UR2+fljVEkkEuoF+S5gSbJOXI2c+Pq5x+0eoiZnLpXHLCqBClTSNPBDjv3yyuW27glVKhV631j6+pgjypDrN3v6vMoBiOqM+9WbP7mWFlhY0TsSegZ+b6AsaQVJxZSq71QYGlUZTdsTvKZ0azThD8Do0ffl+4ls/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II+sHAPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II+sHAPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6BD1F000E9;
	Sun, 21 Jun 2026 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782073361;
	bh=KancFRHJ6mUiJmokl5do0uC7J0HhqofDFYuyZ4ujAcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=II+sHAPjfYsbR9RUeQP/GeJJIC5XHYZ5nL+r1PyiefjgrtYZi4lkswmOElbFH8UJK
	 2zCknG/OV8Eb54zJrRYg0pgeObE1yu4KhyPP+tY+MQKsnB0W4aplLsgp01OgCeSJKd
	 mfv8ONyvnS2VqoWCZdvb0Iqn9v1u6KiJgDfQfEfSu6gP0VSA5jl+M57Fzv8q/HJW0E
	 +RTChcKH+xQWO+J/lreiZWDEekBpzjl0FKp6WDrbD1w7H2BAuB6ofauW0Ydn9vgQyE
	 mnNlz3oOGaXoK6Jjpi+2cRLUZPVr71kRphVXmlSOcT/IE+OEsYKILt8jpD5sexNbYZ
	 jji7YE3v4ebyg==
Date: Sun, 21 Jun 2026 13:22:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5ZGC6Iqz6aiw?= <wellslutw@gmail.com>
Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
Message-ID: <20260621132239.79000dae@kernel.org>
In-Reply-To: <CAFnkrs=kE3thiFLaOULGv3n_KgR-r5T4vB7hxJsZL4iAihO31g@mail.gmail.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
	<20260618175619.671a4025@kernel.org>
	<CAFnkrs=kE3thiFLaOULGv3n_KgR-r5T4vB7hxJsZL4iAihO31g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Jun 2026 12:38:06 +0800 =E5=91=82=E8=8A=B3=E9=A8=B0 wrote:
> I'm sorry that I can't test the fix.
> I've left from Suplus and don't have the relevant hardware.

That makes things harder.. but you don't necessarily need HW to review
most of the patches. If you don't intend to serve as a maintainer of
the sunplus driver please sense a patch to MAINTAINERS and step down.
Right now you are listed but don't seem to be fulfilling the duties.
Or please review the patches to the best of your ability without
testing.
