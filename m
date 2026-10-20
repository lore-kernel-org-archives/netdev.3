Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478126;
	b=3siv+noHVMM6WJNrHxogHI9vq5yu4QzGsVQXTnRfz0gkkp++Yb/D2xLR8Su8PVgKs/xs
	 3kxdKXn0gkSGAH9TedyqhkBH4BjKMiMYij1QUe8oQA6Er6wHugxc3JBCvPcvOHKoXR857
	 2OT3Q3se76C1zyDh6izXMOdzOhsCF0vHl8ZabhbL/pbCFUSK4BuzAbFrTWEsTWJ6qWV7c
	 ncoXPzbrSXIl1Upv3ckKAiRqCdbeYriPlvPCI//WzUDfHVQwdwKfbQ44qIRzjmrAhpUZk
	 OZ3Xk6UfvGeemwhzy8tR7LRWIersc4x+NQZmYVYr6r6P8w5VYYzkLCEgt8o2jdbaPDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OQoTQKp69zwalft8c0xKATXGQMtLqX55wVubm4cBdtk=;
	b=YmLGS1eufP3bclSmxTw1/6QqC6iM46nG3NOH3+hrN/e4q05pQhNV1TXXHjKGgi33E+cH
	 wOSi6GUcEO20GNSYwTcJmDrhoQp6us00nSWFMFxGT8u+LC0L0q8c59Umbw7+x9cHzOOvd
	 c96N8FdqhhYiPtkOX8pSbM3hcHhfIBeqI+0CHhtTeZ26HKTzTCVi9iJU1XGAwfTU0x5NW
	 1NHIHMSZLAriSz/V+BspJo0OX5yJva1emp4S9FudEs3XFmS65cUKAJWL+SIGurr75Or8a
	 5AtEkMYAQTOCY06eTDGj405xWwT9AZBxuW02eM0GJZMjFiOwRODvU9SueG5b+om9e+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZ74QMfw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB0606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DB0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZ74QMfw
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso2792545e87.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792478124; cv=none;
        d=google.com; s=arc-20260327;
        b=KVewS8ntKunnf5BJe1FEOuWPntm58canClA5NnZYiApDPow2Wnt96y4Q5pZvcKWyCI
         fFYeP1B3tHs7vj1SnyyvUyAm+XnCWEDslSyQhVqMRV0BcQUukWlkYLk+mmAolFvsKhNQ
         6gNBEAianxWDdTa1zoljVtP7wzftALhsyNUNTl4N72uskY8DaD3isomw08K/BaEc+xKz
         7QOZtETQx1XHs80dcBZaL4BKNzREMkuMjPs5Z8aG/fd2TgwnErb9lXwvKoA6hjgTWxvx
         fjrE56WZRjzx9Hm5R9FGXYTWl9rqMiDD2OgxywP358KMtJ16xHlWjdpJuUptNSCkF48J
         OFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQoTQKp69zwalft8c0xKATXGQMtLqX55wVubm4cBdtk=;
        fh=6stTtrFeHHBq5eu90RORS/eooQy6Kf25x0IgNCGhZ3k=;
        b=OZfnXm8UDi06bb/h5xnBxYgqnHh8gdezpwhTkn6ApXs+Ib9XADktxN6GaGfeT4o3hB
         om+QXUGDFDCLu0uqWJNUfHQEq3lSCRALfH32I01TFgMFF+XKgX12XZ1rXXafpctBlZG5
         SfPtyKA76dHvCK04d/adY5tPwVkpeTkclNsd3zZXW08FZ/1vqSz92vgOMZQ6362lThTr
         4+sULb/cpsGkGzTnwE01C1XI0d0ukvqPfBDv4Y6+65L/UrX5hkVAAaQWSb3PZkmZha3d
         /QOLUbYIAjiuQTQfZHGYj1pRZKd0QyMCIWSD7+3UGWlHZqseIsACVRJZw7n7+jiryJja
         f/3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478124; x=1793082924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQoTQKp69zwalft8c0xKATXGQMtLqX55wVubm4cBdtk=;
        b=JZ74QMfwflYx2KrfRKL8OB86rBTNIBBLbD5SeLzYwVnY8gnkr1s9daBAnTD3CO0m+S
         QUxp96nRchqvrU+TnMXPan2qGkVvlBeNZETERxhm5D9pvIYSNBNOcmGhgEzJad1ljQHX
         jilHJYy3udvhIwIzqDh6KELFoCDGXpLiF6/g2Qt19tPUHBArURe1TO04cfiX39/v5PC3
         gB9I61/aRSvenkimYYwEl+eyu7lBgrr6VRUBV7JFVIX/8UGASPGsy3ub4a0cSfareBOj
         HGs156cv5HWcQBmySBMPg/ZxNC/uOKeNheJr2yi8qhdDVQT7pZ1/x6Uot+nkz2y8ltxc
         PIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478124; x=1793082924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQoTQKp69zwalft8c0xKATXGQMtLqX55wVubm4cBdtk=;
        b=SdTDKrC0n+T3CjDlJYWpezndv0S5dJG5UzH8YECf+j0vAmxUhigY+n3f1Fgjtfb1P6
         BOs6l9GAbs4p7BE3eiWEXR/tfufOGKlF0sCLagvw4ANfUp0Xy9IjNX+Fvd5OBqLqyxj1
         Kdp69C/jA4vCIbOXXM0tNyBNAocbuZ1MPCTlUVVssgofdPgMtECdseDLnBb96YIpKNfE
         5FgNGq3YPZfLnQG0EohAwrDAe7iOskL10MQ082OK6ROVBro6hDuCcjhWotfSmWdzWauX
         FNymcNWSiupfrMKKXuUXNMzrv0JaLFRjMBQEDmA7CPOAOrwRX61p3l7Kd3FFv1sFKlNp
         3NHA==
