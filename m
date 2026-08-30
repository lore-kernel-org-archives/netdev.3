Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FF30CD95
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123085; cv=pass; b=WAQEvh55SQuGP8XCt1xxci4AO+udJGx6e086axcKVDuS7IAmYmVi7L7k1WZghhpAy98yZ+HMnCazuqd4l3PzOvjkxxhGlzs4aL84pRHS1+fIb6CYSQdVP/mjtd/2tSntPhgaRvkIDMg02bqlka8XvYEeMigbIhYHwVCbQKIkHGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123085; c=relaxed/simple;
	bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyXjJ5nHGMpF6C/tOOMNYvcrQpk1g/W2xrYrCa3XJRhso4pOS9tQb8DrsWWv1EjcISdtGvdLfv6Mgk/enCClr5OdibnHfRaoAfHe7TFsMnStcjHnXBLTRou7z2WALNHqFCOvg/3P2Jnyn/uhc/8KDpSs03OgNlGbU9iq7u3/lqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRf2eHh7; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRf2eHh7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so6937a12.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 13:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788123080; cv=none;
        d=google.com; s=arc-20260327;
        b=iteXxTKjfzOBwqyne6rlFuZRathTygd5wyMv+wOJ2QbgAeVG/1qqJHerEUE8KB2VXe
         drTsNo5NF+I03u+s9mJovnfRloQdd0FEZFpnF2NC0ixG/Djtxy8+E/3dSo0I0i+7BPIN
         udCCM+OAI4tIeHCcfYcJLQ+1FDp/IYeWolVrEGEEk7x5BGshOf01CNY9D2yrAGu8f7Dg
         uOSgAe85MAPx+qucZqcHqAWg/aRhu2/Hf0c0JXvQly/vhSclmw4AW6Xj3ZuQLYM5HmRu
         TcF6xg8SLQh0iDl44jy3mWjXOn7llgXxBf7ktPj8EfysPZDY1eJ7HuE391lto4zaN51T
         kxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        fh=yh98KWVwMLzWCQ71RnvrnNjzOqWJHM8zJUtw4qGVfdE=;
        b=ZUrWbKjU5xFSDts5RLsn89EmE/+8fRWNdRRQGPHXUqKr5Ccc9H5/JqvGEEsAHdD8vp
         i0TX/QLKAlfrBoRv8TuBl8WjQpYnkVIhzhI0M5W6Ez9pHNt/QYzLrmI/gbZ3eyW11xKR
         0rSiL2moKXBj5f1apW1zDo7/8JnkO/zqP69BXoPjsH8O89GcGLWGHxw0C9t37DWvMmhS
         kPTTInKFWS+wVF2SXxSVIFP8Mpkq3QHVisyG75Bvx3j1a3DBRGF41tPEYcTIjh4cmVE+
         Y2SYJIlKLVbr8YTzyYU3lc1nviJ1Nqs0NCzMgaZvTqKm1BxipXy1WWAUApKBPt+kwm6U
         V+iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788123080; x=1788727880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        b=mRf2eHh7xq3mfglMpCNgppOLgsMfs4A3lP90nnTODkYvC2RP5NhGW84NrP8Fqsl6n8
         rojL7epCf+x9i8Alzn7FviGBIfmkVxGR0b5JgtfsKkkxoaf1jYge8qgMzUhOWHfD/xUP
         tBeik8mb/8U25jvfImn6yki/9o1O0z3znmwDj1VYxL+RCTuXXYhLbri3ngOrme8JNt/m
         VvO2qCumj8SVAVT3INA2PR/gr0OBW6ephRUiPxBZV0jyfdE6iPms7U690jHSb7tBfcEE
         m/GDa2oSJo4B3SXoJGVY1caoJVwWd741/gc1Tp6CG/EM52kBtg094APKLvybZAJCKuR7
         HyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123080; x=1788727880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        b=UwZCGKF125K2ZMdPFQjD8IKDYCQci6Bam4e5SyJCVY6XBTNAtq3ftwtR4rWzSsT600
         KEPWlILLUiP7ERDkkkfw6irix+xv33n+8d1wcisLHA200TTUnwDj8SOGHHcrxQphWNCX
         gsnksmBLoOkegb1mXs60/Ax2GgKExth1T4BwVIsdu3mABa5Z5goIwJbpyH93U2sbSQLX
         CTUByiLwHhi35yljO7BNnnAt4r/rkN6Q4Yy9iTDLl9u+UsYAg30U5HpE5n4jMO3/4NUt
         i/RAftSUFqsuBSBuKb2zNqke6R3pLPgMhdQYu/N5j29E1v6v2DdGLP5Dxs7tFVe8eoFF
         JmUg==
