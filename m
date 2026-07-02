Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50199275AEB
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962041; cv=pass; b=X998SBjZ2qYBcHetDj/tJUp4vPD9D+t5vVnq3mWtF0YQCWXYU8C6/h1UD/vZAo+/b0oX3lUhi2bz9QErWiKIMY2+DQhF7gBHWfmALD6qWdXeCU+4YXMLc1sdStw3EGhJBfiTmuwRVdzEgBb16m6aFpcfr8xfWE+p+VTka+Nr6LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962041; c=relaxed/simple;
	bh=kqcE9CqG2OftuXGuDXkA5cxcw3ks00WozsAX98Vk8bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgb/YblNNzeYuj/VBK4ERD4MCqZ8jN7MjJ4D9lDnsYBPPvaowgGze+IqAO+NSHkE/TtXyi3TY/qAq0pRksN9aD4XqLS2/y2tH9EwVjbSnv+DMKfcDZnbJt5QDmyIKX8Y22PPgKiSnEiC+WRat0NmQWTl/owpRSyJjrhA0YJmk7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7MBQXGU; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7MBQXGU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e7391839cso595585a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 20:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782962039; cv=none;
        d=google.com; s=arc-20260327;
        b=h5wnnkGyBHAYn0bY96ut9+s1uA10ZVM4jUQsgscWmYzr43CqpYuXYN2Ns+qLsoGTt9
         uQzF0AnGTVk49u63NXgFcm+MSkX+LcGp4Ooi7S1xZ1sPwuTI4N3isqOgoPBvEZ51EtTT
         oJ0cyuRxNUQ7jsZmDv/QHkvLZfblll988n7qTQN0tJwijQHB+kxl8Z923Ncb8f3uqJYg
         WhAaYt4yw0UBtls/QRT8/6/mEyJ7ycFzLlyE20R5yGsoglm6gjhWYu38qaGA9zT/MjU4
         funrbbp2cAZNSt4Sdn+jdXEWmn66rrP4EmIGxnZvIGLGzeoNZw69ivtD/IlFl5go8twy
         pDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqcE9CqG2OftuXGuDXkA5cxcw3ks00WozsAX98Vk8bA=;
        fh=K75ihqz6LxXK1fpDFvxg0LgjWP+qnG39pjMMTzwNijw=;
        b=hTGl3iJPfhKzCD5UZfK6BU5VGoihPJ8+b0RQp2yviJ6cL37aU9Dvsywa46nldU70xg
         MYJtaPc8qPHWKgQ+usy2mkBQHcntluKNpIwa1T7TCHSxJQHzSM4gMJVMbtdzLXQxRbkt
         XOySOD+NSfI7V2wcnGYMQSgT+O7kDqfEpZuc52lxuLyuB05aEC2QAgDiaXo6DWmNC/mA
         dzxkYs96qk9hJap8LE+T3i22usZsGJtxH5DktPxaizn/MlfFiOxvTyshqL7hqkOX+ix8
         xWkWcEq5fb4HzsYMjKx70mzCakdKaap6nsbXdNtbql/YcoQraLmRrGllRaHYpr1C76Ty
         osfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782962039; x=1783566839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqcE9CqG2OftuXGuDXkA5cxcw3ks00WozsAX98Vk8bA=;
        b=d7MBQXGUnjFPpvzM1sT/LQVnf9CxuT1jjT+6EnjiIm8n9e38cDT63KyeXKuQ708g3w
         AaP7aK5bmvS7Nal1DuNPhaZtGkwi1fdCcVk+YKL4LGRkhfO6j5JzHnu+DDhzkS8E+Y12
         UAU0666PuNPJKvQ8xYUfe3KTnHQl5+i+6Tj8VXF0FM4YY7EDCrcJSOf+D778TaQj+Ltr
         K8GTPXxbqOkQZw1/yLwhDeO3RA5wPk9vrjG0lEW06Qj2bBu48xWLljIcpRD45HJfLObB
         8djETelXXAu4mGBIPRMZPsDSlCUbpjuP9sEXDTPBgA6lqmsqaDTVedqOVO+ztktAwGTs
         RNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962039; x=1783566839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqcE9CqG2OftuXGuDXkA5cxcw3ks00WozsAX98Vk8bA=;
        b=U4Mn3VJ3Vjd8/BCHq1XzNLgzmltU/ymjGCx7B7YbeE9k5SPU1sElh0+t73wuzyeY9U
         CnwpAyJ+RkcoecELdImVxAOQebxjTmzljtpyggZwH7DD66nJfVeH541PaL5929clDF34
         /+zOUrzrw351uU955g4EjKJ0kB9JTx3qpPnG6QCJPd0pjem8pynIU/VFsfBG5Z67lv5g
         twwABxloLJA/JLNZhoAEtGBxs57ePeMR2Y1W8Zi1jnVyb8APigF+Rgql2elC5nOIznKp
         r/LmeaebArZVUPV7eYymEJH+O9GvUYQFAgjaehDhZ/tpstoyO+BFBioIx627UvytVmg2
         8y/w==
