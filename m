Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756433FEB21
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371067; cv=none; b=LC+MAA5i3DO2cK/0k8adBecXxDpDSrPWbhyLTkrKhs4m4VuLmwFhqVIv2SCDC+7YpuqCZY/rLmqLtPf+/5sBH1pLEG+cSs/PiEJUs47xhHse97rB86izHjSskcT41JaG1o1h1BG5/NVe9h6IP9X0VvcPHP3+91+f/YpjY9uJ928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371067; c=relaxed/simple;
	bh=ntUV1ZsAEl8FBR9E4P9ov0G9ZyXV20lN4BPbPTDo2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLrw5d0nBDmjuJ0Z2yjpUW8Wcgc5cXDSPO5vADowAZBeJbbJqOtmv5/Lc1P08qQlHDH4nn8SXUn8PFIMk2iI+hJ2vGs9Ov8D82sYXoJFPjeeos040Y4ItfuSQ3i4pyE6af9jjk8bUzlgIUXNZMiBsr2mjTSrD8734PGKnU5qaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8E5EC6078E; Tue, 24 Mar 2026 17:51:03 +0100 (CET)
Date: Tue, 24 Mar 2026 17:50:42 +0100
From: Florian Westphal <fw@strlen.de>
To: David CARLIER <devnexen@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: clamp TCP window scale to
 TCP_MAX_WSCALE via ctnetlink
Message-ID: <acLA4vof5qlK2-wN@strlen.de>
References: <20260324163033.310087-1-devnexen@gmail.com>
 <acK9rdPQNqwejye9@strlen.de>
 <CA+XhMqwEhxCcdpOvEdczwYsfZuAFuvN+oB2rzuL3Gtic3tpNPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqwEhxCcdpOvEdczwYsfZuAFuvN+oB2rzuL3Gtic3tpNPA@mail.gmail.com>

David CARLIER <devnexen@gmail.com> wrote:
> Ah well :D thanks for pointing out. Cheers.

Well, if you think its a more urgent problem you could extract all
ctnetlink updates from that patch, integrate it here and submit a v2,
targeting 'nf' tree.

Because that patch targets 'nf-next', I did not consider it too urgent.
