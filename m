Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E303B995D;
	Thu, 24 Sep 2026 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215038; cv=none; b=BlMcvUi404An+v68A49Vmi0lcLm9HTlGzzhFTRrlzO4GIsJCRAXDWd5yhipUzevhd+riNGnLyHIUlF6bv/LzokKG6oH0gYxzRLpfLiDISOR6U0XUdx8/0Yudbx+I3rIOT2o2nWWQ22AblUJ8Z3ikPPWggue9IaM8N+k3Dv7g9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215038; c=relaxed/simple;
	bh=HvgcRD1LzxPT5SuDZxdDYbuNlkgYHAAgcYWI7NogXYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5w3WVpm5vQUneTY5ib9pyDjmx5IdcXKBlsYOfojZrgABoF9qPnZdg8fQa1VR8nqWgwMQCqg+RxLx/DbpDLZF8p9r7xtB+S70cAS4Z7S7jtZLWAxmj1M6PxotWRXP5FymhKX+YfAPpYZ8gwJN+xfmYuJJlMK6Jpjxmm5qvC4Dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/EI2YGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/EI2YGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E77D1F000FF;
	Thu, 24 Sep 2026 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215034;
	bh=sOimoblwJenn63HC4gYpunXKMByHzRxRTvHw/9OYcHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/EI2YGqrN0CypJcY1StoHKtvI+1KvinMVqHEi5WSjfwefScqVubjNZ4ylL+9J9hG
	 FzH0V20FlPaoyCZaTGJW1/Rfvdl+n/rqihEHOzBolAej036EDlvpYVLs5gkEtdIKLy
	 HyBDLuDL749SQRn+rtGtuCCDKYtXtpHLLZT86uZjPkjrn4hkf3WZu0PFrWU5tSRHFp
	 4XWG1oWEdUFzldZTpanf8DosqyygSojXRfEltggiG97Of9h/ZwIHHuOn3SUIGEzCLp
	 mUKoLNrJGaoq35qup4Xhd7GFfWUK+JJQOfscTYzsbLwmrUn/A6vK1ex4ewWMyiujWR
	 vRawTK4jlTn+g==
From: Jakub Kicinski <kuba@kernel.org>
To: weir@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	cel@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com
Subject: Re: [PATCH net 1/1] net/handshake: Protect request hash lookups
Date: Wed, 23 Sep 2026 18:57:08 -0700
Message-ID: <20260924015708.4026411-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <01a84794d26de3d9b78ccfb5f34025cd67429290.1789819174.git.rakukuip@gmail.com>
References: <01a84794d26de3d9b78ccfb5f34025cd67429290.1789819174.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/handshake: Protect request hash lookups

This patch adds a kref and an rcu_head to struct handshake_req.
handshake_req_hash_lookup() and handshake_req_next() now return a
counted reference, and callers release it with handshake_req_put(). The
final put frees the request via kfree_rcu().

Closes: https://sashiko.dev/#/patchset/20260521-handshake-file-pin-v2-0-b9dadc472040@oracle.com
Closes: https://sashiko.dev/#/patchset/20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com

> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 3fd4fef9bab1a..da5d41e139a78 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c

[ ... ]

> @@ -127,6 +128,7 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>  		handshake_complete(req, -EIO, NULL);
>  out_status:
>  	trace_handshake_cmd_accept_err(net, req, NULL, err);
> +	handshake_req_put(req);
>  	return err;
>  }

[Severity: High]
The commit message says:

  If FD_PREPARE() or hp_accept() fails after a concurrent cancellation
  or socket close has released the submit file pin, dropping the file pin
  in handshake_nl_accept_doit() can trigger socket destruction
  immediately, freeing the request before handshake_complete() or
  trace_handshake_cmd_accept_err() completes.

The new kref keeps req alive during this window. Is req->hr_sk still
protected, though?

Both error paths in handshake_nl_accept_doit() drop the accept side file
reference before they reach handshake_complete():

    FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
    if (fdf.err) {
        fput(req->hr_file); /* drop ref from handshake_req_next() */
        err = fdf.err;
        goto out_complete;
    }

    err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
    if (err)
        goto out_complete; /* Automatic cleanup handles fput */

handshake_req_next() now takes a kref on the request, but nothing takes
a reference on the sock. handshake_complete() then dereferences the sock
before it checks HANDSHAKE_F_REQ_COMPLETED:

net/handshake/request.c:handshake_complete() {
    struct sock *sk = req->hr_sk;
    struct net *net = sock_net(sk);

    if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
    ...
}

Can the following interleaving cause a use-after-free of the sock?

tlshd (accept)                     consumer (e.g. nvme-tcp)
handshake_req_next()
  get_file(), kref_get()
                                   tls_handshake_cancel()
                                     handshake_req_cancel()
                                       test_and_set_bit(COMPLETED)
                                       fput(req->hr_file)
FD_PREPARE() fails (EMFILE)
  fput(req->hr_file)
  (or hp_accept() fails and the
   FD_PREPARE cleanup does fput)
                                   nvme_tcp_alloc_queue() err_sock:
                                     __fput_sync(queue->sock->file)
                                       sock_close()->tcp_close()->
                                       ...->handshake_sk_destruct()
                                         (req survives on accept kref)
                                         sk_destruct(sk)  /* sock freed */
handshake_complete(req, -EIO, NULL)
  sk = req->hr_sk;
  sock_net(sk)   /* reads freed sock */

The final fput runs synchronously on the consumer's thread. Deferring
tlshd's own fput through task_work would therefore not close this window.

One option is to keep the accept side file reference until after
handshake_complete(). Another is to take sock_hold(req->hr_sk) in
handshake_req_next() and drop it in handshake_nl_accept_doit(). A third
is to move the hr_sk and sock_net() dereference inside the
test_and_set_bit() branch of handshake_complete(). Would any of these
work here?
