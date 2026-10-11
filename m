Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E8280CE5
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727228; cv=pass; b=pQPN6r19xINF3calijLdnKtYb/loP1NzMqW/dkLseXUSNIoDGdqPgF4oL9xml/VYb9mUAQX26j56WwXzl4ENEKoFl0HZkUmwAi4b2GF/VxodUqdWmiDY+QKZdU3mtilD2d6AcCwFldVDOiwNwDfmKZrCrtt1nUDVPY997nQP2co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727228; c=relaxed/simple;
	bh=NlMfuw40ORFWcSamCr7ePf+fXASb8e7WnzfqYP8h6f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+3ZWBJHjNkh8j/2fCwAym0BxeW2a1K0wMS0ZZj4qq1bbSNKA4yBIUjgkdqAGq4E2WjrchM3iKQXu7yCyq3piMWfjg88Q7gn8v4eKV8DF4T/4gv7KTDfHqhhwxVnIYt9DAzA03Zcg9Vl/ArCX1RY23IM5RIv68C5pM9yD4vZPE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=Yvc8ScP+; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="Yvc8ScP+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b55859245so22657306d6.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791727226; cv=none;
        d=google.com; s=arc-20260327;
        b=IgwZB8ZigU8gvOKHh/+C+mY9fHu+VdBXJDOuTkVIi3PVgmENKG/y8EEn9PnwOlfvvV
         g6EFlLkPgGhtdGf+cPLfeJkek2xCdGcfzaaE3EjqAEZPXL5PylDBvo/HC8JKAlCntCqd
         3glyPeynnxqatAMVYbK6h6w0lZIuJU0Dor7KT1OCsSeVNXksTJdJIsSVGUoHPF1DIv1S
         1Quu3IEMUwtCRpj8fnkf6EVi+JDtEP4pYLhWCYXyAraq2WbtLGnRwrsFrE79aD+f8/Ts
         uzw1qXEKfPJzRoWAUdO7s8ytjimoyuv81YdcleKcRzSdwQy0p2uklryYTJrvEOf7cUvO
         LzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlMfuw40ORFWcSamCr7ePf+fXASb8e7WnzfqYP8h6f8=;
        fh=rBI6TC7uVCulxDJrtcDrpFWni2njG2W1yHEAisMhK84=;
        b=QUHQtjbcFerP8kuM2/XX4CmWleVVwn65EP/U6B/JH/mgqL6m4WYJf+tJf47ZO+i6f0
         XvnjRYRe6OWWFY6pJx6X4VLOhxUl72IqPO4Dtx/c7gb6JbyqdB2WYqJTafRswWop4jqR
         YSsPUCZfDWlcsm2lic9ZsQqGhd9ciNDGeEMdt/r2U2SODO4QRl8QYFZk8v9Oz5Gwt1Ir
         M7a3/1EufWyfWyKREo91vf0Pyv3ZeyCFdjOfF4XedD8SwEg1elw9jju2qrxWS8udNLMT
         021LcRf9X0AArsjc1nK8Ec9StzAdMmoYtQPTjMWAp6RfXkEeRuAG0E3U9vIs6ukYuYBW
         axCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791727226; x=1792332026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlMfuw40ORFWcSamCr7ePf+fXASb8e7WnzfqYP8h6f8=;
        b=Yvc8ScP+arz1gpL3zqjfJaBIrzBSBFGTwOgwOQQ8Yu7uZ+Fnx9h+lrPKqYTMX4MH4A
         6ElGceeBQYzhVGY5vW4JxvaH7w8E4fl2IgDUI7tfY7OIDaf3fSw/2jErlSrtkcz5WQ4w
         nYXnfeHVLS6jCmHyf7rRE/6brhRFU6T4JXtJKbkbMjbUfjYEUbwNQsEW0cyBEo+R3euZ
         wgFcqezo15tbSdhh6/zXTGha0auWlNrHK5kdfEnngJzVexWxJj+thtSTgbe4vJWMNQHU
         MVpOBFhxqHRIeoJvYZG0IxHjNbLmsmfiE/trQSqNsJPVpckSPJRUBVlg7f0J6tyJrh32
         0Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791727226; x=1792332026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlMfuw40ORFWcSamCr7ePf+fXASb8e7WnzfqYP8h6f8=;
        b=JaGLmCTa/YWkV+ibFuDzFPUWeH4bsYTWEQMMAupQkOqBr/4//QeQQNgZizLeYOgPMi
         gI9kXbnwf11Uy56JrR2WCH416ONcFWalGk+1I/l/oaCvuR6dBqHoMcNWK7CAGs0R8cuU
         ZDGV9hcwftKnIx5x4sdTppcSHaagcSEDr1KMXzVfdX6Se2msHHnODa4c30JH/twwkFyp
         t2dr3kn9OvuapXxmRGKPga/dBAeLwZ8LEMGjU+dezOyQccZiVAZZBHTc3N0KWLPKpX6a
         +HuIOYRPI0IOJBuSZjfqRmYqxNwENKfkFWNCAEIhEVL2QmRUxUg0FyMqv6Y0RM6nunWY
         LWkw==
