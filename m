Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A262DB7B9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765870; cv=pass; b=g9BKuIEAcwgC8EZrhCFjqwZLKdfX0LLkVEdcxN7FSdTmfIZIy1P10Ne86VETBY7ACJsH9QIcFB0thFDsJ6b7Ch4LjZ2EKEZ8AF21J1ZGyxcjm2Cjzc57bnwPeahYi5bxw8jfa7QV8G26LiGGdt8p7WxBp65ARy+rvfPnh2g7518=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765870; c=relaxed/simple;
	bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAck0xyuH9UaMz1zeZ82ZchHSTmJ0YP5m00M4+40n8RBh1gH3+E1iZYMCAG0+p+TADhT2dAkdrysDIEq5ZYiFdyRAYtpdGYmxwRKXWbc1hr6oIYftNTCtrmhYx8K6fij5Sbti4ZOu+Kqe5gRQHJVODQ4txo8bQRtZs0zVQHOre8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ZiJ5Iz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4Uvh9Kh; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ZiJ5Iz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4Uvh9Kh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788765868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
	b=S8ZiJ5IzRswZcAlOTqhqSg8tZTG1pVm4aNsPGvgcg92Fj6H/mjYX75htO4w9cZWz6/rueM
	J+Pt5DaG4gXkI47eWEugo5Rny+0+IVyyKcLuOpXOU3YQHfb2UeZ6e4JfqFiSwOoZrllVub
	+dG8ov1Jgf97752WqpWRCpPEn3PWpuQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-O7uqsJKKNTec1Rfr8HyRLg-1; Mon, 07 Sep 2026 03:24:27 -0400
X-MC-Unique: O7uqsJKKNTec1Rfr8HyRLg-1
X-Mimecast-MFC-AGG-ID: O7uqsJKKNTec1Rfr8HyRLg_1788765866
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b60bfcb6fcso1784400e87.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765866; cv=none;
        d=google.com; s=arc-20260327;
        b=X2adoymZRwHVpraA3V5PtjanPZ9EyBje3LpvRYiYQs/kWP8N/p7RO9dx1qzABNPlwO
         FRtfDxVbNgJmK2YburIwKJBgntfki7RS2mqk+37irJoh/54gcDVxe0FErIWJdg0wOIuK
         6+JLGeMDYcq/ho3g239/4gJJOAiREmZj8A1eznQQ68wR5YLDlWIlPc1YiwPa0Go7K0SC
         IKR5UMwSyoLDNe3iSfBjC8U1MvXpbySf96YvbYn05YLzX5xeJgG6k2wAebSDTLaqs0vG
         FS2rIyXqS3Q7Hal9X613fLK/5Od32AZ05xTTfDmvXgZ4Ww16BEmlAfwhjpg8uiVAoIJ0
         ci9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        fh=6R6jhkgs+iurWw/vPXJtV4d9bc/IizmxwblooULe2BE=;
        b=EMZVJtcnqWxDWJY/PqQSbJ589PzKmjONO8Nc4TqQD0UTYfRJkfC3UwJccg1ETMokmX
         q7koG0OBzINOP8RF43Jf2Sw1g6StMVFwuNHwsTDYMQNlgGHJTuvXzLCmOVW4c4gYWDub
         eRcwJJCvGbxzGhoW6aZ3U7rZYSA1j/DbzvTu8VrRVN49QIH7RV8uu5SzVfnSM/h7JfyQ
         IpG6YaV/wgbgX42oEyoswhiJ3a7s1B0N6dPwLnYy6x9vJoi6oDI51ruj62WWnqDE6+Gx
         YVXzg8fRi4XQgL7gBO+nb+BibCmksXgp1QGgt/z5kQPJpDuB0ZqKyZu2vDPJRdb2Ee4g
         CmEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788765866; x=1789370666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        b=B4Uvh9Kh038DoTB9gEMhPTq75k2pfy56Vh0rJgVZ914d3OJux9BdPQdPtLi9p4A0EL
         jHGN1rXi5iABqzb2dKM7HlbsASwafFzIl2UxW6/wYXe/MUcAz4wRHzI8X+Vp85oiXjPC
         oE1QHAKd2rmNwHqMT7K2TGix/eJmCbKAHYJn21tgaBs2uPScY+5pcYN4z5bm6noyzrF4
         lPSzIMP+3C3Wdr9Lk4ZQa5ayx85Jzw/vpeN514kUZn6VzyTbY7KoGw1m7fzKBDDxCNsj
         Lj5etN2/Ks74jHdzULam1Bz3jeBo8eBeUlepKaC9AcnQznMy+jbtrB8x2wzwes+pJJ/9
         eiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765866; x=1789370666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yE2vKhYco15cq1LAqgS54dJAg4li6tJCb9pHzWm1p8=;
        b=qEWTxapc8IataJzCsN2OIQh0DHjC99vGDEnc26uqTOc/LmIL98wPj0RA4DDcAJfSMh
         xARmW2MCY2bUjkwXkuQijO796onOZihdkLUCYORlc3U/+6vjNnmw2BpV08J+Ejo0sYA8
         GHfxHqcvpvSLjqgXRo0J9rLGa8hMDTH5mNg4RAo1xQ950vNdOejp3jzgprzxjLvoZpIw
         pGN2siMIrSYRlfAwseNN8OWVG4voJqR94koFVlVlDkqOeMMBvvxNIzkJwS39m6ze5XWW
         J+lszK9v1YMErzRyEgNprmLT00u1Fd+VYyf1Z/sk8q+itxdYRLNtWIzb8uhPaiq9vHEi
         PkFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcw/76TxO3KJZbX1lVXM2QDWojjwFM2Rg/f6GD16uZBaF+Up3bb/LEP9O2v6nZ9Nl+rd2VAfA=@vger.kernel.org
