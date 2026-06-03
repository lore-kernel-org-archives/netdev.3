Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03F3655DB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485314; cv=none; b=u1CSAft1FcqVV/uzG6a5XhRX4h5TX0kv1v319JHj2WqwvHWCqfPpB7vBq0hs3YelQtn1QX/gp5e6DhX0e3gu/FInEISyY0SErPWCiSUC1EuzR3bSeg4xgaMx1OVfFviquXsw7VUHfXIOKpiTdJR26TCl4S/HBIUIDKad8dVQH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485314; c=relaxed/simple;
	bh=IYQ2aNeY+X4nQfJBL0t13iSGFwakR7F2aCt2177FAvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5GdGo5yTpr25i+aXKCBOR/rMruT7wZev6p2h2QZ3zfoZZ7RAfzDc44aWvfc8FGfmhKGerxjLHouK3S1/GE+FKEBnMUeDwl5JT7wcZFhnqsWFEdbqTF3lixn7Wok1fqpxWQut4FC55xwkyLQ7fMrLx7WZGYFbkZg8icAKfIJZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WF05GNAu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WF05GNAu"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c76fb8009so6906434a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1780485310; x=1781090110; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hw0XW6MjQE4Q5GmtRBciMOYe8JFJUy2Q42SiJpNGiVM=;
        b=WF05GNAuQR0KINPBBRORhhKTz6ecvHNw28vGLi+p1FbhvWYUn3EEcezPO97xWtnC8U
         aKQQ+Bz3oIsDO1hVDV8nTFYKXC5FLWE8D0GdJcXv53M7DdQ067YI2qIKw+xa/Nr+Z+VM
         e1QhNq7bE7hpUWqev2Z7qVVRJo4wlYMvpalRW0gcRGDBydbdWQPjXpNfYTZLbdMriUlv
         UxzocdsFIzoWHIne+9XNpMthpjAVxpo6qfJQWu4rJbUq30RxETenina5QOM0Lxgmknp7
         6G8rKSoNY4/XsaWwGjowJ7PzEIDrSyOLnMJxuAzwLaKYQLuN8HlXHpNjcUdLAFab2qs2
         Ph8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485310; x=1781090110;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hw0XW6MjQE4Q5GmtRBciMOYe8JFJUy2Q42SiJpNGiVM=;
        b=kJ60mb3OBIECiw44MRtTus4prDh2O6LSUjY3BVNYTRzILGmUg+RuqmsSHKGPKypxwh
         7orbQVoTAiDcJdOw57Uj/J0o4G+EKO2u9fhfw2r7wGnkrGEacWYpLvQsURrwraDK2T6y
         Tzc1vsNk7em64oSWlJ2B8J16D07e9tjKWgYgBq2Z9xXkyyv4FMohz+hK/95NFE7PSde8
         vSnScoqENSEQ8htSIZUoEKJpTijPTYAm7IxJpi/KvQGR45tDFvdeXlD9IBtHNGWblGbO
         WS6FQr2CR1PQURuqSc8dNDr0igWTFuefm88oSlp/FceU1T3LfpDleqswwyjf249XVIrS
         6hWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SzDwCSViQ6apyIgIbhvl5demxc8QlW6ptUIfFSVWY5WitmhImd01OWytRwSg6owFw/nIfjJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1SO7J5Eb+kvI6a8Iz8ODo+p5jjI32lnqJmzSBBDJkk/NtI7j
	P1ZfmbFCRmxEPTd5+Aduaiv4tcX3hVYnEbYhQxRUSTptHdBKDPsoOBgCOj3SgAykUZQ=
X-Gm-Gg: Acq92OH9A0Yv70qCvyli3fnzvcA4gkRclS3zXoFh/PwZW7KPVTAsQI0qFDg+WrwngI8
	Ucgyea243FQDoXY2XYXmxRvLmz9j5y4YXa4A+DlZnM7i3JKDTljKHDzWa8wiWg6zBPSlVSUZBDP
	vXK4wEEwsBOG0ZRPxnGHhP9MlD9Vt/7ssHFH7lIuzDFlJOhpfF2rGHFvAlfI3PFX7bgYGAYY8IF
	6KafQm1ZRBZf+lpUAtPDEGgC1UsPpWbdxk//gEe5G3Txbn0/yelorSbDwaVAITFsWpaYj8NAkv2
	UBjpBnqqg1ws60luM3DPwiHA9Af4lFnTU3nncN2ck0Zg3xtSawjiw0UMa7rxyVwVyils/mq20RH
	oTARER+RGxVCp9LQkjoh1MRcVTSaLo7r0TxztOdIg78Ulws8xcsQsOjXJo1rNh0z6VV+j7KODFe
	6wXS0Y1+dzPukzOte7H7m7H6KAUMxPDuS8bgwivPz55zEsZDOZC7uzzXOTwnJT3RHawswhD489Q
	peEXLP87H8=
X-Received: by 2002:a05:6402:50d0:b0:68b:5418:bee5 with SMTP id 4fb4d7f45d1cf-68e71aa2f01mr1359654a12.25.1780485309927;
        Wed, 03 Jun 2026 04:15:09 -0700 (PDT)
Received: from cloudflare.com (79.184.120.122.ipv4.supernova.orange.pl. [79.184.120.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65c542c7sm1018281a12.31.2026.06.03.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:15:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  maxime.chevallier@bootlin.com,  nb@tipi-net.de,  lee@kernel.org,
  linux-leds@vger.kernel.org,  pavel@kernel.org,  jv@jvosburgh.net,
  michael.chan@broadcom.com,  jhs@mojatatu.com,  vinicius.gomes@intel.com,
  idosch@nvidia.com,  razor@blackwall.org,  hare@suse.de,
  jhasan@marvell.com,  danieller@nvidia.com
Subject: Re: [PATCH net-next v2 01/11] net: rename netdev_ops_assert_locked()
In-Reply-To: <20260603012840.2254293-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 2 Jun 2026 18:28:30 -0700")
References: <20260603012840.2254293-1-kuba@kernel.org>
	<20260603012840.2254293-2-kuba@kernel.org>
Date: Wed, 03 Jun 2026 13:15:07 +0200
Message-ID: <87zf1b50zo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 02, 2026 at 06:28 PM -07, Jakub Kicinski wrote:
> Jakub suggests renaming the existing assert to match
> the netdev_lock_ops_compat() semantics.
>
> We want netdev_assert_locked_ops() to mean - if the driver
> is ops locked - check that it's holding the device lock.
>
> The existing helper check for either ops lock or rtnl_lock,
> which is the locking behavior of netdev_lock_ops_compat().
>
> The reason for naming divergence is likely that
> netdev_ops_assert_locked() predated the _compat() helpers.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - new patch
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
