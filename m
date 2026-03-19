Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F138A292;
	Thu, 19 Mar 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936609; cv=none; b=gYhiDHxtU1DPpl9GOhf/mhGvh+VfJUoHCVVVKnkvGOe5fqAbghWNuHBy1r3LW4yFjc9s0hAlLeQmFYHAdjLtOjLeffJqUrNduuZGfZ3iGgLFyOpwQF+AVDlWV2IPpn+9f9XyuHh2j5vbo0KAE0eQomg5D6jP+bm0bsQTR8g0tRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936609; c=relaxed/simple;
	bh=ROqWzTgLOTGiqbYldN+//mg1TluitqoWvKYogKgCnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptcvIxi9ZgGnYcr71lxBX4LBsdwRkTTeDH36HuWFFNo+WIrNNABmVJmfQMEWVp9246Lu3XkrQz7LYk4d9WkmNoIHgtbypv99z6k7ok/ud1+5j6o4JigRQBAwqC7uoLLtrdLdO6rH10pmrVtJf77oCm7AkKVx2tWlvuf/TB4+u7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPFiceKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPFiceKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC62C19424;
	Thu, 19 Mar 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936609;
	bh=ROqWzTgLOTGiqbYldN+//mg1TluitqoWvKYogKgCnck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPFiceKrgyXDvn2JPhw54AcmrcBEida3wdOJMhstIZSHPnbTBUGck1nduTxpxRVTY
	 N2SUmXs/XuhiCPcWG3O/v1swj8cknoZa5YwpZ8HfVb0qOKSz8UcVidZoikJbH9e7Fz
	 mG4+BSEJL+M7SNUJqdN5Nf1WWOCk8QOfkMbwrdsvEQRv0HQP0VGr+jcKFimD6/lrBG
	 zPB/azrPK4xHVElE2Cof7yUwNcEFxRH9hz+3E1bgCYiRFCJ31mVp+DlbeO1CCsbNqa
	 zayPUYXgDK6Bxy2JWznQ3kL+L9nQRmsfZUI4MD6UG0MI23VJwn8/VnuI0aJW8CYT5G
	 Gj97pifRab65A==
Date: Thu, 19 Mar 2026 16:10:04 +0000
From: Simon Horman <horms@kernel.org>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix keyring reference count leak in
 rxrpc_setsockopt()
Message-ID: <20260319161004.GH1753385@horms.kernel.org>
References: <20260313132327.409785-1-anderson@allelesecurity.com>
 <20260313132327.409785-2-anderson@allelesecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313132327.409785-2-anderson@allelesecurity.com>

On Fri, Mar 13, 2026 at 10:23:26AM -0300, Anderson Nascimento wrote:
> In rxrpc_setsockopt(), the code checks 'rx->key' when handling the
> RXRPC_SECURITY_KEYRING option. However, this appears to be a logic error.
> The code should be checking 'rx->securities' to determine if a keyring
> has already been defined for the socket.
> 
> Currently, if a user calls setsockopt(RXRPC_SECURITY_KEYRING) multiple
> times on the same socket, the check 'if (rx->key)' fails to block
> subsequent calls because 'rx->key' has not been defined by the function.
> This results in a reference count leak on the keyring.
> 
> This patch changes the check to 'rx->securities' to correctly identify
> if the socket security keyring has already been configured, returning -EINVAL
> on subsequent attempts.
> 
> Before the patch:
> 
> It shows the keyring reference counter elevated.
> 
> $ cat /proc/keys | grep AFSkeys1
> 27aca8ae I--Q--- 24469721 perm 3f010000  1000  1000 keyring   AFSkeys1: empty
> $
> 
> After the patch:
> 
> The keyring reference counter remains stable and subsequent calls return an error:
> 
> $ ./poc
> setsockopt: Invalid argument
> $
> 
> Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")

nit: Please use 12 (or more if needed to avoid a collision) bytes
     for the hash in Fixes tags.

> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>

...
