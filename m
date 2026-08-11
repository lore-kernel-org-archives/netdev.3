Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D835201C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484285; cv=pass; b=FxtYuZTL3Q53b60dJIWZ4gdkC0NK8azGXWEnAsdoIh55RWudFGVwB5rgFyPTufi3zHJEHBBRbvzygjWfcutPfp8UL+4i3bTnIgt7DQFulo1G9NXhZQ1tnZSL978sUmN8EugR6GXCCeHnR7K0SRtayRz3b108wqBIg0eLz/bu0BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484285; c=relaxed/simple;
	bh=kQJpZ2LxciOVgNsyG0oOcBBWpjuJ/RktW+iJUDTkurA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj+3a5zRyYHsTCfrGlU476rnFhHk3N8uoEbIWWeBzn639db6OBiMpiI2oCmln5zMnorTvq8E64X60itdAXG5fb9wy4WZU21ZNu2QB2I2UiRhJ+yyud758376XCuTHdfJ+Vb74+ckqRpqV9ETtgvM6A9OQEZmD3b09espHBK5CTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBp5sN1Z; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBp5sN1Z"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8111c0c7561so2482017b3.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786484282; cv=none;
        d=google.com; s=arc-20260327;
        b=Oh1hpXfjvatFWAj/G9HYZ8+rjx4+WLtxCRnkU7fNtzGVsmIN9p2XyoatJ64GaAvVhB
         LQFq7qscGQsQDbEsjdS2DD33D3RVNe1OtfRlyvP4nfZ/HdIkqgZ8k1+WBhqaeqo6+yfx
         CBbnlIEJoYKpEwNTX7O8inHhrO9WBrIuZwYl+Qnx5D8+dklKlvsZF44H4YtgIgrNeFXZ
         vSLGaocWrifJt3UZFyzJySrmEUafpTPiJIor7gGUGghxG9y8Ih+RmihzKa1AzMmnL6Gw
         Ycg4h6e4KOn8g1yEdjdplbme+0XdbBSQNfya8eLy4UwndxwQ9JlTg+uRVpKCVV4K/snU
         pc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        fh=Dly+E5CsY8yvujhuF0KKLb4yC98oWyPomvfLJ4N2mCc=;
        b=HsJ6www/LOzYow4FMkN4g5A5HHOIZdPF7mh9wAvCjrlml/z7Vwwco9ptIFqcL4NFBz
         sz7RMU5mJIIxSxIH97HGRHoFajJhQqF9fziBgRDXuRjIi3tPJLu4hhoB5JPrcL2q8aP6
         zNE4CwSfD+H4umeKqa0EcxzkjY4tlnzK0/moIXrYEIkgQf/OrXVwsj9lKvGTCy8a5OTz
         p1ogzSq9bx//IzvPSx9HW/1gW+w9ZcEH5wrUl58cZI3X1U3TnPPJ3+UFsV8ujzk9h8C+
         QkvBwZussUyup8XSW0MyG6qoEW9WckJf+Q3Mu049tAd8n0kwnNOIzRN9DdRtHztdua9u
         lXiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786484282; x=1787089082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        b=YBp5sN1ZaUKO8OEiIV13F39VrLUMVgE3YTX9Nbu+mvALWPqvlWO8bcrdB9pr1c8xAO
         SwDD2SgRq+wITkOpShf9YCaB78S6LPlLBBYPJH4Ztgvy9CPPsBqGQL/tn2memdSMOW2Q
         Hu6F189woZZswkkgMBPxebUj7reYpxrUFxLZ9nHDunYQEEv7XqyX2a4oYw3aLki/GVci
         ZnpFpzKZ59qkYz3UwauwyzwKNIIaVCwp4NXozmQyMaeJwW6nVq9YA2juExqoezzx3Ntr
         BeotFnyRwkNC7oyx7eBbITpJ6kJHrkuk8VSeg/1s9racsAQ1AopIl6woQYvxmNbKyQXj
         CMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484282; x=1787089082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        b=EDLaL1TMTeejcz6+N0QWOorRJnd26e+Av9lpAJmO2JrE1mBcsuYdNkxqLQsOFguYe8
         +4ooYdEltHzNBCH7mSKOCwYx8foA4m9fgSH8qFIvQLnKOvQd3UUNOI2wR7ysMMqxdo5g
         as0SSoU+PErovmjPSnf2vA/OLq9tjjxOnKPOeQ/bv1RUFwqaH7mkXA0XCKskBx+nKUIH
         8stXvnueP5aNBFo527Hx5tQTs78p6j4Cwdbqv1uaGpScNjd0etvoRjFD5zxyYmci88YJ
         8lwAU4ulmyZC85bmZ2Ro7p6U6OPR2yJJNT6/V2fT5/G4+PQloXqX2c5bN3OcAQQJlFnw
         TYcg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6k26bMJG3X1A19T+GJWovM/T7dBOWMLeagaf6+zExqZ80vIcoNiH1WPuAlc7sbAZ9o7/4aeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFb2d//yTtYVZnvh+j+EDNo5Skvi/FMeqOwfoDh/LFUjiFqtM
	KPoBA5ZFeUJxFbQNeOKbn1U8SkC7ZoL2mieMb6gfsVixchNPfV5+YLRyknD4WvYkU4D6cuVjgwG
	4QIopaQLVMBWt5TqNzXbrqLfIglN7VaY=
