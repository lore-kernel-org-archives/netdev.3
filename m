Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF02DF717
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269227; cv=none; b=s6tXobMpkuNh7gKGBOBNPUPN1lA3Iw0Ak2Q/fEm96xiuFnChjcjXNIjyrqpcd/nAhouOrAWkm/6WCGKUEAvtyeMaf5TdmPohy9Wn+1P7Am5FhuaOsa08hIUOD7vVoKWVi2y5r9EtEXIQshr6RfBoijNz0JQPOpISFfpTB9mEbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269227; c=relaxed/simple;
	bh=2ECesAhNgGt0uU7ttssxkS0Wxjkyl15plxaja5SjTvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TixwcIOxijxLitVloCBZH1SchYzOcNO5t0GHXCaUBSpRR10KjNFTeY5g/bo7qiIrFk8Yx5dF3aKM4Ad37H8g+PKMUfUqW0lYonvlyJ0RXFKehx8P4LRZrxcVUzFQneu9+qmXc0NfioX1ASqmuomarsUQQzkbbpP+Ou0oLDJqPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CNVtLhGf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CNVtLhGf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso1819285a12.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269225; x=1781874025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kaVGNsXYbHtXZ4uzqeFlf4o6f/3jgmyRexy/RaPVZk=;
        b=CNVtLhGfDfvxeNF7HOQxz748xi2T5b0M+Hw9HOELQfF9SAPS2BmQTlOFXxvVyGjO7y
         xq7c2J1AMnFkJvBejaSezvJobXKYoQJa0xPWM4WFftpJpdqsLTci10xzrR/S/b8ZsVk4
         mFsDR7wGzrRQjmpm9iKQcShNuGu9Z8Y0E3jmCgQLEbuwI2GczrFcd1G9HZ1o1VldAe7E
         G+8Jma0+BP953lzHaC/Hfmvs71iZW4C/7A36aaGjN8Nz4XH17q5vXsI0yHFDj9m1PcB8
         uINSEDUbfztT7v5UoiN6wH4J+VbHIX6XXWejRoZ55ln2mCYY89tTanAGKQ0AcYYMv/Kg
         Y+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269225; x=1781874025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kaVGNsXYbHtXZ4uzqeFlf4o6f/3jgmyRexy/RaPVZk=;
        b=U3Tpq2U1AYvw3UGNS8I1tqVYxPb86/rhUH2SEwqY3Tyci7KVEriMfkai9zHLQMI55A
         4fl+IkCE/r7Eui2tMuNoExeI5vgH7EoeV8CwbatNN1Fzrttz+UlbxrV8MwNwFw3qAqwG
         xPrBhg5HirsoMClsMDIfBzMhM1rVFvIa3M5dLxHpdZOB1x6lqb9ZNcKZFvOvhXMTwYM1
         bx1rOjl8Q0Fpf7SC5O8uOp8MsjPITeG2tcvz4Ad5lANGNG+XRfCLLh+vMmUPNUJTfHSR
         dNigLv1bGVPBRzQPvPm10zqI861rSRtKI9wHAi6b+v0Atvd9v3/3zWUBOOWZJeXx0rAN
         728g==
X-Forwarded-Encrypted: i=1; AFNElJ8uatnJsEhaREgRLaaMN2PGQZPPQvhMqV0Frsh0UgtyLhuCeFj6DNC7tB3ASxfiOy6y1zPNvPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKfrRdM9rywKJsGEi+6Qfb7PAZlrnEBHMQrW7WElYAgivbB7g
	nxRO2dvEVUQY0Q2Gb5j7aQNIQUFpKwg6o31dJRWcPfBufXMi8S3E7K6iGuPPlOwWcGU=
X-Gm-Gg: Acq92OHdLd2pDZuBloNDkRamp8h9ChKgA2f12/E5rReAmJAYCDvSKG5F3FzaC4e8SNe
	yZGVkeDHU4gPZGeYVG1Ywn3UWOhKp+AgjxG6wCwele7+EeA9WZt8CQPbYb2Q8IYnD6DDfLeWYNp
	OGktp+4sMmq6/0wDYkYBYOBYn9Y9CgVb34jX1kpbrFssnHrvtklXn0fmnc0U+FV3J9mUbCWQFYA
	hB4kQYdwuAPTJEe2m2egL6v5VaoHMV4tCCMziIlAHwZ3t6y5HxtubmPahAMJexp0Yv60cxfxiDj
	lQXCNSEwtE/2Z4uQMrKp+eSUc6xklKXsy1QPPa9h1Rrs7U3H3P5QH2/3DMdOZF5elBS8T2Njqz2
	6yWeJk6P2E7HbLCy0A3NeMr36pvLWCYMmBQb1CvIqb8uUDGchPoHynikhwvR0C2SK1uzShv7weI
	7AnRLqSux9/fITTGAEFEES
X-Received: by 2002:a05:6402:4404:b0:687:9c0f:5897 with SMTP id 4fb4d7f45d1cf-693788fcf92mr1468576a12.9.1781269224595;
        Fri, 12 Jun 2026 06:00:24 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949fb19sm610192a12.27.2026.06.12.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:00:24 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 12 Jun 2026 15:03:45 +0200
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrea della Porta <andrea.porta@suse.com>, netdev@vger.kernel.org,
	Theo Lebrun <theo.lebrun@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover from
 lost TSTART write
Message-ID: <aiwDsd-1IzeBzcaD@apocalypse>
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
 <dbc25b24865a1ad92555bc826bef4267@tipi-net.de>
 <aiwA1dD-qXcT3hds@apocalypse>
 <85507fd0fb42fca280aca1ee02178ca9@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85507fd0fb42fca280aca1ee02178ca9@tipi-net.de>

Hi Nicolai,

On 14:53 Fri 12 Jun     , Nicolai Buchwitz wrote:
> Hi Andrea
> 
> On 12.6.2026 14:51, Andrea della Porta wrote:
> 
> > [...]
> 
> > > 
> > > The commit message describes it as RP1 specific, but it gets applied
> > > to all
> > > other variants?
> > 
> > I've seen this issue happening only on RaspberryPi 5, but AFAIK it
> > could affect also other MACB blocks connected through PCIe, so it
> > may be widespread (even though it should have probably already been
> > noticed in the past). In the orginal driver there's no timeout callback
> > defined and this is much like pretgending the issue causing the timeout
> > to happen to go away without doing anything (whatever the cause ot the
> > specific hw are). So in my opinion we can just extend that to all MACB.
> > Or maybe we should execute the restart conditionally on
> > .compatible = "raspberrypi,rp1-gem"?
> 
> I just observed the issue once, but other people reported it to be happen
> more
> frequently. If we can narrow down a reproducer, it would be good to test on
> other
> blocks too (like EyeQ at Théo's).|
> 
> So maybe you can imagine a good repro for this issue?

Sure, it's happening quite often during bulk dataflow, at least
on my RPi5.
It can be reproduced with the following, issued from the DUT:

  iperf -c <SERVER_IP> -P 10 -t 3000 -w 4M -i 1

plus, of course, the related command on server side: iperf -s.

It usually happens a couple of times withing a few hours.

Regards,
Andrea

> 
> Thanks,
> Nicolai
