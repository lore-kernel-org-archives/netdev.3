Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BC3D6477;
	Thu, 16 Jul 2026 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203222; cv=none; b=Sea7a6e2hbJiCQQM6PlUPwEOp5aKpgmmjU8sP53Tr5uXOLHw/Spw6rpxg5u37FWSuaEwAwenu1iSX8e9q7E4Pk/vMuAUYL1kMP7jyYwC0w5wvNIJJa9IEbcXze+4nX3WeQPxFmvPXJe4V8qS9yRfaaF9YN4Yj6oUKPbC2WbROn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203222; c=relaxed/simple;
	bh=CiPLgrZ9XI1dHxFzb+KE9gNa3NW1B71drAt4OnHy4Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPtwdqU98O4BcL6HMM3JKqWjl09dfUitho4gWN1hNRh+vuyghm/oYrkj6MHmF1XB0CKP2MrA0CJYQ2vjpa28X8bRjOfoHllWgwddP3O7e6fqyP1nHl+/Ree2ac3S6CXsx0rTditBcNPKaVLIq1m5hKWZYGCx4cfY6gjrZO6+zB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoWnmBSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoWnmBSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413AA1F000E9;
	Thu, 16 Jul 2026 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203220;
	bh=fEorxvxSKtm76Svtx2kyGRTodPS39vDknRI1Er5eeuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoWnmBSFBJeJ1AG7IJH1YL7QQxWcZxGG3GCH5YCKGIc4jP3ioqx3tiMf1QH74GaZy
	 LHzhh/kREiaWbB8pgSrQkI6VUinWmZNqvxJMZmtox6GrJjTdwhCubVBPbUfj9ZI1P4
	 QB0m4CAuyaLovZTO+aLPyihLA8Oob9FCQpqiOz1ZOn9QX8SsjfWXuBSAqsd0PMkIcU
	 BigVQPLNTMzUenMw4EmuIGFR15vZ0j/eZfFdt5395Y4zu1bSTPcS8ZxLpxWamobd+I
	 lB+XMo7ULC8WgNXP9216Uoz3n/ReuGDRi1Em/AxqRq2R4v07UTy9e1tpKGOHhmUXRE
	 yndsUqy/Hz1gA==
Date: Thu, 16 Jul 2026 13:00:14 +0100
From: Simon Horman <horms@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Fan Gong <gongfan1@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1 0/3] net: fix stale TX skb pointers on DMA map
 failure
Message-ID: <20260716120014.GJ95246@horms.kernel.org>
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710090527.58354-1-xuanqiang.luo@linux.dev>

On Fri, Jul 10, 2026 at 05:05:21PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> While I was backporting commit 1a303baa715e6 ("ice: fix double-free of
> tx_buf skb"), an AI-assisted scan identified several suspected TX error
> paths. I reviewed the results and found this issue in the three drivers
> fixed here.
> 
> The drivers differ, but the bug is the same. On a DMA mapping failure, the
> TX path frees an skb while its ring entry still points to it. A later
> transmission normally overwrites the entry. If the interface is stopped
> first, teardown can instead access or free the skb again.
> 
> I do not have these adapters, so I have not tested the drivers on hardware.
> I checked the error and teardown paths by inspection. Still, these small
> fixes seem worth posting for review. They are independent, but are sent as
> one series because they address the same issue.
> 
> Xuanqiang Luo (3):
>   bna: fix use-after-free on DMA mapping failure
>   hinic3: fix use-after-free on DMA mapping failure
>   net: hibmcge: fix double-free of tx skb on DMA mapping failure

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>
