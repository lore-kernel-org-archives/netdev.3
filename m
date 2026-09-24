Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC52C15AC
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262142; cv=pass; b=fe5AYUH8cxDeOWcqjhYUANWM8La0MsCSHLwNx3EmXOFwfGH236WEuU39m5GJ4fzJGqL8XEHi0w1ioQTo7Ye7PVBZEGDWbOvANLYdgX6zLPhqgZDrRybHT+hlamcLpq5FsIeXr3/Nl1XFabOvcFZ27E9mrGVtEV42F6jKx+oFZTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262142; c=relaxed/simple;
	bh=ShNN69DhaJyHp2DOgt/K2M0XTHi/ubdDgTbCqzMNj2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1kzcWjcM+14WzwyPkFsDwhrP4NZXXwIOTyrzeR2yilATO+8o1pYNqnUv+ILuIyf2RMyDr+Jotx/Xp6qKHNbAzG2kZZQtasvw18Mqtaas2HPmsG0nmNa3lG/CPE11NjK5sLIvX5vHJx/w0TiciwkOF+FLqQnTRlVijWSdVwEN+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swY0Uudc; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swY0Uudc"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a9d74e8292so11408a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790262137; cv=none;
        d=google.com; s=arc-20260327;
        b=TJmNUWCd0uAwg9ho1pkWhxMOaDpvnbwszx8uXJJRRG8aNP6A1kXvKubCf7GfbilJrE
         OFLihZAdgrK20w0oJWIRaxSzO2wRrTD5fhJvbKJgWek22n7pTCHoaHQw6d4cCiJ7jwDB
         0htEgRtgjWRDQntEczbDo4zN2f4jfY/TBrpC8WFf815ip8p7aDiXcEe+Fmcsz7Cd/eKm
         XFvV58/5z+Wqx7QjDSgHnbAPUI9PXDF82fd/CU4aoolua7eix4MmSZer3CzxYBCgBk4C
         DrZNDxTkx9kw0YZAxgILMNgE61/SjdqAmn4hrpruQKxKoYGxEs8db13K6EdoYQXoJ6Ce
         +S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZR1ILn9TYPBwHk6m2pP3jOeJW2/wKuJF/ueaZTjeaY=;
        fh=wmK9//F6yrVL0pYZxeonuTZeCuyCkgPHs439uVZTXTo=;
        b=EMkRP+ZOREWHbqAxCix/fOyttjci4sSVOOaPm015fapTUt2nnICgUlAGxdfcq9/V09
         AaR79sEJv4I0IiIzfxIIhHk4eAE9ahFjjOMPi3Lv0lGYGM3moo7A+iQlJ9gxRX+zt/JP
         vkpHcjIxtoAGQOAE0UcvxCysuH3VF16B2NU0hRfyIxNf8pc0ureIp60ASQ3RnJDG3SSi
         ic5ai+RGAich0MFpmZ0UtE2rBz8RmkRhxo01DIbg2GdAdNpviLECGGf91gk4sGZWPXsR
         REBdHBAeLYjoi3lkn/b2QrN87p0WQuVq2dGyzp5DkstAEQnoAkIRpag6U3A2adVKkUCr
         zxsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790262137; x=1790866937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZR1ILn9TYPBwHk6m2pP3jOeJW2/wKuJF/ueaZTjeaY=;
        b=swY0UudchTjMjFvUJEUAnLhsD33oGR5GcHVFO0mWV/y+oonypULFpLDmPI/xpsskGn
         9z6ktE24X//J4XcgGq8sHd/6deJJgWKKr5bILzPlBVpmgYLF0rhHIoDmebr9zn1d4FrO
         g7r5WDo4v7vecal0w/7hwbxDlSMvPKSsOWgsr2jYUapu6b3IOWuJMEx/OTD/CkGz1ueH
         uamD8Q38u1IngoQbBFMS7QcpFpGVh8NDOQPdQc/1KptFYRA9cjwOuandNrdvIbaYetJz
         AJqPG2WSHCJohbdq9p02L1C6Ix26ztKmAvAGzhWibGsliKVWxa4cRXVCFG0FmYZAJtFt
         NMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262137; x=1790866937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZR1ILn9TYPBwHk6m2pP3jOeJW2/wKuJF/ueaZTjeaY=;
        b=k1+WPCiwxQ9GNv2vwOBs0M4lZ4Qh1RmZl8Vrp6B/GOZZOl9NRSMOyAP4I5/wjuIAtS
         V9cTxxzEQcSyrvPPD0SopxBnj7gQRg81y3EUYC1zjocyKfVC1Z6ZBs4W2c/l7OB/3ATK
         EkR7jjVUE2aszD/F+vbFfvecVk5yCGAmtL4BA44blkR7jQJtqiknQ1cWs5Ox0tFSYSxo
         u5Y94XZ1kOsHvsdt0BpNR4OrMPmRGJDLd06whH08wENpuuSYpd9u3tsrIBhbheezxvdN
         7bHxtS/Z5FKxowuQQi4rrKJFSDO9j6SrAttxzjJXMbEqaz6yiHyyObkp4nT8zTPEHZz4
         QEkg==
