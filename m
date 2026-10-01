Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91E3B0AE1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880795; cv=pass; b=moVmzXsvRwtNfjac8nJZIlco0OhZAQbAt9TiscsiATNF55WZtf/c0g0Ge2Pfsw3lBreYZPjVVRWgVAZiYUUjuhdNhUnY57/xiizWSYHA3uQRl7wFGSNvm7WQy3CfeKoevbXhhm4zWF+/+Nm9zyw3ejYyFtzFD0FZGaAveGIX+0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880795; c=relaxed/simple;
	bh=Y+2Ni7PMqrXeJ+Ib9G+7B54AUw9Jq7EWt/AyyHD6kBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7yGZro2pJUyfc+EIVGuH2jxaRL+zyQ+WHHjopuksRH9UQK1UcKA7Uhu0gc2HsIGo24Y3ihTV2PvTjU1jtS3ZKhKihAsJ62rFEhGnPCwWruBaTc8/mo7/brEvwl46N+VY1rmP3IAs3RWq0QwRRRXo4pl7ZT/tTz3Ruom1ifNej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaHrE+hC; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaHrE+hC"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso3470931b3a.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790880794; cv=none;
        d=google.com; s=arc-20260327;
        b=XOz8gr/x8k/IOAsPSGLpXE6VORUtMqhGP/rfIGJ2jVe+/hQBwi4iKqOxsSwfcnh5EP
         g9Jgs7NXSwNEH/YA9mWta4ZxT5jqsTHaADujxdL8BrjoxihBFFAs50nU3ZhpWEsUeLI1
         Do1aEvsEtmW8u/woUEackdP5Iruk8qjDrhjjq+KJDV/PTJB2r9mjp66LqAo1abaFJgM3
         5OYOv71qyUJHVyByPa6SOsi1d71/Li3ermpAnMr00DDO2f9V6fZ9I9/44EH0faKUlMzm
         kOmymTjJaWMoYJ+7WZ32jJElU5Hwt2k8w9VtFOAzGgCCUPAZAZu3pRn1Nde/lmexpvxB
         LcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y+2Ni7PMqrXeJ+Ib9G+7B54AUw9Jq7EWt/AyyHD6kBU=;
        fh=N2mYRG6J2rHrhgq9O0+4rWCoM+T5a6U3xEw4zXPooko=;
        b=CmtUZ6++3QelpVdpQghBwsHMnOI+JxCrkbBjJNxx9YZkiGucRGyuxQKWcPKOFFA0hM
         smXLzyWRX7G9HFcHILNz5b309ePkW4uOZ4so0JE4U7O79gyZ4xOqAxR7DWanIR/QxTYj
         Glw5rOUh//TpETDl5RgQwcpDnA9Wt+2x5MSCm3R83CGK3hgEENIMQWN4RfdxcbAVltOu
         v4xDswR9wa2TyTldW7C20sfYiLDe/NFNbhxgSXhiUxBCIe66zSLNQTci5Luoe9jQ+hDh
         ekoZ1HAoY87tea2m+H3dn0ntI0P4S1M/rM3mfpkNEW4k1KitxvEFmyY5ErwfxvEC4fhv
         pu+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790880794; x=1791485594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y+2Ni7PMqrXeJ+Ib9G+7B54AUw9Jq7EWt/AyyHD6kBU=;
        b=QaHrE+hCNs8GieY6eP5AQgY/PyRFHQ780LwDdjfXqNcIG4Z/WD9011G9Vl3+sk7UgR
         qc5vstTNGaTFMYvm0bzKAkJb6Xr4+SF6gJsP1gyJH5GbwchYAA7+HuqbwqBnlUI/NBX5
         mCb/R2mNEPrqiTubYL4A6e19MS0lmlQ16GU2X0E142W81oJipUKhSIvoly4YOyXJB6LD
         gfDT+g+XNpMENzsv3QR3R7Yu0Lsd7tUkUMHAYNriZpDQt9KeLE55AvyaklTIp7QXfJAD
         GbhN6rhsnYXTx7AfS78BNXfbXCrvWuZ3B78UrsT9iey+glF2ANw2rZynvzsN45pIvM45
         vuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880794; x=1791485594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y+2Ni7PMqrXeJ+Ib9G+7B54AUw9Jq7EWt/AyyHD6kBU=;
        b=ZoF7NSMtV5rijdXMzMrWxGmnKsYrOgeq+2ZTUB+/DkwF8XO3s44DGuc5PEZRva5oYm
         M+DJUJd0S3BhrcQLbLjfZYNtxNXXtIWyYaE7HueHm9l+dz4X091wPOcADX//wVT2ONHi
         WE7yiavRvWX1MzrqJcd80srNjnpOBth/0xLWsUuolBbCjkusdV2rG8o/fc1yj1FjBZWw
         /y/sgK3nNwG7svmeOlvfwzdPcZYtjcZK/4eZiilX3bRsmX6DV5hZQuRdcifYr3h7cRXA
         +bTA2SbWvbn8oHzp6A1l9wWc4idGU2WJBtSD+g4rL9CQ/OK+Y8L9G/Dbm/i/03KyUenj
         YG9Q==
