Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382451;
	b=pO6lkIg3WXD54icyde3xmMK94K2Ox1yfb/Y+NyE1cRe3/HG+uOp/bJZnl1HBO+GRXTY/
	 IIBhWaIXFME8BR9Ypl7JNKO48wgQBHJ9KCxN2ZeBplpHDYPlNAlkgzw7fXxielkKWn81t
	 XO56fp2x7VKtV7sXJfrdh2kyuLwsglg3o1KzZmP/mQUiohnXRlDs/iU0VjYfHDsagYbsY
	 OAl9ybLHW83ilxMqGtl55kOqXByRYaSgS6B07kwZihBMohckGJPpht1YerfMtu4zgaoVO
	 0AZeL24ueWQWerHBKQ7ahFmy+6pbE+V1Wl4dUbnxu88ka+mr8TJI/9yKKSW4rZ7hn9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
	b=0zBc6lZYa06d8wi+Ll4sfAN7IVeg+QFU54GVYyyn9Zk/qIEfP822zxkLvHfv8Sn3r3G9
	 n9gcH0W1EaqtEw4CRaD5h39gZcw7Xf8mmAgnZVFsdzAmEL9F7AX1Hv7Ou917ba3ETf7uO
	 Npju0lSj34yw2CylqtkMCX8iHtTbXUFaxoOUNaZXptTj8EDqzfAiZnQd2G01XW8tNSikQ
	 ShUP8LRIgDnXaMKpSGa+BswV6QSPYuGA/fIk6ttB3+bt5OMf70klOJgMz/7N0a4EiM842
	 CcC4HPR5bGNit+VIwV801n6KYOXVVGFj6U9XtX/xBKIMagDF12aA4btoYYTmXAkiU5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiJOZf2q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFB606A330
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81FFB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XiJOZf2q
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso451267b3a.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793382450; cv=none;
        d=google.com; s=arc-20260327;
        b=SciSOY/X4bmbWZ1+clswNh1JhLfq/YMXUC5uCq7KR4lIYr4VFRlhtPRmTG8+V4/TmR
         k+b4LLlBKAJf8Nu1s/amfGAtKAqTCIYCgza4nIXGDLpYqnuSd+QjqLAa1BIdwYMpZ3eh
         Z7jTNSGG6HuWHbjq7+iuedvFZzO6MykkYL7MTQ0kF/7oLvUs1uV847grMWvu5sD4dEGb
         mEhFynRrduBk6caLxIWqPvC6aNvmpLx1psz3XVMVJK+t+caFy4Sm/KimPcxwmUrE8ASS
         QbGc+qAlwfg4lzBJMCmhF2Osrnf9NqBwUoB10XWxzsWtkogAzsef4CBUqw93yIwNvlN0
         5tHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        fh=mTfXs1T1Hk0L0B32quGnPz4/Ji6CKgumjjhqroAFSlw=;
        b=Xh4lSM+Ses3I308Hj1X5LQ2RxZQjLzYCJXl2+A1j2dBIGpraqxGIFnZSGgQdMG6PKK
         0PlfXhnm4OyuO5HAArIAD87eZFttNGRYWb3f33KYiLwYQGSTu8XygfXve9XgCcpTRvr5
         azfAtl3Lvf2OgWf9SFMYvETpKtqVDcuhERd4ol1q76sXZth9xZGvrfsYR11l/k2TCPT+
         hYKy4CMk9NJojJARRT77FRJL8fScs23hUlI0O1dtl/EngPe8vb2nI2RRIiFcyUZQjnJz
         M4+LOxi9JAIzoQWkBJC59LcFPp8LyMpcXh9zmZZ/DzQYtbOWGIjYdWY2Z+markFfiU+2
         c3nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382450; x=1793987250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        b=XiJOZf2qGnVvMOKzdKKgRpWoyWi7lo7RmWu0V8WqgQ1k3lzoL0/Dv5fQACqCRG6kM1
         PDsgKhCrs4wpWVvAYSFUP4vK7JaU/AJH9EGqZzKU82dbSRjoTp4O90spiuLfMo+YIHHM
         HaSLbVBL77GBIbulXUBDdFNIUrME8XK6DSOB1WKKJD3EZtLWKCPWxXTl7lZ+/+6tyYv5
         lVX69+D53vs8zH6azIL0M12NDNgxtlMKZXOtIaFgeKUewfILzXlkRBiV9y65ySTvgRak
         QVcOFQipiM98Snkj9OKCPpgX0q7tQgblxQkMG73TN6DbZaMN/diAXX0h4MtTjo7hF/xT
         DP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382450; x=1793987250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIhxZYiznvT7xWI+IfdwWWUWBk2bBwQUSMlQVrH0t28=;
        b=YfmzENfyL+4JbcbsgMRyHJ+FAMLXKYUacF/DWlB5NbOLVCqx5+hdXw37Tu2Jjx99iy
         qFZYdIpN7lY/ROoW9A/EDpNaP7NBDv3tNqzOBK1Tc4+4dVKni4giw/KpOZhmaC448IUE
         VlOh2xgT99hAMckdRIFxl+fG8oSknnsgDpc4tY5HnJ1eulU5HgV7Kbp+yZ+2WcZIRAoP
         U6kFqpuFYmzMQsXe4TGd5Zdclv+jLbBgY28X6CKb5ok3qvLAnxX5vAoGF5zXn553eS7F
         5sidLQn0uVc8yjG9e4usYbFgXrwLj0J9iCFEFsK7pAY6gneTsQ+wQsX4yx+e3f+tAILq
         VhHA==
