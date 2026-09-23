Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3551DB09
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200521; cv=pass; b=UmBBb673/Gr5TMvnkn9fko6K/WBqowjCrdZGVYAoZjSCTYlr9i1octZhHjIPXvoqfnIgfyPtzdzGOP6Uw2NnL3NB76+Oajx8KMsf9npPHXZhzD2CJLnOb67zn2OCB1oNLF33JQMGt34qpglc8RfgN74WKY/i+4+Wd545aPXt4wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200521; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blGBwjNXsa9VjOWqd6889qh1P+02tE6gx/41Xrx3uV8/t49R2r0GicVcf+ROY4o60PRlxWPWqggTi8f4YMPaEepl9KLUqXpRDN3r69IIrZ3ivRdnbNZsY1amkwN4rf38u7Qohccj3MJrtxogCctInS9QO9KEGa+KRtn9Fq5O38k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CazJovOD; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CazJovOD"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d06so1221321c88.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200517; cv=none;
        d=google.com; s=arc-20260327;
        b=rCJPQCNNmNZFzJWJPkza+x3w40E0mBdkOsjHjvM5TMt9NmjABBI37Fr7hCVhYiRtb0
         rf8Iv50x1yh3okIf8d3IpGowUKq4WKw4p1kD7g+XYi0V/z9Z0qgcOQbq1fpb94C4+B3h
         cQcPhWzZ27FA9ZMI2lD9CdtnS/38RfN3TYmYo3YGkbLa1MRUzpBPJNJp+EyDm+FZU67q
         FRBmDyqbZGVNWJgi8I/ASSm7pw+soTRxvVgDb9d8YdXUfs8wcv9vZi9H0AZ4m9g9NGm0
         +SO4YounG16JiygOqHjKHGM30/hG0a0D7hP9PyXIN5/qLD/gVfSaJMNVIrPQkKFlQAUc
         91BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=bwKfIWOZHvObYpnK2VtHQln0hGHHphFkuxSnDA06dJg=;
        b=TSoid8/ywE6pF09pug1bPta8asOF3BoThVY4zbENcV9DeLkWTLTxytwjc34gl6yDcx
         1X2c1bLa1nRQUG7ZZwNlvoa5/a13RE6wnItS0GDkfDRrX0WXI/h6KrJ9SxAXsFjEtpYG
         D5N7VYK+M8FV1SRsPBrwaKAI4Z0P26T2WKqrRv8Q1n6d6qCWSBTsYHnEsAOaiZFUELPV
         kgW710XrPHoZqhGYQ9lQdJHIBiPy0mqjU0GBX7s0fERIwc4WZj+ornjn/GxrZ7kzPq3c
         CLcCoOzz7cVqwUv8dJnFkl/v8mb5SZ6KBUgIZ4XSekd3q/f+PR5ff+u5Ioc7eAbxgp3T
         maMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200517; x=1790805317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=CazJovODq6KNxGh195LoWHygrj5Lal60+JsykCP64XLx5up8Zjxlbo693LN1mLGNhM
         oCKiLsMD3cD2T1oCDdG8vKJmle+Tz0dRdQswtUu3JgvP8gUletEBnURAXXNZa3Ozyafo
         OrfEslPzscQqx3smmZL2MmQGViL1TOolGoW/uaepVt2+F2XWpkfTpJ7E3GuXwNpUvmmj
         KKgx/FRhuwe/xHg1fO3Okv14BtfVzMg6Y8EeiAoYfkI29W7Yu37BqF4lzepM/vp6xRb5
         TvWT4RXggCy9Z49op70meM5SEGNL4H55IOhidztdFbYc5cza7MdryrleBekQjg5aE9HZ
         Ly/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200517; x=1790805317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=esw1GyvVPn7o+zu5rLiQ4BShI5FItVi27SInaG8BKZzoCiDyFFhqe3VJuk9MKHhehq
         lmiGInyX62QXlgjpK756XMp0Sg7rYDptNKVNnYC73HcultyQkTckKZeOg4SvPmyT1/WP
         o46khBb6r5QuQ7lugKfyd0PQBj5MGvpk8/RZw0ZvO77iTrDpxIZqFEZdzGH3poTe0hRe
         SFnK5EPvRVZL6XmGpwSTTs69CKLpTmK2CQNgXF3/pqIt8PhlHqNTR6o6D6Z6Y7JLFBEE
         LuCs3rDO32kvVi3KV8BYP0ESNgh1QsWm9N59psxFrNqzE+SG1s+UG8B8Y/XTcwXF/gOI
         6cow==
X-Forwarded-Encrypted: i=1; AKwUvBxiXlMMOTg7zPTtJpB6uqJjIJCEVKO+XWC5ISl7FXZwEH2s0TLhJ97TqrGVNMhOn3J5uiUKvuc=@vger.kernel.org
X-Gm-Message-State: AFuF++l+HeIO1xIBMKBLxmYQaOJuZw8XO92X7WU0TcW258N+2xf9U0eZ
	JZolp/BRloPco/xDESIV4Ag3IUOTFNQThMoKytnw9W0ZuHUJ4Nm+uokM8e31rw/bssPpDH69rL+
	Ni33YgR5BgPNfZKTQNOCopm1b+cB9J2ArRKQmL0FQ
X-Gm-Gg: AYBFou39aNjA/VutSHPQHYksG+9EDa2VgHIY3yWjX/l/3PZAJUITPr/SAJ+9N4hYFob
	aCTz8wLsxTyndQGKx5dJPdw54FkFE6EPsebJ5DkhOuK1myB/O0hagyVvHtrAcTZVZOQaAtV2qST
	wS4Z/VvlWj2OZtTLuOPveug/3QKkrdizkTUNtqYGkYJ6Atcosnn9TpIdqI0ijFEd2E9qoA8wXcv
	HPne6Zvza+n5tsoGtAoRTblUHNyu2eWdhjHimWd8zybAiG5dqdaIC89ks+6zYY4f66M3c+0n/6i
	H/j4XFST0lEPdlNLegUxR/KTc63TWS5GzbSfHgyECqWpi4yPrKvStAMLAKLdoalzR/siHq3dm1T
	5mfHaEPfZ5ykq0d57c0N+siMUH64GMIrQxWL1ZQyRjkQ0Ljx1/llRN38ktu+URGmCOqO3C9PDY6
	mv4R/e/9QT+3ahuSOuFd17Zg==
X-Received: by 2002:a05:7022:eb46:10b0:143:7001:7643 with SMTP id
 a92af1059eb24-14504068cfbmr341184c88.46.1790200516515; Wed, 23 Sep 2026
 14:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-5-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:55:03 -0700
X-Gm-Features: AclHuK_4Ww86mHGkgJD-9Mc4LvmJ0QvqQKcsql14JiNmwk-3I1uZM9dvnYLtzQE
Message-ID: <CAAVpQUCb=onwgfW2onSyQAOaUspKTdSHWq=_fdkXJH4NM63Y6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/9] rds: use sk_set_nospace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
>
> No functional change intended.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
