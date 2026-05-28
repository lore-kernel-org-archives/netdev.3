Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA53438BD
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928884; cv=none; b=tI5mzdbzkPOZe71jsY/9YrmiuCTOBWeB/Dg02gVWwU1IXlqneCMRXgfgX2yk5IX0EHUVklFL3T8vgjEc3uqMX+J81y/fgDR9LTXSYTK735VD5M9FQ+jkfzS5xTyF5Y12FqouCH88/IU1HnJSXwSLfZwTLRdRfDiejkIiCYAyN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928884; c=relaxed/simple;
	bh=v6C910ZVZ4TU9da0jFbExhc6xKyPdrjDHdJT+8Lk1ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmVWkAtCXyVNjW/Oo7OrX7Fu3QvylveuJcA9q9Ij0xTk9RFqNLCHSZiY6MikChjo238CvkvclZShpSc9xFm8N7p7QizUlFZ1EKGPg+W5gB6Ndb404GQHtyBIJ0LB0+thu2zxgRObHmUhcWQBmeZY6nze8Ny/aZDaoMRlcwQsbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYCqy0DA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYCqy0DA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC47B1F000E9;
	Thu, 28 May 2026 00:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928883;
	bh=JJYw5b737jgkgHNQdGXuoA1BA71Qd57zejA3L5LPlHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SYCqy0DAdwaBnOsfg+2PzdPK8fESyol2ouSdZBVryFtDRk2ee9zEX9mxQ9qTV/+gC
	 Jv36L4OGG18UUeOTg2A2T0eqTRpbUj/Bj11684/Deq+5icEvIqiUw7xQ2E3JNuBjE3
	 VQN+u7O1L8iEqHTKsRCTFbK6u0YZZNX5e948zZkjclgKCZtFNLhYk6i+riLAqyYy2Q
	 YYx6sG4f9Uc0vDoGwc1Ke54eP5mkgaD/WPJhBSoCs0R8vYQyNwkl9lT+vPrwlYsoZL
	 vRXZ6yS7794U8E1qqsh9aRh5BVEbMboUPPqqYAA3JAAm/8BUMr2Bqv2ZE86D9uDd/x
	 gxGi44ES1pk2g==
Date: Wed, 27 May 2026 17:41:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, zhaodongdong@kylinos.cn
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
Message-ID: <20260527174121.2289833e@kernel.org>
In-Reply-To: <tencent_F2C58937ADA208EE4219632E34ED23772F08@qq.com>
References: <20260526162736.5e95b928@kernel.org>
	<tencent_F2C58937ADA208EE4219632E34ED23772F08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 15:51:22 +0800 Zhao Dongdong wrote:
> On Tue, 26 May 2026 16:27:36 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 26 May 2026 18:04:44 +0200 Alexander Lobakin wrote:  
> > > From: Zhao Dongdong <winter91@foxmail.com>
> > > Date: Tue, 26 May 2026 14:51:56 +0800
> > >   
>  [...]  
> > > 
> > > A "Cc: stable@vger.kernel.org" candidate?  
> >
> > Not really, the thinking is that if nla_nest_start() failed then the
> > very next nla_put* will also fail (nla_nest_start() is a zero-length
> > attr, any attr we put after must be >= in length).
> >
> > IOW the commit message is lying, there's no way for us to reach
> > nla_nest_end(). We will jump to nla_nest_cancel() which handles
> > nest=NULL just fine.
> >
> > Zhao Dongdong please confirm this and respin the patch without a Fixes 
> > tag and with an updated commit message. I think we got such a patch
> > in the past, so we should merge it to avoid confusing bots. 
> > But please make it very clear that this code can't crash..
> > -- 
> > pw-bot: cr  
> 
> Thanks for your review.
> I carefully reviewed the code. Your thinking should be right --I just happened to notice that most call sites of nla_nest_start() include a non-NULL check. Apologies for the noise.

I don't see a v2 so I'm just going to rewrite the commit msg myself and
commit this.
