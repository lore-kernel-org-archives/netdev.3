Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F6419FAD
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138784; cv=pass; b=ZoAkeLA06YU0YA1MChp+Lb0klstAWoWYghLj3pKImBJHJOLtuQKG5M+xxM7cDO8D5YpvUTjzUrTu+JYe9cZAQk5JPxJkQoPaN8QrdBBpyCQWDv6wjgNw4ylgdKBPe4Z2gh4aIxMEMvGTEspLgJz+Xs6drjOidphonIRjD+Frp00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138784; c=relaxed/simple;
	bh=CvtqbhTpcUIjBiRcNfVQIUfQdk2rVlupkqd6L4xp+Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNwXJzMcSU30n2/7pKxrTOzKLyTHg8cDf34aNGauleA3m+X9IXKEfgIVpYG4OD+JekgsMFiLTDEMLx+e8k+c8TzXjvBeeXruedF7bExwlJzxt5cECz3fIJiztWf38iAXEyMYf+jiwTOWX2K0dm2K1nnmW2Qcl3UcfUkf7GDRSVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwWaJlov; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwWaJlov"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso12555ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784138770; cv=none;
        d=google.com; s=arc-20260327;
        b=QnkBGOpYnXczdKe7ondHFKdFHGO/+o127QTM3QBwZm3jNoqXwdIM5nsOIwGV+EQc5z
         r7dJZSyPkcn/hufDu34HqR2aAfUUR5nHqSe7iMGyRUSWB0esXcJfusWtsa30/nQD59mg
         03d60UDd7vYuIdDoI0vjv60DfUkCKlrNAomXU6fP1X+DXVnxyKgcbvhbhsEoW5+OPTFl
         fNNzSKV2D1vnl7U/y8gm4T9Y/fOYtNyiw3ciVc693MQzKF5u2yKBDvStSTtuBUWmc39V
         m5HFa5wB84mEDfHO0bw+E2ffko87ZDJmoWFPI0/3tF55S5zT2D2G1mLFyVmPdYxYInbv
         wfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbDYprAtTAaUYhTnGvnNHpzVJY8syKc/fpVU22ZOJTI=;
        fh=eeUVkgBS+h949Zk/UGKVK6g54cl20ahiiMAzuCzzNlc=;
        b=F7ZBpKBBNaqlKBUucBUeO3FITcbgrS3yOrk2Tl4vwxkTjNr4XiSaEqWVuSWV4mi6no
         B7bTdMsCqOe5Q0Ds4kEQTDdyzIJrpY0tgldilmH8+7dIVxCNFRcTPeUL20/n6/yqP/wg
         FTsP7WP3dPSlpHvWmja+2N9iOwGRcHHapuO6u7T9lzyRX+f8Qai8/p6CNU1SN1xya54y
         Tf1wRaxwu0cQFPNo9PO7ci/bJJPqjLH2u51nyRbhW4EJS4i6zzmXSq+rz9WKc7QW0Zi9
         rFlqNg5+O3fhKMy+YQ0+v66rXLNcQJqgoCbJVYck6XpcQFrKWVk837aD5p5L/CF9x3XW
         8KCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784138770; x=1784743570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbDYprAtTAaUYhTnGvnNHpzVJY8syKc/fpVU22ZOJTI=;
        b=CwWaJlovbHtRFgFkiot0TdBPHpgK14XUK9NOD1ejoAiUYPRaBmr4YCnmCzlxWUiNCS
         IPD3a+ER9NJAjdDmI7TFZJUvbZ4IvvepFXN9+cmG7E7+ZIMbPyhPXgwD8WfpkNG/vK4Z
         CvqvJ2xab6DJN1MHzEtI26y8MBIMmHMhwnt4167ksS6cmK0SdHQ9aYIBK1xFUbUpxEr/
         7SBUhsYb80wwStm6en0zLUsvuX/q58gdxTdhfv++t69sPUUQsZ82efpD0seeEeDBcrfX
         2WwmsOo/STxSOCnjGTL4lO5VLIFmksvQPHez6LKomt3etllHPENbi9BvaEh7axBqImnh
         JE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138770; x=1784743570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbDYprAtTAaUYhTnGvnNHpzVJY8syKc/fpVU22ZOJTI=;
        b=SBa9uprR4uD/iz5VkwqLWX5PDBHhQ/L/sc0jFU+sC5/24ElQUhYkEcVdkGw6uLko9J
         AGzoLCyb+1Ry0niNj9uhSo85MoK5bWjDg6xTG+E9F9VN3q3YGgnIV+nVfozcx9j2XXc+
         nEcNbtVnE744JaWLyvozgtj2+YgoFqga+qnwK6N/oDGsX6Yty874SgmrSRxDb6VsDzdP
         Zmidl7Wqz4qDQkLTT28DpmGQJkL6EXr34Po9Xr4XRSwfBoNcFrka/ZcBEpvGSWdnK45t
         fUKioni1ary353Xju6kjLyL81dbLLpxXZrAuNpMaGiqIzXMu6ybl5QqeTfjizeb5AZgz
         D/Zw==
