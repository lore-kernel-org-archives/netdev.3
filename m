Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB2DDAB
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155838; cv=none; b=prnfoFjJc8IsmsvRfqaYFGxPkCl065hh6iOEbwpgyV7qAE2+DdVsiHgATrR2uUhi3o7PLGDXRgfCdR6UDK2ttMvLEHolQS9JczwyuRNfkdAosQmAiN1+xV374It1uqbiJo1RQgTm+N1hU1K7r7EYrQwFIvyRrjIs+0xjtq5EEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155838; c=relaxed/simple;
	bh=6dVUs8aCSBBMiLx/Tlq471KwXF2N4CoQaZsrXQv1Qwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYSN/Vy0Nq63vIu2cXHl5+oA2rnCk1U48XRzWGzlApJk3XUNzhSLULmrY6fU/wb9G0sUcXp7AVWGMfAAgj6LhvYXUuc+8g2k2IiLdX7UYyXLlITqbJHFEi6VMPFNDjV8tTGZTOk9wMdHJ6m27eu3tIYGKw9Hf89wHHfHDXwS+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTNtkoir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTNtkoir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D97C116C6;
	Fri, 27 Feb 2026 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155838;
	bh=6dVUs8aCSBBMiLx/Tlq471KwXF2N4CoQaZsrXQv1Qwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dTNtkoirIu5F+gcnSZ/qtFvJLTLI3QynPJhobHAyW0bSIZaXCgO1JSHVq3oX7wUCb
	 cWF2LxfYeT45eu6OIa4+kILjZpNWz+znBSxLbyZapzXGlph6M+gIGp/gGHgnIpI8hG
	 gBVD+/JDnvSzP1H6TxQ84IMsf7ZILnEIk8+6r6Xovk6E1d6FLkJylWLQrQliEaqGS0
	 YfAeOB+icc2VvOIDVWY9vOxQH4UpwHkk5I1J2xeUC2/o8NttfBcIrZpAnuJ2VIGuab
	 X/YWLCAurQwLTZu5oUI1P6FBRI1SZ0u+GVEuOWwWBoKV68WrIyaTZgBG6AMT4G2v2t
	 AqObrOj/G0Vog==
Date: Thu, 26 Feb 2026 17:30:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, Alice Mikityanska
 <alice@isovalent.com>
Subject: Re: [PATCH net-next v2 12/12] selftests: net: Add a test for BIG
 TCP in UDP tunnels
Message-ID: <20260226173036.56efc7ef@kernel.org>
In-Reply-To: <20260226201600.222044-13-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
	<20260226201600.222044-13-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 22:16:00 +0200 Alice Mikityanska wrote:
> +	ip netns exec "$SERVER_NS" netserver 2>&1 >/dev/null

I'm assuming you want to suppress both stdout and stderr?

shellcheck points out this won't work, then. 2>&1 has to be last
-- 
pw-bot: cr
