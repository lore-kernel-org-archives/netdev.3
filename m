Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF13F9F35
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002363; cv=none; b=HrroCcGR/eLm36O0NwSRuMTK9FoNTzsJjFHO56Ka1q7unmhG3z8nGwARXLB2hxTATee/ZIwNeOfbjYZxyfUYKw6GWG9Iv06OEZwuop9p6QWjcrJJrJTOkTJiKJinOXgFZCah0Zck3WlSyuUtzg895IuBtX+1sgf+7ojzhCAPPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002363; c=relaxed/simple;
	bh=yJNcbNfJoDmq2WuOfC8F3Kija7CTcgpKSGTVlk1BN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMusYQ7N1mgLsL2hsYB9t2hMWj4Ny8JkdO9gSZbGV7RVwMU2kIBhm5VSVOsuuZKzbyq7LiByh6SaV7hmrgs7Hw16CApGkZO2/NLYpX9Yon/R+fb+zHysmOx5xw5I4kO5AYpVFT72gVEiQ5sdXjP048uafDDwmiaqL0K/1Z325+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (c6-bw8xn1s.asicdesigners.com [10.193.191.45] (may be forged))
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 659AoQhu031743;
	Tue, 9 Jun 2026 03:50:27 -0700
Date: Tue, 9 Jun 2026 16:20:25 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 0/10] cxgb4: Add Chelsio T7 support
Message-ID: <aifv8SR/ANbxBAUM@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
 <20260608141314.5c79faad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608141314.5c79faad@kernel.org>

On Monday, June 06/08/26, 2026 at 14:13:14 -0700, Jakub Kicinski wrote:
> On Sat,  6 Jun 2026 23:52:10 -0400 Potnuri Bharat Teja wrote:
> > This patch series introduces base support for the next-generation Chelsio
> > T7 adapter family into the cxgb4 driver. 
> 
> Oh wow! I thought y'all disappeared.

Hi Jakub,

> 
> There have been >50 patches to cxgb4 driver over the last 3 years.
> Quick grep suggests that Chelsio only bothered reviewing a single one.
> You are not fulfilling your responsibilities:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
> 
> This is not right, don't you think?
>

You are right, and I apologize. We have had some difficult internal 
circumstances recently that pulled us away, but I know that doesn't excuse 
neglecting our upstream responsibilities to the community.

I am taking ownership of this moving forward. I went through the netdev 
backlog, Shall reply if they are still relevant. 

Sorry!

