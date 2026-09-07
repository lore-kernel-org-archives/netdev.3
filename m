Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56435E94F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786388; cv=pass; b=YhpnUZ2gBhH1glZXq2ytz2Cy2cOuZdKjhoQH3SwACLR5bP/IEHCMqZtj5BmSqnqJvS+nL/24Qwn7NAtHxrRTO0SoewlEFUW1dckasBt+45HzFiiICUb+O5Ev2yGb60vIROj1O5LwIG19ce1l19lzKm4LVmF0KhdVa8EFZdc33v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786388; c=relaxed/simple;
	bh=DBoU8TweSyD/7RD+ZaEnPRK+Ih4H1pHDIj2amrrd4IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwfyOoRZZlLWZizZd+ba4k/E4yhV4Poim95NqO+vbor6N6MQmK4rgVe0N92ETXLiEvbPNRUegkCyGjpGouP4OWWmFiffYqYnD0XadLbspaK3Rbalau3d75vjwsmlUCcpilYGk8WrDdEgmiqVw+q0chM2YqrwEiNDW3pyJ7sYFfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6YulM5c; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6YulM5c"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836c4474028so31350217b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788786383; cv=none;
        d=google.com; s=arc-20260327;
        b=o41/xIeIMrZAoPR97SsK5G1iAIvSI3zkrqQAvR8sloCQ7EZa9WdEbjHsx0k7Bjld/f
         dAbF6MivCDTM1Pl1m+hpU06a9Qj6wR9xeP8iup5k1gUrmpe4bhDUBmUx78GU3nY7r7Yp
         CLiICrvd52ZTapsUqKXKDsNiOPfdn6y0d+iUDPpfb2k8z6W89j8iHgL2ghkcBOJPovNg
         IzCJrZBt5p4zYKaMOneIeDF4oyPtzine+gWNOZaiNu4eXtNwM7IT5+Q3RG5gNLjk0JRL
         sHlk1n3EiwAf10xVahdlBupHDC/9p5XpGSMWDkJcnMlJu9xclVPPK4FWpJgDOm+Gsz+F
         q2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBoU8TweSyD/7RD+ZaEnPRK+Ih4H1pHDIj2amrrd4IE=;
        fh=hRoEvc1ghJx0ATTdUQ3VXLzPcN2I/fWTKg+YP3eg0kU=;
        b=k85dCVwfaL/uMcRMRRuDS9/gvjiUk+5pisE83bKGCwoYaL6kEUAwUPGqh+6xNR9kZr
         Aaj5FdqGBilH9hoB2o/zMgpLHcD+STYZ572n8B0hxRVry/2dToc+G+LuDDroGjRqcALm
         n+O3LzKBy/cIwY3lCgIXFdNYFKZqinC5LEjEBbGOgOn8ub3Hh/p20g7/JfEN5BEIqiMW
         FqatiUq8VMpT892iosq1kkregRzdvJ6MV1Up3PRejEnFwVur46QHThKQ8QtqqkQa6VXF
         1ovoKCaoEd5FBToEB8QQsC7VzxbPHM4tFAF92Fq1FBFPbDZbDzxGK9TSBftX099wB6NY
         8SOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788786383; x=1789391183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DBoU8TweSyD/7RD+ZaEnPRK+Ih4H1pHDIj2amrrd4IE=;
        b=R6YulM5cw7ocgcw1SQiTdvDZ7ooUvwZtt2EyqOSDI68qxirNjuQagAzTnPNF4IXUc2
         2trhFFdTf8aBuycuCnslFB3bSAjGNyWLTPsOwULIvoC1L12rNYosvr5OdWRcBfhqgV/Q
         xmXWejb0t86CFN3NdvOJWMwYGiMQNgBpCEawgTWCpe0yj7GqhvsdXbBWqw9j4dbJx8CI
         4rm2WsokCNyh5MM3FUMSmFlDe+l/TOTvJ7jvi1hQtgFiZTIqd2wlASZ060tns6+NAYFA
         vooy0COoA9nX1pAMnOuI0ZqxrIsA9Lm9++DEtFgGw5L/Ct8y8a8zXCDfW3QoqMWI2FAF
         PCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786383; x=1789391183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBoU8TweSyD/7RD+ZaEnPRK+Ih4H1pHDIj2amrrd4IE=;
        b=PYGjSqRcgIoveqU09MKI6zUA7mSo28JmonQAly+XdIZcu7OWGYP4U0mbzXsmMOblxo
         HkBfRIH+uzbUIECF/a90PLVs7STqvxdqTfdfisZzChiONxLFBc/xHoLEvnsoSc1UTkQz
         K5iBvqr+j+Ypdc3Nm099158Qh3wS0OQP586S2gBEw+Ncy/HcUv/83O9XLV8+Qe5mVEgA
         AoL2qMhxbjxJKa8oOBkgsclIHvTHCt8St9ggY1XCYaiio9To3czOOzvjCMGibixdiMoS
         vrxhjCKld52xA81Q9wlYLW6ZjrvxHn9Q4kBFRltWhmxv5/d9GMamfhqlYQwJF8nI8t4U
         sUVw==
