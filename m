Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559A233D9E
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784501858; cv=none; b=JOJw7j4QvDK3DB6T7tiCAzb5fqUt3lypGylvbLAkZ11kOd9h0ZS8c4jPrZFKOIHuyU09VuxWGrZmq+Vn7HedDWTR5Hxyxzf/xrrIEzrg3l/tBUBTdmzUyBlNsI/vCc6/Nv32nSP39Jlcu99j5Ypt+974QbppzWcnqRoe/Y6oMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784501858; c=relaxed/simple;
	bh=ip41+IpCq7Bi+P01lNPxASRgYMO/TiQqMhX8Wo0dOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFyz3PiAFAlI+Ns0Uod4Z/JUHpNtqoO8RVSjd8/6RiZ+LmI4ojcyvjMoZDPu4WAUdf0wzEM7i3M6yg2HwqsQ+8J2H+YLj8RyTu/7IQZHrmO8nNfDIFpeXsBkJjjQguWz5tZOtW+uqZNHy/QseAYlQffNWo4ZmM/F4yBkbIJd4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAFeHULS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAFeHULS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4731f5ffa74so675433f8f.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784501855; x=1785106655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=foWVeXbcrx/1DUPB8QQ61IrKeGnDk036pk+v/B/jfNg=;
        b=FAFeHULSiZDmrOfDVGHBlV8f4eoKGfcTmGb3xDLgCET47TXPb8bgYnJ7tY4Au3bP9S
         ysPaaFpZ6yN0rSNpmTbjUnfYOw2Yfz5D6QQ7dXmQYEE3D0CR5sOdpO9ZfNm8eGdFTuPg
         ptYA79wCJhKrcouIxtR5uINYmV2i9iigJ4X+bh+i2ZkavNAGXiSHWkRHT2337Txpf5lt
         2IgEnK/ZETDgMNIWtNGxR7ifVwYpWntH0uGhQ+PX4Prpta7v+Yc4YfUbir3/fJcy8xIG
         0KLms2RtXftYAm9Ee5HTvYIArvff3wj0JzInUlTwNMsmb7yUezKDj7i1Iu2Aekwl5E7q
         j6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784501855; x=1785106655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=foWVeXbcrx/1DUPB8QQ61IrKeGnDk036pk+v/B/jfNg=;
        b=K9sFHBJFsy5kFNPjw7y/cnRqOJPt3++u3+7N/hpth878kmiwebosFibWaW7EzCyfsw
         d9mmQz/GOJezcsGkQ6xxRcd5eKNxPogaiowV+2tBK6Eu7sCe1nHkzTcbJ+9wRJmwREes
         7H2Kw6ps3gzAlQPxmbcM3NUVZNgUUndhEie/c9vQJxpr0zkxv57v+gPJ1Jiwt7JDi0oQ
         Gm2+lrODx4Z3nC5SebagtCPsz5jhyKRcyAGWF1jV29pWPwBdTZPPOrX3T3i/5ImJWXMZ
         QnuyNmrZcxaM4cLFmL8tDGCAGF9c+HIXdpYwBPWFfl0snNhMzEmcO/3LlNKpkcZ4+wvI
         gc0A==
X-Forwarded-Encrypted: i=1; AHgh+RqGhA4QjO9zFZ5aHKLb3sqk/3iiB+kmrAe5lJhtJvf66yiAMcY1X0vupItJutMYnKIasfzgn48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpU3lvO4egRamdQzo05SuN7UBitbo16fas4SKVybisXk7yS1pI
	O9vjx/aE0EG8YK/7gmqBT7o1m4fZUqecKefQkhil6EnrbjBMqBomm1KD
