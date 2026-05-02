Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2D369203;
	Sat,  2 May 2026 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680002; cv=none; b=XrWDcgWffPxdeNBs8TVdQ5CSGu81R+CScsXx5WSe2oFItAFM3N2l1+/BWX25BWonucdm9n2FandLmWrk1JkZLGnFfwelL4CxgZoA6pX/WMZDNvSfVSMvySlslhD+jOHW/FmLXqrGdp/pt1I+oH4gEqXTHZlqwhjsxM1fvWsjMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680002; c=relaxed/simple;
	bh=/1jl2+Gk38jlQWfMB2nGgmVBHt+hIZIsXUnMvuPjpHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgzGVUmyrrrXw0v7wF59Z7SBB55NkFhzOGc4VCI6KxFhh3ckJ0/9Db3l5u/AUghETiEyfp+tJRxArlU6Jg4AJq+6qiRoihKkWk0a/xK7CK0XqQBxt1gR0+odLVf31pw22/9cIw2RZDrUWHsbhbb3t0OLy9zCkMw70MPnHj8puQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVeYMbWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVeYMbWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58577C2BCB8;
	Sat,  2 May 2026 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680002;
	bh=/1jl2+Gk38jlQWfMB2nGgmVBHt+hIZIsXUnMvuPjpHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVeYMbWNowv5y3lB/pAGbd6gzyAXJfK2zq/KETKqZxWXT4ai/IfsdFHS8DyTZ50bk
	 dbrUi9R2bQJ7mc+gnQlMZz7WGutQyjbT8ViJF5+KzlaQGdCRxMYsvgeC3qtydN5svo
	 cUrrQI9/P/w+Woud29zc9QACvClWQiX02jYGMATotNIYthU2ydFTZGP1XBZvyy64fQ
	 7NurA9HAFlwuFEccUHjHBxOM2e85jYY1RrhcR+gAvhHfXnnLBlKEgUBHKplioccoU5
	 HN90OSsNQXBRIR9cc3bwv7PRiKkrnBJNGVho/gvc5Zwk+0JQuGJ3vYG/zGNTkleEmb
	 zcPsGhk7kwTgA==
Date: Fri, 1 May 2026 17:00:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, raeds@nvidia.com, kees@kernel.org, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
Message-ID: <20260501170000.5a687eae@kernel.org>
In-Reply-To: <20260501130046.16008-1-devnexen@gmail.com>
References: <20260430062033.20428-1-devnexen@gmail.com>
	<20260501130046.16008-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 14:00:46 +0100 David Carlier wrote:
> +	psp_hdr_len = ((u32)psph->hdrlen + 1) * 8;

nit: psp_hlen ? all the other header lengths in this function use hlen 
