Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5B456DE8
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250507; cv=pass; b=C6nClxDjruax58AQr9zV8Fbn0/XmvqkL0ZWdUCVwki59XwNAkn/foC1bxQL9puWBqy/rJZeDf7mJiWHR3ew4UhVMnEZYC1al7wj2awo0/WDr4wJR09gxw7/Q+ScqcoeNvDtsPjSgl3kQHhWj7s5HPJRwJyVtRRNqtnD3DUFHpLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250507; c=relaxed/simple;
	bh=p4ZS2QnTFpdtxEy/xf7l2zuepNnHiLZl9CMn7GOvXPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a92cqy7421Wjo/JWUCOu5Vk5He78okabOAJBrhZ8wICnwmbSSDgVlGm1zZvdQBaRe9QbazZZbv7GhNiWHSW6SKnXG/+yCwq36+dDRivmYIJc6xyUQMQkdqUJIPCqoxhjW4cYj/YBVXZMHOxL8D9rfBQ+bSpJgfDQChwAGlg3I+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSRnyLjZ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSRnyLjZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1053306b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250505; cv=none;
        d=google.com; s=arc-20260327;
        b=Cw06EBw4F4t3zCFNOh3KMHpvs8X38Dwrc0HWyOokAb+A7VwcFoINvb/ItDA5+XkgGh
         AJRV9AWS5jtQzdC03sFqrjMd4XAYw0Q398rdRjQCt/qnquHP1betT7Su8WtwvWSS1jDG
         72xFz9aGjQVHRPLBRsCOkyJIhPJqM1XrabZqTrbEo+lE2nUrf8nRYvLIGbixuVjH3wkv
         bUJTY0EJSUC2Ias4wnvYNbG0iWl+pmGy/1nzALqKOurluKqQf+KopPfFAlzOjxV6/D3y
         zgVN5casRtGdKUs51Y3JVNb0Bw4ltRWFz4Wzu9kIka52c0cDD6goG3RcN9g4A+5M6UuL
         VJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        fh=SF1YoGz+AHyC12fqPSyIPt0EznDmYItANgf+cXlOVAQ=;
        b=cTlD9EJxgnXFs6og2szvfxrwEipEyKB6BMqnJ5lELSCbXmIUCepilXcOXey2WTNN/b
         PaXGlLos++3dhpXKL53AuQ7l732nMGop0AaYu2zjmFGtiJ13L7Eb1zrmfRJ+CJVncJy6
         lRwPA9dRuL9fWQXRoLuvHXzQpQe2pgQq0frRtlMSHBEdaGT/kUf5vk4E0hcnDkCq74+G
         t9+YPJN636mjcUiX8LtJl2amYbdtOv3/JHPbTPvQp07k7lFsH1UoSy5ME64DWE8AOJOK
         0mhcl2xd/y3gpZgHP65VrhDHyGfCOowvOXJSekwl2WY84ZsQUd2p6fsnYwfaX6lf+OWD
         768w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785250505; x=1785855305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        b=TSRnyLjZ+xYBoBMy+KO6VVj7+iu27i3jsCc2jsDijMSzbv4440IgWHIYQj1rpFkSMP
         pNXxYrUsg8n+6eKjg72pqcJcLs6NMyebu9PlaRH8VOw4h5E/DhehUFrkYwscysSwwOeV
         l+JsjoTjGc0oLHsiExjKxqi5vCwKhFwb8zDh+y/r5Uy0wuFdHUBvGdRROeFXqCuLixP6
         Xt9JjRsnq4gkIddnSD/GI/CVcdul0LsAXcgl+WNic4hMME5nIdxS41rpdk/N9tyH5J04
         kzn1E4IIqrxQO5WYKpRSMmcUKcyzY9qudDAS+rm4LerICHNxjSCB35FtF4Hm1di2Usft
         uXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250505; x=1785855305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnZiRzYZKi9FGvHEmv0/yAIIifQ5Iqwvf7aqNKU+WYI=;
        b=ffj8p6LVWRI+aOtwKbzRPPl1qWSgzZVure7aKJKNzflHZJ6Xd2I30uuPHOqheFo01z
         KuwZUzd10QAUkwCOiYmwhzFB/TAS9GVKkip1hR6DhZpyCd3eALoHHZwrU/k4c0/zYadD
         ibmy9/Zs1Pu+0s34woPAGvG4du/VA8LQzAR3R2OToS42WLcNOf3a2NuklO/NjaP5SIrN
         qLNeY6TTVzrtJ6ZCYh3SOI5wfJ9ZrW00O5ygaR9TTdKpfnH8xvRKck+2PNQ2FLMidk37
         fr8MQt63a4lwFZiAsqmLyF0o7y2ur0kRlgqhtpKhFzt2fQr4vCzZ5St27gMws3un5K9V
         24Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3HSVWdJwfN3iEr2T4WCLISIldgomFI2SxhAeyYimb+j75I41KyMDTyxyH4pAi+ExEJI/9OvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZyrmO8LUYAZN2dw2tU4p+m73KXfGm2zEGP5wDBdUaMqn17Kk
	Fr6JHVSkwOW8vgt5616GXGwFAR7X4TOY7jJ1MjaBh1eaeHYfUyP80vyx5hHoGX5iQti81+Ojnr3
	LrcHTGKy14l4G5CMejVTy+OZWkbp1iUw=
