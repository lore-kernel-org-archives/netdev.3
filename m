Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BB3A5440
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412057; cv=none; b=FQUuUMcsV7n0ZMH1ci6aQZjPU9pV/8fM2Q6uQ1CpixoY29a/223kZ6gfezESRBOhoT4I0uAsltSSCzy1roQxPgCZWJkBP/z7DcViIKumhAcT49tzoYX5ODd5XXmQFq51jfvCyBgvjLtP6bGecC5B2twAGrrrv8JAEjg43P29Tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412057; c=relaxed/simple;
	bh=yfJjADf/hO1fRxYvy/AN/v3SrpzC/4Wi3xAd5XT6Vfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHyubQEg+wFfQ6odGvN41YcU1AcVFxGRyeRL9n3Q8LauE2VLl3UfuNAs+TpIEtw092yt0LxEIuwziYPITk4PQ3IYiLcm7OEncB3ZQKlVd0mCceoHeKIRlQNV2pEz7wfP/akn4oAqx8GIYdR1U4E0c9OcAPwt663GQesZEbq/Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHJN71Te; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHJN71Te"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so957531f8f.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412053; x=1791016853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKB7jX/87a5ucU2dpPAfqks2hCkBhkpECERSJJpQMwI=;
        b=jHJN71Ted+4EJSzEDgRQsxjJyBl7oD1seqQKsyBKjWZ1BrGy3/KjSSl6l2Y6JKDP1t
         MY8Vz4Li6Un0hyuJL0MvAk+GV9kbZ/Q7d8+cub8laDSZBjJ3Y03OrPdgUYWmk46dQ7Eg
         9ENr9dJZvKfD9hyuHWWQLEbrJnSCwxrnHsaPU5oBFZFRUlRlmaEJ4/l0/wVMg4e4iufW
         97b7wjN1oke5vEWpYVxAPbtKFojIYaMWg4Vf1vQpJiL8FfSz7tZoJGxmVibC/XuSdepC
         X5HNmijDWhJx2HKzYIbw+7G2cXXZXsM4nNXe1sHKeLNbd/97rawjbcAcPsAJgkqpKCTk
         rMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412053; x=1791016853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKB7jX/87a5ucU2dpPAfqks2hCkBhkpECERSJJpQMwI=;
        b=Qbhv1w1DXRt2N2pqZmHUTAt+WqFOqRFCpZmmHcvlDAsnjc6AG3pfJgYOmoXkIWVN8g
         osuMessk27Dk4riGgN631sPFucoBwHskRy6jTnJOEyYIgEcN/X6V8vskPBqV45XvkmMl
         NLi70rB4YtyXR2or5uCtCpUvKlylVYVhWj+TjKngkjJZwoOwnUX3uUgQTnHAbTMP7J/m
         UK/ufTSnpJavaz0Ym8bcRWBFvbIzpk0/Mdb6AzZBHW8UJ3MCtyFI5rN5UwBoYaWpEYe1
         HmE2M+7fceVH6onPrmw/Q1Ioc7cIgBSQY4blNIYqzkghYbB/GYQsFqbX9SYFdIzd6CUV
         77EQ==
X-Forwarded-Encrypted: i=1; AKwUvByREI8yBfRVtgqF9zF1v5CtXdpElJdfUj4Na3zyYQCPKVhFBaPxXDVGHf6p7bFhzuxEdFWDL8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlOJDQni9A7SD3CXkD88qrph/mJL1PAmuil4yr67r9ABkSBKE6
	xHGPB9+QoUZBMYPfRW9to42ZXPNJDSeF6H+czH4qUIdlRedF3+RFc+LL
