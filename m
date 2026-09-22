Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C4409292
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109781; cv=pass; b=GQ08XcbRngyzwmuYgWVUjOK9vaCQ/Kq7xf0s7rc7S84NbxjkyZx8DKbLDAeL3yEA0uqysmLDsJktwDbXzC/hNYmcHoP1lHj+8yH6tMs1k2CQVpVXabC6WtitXlN7Dp3PBNL1Jwbg06g8JB6/ZFwFpUMt3RD9hzSs3CbzgWTWrpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109781; c=relaxed/simple;
	bh=clPJAFG+iMbMZ/1lfY4k/HPrMduY365VF1hYyyaPXaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2nhfl3Tms8myVk642/qCjQqsbWTR3mLpwk4qbma7lZD4ZO+WqAPjTFTCWkeMDO8se+DANIy3M5VL4Slfsagnh/aJiSh4sq/4AWbwb60EqIr2Rjjdv9rj9eli/z421SdWUDpp08BpV/zSkCnKvjK9iLkXOeGJWbjLBniO+2RAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inf/3MjU; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inf/3MjU"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a3so187329b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109766; cv=none;
        d=google.com; s=arc-20260327;
        b=OVY6Ppnq5wgjaHr4jzk50FJ7nMeHhOI+uq5UksT6WNhhJwyeJovvcSc4WLSrzbQ7tU
         RdOfgIHTVOTmASHytPmZjLBQ5kb1kmj1IgqlHJ4xU9cIhMMNEfxvYnQ9BXnlyYaexjHd
         62oO9oQ7NuG8zScp10rz2NiU+ezKVutm32INSM5uTMRt3AZ5IqQ8MndEfcJsJYEuZLwr
         3xjomrwvF2WcPlB3dHT9QhufD6A3PLtHqVRpEZGjPENslJKLwIXcrngDvIe7MK1Itl0G
         UNfYx0iAIKL0OLvXPj1WLIV2sdHPfV+i12kEokWzqA1d/QO9HX16nQ2N4i24ANMPqb8S
         5mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        fh=/8v+YHaMs1F6G3Gyv5g+3Shvs47IgpH+CZ3yYGAJswQ=;
        b=aI5i85Wz7oK1j5oZ0AvdTvy3CiKFdymg9BEjAm4XpaOQTm9ReZEt2JmFehSmXm9eSC
         KQk3nx09oGOFxOWCWkIgI9QawhK8KDqQgwJy5XhlIS5YMXZ7lAyg+xzPHQRd4R5cazYK
         2rmVQryO41spXunGeNX4S85jzKLWLB8Co1/bpLR8Uax5HgZqoCdbsfOMJFZZ21M1g0hW
         1nsGshfHyNiK5Ma7bZvHAS3xOOdNUa+rU9jv4DytGgZ/5CggjGPi0CgY3JFV4qH5iBZs
         sSN+bPOPFPXG49dk0aXia9ynyJEGn8jjd5e6ha8mgoIP2qE1VWVhofNP1SBd3ElqHPf+
         HZJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109766; x=1790714566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        b=inf/3MjU3tYDi+cWapNhF1EoZf/mH0nOYitrbEjpBEGiLHx5FWQOsL1le8T6YHHUJG
         NF4lDKYrgZjYl0Vejgf3crLJqwrnFudfYtvfu2ISayISMrFFkdk6McmFT/ess3qZS64K
         hioG6XKtifIwiOh97uy/s7wXJKrK3/thMqhtEZ0emawrDkhdO2Poz0mSleYbuXYOmbU6
         T4IIhE2xjWDyGlIuzQZae2cW8ArS87lOk3olvK/g2a4zvoTpJLOhRfNKFxi4DWEmiyXn
         saHU6e3nJ1q57XLC299hEtsrrz4MYzqDN2t4JwTJdN9C2FVoSt1wpKjwhIzIt/AlrzrB
         3+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109766; x=1790714566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTYsFeY7zUNSIttKIg2dRq22CcfMNDzj+vWdXla++ts=;
        b=0AtDiN02prBjAQUtWCIMwUdrFZ8eMJWaruPBeOQchHoiKRYq11WYBiggHuli/FEgwH
         z2Col+Ehgv23PRQvVOz0g2C+ExYX7Abh0++RGe3CW23WG7xDVSv9h4LMdVQoh9sdZDSv
         U4kmpefIjzEEFvFwVOtI0ZxHPqTzy2TuEKBykmPQcGRZFpUlHmai5kdaBWCZAPy3rYId
         fX/RpqbOy9XMKum5o5oOt1Y4MZvLD2+Ke333Qjpmb2Wb517OunWShn+hAcNDe26jqED/
         pbmmXD3lwjQyhT9Nkwx+sNxsOeZ3A6zQGAN9oP9ynjCs3FtIgUt3dWKHjcjneti4xUru
         UZzw==
