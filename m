Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9548FF9C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460400; cv=pass; b=kieDTE7HwwDBIiqJ56xLFn35rnYK7dJXDxFzIXwCPMwkPtYacM51dCH7Er9y+iUTyeeydmEHKAKnDGg9oF3PvMtvdzgaaqOZNllYgMbN9garZsUNOV2mtD3vrU9b/8gBRmIkCYgHhFPAlH8C8qbNfzZqFuhFMf74/97m/mfNSbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460400; c=relaxed/simple;
	bh=FzppzYaDCjOxWZvaftAO5bxEFjdXLVVW2QJHrTpRelA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8vfndjVUh2LZbn5WM7h7/JiNXudq8CDcxRuuyKsqTtI72AZKQ6rJ4anMWsPl4S8hLeLuVWehWQOrE9X0dd1WTbP38n8UIvr0DdLKOW0mQlaCztbT8TRE1Up0DVV3Z59qRyCG213eg/n5Yj0aVDarKlSYCk9wr3PshQf4twTjPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vReNdKdH; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vReNdKdH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-892734ce7e6so741833b3a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 04:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791460398; cv=none;
        d=google.com; s=arc-20260327;
        b=OAKMh6/ukyweRbccAkALSbn/3XNvEsxV76DnVER7r9/zGTxo8OvjXP8P2NE0dR2VWn
         DcuxN+0uZ9rF5dchMpdIEDqlmaLDVgtBwEgE3LDoEe0lV0cNyKDKtcMIIzIUTSfQsvIW
         YofdjKpn5Cl8qLFVfkJUcY4g7OTdSeX+OoImFATaqtOnWbnrbu4Mrosbd3R9zAqUWKPD
         jzw9X6oc132v/2e8/3mdoW0yMZCEJZF7sQWDHuYYV412QOjUHBLOQcRlo5jpxZgDMZOr
         2HUp8frdPBmfT1yMCd3Tz4sp9Y3TkGPbxOR0xJ08ah1a4eJVZuGrsATcI86IHEDE5JGA
         WMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRL6Bf+Qw4xAoYNeNpyMde3c0uugUPPjyJFfTktEhjE=;
        fh=UBYzOyCo1jrUVJ8tY1iYOKD9ctV4JlKyfsY3bJ9K7vs=;
        b=NyzccTBk3BsN9aLF8dSD1ClpbreSGdL8MBhUCdZJYwdtEsb4wSstuzSZ2u+PIJAlmb
         KFXg4IFyKAiLDHKWSLG5l1f2AONfOQbg5vTj6l8mrjBIAZiEAJnQ4mqxIpBOPDO8SYOT
         vCrZwL+SLTbR4zK4oKbPyUk6Cbx/SmLUMeUVewA75AJrZ1KmBVBPP3NCaa1xHPLEpT87
         yKAd8WgkwT/+RrjEA2gxJhomOtl54TsV3sDCCPblITj+/11RdGSBnzFgvIgUBeXsExf5
         pfVn4T2cEel/9MLs+83yWfejn3qmMmlRmfnEvI4ihGzZHcfmeeLvMODfd3rs60Ytq9T6
         B5+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791460398; x=1792065198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRL6Bf+Qw4xAoYNeNpyMde3c0uugUPPjyJFfTktEhjE=;
        b=vReNdKdHf9q9yyuSE0ycKIrsgR8Snl9qDjj0bw6BtBu7A6NbiTZUagCEtlxRYLyG8z
         LWSq3Wd3pz/I2/LSWHfLwbvFJilJMsXEl6HGXq1wKq8tZ4IaKRcP3jDCK8+zznN0iaUS
         PrlCSREAhcnbUw0EuJnrlf6BOoDi5a2erb1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460398; x=1792065198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRL6Bf+Qw4xAoYNeNpyMde3c0uugUPPjyJFfTktEhjE=;
        b=ZT8BiWhBGMNqgxubf3FCGutTAV3cRHc4iDuOYqVFrcv3dtADxMvTFLx6fTG8axa7Pq
         ryPhML8HlMCXiTslY8mrapqqx+yWIWk0846ldOuzyylLaAGawMgdYKviijMiyBoZZM4F
         uOg1e1e0uP81ehc59ImBVd9zSardDUCbyax0RrkAVn7Mx4ncriqxfpxuSuF+QLKK8CBL
         jcYHulYagEh4kh+NaITfI3KfDAy0fgqSbyS4zzo3NKzX4SuHLGTF+9r3jshZys+HzIlW
         /2UuGI2PH3bLfAjU76U3v4lRq9LGK0y7LDx7VDz7yk7wH+SiZOLjD9uUarxOgohv6mUx
         DG8Q==
