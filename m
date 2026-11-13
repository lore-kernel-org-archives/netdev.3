Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598046;
	b=GbAg+G7t559dEFuMJdNmyb1I+zI32WbhchXs9/4EHndiBOzE4kiKYJCSmswhRmrjlXc9
	 tyw6z5nEep51c/HqwtEvRyx7QyFAIdGOFaj/NsAp2uviGfy39UoJ+VVV0ENAO1CuZaWWK
	 XXiZ1Jd40AjLP5aRLVpi4A+UUyf/FOYcjaq+4cdjAU/zSxtcqCcUALYn0GBlpUiOc1kWq
	 Tnca5YvZyq8uCIDfS3pvwpqn3P5cjK7KuinuSpFYW9Py+vWzR+Vbt/gh2StnkTONoGGMf
	 AHcPe3QanG/KP0jZ2U+e36hU5elB2I0IycD0C7QAIbLp/Ll7Fqm7Wtwt9VaP3DqyAxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
	b=ZRxFl7kcrDx9fa4SR0pYirT5KW6EkNFB6s41FyGSo9MBC9d9E04mqSE/+y6hprjW4tmz
	 jVuZFT661lgYjVrVsC+OMU9SzGsQ3abgp80ftAoo40LSZS6q85oXvaqSD2c44PQTa++xm
	 aTEMk4wKnycb6Ob5DxWQbQzjbiEOvNnyzmir8hImKmI2+5hvN/qPoCG0gVEPphc67jUHS
	 bdtbT/Zm1WvFB/LVZ3AAsLxEHf9fnmlZvVRLsSY04s4o7bI65CDFkzMKTUInp4Oe6S9Nd
	 AHnxaum5eInMf7oTz1b/UzYiKiOH9WtzNtYQbpFMSZajQcS9zjnyDeoGSjMlLeO2VDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gL8jZDdW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B5606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961B5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gL8jZDdW
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so1167a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:27:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598044; cv=none;
        d=google.com; s=arc-20260327;
        b=QLw/tS1zSDNOvsGd19kqxOMocFJiGnjyTufi6gbjvybvyiPalr9e00v/efxRZCAQzd
         74wunefMf0XzH1qlaJW0i4QCB9tfbat4OEuddWsabWkQD1up3hhbpgs8hhVbRyWQKONR
         9h/PIlhMQga5AVTijI8l97mP+WzaVXFyca/g35DRs3V/axITGd/DOKmJ59p3GE10JUpo
         xI075XYyaM8BgdJEEXFt2PCubKIiDs/OMrmDxvilGvtsC7i8TYkPWt4qoBYg06yW0a+b
         WvpbmZfXnc0dphJJHoXPNFILj073+RH/QSv/WTlyk39Cw5k4gHL5SUTFz7/4uYWq/aS3
         BG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        fh=jmGe+SMD5zQTdRLkD8Hj0ZYVwGzBL4gjp3N2daYl7Fk=;
        b=WxKRbtC0WoUAmkRCcIEzFAYffoIlCHt2kxatSh6SGuTEalfXCWB/Y7H13VSJ8LCpZG
         JBVJKZcGLkgkaRroz8O8yQh6wdvbHZO/LbmHuTOPFl4LHoIIfsI+onRVXA7r7bynSF+F
         FaCZD5SarpG8OSKjfm93CrKLnbxTDN0lHvVLCEhGooxv5p2GLM9ySGYgvzGT6zdupmUa
         TnVpzmhxFEqEqDjgOSoMNj31qh9cnu0+owhNkcGxpIVrmnpUjUS8n4y5LrATy+ZvasfP
         2BoXfbV1zzp98J3MbrLBXaTYLg9hLl1kWFuX1nKpndzNz0ffIFd+/Zb+m3oNm2zeLzLS
         Eb8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794598044; x=1795202844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        b=gL8jZDdWoijYOUqqlj8DOAFvK6zCt6P1zN7hO5bgTFypZZ4sQKlyeApMVL5tn//P0M
         6kW3UYi9iCdBDhHfk6wKFTzI+2CfsAFBw7Rqv9Vk1nFOxXNXN/aD1X2E3ajfnJ6UGuBm
         glDsl536MTl2iP4zdDhrwJ/LeGsb/n7BT1C7dJ/ov1VxHcpDm2TAmCZoixEJlYoKVorI
         ShfqoCaCnn5MgtpAfxRcrwijJhRmF2tjMYr+EO4otzUnXlUcb3HThkZkliJTv9xT5miG
         cFjd4sB1mm4TKPqC2fzbcGlemMbI6HKTVpEDf72EISt32sXh2M3a08l80d0nxf1IFaH4
         Jg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598044; x=1795202844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        b=emCjcqLvDflVOm6XIg/gV9bqbjg3riG8u/dI/Nq7anjXZHJNLuTCyO3V3M2DiZB06C
         RsoDxK3XlVdzDJJ6ttcJn9Y3G5fg13ucBIthgmODWWoRotMh8qsIW0wTODKedw3QwLdQ
         +B2CkBXsPE9K0+XflfydORUWnwKdNc+H6iCb4dffhfgh1+6rJCWSyo1zPxUKjbuSUdvK
         yThvQmTD/4IMUk0lg8Lq+UUQQQiUNUJZUPBvlONaERVjDFInphgr2NZP7TPSuxoVJECh
         36bTcWqdsjkdyuYS8bB4VRYfTEzbzoSdAXMs+XA4wol+WJUtnZjcGBkm4yDqXYRtkaHe
         qTiA==
