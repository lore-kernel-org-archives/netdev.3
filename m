Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D12DCBFA;
	Sun, 21 Jun 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078247; cv=none; b=sUAtgKavUQXOp3uW+1IT9pElPMhaMwpi6i+lJyPYPPIlfXwDWlQ4CJZ9wEPwGl1JfuqLx3i0Yka6CIQoTywPG/mMZnh/E6ClX+A4q0yidpMInMoRKq5iXkgObSAekFbBQeEV5EdLyYuD0Vd20WQiGT4ZaXOYZfmE7/jbyAhNC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078247; c=relaxed/simple;
	bh=3LbQXs+qb3Suq/l1qNXkawU3pDbws2risYUp1hniM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxA73R9tFHQpkmdWP/kYLB8S80a0BA55X9RkdwPTshOnq+cniC9ydBXzQvpM7ZWQ6GwY7BzHwEO73YE+EsIY+BjSFjtaH7JOPQ6HgjJjs5bvEV+QwhfQBcL04uK5oBy2P0e3ZJY8AWV9TZqdyxrNYhiubnGaCXJLZugKi12mXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMDc5Emh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMDc5Emh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320E1F000E9;
	Sun, 21 Jun 2026 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078246;
	bh=Q/DDdrbAqpK3cXdB3Ec3oi2lstJK7AIFoyCnhXuQfqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iMDc5EmhG8RNHjUxE5d9giX8Nn86bVYfaLgrideVNyGGnrQ4VlByanYboGfWY4Dql
	 BIr7UYO6sA69pkk9SNHu4I3BvaC+RtQ03JNk9e6/q17VktVAJMRmjITntYR/GnNtp3
	 0ipez23UML697n+AuA7O+YArHMaPDTXARVZhJ2yFm3BlpOQveHmfqo5MS4oQdmyu0b
	 66W7aF1c2T7mMKdXQYUmqdXeoUWtSfER8b+1jOOwk6geiPg+Ecv4z0lI40Ph+7IWkM
	 M/Tc57aKx8a09VnEKJWwz16mtLmvAtyxzmd/wwtg7Zd7mWR7uODv3wgeAi6mmkL4QQ
	 /i0CkdCwaPUow==
Date: Sun, 21 Jun 2026 14:44:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <davem@davemloft.net>, <hkelam@marvell.com>, <lcherian@marvell.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH net] octeontx2-af: fix CGX debugfs RVU AF PCI reference
 leaks
Message-ID: <20260621144405.0abfc627@kernel.org>
In-Reply-To: <20260617104525.1321395-1-rkannoth@marvell.com>
References: <20260617104525.1321395-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 16:15:25 +0530 Ratheesh Kannoth wrote:
> +		{
> +			struct rvu_cgx_lmac_dbgfs_ctx *ctx;
> +
> +			ctx = devm_kzalloc(rvu->dev, sizeof(*ctx), GFP_KERNEL);
> +			if (!ctx)
> +				continue;

In addition to Simon's nit - please don't create floating code blocks,
just add the var decl at the start of the function.
-- 
pw-bot: cr
