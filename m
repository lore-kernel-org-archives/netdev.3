Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC553E3DBC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761863; cv=none; b=tJr9qjjF1pKxBunOIarOoWjA0WLdxT0vUzJwR3yF4PRUBUz9zmxuj+O32bo/Qrp+ejh40wvVJ0ZOIo4J853ZU8BLzkUqUX/cGuyMHHmsBXS29D1kRP1PQrejKuH+CW0P8mkiPEqvdeF9SojmWwGMDsSMByfNvgsB2CGhFwEgDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761863; c=relaxed/simple;
	bh=nsDZU6lH0ABxd2mkaqWWWwpJUUSibbd+Sb86MxXWU3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPTYNZoLjERzEsmE3L0+fB0V/wPFTW6FxlQYtwaoQp1jZeifzI+o2QlSJFQsr5HudVjmRYn6i7gD3Qm2tr6FCux7zfsuca96uD47ZuqSls83drUlpv9Czx8glg6wYsNyU8Y6Z6eMJoP1FpTWaKuxNzH8ep898SxGEQ44uIp9jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=SK3nCRqU; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="SK3nCRqU"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-5332a80a731so44799601cf.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790761860; x=1791366660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCubAwWVijXqS4BHl9nvH1ievcAHTddydMzemiE8ous=;
        b=SK3nCRqUOj+9Lbj4V4UWI9UMWoY3FMYUnnDsgkESvx3OTiquV0HrHlmwDJ/9qFZ+GY
         oNQoD8nFJ00dQ7xf2txVWJgC2DMFWOs/6I0+aEl7E7cSWF1xFmc724obfassRunPN90n
         C4PC7KVXQPvdisp4PGeTdkijC3VnRZk4AkNSQ3IQ6LfX4t2O3WrENUxugM8fqSMUOKSd
         hpXRqonKqfbdEqoo9wB7CSj12fcrSNh49FWQaKY83AVSqk8xH14dS1WnnKNg2d1laivX
         dQFQRyrAbtyQ+1NFKvrsl7CrAB7pm1L1IKpASwJygyf5ytkeJphyk4AHV8c1x95Eqp5Q
         t30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761860; x=1791366660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LCubAwWVijXqS4BHl9nvH1ievcAHTddydMzemiE8ous=;
        b=EL93oWtXHy14nZDOiFA/lBB/NLAtKe0ZP0Y7HkbBXNyRlkdFSY9UwHNGFr8HYdvUL1
         hltXoY5yQ3bC0eqW4ds14Ma3qKETrha8t94XZnkdJVd7t18e24gIsNuOZ2jm84nba4nh
         6yLI9UxcixpTRq1r3PFhqJYjchBcFy/lspjCEOdkezt5BeqOE65fjaTfXBw7I9LvZlgu
         r85yzMRYWBiKMqx7Msi71dK1iGd00v8YJx1CJ9yKCtRnjBG6jh8k6n6DO8TrxhXGAHds
         9XszVPhO+a5O9dPj1ywC7OdJOSmHb0fsCdxXq8Mk6ulTgTGsfFzZUBvOIGU2V9QhOMYN
         vFeg==
X-Forwarded-Encrypted: i=1; AKwUvByc19dGxFWFy0L9kP5PUvlY59zHHras52sVpOPYb1qJyjCXh2WdJSbER45+RwZgfWB7n5Cm1Gg=@vger.kernel.org
X-Gm-Message-State: AFuF++m3JUX84/KGZOsSqzlQzHf9Yj9IX/Gx42NsRF/590p8bDGXAKQr
	gO070hG1Dp92L5yxQ62YRJynq76IkdeBQJeyfLph1m8pBqMVxbSFYRbRTv5EqLHEEA==