X-Gm-Message-State: AFuF++kbqhoTJITHWuFJF0x2nc75ZsOk2CWkDgqaUerYiO+TTo8yTXtc
	Mchhyh6nhCo4TChh10wMPrVNX1peetiwktobSD7hX5ZsaaoCW7Vh0PR33S7w91VxhgYOzK+BIyi
	Qz14OPtcsBIowzgMidW9NFoKQCeeJEPS/yWP6s1jF2RnlBBzNycSqZYtO
X-Gm-Gg: AYBFou3I5Xoe0I2t0hBV2K6Kz9oDlxspp4Ltd5C0Gm9PXhc+GxDnTBhaWyTpGPdUKfR
	VrL4JjxTlmpqp6PFYhSg4CLb/PLvcfAbkItVXrmTEuSmPMC+KtAWYQGXFIXlHXnqLsBUOp/Kx9L
	wLfQDkhYACeiUx+K5Hk7k2I1qimh1/gfRTACHSP2nrteghod2KbY8g5nYMALqfFV2L5Pfi92IWb
	foZr6yu9u+wbt/GbjGfJWuUHC2sjF8yXy9ReIo8expA9gU1u1WLZtkhtnxIozpC6BqYJIP5ur52
	+bl2K6rtDTguS745AwRMQfaXgSXqLnoEoRXy7FYx/x4xAkXGhQNzlM7GPg07Igl7zZJtFlgRMga
	a2dKkioe59e8fWXmykx8eoSQDhonimVOqtkvWpkFuASnfOyuN3g==
X-Received: by 2002:a05:6a00:a1d:b0:880:bc88:2d3e with SMTP id
 d2e1a72fcca58-891b4703ca8mr4419452b3a.40.1791460397989; Thu, 08 Oct 2026
 04:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com> <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
 <875wzctsky.fsf@toke.dk>
In-Reply-To: <875wzctsky.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Oct 2026 07:53:03 -0400
X-Gm-Features: AclHuK9lflExpmSt1JGeT2o2g72F83KaX2SJtuQW3iKN25CF5ESdWbcOp19iBIk
Message-ID: <CAM0EoMk2nKEaywg0fa6bwKxdAH8kp7dKfxHq2unZi=Qd7HBttg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 6:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> > The qdisc is left with autorate disabled but with the estimate installe=
d
> > instead of X.  On 32-bit machines the unlocked 64-bit rate_bps store is
> > also not atomic, so a reader can observe a torn rate.  iproute2 reaches
> > this because parsing 'bandwidth X' sets autorate =3D 0 and emits both
> > TCA_CAKE_BASE_RATE64 and TCA_CAKE_AUTORATE.
> >
> > Commit the parsed configuration and reconfigure while holding the same
> > qdisc lock that serializes the datapath, so the netlink writer and the
> > autorate writer can no longer interleave.  Make rate_bps an atomic64_t
> > so a 64-bit rate update is atomic on 32-bit machines as well, and keep
> > the READ_ONCE()/WRITE_ONCE() annotations for the remaining lockless
> > readers (cake_config_dump(), which runs without the lock, and the
> > cake_mq shared config, which readers observe under different child
> > locks).
>
> So atomic_t.txt has this section:
>
> "SEMANTICS
> ---------
>
> Non-RMW ops:
>
> The non-RMW ops are (typically) regular LOADs and STOREs and are canonica=
lly
> implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> smp_store_release() respectively. Therefore, if you find yourself only us=
ing
> the Non-RMW operations of atomic_t, you do not in fact need atomic_t at a=
ll
> and are doing it wrong."
>
>
> So AFAICT, we don't need atomic_t, we just need READ/WRITE_ONCE()
> annotations?
>

hrm. actually, the sch_tree_lock() already protects cake_change(): it
commits the parsed config and reconfigures together with the datapath
under the same qdisc lock, so the netlink writer and the autorate
store can no longer interleave. So the atomic64_t was never needed for
the lost update.

on the atomic_t.txt point you pointed out: rate_bps takes only non-RMW
ops, so per SEMANTICS it should be a plain u64 with
READ_ONCE()/WRITE_ONCE(). I'll drop the atomic64_t.

The only lockless readers left are cake_config_dump() (cosmetic) and
the cake_mq shared config, which a child reads while holding a
different child's lock than the parent writes it under - on 32-bit
READ_ONCE() on a u64 can tear there. It's an advisory rate that
self-corrects on the next sync interval, so best-effort is fine.

I will resend a v2 with rate_bps as u64 + READ/WRITE_ONCE. Let's wait
for Sashiko first - it will always find something to complain about.

cheers,
jamal
