Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53342FCB5
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459200; cv=pass; b=sqsQDDv2PgvpWACK/pjLqMaSmjJ4fZ2zPIr81ZC1IIlM8aT0MCArYxqBRvRCDs6WtFps2b8HvvNmy3XBQpDHCXOp1cNv1wfwgMNg3+Y+zonxf1Kn1UrHDHcZbO34lDUeq1UYbwyCnzLqMgxUPw7YzlXEi7r0MErU1CghJ9zIwV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459200; c=relaxed/simple;
	bh=nVPVR0zRjjQCzRypL5OmiHULMHmTyGcRwmfzDYDhGQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5kcpFaIjGnrImGtAMubez0fCIxyZ4IPxTjKH9L1xgpLES3i/q0jTjU+6eVFnxofcq+vD9+LtcTw0m7ypzLWR37sjiToL1S2pMLWaWP7SbU9jzQqiGEKin6E1kg77lSTzoDCfAyjaB8lXXzFyHWky4E5bpey6Tqg2SUD7PQ2iqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbgbTNy9; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbgbTNy9"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2689782a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786459194; cv=none;
        d=google.com; s=arc-20260327;
        b=Lpw6jGCwjPfvp5JsnJ3GkK6tRIbqg4N0FAHGhjA2Tqm1ODwyYqtvP9zcF51vrzTngD
         4Zk8DiN5hQz2EoO8LRxQKzZzzme9CC4BURfQFPt0V4eZPvEEfE85hGKM9WBKBZibG7lC
         ttPRD0DA/IKZE1mBzjO/IxY08gIsnMiooV3xhmY11z2qM1xgxLSbemkPwSSX+aaIfrBP
         Q08dlxMb1mRExdkefSvN5BbidkY58E/1vTRI+GbJCBI88KGNOgfS7b7Y9Z6OS6Nma9i4
         35P9z09BdQPYUB2h9uq4E67AnyridPocXSHxe4LU1PHpD4JT195C3bvYeAp2tFhE1Wqq
         FhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        fh=go5U/0VX/JUOsrl0Kokh8WOQ66faXoht8yMJXAt+0S0=;
        b=pL5wlgRRilOSoQlapVrTuWVGW4BpKQtmbSKFe0B31uTgfyQ4rTO1zUzXlC5oOW/su3
         n/+kmaGQjbHvLBbJa7JVLsdvHaTzBhHTJXo2agPwMSnqP3Q8/lVmQzYLkTW7dG9eqZLW
         vyuJcRj5xTjgMJWx+vpJfCJQnHDeh9c+B8+Snn+l2Y04yMhoTnKOgLpGb/+6aLXELUgE
         VshWMojRufm4cvrHBE7fuOzs7WrHH9i2jTgCFpZHYOTMlUALgMIpoLCTqKG+RfXDzof4
         2dv3W79dDoPzjy0dIbNuAldBjB1remrjsbqe8r6DjVtBjr5EY64MOh3yT9F7ZpRIHR8W
         qA4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459194; x=1787063994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        b=sbgbTNy9UYtTRAcqN8BeJQlafBsB3Gh7kusVWcOH53pF+N+MyxfV1qzu2tNJmnYwI6
         WVHm5fjopwSiPIxYWFClnT8mT/wc9CyCEqVhHaDfwcPcvYuAAhnu8nZx3X5xJbwfTUDg
         2l5lD/wHanUIJc9BDZqoJ6w03EIH5ObPG5erIUnfq0LIQgTfG306tX6EchiJ6YZ+Gf7P
         onb/BfQ8HunDXaHOlocJTXlPABD/7cf77fZxB+iw9F//lTvzPDEVnuCvo094/w5nRfk9
         XYjkFuVcdP0xc4sKR2l32k9vhMmtBXFrMX7khM1aWPAuB8phcDPJHahC78mH2u/nD00I
         phzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459194; x=1787063994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+dl9fZXRnYwGtmGEJgrmW0ZxaoVPhl9+scQqWpDRGQ=;
        b=sJNJd2odB0sdKkeOLdzy/ZdJ6PnfSk/ZSxtaKBrOEZcrdtULLBE7EYdoHVHreAVkM0
         xUi2rmmAR2CbFJbf0YbkSeJTcwUyh7yRWtCjhPofZAx9n7G3CenXDPXNtXSwdnwK99Wa
         2dWF9cM1hH1W6nmC5wdagdO49cBhbuxXREgMc0VfE9iP4BVHE8L7PLSTJaEATtOS/OHY
         wvdYOoFkrU4Pplkz5nD3eGLMRzx2KcAiNqtMfOYuDsFYZgHuFHWA5o2G0SAA2QttPtxm
         rLYwUDYTPg+isNWeo86+akqjMbHZjwAZJN7/yGrZ4z1TRbH7ERkw5xikkS3JRmI3ejne
         Qoaw==
