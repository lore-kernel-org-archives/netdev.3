Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8975F521201
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555777; cv=pass; b=H/6EDqBE1dRk9sAnZTFziM7qSPlyrNnwiTd41Q/M+lEzum4D/9FDzmWGsvk3swfc7w2X+elcirlctLOWtED1CHG8S86n0554Ron9lFvsSaJEgTJzYASReTY2bVM/rPhajoRbgVVAfn1uL/e+ZLHxZ9BDlC3UmArnqgla0xZt4/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555777; c=relaxed/simple;
	bh=4ZVr+prKPSIFRpCnkF0vfYGjCPol1vKUSTfk40A7uPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6ZU2H/06mNB5ZNL6KU+K4RpnfX/23ZjexnFfPQc6Ou4l0OVZEB8Lj2Ap3JdLbc6Kq2ggb/tJJSvEtUDcX4WRyn0mHUlkyZXwpre0hV+xMjpFzTfaSP9S0VQ/2rMRcYID6Ntn8rI9QI73mKI2bTtwS4eAJSEE9M7EHO203hbnGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=O2BGNrng; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="O2BGNrng"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-864cd11a932so27720397b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 14:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788555765; cv=none;
        d=google.com; s=arc-20260327;
        b=p1ZLViXUvjnseO/sD0JiQixoZq1H8IbsRBnUPzIEpDnWJOUdyAqUJfYXDgsZaTtf3E
         0zBct+yii32rfpt1TxGQOqi4mEl6OiNgD77NqttWAVrwpN8jx48vHbkuf8z/R0D09QgX
         NapUwm2kYIfFAcH3hZBH7vUDxmiR53FO9vK66W0lyCLUVkfOKCxDCV2Tt3cNJPnxkgrG
         avOSxsCidv6lYFCXUTt928KpUXfvZyu8BD3ToW/Y65COOMQ+pnhhYtPJO98ivs9Vw/Fy
         f0rF2s6QBlt+M7aTYOziTj7SEQF6SCTLT1MxeYnkiuYdzIy3f+73T7170QPQdLkZrLxG
         dBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        fh=Bw7vPwty+s/zHUhwMV2sro4EqDFGlCriRGUrB72TgEs=;
        b=CZR6rT4g8jY7yqkDrJsRBjkCtS5uJ4UKosxTo+7VxTJayV+2sUnO5cSttKkZnhTHgs
         Dvb/KL/DBNUMWbDPZ20RqtbWY/I8Oww0TbjJNlzqMOz8hGsXGiYrHf3z3sl9wnqz9qaT
         ccMff5OPPgdw7pWNBgmIbT3oe7ndFt2sfSQTevJsNGS0enmmkQwgWP5pgfGk0dgIFzim
         e1OtQA8Eg5FdH1gzKLU18CxmOrtWkGP21kmSQ4YvL9m3ojXI3lV9YaKz52ABkH46Ybyz
         DI6+aYZ3RGqVo4GBpX4QNjlM3yFv5BpNFyD60irxOZvwwUeEzZKsIz5AB+IcYHONkW4E
         8UlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788555765; x=1789160565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        b=O2BGNrngKtWXt2JGLl+dKG4/n5Zu4pzAywj869LCry9tqj7mj1P7BD+pAcFIvIGZCt
         8NrL4IlyGXA/40J7aN6+mVVfuqlnGG8IO9Wzwix/eHj2lX7uyvK26NVqNlum8c3ds04d
         BMC3PByFIQxbN94wq7ri7h/GZicuCkjLuhVkW+9xuFjpjoDBzZUKVatvat0BgQNz8+RC
         loUazT+E1ENbhptCRnG4Fs/eKlefwFg6+8cPGGiO5SPh3NKjcQw7GCXfdfZoWnWaALYB
         TzXng6P0d87LcGGwTD1jxzn95+viqpS0F45GPQKhmKWggDwAkMXPkIdgDZFGH1PT5cXz
         Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555765; x=1789160565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        b=hawVbw1NmvRs6gQ2tTOyboTCuLH4rI74nrIBiDw6Xiv5TsiJRc1z6lbA3Td8trMzni
         1hsDiPzUESgTa6hbPyKwBoX5ULRmTwSfTmdyubQhVEVnFKKOpRBU7OKpFJRFqsxMud+t
         HG1WDLyqzDXk75lMOyh3CnIIiKYLIFfm7WG9mkzZVA3G/VGp+/Va9Q65B1m94gfQvYxU
         7hVnaquSqdQEaJ9/Kdp48+2sY0JOeQu2s5rkBzPJF9wDg6EPRjwrVpPYq1vWSCkxfNfi
         lGqFStIGLHuub5bKduDkedlrR+Kyk5CZIFN6t57KGCe5VGHIKM7mTWUJ3nzayFdTrEAD
         LLIg==
