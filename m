Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54D2206A7
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400695; cv=pass; b=HWxO3EMUjALk6RnuBEOr4OYWJn91GczJBdYNGMYJfIHMIfST8lFvNVY+1WxUuG3TqeE4YGeZbEz5GNZywSlbIYZDTv2pWY4ar57KC/dlWbSb0krhHK17RbL0BIsX3z488AKAb08b/TH/zeGX7aMZfHFL7QLkgGqguROYBukaxJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400695; c=relaxed/simple;
	bh=QphRUAhvuDwR2Vd+Zv7ek+yxUhdFw8ikBqBWePxuQ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTDlc1hbXQxYqoxMs3kpqwVs90JWbfMO+NogGWaQBHg1JDMwC26p1sV6LA0MBgLCQuVaPKniLlDNs/3+pqE6X8gJCZB/wH2xtbFaw0Pr+3GEeTgWr7SUg6nS+wkljzdvT4STMqPnE8xj+ziAZ/XrWz3xvbg5IKaB+bcRuzsLONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6l1DJ2Z; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6l1DJ2Z"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51a1fe8f578so24101871cf.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782400693; cv=none;
        d=google.com; s=arc-20260327;
        b=cUcAfkSCmx5BPDpWp7cBrr8gm38FgXUE+EC2FDT99F4x7/RQj+gD4EsCTwmYs+8VQ+
         MhePzmLcacUZLFVZ3nASgfoz01FZjJY99AuccNBpcMJ2kYLWcIDnboKWxbxNvU3cPv8x
         t4twqYK0cSQ4fFRLzJhhU/Zqz6F2Schjf9AImGl5GfJW/roKa1n7vGL5iWqN6ReumnVV
         U7vNukGmC8ReqEj4n3mfVqAi/u2fA2l6cJTvWyEfg+hWbT1lHPqVdHWsHIkE7NYb6KzQ
         FRZd+qsx80b3Vv2DG29aAMj8j2fu4lbpa01OIYCMBbwAZITu01s+Lq9iHo9bkAmUt0Hj
         KR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1l3n9HHS7cFHlk16ywaztoiZJ/m+ZspaRQyqSAqp5Q=;
        fh=9ZZX0HIuhr04yMCrY7bQhEcvs79EaWNVRZtu5rvUfwk=;
        b=po/PphcOKvvMyoAv3FHyxmIpNOkSWxM4tun44iEQCHqOpqi1DKqLxvdZXLg2ipG1Gr
         BJ6JI2546RGZ/4Cfm0q3gnBstb+PUqUo8WtQVJyhH/b9dLBxBk2nI/u17KBEy+QhGM0h
         b/0BxhNH/2b2RKct+KrUWRuBb/FFW/VohH1vbvt5ac3uld6zFXvFxzzOJGy75aARreda
         GAO7lMHzX2pYfUzxaM0k9o4sK5UTCzLZQXVzThezUxHZtNbN8HOsJv4DaV8RrDSCvBIx
         Md4lgR2CSoTep1mA2kqrDIe+Al5RnFiabAH2VEwDTM2u8jjvYXT8Kuk6z44C5WF2lTgJ
         pAVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782400693; x=1783005493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1l3n9HHS7cFHlk16ywaztoiZJ/m+ZspaRQyqSAqp5Q=;
        b=l6l1DJ2Z2QOL+UenqlhyC0nKTggh6/4OChXk8sDzsbTT2ERQZVitJZdiVFfPFxEa7C
         cBO31I+scIo/VrP7Gjrxlr7/mnyNYPoLPI3fDHkIgjzM8ooLiDjvchjsBWjDflWz04sy
         iXxuJwro1dQlUeOWP0YHCXze7WDf/AlvxD1C+i+6ovfahbKKBUkgngmd3SWGveZpuHmp
         ynMjUh+IEi6A9/0mHI2vNsS6K+FbqftNqGoHMesc706QaxK9jhhFEkkteslf7wY3hOFa
         IKi8n+RjMdPZIsboAp6utGuy1kjh6pRGd1nWyMI20jGiA8EwSH3Jzev0FHHMbVbIdUN4
         yFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782400693; x=1783005493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1l3n9HHS7cFHlk16ywaztoiZJ/m+ZspaRQyqSAqp5Q=;
        b=h99OVjIpHKxLZo1tCVY4/IvX0FRyrw5XQWWhCof8as5Q0So5W9Ml2l3FdOgCz6mUls
         1/OTQjvrgu6ZHFAMUS3qXhmPYV9MGhBUIM08Wk0aipMym8HRnZnScoGnOFJKbOA5+Nch
         ROKmCm6GvuZ8X4Ruv1uCnFcIW6V/TLSgIe+z55Hy2Bmuok4rB0SZmtiScRzYk4jL3TQ7
         rhhAi1tXkVo1hoADE7CGfMDwabaBG/YS0U2XBAM/1PwUwKfzahusr3QHLb5/04gNeGva
         2lZ3jHbXJuo+aMdkFD3ul1VRD4KQyc0hMxV9wV9YdeM50fhI/5OCqV0DDTdK50Lm+oMG
         BXsg==
