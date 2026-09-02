Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56267476CF5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348175; cv=pass; b=cG4c+b5cTfwYpPlrJwojeOElxGB0+xcaL8yDg3ug4A4TVX2xLDzjncC9vNspCX8OOB3XrkUsl9uoo4wCKbgoOYpkBT9GDlrYgXrsGoJrQ5q6Y3qo3ltFUFytC3YKuktnvQwP07FCaY5sqIpoK+CfbWSlycKDvlXQaLN+Kufco6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348175; c=relaxed/simple;
	bh=uUk+l7F1x73TBUXiddcj9QUykpfhsH7j1MvfaQsWcfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aydccl/yrW2uW1xxjBzwPVZIZ73boqySvBuHhJ6acjMZnhxkbteIj2BwCFIY1Hp6iJEqnK2ffpSs8Nsw+5ig/Coeo1G4wmr8OcJvGU/7gOo+c2BToghpREA2N8PuIAcZRLLR5Cj2zjJ0SuJ+YBLebG52043WMM/W0BlG+Kj+n8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYbsuj8d; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYbsuj8d"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52f83889a93so10794121cf.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 04:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788348167; cv=none;
        d=google.com; s=arc-20260327;
        b=UAwcMKsu+fk39NbKhYC3Sgenoh2MgSJNlLsw2DPj0MmUBodWgyc1aGj2wJZdPqE75T
         gFSqdQPxlCLYJsqKpmLwynKYnkxNPpyC1h50zc0iRjVv6vQRPPpusy5gX0m4lQ6cTuyS
         7FAVnbhxzh+G6Vcn9a83op2NW2rdLar/8k+Y+nBCfRUPpqhXc5dbdme6SfN/1WysVuNF
         QIZl8a/aUrE1rDB620n0xwLuDmB8gab/yZ01KwMUwadn0FtHQKMRRPL4cy5p7obqyZL1
         9g6FnLaU1rcaAaUknywGDUbXNgnobAuC1pi5pobVblFM3v4Zsn0ltAVyT93D/V/KpxaE
         nCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUk+l7F1x73TBUXiddcj9QUykpfhsH7j1MvfaQsWcfY=;
        fh=NR3i8Pqmcg9wX1Ej50FMiURb9a8nSdaOVpfs5v6cEww=;
        b=GJ/eo6DRGBD20yAktaPsFoAaSph/T91ty6lwK2Sori3IIOMKr0FS7LJ2jQnNyippZN
         PoLcRSft3lh3Xpt0cCpfPnjztY3jaKA2968BznjXh/bKBsjaRO3AHvXJ9qLgaLbfkvUX
         fufjw3cL3QxQPuvm/Hce/QzTx03iMBwjK7uINdP7ZGylD1tDNc/rtSnJX9U/4YcYEcgq
         7VFRIjQcF5j3s0e1mg5JyjblSK90D4a/qOZVnQfeCMJ9kSmwzGNiQBdfYIlPXl8JeXp/
         LXR5H6fin/jB6KTzFAR74bdhRRHOFgPve98WvNEF3mFhIMy3u8rXdin0//DR6Qc2RUMP
         KIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788348167; x=1788952967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUk+l7F1x73TBUXiddcj9QUykpfhsH7j1MvfaQsWcfY=;
        b=dYbsuj8dCzOcVb/l/24mqP7FVkQvchcWBCWJhuv+3RN0ujnEJx2Hy46DkOVBa+thqZ
         SRdOp/h4c1HCBYvmL6OhNzqTznGBZ9s4u3L4FD8EvdYjE/5mw/pl33bXywjMEo1y7dbP
         yUi6Nrmz6HwWbLi3V6ZJVY3QHPLYEwc2j9aFjliyEIcg/Y7yyYrZF1Ltnr9IT+J8/f/W
         SYyubgdirSHUHJRfmcUZGD53z+bz0EMELLL0MuNW+AqFSlMYfdKvHStdzaxvQg8VI2RT
         SGZBO9SnSb2DyclOi9mPv7dIW7zBa7cam/Z3j/R7rIbBFKvVtsQaQ5ljOYO3mLA+YmJz
         Or8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348167; x=1788952967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUk+l7F1x73TBUXiddcj9QUykpfhsH7j1MvfaQsWcfY=;
        b=RzcjnVYC/m7kbzH47vOPe9R+Zy+iothbWH5VhBslszsA524UtyScl+FvpLDiQTdhwb
         hIaTKLhZepS2EG00UHYE6KJtsB+2p7SDoIEVTCT4W0hYTxYvRTRDecYgdDu3y73HX8iH
         JnDruLHn3vEDSbijogdnnjIz5yy3dqCCVtgu8zoBzyMjX3IguzAQF+hUfqkaghNhUu23
         W/myiyW6JAck1Z9F2rHRYJ5ET+gBKf9zteyPnokQYd1v05+Bxy0qH1OO5C7C6sM1o6wF
         yYoPTZ8jA/IJKRa+CoCZ+1F6G88seJji6oyL4xzLjFI8U2OowSdYWVMp8mZqT/xKj3js
         OGAQ==
