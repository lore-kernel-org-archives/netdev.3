Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D03A3E68
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108141; cv=pass; b=ssi4iSSQVucsc4btSZQFBXrVz8Rge2m5rhd/kJ5S10Nd2D3D9tKTXxOb0MV1fsJANnk8Jz4NucBb1dovKvxcIHel48YjvpSVM3GvUeIPw0WOYrXmTmIA2hCNXw/3B/H93FSyjVC4LoKdE5nl4egedm68W+UVmoOoTmqh6Nn04PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108141; c=relaxed/simple;
	bh=mCEp/0gDCFHj+udesBZqQz+WyqBpGnnRo9HeqnIVIaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlqMy2di6LwAy00PhX2dCL8AGonVpNPYJAFkwrpLR9L4K0tHZM4uPp9XIp3prCI3vd2d5YPl99EjDWlS6VW1z3lszZRtfYctLaojQ6LiUsl2Z4LuBz1w9NfjF18o6yuxudy34HYWVNjSobc7F4kyyQyzpCxDxkM9NQy2M/exuF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsGy+Hxn; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsGy+Hxn"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4c4bf3defecso223729b6e.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108122; cv=none;
        d=google.com; s=arc-20260327;
        b=kt9GsyMjguwjY9ItLEF92/F9H7Zbn6hbami+FOIGvdYEOZ5hkrYYJpmrCPR8g4qUVj
         L8fNRFvtmbIbGQzukU72uBEp/lmkDKZw/+YjiMTn+5/ZReSbnCH6FX3cAeph6HH8Tuhy
         Ybc8h5N3pLT6YigH+Jo7Yir5yl5SXXyJxJ+rPcF4oQ4wqys0gVu9ns7D8XWAOR2+AcF2
         d3J3o0JWIxyvhDM8GY1j2lVObzqNZE4lT+95/9CiY8kitxPVYNwBT2EYXx9/Jyqlyqep
         0Ap2MFNNYpkubIKAvyCeuXQK45PpdU9UvFNUQCp1npO7sPjp11PxtcXGyD3iwkIhvKpQ
         3OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        fh=ZA2u+jl/sMt6H/jh5U6vfPr89wYRk0prraVwYWJwVuw=;
        b=ejK77GN1+dgLZzqenka7eHytBEEKoJ+QhYF9HE6GRpa9nSui9rWgQRAJSPgBaJMOuu
         QUHL5BeTTqHkGhByzhl8Ib8F3W3uIALqpOk+03FjOb4RUvkFOt00nzI7j0th3OENNNmi
         ylSFGSBaM8Lj9s/TTAW9eUGjzsEhBCe9fLIC5U0K7DXpoO+3D2w1ooCxkR50RVtB6TJs
         eJQu6xuO+8mzuwa9HwlAFsG/3Qz8InLaPk1lmdoSEhZvkhtVA79Py48FvJzC27txPJAJ
         NCl+aZgHrFhqPDszD0U9FNg94w3QcPLjE4UCfvwLeclfZzG8kwTQgJ0ohgqw3DfENUh8
         jRoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108122; x=1790712922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        b=dsGy+HxnaaSNCejDg0NtLQ0whRocRiavLOEGb/SGmsPw8BCZbdVXdba9lEyXK9Gozw
         3lWF2M+SvH8iBMqk3a9u5mSmgDFyr9h8jo337PdSZsNlEUbbeHfuMGBuZ36s6mZCH50p
         h8W/DyfLgtQcXJABi/liJv6tx/CSWRP0S4FO+7RddaRvecNVuVeY1okJL3AopxqXF/iX
         a9MH07tAR6dSX6qHxBFJ2UkLIaQrYd/glJA3KbubMgLD95rFM9YVEt19UhZIykwKOrni
         sKhkSKx+Icwsc1gFXjcDVFmi75MUFGbe2CUKWs0CZ6bG7leUlfzzlFqM+ElfmhG160yx
         V14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108122; x=1790712922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVx3elEB3t8n1eAOngOcFYDzr4OwdmHXD0B/yfUjmwA=;
        b=whTgn+ZIgSXUSdVQUOTu5VAHO/2jlYJ4IfRDms1RY8rpnYI2/GnDqB1wMwEijwSzz7
         oFaDbT1JLJljm5nmgmguwEwl0Js3Kg+WELdNN9DhX16X49AtVltc2cUkf7MgmshM7OSt
         VHIL0YBwN1MzVogD29OQcu2hQZXKDTsgctN651fqUgqZrxByhfyBxUG4wL+kcElpi5OG
         AoB9nTENghO9as+BeSJiYcct5SjYLejO6kk/4pvbWPy926KFE2H/5fEp/oBbHIoKw+gj
         nqqSLQpPNB5fguy9blmBd7epZGCCyVkWbDFRalkag+hefrj6X0TbbXSinWLacOUT4yo0
         Nwiw==