X-Forwarded-Encrypted: i=1; AFNElJ9m8cf3FpZP2uSSkyWoFu7F1PyDm0uYkmyq3UdQJRUtONTY/95J7DVCut4ptLvKztUG8j3GTto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7k+2CoWtRu9ZwWjd52e6WPYKAry1RbTGm2hw0UhijWfAJqCGt
	u6ACxoBIDZ08OuO9Qk40qo/LbQ0g1Jbdm5aYoJklj1Jt2GUTrVLsKekcq3FILtuL2JWQHfOnARe
	mJdkxT7P5TBdL3remNo2ajD8bDiTdEklqAZasbJyN1emOezbMSmQsh8ZC
X-Gm-Gg: AfdE7cll0KFObgrt6bTZMgin9Bz+tskyUDP/HYkbxllkY1XvgY/LFkHuGBWrGzl4TvA
	u3f/6K7k+1b63tRhkFyxJc2DVcEfjGLx15rgnLm1irt5ekA4pwJrs9RYIO+jIoti1g9eexj7C5P
	uM4SZ6++3fejCyFZS1OOcOGRpRV6uClBXaI6uLzSY2ihRgqS7gD5DpQYdqn5Uc8fL/tFWJHuU+j
	HcWnB34FRvGMMWs0mcLzdjpCVhbYs7Ld8lIQNY7DvkfrfTjZA9sWZBigN2GPEvibhs59AlkB1rz
	v2FNS+JLXsB0BxiDmpJCVkWWbZhPH4UpotGrmGJz3TdcxxK5gqXfajF/PiRWO8WEtW5DKNertuk
	9Dt7cuw==
X-Received: by 2002:ac8:5809:0:b0:517:92a6:fcd5 with SMTP id
 d75a77b69052e-51a726f9c17mr42447201cf.18.1782400692619; Thu, 25 Jun 2026
 08:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625065938.654652-1-edumazet@google.com> <20260625065938.654652-3-edumazet@google.com>
 <20260625080854.06851faf@kernel.org>
In-Reply-To: <20260625080854.06851faf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jun 2026 08:18:01 -0700
X-Gm-Features: AVVi8CcnYmMLMoNwPYHiZqaH_AJSXJc_YxTwC3k2Z3qO1M-eJeh2yfyAroGvpT4
Message-ID: <CANn89iK9T73A-Qt_Xs3-9Bo=HKhLCWGJ6viESC5mWEwPfUJezw@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/3] net: udp_tunnel: convert state flags to atomic bitops
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Jun 2026 06:59:37 +0000 Eric Dumazet wrote:
> > These flags can be modified concurrently from different contexts:
> > - RTNL-locked paths (like add_port/del_port) write to need_sync and
> >   work_pending.
>
> These should hold utn->lock. Not sure why udp_tunnel_nic_lock()
> is locking in the callers rather than directly in
> __udp_tunnel_nic_add_port() / __udp_tunnel_nic_del_port()..
>
> > - The RTNL-less reset path (reset_ntf, used by netdevsim) writes to
> >   need_sync and need_replay under utn->lock.
>
> I'd rather add asserts to confirm utn lock is held everywhere.
> This code is hard enough to follow as is, without having to
> think through potential concurrent accesses.

Ah ok, I will let you finish this, it seems I am wasting your time.

Thanks.