X-Forwarded-Encrypted: i=1; AKwUvBzmWmZ4lK3kSgfoszcLkSc/+vz/sAijcc/8xPz45M6OgYhG1TSwx0evYs6vV9w/WvMbEordq30=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKzSrEf3ST3exg5V7Q557zeiZ7sQulLbn7knZ9Pe9FgCz+xao6
	qmGinBZ413+MEsrOLv4ouI4oBq79pDBeegbCeDpnIVt7C/ZhJELDE7FMizqAXNqiDlArAcGn/kA
	Days9xL8hapCleciyT2l+yP1IBfvUQ/0=
X-Gm-Gg: AYBFou0Dq2XwYM4YWBhz/53WcRLyOdDyrYIeXsmdh7NiQmh4EhT7KbPjaA/mB++kH0W
	+LOCiJYyQl8OUcmUfdzrSm37FCyDIZMnrzqLIHiX7PZfPs9XNnMhjXR8l+tNwa+jW1tdxOyIVIB
	7qyfa6sG1wjb5JJNRhBsjSVGk+XdiT/t7pSySkZ008y2DngQdickN91n5qsrGckayMGW06ZhlJr
	NlKTfdHjMn+khs3yLfLiCjwyPUIec9Et8+quu91Xa53OurL3yFnmqp9t2hjNYZEEtEiskM4d7JK
	pIXpFHi4Bsm/WXSeHBbafsS2BPlOWEC2tHh7mXU5B+CdNACoAgKnpzQHvQXCCpozjCrMdo3H/uq
	1iYmgkvGA+/fMT+rqVbvUXuyn9bgAaaYbU9JVGe96qsPr1Jq9MLWUDvK6j+Dr5rAV/B8CZTdrRu
	EyygJt+b98+antafMzosq9AimQqyCWQV6cgZdB
X-Received: by 2002:a05:6a21:3b45:b0:3e2:325f:576b with SMTP id
 adf61e73a8af0-3e928a71e94mr2185777637.65.1793382449721; Fri, 30 Oct 2026
 10:47:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082405.1297-1-shengshilingmu97@gmail.com>
In-Reply-To: <20261027082405.1297-1-shengshilingmu97@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 30 Oct 2026 13:47:18 -0400
X-Gm-Features: AclHuK_iwRZMverILPQ6aqdRr0bJylTP3g7Evr_UNs3S8h82CvZ8DH_nxsbSAhw
Message-ID: <CADvbK_eGiwO13sCNqpqHeiTLkQgTU_6Dt+Q+EVZ-CQ6WvRB9mg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
To: Masafumi Suzuki <shengshilingmu97@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:32=E2=80=AFAM Masafumi Suzuki
<shengshilingmu97@gmail.com> wrote:
>
> sctp_init_cause() accepts a chunk when skb_tailroom() can hold the
> cause header and the payload. sctp_addto_chunk() then writes 0-3
> bytes of padding before that header so the chunk stays 4-byte
> aligned. The check does not include the padding, and the following
> skb_put() calls skb_over_panic() from softirq.
>
> Count the padding sctp_addto_chunk() is about to write. The cause
> length on the wire stays the header plus the payload.
>
> Fixes: 8914f4bace3f ("sctp: add sctp_make_op_error_limited and reuse inne=
r functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masafumi Suzuki <shengshilingmu97@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 84a4c97d0f75..8933caadcdb6 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -133,20 +133,27 @@ static const struct sctp_paramhdr prsctp_param =3D =
{
>   * cause codes will be embedded inside an abort chunk.
>   */
>  int sctp_init_cause(struct sctp_chunk *chunk, __be16 cause_code,
>                     size_t paylen)
>  {
>         struct sctp_errhdr err;
> +       int chunklen, padlen;
>         __u16 len;
>
>         /* Cause code constants are now defined in network order.  */
>         err.cause =3D cause_code;
>         len =3D sizeof(err) + paylen;
>         err.length =3D htons(len);
>
> -       if (skb_tailroom(chunk->skb) < len)
> +       /* sctp_addto_chunk() pads the chunk up to a 4-byte boundary befo=
re
> +        * appending the cause, so account for that padding here as well.
> +        */
> +       chunklen =3D ntohs(chunk->chunk_hdr->length);
> +       padlen =3D SCTP_PAD4(chunklen) - chunklen;
> +
> +       if (skb_tailroom(chunk->skb) < padlen + len)
>                 return -ENOSPC;
>
>         chunk->subh.err_hdr =3D sctp_addto_chunk(chunk, sizeof(err), &err=
);
>
>         return 0;
>  }
> --
> 2.47.0

Acked-by: Xin Long <lucien.xin@gmail.com>
