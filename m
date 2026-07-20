Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BA3BFAD9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532612; cv=pass; b=dNF5jjW7Jp/UzjbYA/VvHoByYaAXTfC+IE2w3/vgehW2xkm5hlQSFnOLvbgZyyjwogd4Bl1IhfDEMpynD9vNZhd3T7WIZoJI9beCyEwmXmN3uX4aoF8hO6a19rVsJaoy9hJ2WQh8N0VHhFzbFMs+UsGf0P1/l7KttieeOJm1zos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532612; c=relaxed/simple;
	bh=SUnJyGK0LfiMqfDu/G7zvyDLMzPtPgXYEUSdYIWDewE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPanH1cq4Rjqiovffw3z3GIH9nXGIF7++pCxHO3+VSPOf7Ur1NFoCZBUFNblfYmjZWjKNSkSf3zZxpEtAb+TxlrO0MVAPQItvc63Da1NZ2f5WohInvhjErNAniNy9/7mP2hPf7CD71ZE8sW5C0jlM4SGUVKjJDc7ouGrie0okK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQSjJOrS; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQSjJOrS"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5218927884fso35818241cf.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 00:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784532610; cv=none;
        d=google.com; s=arc-20260327;
        b=WwD/xO/oMcKGe4xCmz3uKgncDDO7c1aqe391pURQKb9ImIbVRDzp/S16mCOjUgGXi8
         4MbPDDRZJ0wsz6hrZ7felvQbXV6In3PBSsibC6fTY0bpSKkGHtF1W97WHsVcq3Z7aKOJ
         4YLqk1iyt5aYNepKOU6eL55mmoQ1aaJ8a5ZpJYI5D+y636pqJ10wqCZc2tE2Hxdk+B77
         68xCB49vV/vAYnS/nBtRPKdsWgsFvBUZGNsD3UrcIp/s2TPPXvFjTA68YeTk6hBGdazq
         hbwLxvWENatzzEo6iQ10hLcOGiy6oBb33xS1NfFPriOx6W8D4xUybmK9Qhn1/JDs8k5R
         HD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SUnJyGK0LfiMqfDu/G7zvyDLMzPtPgXYEUSdYIWDewE=;
        fh=ZwmqKBFES6wWTcnoTuoOiiXwFVmEUiGwu/NC1qS2JCQ=;
        b=kfUnIy3LNbgBMR/S94e0CX2NiVoVq3+4EEqjCfSAgqkzKrdcODiKQt3y9NBcXlkF1Q
         TS1vwIhZSIykyT2/OXaSSubkL9sQ+SQJIDD6hUc7IfPEOPG/ywKYPPd+sAsjtnLYSKJB
         Afv6SfDIKmSgn4QRc1B+jcEQxRacXKKYZj3frNk4RcbWns1tTFOytQY+Q2ECfShVb4gD
         gWDNSew64mbfyoDfpy0VSA5xn3lx1Y34F0ycR50VaDMaSzAe46WBOF6C9P7oj3T3pqTL
         FuHskwaBL+Fr1GgcmFe1gqbtUUdVZHviZcj9Ywf5vmW+Ow55SsB6flpNkhtU0gQG8VzB
         DBxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784532610; x=1785137410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUnJyGK0LfiMqfDu/G7zvyDLMzPtPgXYEUSdYIWDewE=;
        b=pQSjJOrS1lS3i37Yqfl58y/Qz0a7js2iO4SkD1ff1alU7KcZqaLkyC7watmWnrnwH/
         kN5MUJrR73gz9+4XGwwvjVwNcXjjrvi75UW8xzysPjeV/YKN429ET0tjpGXcYTcrfSrQ
         ib/heCOm4TMlxX6N4rBahTgB0i0VuQzK9wnUvTtLH3dsHwZ1Wd9GKCNh92qVfm5GiIa+
         XVnXMzfBRoflpjvFWxmp0I1Bb4zROCe1y9KFEC8+r0s4JGQkZ2ca2Gu+2fwwG0DJzVho
         uzGgPgXuhV6kXo0WK2xC9Lc7hgJvAkJ4ZFZeiSkUkNG1uPjZn0uQSLIyQnUbw9e42ncg
         j8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532610; x=1785137410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUnJyGK0LfiMqfDu/G7zvyDLMzPtPgXYEUSdYIWDewE=;
        b=KgyixsPajEV2DmECrptSvYVP65mIOqiIXQbb+Gf/fEe6VH4qbYycup3MD+cyAY34Mx
         brihRnKfKWSf8ExCsJHemAdxlZZ9F9/hWD/fojT9TiEvqOLGxU29/aw/5Gxhu6eMtkkc
         VUV/7b2wl8khciwjWq6Kvlwb81xXXk9NYPKSDBmPgwiGn2Pnyort/atTm7e6F8eNUtZf
         IXHcLUR7sej/RYuqvB1xoPjCAIk2nl3oMxIhzMChzzJzZ5Be2VFmP4exWmFz6KDgI/S4
         nVnGmOuNzC+BZ/E/6bPEBpZFLQXtdo/2d1C6l+1hvTA2pn0xjg62aMhKpL2uFKc2/Ue+
         1U5g==
