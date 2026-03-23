Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053E3C5DA5;
	Mon, 23 Mar 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287589; cv=none; b=Rt41X+I0vl2d5eSr1C0/3mxjkfaJ96JoxFqqDftSfPZOvD9H51ppcIUasIJjChllWnp/dVtf/W83Lj+UMdHu753Snp9s1qoB5oMzSpDslCmhpeCSffZdVJ3/rn+X5j43Vv1b3sRclt03N7V7nMLKpGdAk3s75zjBJviU3c3ogQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287589; c=relaxed/simple;
	bh=+fa/K8w6zIrws1YdS2a837OADubB/6ucEq3jtuVKqtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU7KJbpGeaakWsO6tVgv4yVdRSnr8Ju/FlImoOyeQgSUoN07S2RqjA2AoAJfcMwyzdg4G+UZc66zKbu4vFww3NCgUGsgkaPxJy45aJtxRzbJgA4epkr4TMNo3p15jHE8tt8nojtOWXRrdDUtQK7UgGn4RoIDGwJ2TyIn8TVwFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOl1s9/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOl1s9/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A553C4CEF7;
	Mon, 23 Mar 2026 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774287589;
	bh=+fa/K8w6zIrws1YdS2a837OADubB/6ucEq3jtuVKqtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOl1s9/hpXugFT8DJttAd4SxDv9uXHMMHlLLTlz9rxu9B6LI9JgWrKgRV0W6g3YIt
	 eGEDaYgxtClEg5r40lA+M1jLYd+DFcvGJyRJaQZUp20JwelAod/KvUYv+hv/VYTIfQ
	 5P+aqN0azYOYMOczqJ46Q+37UUmsyVYNzujkBU3m2zULhF75OYYgq12cEBQe/ANGHf
	 +aHQ4TXkRKxPYh/WwCQ8CG8x7K5XAyLbzAZGimgwbX1Nr0D836oJMRuXAP7a5sipIq
	 AGHkmuZ8tcdPKMtgoDonJcCkdpKD3FNzN2AvYdmYWWjzDo202hgTRGQjZ8mZkbb6Db
	 YWaECIIg+dHlA==
Date: Mon, 23 Mar 2026 10:39:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260323103947.637c3f40@kernel.org>
In-Reply-To: <cabe1ee3-ca29-4d28-913b-0b55ed8352a0@suse.de>
References: <20260320185649.5411-1-fmancera@suse.de>
	<20260321170354.17a2d888@kernel.org>
	<cabe1ee3-ca29-4d28-913b-0b55ed8352a0@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 13:32:51 +0100 Fernando Fernandez Mancera wrote:
> > I think it breaks BPF LWT tests?
> > 
> > FWIW you can open a pull request against this repo, and it will run all
> > the BPF tests for you: https://github.com/kernel-patches/bpf
> > Just delete the code that makes it not build because of the conflict.
> >   
> 
> All seems to be fine, am I missing something here?

Yeah, sorry I ef'ed up the merge. Returning the series to pw now. 