X-Forwarded-Encrypted: i=1; AKwUvByCeGqaS+0FnEPP5wts44elg+Wmw9lVYLFXLFEE/jJKpmWEGOwg+eDTNaJVpo1L+Ssont07TE4=@vger.kernel.org
X-Gm-Message-State: AFuF++lWG1jIE+C2hXGTiae6xYYH5yjIZ96p2IL+jnGpXVTP04Lt9ifs
	EK+9U+g563yCrpNGPFzC2uKRRnr0OAgir3L/YCCdgmtwHW6lv95QGivtIwQMFuHTbo81kAFi/7t
	SJkqGCglWNKUPSvmEtmGQwdr0UkEeSUQ=
X-Gm-Gg: AYBFou2Dz2Iw4Kl2AgnzB8jtN/YK1T3QDMf2WO1oek/E7JYZxcg/blj20UdNEF18auL
	IPdT4nFqedPiUVo6FTgIT6tlnJCJjwH68rXAUEU8moSZkLBZu3bmRxBsC5tIYDXz8spGCgt+ASZ
	cjElALV47YY0eGuX2KT+7yBCnAA9JxCpUnBNo7IKmuLw3jDVFcSBQTQ8es00lJhsMYmF7JFs7kJ
	WgelVX3+RixqBnvyDPu+6PqqETeiVUvJ6O8As/h4szGY7BRsqLg8ETlT1pJJ8UlZiqOAYL14+dm
	wWTPgczAsBlhXlimyIy47jaK0uCWOk6b7Ldf8kg3oEdqo5ZMPxdoupY6BVHVNExhToaByzNGhsp
	R1hIJj6E=
X-Received: by 2002:a05:6820:4c0d:b0:6cd:3ffc:e32b with SMTP id
 006d021491bc7-6d2d261ca81mr468446eaf.73.1790108122487; Tue, 22 Sep 2026
 13:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-2-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-2-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:15:09 -0700
X-Gm-Features: AcwNN1UVDsg65rPEAMRirnKU1eEF0cNOI3a7FG5sWYjRPvHMVqk42xmf1-ryA4g
Message-ID: <CAMB2axPZSbLNMONRt1NUi7iyji4zfT9MjHp315a0Gvq22opvyA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 01/11] bpf: Fix bounds check for skb-backed dynptrs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:21=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The skb_pointer_if_linear() function checks whether a
> memory region of length len starting at offset off into
> the skb is in the linear area, and returns a pointer to
> the region if so. The check currently subtracts between
> skb_headlen and offset of the check, and since skb_headlen
> is unsigned the subtraction can underflow. This causes the
> bounds check to spuriously pass and generate an arbitrary
> pointer of the form *(skb->data + off).
>
> The only user of this helper is currently skb-backed BPF
> dynptr code. Returning the wrong pointer leads to the
> dynptr erroneously being backed with invalid memory.
>
> Ensure the subtraction cannot underflow, and fail the check if
> it would. Use u64 arithmetic to also prevent overflow when
> calculating (skb_headlen(skb) - off) since off is unsigned.
>
> Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45..c8e219030 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4372,7 +4372,10 @@ skb_header_pointer_careful(const struct sk_buff *s=
kb, int offset,
>  static inline void * __must_check
>  skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
>  {
> -       if (likely(skb_headlen(skb) - offset >=3D len))
> +       unsigned int uoffset =3D (unsigned int)offset;
> +
> +       if (likely(uoffset <=3D skb_headlen(skb) &&
> +                  (unsigned int)len <=3D skb_headlen(skb) - uoffset))
>                 return skb->data + offset;
>         return NULL;
>  }
> --
> 2.54.0
>
>