X-Gm-Gg: AR+sD11uOVRkVZeLglBWYuk0ioKdyaYE9bNzligGGbXVt7Gwy+hVNjdVPpS8YVG9N9V
	VSzwPT4iIq6FtP/9y5ZB3evfwwY3490Ar4KsGES/CmC3xofDnwlG5Gd2S7hTHWXKCuIyf0GOLcr
	Yw1Dd6J2LlXAlltYLSnK+3RVq+OOgspz4O7Z5BLVBDsPZW1O8NJAU7Cn4QfpLbrwNbOBJyZDJid
	GRXd4KRpAMjQT/hDckFBWICCZroL3gztP41sXqqca7HFrNNU/yf+9SOlnRoWYioK6zxFhmL+B/C
	tFaO3HVIaLYNkit89cjgQqfYr4gTtbSScAVq/sTP29TUB6gHachayIdWcjSf64oVFtrxJGKXesw
	pgkhF1WR2KpLweBcAIw==
X-Received: by 2002:a05:6a00:27a5:b0:848:2f58:e1e9 with SMTP id
 d2e1a72fcca58-84e9329c546mr2926596b3a.36.1785250504812; Tue, 28 Jul 2026
 07:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-sctp-adaptation-length-v1-1-0ab58b2810a5@gmail.com>
In-Reply-To: <20260727-sctp-adaptation-length-v1-1-0ab58b2810a5@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 28 Jul 2026 10:54:51 -0400
X-Gm-Features: AUfX_mw0BwbrM7UVJQNAz32ePThYFDRt2stVo7wKa45Plugisja7X07u24HlGCs
Message-ID: <CADvbK_esmVbc9hf5ihxkXOGrh=b7=wN2dVKzbnbp2KNH6CGC0w@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate Adaptation Indication parameter length
To: trilobyte777@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:18=E2=80=AFPM Charles Vosburgh via B4 Relay
<devnull+trilobyte777.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <trilobyte777@gmail.com>
>
> The Adaptation Layer Indication parameter contains a fixed 32-bit
> Adaptation Code Point after its parameter header. However,
> sctp_verify_param() accepts a header-only parameter because the generic
> parameter walker only requires the header to be present.
>
> sctp_process_param() then reads adaptation_ind beyond the declared
> parameter. When the malformed parameter is last in an INIT, the read
> starts at the receive skb tail, and the value is copied into the state
> cookie returned in the INIT ACK. This may disclose four receive-buffer
> tail bytes.
>
> Require the declared parameter length to match the fixed structure size
> and abort the association through the existing invalid parameter length
> path otherwise.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Charles Vosburgh <trilobyte777@gmail.com>
> ---
> Runtime-tested against net.git base 53658c6f3682.
>
> The patch passes checkpatch, builds net/sctp/sm_make_chunk.o, completes
> a full x86-64 bzImage build, and rejects the malformed header-only
> Adaptation Indication while preserving the baseline and valid
> eight-byte controls.
> ---
>  net/sctp/sm_make_chunk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index c02809264075..1f7a097802b4 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2168,7 +2168,13 @@ static enum sctp_ierror sctp_verify_param(struct n=
et *net,
>         case SCTP_PARAM_HEARTBEAT_INFO:
>         case SCTP_PARAM_UNRECOGNIZED_PARAMETERS:
>         case SCTP_PARAM_ECN_CAPABLE:
> +               break;
>         case SCTP_PARAM_ADAPTATION_LAYER_IND:
> +               if (ntohs(param.p->length) !=3D sizeof(*param.aind)) {
> +                       sctp_process_inv_paramlength(asoc, param.p,
> +                                                    chunk, err_chunk);
> +                       retval =3D SCTP_IERROR_ABORT;
> +               }
>                 break;
>
>         case SCTP_PARAM_SUPPORTED_EXT:
>
> ---
> base-commit: 53658c6f3682967a5e76ed4bc7462c4bdcddaec3
> change-id: 20260727-sctp-adaptation-length-aa16536552d0
>
> Best regards,
> --
> Charles Vosburgh <trilobyte777@gmail.com>
>
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note: case SCTP_PARAM_COOKIE_PRESERVATIVE may have the same problem,
it will be nice if you can confirm it and fix it in another patch.

Thanks.
