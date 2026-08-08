Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE23115B8
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222049; cv=pass; b=R1Rsm7U9DGZ3Yxxkl5cdYfuvVrTWY23y/fBmyt8q9CO5jjgJgtwGvw7804CjFaXWmeGZKVWnDR4l+/a+miInlCNvBpMOCDmvVgwl9Dk1e0GgSn3t2RHlr/yA/utayt72xsTM1geIad/RMG0wkB8fjVUONXTpv6uEk/nhernocCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222049; c=relaxed/simple;
	bh=zfc4kFvHwcIHkBwfschKtWdND5oG853WyPeQQtK2Wnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEMd8viMwqclCbh8DBeCITbskr6uOFV6Xkm/kDzsidM+cuK52kSjbi9zMc1boe2CKd3iqRVb548grE8GrDhWwIdb5D4WjS8bW/gGu0uHbja0hA2Y9I/QUjaVSMabMajP3QXUNZQFeKLXvYelP9oxkJkPIzzx2eD9f7aGqYXyxtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELcpto8+; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELcpto8+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so6952535ad.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 13:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786222048; cv=none;
        d=google.com; s=arc-20260327;
        b=H+S0ODnC+PqNQsDC6EO0s4xfA4euaqksXIhaYTnOVIc6bcD+TFKtPc81soJLVLniex
         Tq8lB5RR/hDIT9St5faHc7nD2FbVvWDgFDWBR9LSKpRpENEz7ZNGPuvecSOYtMnjdEVs
         Ja0R0q3hQEV5GDQOfH0QGLaqf0WJTWnMNrqb0QWE7H+G+i0nosXRxpo1FmpNcsNdXb0D
         3gRKq2rBSpy+HA5208Tl7xgMeyKp/MoCkfuiThsZgpZWOc13bTsnsBxDoaCvJaU1c2xK
         mMAgjJMbEyHZkM/50+c/E/KgJokghSRVqdIhcTznX5xTqLOumAys2kg3l5ArYaCXLLV1
         0ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYOlH6ijncdGIPkhTaWNjZX/ep9Sosn/DYkMilp6WT0=;
        fh=sbCllqqXbacIhbtlyvPe8MDNydVR/75ScHC8knbWtP0=;
        b=pqqfrLrZDXFm6aru4XmeLyAVjd1Al2jpfYkMoRi94v/5TT/EHNnyjXlbpOeDrxHKb0
         suvp6bP423eI2OhhUX/K7F3yJ/uffnARHnEnhCkOstDeCJzhRoMMt3PYxgpSoYwC4B3q
         F8a1VIfhwKOeZUUETs8sI8fWGV61ZuiQThquCog7QqygT/Q6Cp/QBPHo1HvfVrRRdAHB
         HmpNX3UGmWTN3OI3gjpbC9WF4jX44yW3VsSePtbcJ0BVtyNDAapyLlM4jDEy47VG8k8H
         8AcKMm+xqFc0S/jQGhfB1LZwoQx6OW0C3Mi58rxULVeTyRRPixIFHu8+4ZGIb1uYMmmR
         3qHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786222048; x=1786826848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jYOlH6ijncdGIPkhTaWNjZX/ep9Sosn/DYkMilp6WT0=;
        b=ELcpto8+b6eGjgM4c4y+gBHR037wIqNWlaIV4EGDz8cIfhplyMiOpqLvjKRDH+LDmJ
         /qQFR9plu+O3qy29t+EA3mzhS8Ez6ZCDPmJDYzxfRB7W9BtNYiXdP+ULeFDTOtWW7B2R
         XT57fCxDLdIO3thsWjXMigg1tFi0/EJRc+I6FsMQSnUw5YSzYeUTntLMOKWfoX+gr9kS
         CrTRvyXexnDEckaEAKVtJugr7INW0w9gDLRjncgAmk4qLjFl75nkpZAZGFBYTgcaRTKG
         HxoMm5hd7qF5QCVqgsaesSH5Tv9wlD3GC51qAkC6KBKwjrgN9T/p99oQY0+2gN/xH3PT
         v2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786222048; x=1786826848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYOlH6ijncdGIPkhTaWNjZX/ep9Sosn/DYkMilp6WT0=;
        b=b2A/Ls0u71oKdoIkm8m9vfmbBDfec86N0pu3wVqF/cQAGPxWNXqGg6M/lCnTZ48NzY
         1LlFyrc9E3vV18gNJHvz3XldGXCuIvi50IHgO7BathG5ZFtQ7yY/XIHkDdI3zHl9h6Uc
         lJvTW9EHxTFmtv5Dp06IU5k22dCDfyDx05I0d5UymPkFriVr2n3SAW1zn18zi3JL4y25
         pt0F1rye6+uxRlBcj05YZHnGEcxS7cM9rMjRSSisR1t4tk7gL4UUJ3uEuj8sndWx56fd
         zUbppRyAgwT5wcLQT6Rsj1O7lkiI5QZSEgI0uC1xoQaiHAAtHSwQOaycwK2pTsXYpwsw
         yDlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRzbzcKNgQ0C9sIdDat7Ml23rhGjtT5EGHaEL14RB/BK51tNyMteYRa5yWzqxvAzWrL0PwcKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKEolOfWrnfBBBo+TZiC43TwYqlmsYAXpHttLx4mF9mNv5FBc
	tJjb4d3OukxEVLXKlvuAfwQzcgMMz2a6TNfLRlNaDWI/HfYD2rqFV5LD6fyXbRG+7Y0GvXI8/vS
	kZv3JDR+a9KbYJgHs3DshB24cOcj66by/7gjReUFr
