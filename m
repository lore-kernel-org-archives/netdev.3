Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2B43CE56;
	Fri, 11 Sep 2026 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124044; cv=none; b=Wez/MuA8d/GgpjxAUMaK45z50iFhoLn/5HxnQoYBt3JFGmnxVz0NZM1YJqywMk/d6O2pfRGWFzQ0YHBCfCGqtKaxZVHSLY+RzSbgQ6kkbc5ZVgBTDsEu6iFhxS0O8Y7y7Aj+cszhmVPhJe/k2mbPt2v5q+clXoEh3Xu0+jteUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124044; c=relaxed/simple;
	bh=QB+9HG3aMo7t4aNhrrRHbnFlXTuSwPs0aOR9EayEbLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt7nim8BRPglTqobsRFD0I3v/C7+PJOO4Y6VJyHJj9Hs5l/2MZCyzeqFL3gGpeylIJ3O6L1nCg/Y7hhgkN4pJWNYbVtrtcEdYss6/qmx3+zs5bXlWd9CGIL2FSlCwkMST6BYgXvHX0my3wCV67jMBSW+484Os9Xw1SqfiUnQOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2HF9zFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2HF9zFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6D91F000FF;
	Fri, 11 Sep 2026 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124043;
	bh=nlFiPjgIYaXefonnpKUDARfjcawn8SLbfllvFr0tO/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2HF9zFQKicAZjed9rwYN+JTEbVb/bv2yG5kyYDTMfFfjHjqYzDbYqp804t66fF0A
	 vL5VOgbw91B6Q1U50fweYg/c2+IkLjCd/Wq1GjcXuojI+0vPLHn8L9k61GWVkoRA+m
	 WkjomVDC0LeVk00USoOv6qyW9085av5XbfslUMAXkAegHBBUK5+6KcQS5D9Dd75u6g
	 XAgN9nVm6rc7MaOmA70Rdoym5L2jg9SRaoynkmGANe15+8FlWpRktBGOdqYfIrAsPY
	 DsVXcH2VCxpQtZZiJ7gNKRtI30BXWsKMTK80McSi6QAfLe1twtc8AyWAZh/iMc/DZ8
	 1nhtKQsVyAJtg==
Date: Fri, 11 Sep 2026 11:53:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com
Subject: Re: [PATCH net-next v2] octeontx2-af: consolidate RVU AFVF device id
 definitions
Message-ID: <20260911105358.GD48209@horms.kernel.org>
References: <20260910104102.590989-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910104102.590989-1-yijiangshan@kylinos.cn>

On Thu, Sep 10, 2026 at 06:41:02PM +0800, Jiangshan Yi wrote:
> commit f695390ea639 ("octeontx2-af: Fix limiting SRIOV VF count logic")
> added a local PCI_DEVID_OCTEONTX2_RVU_AFVF define in rvu.c, although
> the same value was already defined twice elsewhere: as RVU_LBK_VF_DEVID
> in af/rvu.h and as PCI_DEVID_OCTEONTX2_RVU_AFVF in nic/otx2_common.h.
> 
> Move the definition into the "PCI device IDs" block in af/rvu.h, rename
> RVU_LBK_VF_DEVID to match the PCI_DEVID_* naming convention of its
> peers, and drop the redundant copies in rvu.c and nic/otx2_common.h,
> the latter already including <rvu.h> through the af include path.
> 
> No functional change.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
> Changes in v2:
> - also drop the duplicate PCI_DEVID_OCTEONTX2_RVU_AFVF define in
>   nic/otx2_common.h, which already includes <rvu.h>, so that all three
>   definitions of this device id are consolidated into af/rvu.h
>   (suggested by the Sashiko netdev review).
> 
> Link: https://lore.kernel.org/r/20260908094051.666769-1-yijiangshan@kylinos.cn

Reviewed-by: Simon Horman <horms@kernel.org>

