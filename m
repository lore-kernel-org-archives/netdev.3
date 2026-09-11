Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4543EFFC3
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115612; cv=none; b=NCCZNb04sKItUIuB0Dlzca5amcI4rgTzFesry5TJ2cIfrG01jEEOg5CwDxUrwg2eymMZcJf0BfSUbHzdV/qPS08XFzJTyiQHIzcQ6pSQRkl2mbcw9uIcdfLLjD4FTlMQfuB+s6IA6WLfbYyBNKfHgZ3aCZQCarFA6Te1Fky8mR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115612; c=relaxed/simple;
	bh=Rm9r2xnsIZFc8ybJEi5S3AB68AbzmoxRMB7qTrAikGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=YMXAbUjUWv/XEqW5fSynEduXuXSDDa2LXnb5oXUR9SDRLT8g8leqDIBn2uEKjN865Qi6HhlqduKSHzuWKR8UUx5fBiA7KKjgPpIV1ZjSlDKjY4SogNSvt+88ba9Y9iTVdrWlt8e2Iv1KbGPdGvD3TniGctdMOV2jQ4jfLfmR/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qvSKB7B7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qvSKB7B7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 96F104E4013C;
	Fri, 11 Sep 2026 08:33:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69066601DE;
	Fri, 11 Sep 2026 08:33:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5120F11C7AF99;
	Fri, 11 Sep 2026 10:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789115602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ftOn2N8WubB1YE40TT5Rd8Tsd8oKLrVJQ4FJ+h3aPZ0=;
	b=qvSKB7B7iBQ2SnufSPvm3YZ05RpvcV/H/IW3bz2GpfGMKegHQTusUErcvUV2DxETJ87xDZ
	3qED2aXk1afyKC21OhPAsFMLvGdd3+nSQWwADUMwcX3aRcuikkuR5qhvPzFOlpNPJj8/H5
	O+I5LAB447ToyOyFWqDS/SF9jdAvKo+VASWGlWW3R02zm92HypRmymZqVb5ZsCAmRhRXQF
	ixD4f4oTXGKldwKZLdszkaA53rUz8SyqWxzLRl1HlaqO5J0G/Ml+/5c099Ll+6NG97WjT3
	wVAvwei+UC7rKGeTA33WIdGdCqtJNzOq0bWAMC7DS0qWFf3QAi2wKT9PcQUP7w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 10:33:14 +0200
Message-Id: <DLCCJPHEM8VD.1527J6FT7I4MQ@bootlin.com>
To: =?utf-8?b?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghA==?=
 =?utf-8?b?7J6Q6rO17ZWZ6rO8KQ==?= <5mghybrid@khu.ac.kr>,
 <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 0/2] net: macb: Fix PTP timestamp configuration
 handling
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CAH1Bc_weSzwLzY4nWbcqz3pRjzyh-W4P45bijWN9EdQzV-SFjg@mail.gmail.com>
In-Reply-To: <CAH1Bc_weSzwLzY4nWbcqz3pRjzyh-W4P45bijWN9EdQzV-SFjg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello kimwooseok,

On Fri Sep 11, 2026 at 9:47 AM CEST, kimwooseok wrote:
> This series fixes two timestamp configuration problems in gem_set_hwtst()=
.
> A rejected RX-filter request can change the active TX one-step mode
> while leaving the cached configuration unchanged. Patch 1 defers the
> one-step mode update until both TX type and RX filter are validated.
>
> The two specific PTPv1 RX filters currently succeed with RX timestamping
> disabled. Patch 2 routes HWTSTAMP_FILTER_PTP_V1_L4_SYNC and
> HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ through the existing all-frame
> fallback and reports HWTSTAMP_FILTER_ALL to userspace. Both defects
> originate in ab91f0a9b5f4 ("net: macb: Add hardware PTP support").
>
> Both defects were reproduced on a Raspberry Pi 5 Model B Rev 1.1 with
> macb eth0. Before the fixes, rejected requests changed OSSMODE in both
> directions; each specific PTPv1 filter produced zero hardware timestamps
> for 61 packets of its requested type. On 6.18.46-macb-ptp-functional-rt+,
> both rejected requests preserved cached settings and the full NCR, and
> each PTPv1 filter returned ALL and timestamped 60/60 Sync and 60/60
> Delay_Req fixtures. ALL/NONE controls and all nine configuration cases
> passed. The board was subsequently returned to its original kernel.
>
> Additional validation:
> - net 7f26a5e8040b: ARM64 allmodconfig and allyesconfig full targets
>   passed with GCC 14.2.0, W=3D1 and CONFIG_WERROR=3Dn. After applying the
>   series, incremental builds of the same full targets passed with
>   identical configurations and no new warnings. Both rebuilt macb_ptp.o.
> - Pi board configuration: Image.gz, modules and dtbs built with W=3D1;
>   the resulting kernel booted and passed the hardware tests above.
> - Both final patches passed strict checkpatch including sign-off checks,
>   and standalone/series application checks on the net base.
>
> The RX tests check raw hardware timestamp presence, not absolute
> timestamp accuracy or PHC synchronization.
>
> An LLM assisted with source analysis, preparation of the fixes and test
> helpers, and drafting the descriptions. Results are from the recorded
> board tests and build logs.
>
> Assisted-by: GPT-6 Astra
>
> kimwooseok (2):
>   net: macb: Preserve one-step mode on rejected timestamp requests
>   net: macb: Use all-frame timestamping for PTPv1 RX filters
>
> base-commit: 7f26a5e8040b4957ef4dbdfcde6cc7ba2db53937

Your emails are quoted so patch emails are invalid. Please use git
send-email [0] or b4 [1] for sending patches. Both allow previewing the
messages before they are sent to the mailing lists.
For example `b4 send --no-sign --reflect` [2].

Also I much prefer cover letters and commit messages to be under the
human voice rather than their bot machine! Here at least it looks
somewhat sensible from a quick pass.

b4 even has a relay service for people with broken email servers which
might be your issue, see [3].

[0]: https://git-scm.com/docs/git-send-email
[1]: https://b4.docs.kernel.org/en/latest/
[2]: https://b4.docs.kernel.org/en/latest/contributor/send.html#checking-th=
ings-over-with-reflect
[3]: https://b4.docs.kernel.org/en/latest/contributor/send.html#configuring=
-the-web-endpoint

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

