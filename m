Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794547871;
	b=MA0zh+myPV8Tt78BkF3xt3XHbppDeEQjhSoNmlff/MHqd+Hki/n+awWHlVBgpmo2n3t4
	 Tek6M5S0L0cRo/YPAYbCgkZ6N/mFhZcfO0+aQgc6iCdCRW9tbwkESDwO/KauGJeaNWBMA
	 3Oqu29BPN9kiYIPVO/h+bfcOIpcaFksP0UdtSqqF5ir2RXcCgJbV4xsdffWovyGQcsey5
	 vdySFCDZCzT+gyzJZxOPn3eSKIQcr0FCReMwb6s4AbHudfuYlrerrp57uwZPnvqOZuXXU
	 MYuHGra6Vogs4bVNG5gK0sRt7TOTLPVQhdUF0+jYw2Fv+kwfaxm8lkAhUbmg5fN1j9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
	b=lfbsa6FjMUMtRUerqOTqoz2R6ofLi3EANhTWESIZOcZN+bHrF5D1ajBh/ggJWNxPthvl
	 +SndtWhQvgSjUZHAUFoMSrw+xtLpVcemcNl9imDHMhFS7flLkGHOMFGClVHuZoHa/fp7B
	 FS9liUemAUFf3C3nJ8UQowV2BruobjnIt9O9+Xk/v93Z0hMtv7DOW2TvxAs3oXt7i/nW7
	 o0Ch53UwKEvEo6QmFUFZ1OFJ3ZTQ+YahMLUTpjwi2FjX1c5vlP2GdUnfgEZ70IKxJEInF
	 AUDSp+2zwCQXow0BDDFwQC69PsIbar//NPit454HLvVCqczrsD3t4gddBettqtjmU/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="VTU/Umv/";
	arc=fail smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F9606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65F9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VTU/Umv/
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso4647a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547869; cv=none;
        d=google.com; s=arc-20260327;
        b=QL80SDIZn+SRqPRPXbLJKFQ9t7gRPEdN2uKQzrjVHWn5pcIG6QZWNAEd2U7LztKIYK
         E2N4M2vbENk9OxuSv4ZwabLVstMqNf+H51HTVSpGNUo1LsK2X/BGb1CjTBqvWSS1kx8s
         EsFDynwUjZYDf1jD/a8uKoap4wkQM73LxNya8J+9x4HQzrL9AYVGHNJ3bVHfG/1yhyRc
         ARECnYeCuCoRCfPhlnpj3XMEKWY5+Eg+JGbfDgNo+5FT1sewDJAvU1+WZfWkAWUeo0jC
         DoyDafiEQ50IOikwtpEjtAi9wN+Doe6KrMGHbJoQZ//FBa827/YZK2sJPwD84xmftKCC
         FbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        fh=vWlqezP5Htfxewai80i/EY4pLyLbw0XT6gnlTaEVlQo=;
        b=J1BGxrxmb5siXYSnjiOYLpyyvCr549zWg21ITvNA6iHz6wKcTPhlj/TcIO/yjbs21v
         2ztvmFuZsPs5kgl2gznemhZkEJUk6wswLyjutJsJpqci4XrMPAbaQcXK8NYQSkTstu9V
         wfJCKPpKdcLxFiudcIpdmfte+Z89QmnWYQboSLoVEqvdcyisdnnONZv1RZofx2X2zv1h
         x8dJhrgl9d6JPXqStFpLOc4LsE064mt+0p5Vnmz5ox80hr7f2ao5GWanIr5plXQPaRyH
         aF6Cu3n1VzuD6wy/8zVJG7HKToFL+CnOUr7fowRV1VEh7AEFxtF+96JYnbjbwzEnFibc
         LEwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794547869; x=1795152669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        b=VTU/Umv/XxRmtX3d/XSHHHzSkVNlCjGAiWWmvRpYtATJbDMspOvWRWvSyyqUeqeGeO
         Q8uCINspbjVgU1zSuH+9UnHcqxv8cjRjT4BNbJxmhaQFB8TeexUJIOYqLp4e6zCgNF7n
         GqWGMPJWmhxv2jXRWVtVDAZqa1EhqIWzuIWQ7K3QsEysQ+usM5G4CvZUur47OQUqnPpY
         PP7Up96FsigDTcgDAk4n7JTplwxHbQe689kspsrS0geT7o0ItGIgt0vez+TupVh2sN/m
         e+JFPSRT2SGGBWIOmeouwuXUS1RYlIiX34y+UZSFFdexoH4xWaCTbeVKnfpyGGT5KVCu
         Qs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547869; x=1795152669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        b=qZaUO9brM15d2/T6yWbHQH7tC/kg0DDfQzpfjeOtYQNHcl1yec2b0+YlV2zwVHwQ2H
         ZSkHkPPKT7ts1l+diPGNv+Wym1T+OnqLWebJcmqasnVF86Ikxos1+8ym5ybpIHBwWoe7
         CIfq6QhaF947UBo0POtF7t9pnGlRY5K6vFrubx9h1pkW+HMwYu043bkd/GAg0Of8LGsG
         CFzoELlOrID9m3EKRHiZqe6eCll8IZbbJBbf381zM7NoXpU+/JpYubN0VzZRiuhCnIYY
         A58YQ/DNIfRw0h+xKPbdP709hGX5fAWL66JKU/VZbN+BBrJxkr81edgn/dYwp6LFYLel
         PPHw==
