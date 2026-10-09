Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B85547065
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527027; cv=none; b=SqYq/qKTMcYhozDmOnT7gp0QIlSh6Do8FmRCZDOaFFuQNw9TLxHQhFLdIOjpwKvp9yXStPbPINj8m77vM2D3kEoWii55Nc2gAlQi4M6DPrTvtO40E3rnF4CoiN5oZQ0Uxa7f14px9u7HNdXhk0pY5BCBOcg06t1nvpQmnwBv1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527027; c=relaxed/simple;
	bh=C1KVr0mKhkmh4Kx3MhX4EslM4YYpLSwMpGhSZ+qRUKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARQ1bc73P0rlRlsWxo+ebsBfU/xfcR2yuRhJ83c6pMCKTOoosoozdglOFsJXsDpCCnN2CcWQJdpgDzfcusnKnceh7qKjcYoud1Yx7MREIf4gicpgXzZw0oZzGPek2hxqQuJR+szM0ZIfOcurGqNITRwGyLrM8H6TzbLqmeYqYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX00/NoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX00/NoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA61F0089C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527026;
	bh=jytX8cvR9WRUcnexUA08Wfow87yvlI+RrObS950u058=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GX00/NoWB3RMAJAn5RzeSWo1dx8Od64LvGPXWuo1W21EugI4wslFDaoEpgc63kzAo
	 0VUwqKkf3QSqkWOKseLEKx7mFFHosbIpN3knIwTO7Ov1Hq3J4Aj0Zd7ZBZ0Y76VpuP
	 xiTooM653cUIUMz80vu8Xednxqs8YmMiOS6uNHdVJ8xkdV41eVzU2oAlR1XxW0W2tN
	 9dpcQu6aPx4KuEz8TtY4+fw9MR9hjIoLHpC0nxBW4qJtkNRwsAC6sQc0YD+cs7VTt2
	 jgPfUqgM+0h0oGABDUqki2aprWX6p3iqRhlmpKKtb0tnOtkPAbTO93NJ7wGDzfJnBT
	 Hk+TFyvlJAqiw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4877837890fso2206739fac.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:23:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCEuODTyzxh0QtemnK4UgGWwR7To1Oy7GzpYh3Z8Jk9lYaXC5Zow2/9kfQuEnF4RZ9F7gxqkk=@vger.kernel.org
X-Gm-Message-State: AFuF++nZiJfwTf0eHpf0kOWd1dWeRLqMonZAnGqVEPmzbQzcXogOI9CE
	rUOeFjJXoD6oox14oMCPlEM+zEzWO1KOe0+NwobY0o28JiOeNDmrZfSGel+hDA8MFrIw1TsQf+5
	5r+riAgkGwUFeOefiOZzaUiyVwEEcuro=
X-Received: by 2002:a05:6870:e243:b0:48f:e0e5:a1e8 with SMTP id
 586e51a60fabf-4a2a8a692aamr926527fac.45.1791527025612; Thu, 08 Oct 2026
 23:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009051703.3615846-1-acassen@corp.free.fr>
In-Reply-To: <20261009051703.3615846-1-acassen@corp.free.fr>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 9 Oct 2026 08:23:33 +0200
X-Gmail-Original-Message-ID: <CAL4WiioQe5771piTNEwsnru6wsWDBp2fKcbh0BSbOhuKsZOnVA@mail.gmail.com>
X-Gm-Features: AclHuK9rMw3o0zqVghWrHtPGHEqCvmpR-mpm85ALNelfgFXiiPK9BeVPp4v7ePQ
Message-ID: <CAL4WiioQe5771piTNEwsnru6wsWDBp2fKcbh0BSbOhuKsZOnVA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: take tcfa_lock for hardware stats updates
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre

Le ven. 9 oct. 2026 =C3=A0 07:17, Alexandre Cassen <acassen@corp.free.fr> a=
 =C3=A9crit :
>
> Actions without per CPU stats update their counters under tcfa_lock in
> the software path but tcf_action_update_stats() adds hardware stats to
> the same counters without it. An offloaded action that also runs in
> software can then lose counter updates. On 32-bit the race can also
> leave the u64_stats seqcount odd and make its readers spin forever.

The last sentence is not accurate.

Nobody reads the seqcount of tcfa_bstats / tcfa_bstats_hw:

- tcf_action_copy_stats() calls gnet_stats_copy_basic() and
  gnet_stats_copy_basic_hw() with running =3D=3D false.

- The estimator is registered with running =3D=3D false
  (gen_new_estimator() in tcf_idr_create()).

In both cases gnet_stats_read_basic() / gnet_stats_add_basic() skip
u64_stats_fetch_begin()/u64_stats_fetch_retry() and only rely on
tcfa_lock.

This has been the case since gnet_stats_basic_sync was introduced
in 5.16. Older kernels had no seqcount there at all.

So the seqcount can end up odd on 32-bit, but this is harmless.
What 32-bit readers can see is a torn 64-bit value, on top of the
lost updates.

Please fix the changelog in v2, something like:

  On 32-bit, readers holding tcfa_lock can also observe torn
  64-bit values.

The code change itself looks fine to me.

Reviewed-by: Eric Dumazet <edumazet@google.com>

pw-bot: cr