X-Forwarded-Encrypted: i=1; AFNElJ8LmuECNWxYR87XL/pNHuSRoLgoT6OjnrMlc5zaVpYTj5D0DWZtbGfwLNtGM9KO492XgC1pWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBsTYggA/iiadoOyu4QdYGnjgDNo3sW+ss7ui1n3KdF/sTCSZ
	5Pkm8O+oxqYZiTrLZzkYIJQaj7ZUOHdWD7rgg0SQjk/W/PZ78XqjuQ/D3RL33APegeCAqlMZc18
	5Kpn6h+QLnGe7fwYLfS47nXCTH9SqWMxURHPdjFuy
X-Gm-Gg: AfdE7cnfIZQctqcmfSzWQTrrrEA++zKyZqVWKKxnE5vMztK8dE54focvu+wPmmZ4IAB
	tGQfESuJd8a04a5Uq4zCd7QEFR/olAmEtPy1dxvaP7sl4LVpfhD9Z7LpG/zSsKojjH/hRdOA0kb
	1wN2oRmcn2WbESUErIuHf74hBZZsnWDvd8Dy6JhaUPnNcc/pA6M/xwMkCUivC6lKFLIXMROpXwl
	1X+ZraZ9xRc6QGEvK7xWOusZ0wLOtDEQcsJdUCpQhfUt7MruVz1p+IjnvjdPYf8O6knkcwWBEwq
	gDmgV+V4DUNfXGWkndSo/bBaf2zIRA/0Gzhj6OjvZt29dZO/x2xoGyQTfrUe+XaAgZsHohwUmJZ
	ESQeLE21gDgK3a/EX1UpXAI2MiV5VIGTv3Zn7TqWz9A==
X-Received: by 2002:a05:6a20:6f93:b0:3bf:d354:134f with SMTP id
 adf61e73a8af0-3bff4289d7emr4103264637.44.1782962039006; Wed, 01 Jul 2026
 20:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701155135.3962058-1-edumazet@google.com> <20260701155135.3962058-3-edumazet@google.com>
In-Reply-To: <20260701155135.3962058-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 20:13:47 -0700
X-Gm-Features: AVVi8CcTfcRytP649sNoPiCHLY6dJ6QdBIjaYHMpQnSmzHBLXeRrjzqUODMuTKk
Message-ID: <CAAVpQUDinHGHzcy5sGU-P5KTcxt9UueaEbZu2qb7kBvi1KDbXA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] sit: no longer rely on RTNL in ipip6_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Update ipip6_fill_info() to read configuration fields (link, ttl, tos,
> proto, i_flags, fwmark, 6rd prefix, encap type/sport/dport/flags)
> locklessly using READ_ONCE().
>
> Annotate the bitmap reads for i_flags by copying the first element
> atomically using READ_ONCE() into a local variable, as the whole
> bitmap fits in one unsigned long.
>
> This allows ipip6_fill_info() to run safely without RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
