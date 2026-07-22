Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FD396B76
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754302; cv=pass; b=BY92pXyuz2g0tqonCwl4l4AISA5KDNyDf+EPd2ZLt/R+xtZ3pIoDBEyqT0GLD1lHo10baSCqJYOoQ7ZtewbE+MLV09vhm82rV7M5nseQmDaFsuLbOoqJ7qRj2xl/tolKWRUDOcLBjf1FYrJjt68ZYff2VbEfoZ7QKoT+HPRnr7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754302; c=relaxed/simple;
	bh=3Ud/eJZ885DI0uvyEPBefXy7Bq89ORWUqmJr/QiDlnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXCFRumUU8GPyHAS37/+CxpnfeJMCxMeRSLRaTEeRjHCKjipUHWCxOii+kxjsV5TvoHxJUBSm4+9y33pOL9GIjD+Y7gaeLtWII10E1JRk7eY7fFO01+uIAVupJsDqYLpOTQHRIbYCzjcLFIaaOorC+Z+cTJFTWMRliPgkYWLyAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Lg4410v6; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Lg4410v6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so13298774b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784754300; cv=none;
        d=google.com; s=arc-20260327;
        b=qS8mYp240IJBbCF+mEcCl1uHaWvpzocYb3geOvLxG3C/5+4Az7n+EACVe2MBjsSALf
         wZUz14btABMWfpuhTtPy4yBGjOUvclQHuRZYAQGOurRXT6+oRr2P6WmLXzEKpcA+xN1G
         pso+ibWzZR/O8fg7mk1AJZ/mhPBJ/MjZqPsYZisea/7Vu/5zM7fWnGhDNqqxBJ42daVC
         yxHOJfRNUhxa1Igy82GOWcyP9nOwmu2F0mNIbTPKqPXb9CorhSCkLsEI6yeoxF2JCDuN
         cqBZgcblV0uSLHWlobcsLYucNFhdKcwWew5VLB9zNId2I3x0cQS5aSDcsyKkInSxrm0X
         dp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NCrGV/IvczFQuzgiCKvrMbx0iXp5RvXYGgSS+cNIwso=;
        fh=8yPKuDA50OrdBiZNWPXoqsMBNbMcWcmLBynS09PMn+I=;
        b=iP8i1eZQaK1cJ6fIaLyB0U/t9Igs/A7/lDKpcxPoXjYnp+ztM5kAhXHF0qLrRPlbRn
         DRy4dKKDJREWNL+ZgI4dqocil9aoR8U/82vf38+O/8xmP7+oNXo1YvGDbt2IhSUjeMLu
         cUYgvrxkfNgQG9FndRLbYdFAUpJ6HlKrBACad6dcqhSkkKSvRNy9zlXZt//9ejJMT5Uo
         qOjytmeWaEHvPLwFLSZqPM4U1duqQ617iW9ZE63vZap1t2hhOJQW3UnYGmxzFWipoNhT
         Jj6T+pUKHgYp43JxmQJNH2wzvBq4TUgxabNwQtuzayX3srahFgkU2XAgXZbRdN+llCzv
         KpKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784754300; x=1785359100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCrGV/IvczFQuzgiCKvrMbx0iXp5RvXYGgSS+cNIwso=;
        b=Lg4410v6uApZY1JYDXR+vObu2K3gd+LCTNjQI3Z+yBY8bsVyfEewLRxu0WEY+4Yq1L
         Y97VXwco5ZDKfJIZYOTWLjdt/OepwrEOw5Ls838BYJeVe21yyj3phdvbtYL9vZKKePTF
         oySTe5uzsfXI/ftKOp75cVYwr9e2kT3JM9rLJ9R5rU+3CzTGfZyUDtfXANDRDqPBnD7N
         H45cFpdbYPydNqpsP5MdU1goEE1WrpavBNLIwl2/4UgrefP2KarIhJ0Iez+IJ7sLj1Dx
         TUtkgb7nE6ocTfaPNBrwqsbiiiDWvX7PRNK14RHUMNl4x5qOC+Jgd9SjkCafd4cYAELV
         EoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754300; x=1785359100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCrGV/IvczFQuzgiCKvrMbx0iXp5RvXYGgSS+cNIwso=;
        b=gAiXlhwUG4vZkFeAT0trdobNwUEQFokP2kjNnygugznk/+9C8A2lDapym3Imsd0SND
         kZH3sqKBZEebz+jLfVA5+pw/FBc91j9rMUoQqkIokIG1qTqW23Apbuj8JDhlQSBmStlI
         JnlIBsYiHXQ/j7DXSgYjeU966eHW0RPCCKTc1Aa0xoBfgNIpfIU+PgSg83z04EZF1Zas
         sSuVzddysJovCzOsUjVsT5l6Fto/symSnbzaWIuJEfMy6YLvPZpjxO6QRJBBkT46kNH0
         9uSEjhMw5CWJWLKP7FH0Oxu5hCC8HnuIN+LA9kwXHYCKWziJpOhBR91tsCuOO1aonVAb
         2KXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEX/tDmZdgal2Mp5pgRB3vakiFtumt9Y5Olb6fly6EJ2A7ZR0OOPD5bBwYpqN8yKEZ9gjiaEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokrqKIZ8XJyN2QwJcbBNL86MEMG3PjvycrNjrzD7Ubdr235by
	F545gh9V5M4dN5++lA9TwCJZh69823CKpc1zwk+mkrwHgBRHqZj7uwOYtCtu3vk/7xAMDCxADAv
	VJzP1vpzif3/CH8uOwFhQqX6ZieK2ucaCygpuPsTn
