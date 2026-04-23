Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9731197B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963624; cv=none; b=MKPGocXIG5uFHGv+LqNvzaq2ECQA730Xu34ur189HBgHtmhJXRvkNpUvvWD3O6CfyrVbAGRPeUcTOOoz1mnTNCwlgTf/bmCrUBEy6WSZlIJq2cXV6a20vrkWxsDIBPKRoyBtwanpOp0cSrxhYDBQfzIKGOJRMr8ghkJOFCcEqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963624; c=relaxed/simple;
	bh=1Kx0ijsknerjauiQXhM0SOSbpKwVK0G/XS0l1zySC3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfR5Mwhb0N+rR+GXHJdVEW9cOVuZcN/ejTdYfQOWNGE9PyJVSE+JUNEPaN0+0mEdzD5JIpKZFxFhOVTqvi73UWvdCnGa7hodaHhTp+DtdOaCROaJp/w44/E/V3XNNVVpwftczYcY45AzFBhV5ozBBuBj+gNCD8pCG/0L/KUlM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFRZF143; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFRZF143"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EFCC2BCAF;
	Thu, 23 Apr 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963624;
	bh=1Kx0ijsknerjauiQXhM0SOSbpKwVK0G/XS0l1zySC3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFRZF143AN9QUkjD+ShcxT7nS3YZ3zsxoXBIsK26NYMzNwrRH5g8qci6U4Nda96EG
	 0d9Zp54CGRK8v5eFZYcgsB4cpOj4oaK+S0oX5Q9+mZzbj3stn494h2q2gXgTJteRHx
	 Jq7gSvpULifTLzXr7XhlWyieJISd0uMmWAsMwjG06YBgxcK196nFzKv6vOLNJymDjV
	 BvN4TpWQh2WoZD18w8LmN+Q+N0qy8Mk8BtTjXteqmrybFJ0aJXeoptBBV5Dey785oC
	 V7JJdWA1Nt2uJ1TmNpzJ8tgaFDge5Eq/xA/JGV978QL5VaXm6ZhRHiDsHz2ZrtH9S9
	 iGM2kFsFCh9zA==
Date: Thu, 23 Apr 2026 18:00:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] ipv4: icmp: validate reply type before using
 icmp_pointers
Message-ID: <20260423170019.GF900403@horms.kernel.org>
References: <cover.1776563662.git.caoruide123@gmail.com>
 <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
 <20260423165859.GE900403@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423165859.GE900403@horms.kernel.org>

On Thu, Apr 23, 2026 at 05:58:59PM +0100, Simon Horman wrote:
> On Sun, Apr 19, 2026 at 06:19:18PM +0800, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> > 
> > Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> > That value is outside the range covered by icmp_pointers[], which only
> > describes the traditional ICMP types up to NR_ICMP_TYPES.
> > 
> > Avoid consulting icmp_pointers[] for reply types outside that range and
> > keep the existing behavior for normal ICMP replies unchanged.
> > 
> > Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Sashiko has generated a review of this patch.  I do not believe the
> problems flagged there need to be addressed as the array indexes used in
> those cases have are always valid.  However, I would appreciate it if you
> could look over this.

Sorry, I meant that to be a reply to v2.
I will respond there too.
