Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6423EAA0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826303; cv=pass; b=PSKxH0BXKJhOoIDi+GcexCvIvAb9TYV17qO1ZFcHB1hwULmZdLFfiA5NbEgmsnAFlwXe4aDGaiRmaGQ+TTepyaxSI08TNVAorVbV4XS1xv5SBNoAwpkouz4b2KNGIzGrGrF9QaCeBOHeLd+q8iAeVs9gRlLK3lbpsF6ceMFDMbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826303; c=relaxed/simple;
	bh=Z+kBhpoynUjH19L7771qxl/G9lqIk5BEfMQAgO68m0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1tstRrLju/Ec0mfRiA8WZIt4GDHUOh/HmWev1SIVgn+LjKPVvxJM2sKRxgHd80Px/RoQznHefwdgyTWNN+96nFb/L85m+3q+4LR/Yssz9ZS8pMHbWHqz/fKGgLPdWvxTDLOeZBauIqa9Z2L3JclCaSrKRrbU87/NNhAFYgNvhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsFwRcIW; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsFwRcIW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0c45c580so11104201cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782826301; cv=none;
        d=google.com; s=arc-20260327;
        b=oWhfaYXNIjGgWcypEbqny+4HTF+uDZLeMhfF4hs2mbpU2uQIyJIfv6HHvRagzmyBYL
         lcCVPiKQcHNaLOqPes3eT67B850ArfGJUCoHP3x7t3ZNJNlXHRe7SFmBGp94gZiTFgra
         Bev9pXg+QZhAlpwNtjKgPZQy9F38h8tb1wXR/562nwuu6mIbt+q5jMD74szpMtryxnKc
         N3RWnY4q9oH+bl6ZrLQLP9D1jvPD4p4lOPDEmuq2Tdl2t5y5xyBwBoxtnFpYxBginaN+
         GVAvxdAspY0acxAtCdBEZuwtqjrfuAtbqd/iEtfCbi97LSGUHPWvmN5RvH7On14pOpLW
         3zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+kBhpoynUjH19L7771qxl/G9lqIk5BEfMQAgO68m0k=;
        fh=K5/fvFNNqogqeEtD3pN+V+MWrSurctgmriI2qMw4V5Q=;
        b=XQYg56T8dVZs095hslKjDI+LLCGGsu4Aub1LxLqFfOWYD2o+VtkFV6VA3xaHZlwitP
         M5lKPl1K1KyJ3cA3fWb5bf91MvNpoYj31rTIucC6aT7KbtqnQfZASYTdYko4Q7cw3FAk
         5MZz8yRqEF/zPzCTWC9f/OLTZFoUo/4cuNLqeExhVUG0rViHSLwSx5/MHH4HHiNLsOAc
         hAVyA1NeOJAeSNhfzMaIwzmfJsbXUtdZaEdSF7kQm+4XCxxG/pDLZfDG3+yNplJo3bXC
         FH1hAAJ2xtTHoptZCiAD1XtmXsQtvwxgmbIDj8JapbPJMS0dMtoGeTpuCylUEiz0g7T6
         L9qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782826301; x=1783431101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+kBhpoynUjH19L7771qxl/G9lqIk5BEfMQAgO68m0k=;
        b=GsFwRcIWfF8gS81sB6Q+jo8bhgmnLNDaj6AC2dfkZmUTkXiuGefKcy2QTPPcciIE3a
         TA+nxpgr5HTbwuW5w/tzC1+bcvMpmc8d8akuiBW8bTXfBJyMNxdkFGgVO8YXPdFm/75A
         82IVfdMARxHZv0Vc91/73PucSgnQAoWOztsT/USSSbPYhB0EWyq7eJnMG+hU301EwCEv
         IGYaX7Lmjc/E7b5RstwxSWv19xJYq4SvOwMxoRDYkMQRo3a+khTI64/0MeaBYCax5Btz
         pXK2N2js7/paLrIP//47++VXMR/C0Ea6HQztDWsnXkuy8XGQFYeGeP4PvesJq6Wz+BWH
         fThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826301; x=1783431101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+kBhpoynUjH19L7771qxl/G9lqIk5BEfMQAgO68m0k=;
        b=BWAQpfGGkGyK5dfwOTX123BaYvk26UdRULBwd1MwHXmp1NJKD5sTKe8fD+JLPSB+Ki
         WITiIoqFd8wv179XHsOjF7+lWwYnA2f2IHK3Me1hM1Ac14IsgmT17rVc7SC9fmSFvu0d
         dYSHy8sL/8ohChY6O3I/1oJfufxjXhM+1zlHes/KQc2LijHM8Z0zKFYDMNVcQfUy4Nz1
         e4aT9j0S/cI/Fx4A8AIeIL7sYDo15vxJeD/1pOwMlWccKR5niwloXiymtz0vTzJ1vRQ9
         HcmD41S39csrlDvTDYzTn1TWmIY646JOrDwmnwHRZXQWjakmUyvZJgO3kmcqdcJ7tw9w
         PEWg==
