Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342567;
	b=gVmZveichZe74hNb5MKDkW5T8st5OEmy/QSPZfEbg0fJ3EeKDr7UOUS2kMYFNPSDQ3pe
	 FfiafPy45WRQ1T6Ulrd/Cf/D/s8lpo/QXmzN9gatQ275GdmXBUrJs91dcm9YZGuxgkejg
	 UaXLrQrMGjALEYsLbThFy/A2+qTwg7CDCDNu33xvPufKJHIO4LobsmD0VSKmJLoEElW8Y
	 6IJi2PEjbl+2muKrXLy+sSE2im6bd4QZPdIk93C8097YV04xzPQoKCbLh+pxaqT9OnNoY
	 3Webr10raRsMeVyVbrJx/D2FN05Qwa0sdCC54g4L17n+y1IoPqdDJAjUsqob36TErag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=yaHRCTRFiHcMC3zscSmooVqj/PwhaSMo17fIfMvXXa0=;
	b=gt8iloH1s/itXxa+jz7aoQKbe3o9lM4I3ILT4dXgEROjPOm+OUTuFp/n+H8HTnC3i1PI
	 wOlqV0OcCHOPx1QAlB8vcmC7jRyYP4QnRdOXqMAw3jBYeJXAisBuvNFhiP7Elq1+RZtg3
	 EN5wRWcRaFiJC6gL6Vof7wiWIXvQznbnahUKKV+Kbf/GzT4SxDyqkazUjw9TLpwLh+zxm
	 SGTsFVz9E6wdD3SMC8p2M3hlPBuSLJDDIQkBfIB/CmO7T0nrnKsZe8nI1RsNJuLR9+ds0
	 tXwONBGAyu8Wnx0kkzQV5OYjzoISTsH255vL49sUyb5ADhBPc9xdAHal1AbMl1+de/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vl0KSw8Z;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E1606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vl0KSw8Z
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso943683eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793342566; x=1793947366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yaHRCTRFiHcMC3zscSmooVqj/PwhaSMo17fIfMvXXa0=;
        b=Vl0KSw8ZV6QKNH9FGUFa5jggHziOsVVyb6CQsA8DGb/aKzfpQaD6JJo/z2L/kJLOa3
         sT69waWLqJGBnEQNef7aoOp+IgbHSVC1FfNb1+HlC1jUKfN7G4fG0Tbt3le1cAQE5UuY
         DQORJgUdG3B2DJJ4d+3Hp0SiiYXb0QWYyi+jDYwqjGI9U6BncFfwRAlnfewS3hcidCiu
         3QTrwSDSDWElYL7yntLpHISmxXtQnmGpg665s30fqakV4hd0ccLT8AbOBA28fLgw9Y2E
         YoCtwgESkAAriclTSCfLwWxaBKhJO3hwn2STO2TtmO2vMCjORi871HY0ZnQWn/lc+2CG
         /RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793342566; x=1793947366;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yaHRCTRFiHcMC3zscSmooVqj/PwhaSMo17fIfMvXXa0=;
        b=0QI2VVxA/IW286jkAWpa/9Z2OhA7+G4DqU3SACqub9qFGqFh3sBnZTMm7c9VXOdTvC
         iZieLq/NxYGbI8AQJ1Ut4Iedowo+tFZQ3Kw265U+mOkLolQdJws9BzZd1pHtNdM5AKep
         lpU55YYH95ii4ttptmFDOuVQSz8lmv6OAAfQEwKtOZ2oS0Do61/Wmqazh6o+DPnydpAS
         nBzT67P/RcfmpOV7gdMSjJvGKlltqY01jelEFCyLtcQKhXpTzF8mBMTAJRNIgNuwm6ah
         3vTpoISAsqZO/KYIa6hWLumGYNklADbktwNaWCceHER9jFnHYYfq0CS4Nzf3oksMBQaI
         AeIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4joAGSUAX2g0loIF6Of5tKl/FC6KcQlkNNbtmCs6CoFgzCmPwLSgvopBwJ/9ryW7Q4vVtx2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1ROHiEMLNfRSQTSfOC64ZSUgGnCLUTanXZqvIMVD6cisREhOD
	A0HE3xIkEbccbI60lsD6Z7Zd6Uu40rc6yltTuuqH050ojFCNGONCPY/BFZE3zJ4RcGTlOr2ldzS
	8HZESWu84GEBtQ3U1W6NjUsf1HA==
X-Received: from dyblz5.prod.google.com ([2002:a05:7301:1605:b0:36a:120e:b9a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id 5a478bee46e88-36a424988abmr2675719eec.41.1793342566121;
 Thu, 29 Oct 2026 23:42:46 -0700 (PDT)
Date: Fri, 30 Oct 2026 06:42:45 +0000
In-Reply-To: <auP7VyY3MGqOphL-@bogon>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030001444.289973-1-omermetekaya0@gmail.com> <auP7VyY3MGqOphL-@bogon>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030064245.4118081-1-almasrymina@google.com>
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
From: Mina Almasry <almasrymina@google.com>
To: Hangbin Liu <hangbin.liu@linux.dev>, 
	"=?UTF-8?Q?=C3=96mer_Mete_Kaya?=" <omermetekaya0@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Joas Antonio dos Santos <joasantonio108@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:05=E2=80=AFAM Hangbin Liu <hangbin.liu@linux.dev>=
 wrote:
>
> Looks Joas has a same issue fix with yours a few hour earlier.
>
> https://lore.kernel.org/netdev/179324296598.34505.11070163314749859668@gm=
ail.com/
>
> > ---
> > Tested with syzbot C reproducer.
> > v2: drop Cc:stable and target net-next.
...
> But yours have an extra guard in nsim_drv_port_add...
>
> Leave this to Jakub decide...

I prefer =C3=96mer's version. Once reload_down has torn down the device and
reload_up has failed, the device is in an uninitialized state, so
rejecting new_port in nsim_drv_port_add() makes more sense than
allowing ports/netdevs to be registered on a half-torn-down nsim_dev
and only cleaning them up later.

--=20
Thanks,
Mina
