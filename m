Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1C32B124
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118136; cv=pass; b=M1QTaHiz1wAwljHo8ShZ6IpoWzcfGMkOOLcs/oPMAcFS/uStDIaw+528ti9xc8/+bRcuE7luT59DSSsvcTzSn9ZduHxxg1/Dy4wA/1FexlcoClXXOMPoOeH+DXeUC8lQcPI9k+zf8T6ZZ0PP3YklqBlipQrKUCVt+fDf2O7guSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118136; c=relaxed/simple;
	bh=a/GJm0s4kgIYCzqhy25/EJFLUDRvXUMnA3p3QQFlRoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRkD7nbQ5ZqydqEuGSukgorivKwXf1yLIKSvQ8u/Fgq1Zz3tnRwKOnvYYWfhg8AQRPDpePezbzJHpv0koKjvXnSKcXGFX1tm5kurx0qXuQ6YWT7FNctclof6L8pegt7duqtvAJDAJC+sTRfGRWEreXsU86PUAQHnPYHJ6BCnwoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=N1oq8Jjl; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="N1oq8Jjl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68cf9123so7575137e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118134; cv=none;
        d=google.com; s=arc-20240605;
        b=ZA5TNSZIKYYrpQ+lVGmYV6/4j0sxoqCx4xClqOhR1XG+yx872ayyBGb8+LjI5kKxaJ
         k0o48ja4ftvu6kzUuY0FyQ7Ijb9CNs93yqu4y+lMQrYOdPtlRkgHTleSFtqI4LjJM/E6
         vai6NsZIkCZlJh467o+Hmi6jAfMQc/7w2hvjEtj982BaiSJInmWTP1nVB+mDP/hGK9DP
         BSD3vvQGuj04llfpySYPLcwVUS8ZbxWvnYvBQhtHVS61Nm/C3S2g14+pHbYAe/x0UC/a
         2PqicFMNBvpZ+7WiZ9JyfUp1++djCfgNHNOSxPvw3xnOMlFCn6QdQNJI7hS7deYui0M4
         J/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTbMdvXx+EQ2sgHTTh7GdEKMQ8cZ80HdcbVpfY3oTJA=;
        fh=9Cdzp0hKJ45Gw05zpQVY0pgHSoHI014alIsSwBDKuWE=;
        b=AVppcu+IRgd0T7S8kl7leFZcOGdJJ9yGF8XklSeYrK1WTU1YTVdQEAz3szk5S5bIKn
         AReo0jNtnAv+rgTajYMk8lYUlR0xhwcrmlY4RU8IwXBog57r8Lg2m7X3tlr9WYfPhlVC
         dNqCmYkTjG7ska5XYPvN9Ct6sSbbUVdgXJs/VlrkWqAOHqkeX6BWaBfLcnr4H1a0gd1M
         mXHrbsGqvgMsIHgzTLA25wHD+ODulW5UK4Vjh/k1/PFmN27x12+d81HdK9DXEJH0fuFL
         AtgMtBwj671Y2Jinp+qi3eLbxPyhz+kDyQrTS1Go9UFYLslUBaStak/fEhubU8CDmQLR
         jbrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118134; x=1781722934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTbMdvXx+EQ2sgHTTh7GdEKMQ8cZ80HdcbVpfY3oTJA=;
        b=N1oq8Jjl8EaHLGg7pb4WxLUGrTlMUMlGMMLYt3i7bUk7uIm3WN49iK2ZwPKmR0gVND
         kwE/GOYZUBpeRP5AKqk1uk5y1/YipAO496Kytjr6qdHlNCxY7ljwz9VtOtfIchpkDc03
         EJWSEUhY+l/6B6uBxOwe8pTev6zBc0dmPmNSSyydvWpZ+WxuTCBmWkGeC7kt3/xGYsw0
         yPOGt5lmlf0ofxchs/K7JvxsLf5kCN7/hwDMTQ+nfpB5oa8x87AGTLDi4xdWsX/1V7rf
         RvIF6ndOVUmC1Tx5rCbFWIYPOq3z/UpxALs8jFd9OJ5LjLxEMrtKBRgDXhqjGPt+Mz3U
         fTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118134; x=1781722934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTbMdvXx+EQ2sgHTTh7GdEKMQ8cZ80HdcbVpfY3oTJA=;
        b=sPKTC1qL5MCLGOdVYuIheidpPdTmhCKofBT0ojoxfQ1ttJSAXXXiiXSs/hSGd5ol4b
         iuKzEnWZxMu27TJrYHSz1jJ/49PUP5mPa10ChyfgaAMbxZQxyKTCqua11BfMcfh7w0Nj
         2AbCyzsrbyhLFFbC5cFsLmtqYCbkIP5nC3k40cm4dU2OfVuuQYr2z+BZtM+xnXwa+Am3
         dMfFDp+CAOvTf6dbnSdDTYaCOkbZkuiuUgVD+Z7Jn+66RErh/w5zIAviTyMjkHriQNHp
         sJaccMPfSE77o+tmaCOpD55s7HE1WCAhXKCpvdhxoODn3zGjOQiRf6aHmsPUA9F3BiUw
         nhDw==
