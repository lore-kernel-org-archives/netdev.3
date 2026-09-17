Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA637E5E7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611763; cv=none; b=VclOck6mpXVASO+sPuZdO2CW5vbxIBGJkyDPfziIf9i19HZT1qPgiBZNBN5NlaUshv1/c3PQqHnzjyaw2KXN6v7pK6bouKuuHQkk0HeLrJTIYgWCcCieZfJP9MMVuzecr41NCZH1ZWCOBEPepkRsib/vdwL7lOhCIXxzzfKUyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611763; c=relaxed/simple;
	bh=HUB6ET0/d1R6a+fL3wKN7/uUzh5DSfrc88/yEkg7cz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk6CEb8QwNjNXi8dP097TG+lh6LY5C5amVElcv5lpAnTRcNvt24dwO3NuYJv2vGPB/Ty+4M8BOEempVGLaqW6G1ITimpPshpAV9rA+jcqvrX3kXIcsuN2oK2cg7XGYtgqjrYwNJnfak215uYyw/IPGJ3WTer2E1Ck8uHjQQePbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqIvVBzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqIvVBzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3121F000FF;
	Thu, 17 Sep 2026 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611761;
	bh=kQ6WYN5SqBi67v6PBOoK3wOwrUayspuHn4SQSlp1N4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aqIvVBziV1iPYfCrdbUP0fdrOEeQuv+2ZLTm3FXeZ375AT3Xa45xhsypCp36dQHOo
	 VYn/9UW/6rUfzWPM/fFER+AljbIRys0AmRQ7p+v62HVHQ0P6OM+i9R3TlfqzGAZNWD
	 xr9n+WPA6bAM/Tj1EbRYOnrGFvoueLv06/GvwaqkRGZVihHVnpMmlTMTHxqdC466Ds
	 4LtGUH2L2xG8XvTgStP1L081bn08Mkat5XGt+xTMq9uZl+4YjDG55DVU24rOtphTAf
	 1kbV66bAgVzPUUT/heWgI/PDtC5w5MOMXTaEMHuxjUvgdqSmJv7pwHP9Sf57k0PBLc
	 EdVBVpLBBEerw==
Date: Wed, 16 Sep 2026 19:22:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: enelsonmoore@gmail.com, u.kleine-koenig@baylibre.com,
 arend.vanspriel@broadcom.com, johannes@sipsolutions.net, mgr@kernel.org,
 benato.denis96@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shaojijie@huawei.com, aleksandr.loktionov@intel.com
Subject: Re: [PATCH] net: fealnx: remove never-true 486 CPU check
Message-ID: <20260916192241.320ea5e0@kernel.org>
In-Reply-To: <178953770825.22033.17119468095020104751@kernel.org>
References: <20260915024638.198865-1-enelsonmoore@gmail.com>
	<178953770825.22033.17119468095020104751@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 05:48:28 +0000 netdev-bot+sashiko@kernel.org wrote:
> > -#if defined(__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
> > -	if (boot_cpu_data.x86 <= 4)
> > -		np->crvalue = 0xa00;
> > -	else
> > -#endif
> > -		np->crvalue = 0xe00;	/* rx 128 burst length */
> > +	np->crvalue = 0xe00;	/* rx 128 burst length */  
> 
> [Severity: Low]
> This removes the last user of asm/processor.h in the file, but the include and
> its justification comment near the top of drivers/net/ethernet/fealnx.c are
> left behind:
> 
> 	#include <asm/processor.h>	/* Processor type for cache alignment. */
> 
> After this patch, git grep boot_cpu_data on the file returns nothing, and a
> grep for other plausible users (cpu_relax, cpu_data, cache_line*) also finds
> nothing.  Should the include be dropped together with its only user?

Massaging the comment is more a judgment call (the other Low complaint
from AI) but the header we should probably remove..
