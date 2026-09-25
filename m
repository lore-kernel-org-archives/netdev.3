Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA212B143
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297847; cv=pass; b=lHrmvdGwsTfOWrk13RNBSVsHtpQCVE8FbYGBUS2R1xKvE5xJEwASqWhK+BfrG8JTghplDzZ/vB/iJ4D4kcTyJlcXSBnExsxclcThnCIu3+SQIJsbNG3Z3xrQT+KY/zz0Eu4JBD7o2tD0CAUySujlIvgj8YQrr3odN1mJ9q8PcOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297847; c=relaxed/simple;
	bh=lBKA7hzH9pjhlzdMFfbHz9SVC1DDES4LjTgOQh6PfRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5br+982mOAapUld5F5OAe6Uld2C3jx7emOBKQtQlfczw0KDVyAFVvWtYDNdew1ycF5T3Wa5iYzcnzmJtq6Bb2FREsXXwOT70GViHMbspgfGiHniVCv525iDnbE2FJgw/zmWTnxpWSiSC8ri332UgSukMNWAXHIMosxwx7IUnW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl5pBI9m; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl5pBI9m"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so4742061cf.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790297841; cv=none;
        d=google.com; s=arc-20260327;
        b=dMEtaJ+mC8mqiVksVpuzjGQ/DF1tPMWiDGRtjJksLDShKySUfKU5ojT/vJElE5Cua/
         iVgNHTDVnQe0+sRzEmo6mCwc401JqvfDPvJgmBjCsEE3b36UJFMNVpHCPqsLjDhctPXl
         cLYlgb9F8E8FFcFXnVtM2icSivVopZz7KwyPhfUqqKkLW2TCnD7ANw5QDINGnL4/Giar
         ynZsTBB4m/RwRiH9pHYl20E9+hKdcDG/K0BgCRcTu/c9A4W0ffnwINqJSIEHbk8JRwlC
         nHMVDPO1z1Jj0yhiCUxhGBLiDR/7I79Ms/PVr0qMgfMSV1X+45HH8eZtlhj39yuOws8A
         rOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pyGHIFbtinRqwaj+Qg/alPqYKdXRt+R/3/nBOW/8Ig=;
        fh=6zfc34g9dSC0U+f8Tklj1Fl9FF2409hSLYzYwy9S3Cg=;
        b=cSfivFUwXK4luh8OhPQtBLG3kZoI5hFE4Jde2dtvw7QqFCHyc/CW/8NCGbzsN+Ie/P
         OXHY0kDRteqhROw6mwlDNYkUfa9O3JtS3L6XXkgYAtX5bDPa8h6GWAfrbskiLbOF9ZgP
         pc7J5XinFCYPpfa5T+G2zKqcYmLlODE3y/Fe2jWgN5bH0dQ/FUvvcqFmw/OOo82s4vUj
         X5pD+KMzO8YAFnifZWaLJqd3b5EgMl71Gpple+uaW8JFxKe58RJg6B0SCsy3iJPsxoge
         07UQs7Kl0ykoF1DEqrkZOABYtxPoWpIiD7a3X7EycHgdlxSdSaE0dnrGFmqsrjvlcDIx
         viGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790297841; x=1790902641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pyGHIFbtinRqwaj+Qg/alPqYKdXRt+R/3/nBOW/8Ig=;
        b=tl5pBI9myxJmXgJ3UpcupUmaHIvZ+JCD46NF0/GP/PkdSPuIx9h7SYiTJitKQtj6d/
         vB6vCUVUmj4E6RljHfN5x44zbL+y1Gyn9138uvrK0yW5Rs7rDcZIOtK10CXKh7wdwmvl
         GxGH5hLoPRk6PkecEj203vMAxFWIG5WV/RLoyVcDvPjRSEBl/Eiv2aCKrU0e+WBOWxlg
         c71kx4LsHyRPm+a3RE/RY3WHtXk5gRQPEyEEKH6mF+sQVGkesdZ0hm9R22wF+g7zcymp
         YQyyiS4m+BRyq09anP0UG2y0+1/eiYzxj/tDjOw8KgjR4/eISGMIJGxPv6BFtD3qUVaV
         Q65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790297841; x=1790902641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pyGHIFbtinRqwaj+Qg/alPqYKdXRt+R/3/nBOW/8Ig=;
        b=IhwUXVz4lVdlDZSCE3po+h64CwfUWXGLCFQXcB+kv3rMuvL4J6DcaNKd3/xIAGhJv1
         7PAJM/LUVeucXQEcntRLtvoAgqStkxQma1MCbwJOSLiTy6USuX5LojyjlVAtSg1r6a23
         xwUVf7dSJ+CP6kwJA1NyApmSbP7a/4cogZDqqxDC1E/wBCgCFtK8uRF69yBToZHANLqS
         ikIE1ll6Jyaeid0Gq5nz8YEuHO0+W0S+pvSZBOFknUeV2zvqx1RA2BM66mksqPb93UzT
         qWx6TokKxCmpkbLweY0Ysxmw38r2aarVKA6pw0kFDuVUUKivH3OydODm5dKAMWu2YtKG
         R12g==
