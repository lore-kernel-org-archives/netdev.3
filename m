Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724E42E42F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827328; cv=pass; b=NQ48AIgV+byb7D69e82nZwODX9qHMuw9dX/t1qLZy21LjaMFbBF7oYOu2Q6M1AR6w+E5+8x6lpgSfqH5dsbJICoOIYq2ZYWvImc1Lxb3CgZIlb/4xuS5EMfE+6kS9w8tI/3jYUGx7O9A8soyzhf9okBxK1OGVGIMbh4iJfyrpoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827328; c=relaxed/simple;
	bh=jDDNSeL3p69BtSLhg+WaA8iRlZDcoKpu7R79daNaadk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhKM+3wmjLvKGZjwiFICdECEukZUV4YokYhyrtZduATT0Cn/vb4gvRh0OzBALyL0twQHEPlLnMKSswA5M3A0Z1cJx7RpAD0Kh8jet5PQ4T6m5TCJy7hPkuecF4nUHQUnMca/orRkk3Rwi4E8+BEjOqsDDizfYFXir/YKANCuehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIoscuDS; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIoscuDS"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b21f09ea42so1831086b6e.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787827325; cv=none;
        d=google.com; s=arc-20260327;
        b=XffzPchovpTfGkd6SSitV4Al0pIZOacM0St9REenBZMcJirsUmQRMxA0cHY41eXl1Q
         WI+fuqoqbMDqDlr1PJURMtmhnVfBfGF1sfol5+AHc0NmqeBVMvrtdxtlysgK1x3RTU2K
         BwbxzD+uJSae0vfPgkdfobXg2q0jq9pYNt162+v09F9/43n488Qm9TI8jnxRMcGsGb11
         DzhQ2AtOruaI3GMT46u4XWDWouTTUgYBwaQx766amMGtHpZZpP/olrqtuyOQm00oMQmd
         uBNiuusIgQh/8aA6embW5hKv0Pp5z+uxJblj5dqC5PNqChZPe3kj8jTfir5CuxQl0TQz
         skzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        fh=QjXnwo37JX1XWOryi5K0yfdda5dOOth/0cIv8F4eM3E=;
        b=V+PVw7w8j9k+QdgQAMI3mGqfmrS12ZYstiRJ9aamiK/bwX6Dgk/xwGTxapa9q+9MYw
         mHgDlVysIOzTI1VebSEzW5Mbtv0mf24uW1GSU706o56dp9A4df8CJjQ7xMUOVzaK/ung
         jQCvVflYOUTRvMUrvrHj24UJmUo1HgSMABM+Ew0Nc14oXO/KIOcv/C19m8hFSoXqnzr4
         swY6oP90dZ9qmsRX665j0En+SYrh3cMTHbviMBa3fcv+J6iJc6XEA/8elK9iA+B+dYzg
         JF3MT+ek/O/Dx/5hXmjrTiGFXl7tzFi+TdqIfouW5QGcqhv9cJFiWrDONomybZGrZMAr
         igjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787827325; x=1788432125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        b=hIoscuDSaxJg+VFZqS/l2b+JNhKXL/OVF25XVpKMArgBdrop4SZ1gypl9wcAteGzRd
         EkE+eJHjRA3lKbiKUGSIkP5+HO5KUO5UHNxvpcjtPhVS0X7+TdgXwSgNq/K5LWIaaZtc
         4furVILxpOCh1vcsz9g0yO2/39YsGdeD3A9xDLs/YJ8U158M3SFt5XdcNAtr8d8WWTHx
         kZ4hfZQmoKQAYejMKvr/F2SHyZ7U/vQuhqvx81YixCINznTD1thCjgxhybuA2yDQWMPo
         cdPOlYZ5CZbhKqK+EKKp4Znz460txVJc6tLaWT+JLoOYwy+vIJW3YoyV61qz3jl6UfNF
         EhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787827325; x=1788432125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        b=UrqHjFEnEm7aHjZD1cVwHITDQrWx3Ganu6/Tgqk1MPzIzA988SPlLZ1SD9swFcwymV
         q7Hsa6yuuQqEAAymWJfIBbh3of20K6Pj/qGmyVhSGBMO7Y+XmCGT3yXfjgNb+VLkzCsB
         FtvKHibBeu136OvWQoju5OzQtkvOCfhOXstQ+BKqIyib8H4yVZbP7WuaOL+slxgTOhIf
         2mJp3kHE7ss0J48e+bF+6xDphL0CFjP0FLGIklcpIvjGSev2SvOqLT1+/MlZ5cAYyM2m
         zJq3Ln4iPEF3Y8hE2qRG5RIqY0IR9PjDE15frkaSMl0qO1ueXiOq5D5eqdqkFtMsXXpG
         +V6w==
