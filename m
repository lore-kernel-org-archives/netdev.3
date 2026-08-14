Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556134CFAB
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689314; cv=pass; b=ZWNAP791c1ewmr/pZ/hLOBdegqH+7dZWrm7iRGQbFQMlmA709u9fHGoAPF8HuWVxWFVTnmcOVL6lU56MThUZuyfBa9rLKILttaZzR6rv99Tq0CaPXzuYGy/0WCA9/Nd3ekYGhWe9JzQXhv649CEfxzh9QcTP3kcntYIYRlgJbY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689314; c=relaxed/simple;
	bh=kvVKt88iNbTj4DL3jU6pxHcXybYbfBLNlI7Vwh6g7w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6l/gJ2ObcP9G6oRWSFZXapQwJhPzg1ogtoDrESnjuZPyuOoQFTo01Zhh7wsGmqWTUfDXaqB/OJJPMRU11eZ3S3SoMXz1tG/DhaCVV6m5gzrJ2nwpkSeIRcfasKRUKaDVXOccSgbQHtSdD0RICsbamOFHBtr7fOuYyMm2MUNxGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwX6DXOb; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwX6DXOb"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c01c79467so178911cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786689312; cv=none;
        d=google.com; s=arc-20260327;
        b=a3tqjIo6/wt6L7dSbFbQGKJ7u2nmWodH1hBjoo9Dfo9wTbeZG2fKZabW1zlKlpf73e
         qZDxqYuO9JKBvyssrPUd9J0Rk1A74UONLrgYVZp9gsQoZ19ZQLcwU1zEPBVSU9TJlLwl
         mcgV5/vd8tkFO6PbiSFlGLstNvUIB7QKKytA5mRPos8MH/6bO9R+AUu5lVhyYnlOakCm
         SLAXdyBoIrmwH8dg5llrUT17vvF/NW/UbUQYypFcOpg33PN67fvVi+216z8z6Qd/zOeX
         KjO1pBs/q+NmPF5hZpqFwXUWtdkbMqrPm/WnWX3rcN+9hatRMnXo/hdlQXK2PlQL+5Vc
         +wHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kvVKt88iNbTj4DL3jU6pxHcXybYbfBLNlI7Vwh6g7w8=;
        fh=S5g3vskO26feMnfD7XHOrhJ5tDQ31DeWRf9mIm2Z8ik=;
        b=ShYQRkMFXU7CAhAqmAndargwpAHYigvLd8cN+6eP3kCxhZmQMtNYuvehMF7FEViZc4
         KTusTOSeM8ssbpXLv1F5g4CONO8N0dYizqfSoHbEws0dasR5hekJHhi73IBKFf3KVUmx
         DSY3QfGOaXvOgv8bEVURFOLl9k8cw+E4RSjgH2XiYJXbflF3agAvSK9d7RAzVuZdkKhP
         0hvchRAw7Bd5Z70oy5hhssM08T66Dl8HVBf7U5GMJYvFS1oUltdii6Av5wI6neSB9ZPJ
         hvvqsJDzdmjSbkAfXiVA8ik6FRc6rnmyhxJcBlb49j5HQs7PC77F0zgwW7JzUyyNRJ/L
         tRWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786689312; x=1787294112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kvVKt88iNbTj4DL3jU6pxHcXybYbfBLNlI7Vwh6g7w8=;
        b=hwX6DXObTZjKvE2rH9ozoP3uRaYOqWHRt5Cow8vwGB6unnfAUT380qQhhB+uyPkdvM
         Xxx8wdHM54nJFgILjUCFOIh4RUG5mnLZQQ4/ZK5jt/ZfE4bk4uAEe594t2+K42xQc6Jv
         BhTTgxCnQxf6nuTA0c9YSfs9IiX2Q/B7W56aHCYZ0+n2JbmeW+qNH257ZktnDockdYo4
         BQjY5Jnhsp6l4zsj5txy/suCqwwW6ifw36mlCxFrhHhwJS8SnH+Qp2/5wKPH1NYB3SEJ
         Ut+F8o+uM/sWzwRPxdhAlwOoqzriY+JyzN2/du0G0NnGXIy3b8n57abDqLduTXVWJ3YA
         TnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786689312; x=1787294112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvVKt88iNbTj4DL3jU6pxHcXybYbfBLNlI7Vwh6g7w8=;
        b=F+9P9YzH1+hUkc1EqjS9hVqO9qIcXsc2QfHe9vuENLY3wMOoxL7P+FC3Ncc0aYRaxQ
         hLHIp76JfswnyLOvGKRENCAHG88ccZ8/JG7VVxkECoQRZ6WnxXFhjdsBmnxh46rTQnZB
         wWiXVP7PkORRDoK9uPPuvylYstdGBl/bRntx8jl5KfcnnYXztNZx/qwXoQXB5oEVYkUe
         O0o7yZJAlr/1OX8yt9ya2GMQxw529rpkO+jA/BA/bLFwxWA35m78Dt2SGjcyzVTYeWdV
         vSJetiLRF6mmpxPSuqFK0yICPzqv3Qt1kFDoFVb0Ni77/Q9HB0m1ehBGDCpnJG5HnyPe
         xJdw==
