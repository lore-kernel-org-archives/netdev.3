Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793651082;
	b=NidAjZ8VkeCcuJGZ67SrRAPYxQAaBVLn5zk/eJqTI0PRfYWI2mUKer+zxhQ2hCAHRj1J
	 jKAXUuXfRzCZGL2gjM8tpSeomfTacV3/goWjHIqL1ldi4KxIYZYcFz6fRES/X3dyQ5wJy
	 q7p7jYBAPWuuRZfA70b6o9XZqfnQtrNnXq3OwKXHrrdLBU8Bf7QweVFQ6/GxH9mbKnesV
	 kBM2SJ8OuCn5JBO0tMJsIlWtAIwix+sgAw2ESLcBO5TazFYdmaldSuJhoBf7G06tM6WzI
	 SvQqJkpwmC3jZA9t6nxFhE3TmmhWVBV+zUMUwofbLngT+AVQ+WBBh1n2SQ9iY6GALuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pRkX0U8+HuQCFFzjR90UGSol1Deg6kqBr45BiznV7xw=;
	b=GPwww/uttk/S00XoBLPCKbIwHXxprwAF995NBFvQCfdeNURKsDNgMpy+RlNwVkw/+5Uk
	 jgp6DkiATtHj2z33wFNq45OjPAmEHmJWQUXRjM0uEnSZZA8K1M01ZQaV7yira9ON1Nnho
	 YmOgdTOfL/qH164mNhHg7IHsbtwQ87nEe9ovZBp1Mqs5AlzyIhIPdge9mLvwwLde6fSpQ
	 1qDg0vMrDsakv288OySbjn9BJSaOmrmpRnINqSz8twC7cQCXPojtX7V9xWPKi6T/fcqQD
	 rmIRSXHRVj4Y0Jj4Qm/DPx7fn2i08SjkoFGtvAtJUaICeeTODFhmWx+NrKUzYRGWEjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SvOmcQSh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C3606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 382C3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SvOmcQSh
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1876a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793651081; cv=none;
        d=google.com; s=arc-20260327;
        b=BP9upePE3TWjomr5EL4kP1p+YKOl0wlrwwYZPTxEp5EznfrAbiSLpkW4V6J6HR/Dx2
         PQn6LvWj4ITt7gSAv3L65OZWG1TyggFIyQ+/Y28CEylRECu1LFZuyDJhB8WMdQxTxoWq
         2/kZLnjWT0jZ/N38K2ki6LHi9cyPp6A41S5esP1A7+a5v8Qsas3/f5ap/8E1W7zpKFMs
         WfKB3drj+TyN2mawujgpcEDMXqXKtMYiV3Up00LK78Jdk4jn72fu5d/qGvy7OzXgQpUp
         oUUrHA3vxMjOLnOE7mUqQQu7eZMKurRwGQ3oGKgR0yNNJo3uj3ONis8LIXPOuzA9sXwo
         pApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pRkX0U8+HuQCFFzjR90UGSol1Deg6kqBr45BiznV7xw=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=ePGIMwahiKVbcJ+hXf9h59AQLZJqboOD4ohDqlP8XyX66KJ4v6OR24OQGQK3tcVGkw
         t9uZ03hQnh1bUHCx4ONxbbXVD1GN+0biFnv2TkdxO8G9rZCYOgKSyEVcbKeAj7GSyIEI
         TaypP5Vkze6HwrK6lzcgRcNGZTCQNf1VgKvw9nAdbVuYFOQLd6RP0nyVxDboIS2UTcIv
         lIlwcA9ag161wixr9lHZ9rsdmkIZmNhvKNAVfcMpT8jGAZboki2ZRio1uZ+tbrOKNrTm
         4IziukwziJSdsvHJ29XvvsfEp5OLF3xV4eO2WzeyvzvJ3nqS8UvrbN8BMprgq4YmI7lV
         j3Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793651081; x=1794255881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pRkX0U8+HuQCFFzjR90UGSol1Deg6kqBr45BiznV7xw=;
        b=SvOmcQShy/Lt3LE+GpGQ7EhkwoAJ2Oh4dl3DKSKKoUDkMaOirBiVW7+e7Hcr3SqfjR
         SCzAzbBMhDNqzD5P+3DXQjwFtm84mTA9TiGZW9kYlDPzlPeRS5X6qXrkHLehuL+oXz/v
         a0tJQ7+URmRTDMS+dmS4t0JA8BOePVO4yJtsuCe/+i68+3svgEdr6NJ+9BSxzhGWJtzX
         D2+3vrhzSS4IGrh4b2ds0fRUX7ytMKUYob9XWOVLjynhVmM+QgInZDmbS+O7gsLrBccc
         92P5mgdx9E1rTjlCF23JPDzYMGMAom8d73U2aOxjDZhf2pa+SJ4+HkV7kOYcZ1IkzSGp
         QoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793651081; x=1794255881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRkX0U8+HuQCFFzjR90UGSol1Deg6kqBr45BiznV7xw=;
        b=NDqFt6EQJbUfV5OrCxiG8hOiZjAJT+pPkqt0pMzDmbDypllhytgH+vytTx/uJBqn9W
         xVnqiXwZkiJ0XU/gSapfHkYHDyiySBT2JbiXbRhMJunrgw9T1tXuWx6IrqN+fyLmntjU
         CrNPbyIfXcli8P9byVmbiUWTnUH8/zzzymkadO5pNEI7/6qgdGTOt4HgWGFECYzHW3b8
         grY0mCWmIv9MLpnRqYhHXKd3IOgkEccxU5IuGJ90FbkiukmuJA2lJfzRNnbFsEdH2r3w
         vvrJgIsOkXOv3B2agdhEZjEqHjpcOEyuXqdvN0jV55pCNkUSH5gfUrfTZG2hK86WZA20
         6iDQ==
