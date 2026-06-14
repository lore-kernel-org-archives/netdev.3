Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A842853F8
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781403755; cv=none; b=cpZ8wS3jobpv7+lNsrisBArv8l9laP7pg1oQuJ53kKrfSJcnxm9f6zhMp67l9a4uNlq2vv1/olmq8Lr5n041m7by3nFme9aZ82rCsk035/O5nM7F3ZDBUPQn8cZab5dsd6MdJQOUAE3+6HmhtsLE9muHb44QYIf7/s0ugI0vMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781403755; c=relaxed/simple;
	bh=ZknJMDKwVJgIZpDFbdQoNSsPaPQ17znpCfBxpHGfGsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnRtIznsl4zFk3I7I7mT7QkHxmS2rxLLBZ9nqS/ghQySS0RyZPS3dO7JDZPdd7AKLilbZv7LClDyj7Jl5gKYJNUn1WeGJnSeW/X1chtL8k8h8P0++5LzawprXoWiP1mj/xraCj+nB6c7LYdBqy1+q1H3opaJI+hKuHJhbMHVuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEgqKCJO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEgqKCJO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781403740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUHyjG0RXs1veCstB5MKuPMJNCla+JoVZvzNMOBLwHM=;
	b=wEgqKCJO64K2xwTZWh3Ep+gEvFYrwEDmVQOlvE9I8Pco9Fw2NEy7m/HnwU7VdikJl+rW1C
	FWGdXXZVMaPa/Ka+KB6BQOuPz6rueouaqZMk5lFPhBR8sjViT2EzWzS6prVUhkwZWK3xW+
	CjgjKSa1QHERcgPYwyDX3Ck4vfGinUM=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Date: Sun, 14 Jun 2026 10:21:56 +0800
Message-ID: <5Iw9UybCQg2Lz8MAf7lCXA@linux.dev>
In-Reply-To: <20260613144438.767f8069@kernel.org>
References:
 <20260610081648.2205711-1-dongml2@chinatelecom.cn>
 <20260613144438.767f8069@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/14 05:44, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 16:16:48 +0800 Menglong Dong wrote:
> > +	/* If both rq->vq and fill ring are empty, and then the user submit
> > +	 * all the chunks to the fill ring and check the wake up flag
> > +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> > +	 * we will lose the chance to wake up the rx napi, so we have to
> > +	 * set the need_wakeup flag here.
> > +	 */
> 
> TBH all the comments you're adding are harder to understand than the
> code itself ;( Please try to phrase them better or just remove them.

Ah, sorry about that. The race condition here is a little hard to describe
for me. After the discussion in the V2:
https://lore.kernel.org/netdev/rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev/
the race condition seems not likely to happen. So I'll remove this
part in V3.

Thanks!
Menglong Dong

> 
> 