X-Gm-Message-State: AFuF++mT/X7HoW90BE7nFzZMkzXbnz05aHHe1WyaC1h4wwC98Ye34YkK
	x+vqGbWMRNqea1tnwWfUAXo3pzR8r7T0h1EQVzHi6J0EIohjujQ2k4L2mA/E6Wff7BCdrpnSdho
	XK5nnW+MRSsrc32lK0qziMFMdNVis/0Poc8zyaT8O
X-Gm-Gg: AYBFou0j8RmmGS0pKVmGtviIeqUw5p2aBW6+GnFVa5AQq00aiHVkYVFh74rcf8+4ROs
	m4QJtPoBnrMEH9TejLoYwBjDyM6PBtEoBpSDO7Q7B6L0dHNHuLZheeAQ+Ox7YEr90fHTPbue073
	JfUjEsRcqqqVzoqQApZwvDWBvUND2eGjgUhL3Hp3HLABjjq3WnliQZ+j7T5OSQspkT3dpnEHGLh
	t+R0oIhESeDJUHp9zNDEE0ehu2H5zajKud1/g3db3fSwrFkrzaN3E1Y0cIRfLunWaSL1R5bx2pl
	7V2JNBJ1k1ZSUSImUZpWTA+2GkDS6SaNo9X9fI0L0i3TmESbqm50sjLEU/hm9Mm6KaEOpei6YsG
	NYwwSSQ==
X-Received: by 2002:aa7:df03:0:b0:6a6:32f6:2841 with SMTP id
 4fb4d7f45d1cf-6aac7cd8562mr60719a12.14.1790262136510; Thu, 24 Sep 2026
 08:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922204348.717198-1-sdf@fomichev.me> <20260922204348.717198-2-sdf@fomichev.me>
In-Reply-To: <20260922204348.717198-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Sep 2026 08:02:04 -0700
X-Gm-Features: AclHuK-Rw22mmYVrW2dkDQdq_DFu4D5I5rl1QgSsMEN2Zfe2L0z7rCIa7BiKQQE
Message-ID: <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist helpers
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:43=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> io_uring zero-copy receive and devmem both maintain a bounded LIFO for
> net_iovs in a contiguous area. Store the freelist in struct net_iov_area
> and provide common push and pop helpers.
>
> Leave synchronization to area owners. Keep devmem's area adjacent to its

This could be a follow up change, but I think synchronization should
be provided by the netmem/niov infra, rather than the area owners. TBH
the infra providing an unsynchronized data structure and letting the
area owner use it and shoot themselves in the foot feels error prone.
For now we could use a comment.

I also think we should not provide _push and_pop functions, rather we
should provide _push_bulk() and _pop_bulk(), and the caller can decide
to only push and pop 1 at a time if they need to. The reason is that
in allocation paths, we almost always want to alloc in bulk. If the
infra had the lock it could lock once and alloc a bulk.

The free path is more nuanced. I think _push_bulk() is actually not
currently that useful, because page_pool_put_netmem_bulk() ends up
internally looping over individual calls to __page_pool_put_page(). It
seems like there is a very low hanging fruit optimization possible
here where we change things such that page_pool_put_netmem_bulk()
actually does free the entire bulk at once, and if the pp is using a
memory provider, it uses push _push_bulk() to free the entire stack of
netmems with 1 lock acquire.

But these can be future optimizations, so,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> lock. Use u32 indices and counts, which halves devmem's freelist storage
> on 64-bit systems. Reject devmem areas with more than U32_MAX entries
> before narrowing the count. With 4 KiB chunks, the limit is almost 16 TiB=
.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/net/netmem.h | 28 ++++++++++++++++++++++++++-
>  io_uring/zcrx.c      | 25 +++++++++---------------
>  io_uring/zcrx.h      |  4 ----
>  net/core/devmem.c    | 46 ++++++++++++++++++++++----------------------
>  net/core/devmem.h    |  7 +++----
>  5 files changed, 62 insertions(+), 48 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c3..da885d95ea63 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -101,10 +101,15 @@ struct net_iov {
>  struct net_iov_area {
>         /* Array of net_iovs for this area. */
>         struct net_iov *niovs;
> -       size_t num_niovs;
> +
> +       /* Stack of free net_iov indices. */
> +       u32 *freelist;
>
>         /* Offset into the dma-buf where this chunk starts.  */
>         unsigned long base_virtual;
> +
> +       u32 num_niovs;
> +       u32 free_count;

Why not keep num_niovs a size_t and make free_count a size_t as well
(so that essentially we can support anything up to SIZE_T_MAX - if
that exists - num entries)? Do we gain anything by converting these to
u32? I know in practice in really doens't make a difference, but since
struct dma_buf->size is a size_t and that's usually the type we use
for memory sizes we should use it unless we see a reason not to. Tbh I
don't think the size of the freelist array is a big deal?


--=20
Thanks,
Mina
