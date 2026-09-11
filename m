Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1648820B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149611; cv=pass; b=qkiKqkPWyAGWdF0ZZtRpFrlWIUQFseJc+l0g+jNXWffqBw4PNMF4CnyPe23jBbawPRgy90sMHfgyq4aFarc2+MEhUWjmFv5LIWnJSJBdfQKJZza8NJOHj3Hg+UcKxOBxYJ5y0hE3X3aCXYzO+o/McgrOZquOWkqsKvyBjDSA4EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149611; c=relaxed/simple;
	bh=75B6zdKCfHIJgushz+4ScUK9jZ/KjqUsttYbzMJwht8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui0TgRDN5559YFbs8nmzJOrAu8iPbk6p+VKDPtO6AYxSouVZ3R2/GBats5MQ5JswiDJM28Qgy3Qjry2aA3JoYFu59WxlcmQnJZ91gh2tyczWp6j8P1IVOcsLfvvzmUwEvjWB2CkOKMI6pWVQF8Mun+FA//xYeZ7q8s3YR8ceqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5xQ4yOc; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5xQ4yOc"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so2886a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789149608; cv=none;
        d=google.com; s=arc-20260327;
        b=mRs5slSAB7Y8F2uA11vdIDQ+lh+TlIscwzOKFaHsSy2Eotlee3l/KuBSslUg8m+yvT
         We97igj5A03yFfq7m48XDm08EtlzjjjE3rNopgvseHRotjJxsWWioms4aS8LZuB7UKe+
         VZVy3zZCrrLScjwv8/4F+fKPfZxgQsbCW+6ysWUUhZy4MAquhYgjsYUJ2G7VsakuVqzd
         3h6C18KV4IaxXoEDxSaPisqbWTSg/OYb0Wu3sfoymr1Zn38lscQwFgWVpxsrUPCYVWQL
         szU7G+iGMN9UqQb/Cpl/REAFjZJ2RJKEpgjMRAM5lhQaQUrXma4/dXbsoSjqy/lQNoUc
         KLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EPuBfl5vK2ggyAXvAEaHgEtOqAJU0sZXA/862mNKi+A=;
        fh=1uR2LhNr6LBdQn+A9M50qYSEMxIkrc8hdgBLUzyhRHc=;
        b=Hhu1EnMgjbCWL4dytNPEFRC87HYlYPJzczd/g9FVtQILLJkkTkWKdx9rE5+5FU2XWf
         8zHPMJ+eLVejeUHucrQU1n1EoB9tU6+A9vh/b9MoPxVN2P61OW6MY187jR74cUxNeDww
         IoD4PqZv3gbsOZkFs8KvP24+Oy337k2WTTrHcw/QtCvlwJSMAKVMxzsDUdeuvnmobPBg
         +kQesGmnFQISQAh3QYRCQoVNu2ynddxgbAPIs6DOnCTFKGVq9q3hMvPcbsNBVziNkmnr
         veCtPXkwUXPXIqR4ENdmkBPjBhX5iHpa0qcVebMOir0KAzczmoLWQd1RuhI2pWtSiKEx
         jKMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789149608; x=1789754408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EPuBfl5vK2ggyAXvAEaHgEtOqAJU0sZXA/862mNKi+A=;
        b=W5xQ4yOcI2ba7kEPjjFVpiDYDWsePTb35OMen34pxhsRcj/EsVJa8jBN9D0+G8kjEb
         p6phj4M9okxjfsWQCt9Q1yO3I+Afop71+pnBCtRw3scve8CdKKxhbULBlbnoFGt3AjbS
         XFKqC0Q1S/m5qF9fRBvrpkwzQ8jQXCIx5T6C1Muyn2sCaAnFWEKKIYRxRFK+K+nsSsqC
         lhOLD68Zed9fm7EWIF03GX7KTqKtYOcd9GuuNymYR95GxC/mXAXHpPSSQxKHCf+1YBIH
         38/tjaid5qRrK5Q5lCOQ6OHD+q9CcfpRdSMl4uVSv8CjjLf86aiBnRQPWV89sL7854NL
         deqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149608; x=1789754408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPuBfl5vK2ggyAXvAEaHgEtOqAJU0sZXA/862mNKi+A=;
        b=alsvqP6As9/bzySfASAiQ4ZYeNX3yxM2XPg+rVVmmt8IxQhF9XJrFuDJPGomBxhUxF
         pmxFLkTindnMYaQFmtdYMlHYxphRs+y3TrniG7SNvMwNSezcKvIiy9CqrffLj09Kva3N
         Gl8kDznrVLREM34ZzcLkBGozgxpN9wrcAdvIKpM4p8QXpGxERwqJcw7RKVcXsu3h6tue
         Sb3xuWwC8R6yLUZ32nL2Lr8kis2jsqcmgFYUxw5eszCmYeOj3hNchUwo+zRe7GBpeiH4
         xVPkhhVOVbW4lVhHO8NQ/Nz74rzFHA/pAlP0pavg/ZmBpfGmTP7aIIMqf4E33DPX6iMv
         idZQ==
X-Gm-Message-State: AFuF++km2k69636ez1lOJSykEQuCCjRtR9KNcPmLK6oAHD9KwAv7q9vR
	xjOvJMNFngOOix+UyGZe29ro1Gg0USFiAAGThI5ymetfZxY9ZUP4oseSx/PEUzAaIesc7jW2hNl
	2+S8wA3Fw41OlFXpfE65JKseMlak7Ig0zYpOidnYJ
