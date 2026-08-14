Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BEB282F03;
	Fri, 14 Aug 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715457; cv=none; b=lQqcg5UUES/0C28UJuZunrqKxnQ6IEetmq8YqbH5jqc6KbyOZFASyDUpRAF+y7QoKaec1DqOSot8jqNQ4y9crmP71Mwj25SbGVskQ3pAD+6Utto7ZP/HP29FLAf2GVS96qOWUK8aKZYnlwwJ0ur6rAUqMnt9H/sV5vWJlCbxiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715457; c=relaxed/simple;
	bh=nVzb20fSjdZWY/1OoSz1yZB5M9/1Few3Y9ftlFfpl88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLDacBfcx7VxggGfTJE6/+0ODRPKEzguA4iF/rtasfBU2v9Qzt9DICLDmpq0UXghBWWKve35Lp5ItUdJGQL6YJCuF/wagrT8o9t7TuM46TxPTGqwS1dgG0lMFki/zG4i9f1N7BqVkZNlxa5VBjywszE5sTm0JMi4o4OIUwmc7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfl0xVPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfl0xVPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BD31F000E9;
	Fri, 14 Aug 2026 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715455;
	bh=nVzb20fSjdZWY/1OoSz1yZB5M9/1Few3Y9ftlFfpl88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xfl0xVPaZH5YYSNzwXyXRAiibo7VzA87Jr2GNA19Cvgk/6VKFpsRRMm+U4nRj6ys0
	 giX8QaJd4fgj+u8IKiR2I23dn/+VXeyMcWUHcvruuPC9vN1OKqkaJ8N7ELCCWDYE0Y
	 b6hgFPxo3JN/yRDtDVITlKYEEi7AFH1CrGOaCR/3FxRgK3s0/V+EWzwTIgny9jCamm
	 ZsjPBDKMlRZWnAqUUiV/HOzBaMscEiEr/4t3Uz6a+quXJ5tDRhtKKDvRRPiLms+an6
	 MOfswT1EsYen6bQmmSj6iDctS//40VLUws4rc12gsf87kK3/3ddynkfVa3Ro8rwlAc
	 SGTU1IxV04yig==
Date: Fri, 14 Aug 2026 06:50:54 -0700
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
Message-ID: <20260814065054.55333a89@kernel.org>
In-Reply-To: <CAMEhMpmq7ZrW+4Q19gsF9k3v6S90k61oEXB6t4Oc4d9EU_QAbw@mail.gmail.com>
References: <20260811142958.160088-1-shivajikant@google.com>
	<20260812172824.724ec190@kernel.org>
	<CAMEhMpmq7ZrW+4Q19gsF9k3v6S90k61oEXB6t4Oc4d9EU_QAbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 12:04:59 +0530 Shivaji Kant wrote:
> I understand, my thinking for this was removing priv->lock is more
> than just simplification, it can be a concurrency win. Sorry for not
> making it more explicit in the patch description.
> As you pointed out, priv->lock current serializes the entire doit
> block (including netdev_get_by_index_lock() and the entire
> net_devmem_bind_dmabuf_to_queue() loop). Furthermore,
> net_devmem_unbind_dmabuf() blocks on synchronize_net(). With the
> current mutex implementation, if one thread is destroying a socket or
> unbinding a dmabuf, it holds priv->lock across synchronize_net(),
> completely blocking any concurrent netlink commands on the same socket
> (e.g., binding to a different queue/interface).
> Converting to an xarray allows us to cleanly dissolve this wide
> serialization scope. xa_for_each() handles the RCU grace periods
> internally without holding a manual lock across synchronize_net(). I
> agree the changelog must be updated to clearly state that reducing
> this serialization scope is the explicit goal.

If it's an optimization you have to show prod data (as in not a micro
benchmark) that the problem actually exists.

And please describe how your application manages the sockets, we're
talking about a lock on a management socket, not some global lock
blocking the whole system.