X-Forwarded-Encrypted: i=1; AHgh+Rqfn7oB7fPE82KbIZGl9Zb3+z/2dcuHWapoZcutXVJHE+KT3GrDBDe6TJLZN6VoWIS1khGRPuM=@vger.kernel.org
X-Gm-Message-State: AFuF++m6y9SWaNOHHnz+jEiNLiPWKCs8xS43qgHXMNCJTa6hpoJT0alr
	1XjSnGe33r64HcJlP93sSuAOOLRoutWYHoaFh16Qhcg7ej0TSZENVjG5N5dGClVUus38jCAUn4A
	paw9bQNYPRpXdlMDB/EQ3KnKLQfslUhU=
X-Gm-Gg: AR+sD10tARnx6YM9U2oQlRM1nRBpO9KQOas9Cv2BiT6YJdFdBMk9JcAouPpR0m3uFuM
	HekjJHOWemi7UXsk0k9+lo86MXq+2ktz04k5A/nxGZhbCINGNVylF/syISJio6Ta6cSXmWFLYue
	JjsdJKWRHP5BdTtC5ejevqpWafzhEVUVJj/tMezE29eX+4Zi3DGlKGBZG7qXM2KyBQNNRmrGf6m
	n8TBF5FT/pnKHtDAAlMVwrHTe+ntL76fEt2DTHfD3L7wXNFrwa+5XpQstUODNJl6xPyV5B6jrDs
	G9ZkZfrhc4hahS+zMZW+4hYfD1hiYbf+DsnNK5obfJ1I
X-Received: by 2002:a05:6808:15a0:b0:4a4:ed9a:e7ac with SMTP id
 5614622812f47-4b3669f06a4mr14189855b6e.1.1787827325398; Thu, 27 Aug 2026
 03:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827051859.45511-1-blbllhy@gmail.com>
In-Reply-To: <20260827051859.45511-1-blbllhy@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 27 Aug 2026 03:41:54 -0700
X-Gm-Features: AcwNN1UevfzNgu75Mwt-YYuX6NdsUL3CSX5zO7op3uaz_fQCeJoL4xqHlnCj_DI
Message-ID: <CAMB2axNFOC9G2RwOCnsWDth83REMWnmPE8gxMwbLYoGusw9miA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
To: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, wangfushuai@baidu.com, bestswngs@gmail.com, 
	mattbobrowski@google.com, kees@kernel.org, menglong8.dong@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:19=E2=80=AFPM Cen Zhang (Microsoft Security FORG=
E
Labs) <blbllhy@gmail.com> wrote:
>
> Iterating a sk_storage map is two stages:
> bpf_sk_storage_map_seq_find_next()
> returns a selem, then __bpf_sk_storage_map_seq_show() uses that selem.
> __bpf_sk_storage_map_seq_show() re-reads selem->local_storage via
> rcu_dereference() with no NULL check. A concurrent close() can run
> bpf_selem_unlink_nofail() in between and set that field to NULL, causing
> a NULL dereference of sk_storage->owner.
>
> Oops: general protection fault, probably for non-canonical
>    address 0xdffffc0000000011
>   net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
>   bpf_seq_read+0x366/0x1120
>   vfs_read+0x174/0xa50
>   ksys_read+0xfc/0x1d0
>
> Return if the re-read yields NULL.
>
> Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or lo=
cal storage")
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Cc: AutonomousCodeSecurity@microsoft.com
> Assisted-by: Copilot (Grok 4.6)
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---
>  net/core/bpf_sk_storage.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..7228520aa2b6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq,
>                 ctx.map =3D info->map;
>                 if (selem) {
>                         sk_storage =3D rcu_dereference(selem->local_stora=
ge);
> +                       if (!sk_storage)
> +                               return 0;

As pointed out by CI bot, should this be SEQ_SKIP?

On a seperate note, __cgroup_iter_seq_show() also seem to return the
wrong value.

>                         ctx.sk =3D sk_storage->owner;
>                         ctx.value =3D SDATA(selem)->data;
>                 }
> --
> 2.55.0
