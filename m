Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1F3845A4
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333474; cv=pass; b=oZPjNmqx4TRUxsuQrbJwXHmerSW4LpzPHBJLX+5aWe8rVW0xF3TGIyso1sGk2VbDH0bgt8vVqtPMVz8J68I9ruWfzWO8l9xasfIoQt8Uz5K943P4D8I/fKfmY3SQBvVjcBYhX9iG2zNE0t142iP7WB6/rcntXQ6bVisGZLs3XPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333474; c=relaxed/simple;
	bh=71ETzD+l8/8KZpV9V//bdma2ToKvQ36gSqMPFnsxLrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4zX2rlq6ubMzW3cK7eZniDm1S6KrMPjPKKB1JJvhc1LhoYnhpEXvnr9SCEr6avOU2lnMehzLMkb2JB0/7lM1i16GwZ/Y5xm+wfD/dupeTQoXL6mCAWhzV1+447IKOLIBnCH5OjH6zspz4uD1QUk9lxcwXDJm1egmydsmKPMsD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afG5T261; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afG5T261"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8485ef63b68so884346b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787333471; cv=none;
        d=google.com; s=arc-20260327;
        b=k2LI/2E85S5QSRsxTWIObbIAVk7BEGC5OX/cDsGsaev4lPfSQKS8AlTpB4QJIzqfgI
         d4vyZhaxWBBS+jdVupa3U1eKWd7ytfYElJxmi8UuKR2BSoKb6rxk5Cqw3gGAo9MrmtiF
         FDHZS7SCmA8Dcwh/XQ7zVfHpRPdUJS4cgm8+OpEu5IJdBgKGg+hZ+dy/Ea7ZH0B7arhd
         uLbvR+WXaoltShxIq/OYfkk4hqZwMsh/YFTUaH+zCtScK8r9nPIbWXhBHGTj+3+maqWs
         hsA0SJwcfV/uaje663tVCKoXnAk3fZB1NDbMb7tF6lWoK6eiJzK7/E/AL5+3xKx4xJRZ
         L9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        fh=vANVXJv+ExG3XvCeryhFigP9/D8WX8VFHbVofoTTbMQ=;
        b=EeeNe7fzfdvkCRYAy/xK+cKdudYlCzSyCj8jwWPE3TpHOr/kdbkIF+BHkNyG4CYTs+
         wlBsYgi/M7zchma1V9dScsVsdQA+aIiPecHaoIDA0m+N76H9aufDkSazwlQuKCWLUFRb
         kdhRldxaY1aQimjF+KFN+FF+vEEEcnQ8OW5Y+wF91o5LkjRELQNhYo/SEDORVkB7rp2w
         HXB9pR/yDtSgsRaWKhRk8SvanNF9Zr64lTUqycOsnIQ8/Fnbnd88k0V2sEpXhsR1gUK2
         1kizA7z9GEsgwOFGXvAVOxfsPWG+Nvbp9V1fVElPrFidxb1enMAOvhhRKGbx/f0MrOCD
         7baA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333471; x=1787938271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        b=afG5T261B1tH5P+vfHVr2EwMibpej48KG2Pp81h8vnxlfrOuyUIAn0zBkfcjQHUZti
         10jvijvP0HNhbMejo7Bi3yIyXejabl2mqjVci3ISnm5YB8+FoiaaRVkV8NruELhRRYq3
         gHw5RsXw4flz0kL+C8+fXlgXKew3uGj1twm4hFWSIWz6Hl4HYilzPurnc3ZvRF6joZKq
         Q4yQqazWQ0LwZLg5GbfqZ8BDJWfsFoos6rkuCMBaNiLc5PLpazh5ROmAXVg5iYzyMZsw
         z5K21EucjWuvjqycP6zuRD1eukBmGIF9VFnTtmiU4gb8hLWGEIIv0yqrFrE057ldd6Jb
         MFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333471; x=1787938271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        b=TGf1WyZJZ1W5WF3QLNB+Q0Sh86CkvojFdsAFD6B7eI1TgBYxVrN+SPmo1B7YNk23QR
         iemXQeAqmHN8trq8LctN2wU8uvOw8Ac3bmimGGBsJ4AY2tXMT3S3wnHzvkjYH93Jffjl
         QsHG1ej/qKJcNWQoJQFepQl5FE2HjpP2FEQc7AoV5oTt7Vyv0mA+nEdzKl9TSTWqHUR5
         7JM0o36H+AAcyPNMkusHKk3ELqKJnWYfJG+JX0I38O99Im1IKwhaq7yVmUqEJdgS0I3u
         8o9P2FNDxlp5Sf0qHwHv6mdDERG2a1HJrITL9hSBHrDaWw3N7/GEzG1FzEzxvZWy0FZE
         +Tag==