X-Forwarded-Encrypted: i=1; AKwUvBxSz3OASrY1eWKC1xZ+quuPiXMLcp+xXzvoOnzZrn+UhpOIh5l/VVnjUvpJQsGHQPG2ufceO34=@vger.kernel.org
X-Gm-Message-State: AFuF++kvaSWVIx1n3Pbj/YVI7GfoU0ghfcxvEWu1H0NWLDOr7KWi7GJ8
	QPKoURG1A48UxchTnNO6cqduTbrNxPQsCicDNzwSay2qQjNbQ2JpBHOORAHpnwLZrtBGCR3MpN/
	oe9grCfJHkDnVRJ0EneaOjFFdKcOiZXrLhb/kvLQU
X-Gm-Gg: AYBFou30EsgAoJrzjKFUNwCdzKM7TAhEpHe9RZLDHz5pTDRgJwVohcZo1vold5zfCNx
	ZD+PrPViunf1fOTJUjybmKi7fhgtAgQoDPEx55q0T8+O73d2PdzLfJ+lWM+CZGbP2lubDhJVYI5
	4fLprhDHI4/NdlxpDMSmBNTDx8uFMelfaRstFYgxCoxeM0lbABJm25qbcxqlb/VdBcBhjoi7uYX
	bIIGOrBb6nQHqiy/lugJMwk05DKLK7ziSzVpsj3cY8MVWvCcr/9U0PqRkvzyg1Hf0+ngTSk7N6r
	9k6LWwBLgTUFKiFjHtWTZ3xM2RgsGYWUmF3StbiehG0=
X-Received: by 2002:a05:6402:5052:b0:6a6:32f5:b172 with SMTP id
 4fb4d7f45d1cf-6a633634602mr29431a12.16.1788123079816; Sun, 30 Aug 2026
 13:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830142333.1741155-1-tristmd@gmail.com>
In-Reply-To: <20260830142333.1741155-1-tristmd@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 30 Aug 2026 13:51:08 -0700
X-Gm-Features: AcwNN1Xm1QyezA-JkdWtSZwOXWMjI9Yt2s6qRIxGaQ-qmcEpa_70-3k-yXY5nmg
Message-ID: <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: add missing permission check for bind-tx
To: Tristan Madani <tristmd@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 7:23=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The bind-tx netlink command (NETDEV_CMD_BIND_TX) was introduced in commit
> 8802087d20c0 ("net: devmem: TCP tx netlink api") without any permission
> flags in the netlink spec. As a result, the generated genl code does not
> enforce any capability check, allowing unprivileged users to bind
> DMA-BUFs to network devices that support TX netmem.
>
> In contrast, the bind-rx command (NETDEV_CMD_BIND_RX) correctly requires
> GENL_UNS_ADMIN_PERM (CAP_NET_ADMIN in the namespace's owning user
> namespace). Both operations perform the same class of privileged DMA-BUF
> binding, and bind-tx should require the same level of authorization.
>
> Add the uns-admin-perm flag to the bind-tx command in the netlink spec
> and update the generated C code to enforce CAP_NET_ADMIN.
>
> Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

This is the second time some AI finds this 'bug'. It's intentional
that rx needs permissions, and tx doesn't. rx bind takes ownership of
an rx queue. tx does not.

--=20
Thanks,
Mina
