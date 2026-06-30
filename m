Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFB3E1732
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833358; cv=none; b=tiJOJbVaHaNgB6UeAJxtPjjAaOBOejQHUSsp4z8gLaBvghwdCAHbDXNk/dm5G66ZUCgqjnrgRfHEyTEd2qxrjJ9Cfs0SJDvBSR4b+gscwcZ8S/q6nNpImW17wPl+61ibN7K4zPlqeAZPfrRbYVeOVYnBcR2KYUCnOtfD41Sx5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833358; c=relaxed/simple;
	bh=WQRlvOCE1auyNFN25FfdvwAf8yTgJGPbfJqgPD3mkZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8896pTfqafjxFIB9JQBnsSECskZcBYUzwD9XOX2DQZy0O69hyAzkCQ8CRABXzgVInrXCDC0BGcNfguuGoNn/GaPGdd+Bilf2owpCjH4z24DFngQuh3tfy3n1nIBuylt7keE8NEF4nVxlEk+V2SrwY/MFIrhwDRtKpD//nJK0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9gR71D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9gR71D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555631F00ADE
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782833355;
	bh=WQRlvOCE1auyNFN25FfdvwAf8yTgJGPbfJqgPD3mkZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l9gR71D9A6uav7d5RvE8QcK9rQeFL2y3W1qche7RQUI9lOP2HhOU7uzwnleAUzXDc
	 H5xzmFMe3gMPOEwSRZqy9u/bJQjUvWcKmo2ID//e3KXWnM2A5FwCLI5whSjBhSYTN+
	 lcwp6M4pno6s8K0fCEvGVh96vBQegwRBPEzKykcKZpHhUMXr+KFvm07eaUZKm3Yk5h
	 rLhaA+01Q0wiv1qrc3JC2BBJBOUCPHTRJ+lpBNpelvyEolCVdX1OkgTdQ3rkdxZZSI
	 wJ3JrwmjqDTYwedbN/JY8gACsAP0ZLdFuRAO47jIJUuO9anmhtrPaBcm63E6d2+4D5
	 Puuc2/AUqIJzg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c127a694ccbso262617166b.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoM1oVtlIUDKmaCO6VCTYDaMNUAlFojA3dhw9gc99ph7UDODNjA9s+xDwpL0VmSAo8mJETI82k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7nTIFgwmwbMslnyBiIT5Kz8BZAGsSUA0lV9xqITLLyWG5dFl
	soM3Awe0FaAwj0Riq3cyqxS3DmLrnxnaT3IZFR5mOOBVWbUqyYOGMcKUqmXaA2xfgow3i+4z+PC
	dplARoQinm+OuByRo4ai9HcgLDVpNRw==
X-Received: by 2002:a05:6938:a08a:20b0:c12:7e9f:5ae3 with SMTP id
 a640c23a62f3a-c12872a34b4mr141132866b.15.1782833353756; Tue, 30 Jun 2026
 08:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
 <20260615041056.GA1426553-robh@kernel.org> <CYYPR02MB9828308552BBC60427E8EF2283E82@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To: <CYYPR02MB9828308552BBC60427E8EF2283E82@CYYPR02MB9828.namprd02.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jun 2026 10:29:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+H5qSep2+Wd6i+pir0fK8NDAdPj=7Ka7+qoG82QZeFqg@mail.gmail.com>
X-Gm-Features: AVVi8CcE2u2osQeWDN_q0N5A5Le8-51ZMka5QYUjnRlp7Tx6YdkygDNIGVndh54
Message-ID: <CAL_Jsq+H5qSep2+Wd6i+pir0fK8NDAdPj=7Ka7+qoG82QZeFqg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Richard Cochran <richardcochran@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 12:07=E2=80=AFPM Selvamani Rajagopal
<Selvamani.Rajagopal@onsemi.com> wrote:
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Sunday, June 14, 2026 9:11 PM
> > To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > Subject: Re: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S=
2500
> >
> >
> >
> > And you are missing tags from prior versions. It is your responsibility
> > to add them.
>
> I added the prior version's link under each version. Somehow "b4 prep --s=
how-revision" command doesn't pickup the older
> versions. It shows v4 and v5 correctly as the emails containing patches w=
ere sent in a threaded manner.
>
> But with v1,v2,v3, as each patch was sent through individual email (with =
proper subject line, of course) using outlook.
> I don't know if there is a way to fix this.

While links to prior versions is nice, tags means Reviewed-by,
Acked-by, etc. lines. If you get those on version N, then you have to
add them on version N+1 and later unless there are significant changes
that nullify them. However, you don't need to send another version
only to add tags. The tools will pickup tags from the current version.

The only advice for outlook is don't use it. It is incapable of
following maillist etiquette.

Rob
