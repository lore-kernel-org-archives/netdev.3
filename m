Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DCD48CFC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317013; cv=none; b=Cu8bqXdSVPuQed5Hb9zJ28ClzlsXdlz1BEhUPr7+fHYKevjLA7CaVxbj/CdmZ3rbbNtx6NWFXPvpSftAf1mUWNC0/b5uYgnaBFB1fR4sDAaNQL4nSP8Fy2ItKq1Q3BFJEdYWd4FMuGsPs2Q+Ep9Jn9wjF604LnXFNtRsGWgruc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317013; c=relaxed/simple;
	bh=WHmyUujvq4aVgg2mLFZf9vF9WE7e0ZDGSrX7CNYC0QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOtXS7I0R36hDoaOVwwMmG/T1Ww0erC6/FXCvxDtpPKojEPFLryIYNtphxxfIanp5ukUQsFPr+Tjjzj0cXPd+zP6H26oItjpI0RQAH8RrMqh1lfASIQSrECUJ6rbIXyvnvaw7MJ/tvFEKyo1nBmGPjeEGp7CFcx696aH/Vada6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Cx7bfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Cx7bfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBBBC4CEF7;
	Tue, 24 Mar 2026 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317013;
	bh=WHmyUujvq4aVgg2mLFZf9vF9WE7e0ZDGSrX7CNYC0QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2Cx7bfMSbk29if54XR3W9xewaH9Zt7JE75OLuWimJy/cHaoU26PQOWnXZUkwg3uX
	 WyIMAl6UKmysry53/Bg4yNTDqeDEHwX29ZaQ/akMnyJKMfSBEeuZSYSvib74Y0UKp4
	 M/A7de0Qq5bq3K8f+Sm7drk5HFladMDN8YHXixprdCpSL2dGXvagGoRPoXVw4cKJCi
	 lnUbPyHLTltJLlfK+I9Q0MeYDFW+JKpeW+w1kZwnUfb2l3M6EHfcEdJZ+I7d/msR7T
	 O7y8fjO4/whoDB1/L/53sa6g9ZESbxTMOcoK6U4PR9HrIIeJ9MeVwadiOkHAlIQ4UT
	 LkgEBIu+cywZg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	kuniyu@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	ncardwell@google.com
Subject: Re: [net-next] tcp: use __jhash_final() in inet6_ehashfn()
Date: Mon, 23 Mar 2026 18:50:10 -0700
Message-ID: <20260324015011.858344-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323011816.3737155-1-edumazet@google.com>
References: <20260323011816.3737155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
tcp: use __jhash_final() in inet6_ehashfn()

This commit fixes a bug in inet6_ehashfn() where the last round of
jhash incorrectly used __jhash_mix() instead of __jhash_final(),
which left entropy distributed incompletely and didn't provide proper
avalanche properties.

> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 109fbf620ad7..0a781cba4085 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -63,7 +63,7 @@ u32 inet6_ehashfn(const struct net *net,
>  	a += (__force u32)faddr->s6_addr32[2];
>  	b += (__force u32)faddr->s6_addr32[3];
>  	c += (__force u32)fport;
> -	__jhash_mix(a, b, c);
> +	__jhash_final(a, b, c);
>
>  	/* Note: We need to add @lport instead of fully hashing it.
>  	 * See commits 9544d60a2605 ("inet: change lport contribution

This isn't a bug, but the comment earlier in the function needs updating.
The comment currently says:

	/*
	 * Please look at jhash() implementation for reference.
	 * Hash laddr + faddr + lport/fport + net_hash_mix.
	 * Notes:
	 * We combine laddr[0] (high order 32 bits of local address)
	 * with net_hash_mix() to avoid using __jhash_final(a, b, c).
	 *

The line "to avoid using __jhash_final(a, b, c)" is now misleading since
the code was just changed to use __jhash_final() in the last round. Should
this comment be updated to explain that we combine laddr[0] with
net_hash_mix() to avoid an extra __jhash_mix() round, and that the final
round correctly uses __jhash_final() for proper avalanche properties?
-- 
pw-bot: cr
