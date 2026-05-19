Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29832AD0C;
	Tue, 19 May 2026 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149664; cv=none; b=aiIp/35JOTl/Uyv7xiewJisN3TVi1q1XAThbEomkSEHCztXTPjNhT1AIZ+4fOks/CpT4s1hNzpFuut6FfDRrVFrjYW2Zmx2OgkyHlq8biPyCws82kHfr6zV46/MwuauT9LV6WK4YfvSuuMgh0NRy6Y+ganORfJW+iN4tO2epWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149664; c=relaxed/simple;
	bh=PQY+cECJ9DOxPHMncgqIMlR1QqMUkQDxCMSXGbdzrOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTT+DU3nhoLqSmES+dLEFP7UHExM8IjH+m+6wGBEdk6lH4/V2Gn0Dx3H5+SQgDZOjlVc4QpprpDl/S0TsAhtEz/ZxcnqsLPis7lYOoZ3QIfsyWuZ3x2ZFlYIX4RIWSvl2D3uXJnEbIjOBVhK3lQt+du6ATP8Xpy0Ph1aBnFWU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYlLGu/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYlLGu/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DDDC2BCB7;
	Tue, 19 May 2026 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149664;
	bh=PQY+cECJ9DOxPHMncgqIMlR1QqMUkQDxCMSXGbdzrOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYlLGu/5rT/Y/1bqQapiOiudPQHgDm2ap1SD8q0wHLFVszCspOM8x/bUmhq/BjsS6
	 EapAkH0T4kMQGj2oqAF4BxwRHrPJKO8+UScPR8/0A+Sez2XmPw5jr8I7SZnXTxX3OG
	 AdOkOc7lijIF8Dl1SmXHNhjRx+bNBzDiKlmf9yIzw56dSosvKsCBsqI3tyIMy0qMU6
	 O/v6Jk016y3IeCX7plx/DSI1ypFc/Grp7Ro3VcD7IQPXEGaD395G4o22BkGzwev0Lg
	 Os4S/Ubd2g/rXTC5Y1iQY1jO8MxBPj2KkImJ4KYvPpMaGIwP22jRA1JclPs1547mkO
	 30/DBYi0ZUAFw==
Date: Mon, 18 May 2026 17:14:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv6: route: Unregister netdevice notifier on BPF
 init failure
Message-ID: <20260518171423.2ad15470@kernel.org>
In-Reply-To: <20260515130517.779406-1-dbgh9129@gmail.com>
References: <20260515130517.779406-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 09:05:17 -0400 Yuho Choi wrote:
> Chages since v1:
> - Unregister ip6_route_dev_notifier directlry in the bpf_iter_register() failure path.

The goto was fine.
You're generating the patch against an old version of the source code.
Please use
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Or for networking fixes better still:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
-- 
pw-bot: cr