X-Gm-Message-State: AFuF++niYF1mXHJbBBGw1D06Um0I+zNHGECrKHq7eiE4+BFDcidzpqXb
	ASvf7xO7XDj10T2vzXPclXM/Wd/HX7OYvdlkzp7dvU9/7LpCSr3d69QWPY4Lhc7J66Hx5o8S3k+
	duRV5xRB76wzt1vsTnYW6l8tV5r3yn1Y=
X-Gm-Gg: AYBFou3Sefd+YAYWK5xyUASZN0PT9LST75nLWJa10w/6zGpEhXp4j3Lylx3YsQpLMZq
	In1z8IaOC2kZJ4nqxY60S8z4o9kSOm7hTc7X6OS4UekQv1SRkrPI+IL4FOYg0Nt+WaccSlnVnBb
	1mFDoyO0aNURXUKrZYhQuB/n33NDAfFrBD9v+IkYtDJgykFQCfePPS8RTBet0Acc3+qhpCyex7k
	vwlVJRg4oea5jselLZj2ol/wIXrIO2oyTgQHWTk9Qtfn5CFDFDEx9V9TdZIxnzpGcMD2SxNFGmx
	21W2sVlSZRyj4lLEJblsb/N9hvWDTMMGakZIBFuCGxMRW++7/uAsZTTUzz2GWKi3ZwjMf4f3/9t
	EkDhVHiqwiXM4yddXC1GTNPK2lcoPQ7hJ+ve0RdaTeJ+JwKhyv6UuFLGJT7oFNN/WCQ==
X-Received: by 2002:a05:6a21:6b0f:b0:3d3:ae40:51e3 with SMTP id
 adf61e73a8af0-3ddf7eb5f73mr622092637.23.1790109766026; Tue, 22 Sep 2026
 13:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-5-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-5-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:42:34 -0400
X-Gm-Features: AcwNN1W-iOgtFaeoFgTSVoi0VfumM0YOE87MwjOUfMe1Y7AltETdUhTGgq3CSe4
Message-ID: <CADvbK_c7dS27Vip8OO6vonG89MWTP3PwN_y-YP1TrH0du6HS5g@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/sched: act_ct: avoid modifying shared
 unconfirmed ct entry
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> In a case where skb with an unconfirmed ct entry gets cloned, we may
> end up processing both again but with different sets of extensions.
>
> The series of events:
>
>  1. The first clone wants to commit and runs the helpers wiring up
>     the extension pointer into the expectation list.
>  2. Then it looses the confirmation keeping the entry unconfirmed.
>  3. Second clone now wants to commit labels or run NAT and adds the
>     new extension for that breaking the pointer in the expectation
>     list causing UAF on the destruction path later.
>
> While this is possible to trigger, there should be no practical
> network pipeline where we need to process both clones without
> modifications in the same zone.  So, let's just reset the entry in
> case for some reason we got an skb with a shared one.  This doesn't
> affect any known use cases, but avoids any potential problems with
> sharing and modification of the unconfirmed ct entry.
>
> Unlike openvswitch module, act_ct allows for NAT without commit.
> Changing that would be a uAPI break.  So, act_ct needs to reset on NAT
> regardless of the commit flag to avoid reallocation of the extension
> space.  This, however, doesn't really change the picture for sensible
> networking cases as there should be no need to run the same packet
> twice (before and after the clone) through conntrack without packet
> header or zone changes and without commit.
>
> The fixes tag points to the introduction of helpers, since that's the
> main UAF trigger for the sharing.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
