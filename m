Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3D2D8382
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174047; cv=none; b=lPUWEuMxM4ow7eU01ATnX8BQl1nIcwlEG6OUrSaPRVyYXX1RJvcCAMO7UI0rCpAYa8/Jm5VnHN8y0iJ6pefWy2j0CrEfrDgo+VOT1P1Tqu2bdlooFs03RpJwI7L+d14+R+Ex3D730Z2HCddngb+TvgKKlYsS/sTcyNYSc0Y24w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174047; c=relaxed/simple;
	bh=FkqF8+3mlOmFgqiaG2d7mzyf1qhDRjd/zP+PjjeuGJU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rKSm1GWB/3qcc2GtmDS4bP2bA3kHAjY/f51e2TeuDatJh8wYkACe8gaM+DqkY6/xBqN0Q3fSsM0cS9kOmDr8qQjvLIit52gMtLjWGXg5C5lEyhxJVTvXhfpkwG8WrK32qgiE8T/oKg200oH289HH40bKyUukfxbdpLJhWdNFr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2newKzE; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2newKzE"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66bd7857841so1580804d50.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789174045; x=1789778845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j918tPOZgQD0Pi8ul4Un21B2wbrIXAt3S8K708xHj9I=;
        b=f2newKzE2ou5J037b6JO+wo+X9BRYaLP0wyCPGeVFOeF5lasO6r+TgS7Q5NyLNCi8j
         wPlW08LWS4fosR0GzTUBfhOcUp8HAskQP7R9H49M2Co++U8A/ANHnr/aT2iAW5CS5HEX
         BFfp/Augl+fS5GDWFJb8/2N9PcnTb9Ul+M7wRhHEnWe9yeVsc4BGsa9c6j+3lTZdJQwn
         buxxAYLhC8KyuCbI2ZuDuQumWOjfBkflSNqxiYGS7v7iqaV1MxyT8FSkeKTfu6pBF8Mc
         NUNvVJpmZ9hUdJV5NfunSnuh/c+mQr346PVWyAHirU80U0OM2GHgd0I95C3QsmHSPvGa
         2bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174045; x=1789778845;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j918tPOZgQD0Pi8ul4Un21B2wbrIXAt3S8K708xHj9I=;
        b=TVs4sboEKOvW2FS4kymBMCxyzU27PmwAxEQT4Z3jFUfblcWTgGyzmYIQsU3y1V/ziz
         jqLfXHge6WzJs6j6xbOb9m47RoUFcXW7OoNhgF7AH6Zkd2DzY0SrNMRg5KcfEm0YgISC
         EnlQTcnWP3LiJQGYvpq2AWHZy278k8gf5DELfTrwnionfA5i3amyMR07diicgtfsbdO3
         iKZIde90EcYBiUFFrTFpMoOgV8QsI8on7yoDEdfiVXMky/SumriFvIFnjjkMw4SHsBoo
         KzEtmvvSswBW8ll64FNEGY+UsTwCCcEl1yHnTQZ2MNEZUTlKahx37e7T/tJ2LT1epPxz
         Ee8A==
X-Gm-Message-State: AFuF++m50SF3cnj6x+VICkfXKC+esKPmq6bMBoF7r7XwC/vnOFGyRGN+
	NU78GGXr46z5sAZ4wSucUDsXYefLhWtrR199SE+gCTKXv7dLBcBnx3Bk0/WnLA==
X-Gm-Gg: AYBFou2G+EUghv3mz4CYb/bCwaAMcm+WpjFgUXEQGhIFQcvFRa1AnEe23hoGUMFpQGb
	jEqLTXGE2X2zfYXuZpSyqIdqM4iQ1bqp6nXIaT7Jvn+aoV3I32PwnDR2n+0cK9IyszRgTl6fCEd
	HOneKTh4+8LM7FWju1L3hTYe0DirQKu7HObUwaDjz1zRJVlZ5gq0uaAGW/uO3k6kwm9+RUSJ67/
	Vf63Z8VzLD8q8WDgJjJGKC8+e/fBpyK7MfuIXMMST6CkFoWnSW9teHPNV76PZjH/oJnPh1YXN7m
	p/PjYz9Bx37BnmuQqranAneFim7cLH/SjeDaATvRRxfZr2wKd3Hol+EtmcFbihb+EYQLom4BKnq
	FzTCqrg38n5aztN8iIDAFHIeGhT6hbxgEwx32iEx1XxHCvIU5b2WjmKM0lH4bF8UELZIXyHZ37Z
	edyiZo5fN2uG3/xJ0Ien6wvSClMNZ9Y1Zh9BSfK+bVx8056FrHikzenQWvy0o8MYhVYeebuY/Dt
	ZC5X0lxaZZ/P+eeqpjzLBNoAYBxVuNlljHL5xtMyxs4FcTwRn3qSobRCdP6JRQ=