X-Gm-Gg: AYBFou08sglZR98Xqtl398XuuUzWa9qF+3ujJo0LzLcRlmLtZ47pguLHlpN03Y7XV4j
	S39p9epaV0ATxhWECrkBle2Cjjs1roHVkI2PD4zcUc4L3kwQJM6FJAg2exDMqYWB3I7hCr9rMyl
	v11AQKd3xccSXZa+gtb8HfMl0vewhdqjdvTw4dlu8i2ORw+EVS4qEjGdmdegmKzWXf+8X/kFtNr
	wHr7L2H0bSEDlKihO/ukJUBHFE2oDE+9WhOzpDlIkHt+JY4JzVPnl4OWL+i46kK98lTLpQWJha+
	q4vq/udpJQKt4Sg4q4Cl9832fzR1Bg5PIB3+bzTyUHZX+3PJZJk+reSvTUbaiSwP4xRnGcb/jBn
	ujLsMdktkdQ==
X-Received: by 2002:aa7:ccd9:0:b0:6a6:6ded:b4b6 with SMTP id
 4fb4d7f45d1cf-6a9cae90c46mr922a12.13.1789149607454; Fri, 11 Sep 2026 11:00:07
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910143652.166683-1-f3lix.dev@gmx.de>
In-Reply-To: <20260910143652.166683-1-f3lix.dev@gmx.de>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 11 Sep 2026 10:59:56 -0700
X-Gm-Features: AcwNN1UFTPO9vNySiDMkdtVBGNXMPcgymzAD6eUPPtQ0NvEiLfkuP4abad7ttbk
Message-ID: <CAHS8izOJfCCistkyZfMpfvf8jGEgtZ5gB5qROC59qnW43PPC=A@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix TX binding UAF on netdevice unregister
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:37=E2=80=AFAM Felix Hoffmann <f3lix.dev@gmx.de> w=
rote:
>
> RX dma-buf bindings are invalidated by their memory provider when a
> netdevice is unregistered. TX bindings have no bound RX queues and no
> equivalent uninstall callback, so their physical and virtual netdevice
> pointers remain live after the devices are freed.
>
> Closing the owning netlink socket after device removal then makes
> netdev_nl_sock_priv_destroy() dereference the freed physical netdevice to
> hold and lock it. KASAN reports a slab-use-after-free and the kernel can
> panic.
>
> The binding can also outlive the device used for its dma-buf attachment.
> Since dma_buf_attach() does not hold a reference to that device, deferred
> binding cleanup can pass a freed device to dma_buf_unmap_attachment().
>
> Invalidate TX bindings that refer to either the physical or virtual
> netdevice during unregister. Keep a reference on the exact DMA device
> until the attachment is unmapped. The netlink socket destructor then uses
> the existing device-gone path, while delayed dma-buf cleanup retains a
> valid DMA device.
>
> NETDEV_CMD_BIND_TX does not require GENL_ADMIN_PERM. The failure was
> reproduced with the binding owned by UID 65534 across module removal.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
> ---
> The reproducer is available privately on request.
>
> Testing:
> - Full x86-64 kernel build with generic KASAN enabled
> - Unpatched kernel: UID 65534 bind, netdevice removal, and socket close
>   produced the reported KASAN use-after-free and panic
> - Patched kernel: the identical sequence completed without a KASAN report
> - Patched kernel: 10 additional bind, removal, and close iterations passe=
d
>
>  net/core/dev.c    |  2 ++
>  net/core/devmem.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  net/core/devmem.h |  7 +++++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ecfbd72d5d1a..c325fa7e0d6f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12401,6 +12401,8 @@ static void dev_memory_provider_uninstall(struct =
net_device *dev)
>
>                 __netif_mp_uninstall_rxq(rxq, &rxq->mp_params);
>         }
> +
> +       net_devmem_uninstall_tx_bindings(dev);
>  }
>
>  /* devices must be UP and netdev_lock()'d */
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7f..a21a8fe92f58 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -77,6 +77,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struc=
t *wq)
>         dma_buf_unmap_attachment_unlocked(binding->attachment, binding->s=
gt,
>                                           binding->direction);
>         dma_buf_detach(binding->dmabuf, binding->attachment);
> +       put_device(binding->dma_dev);
>         dma_buf_put(binding->dmabuf);
>         xa_destroy(&binding->bound_rxqs);
>         percpu_ref_exit(&binding->ref);
> @@ -153,6 +154,46 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>         percpu_ref_kill(&binding->ref);
>  }
>
> +void net_devmem_uninstall_tx_bindings(struct net_device *dev)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct net_devmem_dmabuf_binding *found;
> +       unsigned long xa_idx;
> +
> +       /* Unlike RX bindings, TX bindings have no memory provider whose
> +        * uninstall callback can invalidate their net_device pointers.
> +        */

Please remove these LLM generated comments that make no sense. The
comment is correct but no one reading this code is wondering if the TX
binding have a memory provider.

> +again:
> +       found =3D NULL;
> +       rcu_read_lock();
> +       xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
> +               if (binding->direction !=3D DMA_TO_DEVICE ||
> +                   (READ_ONCE(binding->dev) !=3D dev &&
> +                    READ_ONCE(binding->vdev) !=3D dev))
> +                       continue;
> +

Can you do a deeper investigation on what to do here or explain why
this is correct. I'm not sure we should do anything on the vdev
unregestiring? hmm...

FWIW I think probably an in-tree test would not go to net, but would
be a separate patch that goes to net-next? Maybe? IDK. Up to stan.

--
Thanks,
Mina