X-Gm-Gg: AYBFou1jHs5pgZ0QToPaRqMx64qRwDZZi0nXBLFuHuoMdHE4xA/vcVvRkvapeKFITYP
	Pp2rVZOBGYhmFSqiDyEfHatF6pTmIdeIOm/k/Shj/cmVSEY4a1SFpUDgVcwmPYdTh6ewHaWYTGm
	6eu+Il/5XTG2ed2XvdEY/4drMCKgzmezBuozyXh0AXpMODgZ+4E8+ZU8nbyR0+2kvPZCbQJ/wVN
	EIOwU1s0Ufclv73P74q06+1v9H2/ZSVVI4+u0f9wJgEE3zUGBj0bNxt2lSlsor4PGnjeqrybqD2
	Sj89O69hUPtjL/Ty1chju4kT1VQPsO3UjLnDUDvYUbDDKTt/S/ck7dZ7eUfMKNozBmTvZKRneJ1
	kEPUhJ34A2ms4IuX6ADf7o2pJSGmYZjQ+nzqLM26IEH/owi9ASutxrefyMuCnqnRpdTR97uxxZZ
	Owf7pSYdlbb722xmyAu6Dm+aqlkisWX9azHvSo/TvkpohUC7RFEOPP2chmJUkrcyEpMYUsxFzf/
	/gWz4NiXlX+lwp9xjQAX7xW061NtaNPZyFsiMqBXQrLaOOd9kcMVoau4I+v7Qz74D0gbE9439Vm
	AtXNXH2SjEmYpQWUoKHm0VYCAPev
X-Received: by 2002:a05:6000:40e1:b0:487:62d:37d9 with SMTP id ffacd0b85a97d-488716a5e3amr14226748f8f.27.1790412053273;
        Sat, 26 Sep 2026 01:40:53 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349a0esm18313534f8f.10.2026.09.26.01.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:40:52 -0700 (PDT)
Date: Sat, 26 Sep 2026 10:40:50 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 04/11] ARM: dts: imx6ul: Add Variscite audio codec
 files
Message-ID: <areFEuHcyziU2xXx@Lord-Beerus.station>
References: <cover.1790344389.git.stefano.r@variscite.com>
 <ef56f98137eb9d1e0af3aa1b801186d829dba521.1790344389.git.stefano.r@variscite.com>
 <araMJFirhP86Dcb6@SMW015318>
 <araZ8pJGmDVXMjvE@Lord-Beerus.station>
 <arakXE94ZONxduMU@SMW015318>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arakXE94ZONxduMU@SMW015318>

On Fri, Sep 25, 2026 at 11:42:04AM -0500, Frank Li wrote:
> On Fri, Sep 25, 2026 at 05:57:38PM +0200, Stefano Radaelli wrote:
> > On Fri, Sep 25, 2026 at 09:58:44AM -0500, Frank Li wrote:
> > > On Fri, Sep 25, 2026 at 04:02:21PM +0200, Stefano Radaelli wrote:
> > > > From: Stefano Radaelli <stefano.r@variscite.com>
> > > >
> > > > Add separate DTSI files for the WM8904 and WM8731 audio options on
> > > > VAR-SOM-6UL and DART-6UL modules.
> > > >
> > > > Put each codec node, the SAI2 setup and its pinctrl in the selected
> > > > audio DTSI. This makes the WM8904 option explicit instead of placing
> > > > it in the shared module base.
> > > >
> > > > Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> > > > ---
> > > >  .../imx/imx6ul-imx6ull-var-dart-wm8731.dtsi   | 71 +++++++++++++++
> > > >  .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   | 88 +++++++++++++++++++
> > > >  .../imx/imx6ul-imx6ull-var-som-wm8731.dtsi    | 71 +++++++++++++++
> > > >  .../imx/imx6ul-imx6ull-var-som-wm8904.dtsi    | 85 ++++++++++++++++++
> > >
> > > what's difference between imx6ul-imx6ull-var-som-wm8904.dtsi and
> > > imx6ul-imx6ull-var-dart-wm8904.dtsi?
> > >
> > > Frank
> > >
> > Hi Frank!
> > Thank you for taking the time to review this huge patch.
> >
> > The difference is in simple-audio-card,routing:
> > on DART-6UL, the microphone jack is routed to IN2L, IN2R and MICBIAS;
> > those routes are absent on VAR-SOM-6UL.
> 
> Is possible to share most part?
> 
> Frank
> 

Absolutely! I'll do that in V2.
Thanks!

Best Regards,
Stefano
