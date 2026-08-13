Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F229BDAA;
	Thu, 13 Aug 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580907; cv=none; b=hDnagM2fMFp5TMDrX+88booZcM0JUuvQ9kPELyUiZ6sV9nqk8x+hUjnBahatUKjNkMtOLwwfaIqBt+Mugu1q5MRaAN8Luj/2nj1VADFEN5AVJJKMESdoMMkaPZvHJUxT7cfNnO7mUlp1ODjIJyS5U/6nYUOHYKNMKNK79/KiwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580907; c=relaxed/simple;
	bh=FVClKMho33ethE6YexC8chACWCmfK7Zg99Y7/LQNnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvEzGPSY6/284KXxfUTR7YbcY46A0JMSRtwc1kbUilarqIhS2fiavQq5v9wBhz43dbMJp9pk0BaRJVlPHyll3FSs2l1Tj72HQQ9bZ+N+H+V2i/SF3uIyHZq5uc7fsNVfd3LZcI36ssaZnuJGhpi0ZhoFG0yAza2a18zOtgR9Ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmJ7Be0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmJ7Be0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391851F00A3A;
	Thu, 13 Aug 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580905;
	bh=aXqiGAdZN2nWwSbLZvPAAOM9zFgvuhxZ3LMdubhfHPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YmJ7Be0HXBl+TL0w//EoDaABd/zvQwYdSyQsNKm0H/+j39C1KmV06tycZPQQV4oqn
	 VLMSWDM5f1WPn4yrXoQzduvuthZdZJ35OsVducuKLmpLoF7fJq/dsB441VHJz/soC+
	 0LgF3RH8PK/OkXncRYdZDON+uE8lfYuTFDsaaKH5vfKD7mxbjg//A0eR5wrJc3xigw
	 FOdrKbwwda7Ov0An4uVWjcfC6vITTfvCsBkyKt3Jc2NU1nuRYtVCEBQS9cA6NOwciD
	 KNimVxfsgmlkF5t2zOqZlOvQL9z+UFdpWP6KrxSYvh9SZ0NW/k2IWLEYNSLVcNBUQ4
	 3vKeSnlgAElKA==
Date: Wed, 12 Aug 2026 17:28:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, praan@google.com, Mina Almasry
 <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Dragos Tatulea <dtatulea@nvidia.com>,
 Kees Cook <kees@kernel.org>, David Carlier <devnexen@gmail.com>, Yue
 Haibing <yuehaibing@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Maoyi Xie <maoyixie.tju@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list
 to xarray
Message-ID: <20260812172824.724ec190@kernel.org>
In-Reply-To: <20260811142958.160088-1-shivajikant@google.com>
References: <20260811142958.160088-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 14:29:39 +0000 Shivaji Kant wrote:
> netdev_nl_sock previously used a struct list_head bindings to keep
> track of active netdev netlink bindings, protected by a per-socket
> struct mutex lock (priv->lock).
> 
> Since list modifications and iterations are not concurrency-safe,
> priv->lock was introduced to serialize operations on priv->bindings.
> However, xarray manages its own internal locking (xa_lock) for store,
> erase, and iteration operations.
> 
> Convert bindings in struct netdev_nl_sock from struct list_head to
> struct xarray and remove priv->lock. This simplifies the code by
> removing explicit mutex locking in netdev_nl_bind_rx_doit(),
> netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.

I don't think this is worth touching if you're just trying to simplify
the code. The mutex is in struct netdev_nl_sock, which is meant for all
netdev socket state. It took us a bit of massaging to get the locking
into shape, I think that keeping the mutex around can serve as a more
generic blueprint for others who need to add state to the struct?

Clashiko also doesn't believe in the correctness, I'll send out the
review separately. I didn't look closely but the usual workaround
for store issues, off the top of my head, is to store NULL first,
then swap it for the real value. The store can only fail if the xarray
needs to alloc memory, swap does not fail. I could be wrong tho.