X-Gm-Message-State: AFuF++n4nz+OlpxSOh0cz87eiJP7atqsdAL7xWTLa7d1wnLcPX+gtUAV
	RJortSQWB/oT8gZqMaThyfv7KvbqIf2mE/opWpwd604gl1CDqdluJPqCMSImqf2mhBHctSlIyhA
	phZTCaYtLHPHdQhcBUfueLymtMnd04BEin4OBBL9Z
X-Gm-Gg: AYBFou2glMBX+2BXopVbDB1nmmmOnWBtA+GtGslF653L9mecmFnKjwVyjng5ums+7XD
	kUeMJpvsawOlQq4+33YPRcjf1wPN0gOShs9hZvzaU6h6/PmgM1C1TP29yNKOsIWDRsx26v7syMj
	QHAQ2lNxkuaG7tNsVM7K68dn1rhit2/7fsj35A0S7fnKP3FAVxeKKBAWIgLxBXGwg2mJmN+m0+G
	H65j5DQiQIlkTqVEK5XVfm6oHHeX+q95B0RgCMbx4nsjj7UT16gNd3N8rXlB5YGlw4+u7MYUAD3
	IU9y6RV1tv58uHzi5i6EXggsTuMgq6B/gQKlB6Skb7h6fcibIW703JGB0+x59rddZEXCdphtUJa
	kUuRA2gnHPUzErjo+x3YzgShRsAEVwfimM0yIL3izPhpNQhrNmUpufP8WyTHuIB6t8GC9
X-Received: by 2002:a05:622a:e318:20b0:533:1038:ad5c with SMTP id
 d75a77b69052e-5331038af84mr2905601cf.40.1790297840359; Thu, 24 Sep 2026
 17:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924224456.55690-4-jeffjo@openai.com> <20260924224456.55690-5-jeffjo@openai.com>
In-Reply-To: <20260924224456.55690-5-jeffjo@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 02:57:09 +0200
X-Gm-Features: AclHuK9i6M-UlXku212en58JsCz_7tBwqq3_4M6DEUdxB18bU5VlwiunFiLOeFk
Message-ID: <CANn89iKF+MD9TDBGb7oXjR5Nk9HgwXF3kB6KV8_3Li=qLKZ5WA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: refresh TS.Recent for accepted old ACKs
To: Jeff Jo <jeffjo@openai.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:45=E2=80=AFAM Jeff Jo <jeffjo@openai.com> wrote:
>
> A TCP packet can carry new data while acknowledging traffic in the
> opposite direction. With overlapping traffic in both directions, a
> delayed packet's acknowledgment can be older than one Linux has already
> accepted, even when that packet fills a gap in the received data.
>
> Linux accepts the data, but tcp_ack() takes the old_ack path and skips
> updating TS.Recent, the timestamp saved for outgoing acknowledgments.
> The reply therefore echoes an older timestamp. If the sender uses this
> echo to measure round-trip time after a long idle period, its estimate
> includes the idle time and can reduce its sending rate.
>
> Update TS.Recent in old_ack using tcp_replace_ts_recent(), before SACK
> processing can trigger a transmission. This reuses the existing timestamp
> and sequence checks, including PAWS protection against old duplicate
> packets. ACK validation already rejects old ACKs in SYN_RECV before this
> path, so no additional state check is needed.
>
> Echoing the timestamp of the packet that fills the receive gap follows
> RFC 7323 section 4.3. In a socket reproduction with 300 seconds idle,
> controlled reordering and retransmission to exercise timestamp-based RTT
> sampling, the sender's smoothed round-trip time was 37.5 seconds without
> the fix and 15.5 ms with it.
>
> Fixes: 12fb3dd9dc3c ("tcp: call tcp_replace_ts_recent() from tcp_ack()")
> Assisted-by: LLM sparse
> Signed-off-by: Jeff Jo <jeffjo@openai.com>
> ---
>  net/ipv4/tcp_input.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92bc60716f33..99baf14afdfd 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4465,6 +4465,12 @@ static int tcp_ack(struct sock *sk, const struct s=
k_buff *skb, int flag)
>         return 1;
>
>  old_ack:
> +       /* An old ACK can carry new data. Update TS.Recent before SACK
> +        * processing can trigger a retransmission.
> +        */
> +       if (flag & FLAG_UPDATE_TS_RECENT)
> +               tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
> +

Reviewed-by: Eric Dumazet <edumazet@google.com>