X-Gm-Gg: AYBFou22qCavR4IcYGGmGYdDwkN1oOOW6v/ehdsOIM0NlIbeOjBw0OsaTTYHzg0z0vS
	kaIrdTba6tXLS+KUIrfeehfA0xo5HvKNCBavgqJ3UjOyyHM4U1++CHf2ZtYB2ravoPuE0LBRyB8
	e42uDW10Z9obZ70XdVZsla6HR3KI1LRpDOoZdTOBg1dwVmiDosyitLZS+bFo1fhjtWMNnq0jMJh
	q0iihJU0XL/sFWAx8cT/Sq6VEN1Elj5jHkjMwqRlNBlRDj+QPKTxh/sqIdxpA54001pdDo1O9hy
	jvsh8LADqVd/+iElB7AmYhg9CxAV4WhpYIh/1YPn5qeyBASxiZO6TlS4Mw8yfI9cmO6M/PvUviX
	Mn/gxjeanlK7p5zvGFy/Pw8rxKo5Q8Z9rcFyQZP66e6QOi4VAu1AQXPsZfWRiZO/OYc7H8xCf2u
	kjPVKexApT6GXQe2uH0f3sbc9tod0ZbGN/J9g5boWPpjAOmGUKYyoAJ8Md3fva+5m4oldorr0fw
	GcCikqiitmnLEuDd+4Hkvrnv477c77b
X-Received: by 2002:ac8:5a01:0:b0:532:be46:5b07 with SMTP id d75a77b69052e-53374abf22amr13892561cf.23.1790761859955;
        Wed, 30 Sep 2026 02:50:59 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53374118024sm7797121cf.26.2026.09.30.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:50:59 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: joe@dama.to
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	hengyul@cs.unc.edu,
	horms@kernel.org,
	jack@suse.cz,
	jirislaby@kernel.org,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Date: Wed, 30 Sep 2026 05:50:58 -0400
Message-ID: <20260930095058.1062123-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
References: <arWdMDek0iv0obDy@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 5:59 AM Joe Damato <joe@dama.to> wrote:
>
> On Thu, Sep 24, 2026 at 02:57:47PM -0400, hengyul@cs.unc.edu wrote:

[...]

> >       default:
> > -             ret = -EINVAL;
> > +             ret = -ENOIOCTLCMD;
> >               break;
> >       }
>
> I think based on the documentation this is probably right, but I am now
> wondering why both ep_eventpoll_ioctl and ep_eventpoll_bp_ioctl need to
> exist.
>
> Maybe when I first implemented this I thought it made sense to factor
> out the busy poll ioctls into their own function, but in retrospect maybe
> it's cleaner to just collapse the ioctl function into a single one
> instead of having two layers?
>
> In other words, maybe:
>   - delete ep_eventpoll_ioctl
>   - add the is_file_epoll check to ep_eventpoll_bp_ioctl
>   - rename ep_eventpoll_bp_ioctl to ep_eventpoll_ioctl
>   - fix the test (as you did in this version of the patch)
>
> Would result in a cleaner fewer helpers / cleaner code ?

Thanks for taking a look. Agreed, a single handler would be cleaner.
Two things I noticed while looking into it:

1. With CONFIG_NET_RX_BUSY_POLL=n, ep_eventpoll_bp_ioctl() is the stub
   that returns -EOPNOTSUPP for every command. If it became the
   .unlocked_ioctl handler as is, every ioctl on an epoll fd would fail
   with EOPNOTSUPP on those kernels, which is the same problem in a
   different config. So the stub would need to keep a small switch:

    static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd,
                                   unsigned long arg)
    {
        switch (cmd) {
        case EPIOCSPARAMS:
        case EPIOCGPARAMS:
            return -EOPNOTSUPP;
        default:
            return -ENOIOCTLCMD;
        }
    }

2. The is_file_epoll() check cannot fail there: the handler is only
   reachable through eventpoll_fops, so file->f_op is always
   &eventpoll_fops. Unless you would like to keep it as a defensive
   check, I'd drop it rather than move it.

Since this changes the errno userspace sees and 18e2bf0edf4d is in
6.12 and 6.18, I'd like to keep the fix itself minimal so it backports
cleanly. How about a two-patch v2:

  1/2 this patch unchanged (Fixes: 18e2bf0edf4d)
  2/2 fold ep_eventpoll_bp_ioctl() into ep_eventpoll_ioctl() as you
      suggested, no functional change

If you'd prefer a single patch, I'm happy to do that instead.
