Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A703DAAB8;
	Fri, 11 Sep 2026 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093397; cv=none; b=LR7RV8SVtdS2cDcsxHymd0AcwZqa3W+wSzS5zf7bNXAUT4vt0Ss/wQNhB60fjgt2+qCBv/wL19ge9g5qfrhzjJp6rlcPKJh+3n8JlnCFdgO6im5MaVfqddU2xs9wJiHNM+UjoIDAia6M4H30WmQw2O0O+XyyY8h5Von4jjSl5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093397; c=relaxed/simple;
	bh=fdCqNNh/t8QEzfCExY1qXscCqCl40CV63Hc6WgjoXgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQDyy17HnAlHCSe7V/7h+BJtv3YRMOGqA9Z/7D41bH5RoFXpz1npJvQR0PNE3bIt+zVg88Ejg9ELQAuwLu9RFhdfVZif/k3obKJ/vO303GwDZbtT4Sz72U9OXho7FDS6s7JGLodT0Tr5/pGgj4aO9TdS/bL/zVJ4ad9D4GTEYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g20pEYtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g20pEYtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F21F000FF;
	Fri, 11 Sep 2026 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093395;
	bh=FB9ADrlAoCtxjzP97Gbv0Ht7cbGtU2YLylESpFXOJGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g20pEYtmh1kGVXAIAlLv9PF2sMWRGbEnruB23OHEJ089h152YJYVS4P2R0wrjC8Ut
	 phQAd98ifbawHQRZiWAwim0rerzLGwzgDxwJmPKXNWQA1mRDNqpkHqEYmK4AVQhfTk
	 XR1/HYfGarqEfMrAQR8nS++gbwsvBnbr71MDoHlQ/wjrmV9k6pSE9C6l8S85w6gDcQ
	 YnCF2QbuPfbIW6AEqBXgRdWrtZj8UFMoJFVwwEgjXJzPwdH/PGJnLWz2JZ/affHDJ1
	 8evdVAZuOOv6kpC6SqPf6844MfNmXHFEYc6BmEcJPsI6mpaCeK7pN/8iuSkzDPNZJp
	 hagtR3YfCx7bw==
Date: Thu, 10 Sep 2026 19:23:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taylor Bates <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness
 bugs
Message-ID: <20260910192314.209ecb01@kernel.org>
In-Reply-To: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 19:45:06 -0400 Taylor Bates wrote:
> This series is intended to address several robustness bugs found in the ynl
> tooling and the netlink-raw YAML specification.
> 
> These issues were found while writing a netlink-raw spec for the Bridge
> VLAN family. However each stands independently of that work, and fixes
> bugs in the parser that can be reproduced against the existing spec
> definitions.

Why are you doing this? What's your intended use?
YNL extensions for classic families are unlikely to be accepted.
It's definitely not a goal for us to backfill all the ancient baggage.

> The patches in this series carry Fixes tags, but are all in developer
> tooling and have no effect on the running kernel. That is why they have
> been targeted at net-next rather than net.

So you know that the Fixes tags are pointless and yet you add them?
Please, if it's not a bug that needs to go to LTS it should not have 
a Fixes tag :/
