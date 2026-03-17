Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B034402B;
	Tue, 17 Mar 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777315; cv=none; b=rciTPH49GFYHwYdZfQ4MilwSarruHCSsc/+eZqIZGnxe0rCDy+uKOaVWT0h8WCohiBPuJZWgKQv4E7v4d94cRf7HtrdmvwHtRclE/2A7CWzAZmKOUE/UGmjE9pOsgZqWnLVgSUERho7crR25CNwfSDEkq8n3WsFZ7QcV1lCmfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777315; c=relaxed/simple;
	bh=6CmjJezISIdi6S85hFlbSw8pHqBMiY/a5+k1OAZGtHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhavro5joPsTjgZHVdSf15mteQq9T5KCYvIJNvoeyYNgN+GW33hlbK3hQpKoyd9SEQLyZFOaU83NceRhwKIVC0w6Nn1xRARDJERbmXrcM33veFhjTX80FOPcopzv7EOVTmPq+ARQDgIuL15qdcvCD6WXzAedT3ZH6u+ZtjN7q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jD2YFnsj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jD2YFnsj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PM65uSvrRT+IPon3rl3yfezxEUBG+alq5k/vugfaBWU=; b=jD2YFnsjyMMowPir++sjMKFIFQ
	RQMcwZCKfToUbCc4+hEwcbqvq7tccvJY5zrWSxQZQfEcABrtxkEi3sdZy5zuOqLgRfCDGfFPXiVo4
	iF6UGB2+vcn+UvYlmN21U+Iloq9yFNDJhMEe1IC+6f4zZP0gMOVzfG7UH2GeuQizUsagbSp3eBZQw
	FEshI9Bu/+fp1lpUfnQ+8vI7wFxBl6mNipuYmUC6iR+LfZ019urO5Hwf3JdF8dmRPxLWlwRxbvBBz
	pd3NR6WqUMgWSIymE5ZvU7YONgvvCcvsPy3dZ7QeMbecZko1aMz7F+/UPnUYaonFb6DiTpU7ctxla
	YZgGTZnw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2aVP-0037ka-Ae; Tue, 17 Mar 2026 19:55:06 +0000
Date: Tue, 17 Mar 2026 12:55:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH PATCH net-next v4 1/8] tls: Factor
 tls_decrypt_async_drain() from recvmsg
Message-ID: <abmxgHSjkeOWd487@gmail.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
X-Debian-User: leitao

On Tue, Mar 17, 2026 at 11:04:14AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The recvmsg path pairs tls_decrypt_async_wait() with
> __skb_queue_purge(&ctx->async_hold). Bundling the two into
> tls_decrypt_async_drain() gives later patches a single call
> for async teardown.
> 
> The purge is kept separate from tls_decrypt_async_wait()
> because other callers (the -EBUSY fallback in
> tls_do_decryption and the tls_strp_msg_hold error path)
> need to synchronize without discarding held skbs that
> are still awaiting delivery.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
