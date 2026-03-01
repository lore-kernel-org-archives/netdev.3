Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE6430BB4
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772384620; cv=none; b=iTfxcKkbIdOHHCnmrYxM18aQlvTHdg68OELMvfZqG7eoxcauDsBTsFqAsAjxasv/nhcYaSxrrIHC2ZV1WLM5dpEE1TAfTKC5nB8DSveyEtU33f/l/i5pxaSm28Bb3XiwfSywISAzsN8XGWSSqROC7YNR5v1I0qqJPvlK6FhJ2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772384620; c=relaxed/simple;
	bh=K/Xgi3931rcBdCh8x0U0yPZqK8F8K08xyahhKbjEFo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSPsI7itaeZwSMqX0iHGoXT0pKd8G0WQ17t+crDwbakBUL5SG4hKnTWQJUM2mEoZjxxrsiZItNVT2f7Q6M3iL7Y/RMI2Ao+JQCdAaf89vAla+hpkzhbf7N0ODRasNoEvNaWlTi9nYLrIqdoR8W4ANfTlMLPLQ2fpuxkMLCfkSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiyPNWWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiyPNWWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D05C116C6;
	Sun,  1 Mar 2026 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772384620;
	bh=K/Xgi3931rcBdCh8x0U0yPZqK8F8K08xyahhKbjEFo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiyPNWWwseicPNpTca6OQkxzyZyGvdNaUKTaK1AHnqeqTEuauGWeB9t6LXKXp0wLv
	 EqckS/XR0vB7huN/qhgalTKKTezWI1inESaBCPa321q1GVPu6YRKJow8xTPQ3fvRb5
	 L6R3eAPb/G9Yj56UyWZuwydHh7GZl6PNvDFKjrz1zRJvsDMUCdPVBleV5tWi5G7ne8
	 lgg1xviGf3M/5RS7DDcxbKydteHSqUAYeunb0JTRxkxppgSNnA1nhrYpWqJyYAPwIJ
	 9HFmrTgTswPVvZvzoALg7lPEb3dEE55V3+t4ISTfnmaHSSc8b+NMMDxna1JDSVJk2+
	 mJ4ppPEPF6oDg==
Date: Sun, 1 Mar 2026 17:03:37 +0000
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	Tobias Brunner <tobias@strongswan.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <aaRxaVEUi-vR5EwI@horms.kernel.org>
References: <aZ_8Adz1m47-yzhp@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_8Adz1m47-yzhp@secunet.com>

On Thu, Feb 26, 2026 at 08:53:37AM +0100, Steffen Klassert wrote:

...

> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index e75da98f5283..b90e93fc1a70 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -11,130 +11,14 @@
>   *	This file is derived from net/ipv4/esp.c
>   */
>  
> -#define pr_fmt(fmt) "IPv6: " fmt
> -
>  #include <crypto/aead.h>
>  #include <crypto/authenc.h>
> -#include <linux/err.h>
> -#include <linux/module.h>
>  #include <net/ip.h>
> -#include <net/xfrm.h>
>  #include <net/esp.h>
> -#include <linux/scatterlist.h>
> -#include <linux/kernel.h>
> -#include <linux/pfkeyv2.h>
> -#include <linux/random.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <net/ip6_checksum.h>

Hi Steffen,

I think you need to keep including ip6_checksum.h
as the code still calls csum_ipv6_magic()

...
