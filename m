Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DF568FCC
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999684; cv=pass; b=ZNFUCAndweLjmYy3aSefF2zP8epSokNR/S+ttZ1IopCRR49Lll/gXNuW6I9T9bZayDNfx+8//3nDb+NGv81prYsV84eHrOkGO48C51RnyYC+G7CODMi47R9SIgytACXtw71RcUQ6hCxueYVwyVgKGNXmo2+Nh1ALyxMArae0U58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999684; c=relaxed/simple;
	bh=f0SLdWL9E138QUb2D0PGhvwvPjEMduNm3zGCMH/mn/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po39vdFke23yLq1j4JPBaG64AgpHvbQ+yzluperNxWUYgLRlHYKB32+tHBtYEzKPXLRpXVxn6PkfguH3DRUsokSxcX+VYcYop6pUOkPl2reLd66SIcKRxVR/38P4iFuf26yoSAbnCB/PMspMsv6E5fN1AAhXZ9odq33JyUjFTzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVLGjhlD; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVLGjhlD"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso43785a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791999675; cv=none;
        d=google.com; s=arc-20260327;
        b=YDVHREiwvzmmakKW5TqTRo0P0XEiAvChIgFAByqLJ2rEiBP11Ym/HQUPYth7uhYOac
         1IYAeagRu2UBKlqe5iU59AZNRl4cHH2mOkO+XpBB0ptnhBZHnNKNRvaC4qTS77EzNsTU
         0FMqR006bt+60h2Mw1fDltUTpQf1B8vapYEWMarp7dKeObLgblVSNSOymMM9nSJWxtRv
         szk3AMSB5IBpqXy4qO50Zl4uA17GuFA4HNIE+pt+Q1BUgX/yp9SC7vEM6AVymAWUvH74
         sfdT7EDa9toCBHNG5llF6GnsIr4Alb4c456TvQBC9SheA5Fii4n0REJLxPEMsZiY49lL
         Lwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
        fh=g+70DSSpnKqOoFCUhkHq+EOOP42dtBS3Xoqs0AbTmAg=;
        b=hz/4vanEv1kxGHhgjdrpAR8ZMq7mEV9aCCUd+Mge8jDp5OM0MLTEk9kKsyYFRNnOZq
         o08L8gSOxjPhZoNfZWCf9vGuq9yvSuoTkhbnSuRwhjyikOoL+PCCukPihO1WTGb1MAeQ
         7UAKd1bElCHfAXropEJdGLLXlZq3Y3fy6A3zQeP3zs4dRJslBBP1nO7XIjauAhVxhQA/
         cjEj6u+3LThkNqSHvjiUFGOxn5s5Bqr2BS1ucyg6xXeG+DwlQSJYSkmnDYKX2EaCtCwQ
         gEvUgMJxFyDJSVJEH2EvzE2GuU0VK/u1Cyhml4xBvRWg41MOcwhhRxwSkgWWIreznJzl
         wDrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791999675; x=1792604475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
        b=pVLGjhlD/ng4/MZG/9X3p/9SFV0WgyW+x59aATXz4CwBXINi3ynT4Vb8v5Ae7JuN0W
         75HkF64U6eST8ymsODdXzHCJ2xslcUlpDGCkgPteZx6PD/qva7n95x4PmoOAyTIevBqJ
         qyogjQfPdlIMojhE3KqszoC2DIARgRwkBTUetC2SbTMI/x58T7ofVcXyXzMSCmmwV7sZ
         xRMNEDoKaaKso+mn/K4913D1fMFFKCkhuMQrH+dWz93kJJlyzt9V/Y7x5p+vsTQ9st2I
         EJ/8K3IL3FXO1K37gUpnLcHvczv5xpEkR47Blsi1PsN+mMAWYFDqqG48tbKAhb8OGWoZ
         6/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999675; x=1792604475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
        b=IuAOsQ7IoniseVoXXOcc6bYJmZuy2WbAV7utx08ZPHYgifZh9VOaCeH8FsytRIiYSF
         8CAQ54hSyboKtay5AdQJPFjulcudGrca/6MBi0L2Y02+sCpzKFAFdMVpBK4sJcwAHFbA
         9pdjVBUaNgbaJiR2J9qltQhve0L4tOLdRzFUblU1pMHpIkjcjnJO4pnSl8OZRnehpIQa
         FjnAZ3MGmEGMvkopcWCtKrBmO1vbuc8v2n98RU8ujTBAvh1hE+tRvtpw9alUNmYLx2V2
         DiBH288s7Lv6SZ2h5tCsoRdAOzFOSwcgEFvl9vyYFRLuy4ydWO276Q8+XeIOMp2fm/ui
         bieQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjlJrTiYOPQLBTapBackYUoRDoqC92DFG7F1JtrZidVovLNcbvPr1QS3to48nbqHOa1GF5Mhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMRD3c4EKujJwLW7/tcRpcgN29Bdmotv2ABKBS5JT+sAveUttT
	H2u6zUF63O9g40vmXnzOwfbZlLdTpBP9Uyv4Mtap0DiduaK0B+5ufEQkoriVD9/nGLA5XDUXy8w
	EPdelbPeBVDgaE1SYGazdmP/6SBcVAaTNm9QPtwQm
