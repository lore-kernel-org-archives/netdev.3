Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D3383994
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021384; cv=none; b=NZvRPy4bJpyjXQ2NmGIVO+FHbu3UhmviAC4RbKpzDwdKqJdhiHALIzVDUsFu5+aYsnnryK4uyIUHQ31sLMZDNuzhQoGL5PX46/JJwOkwDcEgQ8Lvs5kk3xG4E73pp0LA+ZB4OOvxkKYhvcM7m1hEpKqvLYNEzdAzgu+/FbkXt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021384; c=relaxed/simple;
	bh=qCmKAQQz9CoO7XBcOkLPPiHz+xhT6t5hKD77SmbXPqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ch4R98YRmK4buzu4QUOq9nF/DUjknLMZn43RxeyRj9Tn+89hR1uVpuzPY0+JpvM0Xcb260ED5hDBEX46qUBK3Ez1JIcIBn2Agz1xtoLxRoNZ44DTjrGE6/+0dw1ogBUeSF0HchoqlRmWyl6ajBG9j4xJsrTYdFp2h128g9u1IgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duqoKYXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duqoKYXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293101F000FF;
	Mon, 21 Sep 2026 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021382;
	bh=wg6bu+a1SXSaosUWu06gOIMInLxZPkQ9f3IMwT4i+is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=duqoKYXDD2O7FOi6J51oS/8IO7Um4TeMD9l4dq7GTdead2q8E+h7Fwo7sq4rq8m55
	 zN9hRA8KdJ+uxoHbhbmBO6xp+PzSFvbBdeN9GlRj3xvPhX3S1dkKPjrGVl+NppZyXW
	 Dgq6Psy+/mc42fe2HqqQMGiTvQlrbsM8Qw3NrMA0pY2KlAPngLI5LzzgoXdhm+nskF
	 DmfOPpIANEPSdh4xfLsenLNw/JyuCBc13FS9VNo4YdYsnvnzUn/NSu3RK46IGB+f+9
	 CXBiOket1O+ShsWP2e/YdU6od+iD5wVOjjSSHfTuuxwSWORy/fOCqt1moXE3hizYOf
	 9D21kjKmk1rZQ==
Date: Mon, 21 Sep 2026 13:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/5] selftests: drivers: net: check the RSS key
 a device uses
Message-ID: <20260921130941.70ef8dee@kernel.org>
In-Reply-To: <20260921183758.1812310-6-edumazet@google.com>
References: <20260921183758.1812310-1-edumazet@google.com>
	<20260921183758.1812310-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:37:58 +0000 Eric Dumazet wrote:
> +++ b/tools/testing/selftests/drivers/net/hw/rss_key.py

Let's fold the tests into one file under drivers/net/ (not hw)
and add to netdevsim the reporting that let's us exercise what we need.

Putting stuff in lib/ should be absolutely last resort.

> +    for fl_type in FLOW_TYPES:
> +        proc = cmd(f"ethtool -n {cfg.ifname} rx-flow-hash {fl_type}",
> +                   fail=False)

netlink supports reporting hash config

> +        if proc.ret:
> +            continue