X-Forwarded-Encrypted: i=1; AKwUvBy4SZZDm14i30s+LkD2fx6lgqhX39d3U8i1VKsEFgbCIydGuUNsVu/gNBdplWlDFQpG6diNiYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ngNe5KL1W/NXHkqP6G14nt+b5IXITS/MqEaT3h+LsrJBXR5Bit
	2wED150+0o6gspvENa2ZB1+d3Aia8RIXgMG3oPlidocB97vsjEeHbefSqjJB4NikCOJ7ZhBWzMQ
	2QhZLcbMbFthac4/TWJT5ogslBApjpdI=
X-Gm-Gg: AYBFou0DvVDv/8JJtCT/c+N+/IMViEuFUYMZk1vNBhuocX/TbHrDbelJiYnbWwFL0mW
	xGLXswPA3ZB/fNZpdAm2sLVW9CjSrQU3vXQ8Nh4IAi4+MtK7Cz9J+XE0W0KbH5D0A2SrI3CevQ9
	v187UWf/hgHgQPpMMGkkFO9TEJZMxtGStUrwMd6SxngLTL5mv/n/QG0a27HXcMY3uNaBYCW8VlR
	00z+Taaz819+jL5/RC9gRWKea7YlWVC30jrJZ96v4DJ+KNNgYW66sVqaTJkHDgzPNM9RaZ9u2kU
	PMb1X1q9gVXU+7IkmLCXl6asLlznxSsGUcitTHw8RWQErjwlokuNXNtJzRtJ+6yveRbkBIIkBld
	N9ZrdcxP5IHQAOptaPQQ2Bmr30bvoPZ2eozk6tM++sBPMA7dkG+WSz74zBQ==
X-Received: by 2002:a05:6a21:8289:b0:3dd:a197:736e with SMTP id
 adf61e73a8af0-3e0bd24822amr308001637.71.1790880793837; Thu, 01 Oct 2026
 11:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928152132.3705137-1-guncraft2000@naver.com>
In-Reply-To: <20260928152132.3705137-1-guncraft2000@naver.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 1 Oct 2026 14:53:02 -0400
X-Gm-Features: AclHuK8d7NtbaPQb6Cfc9lQW_joRcJ6ZbSCH6q966PeL3ZPj33mszk9mvkCU-9o
Message-ID: <CADvbK_eJTrNFyPRSwCtUXqQRe7=_KnbDjsNEK97J4sYp+YpSxw@mail.gmail.com>
Subject: Re: [PATCH] sctp: hold transport reference across connect wait
To: Seung Min Shin <guncraft2000@naver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:21=E2=80=AFAM Seung Min Shin <guncraft2000@naver=
.com> wrote:
>
> sctp_sendmsg_to_asoc() selects a transport before waiting for a new
> interleaved association to become established. sctp_wait_for_connect()
> drops the socket lock while sleeping.
>
> While the lock is dropped, backlog processing can handle a COOKIE ACK and
> an ASCONF DEL-IP that removes the selected transport. sctp_assoc_rm_peer(=
)
> then marks the transport dead and drops its association-owned reference.
> The transport can be freed through RCU before the send path resumes.
>
> After the wait, the stale pointer is assigned to newly created DATA or
> I-DATA chunks and later dereferenced by sctp_outq_select_transport().
>
> Hold a reference to the selected transport across
> sctp_wait_for_connect(). After the socket lock is reacquired, abort the
> send if the transport was marked dead. Callers without a selected
> transport pass NULL and retain their existing behavior.
>
> Cc: stable@kernel.org
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Assisted-by: LLM
> Signed-off-by: Seung Min Shin <guncraft2000@naver.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