X-Gm-Gg: AYBFou2yV4/3DjIC9UthVqS10xuANm/P3LQ3jduiTgQh0KEN805JcGS8nX0MjILBk1D
	VXmKQ+k5e0u3/75SV6nvdyR/5/EsAj21xZeQIqXq1UGDq/+e38t4q4ocInoXJRUYelAIEO9yizQ
	wQYmtwBu3L0CKgSTExowTpt1psTqneNM7AR3jX8cmsZz2QYavKPgmKygtgGrkN3BN9kWb2OgVvA
	k4dyMwvGoeTF0fX+u68KyldoypE11UrzKz4SrZe5fagvGplp7qFXAhLf3snpSQaKRvaLFPOhy28
	n6KeDRGeRZ+Io+EebhkdF4Pb5M36ivT6qkUoG7tvOmhQF1xKIVg32A==
X-Received: by 2002:a05:6402:20cc:10b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b2096e7803mr65994a12.2.1791999674865; Wed, 14 Oct 2026
 10:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-2-almasrymina@google.com> <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
In-Reply-To: <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 14 Oct 2026 10:41:03 -0700
X-Gm-Features: AclHuK8u69N7ew0pAEQZHwLPBLn5xdE_tbIzLnNp8gBabvanxWdbaZUh8Vuvjwc
Message-ID: <CAHS8izM9E3YTi19LdNSKY+FWyLtesTAjEmCRHxhgiu=y3t7jaQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 10/12, Mina Almasry wrote:
> > When a bound net_device is unregistered while userspace still holds a
> > netlink or TCP socket reference on a devmem binding,
> > mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
> > netdev_nl_sock_priv_destroy() will not touch the unregistered
> > net_device, but leaves the dma_buf attachment mapped until
> > __net_devmem_dmabuf_binding_free() runs later on socket close.
> >
> > Because dma_buf_attach() does not take a reference on dma_dev, device
> > removal frees dma_dev while the attachment is still mapped. Closing the
> > netlink socket afterwards triggers a slab use-after-free in
> > dma_unmap_sg_attrs():
> >
> >   BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
> >   Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
> >   Workqueue: events __net_devmem_dmabuf_binding_free
> >   Call Trace:
> >    dma_unmap_sg_attrs+0x76/0x2b0
> >    unmap_udmabuf+0x8e/0x100
> >    dma_buf_unmap_attachment+0x145/0x330
> >    dma_buf_unmap_attachment_unlocked+0x96/0x130
> >    __net_devmem_dmabuf_binding_free+0x156/0x2e0
> >   Freed by task 9:
> >    kfree+0x1b8/0x550
> >    nsim_bus_dev_release+0xe/0x60
> >    device_release+0xcf/0x250
> >
> > Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
> > and null out binding->sgt and binding->attachment after unmapping so
> > unmapping is idempotent across queue uninstall and deferred binding
> > destruction. Call it synchronously when the last bound RX queue is
> > uninstalled in mp_dmabuf_devmem_uninstall(), except when a leased
> > queue is unleased: the physical device is still registered and, if
> > restarting its queue failed, may still be using the binding.
> >
> > The same use-after-free happens when the netlink socket is closed
> > before the device is removed but RX tokens or the pending release work
> > keep the binding alive. Such bindings are no longer installed on any
> > queue and were already erased from net_devmem_dmabuf_bindings. Keep
> > bindings in net_devmem_dmabuf_bindings until they are freed, hide
> > unbound ones from TX lookups with an xarray mark, and on
> > NETDEV_UNREGISTER clear binding->dev of unbound RX bindings for the
> > device and unmap them, unless the device is a virtual device leasing
>
> [..]
>
> > queues, for the same reason as above. net_devmem_lock serializes that
> > walk with the final free.
>
> Can you explain net_devmem_lock a bit more? In
> net_devmem_dev_unregister, why can you not net_devmem_lookup_dmabuf and
> then rely on the binding->lock? The rest looks good, but the
> new lock seems a bit excessive?

That problem that my feeble human brain can barely understand is that,
in order to revoke bindings when devices go away, we need to hold the
device somewhere. I decided the a good design would be to keep them in
the xarray but mark them as unalive; that seems nice.

Now xa_erase the binding got moved from unbind time to free time,
which makes sense, but that generates this pathological race, where
net_devmem_lookup_dmabuf for unregister can actually find a binding
for which the last ref has been dropped, but _binding_free() was not
called yet. Fun. I tried to work with the LLM to find another simpler
approach that gets around that but no luck, the overlords find a race
with every suggestion; this seems like the simplest thing to do,
although it is depressing to add yet another lock.

I uploaded v3 btw to address the 1 non-lease devices issue. Seems
we've crossed paths again, let me know what you think and I can spin
V4.

--=20
Thanks,
Mina
