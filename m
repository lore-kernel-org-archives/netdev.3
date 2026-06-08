Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674637AA9E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956559; cv=none; b=K2ogdCTUZSaBd1+sWmuBMGp/FxSYaa+bVIDcuGEGZ/c3Bu/9oWf3udm3GbXt0wpuPQ0CKVDy8KgtkTeXRFk9vEtvCCt3ZUM3IvVQlB85i3rVALTYidIK1jpBW9ZMOjsLqzA/ZiyWcUdprfzYqqaNSbEfsNtZhNVjdoq3BsgPf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956559; c=relaxed/simple;
	bh=y8QkwBMa3woLGWufwyutWVES2bWBRoDUgruGm6Wis7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BiSN/4rVTLRnEMiCgVM9XoXVQXZR6A/xyKjrgiDVQ4rIMFgkUkMlfo+ifQySgTxO6c/RSOiTE5ps5RzwDi+NqgIqPEnD+4LnvID5KTEG2O0eolhG47i2cTIF8NuA3GN8Ri7pdNl+cPgB7JTnpC3u7/pxb6kEbTMBDoiz/VYKxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3kygINc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3kygINc"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e266714bd3so54835937b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956557; x=1781561357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zibFaWk+zoXaui87oKuwtiqb9qfcsQ6oAAPVqF0wYVc=;
        b=Q3kygINcBeBAsVcHkDm+8Zzx5lTh3eGdS+iVUPTvq6fHRPMJzXoZ7O/gVH8bZNKHic
         HUJooL8ZM7SMhz2e5VL47CTO6ZRWSrUOszunjG++NZkrymxr54YoK4bhcqdcDURnZtCf
         nlC07C2pUFPCn0XjScma6iBZy/g1RaBDDXAde634P4TpFi7z5NqsE+E+pu13+x9MBFt9
         IQJqmvaet1jk30qfIngka7mvBkXfh+T0uX8VwVtMYN4sRAz4d6feZFHNq/4LZjNS7G4G
         KdfhtL77q4LVQzSrowtHIajJtm5Ip+iPyl4xykyi3BCnxrIpJC11GncCHwc2WGOWQOQY
         QWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956557; x=1781561357;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zibFaWk+zoXaui87oKuwtiqb9qfcsQ6oAAPVqF0wYVc=;
        b=Tgh+yoY1ddRXoUWZcZ6kbO5IPrz2AC+SOXOPhKtfpBhXV7Uvt+ezMeuuGH76LbOGjS
         v63VJOT67WIheKA3LGqwmKweEn/A10DJM7e5PTFHZWK6vpSi5+hUQ4HDKbmjqAvjn8HT
         CDJNrQ+FI2j5QIK2exg6j5dpall0E4Rxxjmb93L/Fh90tdPuZS4ptHMWzcLpvJHpYsYg
         cZK8D5FWyfz/mv0pA1s4nShS4i6WJH0c9OswBZTHLyyWPSKrjD/XNSdLC81Wm2hEKwqV
         DrXL4aAbyopO575ctWggb/AI+chsSMS6zgvtPFw9yX0iftyMze3qlW2ShohWPdcR9hBj
         Pl1w==
X-Forwarded-Encrypted: i=1; AFNElJ+ZacO6jyto+zsp8EIHfwnRaH3jg8HjNXRCIYjbBvj/v3GbKFFELyCU1t1xtYLE+H7o1zz/IP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRwB3gaM0hc7wousL0T+wS3+Y6wMB5+3PYUInyYYmT04kZV5y
	j5NcE5aT64eccefIdoFnr5c+B/+N3pS7To0oQvZjzWBxCyQLYm2V7K8i
X-Gm-Gg: Acq92OH8ky/g4bhD+wCm53nTratTms2ozBvr2wWBZgje7vxPof399Bhwt7VUkKkqqrn
	tyxJ44eXmUtdEtLvacNcDJjZnsmPgmtf5S0ootbMpslN7yWgfUkKDSoH09/7Ve6wfl+51G9YQAZ
	mPXCwBxVoof8Ktg5SAskBKIJSPT/O34kjlDccfBqceOIFJjvJk8Uh9//g2fDUK/v3bt60Yaf/S7
	QTzlcs7P7pYwlnjSRUwsTk5LzzHDC+iibHJoXdW/Am6sFDmekMfVd8JIqskLX5FW9N5hOdHFwtH
	eEEM/knpAU3PfuMMCyR5W2jrCR0dxJqeIeX5duDEc5dwvzNEKFScEGPDhNEoVz8kNzPMO0noQcb
	TSmlOPyyNvs7jX7Ppz90aXNXA4gzSRhThETUeAeDX6W5kDIufNkZNYuR7FiCnhFWxDSC/8MUevb
	SPcQslG1zNU9kYS5m0s2IHWRCm7b4vp8tem8Y58I2e+XqWoyVDpAlaXLHh2z37tL6iDfBsSX8O8
	T4H0+V//ImszOEHSA==
X-Received: by 2002:a05:690c:490b:b0:7bf:dc60:ad14 with SMTP id 00721157ae682-7ed103e4dbfmr182799417b3.46.1780956556998;
        Mon, 08 Jun 2026 15:09:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea21968299sm90423357b3.19.2026.06.08.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:09:16 -0700 (PDT)
Date: Mon, 08 Jun 2026 18:09:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.356106e98a673@gmail.com>
In-Reply-To: <20260608143913.349e45c4@kernel.org>
References: <20260608173305.372987-1-kuba@kernel.org>
 <20260608173305.372987-3-kuba@kernel.org>
 <willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
 <20260608143913.349e45c4@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: so_txtime: check IP
 versions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 08 Jun 2026 16:25:01 -0400 Willem de Bruijn wrote:
> > > diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> > > index ddcd2c0e06a8..8fe061f52055 100755
> > > --- a/tools/testing/selftests/drivers/net/so_txtime.py
> > > +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> > > @@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
> > >  @ksft_variants(_test_variants_mono())
> > >  def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> > >      """Run all variants of monotonic (fq) tests."""
> > > +    cfg.require_ipver(ipver)  
> > 
> > This may cause aconflict with my outstanding SO_TXTIME series.
> > And more importantly miss having it in the new test_so_txtime_fq_tai
> > variant.
> > 
> > Could this test be moved to test_so_txtime that all of them call?
> > 
> > (there is WIP to add another mono_hw variant too)
> 
> Ah, sorry, missed that. Would you be willing to take these patches
> and add it to your next series, then? Or the WIP stuff will take longer
> than say a week to surface?

That will take more than a week. But I can respin this regardless.
Apologies for the test breakage.
