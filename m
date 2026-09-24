Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49141D22D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278022; cv=pass; b=sa4Z5reUxrNsRK3dJutsKC9QAEgQXJA4XHJHCnNldOn/lxpJguPTi5AdQMfuuFPmGOaQTbzPitF48zbDHUmNJAPbtzYTzFJoMAiETWal/egWu7o+wVCByWegTFkukXKpXBsmV6iab/OuyiQxq60+MIfxsrJrS48itHteP1zgO2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278022; c=relaxed/simple;
	bh=yYxa5cHYFz+o6mtZX1mc8GmR4S70HG0QuP15znE6Z74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr3n6UajDK8ObYyOie2HbDoRwfXtauDOXD5k9gz48IwnQLtVoL/R1/ko96pksaYu4u7TxTbczsEI4x3OnMnkRLj1SY+QET0SCjOjL9NbVwAXCP+OzHeVSP1ElYNIC9Jprce1UpVH5YPA/R+g6o/gtwXJf0JLPuZFXKgniO3yFvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMLUZbty; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMLUZbty"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a9d74e8292so89a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790278012; cv=none;
        d=google.com; s=arc-20260327;
        b=AfRWYnYisghNXQNNnD3TN1Py/oOxiYT+EO+lt9oWMAoQ5ScSqhIHu4xBYThFTcX5dg
         MAvqraj6dP58BY1o2QTMnv7AHsWfjWRE8ZRj/2yM9P4l+6+dkJ0fwU/VVoDIE0SF6PyY
         G5m1KSUW7Z7nOwM/DpPR9VfYWrZgVnpGy02n43q76j/mqNw2dNomZYBaR+yVK3Li00Uh
         DOwzfxVnqVNN6ayspvysGS0gpmMZzypUdRFefE0tuQ9ToVUaZ1AYhl2ZPgOIDNSPb5Ln
         8vlXzF668yAWrI4t6LNTp7dsqWeCjHfKxRHKaETUHeFThv3xO5BJ/F+Pds+U2BkBqKrU
         b3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yYxa5cHYFz+o6mtZX1mc8GmR4S70HG0QuP15znE6Z74=;
        fh=wmK9//F6yrVL0pYZxeonuTZeCuyCkgPHs439uVZTXTo=;
        b=Kxg40epQCAaDm4q5ZYZtbTfmFNk6GP4jOv9KRE+YL723RM27FaOniiXDqMPtybjfWH
         Hhm012WcTIH/QObxa2P0bdK/VRK+X/okBoYlHT6qriwKXSGcdkrfTFlmMPZDZPXkNj0q
         t8m2kmpXaJ/UtGykGilUCxZ8NpwdGUbezy9pf278hKDnheHvFENWGb7rrTR+BYNijTn7
         Yd+/x+2DxnCZyIgUtZ3P/xnANkcKqiHCbLWCvvAhKsRZIiSyV8EjygZhyOAY1HkA1Qpi
         6ILxntPY7TvsCJB6LvtkHkzgd1R6P7zg3mXkCvrJvWFm/BmPNxwIF6t00zfCrC98u8qf
         WOcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790278012; x=1790882812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yYxa5cHYFz+o6mtZX1mc8GmR4S70HG0QuP15znE6Z74=;
        b=PMLUZbtyMNWUwugoImgCOMKYy5drlDBLGOaShjfC/ebqZbWFtlVhF2WNYIxkuhyRHj
         b7+7qaK/fsYJplVuBlHNsJPlmCidJNrvRr9FGQn8K/qeK2n7syyBT/bL5dNvDmUTZ0YR
         YdU3JkQNWjg6grRbdgJowTfaKOL5lG/2TK0pOtJkWGV3ACSuEwAIIVYxX8PREVJzSIQJ
         TYa4OlNAyW22ep5AfpuNx69ddQAd79jJZ1QvezgJ4+X6/z9gkIhzfkYk8DAZqp0wkXES
         qBt6JEIb6kuK9BaOqt1fZOYXK+FW45QnYjPpKMKi/YbtdLismBZgwtkhYl+wNv2/aRY2
         ZPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278012; x=1790882812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYxa5cHYFz+o6mtZX1mc8GmR4S70HG0QuP15znE6Z74=;
        b=PDwiCCQ0Vbh81t0vOyzAJDCs5TvaPsFc9FFWPCRyB4VlhSxwtXpfxBc8pu9JI2ao5W
         A5q6e5Mdxor2262SCVw8HbI4HFhY2xvCzSZwqHs+3HrOb9mk7LQ5muEzmQbC/dU+0IDB
         CB4mtZ7V8fRB5foMEt3pNflEdFgXqTbbte6Gj+YMSTcu6Jx/rDuxs+Tti4AvdVmH3Xrk
         cd0CJgNhTAEGGR8h9pJuaK+wTwdHk6nldHIR3y0GpIFT+yvPuTvKY8a4IZwWHf4Hoq/D
         XcGgGc5MEOhj4rSmhFSVKtaPjmi3EUcp81D8SdpUnMdV0riR3s1msLyJX5aLRBLK5dCG
         H3IA==