X-Forwarded-Encrypted: i=1; AKwUvBx9KylaXk6xHyRINghfMVkf5ep+Fu5J4Md4+qZW8qCntBpeAvtxF+gVXCtUBNPH8Nx65wFg5H0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpFkqpHxPZn0wWZ6TF/O7x2NmTSnWZ5bMmGZLWQYnCmApJEwQv
	UiRaM93uhcXZ432UlmYV4BU1mMYOUpUOs8cg/HlY/pA4itJ/LwZcXHPBYKp9lmBJ6OcF3Sksdzb
	pfZFqW4PMtCLqP5o8MwrTWPceRfevx78=
X-Gm-Gg: AYBFou3C/2mhCyXb/ZxrQMj6gNICexqUOyj/0TOM6jmmxF1S49jioc+Zl/FXq7G2B2G
	jvXH8lvhCCp9VMFsoo8ZQGIlSFOs/D02lrMKIJD84+3S1BbzDOurcHyEdpa2AHFd76EsjJxSuA6
	MSrOCIptCDMise/GC3VS9roAVDadiZIhgAG63+zBmp5U9gj8MfUGrXc4DofMs4G2+VACHnc3Fy+
	e9gmYQVB07OMGjegk9j866PZ4hs4IWpw2JDI57FbItSjRFFbGETFlsiwGiGwCE4cqESbSyoHIYX
	6kRJbJr/XJRuOD4xtU7Hn9wNvtZtxMcbJQ/NWE0AVj1dvT/XgyZwOyptq5zNFuWtrS7VHE0c9Ld
	TeEGbw+Omoq/x1CZ4fUKHdmn7dV0x/UCmX4xJn+MFaxczXcQGmeX8E7JvhKV5kcjqU+OEAA==
X-Received: by 2002:a05:6512:3da4:b0:5bc:d9d6:6aa8 with SMTP id
 2adb3069b0e04-5be50a49e8fmr3342745e87.23.1792478123701; Mon, 19 Oct 2026
 23:35:23 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019230758.2960779-1-joshdon@google.com>
In-Reply-To: <20261019230758.2960779-1-joshdon@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Oct 2026 14:34:46 +0800
X-Gm-Features: AclHuK8Z6eedwZFjydm_QKED12xWeIvXORddk5spHPuvKLcq0T7ga9yYuVAKwaY
Message-ID: <CAL+tcoBjWDwA+MrjzRapUeAom-4siL-cnXXLQrVf-A4myNRxyg@mail.gmail.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for udp{,_v6}_send_skb()
To: Josh Don <joshdon@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 7:08=E2=80=AFAM Josh Don <joshdon@google.com> wrote=
:
>
> We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry programs
> to monitor UDP transmits. Both functions are static and have two
> callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
>
> After an FDO profile update, udp_v6_send_skb() is now inlined into
> udpv6_sendmsg(), while an out-of-line copy remains for
> udp_v6_push_pending_frames(). The fentry program still attaches
> successfully, but it is silently bypassed for all uncorked sends.
>
> To address this, make both functions noinline explicitly for tracing,
> as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> Add noinline_for_tracing annotation for tcp_drop_reason()").
>
> Assisted-by: LLM
> Signed-off-by: Josh Don <joshdon@google.com>

I actually mentioned this thing a few times before. The original
thread was from Breno who tried to apply a similar change for tcp
sendmsg. The fact is until now we don't guarantee those functions
should be kept noinline like how uAPI works just for BPF prog. What I
suggested was to select a series of functions in one Doc so that we
could tell people those functions should be noinline or whatever else
just for tracing in a soft way?

Otherwise people would argue there are more functions that should be
done in the same way because they internally trace it.

Willem, Kuniyuki, any thoughts?

Thanks,
Jason

> ---
>  net/ipv4/udp.c | 4 ++--
>  net/ipv6/udp.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b090bd1f59e86..487c8cc8ab206 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1110,8 +1110,8 @@ void udp_set_csum(bool nocheck, struct sk_buff *skb=
,
>  }
>  EXPORT_SYMBOL(udp_set_csum);
>
> -static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
> -                       struct inet_cork *cork)
> +noinline_for_tracing static int
> +udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4, struct inet_cork *=
cork)
>  {
>         struct sock *sk =3D skb->sk;
>         int offset, len, datalen;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad5769..fe92538835176 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1366,8 +1366,8 @@ static void udp6_hwcsum_outgoing(struct sock *sk, s=
truct sk_buff *skb,
>   *     Sending
>   */
>
> -static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
> -                          struct inet_cork *cork)
> +noinline_for_tracing static int
> +udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6, struct inet_cor=
k *cork)
>  {
>         struct sock *sk =3D skb->sk;
>         int offset, len, datalen;
> --
> 2.56.0.212.g129ede20d9-goog
>
>
