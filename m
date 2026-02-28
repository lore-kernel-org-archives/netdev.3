Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0933D506
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304349; cv=none; b=Ur3rq2xo8eLySSxGWwzdETZkpb3U71++GodeQpSrIjSUlszreTSorfOzlXQUaIGk8efctpdZs28+26DMYNBC8YGXzc6Y/RGLSfNmFjeOtSbNJO6xdRgRwOfXYlEu5InfFdZCunQsr0bIuUqwGF5aqHwt6AXTOJy/nd3yLEOHHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304349; c=relaxed/simple;
	bh=u3n0XsrnEAIgqgqlA31gZGjOHyYHDYEH1llZ+tI5tGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSItVTvdqo98+1lS+pbbV1hSiPfYDg9ClddXnGeId1qE++puN9s+5sCAGUqUHZ/Wt/+RfY9WUdJ1jd5EEatt9T1RSHyRRdhC+wsWuiHTz4QRWwc4D4OgEQKDnIb/X3XrCgwJ4ZP6+S5JcczUSe0XuINB+0RTR/FWTNTvifUmcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0epXK9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0epXK9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6461DC116D0;
	Sat, 28 Feb 2026 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772304348;
	bh=u3n0XsrnEAIgqgqlA31gZGjOHyYHDYEH1llZ+tI5tGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0epXK9Z4lXiobFTd5S/J/x21z2o8rtztaOI1IYeIAfXy0rIwfZ5YPNKfubm29IYL
	 0bu2m8ZqJ+VQX8L6AJwMBHPoPb0etUvmykJ4vgzNgsssCKj5hbC0tJMR9kX3UmZke1
	 y+5hDXCopmKtwIPW/3OYTUWCR+UkkQu/ys/LJ4F8speC74hfSkOGxbnBPgdgKuAxSH
	 CVX2GDFUOKu5NWttH6nBgT+oYGbH7B/xGzKRzJOV/jwZql5UrbMzxMelpuU3xlr5W1
	 c6fiE2QMN6wvePZ/LxKn6/eR90PjKaYs38Liwg/sbC11Cc9H0Qk+0+Z7q8P+QU0uHE
	 AMSy3Z3hLSQYA==
Date: Sat, 28 Feb 2026 10:45:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant
 devconf value changes through netlink
Message-ID: <20260228104547.56186b2d@kernel.org>
In-Reply-To: <20260226133949.17070-2-fmancera@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
	<20260226133949.17070-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 14:39:49 +0100 Fernando Fernandez Mancera wrote:
> When modifying IPv4 devconf values using netlink for some relevant
> fields the rt_cache_flush() call was missing. In addition, if forwarding
> is enabled on the interface then disable LRO.
> 
> This is needed to avoid possible connectivity issues and ease the
> responsabilities of user space tools.
> 
> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

This OTOH probably deserves to be a real fix for net?