X-Gm-Message-State: AOJu0YylMOHG4PlTdnJs8AAXMFNDxD77SohM9vnzEx1rFQkT1ZAcGXDB
	Uoa4OY+h0jlC1TNGjmZY3/ZqM0cTTfkvIjMXIyvg468xeBC6tdQx4NxdCviY2MjswoNcMX/klnV
	Pl8oDOf0mukBrXz/lZr8MLzph30Z5KGeRUimkQR4d
X-Gm-Gg: AR+sD11YQ2W+3y1pvPXSRfmo+gWsL7QHKX2o8R7MO3hbfFYYDqk38jLW3MUnJAVPXjU
	jXWq+jcEczmuGiVKzOFZ1OPd/Wfo06HeBduHtSXrZD69mR58XgQBVhkjoB9tMv8V0a2UAWGypmJ
	81WwfzNobK0MVtgBgQQ/FJ6p4V2L4YXXKzEqTnry3FRQAq5t7o/7PpLxpsF1szT4IqM5gnAAwKy
	DDMmOFXq36tVaLFxs0nVAOrp5Ouss4diXCoDOktT+2Uuadkx+C4moqwFXpzYuv+fdhodFTqfOmc
	xjGaggqR8+CwpM4euBLHxFTMNQ9gSSxKxsyEAjYKinMp/TdEdpICli2PfqSH6G2khgI1QbpRJOp
	JC4NY5bcCL8Ui1DeXkOnjycE6HhcKABsicQ==
X-Received: by 2002:ac8:6544:0:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52d862fcb1cmr9585531cf.11.1786689311672; Thu, 13 Aug 2026
 23:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811142958.160088-1-shivajikant@google.com> <20260812172824.724ec190@kernel.org>
In-Reply-To: <20260812172824.724ec190@kernel.org>
From: Shivaji Kant <shivajikant@google.com>
Date: Fri, 14 Aug 2026 12:04:59 +0530
X-Gm-Features: AUfX_mwWcjUzNr9FhzLjSVCwFv0_kd52wWN5iMlYerwco3X7otGfIzTbeo4Z_PY
Message-ID: <CAMEhMpmq7ZrW+4Q19gsF9k3v6S90k61oEXB6t4Oc4d9EU_QAbw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to xarray
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, praan@google.com, 
	Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Yue Haibing <yuehaibing@huawei.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Maoyi Xie <maoyixie.tju@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Aug 2026 14:29:39 +0000 Shivaji Kant wrote:
> > netdev_nl_sock previously used a struct list_head bindings to keep
> > track of active netdev netlink bindings, protected by a per-socket
> > struct mutex lock (priv->lock).
> >
> > Since list modifications and iterations are not concurrency-safe,
> > priv->lock was introduced to serialize operations on priv->bindings.
> > However, xarray manages its own internal locking (xa_lock) for store,
> > erase, and iteration operations.
> >
> > Convert bindings in struct netdev_nl_sock from struct list_head to
> > struct xarray and remove priv->lock. This simplifies the code by
> > removing explicit mutex locking in netdev_nl_bind_rx_doit(),
> > netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.
>
> I don't think this is worth touching if you're just trying to simplify
> the code. The mutex is in struct netdev_nl_sock, which is meant for all
> netdev socket state. It took us a bit of massaging to get the locking
> into shape, I think that keeping the mutex around can serve as a more
> generic blueprint for others who need to add state to the struct?
>
> Clashiko also doesn't believe in the correctness, I'll send out the
> review separately. I didn't look closely but the usual workaround
> for store issues, off the top of my head, is to store NULL first,
> then swap it for the real value. The store can only fail if the xarray
> needs to alloc memory, swap does not fail. I could be wrong tho.

I understand, my thinking for this was removing priv->lock is more
than just simplification, it can be a concurrency win. Sorry for not
making it more explicit in the patch description.
As you pointed out, priv->lock current serializes the entire doit
block (including netdev_get_by_index_lock() and the entire
net_devmem_bind_dmabuf_to_queue() loop). Furthermore,
net_devmem_unbind_dmabuf() blocks on synchronize_net(). With the
current mutex implementation, if one thread is destroying a socket or
unbinding a dmabuf, it holds priv->lock across synchronize_net(),
completely blocking any concurrent netlink commands on the same socket
(e.g., binding to a different queue/interface).
Converting to an xarray allows us to cleanly dissolve this wide
serialization scope. xa_for_each() handles the RCU grace periods
internally without holding a manual lock across synchronize_net(). I
agree the changelog must be updated to clearly state that reducing
this serialization scope is the explicit goal.
Also, For the race conditions you found:
Yes, the erase wrap-around race is possible. Reversing the xa_erase
order should fix it.
For the high severity UAF on the error path, calling
net_devmem_unbind_dmabuf(binding) instead of manually jumping down the
synchronous error ladder perfectly resolves the missing
synchronize_net() and percpu_ref_kill().

Let me know if this sounds positive, i will send out a v3 with the fixes.