X-Gm-Message-State: AFuF++m9rw1fu47oOAQ99KsUhnlrakgiKRrDEWjB1o7dphLS7HpfjEx2
	UjsCJTb5VQZypp+K8tylhkuRLNfUmYpPF+dFkDEBuxnZaatLHbk9gFC4+APDsgy815MQncoKqUa
	jeQYM+1I96WWqI/SAlJsqsB3Lq4VgrBpBQmnK89a+
X-Gm-Gg: AYBFou0fqzajHAwfj/9HvCrCQxxUOhC+Zb6uJw6Lb+O0j7W59g0KlAH1VVPolvyfQIz
	qkxu30506ehaUzGx6PIi6GxcxLpZXIDMAIaIfgVyHtLa5p/56sULjFW9mDWR2IgPfneqSVxWypR
	MF98prOod4MqOhub/TX0oo4fUPeVLhK6tY2p0Z70KwFDjPgKdbebfc4jZfF5bbHCs01onw1jRXo
	pE3dTzi2NDCUP4cDAKB5WMcV48ll4jW3AzRgaMbbNg0kTq2zT7qsSvgrd7xulKe/mACVdRy6gh5
	884y4pEFr2ane1BTGmVAqyy3OK7B0F9pJFYjLh66pnFEd2rghbo6a1SVm0TM6DeLcnU0JHLxPi6
	8QQbWcvBjCsBQJFNXmT+DYGT3MRyD9hGEPxwKiMUeJsGfAlMekT+pB9kFkA==
X-Received: by 2002:a05:690c:5806:b0:86f:b460:1d34 with SMTP id
 00721157ae682-8712800f98emr63760157b3.28.1788786381959; Mon, 07 Sep 2026
 06:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907101358.596953-1-idosch@nvidia.com>
In-Reply-To: <20260907101358.596953-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 15:06:10 +0200
X-Gm-Features: AcwNN1UI38d-FxzlcQraHkDF6B3oO20PBmJW-dpUdXeYtX7XeaL2OeFDvorEBJ0
Message-ID: <CANn89iLhAgD3dRdMHZdsOam2cQinXqf1p12PHXiaDk_GTenvFA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: udp: Use ip6_sk_redirect() for tunnel sockets
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 12:15=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> After commit cd51b74bdd0b ("ipv6: Fix redirect exception creation for
> UDP/RAW sockets") the two redirect calls are now equivalent and there is
> no need to specifically call ip6_redirect() for tunnel sockets. Simplify
> and call ip6_sk_redirect() for both tunnel sockets and regular sockets.
>
> Note that for ICMPv6 Redirect Message packets the VRF driver does not
> reset skb->dev to the VRF device, so skb->dev->ifindex is equivalent to
> inet6_iif(skb), even when the packet was received from a VRF port.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Great, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