X-Forwarded-Encrypted: i=1; AKwUvBwqjJm963pYqFJ/8HZIziQbBoiP4SLLPOwlNETBZGOQweEE8AGPEG8tX+//iDHmhWGP47qaOAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+C2oVoHu3gbtclg6CKWVCxlcPLlOYw3/tGV6KnPEzaUvp1AlN
	TjKqY3KqyiasAFxSISRDOX4Ob0M7Nvw4bGHkuinGDMvRl1VrgZl1niwTXTQlfpmOL5SWFqg+ROE
	1o5n6PeU/YzUDfDemRj7UDY9RCFMGdRULWWr8N2Nw
X-Gm-Gg: AYBFou2/3VIlSCZ+XHPlxd3g1id8itRbxqMRBHNoWhP2aksscLikqWv8frdyOSjRlpL
	8/I6BW6IEDnkrKJn2Aebncvo4sFYzpsil/FlTCWa8txl/9w+AVedU8/uLy6LWZaNj+1YSV5wGWW
	5zNRC3w6J3pl4UxJyoL9t+xXY4eSaDb/FKfhQRIFrsvffTTNVQbP/Fjh1hFomhxkmaA4o2CVwDr
	JZ/bv6X9mG/jDdWN8zrQpgtCBFcMFV+8VsQRxZeD2ewJypdPYtN9KHZWJpOyy1CnZG6rStLQ2pV
	25ksX+xRCAhBpuNMcpHAaEmUmHNhaG7PkzxEmlBb4KP+Rc9LCUxyalBa8MHCSICXJg==
X-Received: by 2002:a05:6214:4017:b0:917:a1d1:3b91 with SMTP id
 6a1803df08f44-91b554fe8b2mr124028256d6.21.1791727226035; Sun, 11 Oct 2026
 07:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
In-Reply-To: <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
From: James Clark <jjc@jclark.com>
Date: Sun, 11 Oct 2026 21:00:15 +0700
X-Gm-Features: AclHuK-esRNB8W7zs2qgx_OudsZ2V4R3VAw5wkSWWvbXvEsBPzNqouiauJwAFE0
Message-ID: <CANz3_Eacfj18qJdZc-WEdZVCFYA=4KgeMK3U=e99gfnSyz7=Vw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for
 PHY gettimex64
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 8:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
> > synchronize the system clock from the BCM54210PE PHY PHC leads to the
> > system clock being 32 =E7=9B=9C ahead of the PHC. On the CM4, it is abo=
ut 7 =E7=9B=9C.
> > (The difference is because the MDIO clock frequency is higher on the
> > CM4: 10 MHz as opposed to 2.08 MHz on the CM5.)
>
> IEEE 802.3 says the clock should be 2.5Mhz. Does the CM4 use a
> clock-frequency DT property to enable this faster clock?

No. The CM4 DT doesn't set clock-frequency on the mdio node, so
unimac_mdio_clk_set() leaves MDIO_CFG as it finds it. On the CM4 that
is 0x91, which has 9 in the divider field. The driver's formula is MDC
=3D ref / (2 * (div + 1)), so with the 200 MHz GISB clock that gives 10
MHz.

James
