Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790C3E1228
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370195; cv=pass; b=J9Zbm9Xs04bbz2tnKQEdaUZAnkndixeglxxfER+jTkeNddRcAjpa/3l+lxcF3BTumOBTBrOvhlRYLNk4fVsFFAMrD21y1tgfQ0kATbj4+KHF+YmGNuwCOGOB6jKjkCqL4ukSWqjUqcFcw8+R4V/ZKgSFGBtfW5FcvCDTvXytblk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370195; c=relaxed/simple;
	bh=JIaBxECDgeLrglNTVL7uEQ8ZAUKZE2cQsl7TRwoqsBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNIS/L0aC30he1a5oG3Ap3kZAQhkwlqKBbrIEYxcble6gItAcYoEsj9TGlUp1KLQgzRSRPy3R7Uc8/X0rOqQ0Q62Z7OpXUp28N2UfFR1fDBStDgd5piQutvY8Eh8K2tDZB7alH41G2eR4TjqezbODZvkEivmd22NMJzwh0a20Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ght7qXDz; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ght7qXDz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e27035206so230078b3a.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370193; cv=none;
        d=google.com; s=arc-20260327;
        b=VkoU31Cz40sG/BC4qbSMtrmlVF8EVRIzPtRxLb0rAvL++Xt2N3xX06hmRlXNfF9m9y
         Xq+Xz/s+rsut3FNIy0XuuSu+Uu2RbyEt41edj3z9AH+dOk2z30/Jzm+Ny5L572qKPpHH
         1KDvEzcCTYpXMaJZIBXNoGao9R0N7YJDAtJxy0jBKbqH5bJGkpwGqpIkMcv9dpjXDvPu
         Wr04pwfa/jsTKPivsmh66th9CW9I+gyUNDzsUb7YX7GSOjER6oxD3RFt3G0Snj80G/8i
         TIGf90PZEUdN8SbMcl+fwu/hZye5gmWsUggHLRFgBZWd6Wj6OfnjzFTPbFLAwv8rZui3
         cu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZiMjoEB+rAgTIeNvxZB7ySmeM47GF7ZvAX9I7YT8opg=;
        fh=uo39gpWBgHK0kN8sQfeOtXThmAgyapFofaCdsPU5zY8=;
        b=bt0Mx7u3nZ8d+mGciwSTx3NHvEBKEnZfNeKrZzS+MGNMFpuohBSeudMBL0OM+RGcHB
         Cc7NGb5RgF2sbMhQLZynWIm59EEUVCtvp4JkEpIoTxZgAuskI4kxsA0aVCbJUDBudozg
         JXF30qu8lcYrWv5/GCMtH5pN4bzwRlXhGzo/6QQW5IUL1JvxOjNQwo2Lh1tN9Eo4cr+M
         i2OnNnu6/FNwr9Xhp9VsiYiVC9WxPrm4MSZfnCmgT5M+pwq4NEyQ2Z/I/OfASjiJMNpR
         BZayEDmeTuXDDN1U9bKL72aLjwUwiejAYLvmSh8yazj/PMDEKr6c3U/fRXDyIcuOfSti
         Ca5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786370193; x=1786974993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZiMjoEB+rAgTIeNvxZB7ySmeM47GF7ZvAX9I7YT8opg=;
        b=ght7qXDzRGKZJ+LhdU5sniBUuY4oZS4RXtw6jWr+KfGhoMGL9kLZcCKSTOB0rC7gKj
         b7PosnYRjwtgqbNhp8EQHUSyxDYKWGxJMyIO9R75CKAEUuQc7zc5wgSkInr508A6I962
         Jke/c2BOCWmAhJx1Pd5FiQCTCNwBtjsudDuZuh1Z8ZHhLyhbqXlwKLysbadOhXVS0Te1
         aP36W/BFAeFu/euw9fI5AwjPcMQGtSe9YS0yolRqgSE4uMurIHjoj77M2L8Bk03/Z1Il
         7NATrI/uEag2F/6lRkjHiXz0zAaAdeYJvnfjWvua5rzUAzkn/deWWfKA0bkE0xcO99es
         eKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370193; x=1786974993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiMjoEB+rAgTIeNvxZB7ySmeM47GF7ZvAX9I7YT8opg=;
        b=qTkr3uVhRLnYDgcTgCGOQrFX6vFnUd6wKyVYk3/Fr8LtIH15+aILjmwr5Bl2lDNulN
         Rui7bfhIIt+ycHKWxBEECH8BrjAlnQN4yli/ex5mFt19s/EdU/0Sp1za5pZloLByXUhU
         pTNVcqeug6VWLk5yi0B1JGFAemNDreK27pSbxdjzc0w4/I4M8jNI6CcHL+ekIbLMlHAK
         0X85/yl3093V8R2VOOlkpAXNj5c5Sk58BOFDMMq+nLrrnZgcGOugLYOJs/L7JftV892x
         dXiF5rWnhz/VfCNxlm9apXbYhBuotqfWFLxLxeTygiHE5uHXTZihB7YZHLUzY58ULSdb
         GgNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgrbFLxnOL/cNi4Z9qvZ7u9TJQJb3mpB3EdhBFBWPgtsHNj3O0RPJ90DyFt/HjwxprccuByzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLe6KjH8Vkx58MZRz7unb5PFTQ4/1GQ8ZAlqHZt7ePAyurc30
	efk+zN+0T7rdZKjgQRNJ4V1Nl+TgVnO9rGLfLVH8AJatWr4kINoBLa55h6rnuC7gYAjBobyTQIL
	hysgzuiWt3jplz1wDJ1hCQIzpCLvvH3o=
