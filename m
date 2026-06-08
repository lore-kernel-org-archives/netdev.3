Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40C3A6EEB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954756; cv=none; b=g1q6b1ewFYe+gX4zWfoscVcxSOb9/8owpISjivkl4htNBF0wCaFVcAQO9Dy9ThnpWzYF2yPV9Sd2SE6hK8ruXQMmtZZA3nXyDqRSwz36hs+Czu+WlW1XAgKl82z8CgRniVfPGeuIyvuKI2o2WJ/CYmy+3V7QyvzvRxAqgllYIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954756; c=relaxed/simple;
	bh=mKWI2odDW4UxxRm+DRJiRwsOPa7BFZpIaoH5Mfq899c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4kqRDTpQQnrj9F9lFSbvpy6ObkT/O2IoqDVO5jjD71Ct7yU5jvJYTH2kXU3/nqjXpz8+CTkpmoLPGKkjI16wVd5GbQ0/oB2CtZeHAXhSkFusmQZGBDo+IrF20aGJRAvJMKFXv+yEMYYZrjzr/gMGpJZFPMgxFqCUaS84Pk1RuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlc8lD4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlc8lD4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BED1F00893;
	Mon,  8 Jun 2026 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780954755;
	bh=1oIouYlhiCMj8QSPZzs4UCMaZWSSBZ13yHvdHY/uFIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xlc8lD4BW6Iex3qgN7EUW/bIAxuY7xKt66M91SXcvvNeiOE//nm9CykCt+uYxIoeV
	 0XmnOLN1WymMjBenu1KskmgnI/AeVl6hYMeoQOGDHFxeswoSBrrbXiJVgBNYAiKVUK
	 X0aai8WLrjAWzasHIQrkKLE4D0soMp7XFDhE45xE3P686/PZax+0nNo8ILfUQCUPo/
	 RHFE/5RD3GBeTjoR8Iiv/6rPqy9EyHBPQTVxLGXl3a/tL18lao4JtWSQYC6NsWu23B
	 FNfAAc+xmW2fBT+cKJMpCveqO2hYpUoz5WccO4t8EsN3VhHMIQ5fQbgDeIOMnfMYZj
	 XWqnVxsk/F2Qw==
Date: Mon, 8 Jun 2026 14:39:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: so_txtime: check IP
 versions
Message-ID: <20260608143913.349e45c4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
References: <20260608173305.372987-1-kuba@kernel.org>
	<20260608173305.372987-3-kuba@kernel.org>
	<willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jun 2026 16:25:01 -0400 Willem de Bruijn wrote:
> > diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> > index ddcd2c0e06a8..8fe061f52055 100755
> > --- a/tools/testing/selftests/drivers/net/so_txtime.py
> > +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> > @@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
> >  @ksft_variants(_test_variants_mono())
> >  def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> >      """Run all variants of monotonic (fq) tests."""
> > +    cfg.require_ipver(ipver)  
> 
> This may cause aconflict with my outstanding SO_TXTIME series.
> And more importantly miss having it in the new test_so_txtime_fq_tai
> variant.
> 
> Could this test be moved to test_so_txtime that all of them call?
> 
> (there is WIP to add another mono_hw variant too)

Ah, sorry, missed that. Would you be willing to take these patches
and add it to your next series, then? Or the WIP stuff will take longer
than say a week to surface?
