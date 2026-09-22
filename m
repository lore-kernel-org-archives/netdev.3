Received: from mail-oi2-f23.google.com (mail-oi2-f23.google.com [74.125.231.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56D418342
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.215
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109204; cv=pass; b=P4G6D2zH21kMIOmAKrj3SLDKi3iTusq97fvS0tZRDx8DHkgGfO2+xM9Jj89ny8tcnszqF/DBlwgvJjGul0DDl/r9NsZvrnLbH62eado41fI5DoJB31qinpds3JB7iDjtkUSi1Z4sD4HddgaPiEHILLn8ia3ucF4JV8yd3Iq1fWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109204; c=relaxed/simple;
	bh=YVrKX0LV+9XXawTshmyoqahUAGMDRjhHBTCg4U2uBHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n11uSML1yUVjpFTL4y1ByWbW1GiAsOXF8lVfo8jG5tjjoRTbqliRxUEprWrAyfcN2w3wkCttClVqJEcSZRVToatP9p+2Sq5cFkglY/cCc3sgFJakI59gDfGhIFlCIDOyS42pVjcYC8pOo1mPYTr4WyNIIYwjj5+/b3ghoPQ/nRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuXtR6Sg; arc=pass smtp.client-ip=74.125.231.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuXtR6Sg"
Received: by mail-oi2-f23.google.com with SMTP id 46e09a7af769-7f4f0d37dccso195514a34.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109191; cv=none;
        d=google.com; s=arc-20260327;
        b=dFjcS1YDbVA4UK1YMFvbzggq8/p1rVnStZyhoaBCAESuFX5NQl5wzK5G8pqMnm1A9w
         0enJ6EkNTgEt5S0ptJA+yia3D10Jhk5tsYokFBPiKF8Eh76C73rkHmEJaRH0lJ9072qD
         dodza30RCgE+eLSTKxPytBNl+xmO+LYNTMtKAPUH6pVePBOFzTCvP8V3CzfbP2IrqqUl
         /+V3gyOvd/7Tsc6PVIzDb6tlWpr3rRJKYRl5NtuNSFhbyqod3kl/iT4+Er13g7jnMUkN
         vE8KK1v2oB0KNwLEemS/TfsXWbuWOqbZ2Kwbq6iRxPbjWeYe5Bk01RaFCZjRFvSTPP+r
         FQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        fh=VVlwAK4shnRlLsNXB1xGTNSb7qParIkiZFP8Aowqa7w=;
        b=LGaPSXkXGJoV94ZoLXS8LBlPczdDtJtLs48h0xqK7FYGFRMLRk4nYLcAEdrxk9jem9
         xtKXC5OrJpbUtNv7s/mUZ8wkfeffrh6DbeyE6aqnFnJ0aS4mr/U82ZvJeZcqTgU/8jWs
         D62B4xzkQBZplnCKOoxnHTsdPGPWJ5yV9g4oi9N0pAGaSdEXXXQYfbWepzXuhP0a5USO
         9lvU/rGEr3+gnVhmT9yIFgPOa/rdGAS48TR3F3XKMA2ylOD0tsN/9Ap7gJppGnWR8vye
         sOaXwcU1eUArycNIEwRgpI5Zs1YqFISI+HJ5fhFv6t5mDTXHeW23AtYoGQTOYOYCt7+I
         5/Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109191; x=1790713991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        b=WuXtR6Sgw6UVB2U1/iwbEBd/wKvxBh8DkVhl/RgCU8+wLUxa15cxwJ+sr8rfc6Yflp
         sjTvD/nz+rjjKC6uNB4IjRIBhGtjSN6uLx59wGz3kfsvZ1BK9XigObr3pSyI932zNOM9
         MBc6iM5kRtfI1cV8WsJ0aNGPFjEDl27KmjRd4+6bRdINBZswfRWhnajQQr/1WEJtUCMS
         ZNnbPE5MUekjSQ+DtuuSRyQuLnq8Hc1sfhPn9U2W6+WV3TGCpBeX9Jk9QYrd1wINXY6Y
         yoGlI7shm/6/CRPiJzYCTAP2DelDf5ShoS1MPeuJehzxel5WxMwjRYUXfHY99V1xIjRB
         HXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109191; x=1790713991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H07YChWgthu6uT5lPpAm/6rWFjM+GWRx5WUSHRQ6MZY=;
        b=B/eXtrA6aVhbYb8hylyRtEPhFYKX/Hp4Q5rGENG+YHiV6sqSm5/JH9BnsKxFs5sHR9
         d690MhmyeT88IPETLOgHsea0UsOk74/41yF7O6G9Dvaf7jkFiaIhC/bjmby6W96bFqNN
         C5PySbhW2hMzqNi1XbDIMQVosMrAa1aGMj3YxWmb6n5/0r1cvA8iTXshjF8iYKNp3sbH
         iYmLtbeo8/jfea2gkQhgdaFYgi8RfH/BufssnRvhL2ZFGjbSr1J1AOJ6C4rP8e0QJEqA
         997uq+jjIeobLfcTdjvAIXS14uISEiQP330+REzEORtm4//lBO4zLtauHZ4mlw7Q7mT0
         n2wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfzazly/lqBriQFR/k4sBil0BQSaMuHeU08ifrlRfWWtRRZh3/tOMR8ORSrlE/CMNFrODDxB0=@vger.kernel.org
X-Gm-Message-State: AFuF++l9MHJDXO1mMHDq0gxhIFvEFbsBcmYX3Zo0HI70EXTZl+D+/QzX
	KjQB89Aje/mRjo8blxcBhID3C9Ta1jBnEjISRPrN/4i1PP42oPbnsVFqEXKZfFP8db8SRSGLv6O
	iY4lEeVM55hM0gYAPqEim/9yd9wWarnc=
X-Gm-Gg: AYBFou2Hpjspap0lQmLbe4y9al++0Ho8B9+23vbidN0RtuMNb0J1SrCRYTl5luSRzae
	7rO5XjiY9geaF3yCSZKTVgRODKRRiww3l8PxQYgDUknQ1Na2XfI7XNHPEeXewZOvvdTjBc4UqLf
	riyHc82OCudbQgjw/UrCegs1TytDXsYqugPjigqHvnVQEN6v6vgIH4ZURpoMERltptxSgQN1aj1
	2eMEL6y7JD8vt+23uqA8nOdjryTWw2f5RdhPEHvrQBeRL3eGJ6nfvnJ69mQZ+BfSGygMetVvmbM
	OtkRmVoQaFgc0mLhJXI0yUCmDWq5gQeUah479A2gUn6g7KmfrKD1V1fJEfLjPluiB1PdD7AX
X-Received: by 2002:a05:6820:290d:b0:6be:4eb3:e1c7 with SMTP id
 006d021491bc7-6d2cff43713mr471043eaf.14.1790109190880; Tue, 22 Sep 2026
 13:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-6-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-6-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:32:56 -0700
X-Gm-Features: AcwNN1VGJY6GqpU7_5pCNeCM2-B96aVCqu0qSFJBh6gFAmJnhMxteN-NYUreQhc
Message-ID: <CAMB2axOmSEshN1jT0MRDLTvnVu6YvbsUw5MhOrB3-mvUNbhmwg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The verifier tracks changes in how PTR_TO_PACKET registers'
> bounds are modified across subprog boundaries. PTR_TO_PACKET
> registers are actually passed as PTR_TO_MEM, which is assumed
> valid for the entire call. This is not the case with packet memory,
> where a pskb_* call may invalidate its memory region.
>
> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
> because we would also need to somehow pass the PTR_TO_PACKET_META
> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> subprog is guaranteed not to mutate the packet.
>
> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74c..71ad07a9d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10421,6 +10421,16 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>                         if (check_mem_reg(env, reg, argno, arg->mem_size,=
 BPF_READ | BPF_WRITE, NULL,
>                                           NULL))
>                                 return -EINVAL;
> +                       /*
> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, preven=
ting
> +                        * us from adjusting bounds tracking info.
> +                        */
> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr=
_slice_pkt(reg)) &&
> +                           sub->changes_pkt_data) {
> +                               bpf_log(log, "%s is a packet pointer, but=
 func#%d may change packet data\n",

This might seem vague to users. How about something like:

  bpf_log(log,
        "cannot pass packet pointer %s to %s(). The function may
invalidate packet memory\n",
        reg_arg_name(env, argno), bpf_subprog_name(env, subprog));

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> +                                               reg_arg_name(env, argno),=
 subprog);
> +                               return -EINVAL;
> +                       }
>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
>                             (type_may_be_null(reg->type) || bpf_register_=
is_null(reg))) {
>                                 bpf_log(log, "%s is expected to be non-NU=
LL\n",
> --
> 2.54.0
>
>
