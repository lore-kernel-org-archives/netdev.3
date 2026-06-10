Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F22198E91
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059368; cv=none; b=tphHb016iRSyXH9M/AYwdCQgQLCu9QJFto4IWRTmiJXetS5w6S/SugHGaHhJP+v+t+AQAL5+w/SzQl9Wk8ix5B89OYyI2BY6vfJArEb5/cE11ymCI3Lq2dkbynE7xeyrTUGJKY0R9cuNjBb1Z1tMj+KS7Z1jt114O2FVdb6pzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059368; c=relaxed/simple;
	bh=LcwuuElJeSWryu6sRcjs/ftXOmLB0sJDxYiyLmTlvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgydKr4DAR5WfE8/9LMqtl9jf+2vCEgXuASrGn+dmK6ZpAWWbL5zqbd2WBjMVxByBAYfhVt0u7Y2gOW9eZXRBIBye3p9Nes+W5uAx3uLpDoj0A1qGVP4z8DUu8h2z3fdrdRaZd6fXOR1k9JONZP8hc5U3x20yEePdZUpGy5dpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PublGFB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PublGFB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7001F00893;
	Wed, 10 Jun 2026 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059367;
	bh=MHkTMDERPl1A47UHEZMGRZ4pIvAJRWE46Q2Dedu1Iww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PublGFB2pL8u0VTp5EHqUtAAHETz1l5qwcz8hu6/MMu91vOj/ZSYcK448oKXbs5nv
	 oS6j4C12UCHjc2/qydBmsm4ifei0wK7KPv950pQjT3+Ir08805C0gbt1t7KiAjzwkK
	 x6t8Q3wqKgDbtyD9EZuiN30G6xXX1B39OIa33tCjtvu3YjPP+XLd8goFH2KemNgIst
	 8rQJDT6qnrTCgwMCDvTEruB0kPRHfDWjNVgBsoP/3TIvSb+j7jjHZ2a723j6qko5Hf
	 EkkNoZtEmX1LZi+pbVHDHLq22u68PpQC23gNYxdIqZ5+hC0DN0sirigiLbytbpgHXb
	 oT4gDaVcnTDkA==
Date: Tue, 9 Jun 2026 19:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Marco Baffo <marco@mandelbit.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260609194246.23c66818@kernel.org>
In-Reply-To: <20260608150741.3320919-7-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:
> Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> to ensure the keepalive mechanism is robust against system clock modifications.

Why boottime? Unless there's a reason shouldn't we be using
plain ktime_get_seconds() which is CLOCK_MONOTONIC?

(if you decide to respin could you also drop the selftest change
from this PR and move it to net-next? memory leaks in selftests
are not important)