X-Gm-Gg: AR+sD10Rpg4z6OKPYy7i9TAvgo+S2RRnKaEILYoISDGLiw/b3GLU5RL4TfwiGGI5ayn
	ucMvydf6mnIeDOoJMiKcdc4UBHZ3kd/UaNkyqWlE9t1fl46UAmAVUHZSMmqTNcEd2wXzN+o/Pnq
	YxVlSW0+A3FfI8mzMMhQcxhqsJJVAIVtxyNccG3nrJru4m0FaXwJVH/YVhGPn71aP4Y4R/ZN91g
	cki9d2i4CM24wpD4nt0uizOiK7AXLQz4BBou/oK47xEtDT3967DkWYny5enPCOOOhJ8osH6F2uK
	5tLEPXu+SfjoTeQNLSiq86GiwtgmdlZFhb6NsGZgCAYT7xnyeM+kn8L/lMgeYMin2LynKTdkp7d
	izPSUoa72cw7NIYaQpWSc55XAyhpAbaphE/4t0jNQLre9OixpdlL1Wv7yR2kiuqWqJVgumoTHPY
	rd3xKzj+R4aYqeQgqclF/20yJuoHGxBCD6d2N+
X-Received: by 2002:a05:6a20:ce4d:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3cb8607680fmr40487195637.33.1786222047107; Sat, 08 Aug 2026
 13:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com> <20260808130341.03d18272@kernel.org>
In-Reply-To: <20260808130341.03d18272@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 8 Aug 2026 13:47:15 -0700
X-Gm-Features: AUfX_myTluPq_eUjAun2Pz3-1A18zMacD2cM0dl98ZZrOsCWCcj0N_sPdWweNa4
Message-ID: <CAAVpQUAOGGWcndwLQB8uSd-f3deQcr6PhBKhEFdXv6ahMBN1EQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/13] neighbour: Namespacify arp_tbl and nd_tbl.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 1:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  7 Aug 2026 23:28:38 +0000 Kuniyuki Iwashima wrote:
> > The neighbour subsystem is almost ready to drop RTNL.
>
> CI says =F0=9F=AA=B2=EF=B8=8F:
> https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-202=
6-08-08--03-00&pw-n=3D0&pass=3D0

Sorry, the lockdep splat is false-positive, but I'll drop
timer_shutdown_sync() and use tbl->entries to free the table.

Thanks !