X-Forwarded-Encrypted: i=1; AHgh+RolZQ6CYBR26ZFDLAc9IXzFJQM2/72ToS2iGwu2HYu57eV68PwVPlW7cAuqql9KP5RkIPw+jEo=@vger.kernel.org
X-Gm-Message-State: AFuF++k5Ayf9EOALvHGDgIhk1uFJ/2luSZdbgydhDLo/sLdrML81U3Sb
	hfxMYD4leSf6qHETvGinmtuYRWNhYmgD/4qwFXeqV7xGu1yYZ+YRlFwHowwl3j5Hv+If069WGxq
	rh54XXARyKwzB2AE3bSlIuzUYKacKwRc=
X-Gm-Gg: AR+sD11RsxG4yebsmGretiI1h+uZXJ9RsT555jsbv1/KEeuF1PzOzqc5F37YUdDEfcN
	6AE8YM5Vc1CVGC59Qp1lSmqzgguA/p6aQgy4Tn5oquDTjFB2tJkTLn6Cxfn0+ETZcSrAXs4oBID
	c9V6v9daEUTXyVyV3xgxCIknld6atjrmIWLEobfXpSDnM3RwMixThiGSrd7vquyJjqPCzI4tdQe
	9WqumFi1brJ/gANnoApMCVNqPR7phjMQQjrS5nDnvBTxlEeD66cYKoUJA1zHUVzy2ajtxG7whSO
	20ZSzqKLz5a061iTWrtSpvSnYY0jCeD1Yjo2JOcO9TzKfAoq8GrELukb6ErI7EhAFvU6E/bF3xr
	+M6/sFFbTkleBIl+E7KbAXpiCjA==
X-Received: by 2002:a05:6a00:1d9d:b0:848:67ca:bfd with SMTP id
 d2e1a72fcca58-851fa017101mr13222177b3a.16.1787333470987; Fri, 21 Aug 2026
 10:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820152532.621639-1-s.mahnur.a@gmail.com>
In-Reply-To: <20260820152532.621639-1-s.mahnur.a@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 10:30:56 -0700
X-Gm-Features: AcwNN1XANjk0n8jzavAweB4B0jx1QOPaM2D1vGwpdzDHxCe_LsEvJuMRqaxLGZo
Message-ID: <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sock_from_file
To: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	netdev@vger.kernel.org, andrii@kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:25=E2=80=AFAM Syeda Mahnur Asif <s.mahnur.a@gmail=
.com> wrote:
>
> bpf_sock_from_file should not dereference a NULL file pointer.
> KASAN detects a null-ptr-deref when eBPF tracing
> fentry/fexit programs are attached to points such as
> __mmap_region and file_map_prot_check kernel functions. This can
> result in a NULL file pointer flowing from context to the helper.
>
> A minimal check before dereferencing can fix this.
>
> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NE=
T")
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
> ---
> v2:
> - Added Reviewed-by from Emil Tsalapatis
> - Fixed name in Signed-off-by
>
>  net/core/filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..7c3caae4bafc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_soc=
k_proto =3D {
>
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> -       return (unsigned long)sock_from_file(file);
> +       if (file)
> +               return (unsigned long)sock_from_file(file);

given this is a legacy ARG_PTR_TO_BTF_ID, it can be not just NULL, but
also a) small value bogus "pointer" resulting from NULL + offset
calculation and/or b) just random garbage casted to struct file
pointer with bpf_core_cast() (maybe this hole we've closed with
explicitly untrusted, not sure).

Either way, this is not a sufficient fix at least.

But I wonder if the proper fix is actually to mark this (and other
similar) argument as explicitly requiring trusted PTR_TO_BTF_ID?

Thoughts?

> +
> +       return (unsigned long)NULL;
>  }
>
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
> --
> 2.53.0
>
