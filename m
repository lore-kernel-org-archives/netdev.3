Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D372BD033
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563318; cv=none; b=OJNzcw2O9lt6+pjWVEgSlqKSSNh41YdTdNXhYOiDosxIic9YKBPFbYOl6mCwEl9Dto6APUe42HeMACJWgw398nHDYZOAN/jkPstFMvv+P+z9cjcFGh3hva/yHb4yM06aqEc4mGZturmyZqsYVIu8kXNQni1Oj49T6BjowRtRVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563318; c=relaxed/simple;
	bh=3YflWhYT8t/E7G03E1JX3W2vBb1Yv5bEEpXxrirObqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDzIOnaSv9Om09UfRFWBccS4oj3prxcDYvKDAA0gZUT7hN7kVi7je0yIAW2EEYXLdWOs/CqSHyz4KKcExSeecq+hclq6+PUjkj1H3VbaKMj9WA7R3Ha8Kwq9JOpQ1IRm01uAd9GwD39enh8dNQyyL51aY/MNGl6tEBQSn3Y3Ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN4GXF9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN4GXF9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0ADC2BCB3;
	Thu, 30 Apr 2026 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563318;
	bh=3YflWhYT8t/E7G03E1JX3W2vBb1Yv5bEEpXxrirObqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EN4GXF9UNA4GeNMfwezUr1ABNJttMOEcf0Nkg82YdLWy8E5lQo7fE7/K8jiPSxkiC
	 +uWPzRXGTydMsc4J2hzJ6nOOUdC/2+uuX0iTdfWiROBUffRK0nxeyiaz3STbUntUmJ
	 OnRc9ZrNWgFK6mA4viUOebShiYBkigWivBF+ix8HWdzrOTXIPMFIEiSpf7/XBdmnIf
	 bBxRewimMTGkHrGfbj9XbrZFmYH9HAbUPmvCAs+Ee1w40XvrWdd7Ny6q0563hbBDg7
	 2awj6mRvHI1dmn42hH9KttMO0dbUsFCSayPKwdDuqULrS7fjOJ7FpxyOc6Tqapm5iv
	 g60ZSnTk3EV7A==
Message-ID: <6e00eaa5-a4d7-45dd-9d90-fb319b76c9fa@kernel.org>
Date: Thu, 30 Apr 2026 09:35:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260427081953.364819-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260427081953.364819-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 2:19 AM, Eric Dumazet wrote:
> Some fflush() calls only make sense for monitor programs.
> 
> For other cases, forcing a flush is expensive.
> 
> After this patch, ip, tc and ss are correctly buffering most of their
> output when redirected to a file.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/utils.h  |  7 +++++++
>  ip/ipaddress.c   | 12 +++++++-----
>  ip/iplink.c      |  4 ++--
>  ip/ipmonitor.c   |  1 +
>  ip/ipmptcp.c     | 10 +++++-----
>  ip/ipneigh.c     |  4 ++--
>  ip/ipnetconf.c   |  2 +-
>  ip/ipnetns.c     |  2 +-
>  ip/ipnexthop.c   | 12 ++++++------
>  ip/iproute.c     |  4 ++--
>  ip/iprule.c      |  2 +-
>  ip/iptoken.c     |  2 +-
>  ip/tcp_metrics.c |  2 +-
>  lib/utils.c      |  1 +
>  misc/ss.c        |  3 ++-
>  tc/tc_class.c    |  2 +-
>  tc/tc_filter.c   |  2 +-
>  tc/tc_monitor.c  |  1 +
>  tc/tc_qdisc.c    |  2 +-
>  19 files changed, 44 insertions(+), 31 deletions(-)
> 

no longer applies after merging main to next.