X-Gm-Message-State: AFuF++lXZbLqVTcypAvKGU06UM6CGJkp30WXZzmk0Bdx90ApIOq5vEm3
	+JY73aZnCPqiH7EQMfSbziR666GU54UNnRPEwgqCJhG0QJoa/Vg4shYO80xS2YFUcWMN9KtgQzM
	gEie/oBbMmM3ILqxbJj1vQqb3+Bty4MQhf6FWevBy3QYJg9qG3nKbTETagb7t9ysGa/3LBqMN1D
	2GT5HelzpxBY/+Zurg8GjrUx/o1O17lHa4
X-Gm-Gg: AYBFou0zU0XHTD97B/Gj/2o21DrLL7X4+Y0Nmmnb1J96LtecLJdCQxQjaGCj4NfeWeL
	4FbQUR+KwLYfm2OqUBHHWuVxT8sTicBJwkZW4C8u2eUG4iuai1HXeHQv4S2mn6+sX7rc0iyMQx/
	vMOy1g2RIyLc2YWAxVtMOU7vU7Gp7CGm1pX1KG2CWKhHvzDjcjys3yETil
X-Received: by 2002:a05:6512:3f0e:b0:5b5:e86f:3550 with SMTP id 2adb3069b0e04-5b616eed114mr3346327e87.9.1788765865564;
        Mon, 07 Sep 2026 00:24:25 -0700 (PDT)
X-Received: by 2002:a05:6512:3f0e:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b616eed114mr3346309e87.9.1788765865162; Mon, 07 Sep 2026
 00:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903121057.80006-1-ihuguet@riseup.net> <20260903145631.GA182962@shredder>
In-Reply-To: <20260903145631.GA182962@shredder>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Mon, 7 Sep 2026 09:24:13 +0200
X-Gm-Features: AcwNN1VwMZKu46IzJzKROmEYRy2rjJetX0BeFnxsi74O5FJcBryBFl6vpHj-5Dg
Message-ID: <CACT4oufRecaPSMTJPK3yJurmaEaMN5i_CArV-mHd=rAA4zOJEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/ipv6: don't route packets with unknown source address
To: Ido Schimmel <idosch@nvidia.com>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, dcaratti@redhat.com, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Phil Sutter <phil@nwl.cc>, 
	Daniel Borkmann <daniel@iogearbox.net>, Junseo Lim <zirajs7@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Leon Hwang <leon.hwang@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Qi Tang <tpluszz77@gmail.com>, Joe Damato <joe@dama.to>, 
	Breno Leitao <leitao@debian.org>, Li RongQing <lirongqing@baidu.com>, 
	"open list:VRF" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:57=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
> 1. This is a behavior change, not a bug fix, and should be targeted at
> net-next without a Fixes tag.

I see it as a bug. If you remove an address or its valid_lft expires,
the expectation is that it's not used any more. Anyway, even if we
consider it a bug, it's certainly not urgent, so it's OK for me to
send it to net-next instead.

> 2. What is the motivation for this drastic change beyond RFC conformance
> and parity with IPv4? IMO, these two are not a good enough reason to
> make such a change with a huge blast radius.

IMHO conforming to RFCs is always a strong reason. But beyond that, I
think that the current behavior is wrong because, as I've said above,
keeping using an address that has been removed or expired is not OK.

It's true that it's difficult to spot all the corner cases that may be
affected by the changes, so the tradeoff of fixing vs risk of
regressions is not that clear, I understand it.

> 3. See [1] for a list of regressions that AI flagged. Even if v3 fixes
> all of them (which means a much bigger diff), I don't think such a
> change will be merged without a proper real-world motivation beyond RFC
> conformance and IPv4 parity.

I will try to address all of them; thanks.

About the real-world motivation: this comes from a customer's bug
report, who is worried about packet leaks in their production
environment. I mentioned IPv4 parity and RFC compliance because I
thought that without those arguments it would be very difficult for
the patch to be accepted.


On Fri, Sep 4, 2026 at 12:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> breaks a bunch of selftests, too, FWIW
> Please make sure to mend those if you want to forge ahead as a non-fix

Sure!


On Fri, Sep 4, 2026 at 12:22=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
> Just in case, do not hesitate to look at the new countainers that might
> help you running those tests locally:

I didn't know about this, thank you!

--=20
=C3=8D=C3=B1igo Huguet