X-Forwarded-Encrypted: i=1; AL+hErGAjxiENNhwCuyNv+fk6B8hV+Srk7sfopD6FwTOacl9Q6u6mmXOigvyj9//eX7HasZzYA/6zNw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nI1TEWCssgtYnATDlcFbNjXsAsmxPvDX743UOZVcEcJF5jUSG
	ggWkkilvIrU3PXjqHZvv1vJzMH2O19X55GgovJPkQdWjCpWAwqN8ByOKFYf0bfKs7K/ygMu4xn6
	Kv7yhoS+QGIhf1Hslfn32Zla1QlVGhhEyaXH7YMvA
X-Gm-Gg: AYBFou1iIBpoqU4ERlo/bMh/eQO58r1/duVmb3g9wKNC6drcY+bxGb1MJmnepfBB6KZ
	G6JNdReL3Js6kmRtzbM8up05ooXAkLBuvHvbwMNO9BbHTYBhyrIQdxD4okzNbBOY9ezURVX0Oyl
	m7+bNH5mKj33HCr5gRY1IEN9EbbPiVUnK+RlWVykgyCDapmgfYsvBq7rsUF9tTQghT9UxVzVKAN
	A/O5VX6lF8DM+3YVUprHZfrPIjrBt+JHVWQy/3GQDAtXu9sLfCw7Yl7uEP3fnHd6DKl6u6HiVP+
	Qaj0Ff1bL3z+o95j9un5CHraCKrIeyLnNW7zMR/BpZoFHI/RUSJlVhvdj2C3ebb9luRdt2oDxzm
	5eARNubGzhyr2BBu+cfS8IzhGMjnJ6vtgm8tGZFUOrvkSymitGBZskVqiL5JfNgaGtl8=
X-Received: by 2002:aa7:c60c:0:b0:6b5:5d24:5d90 with SMTP id
 4fb4d7f45d1cf-6b7e064b605mr11515a12.3.1794598043562; Fri, 13 Nov 2026
 11:27:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-10-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-10-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 11:27:11 -0800
X-Gm-Features: AclHuK8F8Y_DVnfmHCZelVEZmvLdtuJXie3zRJu-e7GqKDc7mN1PxeFQiqOooCY
Message-ID: <CAHS8izNyMM3pSJJXZga+OL6QMHFgnF-gu-+vzk6DO=EC4CLfuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 09/11] eth: fbnic: Use netmem for RX headers
 and XDP_TX
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

On Tue, Nov 10, 2026 at 2:22=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> fbnic reaches header and XDP_TX buffers through struct page, which a
> provider net_iov does not have. Use netmem for both, and set up the
> xdp_buff with xdp_init_buff_netmem(), so XDP_PASS copies heads that
> must not leave the RX poll.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
