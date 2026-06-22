Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDE379989;
	Mon, 22 Jun 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131931; cv=none; b=QBLEpg0GAufFk5DB3Jc+BfqCT4xVnK6RZ9GlHX0nrC9IxuoB0JIGlQFnltY7x75fEncLm14YkDzxecbX4hzlwNsNZ2nw3JX+s5dunE7qQ77YMpPja4D2CAFj+ZzN8NUWRkQ+wO0BbBJ6WM9CjDYXoz1IwRlMEXRPDQLRDk6CkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131931; c=relaxed/simple;
	bh=4Nc6+PGCpfC6ky6338hjz+lE/sBPf0UsIxt39f0r2gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Crq6zBgtncOLe139mP+ENrN4NbaL8npgT61h7nQMFN8g1PEaq9HETDWYdWNxkKe83GG6pmvEJgRJqrzeFxmfq8Ll4BjeakGcG3l0OK6lX0CDIrCK3QGzMOiCMnSyY49R5gCNYG4yTMq4XwwYAiTnWVQ9YO0lR7gj+pAosIKvPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJHJyk+N; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJHJyk+N"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782131917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki9LVQQkdeH3DwvPppRnxehs+Pc9wdORAAkOX39MpTQ=;
	b=GJHJyk+NXQu+vMKSMdeYn9UGjqmI5F3/3qKIaHjgdpx66PHBpEOgzMQYaksxhjjN7fj4NI
	E3WVp55vZKrCAEK5TWzmEaJxo2JP4LpAjesv1s/qybEX6Htyy6P4vl2z/7h0OpFvT0x1My
	xHxkdpNiSJw8dwNsqTWZUrFC1MkYMO0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, Menglong Dong <menglong8.dong@gmail.com>,
 eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 20:38:20 +0800
Message-ID: <y0Z7Q5BMTOCjWxPaSzIakw@linux.dev>
In-Reply-To: <20260621150610.0ad5d02e@kernel.org>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <20260621150610.0ad5d02e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/22 06:06 Jakub Kicinski <kuba@kernel.org> write:
> On Tue, 16 Jun 2026 19:59:12 +0800 Menglong Dong wrote:
> > For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> > in the tx path for example: we set xsk_set_tx_need_wakeup() in
> > virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> > anywhere, which means the user will call send() for every packet.
> > 
> > We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> > is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> > Otherwise, we will clear the wakeup flag.
> > 
> > Race condition is considered for tx path.
> 
> Seems to follow what mlx5 does so presumably this is fine but IDK if

Yeah, I followed the logic of mlx5. It's amazing that you found it :)

> there's anything virtio-specific that we need to be worried about.
> 
> Xuan Zhuo, please TAL?
> -- 
> mping: VIRTIO NET DRIVER
> 
> 




