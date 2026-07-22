Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE1368D76
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758081; cv=none; b=OlWklEj2+vbdrZAM+VP2pAjNtFGPVmDZc4rQnBJ1RsD+6w8C8bUWwV1V746jr97vhyxDdGgMcZ4Wq6WywxHTbmtXp/EYN7tqHKQF27uX7lE8tauf8gbJOjckOyi5rFge28pEEDn6e5A8t9naRLB0iWwLdjqULoHItPsPuNcdP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758081; c=relaxed/simple;
	bh=c4Obeuqqrr4bY3iX1bjSDpquaWYjAyztcT+fEJSg1K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVeDuWyjg/BOeaxDsTExpQoZlndG2HAw5OSzA57QP8SdKCbwNOFfwKR2NTM/iAqdHKoXNg4o/yZrAkYyAauwCc0XW1L0slqOp1h7EW/MxhmqMTjBSu0AxntojhXMOb7Fk1BPCB2m1MJvqs5StvfPtVC3QuvUYbFnJoDjHB3kUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXeG7YuX; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXeG7YuX"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eaa0c5df6so104338a91.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784758079; x=1785362879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8B2XeyxAvEwsooW1amp2RehjuZYYpC3Hm5dyn1YxDOg=;
        b=IXeG7YuXsXONjpKzIDygNtAZKQQVnwSOoAIlzlTwO7CoAZWULWRLzLIlsplzP4lLlt
         8JVOuQEIpCsFUvi06p3lpStJ5TI/tamhPRhownSsOChMYJkOqBCJ7SUXyIqhAqpXNvnL
         0p7/cXoxsIDcQm3UDlJhjK7cfFrSejKWfnap5Savcpu3UlM5ydTgUUk4crAyeoPHV6Pj
         HWnqaE6+e1ncoZMw59qX0RcDMqs796niYx9NXPACNVXRBov5+0jFasaBozKFO/Kd6W3U
         +nZtbp/xHTubDEACyOs3DRUHJkP0GzNH2jw86IOguWbnmz0L+AVNi+A92/nsdgcZz+Fe
         FIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758079; x=1785362879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B2XeyxAvEwsooW1amp2RehjuZYYpC3Hm5dyn1YxDOg=;
        b=jbNn4yjoxsFRI/pqppMJUyHBTScQuv66b4ywSTOb2XvV29TTDhrcotZBRMLbRqHWVu
         VuIotV5WtkAdzxx9VwvnYJAXmBoPBwFeLIIRJLwN29PHzXmam7yMG0a/LAUNRrk8vflb
         E20xH1u6Ac98kf4OUaJ7mhEuzkWZIJr8loBuhzovqShcl0kG7+vSM8L8ggeX/znHe8G+
         CVoCcG7lDwrb56PPkdrgT2PxoHTDPnbi2quRZUXlq05ji/Ju/EX7PJgVNv1VYDrLQ1Ah
         F4dH0C4nvAFtgmwnO4hSyPBMVX1tygD/rgH7cTjDidwboVvLyOOE4BAyBcdrOoT1vo84
         15uA==
X-Forwarded-Encrypted: i=1; AHgh+RrHkm9QhAcCBl6l94vozdfnWU27BOhawV+0Rvb9RrMwF0x7IVpWpjUveutwsXInvZYvceXG+jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzonLhB1sOfBuxljO4UhQ2TdhfFFprqF7FY/WK4SW7Wgl+BJRqk
	rcpmQGMvuIFrFZW+b3VDKZNXarDzGXJBtpxQq4wqqoSjGsxheOCjxcNp
X-Gm-Gg: AR+sD12awrA1y+SBzn7bugMpsBMFlxhYUmX+vnAorO7X6MvYz4bvmEXJ/j+7Jk2CiwP
	iWieUtZB4mfl/D9rAjblEXK5Q3mHZKRFFzsyXmE7h0HaJINd2BRNMB9pHVQ5vrIsfN19ZEIlAW5
	1hI5RKjGT5JLUWhV7UCfM6M5f9/J96b44/BDEIyD2RgPlOmp8UeTNBfMt/cePGAPBqNkDtzeiDh
	yQJF4AJNJxpQ1CMZ3rrkLy1rh5OCG8qaq/oJnvIHF/EhJnGJVIDjaRY3JCDyCcsgTIlDfOOATza
	7BBxeMHmWX94HqpM95qJqzc6Ss7wswEOfC7Pe7If5AszDQRrTiCguyexgTqFhZwdEcQojzuXbio
	nCEvN5Pb4jqhZ7hNZ2pZRDd9kj2p2KuxkEguCyLSBM4vpskZatyKsKlLsI+8aXpF/bqUO+Ln3m8
	juhmrdFA==
X-Received: by 2002:a17:90b:3f4e:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-38ec8389dc3mr103539a91.1.1784758079276;
        Wed, 22 Jul 2026 15:07:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92169cebsm4014911a91.11.2026.07.22.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 15:07:58 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:07:41 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/6] net: hold instance lock around
 NETDEV_DOWN/GOING_DOWN
Message-ID: <amE_BSmEYB18a1t1@devvm7509.cco0.facebook.com>
References: <20260702224150.3730033-2-sdf@fomichev.me>
 <20260714113658.2023117-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714113658.2023117-1-kuniyu@google.com>

On 07/14, Kuniyuki Iwashima wrote:
> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> Date: Thu,  2 Jul 2026 15:41:45 -0700
> > Mirror what call_netdevice_register_net_notifiers does but for the
> > teardown. Cover only DOWN and GOING_DOWN. UNREGISTER is still unlocked
> > because of the SW devices using dev_xxx methods.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/core/dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 4b3d5cfdf6e0..9d49493f4fb5 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1912,9 +1912,11 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
> >  						struct net_device *dev)
> >  {
> >  	if (dev->flags & IFF_UP) {
> > +		netdev_lock_ops(dev);
> >  		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
> >  					dev);
> >  		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
> 
> FYI, this is the report I mentioned yesterday.
> 
> Most likely false-positive because open/close, which takes RTNL,
> are never called under epoll lock.
> 
> https://lore.kernel.org/netdev/6a55fc56.c90005c7.37d349.001c.GAE@google.com/

Sorry, just spotted this. I do agree that it looks like a false
positive, so not gonna invest my time unless syzbot finds a repro :-)