X-Received: by 2002:a05:690e:4403:b0:66e:582e:f6a1 with SMTP id 956f58d0204a3-671245bc484mr1520468d50.30.1789174044658;
        Fri, 11 Sep 2026 17:47:24 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125b8bf2asm1747833d50.1.2026.09.11.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:47:24 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:47:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.2e348176f4860@gmail.com>
In-Reply-To: <178914679853.219967.10930030898097751336@kernel.org>
References: <20260910171131.2532487-7-willemdebruijn.kernel@gmail.com>
 <178914679853.219967.10930030898097751336@kernel.org>
Subject: Re: [PATCH net-next v9 6/7] selftests: drv-net: in so_txtime tell
 apart sw from hw pacing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> - [Medium] `-H` is documented in usage() as 'verify hardware offload
>   (tx)' and the commit message claims it tells software apart from=E2=80=
=A6
> =

> --
> =

> selftests: drv-net: in so_txtime tell apart sw from hw pacing
> =

> This adds a '-H' flag to so_txtime.c that enables SO_TIMESTAMPING with
> SOF_TIMESTAMPING_TX_SOFTWARE, and flags an error if the software transm=
it
> timestamp is more than cfg_variance_us after the send start time.  It a=
lso
> extends the errqueue polling deadline by cfg_variance_us and sorts the
> getopt string and usage text alphabetically.
> =

> > diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/=
testing/selftests/drivers/net/so_txtime.c
> > index f6f3253ed1748..9ebe9f91227c7 100644
> > --- a/tools/testing/selftests/drivers/net/so_txtime.c
> > +++ b/tools/testing/selftests/drivers/net/so_txtime.c
> =

> [ ... ]
> =

> > @@ -191,12 +193,32 @@ static int do_recv_errqueue_txtime(struct sock_=
extended_err *err,
> >  	return 1;
> >  }
> >  =

> > -static int do_recv_errqueue(int fdt)
> > +static int do_recv_errqueue_timestamping(struct scm_timestamping *ts=
s)
> > +{
> > +	int64_t ts;
> > +
> > +	ts =3D tss->ts[0].tv_sec * 1000ULL * 1000 * 1000;
> > +	ts +=3D tss->ts[0].tv_nsec;
> > +	ts -=3D glob_tstart_real;
> > +	ts /=3D 1000;
> > +
> > +	if (ts > cfg_variance_us) {
> > +		fprintf(stderr, "sw delay %" PRId64 "us exceeds bounds\n", ts);
> > +		if (!cfg_machine_slow)
> > +			errors++;
> > +	}
> > +
> > +	return 1;
> > +}
> =

> [Severity: Medium]
> =

> Can this check actually tell software pacing apart from hardware pacing=
 for
> every workload the next patch runs with '-H'?

Key here is "for every workload".

Yes, passing -H is superfluous for the non-paced tests.

No, that is not worth complicating the test to add a branch.
 =

> The only positive criterion here is that the software transmit timestam=
p
> lands within cfg_variance_us (8000 us) of glob_tstart_real.  For a requ=
est
> with no delay or a negative delay there is no pacing interval to observ=
e at
> all.  do_send_one() does not even attach SCM_TXTIME when delay_us is
> negative:
> =

> 	if (ts->delay_us >=3D 0) {
> 		...
> 		tdeliver =3D glob_tstart + ts->delay_us * 1000;
> 		...
> 		cm->cmsg_type =3D SCM_TXTIME;
> =

> So for the 'a,-1' and 'a,0' variants that the follow-up patch passes '-=
H'
> to, ts comes out near 0 and the ts > cfg_variance_us test can never fir=
e,
> whether the transmit was hardware paced, software paced, or not paced a=
t
> all.  Would it make sense to skip or reject '-H' when the requested del=
ay
> is not positive, so those variants do not report a pass without having
> verified anything?
> =

> For the 10 ms variants there are only 2 ms between the requested delay =
and

