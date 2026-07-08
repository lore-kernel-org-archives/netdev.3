Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107043933E;
	Wed,  8 Jul 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537497; cv=none; b=lRE4oWbUHSj4W9J7lk1mBCIPYxyt1EK4zV5TfhIXeP/xAFxjGvO/t50h2CcwEJ7Ge0Q5xoDfrUOotbUOirSxG2TyAcmVdlYZ2PdR6+ZAHjwcbvwxaeaCSz3Uuk2V6AyxavL0zusg+dgAINpGb5mbEItElmG+XKDybx73pPAqDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537497; c=relaxed/simple;
	bh=tPH9DICekdlZbynKMclkIKeubaFZz/dgqiOwKq97EIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujDvVKAQPFToNHlz8NF/WddiDCKoFWaGiLZnm0nTpA82+ZEDUe7cWFVNWy3IFZ+g92qETsud5AAOPXuThI4tdxCorAdGMKvjQwomQ9ZznbPI4yJ/NaxFkMhWpTl40fm+U6nFRBrP3Jpx3li4jwPrm8w8SBA6DkQNFDHf/Rr7oQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9lREdGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9lREdGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2491F000E9;
	Wed,  8 Jul 2026 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537496;
	bh=P77UWkg5VroY5vpeRPWTAH/eSCjDlL6nr9xgv0/Fd6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9lREdGE2X8+jzoVKSg32WHZlgvfm9WUnyhAs7lCBVlPjSEGUlqc/9BP+Khb87TWw
	 PcMlY0SMlJfW7z5yAXD6XGxU1f6aI/OMTQSmS7d13+3zao6azE0jjjNtfxNi+lnlOM
	 sWWXqZjKVt65mmWHcRaexgAleBoEjR2/r6chFprmV0rV5/Fc8hfKGMVt8YRmhWiZjF
	 Shr/s9UsWMHEg5uMVvvZOfDGhEU7pSazhugTTPIYeBAbr99/0zSWXWRo1OqeDTT1l2
	 pNgcyFJl4jk3K9Fegi7OPac0d4gLGiWjIsAk8J9vfckBKJ/e3+3j4Ziuu0ScLX865Z
	 /hEAc3FieTDEA==
Date: Wed, 8 Jul 2026 20:04:51 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <20260708190451.GM1364329@horms.kernel.org>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org>
 <ak0SYEOvw6K_8C_w@chamomile>
 <20260708103525.GJ1364329@horms.kernel.org>
 <8d5fe948-6979-46be-866a-69a98ee391d8@redhat.com>
 <20260708183252.GL1364329@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708183252.GL1364329@horms.kernel.org>

On Wed, Jul 08, 2026 at 07:32:52PM +0100, Simon Horman wrote:
> On Wed, Jul 08, 2026 at 01:10:58PM +0200, Paolo Abeni wrote:
> > On 7/8/26 12:35 PM, Simon Horman wrote:
> > > On Tue, Jul 07, 2026 at 04:51:12PM +0200, Pablo Neira Ayuso wrote:

...

> > >> I think this patch is not correct.
> > > 
> > > Hi Pablo,
> > > 
> > > Of course you are correct.
> > > Sorry for not realising this earlier.
> > 
> > Human slop here made me wrongly apply this patch. Could either of you
> > please share a formal revert?
> 
> Sure, will do.

- [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
  https://lore.kernel.org/netdev/20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org/T/
