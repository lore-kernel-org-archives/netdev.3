Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FCCA6B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188243; cv=none; b=i2r/WXj7cvdOFK+gUBPFZ2tBbcLEiQOxHjjjfV62ETEuTztxWhwIteINE2k5KhxceNiet37vuIi27YRGcEhNZdmpI5dWaON+5FgAcRILHEFSTLwa7GNu2WjQgQ3b9NvHdlZxe/neJL6EYzeTf8pc1w7Fa9CmdSahhalUe59dJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188243; c=relaxed/simple;
	bh=1pQHAjNMa3DKLEoaqvirsb540qyS/ijIEghIj9SK1Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArEwrhDVYT6w3LOI6aECsNFvTQ8RjCSg9M/pu74NjAd6n/Yz9raitQoFCClkoOlJUsCuYCuHUrUfIaq3cpjujFhcoI5ME35MgYJenL43OEstuzj7pKVun1NrqGpJDeTaWvwnWyiThC5luOsoqugGDkgjRkRJySyxCDPNcd08XLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMXDoEX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMXDoEX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD01F00893;
	Thu, 11 Jun 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781188242;
	bh=KzOShb+oepXktIoWmG8bCkb+rLXb4XUjLJM0fydmB28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IMXDoEX6VcWjlJwaSBOBDfr7qyHz8nI7/MFuoypwKah7ft6nohjz3yFzoeHlQ/K5l
	 8TMKGK2a/9/eNRaz3Zy7xeBmrHaZKxFwJLf2xifljUaS7y1zrxF3dbPnheBUVa/0nx
	 Qr2pHzvEEmpe2Q4upeUBDMei+UTzyYgP5LfO+b+OpIQGbmp5m/EPpO9mtWkBKAaVF1
	 F7Tzx1VNFWUuITh3k7QMXCOM5W9AsZydPF4aaa7V84y6TksE7hLF+gRMMJ5Z+us3Ra
	 OiUII/8EoGJWbO0uxRRwEuJPFSsRnIhnskRgw04qWUubXmDfgfM++9ncP8Xp4iGB35
	 zUYH5/0CLYS/Q==
Message-ID: <5d7f1438-4517-4fbb-8f21-18632c1efb1b@kernel.org>
Date: Thu, 11 Jun 2026 08:30:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 2/2] net: fib_rules: Don't dump dying fib_rule in
 fib_rules_dump().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260610061744.2030996-1-kuniyu@google.com>
 <20260610061744.2030996-3-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260610061744.2030996-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 12:17 AM, Kuniyuki Iwashima wrote:
> rocker_router_fib_event() calls fib_rule_get() during RCU dump.
> 
> If the fib_rule is dying, refcount_inc() will complain about it.
> 
> Let's call refcount_inc_not_zero() in fib_rules_dump().
> 
> Fixes: 5d7bfd141924 ("ipv4: fib_rules: Dump FIB rules when registering FIB notifier")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/fib_rules.h | 5 +++++
>  net/core/fib_rules.c    | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


