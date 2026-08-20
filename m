Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F914195A1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223447; cv=pass; b=nmepCwk3rOmJz6RgNicHxpVXcieiZi8vztqnzuiI7MuBQQJ+VJ+FZV53xE30UQcaTkSj4mUURPrFY2lMNDmQuzUGJ8m9hkwEoAJrFIQm8C/DT5ohnYc4Fx4o0URnVRmAj2UVd+HBi5d624dQF3utDiKXD8Rwmdy+p9GDTVdz/xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223447; c=relaxed/simple;
	bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8E5NMNjEy42///z1/zX3ZsIID7e5aov6iDU/95LYrpTtxGkRoXhoHl60+cxC9Ong7CzJbh7CpyNICHoljUwbiJtABHJWw+PFq8lcnpAhTBUg5NalEGbGHb+z1vU8BjbKql8VG6OsQU4bMvdDJ7Lj2J9vH0othqwJqBTtVL+ljs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vH+PWZ4k; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vH+PWZ4k"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f72317a6so123222885a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787223444; cv=none;
        d=google.com; s=arc-20260327;
        b=mqIzwJR8NZppGTMHrSAKm1fBfG2BlAjRnv+HONPQQMu3X5sSrDJ0PYfUFbB6+jqvLn
         VHeu3tD2oVCdvht2gzE5rNf4JBDz94/2xLao3XibHXWCfHHfHM9QKR1WwpYp6jUJfiey
         ljOuGH8tAXgwr5CZN+YkvW/GFqIGc/lAnMB52OKtRLN089eq4d5u9tRkp4l5InDutdx3
         QnLPApIBwPPkXMg0sSefgIctv64DPnbOYJZ2YjAC5+zu9bBbBzzITQOay60ZEmxTGKzr
         oVUGSKWHUA6/lztEq/EBOMUOAM9R+pIWJgOQAdy/xqhENWCdXR0UjEXc3fRS0ZyAcCY1
         t+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        fh=5wV6wW3fOm5LTIufyMqwX0c+RZfCNcXVLcksWwYX0GM=;
        b=R6JLeROW8KIpKL/LKsJsRRfVFgbn58HcTdVlm9lQ6HOCJAeEsVV8hbl8/Nmn87rWot
         AL1JTemdGSS67j1rkPgZb1d9yVIlmnTsBQX2u3iUenzpbUB+8Yu6pUpmODepf5wLnVwL
         Ko9nDjZkoKdE5XFkUQaI3MmR5zDmcFC+j8FXtw7O0g9sGRwJ4dBhEwqYYc80T7SR2Zxr
         TfRJPgOdULSVlZRWKuJxislIGLAwTRpAdTMHy6mc5haw9UBYq8bxq3Cg7ulRSymQxMFe
         ekKhtOsDt+3uzBnXE+U/ZfjD6K7a02T+P+OdZkxDCp02VGjZ6eMG+UCrPdPaLi5UN7Pl
         8bKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787223444; x=1787828244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        b=vH+PWZ4kRaCk7q+/hoUeJPvKKLzE9mCR/GBiwYww1gvDQuQNSm4o3JABuI6JK/3fOg
         e9famN5/r17Dzglyxh57XsMbPhnYJag3eY+0EmkODlC/YPs5hbRf4WU+QVV5epNu79jl
         lfdKu4p7v2OGld7/A+GszvGy/1o9rR45TTFXC8GKzFYOUhHhg2EYfqBk5cXyLR9W35S1
         pHtjqs8wOwtr7Z9lPeREIEhwR2wdgjb0fkpWRvHw0SHxkyqDbYq350LefO/tdvZFBlnY
         hHUiatk99FC2Dh3hWqI7R0zs4sxTOZ81FBHcqDzhq82VxDhQM9Mx4NkhccH//Kro6oIr
         qq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787223444; x=1787828244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jYtyylx2W7dLCyVBh5w5flbhCU/+JBjP9aGJBwO6Iw=;
        b=J/yJJhYiUapbSqj59pVg0I+yurvByrjKC9C7InBLtEXI/38lE/+WVpAh5kdAucYYrf
         EmwMC34vw2iw7S/t3aQV/u85iA2Iw27h3VF/7JiNtemgVVecnPhscgBrSRUncAYliFFz
         SM0O1yPYuTg8fsEPTbL8ysiYvsFTQhYYCJDDkE1EV8HZHU2nGwVAwlm67F6hJPsZcpP9
         WUaNvHiSUYU5ujntQvBjKBU0AKf3Pw4ZoFHAgNbeB5yPC3905AlysocIA+CE2laMvN0+
         tJ1DlSKW/s0XwBU/ViR5e8BYHmJ+lj9GikkoG9bWpmwW88XmttaQwlDyij4k4Q2yDz2d
         ce9Q==