X-Forwarded-Encrypted: i=1; AKwUvBy1KteX6NUTyNPh75uIBp8FuuZVUtMx2Q+us+HgUMAnj/tP2Y+YUlPys+kdr1ajSQ0stVQanBE=@vger.kernel.org
X-Gm-Message-State: AFuF++mvZyZWWMWlczxETFtDBI3UY2Rl/rHknKKyz7kA3BDBlQp8kdrb
	AnOLP98tzikQCEWzj3SUjKYTiWVNqlD2c2pmV+we+LuQjdNHDydvH91geIQFMOpwHSlclR6VWFG
	94hbXgw25BvGtlSJVAe3Ba6JNXFpJWT9uozNgL8XIMQ==
X-Gm-Gg: AYBFou2siRVm63ex81QAisSA18n5912LHQ6FtF434KZdQKuNcoKjnluldRwNpPqgwLJ
	JQkAZSKySTMUOsVYT1jds6qUIS0i7a3XtT/qhtRrW0UYewOHh0s2PmauidNyqGIGhmeuNm68LLY
	eQlajV+8h4lwe1jAz1egSl8LYJrQkqOY0n83IZ+bBh8wiyRxJKaP9ELlwGxPp6PVrWzNE7LZ3Vh
	gyfj/03h608lLcmh4zz8eMLpWXzrCV9VtoDRgpGLs33uAJCTSX2NUwkhAF7Sw9wYRs/LgTZk++x
	kyMvwHqoEP/MNeAglfMm9VaGFARYpy3RVZYvzhDbiNzQxt2cmt+uSjfkBlwDFucnuOpqivjNUw=
	=
X-Received: by 2002:a05:690c:7202:b0:873:5c7b:c13a with SMTP id
 00721157ae682-8735c9a76a5mr8052607b3.34.1788555764789; Fri, 04 Sep 2026
 14:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787897193.git.rakukuip@gmail.com> <35813d54d61b7b415adf002ef71087af6047da6e.1787897193.git.rakukuip@gmail.com>
In-Reply-To: <35813d54d61b7b415adf002ef71087af6047da6e.1787897193.git.rakukuip@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 4 Sep 2026 17:02:33 -0400
X-Gm-Features: AcwNN1WzRE-WMrnXOW-gBNYNIJ6qfMt4LVYPtBsLWXJkGpDjXbxeT2yzV5bc5j0
Message-ID: <CABFh=a5mOKjT1h4X7c6hgQDNepKMSLp_irqC7hsd7c0U4GYK-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf: Fix use-after-free in bpf_prog_test_run_sk_lookup()
To: Ren Wei <weir@nebusec.ai>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, lmb@cloudflare.com, vega@nebusec.ai, 
	rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 11:36=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> In bpf_prog_test_run_sk_lookup(), bpf_test_timer_leave() is called
> immediately after the repeat loop finishes, which drops RCU read-side
> protection via rcu_read_unlock(). However, the subsequent code dereferenc=
es
> ctx.selected_sk (checking sk_reuseport and generating cookie via
> sock_gen_cookie()) outside the RCU read-side critical section.
>
> bpf_sk_lookup_assign() explicitly allows selecting non-refcounted sockets
> whose lifecycles rely on RCU grace periods. If the selected socket is
> concurrently destroyed and reclaimed by RCU callbacks after the timer loo=
p
> leaves, accessing ctx.selected_sk results in a use-after-free (UAF).
>
> Fix this by deferring the bpf_test_timer_leave() call until after
> ctx.selected_sk has been accessed and processed. This ensures that
> ctx.selected_sk remains protected by the RCU read lock held during the fi=
nal
> iteration, while preserving the cooperative scheduling and grace period
> progress (via cond_resched()) within bpf_test_timer_continue().
>
> Fixes: 7c32e8f8bc33 ("bpf: Add PROG_TEST_RUN support for sk_lookup progra=
ms")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  net/bpf/test_run.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 5d51f6cb7d15..e677ec3390e3 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1650,21 +1650,21 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *=
prog, const union bpf_attr *kat
>                 ctx.selected_sk =3D NULL;
>                 retval =3D BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_p=
rog_run);
>         } while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration))=
;
> +
> +       if (ret >=3D 0) {
> +               user_ctx->cookie =3D 0;
> +               if (ctx.selected_sk) {
> +                       if (ctx.selected_sk->sk_reuseport && !ctx.no_reus=
eport)
> +                               ret =3D -EOPNOTSUPP;
> +                       else
> +                               user_ctx->cookie =3D sock_gen_cookie(ctx.=
selected_sk);
> +               }
> +       }
>         bpf_test_timer_leave(&t);
>
>         if (ret < 0)
>                 goto out;
>
> -       user_ctx->cookie =3D 0;
> -       if (ctx.selected_sk) {
> -               if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
> -                       ret =3D -EOPNOTSUPP;
> -                       goto out;
> -               }
> -
> -               user_ctx->cookie =3D sock_gen_cookie(ctx.selected_sk);
> -       }
> -
>         ret =3D bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, d=
uration);
>         if (!ret)
>                 ret =3D bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*us=
er_ctx));
> --
> 2.43.0
