Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73244562AC;
	Thu,  8 Oct 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459182; cv=none; b=e/C80okXNDk7Z6u4ijIsbVdp0sM+8UaCWXSwg+U3oOmTOqddXxxIy3sQtEnk5570FqwTPcvguuo/C2/x1YA1+1H1lTHKuYwkQDuqwzx48PuTV0udbtvLXFr2/10nzMW4qd7oxqRBMsIP1bPx3MaVowEDISxAj1V6tSfR3mQ2BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459182; c=relaxed/simple;
	bh=KUJp+kW5eAWQKOFTGG+3edEQLI6tkQPYxyAiQQqYNjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQPH9N4HuOd2LkDyuE+hc/KJ4w8Tgmp5VTRGGiQINI+yvP1SIPpO0SmKiA2G2MFRMs/L/4MnjEEUuALR+wlRr8It/ngePymEGAneswUZk9wUhx07ZGRw90LF6c4zVjC0B0MFpdHEoMFyHNq47jRJoN/eoT50p1Ydqev6c9eRSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3E38F46482;
	Thu, 08 Oct 2026 13:32:52 +0200 (CEST)
Date: Thu, 8 Oct 2026 13:32:50 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: ipv6: seg6: report lwtunnel setup errors via
 extack
Message-ID: <asd_O9_pH_TE2apO@luna.proxmox.com>
References: <20261005140637.644840-1-g.goller@proxmox.com>
 <20261005141850.278fdefb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005141850.278fdefb@kernel.org>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791459171217

On 05.10.2026 14:18, Jakub Kicinski wrote:
> On Mon,  5 Oct 2026 16:06:34 +0200 Gabriel Goller wrote:
> > seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> > so "ip route add ... encap seg6 ..." always reported "Invalid argument".
> > 
> > Attach an extack message to each of them. The checks themselves and their
> > return values are unchanged.
> 
> Why not use _MISS were appropriate?
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005140637.644840-1-g.goller@proxmox.com

Makes sense.
This will make the output less user-friendly than before, but I think that's fine.

E.g.:

	Missing required attribute type 1
	RTNETLINK answers: Invalid argument

> -- 
> pw-bot: cr
> 
> 