X-Gm-Gg: AR+sD11qc+qV1vAmcocKn7ig4HTUS/4MKrkdZ3LU/jshkflaNSG66aJxj5GrU+bCKZK
	tvcNg30+cOmEhBqYUrd5VXvr2FAjRmxBwRhj+l2WH8Le8VjV6JzK1ucHOnS1ghMZx7kWMqdDx/n
	HVpy+ryTIuTV9Igj3mUE3AFb9c/6mhkbLRrKv70Rufhn4fw61uBo4+xZvho0TqJyQxr7j7hF7FU
	DJ2jkpvCqTQzaE6qkLPpsWomwJAE+265KOdb96BLRHdgVKlPSNTWK0CTNuJFCnkkfaeUMhosV7Z
	dcBdR3lsJt8VghyPBZ0rJg+I4jolX58dNXAqGkYUDmdH
X-Received: by 2002:a53:c148:0:b0:668:d09:f354 with SMTP id
 956f58d0204a3-66b345ba1d9mr99815d50.50.1786484282326; Tue, 11 Aug 2026
 14:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-9-ameryhung@gmail.com>
 <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
In-Reply-To: <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 11 Aug 2026 14:37:51 -0700
X-Gm-Features: AUfX_my1PtitOvYVmAIz6f7TjlV4KeLtpQSene380p3dvpq5XY0TfBc2QnQqmZs
Message-ID: <CAMB2axO0dhqd71m+PGo51RbjFHsztD3=0B7sxg-aCSKg9j1C6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Add a few bpf_cgroup_array_*
 helper functions
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > In the upcoming patch, the array can store a struct_ops map.
> > The array could have a cfi_stubs acting as a dummy instead of
> > the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
> > also in order to support storing struct_ops map in the array.
> >
> > bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
> > bpf_cgroup_array_delete_safe_at() are added as a preparation work
> > to allow skipping the cfi_stubs in the upcoming patch. This patch
> > only skips the dummy_bpf_prog which is the same as the existing behavio=
r.
> > The current bpf_prog_array_*() callers are changed to call the new
> > bpf_cgroup_array_*(). This is a no-op change.
> >
> > Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
> > does not need a temporary buffer. The cgroup caller already holds
> > cgroup_mutex and dereferences the effective array with
> > rcu_dereference_protected(), so it does not copy to userspace
> > from an RCU read-side critical section. Details in commit 0911287ce32b.
> >
> > Another addition is the bpf_cgroup_array_free(). This prepares
> > the array to have a different rcu gp for the struct_ops use case,
> > for example, a struct_ops could have mix of sleepable ops and
> > non-sleepable ops. In this patch, bpf_cgroup_array_free() only
> > goes through the regular rcu gp. This is a no-op change also.
> >
> > bpf_prog_dummy() is also added to return the global dummy_bpf_prog.
> >
> > bpf_cgroup_array_dummy() is added to decide the sentinel based on atype=
.
> > It now always returns bpf_prog_dummy(). In the upcoming patch,
> > it can return a cfi_stubs if the atype belongs to a struct_ops.
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> One style issue below.
>
> > ---
> >  include/linux/bpf.h |  1 +
> >  kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
> >  kernel/bpf/core.c   |  5 +++
> >  3 files changed, 76 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 047ffc029666..e371a4733135 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *ol=
d_array,
> >                       struct bpf_prog *include_prog,
> >                       u64 bpf_cookie,
> >                       struct bpf_prog_array **new_array);
> > +struct bpf_prog *bpf_prog_dummy(void);
> >
> >  struct bpf_run_ctx {};
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 7abbe12e108f..081d81de1816 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf=
_cgroup_link *link)
> >       link->cgroup =3D NULL;
> >  }
> >
> > +static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> > +{
> > +     if (!array || array =3D=3D &bpf_empty_prog_array)
> > +             return;
> > +     kfree_rcu(array, rcu);
> > +}
> > +
> > +static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> > +{
> > +     return bpf_prog_dummy();
> > +}
> > +
> > +static int bpf_cgroup_array_length(struct bpf_prog_array *array,
> > +                                enum cgroup_bpf_attach_type atype)
> > +{
> > +     struct bpf_prog_array_item *item;
> > +     int cnt =3D 0;
> > +
> > +     for (item =3D array->items; item->prog; item++)
> > +             if (item->prog !=3D bpf_cgroup_array_dummy(atype))
> > +                     cnt++;
>
> The outer parenthesis needs braces since its body is an if-statement.

Ack. I will add the braces.

[...]