X-Gm-Message-State: AOJu0YxCNjM51Q5NuflSTN+RZfER9mGsOL15yf8/YrBeJoC7NBCBvZtX
	4rjFc8fOaJVXXggjDRI0Ps5h0gImscsSeB5PQBZWxUSuW0RS1GPuqRK7/MVxiSjbYbkpBUNaJMX
	ry6wBfaNTzh7GkYcKTI2Tpl1OB5mQ4V1up0i6+tk/
X-Gm-Gg: AR+sD13wDlnKmaPZ7+ZOc06MGeNFQ4bqWfYbkN/2ATBgmvfNXg06lk4T8jeF591IhFX
	cuavSZuhBlFFt2EBI0cxWMNkxcZg3bN4W3As63UYBwsXIUVgPc/ew95C8su+KGcvJVryOw/Zsfu
	YQQt2im0ZMJAToskvg4z3vImjugvS8g6lGvSWXql26T16J5L8AIlQNBNlKM3ZcXS9Fkxaj5+GeD
	1hSnoLpd71E6W/0e0CIOgahfGb0lEncveGUfCCQl3tXXzdJOrCUykKhSk5b/kOgf1WNIuNSo8hV
	uHTQPrwspdA2H18rbALc+iZ2oYe7oliTro68DxHIgArpYpmv2OrtZ2pfrl1F4EPIvAq5d+nooX1
	2KDTxVxqvoupEZoBvpFA760XQCbYV3qUI2KCjRqjn612xTlskiOuySDKh2w==
X-Received: by 2002:a05:620a:468e:b0:930:9091:f0ce with SMTP id
 af79cd13be357-9371e302067mr1049789885a.22.1787223443592; Thu, 20 Aug 2026
 03:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815070413.294559-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260815070413.294559-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 12:57:11 +0200
X-Gm-Features: AcwNN1V-lDNNVkCSZufLYHUNnmdNTo3thCvZLBu1IvrTsUJT8e265xO6leh8BHk
Message-ID: <CANn89iJ7hfewnOEjD5SSf_3n3iSQAHN8TPspBCyp_Pvy-ibbYw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: advertise TCP MSS from the configured
 MTU, not the learned PMTU
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 9:04=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The MSS a host puts in its SYN tells the peer how big a segment it may
> send us. Right now we can shrink it with a PMTU we learned on our own
> send path, which is the wrong direction entirely.
>
> On asymmetric paths this bites - think DSR load balancers, where the
> request side goes through a smaller-MTU overlay. We learn a small PMTU
> going out, then advertise a small MSS, and the peer stays capped for the
> whole connection even though its path back to us is wide. MSS only shows
> up in the SYN and never grows back.
>
> On symmetric paths we lose nothing by dropping it either: the peer runs
> its own PMTU discovery and usually already knows the real path MTU.
>
> So work out the advertised MSS from the configured route or device MTU
> and ignore the learned PMTU. Our send side is unchanged, still clamped by
> tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
> and use them from the two default_advmss() paths.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 164a5e7ad531 ("ipv4: ipv4_default_advmss() should use route mtu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
