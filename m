Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750058;
	b=W97UyhQaSDRcE6C6Zy7Q+F1WwseWYijIa8lEzYJWEXcklt4h/vUrSwo9E7uKPuJRU5g/
	 gd688B7sp/2mwNPnBPBjlM+oKnx9bKasNqnwJ1CX9lZvmJ/SvdtsAAkquheRu5YrvD3Jq
	 /kgDRuOwlkAS+WnwGDFKK426M4l2wMAiQcWTBArDLxBfioA/XFm3XOBkrPicseN7nsOki
	 G+gJ7ATDyG5KEe4Z2KAX5VsivQ4NpIhGwjNaUqs8xOTNGSSZxZQxIh8xvkp0o+RB7eaXf
	 LD9rlZ/jwtGJbjskFNbs3W6UOS7OGojpzs/OatAMI0wA3VeIKOayuh6eFyqcgAOPZyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zXM3jUPkYwdbcuKJfKxlbbC+DSdK5AgwLSlTQSkg0Bk=;
	b=zBjLmlbqKjmXv4YDqMRH0i9QdffvHczU7KHJJtCD5vJpJsGIO06mmBXXMmawCfE3l+Qb
	 IpR0/BzZFvdjsqwLssx492UHuMU0f+ULm7nBl4MIX16obYzaKPeRCOFXn8awluI0SlQxX
	 cEpz/143Pu9FVj5D2Itn8EGOtDuzh3GGVG6pN0E73O3KWWlSwL8M/BLMdt6XxStNWQ3sd
	 6fZRwn/HtUZMHufS0tVhXI5T779u5KQiMynSoQADc4e1O752IJ9LKVsv3J7ng/IJ8KTQO
	 fjcgZrFCmdcVWAeKh1C2JWfOkHzk+9iymwyN+wOdtARwcfJzQtkxaVz4n6/fZRCij0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQQKbUr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95200606A31A;
	Fri, 23 Oct 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQQKbUr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8E1F01825;
	Fri, 23 Oct 2026 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792750058;
	bh=zXM3jUPkYwdbcuKJfKxlbbC+DSdK5AgwLSlTQSkg0Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQQKbUr5iOQo0qFN6Nh176OlSGPa3zi4WYO92hjCv05oeQDO4eUtTyh4x8dMkSrri
	 4r6D4IN8tTDi1qj4/sM8Mx10rVn7Is3FcEO/qCofA561UOQK/rMoM5Ac3xL6cFLuPo
	 irvJDFL5RZZ1cvkctkba5voyiOmOUi2Fiey6l7bTYmY8ZL2DusQK/TjuvbpTIxhNKs
	 7uj2Vv1LNWL9Bc3tMwoBL18VwEFHUXyOLiTIVdrIIkg1zIJ5hWsh4owFMM6B1GQWx/
	 ijvyhp7CXpFJniO2lW59pof9XvAzwNxUq1O40xWwqO5n9ADgKwo3c9mEeWG9p+MSS/
	 Z6X5ij/M2KRAw==
Date: Fri, 23 Oct 2026 11:07:33 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261023100733.GH708417@horms.kernel.org>
References: <20261020153044.18828-1-omermetekaya0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020153044.18828-1-omermetekaya0@gmail.com>

On Tue, Oct 20, 2026 at 06:29:09PM +0300, Ömer Mete Kaya wrote:
> On SMP, usbnet_skb_return() can observe EVENT_RX_PAUSED as set on CPU0
> while usbnet_resume_rx() clears the flag and drains rxq_pause on CPU1.
> The skb can then be queued after the drain has completed and remain
> stranded until the next MTU change or device stop.
> 
> Synchronize the EVENT_RX_PAUSED state transition and paused-queue
> dequeue operations with rxq_pause.lock, dropping the lock around each
> usbnet_skb_return() call to avoid lock inversion. In usbnet_skb_return()
> use a double-check pattern under rxq_pause.lock on the slow path,
> keeping the normal RX fast path lock-free. Use spin_lock_irqsave() to
> match the lockdep class shared with other sk_buff_head locks taken from
> hardirq context in defer_bh().
> 
> Discovered by Sashiko, not triggered, not runtime-tested.
> 
> Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> 
> ---
> v4: Use spin_lock_irqsave()/spin_unlock_irqrestore() to match lockdep
>     class shared with other sk_buff_head locks taken from hardirq
>     context in defer_bh(); restore local_bh_disable()/local_bh_enable()
>     around drain loop to preserve BH context.

Reviewed-by: Simon Horman <horms@kernel.org>