X-Gm-Gg: AR+sD10wK5cuutTsYBT7UvPiqqwjj5YKYAYd2uDWZpy3vB4c+elJUnDWIEwRLMMxciQ
	VKc5zUuA/4i4hG+xtyH/gxcYeJZ4Ig9IIHyQgAThs+HnQMSufc9cv0BMikCZ7ElTbTr8oTG4S5K
	qxDoGMCl2ksjOPrpMHfqo3nLmZLFSKPntCUFi0+LcRs66RJJaXXXIpOTt/moUFWEXVONELA81PU
	riYrtOMQeBiP2yvC/8Gj/kjBwrSyeix81OV5zG0quXBIvLYNCeZOfISyD4WSQ9KhBJT0vW040QK
	bG+kQ8uj3aKP/gKtm9s+rNY6dFGaM0sWuAOVFVnNeZ4zRCgl7lFWAxcebY5q8Ec6rRI7I2YWf5W
	1L0Tl1qAcFIB4eZzjsd7V444zlT7mpjWTnp/BYaCFYre9YA==
X-Received: by 2002:a05:6a00:1405:b0:848:2c6c:dfe3 with SMTP id
 d2e1a72fcca58-84f9c914a9cmr1689714b3a.17.1786370192660; Mon, 10 Aug 2026
 06:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730064202.792809-1-l1138897701@163.com> <20260807064314.500742-1-l1138897701@163.com>
In-Reply-To: <20260807064314.500742-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Aug 2026 09:56:20 -0400
X-Gm-Features: AUfX_mx9V_SVYfZyMczkkkNKo2kfHaPSv0laG0eJ0CyEwUXRtjkhxqMLG_jjaxs
Message-ID: <CADvbK_fS_8AoMpqSosUYA7zhqtYx=wXcB_DvkZXe7_DKaJJ0PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] sctp: auth: propagate HMAC calculation errors
 to callers
To: luoqing <l1138897701@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:44=E2=80=AFAM luoqing <l1138897701@163.com> wrote:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> sctp_auth_calculate_hmac() can fail when building the association secret
> under memory pressure, but its void return silently leaves the HMAC diges=
t
> zeroed.  On the receive path, sctp_sf_authenticate() compares this zeroed
> digest against the peer-supplied one using crypto_memneq(), potentially
> accepting an all-zero HMAC from the peer if the allocation failed.  On th=
e
> send path, sctp_packet_pack() transmits a packet with a zeroed HMAC that
> the peer would reject.
>
> Improve error handling by making sctp_auth_calculate_hmac() return int:
> - sctp_sf_authenticate() returns SCTP_IERROR_NOMEM instead of accepting
>   a zero HMAC.
> - sctp_packet_pack() drops the packet on failure instead of transmitting
>   a zeroed HMAC.
>
> Update the declaration in auth.h accordingly.
>
> Assisted-by: LLM
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>

Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Acked-by: Xin Long <lucien.xin@gmail.com>

>
> Hi Longxin
>
> Thank you very much for your patient guidance on community patch submissi=
on conventions and your valuable review. I fully take your comment.
>
> As you mentioned, returning 0 is acceptable for the moment, given `sctp_p=
acket_transmit()` always returns zero today, while `sctp_packet_pack()` ret=
urns the count of generated packets.
>
> Although there is no functional bug in the current code, unifying the ret=
urn=E2=80=91value semantics makes the interface more consistent, which can =
prevent latent risks when this code path is extended in the future.
>
> I will implement this optimization as a standalone patch for net=E2=80=91=
next as you suggested.
>
> Please help to evaluate whether this improvement is necessary for mainlin=
e. If maintainers think it brings limited practical benefit, I am okay to d=
rop this patch entirely.
>

It's fine to make the code look cleaner even if there's little practical
benefit. However, for the sctp_auth_chunk_verify() change, I don't think
it looks better for all its callers to have:

+       error =3D sctp_auth_chunk_verify(net, chunk, new_asoc);
+       if (error !=3D SCTP_IERROR_NO_ERROR) {
+               if (error =3D=3D SCTP_IERROR_NOMEM)
+                       return SCTP_DISPOSITION_NOMEM;
                return SCTP_DISPOSITION_DISCARD;
+       }

If there's no clean way to improve it, I'd prefer to keep
sctp_auth_chunk_verify() returning bool.

About the return value of sctp_packet_transmit(), I just checked the
history and found this comment in the code:

  /* FIXME: Returning the 'err' will effect all the associations
   * associated with a socket, although only one of the paths of the
   * association is unreachable.
   * The real failure of a transport or association can be passed on
   * to the user via notifications. So setting this error may not be
   * required.
   */
   /* err =3D -EHOSTUNREACH; */

I think that's why its return value is currently always 0. IMHO,
sctp_packet_transmit() should return void, and all its callers should stop
processing the return value.

Thanks.