X-Forwarded-Encrypted: i=1; AHgh+RppizOA+d6YFl2Cgxy9r2wqn2C5lqeqAzaNJyBb2vN17x+erNWGNaI48k8mjP+lmHDv12+m+hE=@vger.kernel.org
X-Gm-Message-State: AFuF++lenj4t+LfrSIy3dK0ITd/Gjivp09K8iaM3R8HH22Ky6NupDkb+
	PwuNSiVroNjmrXPDQhQlNExfgX5DvoRCJknbeBrmoVy2RCvoibjF4vKSJBlee75ew/pdHjRmXjd
	jde7MlpKE51QCTsQzKw67ZrCNu4TPtJOyDgBfqeN4
X-Gm-Gg: AR+sD13/qDdkoA95Py+x41xvjLpVj3ngli8RYMrgG63ML2VgabKImgKR3BIPiQPpe16
	Un+7P6QZnNMOWWDOPnt1ZAWo6tkyt7XGtDucCn0fbeOA3aK32DTTJmExKoNdfDUuKOhGnMfb1O8
	0ntqNZQONYiVmD4mXqv1F2rbr1HRMSwbuADEh5L9/WKJAEHG0fCgGomF/oe8jQ9XU7eQM0IPK72
	vWowj3V3ksh598AYyCzz73crZjfTf3uxqSLQR/7ktaohvAeuOhATyNsre1hB9UrBYg8r2kkuQ6h
	GNuPxWsb7abk5V0CRiceM+9uRYHzGsxAQWMTc7+My67UeColDpxLD0CgYcD/hoUP59gGxIiIqa+
	VGwGIUxpDQFJjdYkHoO/nDiNrv0wdJZ5D4eeO8NbkDT5GtRGXpgv7hqId0Q==
X-Received: by 2002:a05:622a:4014:b0:52e:8ef:5960 with SMTP id
 d75a77b69052e-53036d1745cmr47815971cf.33.1788348166577; Wed, 02 Sep 2026
 04:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 13:22:35 +0200
X-Gm-Features: AcwNN1XtrN_vRmmLotA05NPV2nZoREgdYIiTjejMqXkeMTeXnJS8hCfHR5m_YAA
Message-ID: <CANn89iLX4Rw6NhxwN+NT5OLMTUDmqUiaAWC5KHS9PL9tmQSykQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net: remove skb mac_header assumptions in
 TX paths (I)
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:33=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In the transmit path, network drivers should not assume that
> skb->mac_header has been set.
>
> In the TX path, skb->data points to the start of the L2 header. Using
> eth_hdr(skb) or vlan_eth_hdr(skb) when mac_header is unset reads from
> skb->head + (u16)~0, leading to out-of-bounds reads (flagged by KASAN)
> or triggering DEBUG_NET warnings.
>
> Commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
> macvlan_broadcast()") introduced skb_eth_hdr() (and later commit
> 1f5020acb33f ("net: vlan: introduce skb_vlan_eth_hdr()")) to safely
> access L2 headers in TX paths via skb->data without needing to call
> skb_reset_mac_header().
>
> This series converts the first batch of 10 network drivers and virtual
> devices to use skb_eth_hdr(), skb_vlan_eth_hdr(), and
> skb_checksum_start_offset() in their TX paths, and removes now redundant
> skb_reset_mac_header() calls.
>
> When all drivers are converted, we will remove skb_reset_mac_header()
> from our TX fast paths.

AI-reviews have killed the notion of patch series.

I will send stand alone patches, to avoid 10+ versions ;)

pw-bot: cr
