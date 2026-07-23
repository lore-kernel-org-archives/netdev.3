Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD0432E7C;
	Thu, 23 Jul 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813981; cv=none; b=qzVG3GjD8HkQoIn802Hy8ZMfTpFQfedZhkk65HvGyuB6WoHhPI7h2REVGRmGZUf7QW/cutbgKn31uXv9GpFvojeIEZFhNig5MJlr0vxTeeiWRIkiivQJTRI36Xh27FB9DYcdmF3vtYrgQQ92DVqt0n34vILvWFJYHUYySjA7yNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813981; c=relaxed/simple;
	bh=zRYiwlNo7ebNzBLGnhfeLnmAgWlpBQFde8Kg0HUSf1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK3cD0EXPS2DLZp26rVMPVXM+0lXojAeokiF1ySwUuamGA31GFclyX8MWRqbfQH4TFlXnkq/B+hQ7XaGe5WoCPYZWf2tIL35eg7VlcA/E5qpZaqmDpmzdqCBb1GB+AqU8WmhBwf1j6SkaxZTzdlThwevsIo7MTFU9vaLfCCLUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ACB1F000E9;
	Thu, 23 Jul 2026 13:39:36 +0000 (UTC)
Date: Thu, 23 Jul 2026 06:39:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <zhaoping.shu@mediatek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <ncardwell@google.com>, <kuniyu@google.com>,
 <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
 <willemb@google.com>, <alice@isovalent.com>, <sd@queasysnail.net>,
 <eilaimemedsnaimel@gmail.com>, <imv4bel@gmail.com>, <hw.he@mediatek.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <haijun.liu@mediatek.com>,
 <xiayu.zhang@mediatek.com>, <lambert.wang@mediatek.com>,
 <Iven.Yang@mediatek.com>
Subject: Re: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Message-ID: <20260723063935.75bf55e3@kernel.org>
In-Reply-To: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:16:01 +0800 zhaoping.shu@mediatek.com wrote:
> From: HW He <hw.he@mediatek.com>
> 
> On devices that support both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST,

"devices that support FRAGLIST"? Isn't it a software feature?

> the hardware or driver may deliver packets that have already been

If you have a driver in mind please name it.

> aggregated into a TCP GSO skb with frags[]. GRO may then
> aggregate the skb again in skb_gro_receive_list().
> 
> This can create a nested GSO skb, which is not handled correctly by the
> later GSO segmentation paths. When the skb is segmented by
> skb_segment_list(), it not be fully restored to the original packets.
> 
> Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before
> aggregation.

I don't think we can do this. For GRO_HW devices re-aggregating
in SW is quite helpful, HW often runs out of contexts or times
out too soon, generating skbs with 16kB..32kB of data, the SW
can help bring it up to full TSO.

Also - you're missing a Fixes tag.