X-Gm-Message-State: AOJu0YyNdItManUjwMhfzHWqHQzkXCeOYsAR8NHv4adgbjs8DvSa6SA1
	LPO07yj5ypTAX/8XZ0c14Aj+lZZCjZIs9NMXGj13htfh3mGfhVLfJR4b9wyrju1eIS5VzX76ZTc
	f6IValLfKFqdMgY1ig/zAkgHVuT1SlTfTMJgRTs0aaeoeo3TP0PYQa+Hp
X-Gm-Gg: AfdE7clyTZho9l6fZDNDCPGUj5Cs1tNZ3nYPZiY1R1dAjyBBr8a+ZLIH/Zg13SUKfxm
	WRf+FHyVQP06IZ1+dFVBi4uV/coMI/ESEpZHolpuSPKMi2F2CG3sAa/CG7RjmL3ZZTBX4A58YJw
	p+zscHlhs7xuYsXxqXJL0mNZO/GBgdfEudqgp7WMnocrU+VgOPIZw5eE6MBCbgjkRGroyMfB4eU
	C3i3I4yrl13lU00wQHwDzUhp+BKLtYl8Ok0ST851YsCq5WeK/f1YlRuxh+/R2eTwO39L4qJ9JNS
	IMgDjp43BlRP38bXnFK5IJOiqoY=
X-Received: by 2002:a17:903:1850:b0:2bf:139c:dcf3 with SMTP id
 d9443c01a7336-2cf19639aa5mr404555ad.19.1784138769096; Wed, 15 Jul 2026
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4@eucas1p1.samsung.com>
 <20260715123602.51950-1-j.raczynski@samsung.com> <20260715123602.51950-2-j.raczynski@samsung.com>
In-Reply-To: <20260715123602.51950-2-j.raczynski@samsung.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 15 Jul 2026 11:05:55 -0700
X-Gm-Features: AUfX_myiC01IMInrfsYG52lU15TUIyRDhJY9tdWQ7zQwCgNUQoJkmDKfWc-MS5U
Message-ID: <CAHS8izOC=hSwB=nFhs5h8UP8knnfMTj7Zu=9trxZ5+vHN0dXBg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/stmmac: Set Rx queue page_pool to NULL
 when freeing DMA resources
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:42=E2=80=AFAM Jakub Raczynski <j.raczynski@samsun=
g.com> wrote:
>
> When freeing RX descriptor resources, there is standard clearing of
> descriptor page_pool via page_pool_destroy() which does destroy
> page but does not set its pointer to NULL, which must be done by driver
> calling this function.
> It is not done in __free_dma_rx_desc_resources() when stopping interface,
> which is generally not an issue, because __alloc_dma_rx_desc_resources() =
does
> setup this regardless of previous state.
> But above is true assuming reinitialization is successful.
>
> In case of failure of page_pool_create() in __alloc_dma_rx_desc_resources=
(),
> all non-NULL pages will be freed, including those already cleared.
> So there is possible kernel panic due to wrong paging request at address.
>
> Fix this by assigning NULL to page_pool pointer on free.
> Also remove NULL check as page_pool_destroy() does check for NULL param.
>
> Fixes: da5ec7f22a0f1 ("net: stmmac: refactor stmmac_init_rx_buffers for s=
tmmac_reinit_rx_buffers")
> Signed-off-by: Yashwant Varur <yashwant.v@samsung.com>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3..3098971e0b66 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2172,8 +2172,8 @@ static void __free_dma_rx_desc_resources(struct stm=
mac_priv *priv,
>                 xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>
>         kfree(rx_q->buf_pool);
> -       if (rx_q->page_pool)
> -               page_pool_destroy(rx_q->page_pool);
> +       page_pool_destroy(rx_q->page_pool);
> +       rx_q->page_pool =3D NULL;

I wonder if it's reasonable to add pool =3D NULL; to the end of
page_pool_destroy. I don't know that any caller wants to ever retain
the pool pointer after that function returns, and grepping this
function I see almost every call site nulling after destroy anyway.
But anyway:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