X-Forwarded-Encrypted: i=1; AFNElJ9lwW72L0dSWR+iKDUGQT2bW9bPKBipqcdmUF2jgo4F8ym65YZHO92lO9mHa6877YKtLEwYD+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGcwS0eTtgvWFBe+rmfhYmSXCjwpo0Q2u/7DCpf/scuIHltcA
	ZhRx++e5f09HZlhZ6oiS1MoDPC7dfYzZJAimw7O3t+jYk9emxogK0nuLwaPuN5/4OKQG4f0YwvZ
	PBpb7u2EqiXkYUzT2ce8NIWG5R4HfFFJ+qOEs8fKI
X-Gm-Gg: AfdE7cmhraSZZmYsxGS7R0Mu7uSod5cUPwkYtVfmp9JiDu3Qsb1AXMAYj6r4IkSZSUY
	436F+oPN/JIiuYOqzyizYJKDl/qO/SpI8lyrOWMPvt5QJQqNiZsCv5njQScxH0oTDAt5MY7o/Ln
	/knzSteiTDyuES4+EtesmMQzIYDk/sjp48wdgtem7LBg58tbsRglieY6Jjvm5YLqkxd6NIKiihF
	eT1VaZJTWkdVxAXJOASd9WpKKYNsATwcn4PWmICk94NsFqpwN7Fu49asirdeNqmxPVzECUCz6FO
	0h8PKFeQeA6OX063G+d6TAtdiCnAK+IOU9TPaCtVdDr8VBE17uwCfteuqK3aNiJkYFGVMfbRncA
	m9VRv4MfD
X-Received: by 2002:ac8:5dd1:0:b0:51c:9ad:d82 with SMTP id d75a77b69052e-51c10825dedmr45530061cf.41.1782826281297;
 Tue, 30 Jun 2026 06:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630122333.935406-1-huanglei814@163.com>
In-Reply-To: <20260630122333.935406-1-huanglei814@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jun 2026 06:31:09 -0700
X-Gm-Features: AVVi8Cfpf93rIF4LAGposaUunH2U057BYaAMl9rQQR6e_uBV59-KPHK7gRtv-RE
Message-ID: <CANn89iLuPPWYKCV02e_35n6Wkh7E=jQfo9aoz=0A6jq14wm6Mw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix TOCTOU race in __ip_do_redirect
To: Lei Huang <huanglei814@163.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lei Huang <huanglei@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:24=E2=80=AFAM Lei Huang <huanglei814@163.com> wro=
te:
>
> From: Lei Huang <huanglei@kylinos.cn>
>
> fib_lookup() internally acquires and releases rcu_read_lock and always us=
es
> FIB_LOOKUP_NOREF (no refcount on fib_info). After it returns, res (a loca=
l
> struct fib_result on the stack) has its nhc field pointing into the
> fib_info internal nexthop array, but RCU protection is already dropped.
> A concurrent route deletion can free the fib_info via kfree_rcu, making
> res.nhc a stale pointer. Subsequent FIB_RES_NHC(res) reads this stale val=
ue
> and update_or_create_fnhe() dereferences it, causing UAF.
>
> Fix by wrap the entire fib_lookup + FIB_RES_NHC + update_or_create_fnhe
> region in an explicit rcu_read_lock/unlock to keep the fib_info alive
> throughout the critical section.
>
> Signed-off-by: Lei Huang <huanglei@kylinos.cn>

You forgot to include a Fixes: tag.

Please read Documentation/process/maintainer-netdev.rst

Anyway, this patch isn't needed; all callers of this helper already
use rcu_read_lock().

I am guessing all of them are called from ip_protocol_deliver_rcu()

If you think about this, LOCKDEP would have fired a warning years ago
at line 769:

in_dev =3D __in_dev_get_rcu(dev);


pw-bot: cr