X-Forwarded-Encrypted: i=1; AHgh+RoyWvD1IoBuXo0aI9MWFYK7fR6dlFVmg+JUFAYE/4RG7kdHjVU50gf/5LWRGib2KTJviiy8/fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzR+OXxuMymPKeh6kZYj/q/Y8JWn3UupW1ZqFZvL2tV5sbHQkz
	yimsTwt75OLedMxiOZqfGRU+Fqi6rPod1nv0IFb/OVUdFG6SAjyQUGwJl97ZsqTwY90tKEIHtcy
	dSbODhatkThZjQ1s8jZaqP6OBvw+RnLExnHfHBQOP
X-Gm-Gg: AfdE7ckj4239hgTW4NsoNdEnXSmPp64eggTsvCn8ZUSG8qevzaTKLZ6C3j8/cdyEVuX
	bh+JUGOzMOj1YOXcp10sBA+2WSCkDy0vrVoLwamOs8Bj3J/ebHY/u7LE9yTSHrjWsW4Ep0zYV6c
	vIIk4nm76ZXxR5FQdxdIl/VK2aZbd5RSYaRPcw7adGDB+LiPWaNh5hv7bRaiwWX2hVef1OdVX3s
	Ra0e39RhlL4ouYcCJ4Xgb7I5B+60kzzvFJBv+EY3zs2ZOupTFKpgbXdPAU82d9fwW0lF6S3nlY1
	WZVy+tSU2WOm99CEmplQmGrBWzh1BXLysRWABuL5XDHB0L8+beTV/ADs+5clVSop2ooBQfhP0m2
	NEooGVVCsAxTyqGOPBZLvKkLJj3yzboey
X-Received: by 2002:ac8:7dc1:0:b0:51c:849b:86b with SMTP id
 d75a77b69052e-5213c7e5e5emr127224301cf.43.1784532609460; Mon, 20 Jul 2026
 00:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com>
 <CANn89i+z6ECLND1o8oD10re_zGJg73JCOr3dnV9AADeG40K=_Q@mail.gmail.com>
 <CANn89iKOb0003aqdxJw65F0_xaLOkM-45MZv+CUmQ13-NGoGOA@mail.gmail.com> <d6be3b25-3db3-491c-93d8-7e014427f380@h-partners.com>
In-Reply-To: <d6be3b25-3db3-491c-93d8-7e014427f380@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jul 2026 09:29:57 +0200
X-Gm-Features: AUfX_mxiKgW_HhGSwOvTqPfmR2LmtHkabc9g19om9eOMJjRvOWega1Iqb8xS9HE
Message-ID: <CANn89i+Oht4shHrMLGSwEL4D_gvYVwQ=JXPXcQajnaQuXpZQYQ@mail.gmail.com>
Subject: Re: [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX
 on lower device
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Fastabend <john.r.fastabend@intel.com>, 
	Jesse Gross <jesse@nicira.com>, gaoxingwang1@huawei.com, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 8:42=E2=80=AFAM xietangxin <xietangxin@h-partners.c=
om> wrote:
>
>
> Hi Eric,
>
> Thanks for the suggestion. I tested both parts of your patch locally
> and can confirm the skb_under_panic no longer reproduces.

Excellent, thanks for testing.

>
> your diff is against an older tree. After commit
> cd1c188db109 ("vlan: defer real device state propagation to netdev_work")=
,
> vlan_transfer_features() has been moved to vlan_dev.c.

Yeah, I had this patch in an old branch, I should have rebased it.

>
> Could you post a formal patch?

Sure thing : https://lore.kernel.org/netdev/20260720072622.3541873-1-edumaz=
et@google.com/T/#u