X-Forwarded-Encrypted: i=1; AHgh+RoIhk1DcoCUlqvmcN0Y6mwOKDl6mbLjJOVhiN7MMjy+7lbRbeCtPMIeCkHYi1UIrGF820bE9+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56im9qsFwMnYSjc3zgVq3gxRQgKCYdJGNQZbCafuwLPF9gWzM
	r4DQNIFtchTESPWqnfsdUZD/XJ8ORE66e5y6aLNTEhPKLw8F11ciSK7EXZjeFACjUVO1kmHQFP8
	lXQ1AhKmd/L2H8Uw/aenOfQZSuV5IaV8=
X-Gm-Gg: AR+sD1246z+eM+hGkHm8q2nl4Dk9QtlYr3NwsodL33TUSveoe24gi6iUch5o6oqdM7K
	bBfRDN1Tln1o99Qa2peW4ejcOtX3LbYSXjqnU4aLd83nw9qzK8XUBdHEUPJQt7wk3iVGWSxmnlo
	ogMHJ40Bbx9FGqPiVquD5OkT1OZ31PvCOp1Qkwe1ZEftzMasBsAZ8A/43z9MV0t2XgqfaQqV1T2
	Jtke/zr/a37y4DIZcF0NlOh7dHop6GONsOqx1bXLXou5JLBEpqM53Ch4+TQsfq8ccvK62bPg8lL
	s+1VDY3P1Jt/iPLnNXB7qORsiqAvDSO684hJeW543cbEFXD87JgzzYLw01wjqCGERURVCFJwRkK
	wKawZbHF41eeHbynse9Ts0CRJn9iMRmMXEPace2mS2mAN
X-Received: by 2002:a05:6a00:181b:b0:847:8449:2ba6 with SMTP id
 d2e1a72fcca58-84fa867de2dmr3537170b3a.8.1786459193566; Tue, 11 Aug 2026
 07:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
 <CADvbK_cv+Wkb5r-8_sGnKsuA5tfErvLoiPZYVN=yXALbWfBOGw@mail.gmail.com> <20260810164158.2c6821b3@kernel.org>
In-Reply-To: <20260810164158.2c6821b3@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 11 Aug 2026 10:39:41 -0400
X-Gm-Features: AUfX_mxUqV6zeBTI5OtRJ6DcMDEFwMxz_gmXIIliFx8FhaX6oD2roVpYsRIQPfE
Message-ID: <CADvbK_f+LbCtszU5WJMpAhcYGOu3ReyVrqXx+Tstr+bwkyHueQ@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix use-after-free of cached ASCONF chunk
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Aug 2026 09:09:15 -0400 Xin Long wrote:
> > On Sun, Aug 9, 2026 at 12:38=E2=80=AFAM Yuxiang Yang
> > <yangyx22@mails.tsinghua.edu.cn> wrote:
> > >
> > > addip_last_asconf caches the outstanding outbound ASCONF chunk. The n=
ormal
> > > ASCONF-ACK completion path releases the chunk and clears the pointer.
> > >
> > > However, sctp_asconf_queue_teardown() releases the cached chunk witho=
ut
> > > clearing addip_last_asconf. During peer restart handling,
> > > sctp_sf_do_dupcook_a() queues SCTP_CMD_PURGE_ASCONF_QUEUE, which invo=
kes
> > > sctp_asconf_queue_teardown() while the association remains alive and =
leaves
> > > the pointer dangling.
> > >
> > > A delayed authenticated ASCONF-ACK can then reach sctp_sf_do_asconf_a=
ck(),
> > > which accesses the stale chunk and passes it to sctp_process_asconf_a=
ck(),
> > > causing a use-after-free and a second release.
> > >
> > > Clearing the pointer exposes a race with T4 expiry. Peer restart hand=
ling
> > > queues the timer stop before the purge, but SCTP_CMD_TIMER_STOP uses
> > > timer_delete(), which does not wait for a callback already running on
> > > another CPU. Such a callback can reach sctp_sf_t4_timer_expire() afte=
r
> > > the purge and dereference NULL.
> > >
> > > Clear addip_last_asconf after releasing the cached chunk, and make
> > > sctp_sf_t4_timer_expire() consume a stale T4 expiry if no outstanding
> > > ASCONF remains.
> >
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> Hi! I think *shiko has a different suggestion which it thinks covers
> more cases. Does it make sense?
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809043806.276830=
2-1-yangyx22@mails.tsinghua.edu.cn

These are two pre-existing issues:

- The 1st one needs to clear more state for ADDIP in
  sctp_asconf_queue_teardown(), such as src_out_of_asoc_ok and
  asconf_addr_del_pending.

- The 2nd one needs to check whether the expiry matches the ASCONF it was
  armed for. We may also need to add a new member to the association, such
  as last_addip_serial.

We=E2=80=99ll need some time to reproduce and confirm these issues. Since n=
either
causes a crash (unlike this issue),and the current patch does not make
either of them worse, I think it would be better to address them separately
in later patches.

Thanks.