X-Gm-Message-State: AFuF++nyU1tQtRVjMe/EcEl5Wb78Dw3blxw56E5+miPBEgc88LWEcXRP
	6XLroiYtjWWO/MSgzIUsORgqYk0AWG2jkLLoaTlxGX7tum7/1Wm1AfYttL4MZFfXfq357qRoqgi
	O7t1+nGDXQ+H0ysvPHzEcifRxcD+NBc8KBaGsBt7TjZe9yK4CqnTAZUjZ
X-Gm-Gg: AYBFou3mJ9z00WKcMxgdttL6FmIAvH6ALczK3Y9Xu0+yrJ/oaVjWqMsBuvu2vO43KFP
	8WUJsjYNaELrPO2tztQDen5yqiqRM2AzLeI39o9Ha1pEr9Pb0utUgFCYdzrD1dsANuYSQ0USfbZ
	qH0SyMFJLN1ejwmSQjH1EeNp6xmT2PppNvLEiYj6krgH/cZkhImkSpZJisC8xDYKkRnJd8glvoE
	2kroQJjIrAte7fO2YPkazOLnCzdODMr1k/NlsSDvZ7SEJ92od5deW1Xbr4kMrVqNAktOphAqfjb
	4uydgMjXtmctV5vSmfJn2ptn2A7nh9gdRfSWc3OFWf8DIANZfkHRhcXR+brbvLeCoDN6YyLj0iH
	4UGyHlD7QA0o=
X-Received: by 2002:a05:6402:32a:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6aae505dec3mr6769a12.11.1790278011541; Thu, 24 Sep 2026
 12:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922204348.717198-1-sdf@fomichev.me> <20260922204348.717198-4-sdf@fomichev.me>
In-Reply-To: <20260922204348.717198-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Sep 2026 12:26:40 -0700
X-Gm-Features: AclHuK8Infx3n3fxQpi6yWw-iI-ks1OfMwPCy13lk8MO82P-g6diXI4rh_Dls7s
Message-ID: <CAHS8izPTz6g8MR6_1v3cu7OEwZhokS7oz6qbi7tU_ZG=yeGz5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: devmem: decode DMA addresses for TX
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:43=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 32-bit architectures where dma_addr_t is wider than unsigned long,
> page_pool_set_dma_addr_netmem() stores page-aligned DMA addresses shifted
> by PAGE_SHIFT. The net_iov branch of __skb_frag_dma_map() adds byte offse=
ts
> to the encoded value, so the NIC is programmed with an invalid DMA addres=
s.
> This can trigger an IOMMU fault or DMA from unintended memory.
>
> Consolidate DMA address encoding, decoding, and representability checks i=
n
> netmem helpers. Use the common decoder from the page pool and net_iov TX
> paths so both interpret stored addresses consistently.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
