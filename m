Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4218AE3;
	Thu,  8 Oct 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417852; cv=none; b=CrAtbvsOaXKXJaX5U1+ulJadphgJ8fbOA7Gc/LuO3U90ALTwZtwXlQrrxbRsEpg1cIYwYKgR3SIrpGK/iewUF7MvPP+MPAVQ7UKBOZN5oGMtaBrOaMbTJec912XLU31905eOF9brAK5cEzDv5nq17aesUDUU782nBA7Q4qxvXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417852; c=relaxed/simple;
	bh=xyfMnJ+FgEFWdJBNlVq7AnH2xqhajFGEhBsRPp50sh0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/EfCLpzg70+xdR/wYheVXqYqt2Q3BOe5uqFMazuH6JwLcpf9rb4dE5Hj9vVjSV+cKLaFWBoQIz6017n9RmhfBo9CcA2AgxMoLESkeEdpipquPVQVXm+OtK/hj3RJp7AmvT/wTQ0QY8rHJsN6GPAZoacB4ldQlh7aAv5w4F5ADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQsBvXSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQsBvXSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FADC1F000FF;
	Thu,  8 Oct 2026 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417850;
	bh=kzF+Qwrs/NC1+X1OZtTiyLKqPw59tj61aGXqv0sAPcY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GQsBvXSK767xTMuTrodv67tllv8rCP1nHBK0tDRMbydlJ53+4q8MFmSOLxemkTjMC
	 +WtFYk0wh/bbyCRsAPEE6qGeBxxgoCer5ZMZSHdhY3NoZJhAgLqOYesnbYNojWxoBf
	 33/M3je+Vbag6V8kiGTIMWHhMb+jzCJT/2BBgEXELl3JACZ4MiXJoVJxa22ueBLAfE
	 Scd5nsDZPzuVW1l38ixOYA+MYgvH+l0izK1Spx53veB9pTzkeh9ITUKXrkbzBGcpZb
	 JHDsGILVaumtdOCJf24SJXFPSAwOXHK/DR2IW35SzyZf8ayOoTUqWe8aovC7HTo4EN
	 Dxr1vYd82kSzQ==
Subject:
 Re: [PATCH net] net: devmem: check uid and netns in net_devmem_get_binding()
From: netdev-bot+sashiko@kernel.org
To: kaifengw@google.com
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 00:04:09 +0000
Message-ID: <179141784973.434549.3492874220530662715@kernel.org>
In-Reply-To: <20261005210403.3206872-1-kaifengw@google.com>
References: <20261005210403.3206872-1-kaifengw@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch narrows who may transmit from a TX dmabuf binding.

--

net: devmem: check uid and netns in net_devmem_get_binding()

This commit stores the network namespace and sk_uid of the netlink socket
that created a dmabuf binding. net_devmem_get_binding() now rejects TX
sockets whose netns or sk_uid does not match. On a mismatch it returns
-EINVAL, the same error as a non-existent binding ID.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..9a773b1ce92de 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -220,6 +221,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  	binding->dev = dev;
>  	binding->vdev = vdev;
> +	write_pnet(&binding->net, sock_net(nl_sk));
> +	binding->uid = sk_uid(nl_sk);
>  	binding->niov_shift = niov_shift;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>  
> @@ -390,7 +393,9 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
>  	int err = 0;
>  
>  	binding = net_devmem_lookup_dmabuf(dmabuf_id);
> -	if (!binding || !binding->tx_vec) {
> +	if (!binding || !binding->tx_vec ||
> +	    !net_eq(sock_net(sk), read_pnet(&binding->net)) ||
> +	    !uid_eq(sk_uid(sk), binding->uid)) {
>  		err = -EINVAL;
>  		goto out_err;
>  	}

[Severity: Medium]
Could this break existing devmem TX users whose TCP socket and netlink
socket have different owners?

binding->uid comes from sk_uid(nl_sk), and the new check compares it with
sk_uid(sk) of the sending socket. sk_uid is the socket's owner. It is set
when the socket is created, in sock_init_data_uid(), or changed later by
sockfs_setattr(). It is not the caller's current credentials.

sock_graft() does not update sk_uid. An accepted TCP socket therefore keeps
the listener's sk_uid through sk_clone.

In these setups, every devmem sendmsg through
tcp_sendmsg_locked()->net_devmem_get_binding() would now fail with -EINVAL:

  - A listener created by root, or through systemd socket activation, where
    the service opens the netdev netlink socket after dropping privileges.
    binding->uid is then the service uid, while the accepted socket's
    sk_uid is 0.
  - A privileged helper that runs bind-tx and hands the binding IDs to
    workers running as other uids.
  - Sockets passed between uids with SCM_RIGHTS.

The mismatch returns the same -EINVAL as a stale ID. How would userspace
tell these cases apart?

Should Documentation/networking/devmem.rst be updated for the new
requirement? It still describes the ID as:

    The netlink API returns a dmabuf_id: a unique ID that refers to this
    dmabuf that has been bound.

It also lists only SO_ZEROCOPY / MSG_ZEROCOPY, plus an optional
SO_BINDTODEVICE, as TX socket requirements.

The comment above netdev_nl_bind_tx_doit() says:

net/core/netdev-genl.c:
 * shared NIC RX queues, bind-tx only DMA-maps the caller's dmabuf so they can
 * transmit from it on their own sockets without affecting other traffic or

That is not quite the same rule as "same sk_uid and same netns".

Because of the Fixes: tag, this restriction would also be backported to
stable. Should the commit message describe the compatibility impact?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005210403.3206872-1-kaifengw%40google.com
