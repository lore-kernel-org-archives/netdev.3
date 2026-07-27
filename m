Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9ED3CB552
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195537; cv=pass; b=f1FVWWjo8aZLVPS7eFPH9Be5lilndIWM8slgNlAL08OMEfvRy85zXEAMI2DQXqK/TQh4+vizyD59hrYdjNtGx+JQyDsysCeNMArHRyP5xDpakmiD3fDAPCPzRXbDdzJDYfgaxIF6KD9euW1OW1acCXYL1JwwZtvyd/4LXw450p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195537; c=relaxed/simple;
	bh=H1ZSngc56e2t/CGWJDGOPdz5CZRUsMHh7ctFHnJpYeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR0IweGUV4GlFE+eDWU503cxWEuS5T62pHVgwLFrV549zWq7wD/ArL7ks0Ti2g6ofhZFyuWAfw0UJM1/7HZw98tqs8DxvyNRGNIm+OU+UTfs7wsSh3Cjw7XZbfkquhNXvQwIM9rQPHkgnwnIxx8Xq6US6Melb7UuyIR+oqHcif8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miHJUgMw; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miHJUgMw"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a46572eb78so48224b6e.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785195535; cv=none;
        d=google.com; s=arc-20260327;
        b=D+Xyt9TA6G5jm4lldpDF7iRWAqD5/8iqHG1QqxyZkwedD9a7L4JjG+kYjN5cC+Dpx3
         +E68EOAiva7NFbg9rVyMEgeoKn+lBj24vw27R/j+5LtQ5PCYqsDpzDhBgrVoXjzqa9wj
         UJNMrTrr3sh9VBhUMbUbIFk6VeAC7/cnpM75AY5JR787MU/HZ+v+l33O5LTp70qsM8vG
         dE++ulXBjQ2YoDOktnxKJn3Z3+j4KJRIBW2tubHAaoGOeqWqYnG5IoSCV1zJ8wCSHHyy
         J1gC4tSyuWqH/tBwfQv9v0ky7DxoJwRcyK/nxS1AZ4btkWHcx2ltkodMxt9as+jHBLl/
         UgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H1ZSngc56e2t/CGWJDGOPdz5CZRUsMHh7ctFHnJpYeM=;
        fh=19t7LxDn9VsozGThjFEk68ZrMlc2Xg4TG87y+h0rK3U=;
        b=LMNsqJitXEj0phAZVHvhtyv0O/l+HMGZkZlZMBNrjJDaYl0LZdP0s+GiQkI2C4aAZx
         I/vlpzYyojy11Ylp0lVHJbZakxVQQh+fakvtBWdkIlPMFGa/vcliKVwhMc5WfrhxRmXX
         AtP0QlQP0d0B22y6dnZnIQLvJpvMA3FWAW2fyuI1HixVWCg5tS0HSlW/n0L5SNatvatc
         +rqeIQqvZGW5/Y1MjEEdjkPlT9x4v+F1FbnKhP+buv3XevgqelV1XUaX/0Nua9pQpFDW
         JUGt7ctg36dESmiZ1uNtvlWNRagBJVj9BENBSFygtbt5up3MDciSM/vXeMyaD/PGd/6y
         e8zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785195535; x=1785800335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H1ZSngc56e2t/CGWJDGOPdz5CZRUsMHh7ctFHnJpYeM=;
        b=miHJUgMwXNuXVzaNkQk91Y2zrzfQ4PAA0IHf15C5j0b6AbrHtIJRNEAaTmGMLe3/a1
         4YMOjIJ4psJnaU5vGE6M6Hs6x6JMKdjfOv3bxLt4cYVCm/T8gc4iVN4BOYyLpQBTuelV
         7nxrXmOpE8YKavc3qxL2grGSdktAayzW30ljMXyri9VuUE8DmTupipu9mM6FrnjYmnIk
         V2p1J22pQ9Sqfg4mkVpzPWv9vIicQkIrCFqMpmsaK+IJEqiHl11dCNupY/zB6G7CrDjx
         HMr8mZOqdCVWrxUrVrKO8WZjgDL3ZWzYX+xRe1V1chrleTdkwp7vLjqIlsiobAr8sdDq
         CI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195535; x=1785800335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1ZSngc56e2t/CGWJDGOPdz5CZRUsMHh7ctFHnJpYeM=;
        b=bCgDhFeOLISf2KqmJ2mq7w+Um60B36bvd5k+4pqtfgyc4n76N9ybbmAZ9wvjJkc7pe
         oQTfep+YtCkWMOy95Mz5om6o9FKRKXb/rPaA9WmCphMjFYt/bCbiNoki3ZSzr04E2yvD
         HWm1KAP/WDot/+crVPmLHSvlPz5sETMwYCicEA9cTzn9p7ZfVa4f57rRoAxki0GbGGdy
         fyVWFiplgLMMflirTu+gxzu6ytFpNGBbhUaJdbrvNjA28fsZcIHK6HRv2wvJIX2mgeDF
         C94JJSBB/mh1tW4+v0bVzWtnnpEcD9yucjZqcT3bqGKtxXxhXCo3oU0KbeMFApophbo/
         1IFw==
X-Forwarded-Encrypted: i=1; AHgh+RrIfEEBYpJXyAqRLVOxpKgwRBV6nkOUTDzObiTxLRo7ByRdQ6HAYwsnP+2XUrc7Uov+lD2w7MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTRXKrOpo0wG7dAYkfJ6psfUwhgto0kOYxDF+wISnzufhFSCz
	ikJPWfsrABNoxo64B9y7m1HcUnEY7cU/lzRwyw648mkiLuSiHER0S6fCnSHvT3HRubHdP5mE+f+
	/kBVvT6eSgm3KGEzMwrciVMT4EIYcYdE=
X-Gm-Gg: AR+sD106JZP3C2iJqF8U+BIXH7hBJkpEe3qAgdUJuvZlgvvhVby1KakviOOrlGOSUfn
	uWHTvfT1ieAjxPuSY4tYQ40+SIQDZkS3zCiACy9+Zoak2qPAK0ReEa1G7AKYmf+fOmZuQAXPTtR
	zJV8ixrUwLiUK69W6NulEsEpteyVRzelijBmLy6ppWeApgXzMRHaMqSQ5Q/wJC7b7Wy49lawcIW
	C4aP6+2r0gQwaGsiRTA5m1FlBmbGZEXrM2Inx6OVZEFLItaiFKWuSVGVbkDZ1n4qKmnmL2FMV5G
	jA==
X-Received: by 2002:a05:6808:221a:b0:486:7a1b:5a9a with SMTP id
 5614622812f47-4ab69f5e11cmr9702265b6e.2.1785195535323; Mon, 27 Jul 2026
 16:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-3-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-3-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Jul 2026 00:38:44 +0100
X-Gm-Features: AUfX_mxHc_t1SKY0ZfzqxyAi64O4wzECyaFMnbv8uCzScEukidwZfds3TRM2t8g
Message-ID: <CAGSyskUxYnrYVeyvuT8c9=d7+muMwb2OdQfBFQ+86pYTNRcZLw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] netconsole: take over netpoll_setup() from netpoll
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> netpoll_setup() is only used by netconsole. All the other users use
> __netpoll_setup().
>
> Move netpoll_setup() to netconsole, and rename it to
> netcons_netpoll_setup().
>
> Pure code motion: the body is unchanged.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
