Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511845;
	b=b6+fBqhuZ8D93NPg9E9OW25tvgT+wM3U+H8/LQaPaFQEk3HN69ibnL9ucdFW6hNciV8Y
	 U4Oq/iNV/JhkcQTXixh6H2U/XzuHqlNDV+/OIapHePWwnae8xLqEzoCI8wNiK5DDNIsq6
	 31j4c2ZS3RDgarQhABViwJU+9NvTCIKvh/jKax7jl29I9hgZc2sl7067IGMNPzUEiTaoX
	 TWm/L2inezuUZjw4FHo05XH4WWsbatvJay67jn9xlGoEN41nVYFpdnfiztglEHcLS7T/p
	 dfMtKAa08JvrylqthJp5FuFAF2iAhJZlCJ5qV7Wi2kPYG2mtMaoujMZZCl0QFWqCA8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511845;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=dVmGUOAC/RT1NKlC/mYP5cJfsGUMVjyOOI8i2FgSf+0=;
	b=1ZAUs0M3UXINSGCozj+7XLfjlZW29uByG8jhzQAMebRyjlxICskriifDCMs3SAwddpIH
	 7JRTI4/m2LpcNE0RRh70T3I0rwMTp6+MOwhkXEGpm0DuUf0BK4sFznR/blhEfRCNXBx55
	 f8pNWbDKYRnhso3lL5URGuj2+l+53yOxeitE1aePHnU53Y+z/ey+RyFombnd6rIhCE7R3
	 fmRpaCHW9Wr51tyforQqO67JBIJlqvPMPqjJRKni1uCaSHubJiMQrgaPE8muP1vABkdMO
	 4uZ1UwLwZDqgzYugWx+VEzUZiJoD5bH2BtFN43+ErUWdsw5/w2IzhuMyuJIoSa+qQFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=uqwwLbb7;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE0606A31C;
	Thu, 12 Nov 2026 19:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACAE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=uqwwLbb7
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7CC6A02E2;
	Thu, 12 Nov 2026 20:30:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794511841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dVmGUOAC/RT1NKlC/mYP5cJfsGUMVjyOOI8i2FgSf+0=;
	b=uqwwLbb7jyZwL+AGCWepunM4AWYUTElrxYlK50uYAQUsb6gN0Oeq93ADOF5Jm4ieuJaRCG
	v3CxPV22oXfrwm1GceAyeL3EwazH3T0Rg+IIHrKZjaiyGDSgLd4gkl74UCsAqwto8crkId
	mRZKkHM9+ad6H6+R5zlAm3M32gzyfEwAFYl3rcL0HJI6w+BiIzdetnnVCLSHpdYDau5wTp
	MNqx+o/ls9kJ13UCYEMaU5D7HN1qIoXYRYgh38jQT8U65W7fnhvtACLtAsP/DJFSX4c2sx
	765KKTUeIy+bDrWcUcWPZe3EG1vtomsADKCAHR9/ILYqtPPT9lbEzYaJRwG6PA==
Date: Thu, 12 Nov 2026 20:30:33 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>, James Clark <jjc@jclark.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>,
 =?ISO-8859-1?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Conor Dooley <conor.dooley@microchip.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Hubert Feurstein <h.feurstein@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v3_0/6=5D_net=3A_mdio=3A_add?=
 =?US-ASCII?Q?_timestamped_MDIO_writes_for_PHY_gettimex64?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261110151602.7a065b73@kernel.org>
References: <20261105054839.2248046-1-jjc@jclark.com> <20261110151602.7a065b73@kernel.org>
Message-ID: <99CF7794-BD73-4E84-815F-7819AA4BBE5B@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3



On November 11, 2026 12:16:02 AM GMT+01:00, Jakub Kicinski <kuba@kernel=2E=
org> wrote:
>On Thu,  5 Nov 2026 12:48:33 +0700 James Clark wrote:
>> PTP_SYS_OFFSET_EXTENDED uses gettimex64 to bracket each PHC read with
>> system clock reads=2E Some PHYs have a PTP hardware clock (PHC) that is
>> read over MDIO and sometimes multiple MDIO transfers are needed to read
>> the clock=2E This leads to brackets in the tens of microseconds=2E
>> Applications that synchronize the system clock from the PHC typically
>> use the midpoint of the bracket as the system time of the PHC reading=
=2E
>> With multiple transfers, the midpoint of the bracket is typically far
>> from the time when the PHC reading actually occurred=2E
>
>There are some AI nit picks available:
>https://netdev-ai=2Ebots=2Elinux=2Edev/sashiko/#/patchset/20261105054839=
=2E2248046-1-jjc@jclark=2Ecom
>But frankly unless someone with time expertise reviews this it is going
>nowhere=2E

I have been quite busy with other work, but will try to make some time for=
 a deeper look in the next days=2E