X-Gm-Gg: AfdE7ckVEr7D1l+PpIehalYzGPr51j9yUcHvYqirjLce+V16vhSRzomBBegZG0gs3KE
	+JiU/UcuvCLnEK9Og2G7eoy0Majaw5U0rt/8cpj+PBnbqGoiPR4QgaKPgcyNEupDADHJoaUrQJL
	j1+3BhGij0i9JxmqgbDOU95fMEPkg/s14i2wXla+2IkfOGJrKdcurIJttPDh0n+Bf8BmLxLznSJ
	dUKkk30KLfbZbPrCCH5HD7aW2+2vSzDW/D2w2ljcNRjml7O4F2lCZnFvn6oo0AZ3/n1h8I9qYwN
	vZWTKeSHzZmmcfh4aNTY1DySch5dfO+g+V4zJKjL10qDhTrp+JCWmMneGKHY1sBr9v14PUsSzn9
	KMJGZV7T7uD6Zdxn0yVGtA0vC3/cPEMEOo2ql63xmQ+vpRQk7Z9vSY9ZtN5OVv/bxnA==
X-Received: by 2002:a05:600c:46c7:b0:493:efdf:7c80 with SMTP id 5b1f17b1804b1-4954a40ebf0mr74112875e9.5.1784501855076;
        Sun, 19 Jul 2026 15:57:35 -0700 (PDT)
Received: from skbuf ([86.127.127.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f69e5eff1sm16179219f8f.19.2026.07.19.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:57:34 -0700 (PDT)
Date: Mon, 20 Jul 2026 01:57:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <20260719225701.okkvl2uhgsuwydfi@skbuf>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>
 <20260719095307.hwtnbrqdkjxntrcr@skbuf>
 <92B1BC3E-6976-478B-8B34-043EFE63C3DA@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92B1BC3E-6976-478B-8B34-043EFE63C3DA@padl.com>

On Sun, Jul 19, 2026 at 09:22:39PM +1000, Luke Howard wrote:
> Hi Vladimir,
> 
> > ocelot_ptp_rx_timestamp() accesses MMIO-based registers, which can be
> > done atomically.
> > mv88e6xxx_ptp_clock_read() accesses MDIO bus registers, and the MDIO bus
> > is sleepable. Fundamental difference.
> > 
> > Your hardware only provides 32 bits of partial timestamp, so
> > mv88e6xxx_ptp_clock_read() will always be needed one way or another, to
> > recover the full 64 bits. Either through tstamp_{cc,tc} or through
> > direct calls.
> 
> This still happens from overflow_work().

Ok. My mistake.

> >> Deferring to the worker can reorder frames such that PTP general
> >> messages arrive before the timestamped event messages, which confuses
> >> some other PTP implementations such as gptp2d [1].
> > 
> > True, this is a caveat, but event messages and general messages can
> > already take different network paths, especially with PTP over IP where
> > they go through different UDP ports (even if for gPTP that is not the case).
> > The PTP user space implementation needs to be prepared to handle this.
> 
> Good point. So perhaps processing the embedded timestamp inline
> doesn’t confer much benefit. ptp4l (which we use) handles out-of-order
> messages fine.

If you're intending the in-band timestamps as a fix for gptp2d's
limitations, then no. As a general optimization - maybe.

> >> This optimisation of course only works for ArrTSMode because there is
> >> no MDIO read required.
> > 
> > I don't understand this comment given the partial 32-bit timestamp
> > limitation.
> 
> Better phrased as no MDIO read to recover the arrival timestamp.

Yeah, the timecounter/cyclecounter requires refreshes at least once
every 32-bit wraparound/2 time in order for the trick to work. But since
that is set up, it frees up the need to access MDIO per packet, since it
is guaranteed that cycle_now - tc->cycle_last is no larger than half the
wraparound time, which permits distinguishing timestamps taken by
hardware before tc->cycle_last from those taken after tc->cycle_last,
and correctly converting both to a valid 64-bit time base. Quite clever,
actually, I didn't fully understand the first time.

The only problem with timecounter/cyclecounter is that the hardware
clock remains free-running, which means you won't be able to apply a
time-synchronized taprio schedule (if the hw supports that).
