Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1EF3EC82D;
	Mon,  5 Oct 2026 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235136; cv=none; b=eSM84vnigRy92ia3bkL2q5gAmeTLqr+RVS48bkupAtcLbVvny/bVOIoQtmN0HO5Kwr+7vWmWpGTeCExXzgUPWSNwb0gF8zQexOE70CtKz8Z8Kq7z+UFzbBEsBYviNWpX7xsz3Csjh2pMuisEqVSjpB1/SOkwkzdR2SGYvcfy6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235136; c=relaxed/simple;
	bh=vRsYo0wkKnNQnOT4mtIV+Z9lDQm1mC7uC/SG0UxRKWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQdS2bVzfKVMxiSrsgiMVWlX3pk5fmFItIDVHVohhpoN1Cx+0ZpiYmNz3IIDcxDt+DnGVzDUd6rlMY0jCt20lDOiAm4H7AwwNCjiWzoXY857Xi9TzMUsRpBs3rz91Npe7xGkpzV6BzLC2RY1V5ASKFclAHGDXoBzMuo5ge6ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF6+THh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF6+THh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0CF1F000FF;
	Mon,  5 Oct 2026 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235131;
	bh=XZOxIri3ww3bedA7hdQqfiZk8oMD9FYJ6/aNOkgIZeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oF6+THh3hi44S0oG2/xEhLocfjSwOHufDfRJ4Ism+K2r8lFt49OEOo1IN4FIfZRNX
	 FTbm3nznEZuNbkB1xVHuNss5zEmT0k1MtvoCfWagGTORsRtGigCWNBPm+EydbSiCyF
	 NxV4qVlCtm+Rt+c2L7afJD/xI4zGgdCxwOLArApCfh+ZWjAvsVuMc4WYDUM6tR3Hvq
	 Nx40DNtttRBVq+BFgd4QfcZUYdi0tUyY6AV51S7pT8tQldkQfmG6p4qVOXDy5Ku0GB
	 SvsawBMUkE9PvIPBpOz7+czvcQTzaVZlLsXDVdkThAmtfDEHUBFsfJSyFVXiNDXp0Y
	 SrlWz4FrBukMw==
Date: Mon, 5 Oct 2026 14:18:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: ipv6: seg6: report lwtunnel setup errors via
 extack
Message-ID: <20261005141850.278fdefb@kernel.org>
In-Reply-To: <20261005140637.644840-1-g.goller@proxmox.com>
References: <20261005140637.644840-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 16:06:34 +0200 Gabriel Goller wrote:
> seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> so "ip route add ... encap seg6 ..." always reported "Invalid argument".
> 
> Attach an extack message to each of them. The checks themselves and their
> return values are unchanged.

Why not use _MISS were appropriate?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005140637.644840-1-g.goller@proxmox.com
-- 
pw-bot: cr