X-Forwarded-Encrypted: i=1; AL+hErGNKulmRQZao4sRb0YpK1pCevp0aco598j3dnZin8TXhhvpUDsJP0Cdygy3sIJs1y/tEc6tZ1M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g1VKi1CoTuElOuhotudg3Tk5EomkfXAciI5cDnsP0IwoGZfPq
	YCZ65z/L1kTu+56DDyhtHfWrY3JPleUU3u71rdAwZS3siKRk2a+Rq5pc8A//VMFO1i1cT0cLrif
	Vla0XfNs2eecuHMFwKvNRA4sHD1C7I55bHIMrMHeP
X-Gm-Gg: AYBFou3MJI9p+CVHsIhMBjGweoy6RrDqGSTwvevKCzvPSuV3Z9ZMyr5tKhAFAHYGOLC
	Gdu6wY5z9+Pvy8RofZUkrUG6jCb1Z0a+Tc/dtdiSLWr7Vh2Uzboi8D/PQDONlh/K+XkmmA0YzHD
	G93VpH4HudEBcl6lNZ7p3yJstjsUgo4c9wEDwJk/Wi0zPUhscPdDzLF0dwG6N7hgNgHZHQrSJhU
	8zjAia8MtvtKGGG4tS4MlHt/SWI+SlFY3d82VWIP+BIRJ1Iv0j7AdBG0pk9WNRzNHRwGrzxyqoq
	0ZThBJp/+epzkTtYJk3oWYjGcAZZA9Jr/rw+q+T4TYA0HNunp+VVvxGm1Ff6mCGji/vj8FPsAUk
	JQJLUspSuDreKriCn401A9r1evrv4eTNH4fo=
X-Received: by 2002:a05:6402:50c:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b7c82ccc67mr31403a12.12.1794547868632; Thu, 12 Nov 2026
 21:31:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-3-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-3-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 21:30:57 -0800
X-Gm-Features: AclHuK8G8jI-cBJtcQSxvGp_Bq701GaxLVhNUpqBJGdSCTN97QaxO6J0E1uIQ_U
Message-ID: <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> The core treats every memory provider as unreadable: installing one
> needs header split and no XDP program, and any page pool that allows
> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
> XDP, and hands out whole buffers.
>
> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
> readable provider only with the new PP_FLAG_MEM_PROVIDER:

Why do we need this? I thought whatever creates the pool actually
shouldn't get to pick whether the pool picks up the memory provider. I
thought if core has configured the rxq for a memory provider then the
pool is forced to take it.