X-Gm-Gg: AR+sD11mdxQlvYBbj0qrRPCZ8JJHZv0hrFZL4fUMxZMrybJfJWBr7VZLxdjYQ2psuVL
	w7J686naAxhvmvMbtcFYCcjZt+dRBnxpNhdxHn7yYOoPy2I6k8W4SPCVkLyYgfvIup2M440X04u
	vEKNt7XPU8jRMyaa4Mgw9Tnv9UM0v8K8IEr/cUpLiPlobTrBhGGKbGyk+NTo5RZLnz+x9VA7EGH
	JG3vJjJxznVjqzuicXszBYcAs+JvI8EUe70h/13o+Fhf5dWSYNu25OecbmWn4e4bzd+yHS6fTdS
	Ghw7BOV8GZ1Ot3+G7oM=
X-Received: by 2002:a05:6a00:3310:b0:847:8b1d:22fe with SMTP id
 d2e1a72fcca58-84e2c19f3d7mr503928b3a.50.1784754300526; Wed, 22 Jul 2026
 14:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714212239.1511269-1-xmei5@asu.edu> <20260722112719.17665461@kernel.org>
In-Reply-To: <20260722112719.17665461@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 22 Jul 2026 14:04:49 -0700
X-Gm-Features: AUfX_mwyaH3RhZqjpnNmvjQ0TEigTZvfj9fA5b9tOURP9AVDEXXsz1iach2-J_s
Message-ID: <CAPpSM+SHEG4w4L9idGS5Zws3ZXJngKJnTVb=Rpmw53W=LNLr0Q@mail.gmail.com>
Subject: Re: [PATCH net v3] rds: tcp: hold the RCU lock across ipv6_chk_addr()
 in rds_tcp_laddr_check()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Allison Henderson <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 14 Jul 2026 14:22:39 -0700 Xiang Mei wrote:
> > Changes since v1:
> >   Use rcu_read_locks instead of dev_hold/put
> >   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference wh=
en IPv6 is disabled
> >
> > Changes since v2:
> >   Add change log
>
> Why did you(r LLM) leave this portion of the change log in here and the
> rest in the correct place below?

Sorry for the weird message. It was my misunderstanding; I
misunderstood Allison's message. I thought it was additional changelog
in the commit message. But it was that I forgot to have a changelog in
my v2. (I get used to v1:... and v2: ... so I thought Changes since v1
is like something I should put in the commit message.)

>
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Allison Henderson <achender@kernel.org>
> > ---
> > v2: Use rcu_read_locks and rebase on rds: Fix inet6_addr_lst NULL
> >     dereference when IPv6 is disabled
> > v3: Add change log to commit message as Allison suggested
>
> The patch does not apply, if it's still relevant please rebase and
> repost.

The v3 applies to the latest net.git (8e04823c120b). So no content is
changed in v4:
https://lore.kernel.org/netdev/20260722210203.565803-1-xmei5@asu.edu/T/#u

Thanks for your time.

Xiang
> --
> pw-bot: cr
