Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB532FA2E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934463; cv=none; b=IQkpJDtzSDGiSZjBrqu1OdxGPRl++xeXjY+Qjs8f/TYhCSsm96kQdyRZaVqhQp8ewiE7SQWZVhiDAmVgTZ4LPzmjh10pQIdTEP6urVz+eFudO0R9M4r70k3TjU7OzL+TWi9z+KBhc/OXWRLvX7He2aASVQX4JA3saoNfZhVoNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934463; c=relaxed/simple;
	bh=Ts8u5y43FkUxGVOnBltJQb/YAn0hirg3J7c793j5p54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9CZEcCtkcBSi8cG+oDv9fWxOJACaWA52xJdg2+2hIcibNfezbkwIkaF7Rzeg95O96ARx9BiTwONWIfascr6Jhf8Zy2JfprdQRSRR/6j3HaVk+S2zxx6mStqKoljCHxys26nCRm5rXIdzdN9Pcpq5JKaJi2KtRZRl9wC4iUU33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbD4Jpuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbD4Jpuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D961F00893;
	Mon,  8 Jun 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934462;
	bh=Cd+2dTQEsuVtmckVeu5cIadqjrd3NxxW5x6IS+111+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NbD4Jpujgo+tgnMDUDiZ7fr35vlavVwjfHf/nNm84/7nYtp2+0uEziuYySI39Jy9F
	 nC8ehpQ+rM09jAvhF/SlJgUQqrG+rGUoKA/V9LVR+DfbER4S8yU0bpsXI7rfwImkui
	 b6QCrh79b9IZ0t2syjOiCCJ9pbddWdEHKGjFwyH2xx+X5tD6DAWv6pbUIpnz/06hAX
	 Hr5rZnRfLJ2I+OzemIebZZBaOcE+Fylm98Bwaqsff5NerKFW7BvF6lwIVTWBdvzeRw
	 eHmoMLSXbqpuqAvXVRl4qcJDlw8LSdUizueE5n7gJRm2Wf2hHgyde7MjFlZY8l3GUj
	 yiLJ+jlH+qP+g==
Date: Mon, 8 Jun 2026 09:01:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
 syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: watchdog: fix refcount tracking races
Message-ID: <20260608090101.42b9f43c@kernel.org>
In-Reply-To: <20260608123935.524879-1-edumazet@google.com>
References: <20260608123935.524879-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  8 Jun 2026 12:39:35 +0000 Eric Dumazet wrote:
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).

selftest kernel build says:

net/sched/sch_generic.c: In function =E2=80=98netdev_watchdog_up=E2=80=99:
net/sched/sch_generic.c:594:39: error: incompatible type for argument 1 of =
=E2=80=98IS_ERR_OR_NULL=E2=80=99
  594 |                 if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
      |                                    ~~~^~~~~~~~~~~~~~~~~~~~~~
      |                                       |
      |                                       netdevice_tracker

config:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/682182/co=
nfig