X-Gm-Message-State: APuU4Z+jY5485fjvlAUFYdpMfczf2pZNG5/YBylnSRKEoAUpusz3MgDH
	ascekNfUSvgKRfN16niiL1NAcMn/8ps+bSnBN2RbZ0HbFoeBFzf5oJ+IaForTaimTyP+2UK3PTk
	GWOfP3/QmIKMmuwvoL6DE4EMFNokTQ/SZsBK2dA1C
X-Gm-Gg: AYBFou3v3wMN+UljIfVoa1gOVB8hYywfX9WQuNJXY39IVn4TrQo9jdSTYsxcvmwB80T
	s1fPlcdzd9sIQ23V3OWE7JmvmkeChDVlZn4Q7w6glIfs3sGPqc9ZxUuRqjvxf1vG2MJCpx5DS5R
	NHgmaUVSsCh1Q46gq+FRRfIRXtDEYbtByl4Zv9Ww7paViBH1mPtWBW75jUpMvIKF+jn8LC4BEX5
	wQnBHki9uPyZKlm5sI/hHPfcCRLQI8A5ee+acHSCBy6RHIhg3e78uG0qKUooxQqWamMahRmJCNx
	FPUhgK03gESZQJnLGTS7I48lQJ1X6/Gn8RO4bEzLPRRzO3QWXuoCg6wl/OISGskiYUZXn96a9pu
	+a9veLuK7OcYYLPZ6OkJoh/8AF07KJQFY8vDM7JB7G3baih36m8ZtQvmOL5fQEyrKT4wVWpVopy
	IrJKKZkh/4Hg6/
X-Received: by 2002:a05:6402:a20c:10b0:6b4:6725:f2c6 with SMTP id
 4fb4d7f45d1cf-6b539d6a214mr5220a12.13.1793651080182; Mon, 02 Nov 2026
 12:24:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-4-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:24:28 -0800
X-Gm-Features: AclHuK9HmthtDhK5Se7ln97xEjRHJQkrIbx6CEUxI-rYHFFjq-AxT46s87UOWio
Message-ID: <CAHS8izNMpH-RJm7mk=-MpMMT6nc1_AukmLVHmh2r=AoyBmZPmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] net: devmem: use niov_shift in net_devmem_get_niov_at()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> TX bindings use PAGE_SIZE net_iovs, and the TX lookup hard-codes it.
> Derive the index and offset from binding->niov_shift instead, so TX
> bindings can use larger net_iovs. No functional change, TX bindings are
> still created with PAGE_SHIFT.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/devmem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 32fafbfa1359..6339f221bc82 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -455,13 +455,15 @@ struct net_iov *
>  net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
>                        size_t virt_addr, size_t *off, size_t *size)
>  {
> +       size_t niov_size =3D 1UL << binding->niov_shift;

I always dreamed of net-iovs can be non-power of 2 and also can vary
in size inside the same binding (no reason why not), but this is
providing excellent value anyway.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