X-Forwarded-Encrypted: i=1; AFNElJ972zJruh5EsM8iddzP2mfjRUSeCis8KkWyeLmpz1B/jnysf9TQdrwylzBA43X/Z72BHZVRNUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPyZwreq3W+7qRaSAUd6vvA2CTwWZh/XsH1j5UKqDzsl/dVLe
	GUTVGg456i57bCz9IAHtbw5cpMM6Ts93l0EcwISZ2rQqpvOqMppj+zmZ/b/LYubPp2jnPIwxNtY
	+2UWsCGzHicW/m3yPtYMRN+JJBQS/TT5UyIQMSVI33w==
X-Gm-Gg: Acq92OHqBQmEysINp3cL0/hlHoZ1rxU6P7x5tv2UyxsA5/24ORana+M5zw3RM/jaC6J
	SUNapNATZ5tUIF+9gr7Ew6U9mfwP+9ceCPGQWBlIlipAO9YYP2+Fhl7t/SLsunzjXBQbRtbCeN5
	fk987J3ZyB1hByzNpU497CQAHQkU5xqvTIO1ldT42JcHN3o+Plpc+/MMxtoFWAXty8d7WDejyOw
	HAVfSdxsBfMRfeqk6tDtFEcuVMF01VOouDMkmRnp6YMeffkYrI3cySH6EpaO90bFjPtwXpci279
	ZvRzM3PcH73Znhau
X-Received: by 2002:a05:6512:401f:b0:5aa:6f89:9375 with SMTP id
 2adb3069b0e04-5aa87c2dc8emr7241316e87.29.1781118133711; Wed, 10 Jun 2026
 12:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609001013.1234755.d884b9e2028f.codel-limit-zero-bypass@trailofbits.com>
 <CANn89iJdrwPtMkexacercdV+2qDAZ=JYwGjW8xA1aKZTk3muhg@mail.gmail.com>
In-Reply-To: <CANn89iJdrwPtMkexacercdV+2qDAZ=JYwGjW8xA1aKZTk3muhg@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:02:02 -0400
X-Gm-Features: AVVi8Cfnt34IFVoATneLn-yCEOuvoLhgT8c1KaPkUinLW1w0Nks69_sLU-K1oD0
Message-ID: <CAE+C+DYBcVmH-1_0BHS9asdZsM0GrAi-BeyYY0=8Jkh0+aO4ZQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: codel: refresh CAN_BYPASS when limit changes
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jun 8, 2026 at 5:12=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > sch_codel and sch_fq_codel update their packet limit without refreshing
> > the queue bypass state.  Changing the limit to zero can leave CAN_BYPAS=
S
> > set from the previous configuration.
> >
> > The enqueue path can then bypass limit enforcement even though the new
> > limit should prevent queued packets.
> >
> > Recompute the bypass flag whenever the configured limit changes.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
>
> We can't change sch->flags in a change() method even under qdisc
> spinlock, look at __dev_xmit_skb() which reads q->flags locklessly.
>
> pw-bot: cr

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
