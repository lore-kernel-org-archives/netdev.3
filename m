Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312126;
	b=5pbOQWaMLzjsroBGuDjuIwCqE//9otszllWRfaBfFYH0htt2vPiODPSsq3JN9lYAYs1K
	 ePbbcCn6qmO3CMFcS95bXCjSlmX0sSe0riTTwCMLoGXeNhNDCNH6exQFZJUeJEkiRK6SE
	 5ImyrqHH4LalzHdUedsUhyL7VDO2GCNKLRSOKnoG6mbk4IGSE7qC4DWm0mwSedjWAUZ0C
	 6LRNmTjxer9YBjsv43ZIS/xEbeIExi87SYUMi7h2QOSxUZkffbm42JGIKfzTOaVP3ddah
	 71XU2KmKEyS/b1+xp+/r9qQiT+JlDpKT7MOmMN/YAp6qwirhZr/6b3tNc59pP9jwHmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=c7Bl+YGszqCuzVBCUY8SnSGUM1w0dzAscktRMso/r9Y=;
	b=txf8CkKMs3IqrqXw+4jo6DFwcxc2cAjHkc98sE+RAwHPeIyEQf8/lV51FVn3c6ITufUX
	 DemRUbLLXDAHFWiH+RqLbDMI1n1bgEeZisof9svxLaHSS6cOY2Pv7ObBoxwkGXtTM2q1r
	 lo2UJRiQzL2HRo5OKpfZxJENKhpz+xj9hIvNvinpEIu5fQqK/h9Ch0ozCL1SEAQjXhekN
	 wba7pj1+I8gf6T2tR7VI+r8J9IKS3jpeTP4IVWSYqW+TbJm55JXt/rNEHJdW6gwRRYCjT
	 k+j+jUvt5SWMg1sCKQTdPMoACJKq+mxQjQfs+UbuQ80CiD/VPcfMjbj/UP/VlxlykOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMnSWIDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261E606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C261E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMnSWIDh
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d473cfff6so271282266b.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794312124; cv=none;
        d=google.com; s=arc-20260327;
        b=qLqoJLUu41pDh1qy4oioGrW6e49q+YNkmYX+sA3afNCO8QkfP0na5Tr7zHvW6B7wcC
         8ZwZ2cZfEL03BhseOOfboPkFEXis+2vtlb61eEVs4JbykS3/IHS7AxLtpu6tZD5DIR3B
         +QuJM6iKEg3+agbyE4MB2EZ2JC9tPsmASJskXutly6jA274Qh9bTqu7wH/ik8DABSEsG
         qKmHrkQzupy3TbVdDVoJUCyuQfVlShuAC6eUU620FphQkAUYS6n6u3WR66klNYdKCi4j
         onSRnZ1y5AJqvWHPZN89IR2gKVOaW/rtQAMfZpvan2OIpcBJFUcY5xtmfhdQHfLtDSrU
         wp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c7Bl+YGszqCuzVBCUY8SnSGUM1w0dzAscktRMso/r9Y=;
        fh=FdtHwaz8qJKUTHNeubhW/81PwichVRAIc2vANP4hQI0=;
        b=hPLPFVQVctwT8D2hVkmbfGwJSJtW4fiPT8Y1Klxa7+bxqJbj8Azb/Hc4aDGY6NqEej
         dgg+Pg3g7/lU9rJ7qq1+6h40KK0mrH0B6fvCOJNSAyFI1qDih4TieKc+lGmu6+cJpQQM
         JUd6BxX999LpanpuP/eSEBopaCzL/jwZfgkr0Xu/4VV7vjkmmtSFsSAMFg3TB2vflkbW
         MaUyavhrirBn+2haiZonxQcJOSUxTjS2tfl8vyj3o4gHpTapJ+IlAbsWYteG9HzJbFWU
         g0AwYOjFaXbe20rdDsUeF9+s8m3szdLQ6iothVpvdfAkhi+5NpmmHFiEbEy3eaCnGPII
         8HjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312124; x=1794916924; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7Bl+YGszqCuzVBCUY8SnSGUM1w0dzAscktRMso/r9Y=;
        b=AMnSWIDhWielMFiButlvuEHVLmK4B9OId55+zEF8ky/Re8eeYl2lFLsV8CwqUbyLyB
         Eb6uSfzXxt4fmAkFARHqpsv1zq3pINmPinDIhdiMFAZTkct0hSrsrmENEwKxwSDRkHrB
         QhJg66qbfdGucDM84o7nKwhNUs3uBQ614CpFgjqAzCAxlP6Z77Z/oLyJQVPoqn/10BsX
         3OLyXCmY9SclyHseShw1c6JGjTKBSdtlCUlhDLRdCGgsEjTsWFBPMs8NFmBPdrPWUIWh
         q63Nu8NOJlWR9GTjmfu6mXO5DF01grCHvJy1+Jm1nqCAeL/Fl8beNlIcZ4McnkYCHF9x
         xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312124; x=1794916924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c7Bl+YGszqCuzVBCUY8SnSGUM1w0dzAscktRMso/r9Y=;
        b=pqcwrfyGvWTS3OYW3xSsjUef2xJC9JgLI6NSh09StVyHqmVkfYZeLzdQiG/aZDnXnX
         zI6gYqeoH8c69m0CwtIArEFF1mwpMcYxpzr9P05iOBtvPcKMqjwg2CPnru8wFcek3QRz
         UGfi8+RBHmxtjwymcWSctBRUmFGvuQ4eFi1T15CGkfiCdSt78BjPlcK70lXvgP3HKKju
         +axUnhNKeT7abNBRfOnd+0P1i1V6leY741aAUION9hjiUG6vZU9yv3/Kg+6YB9tDGF2W
         0HT1HQHrsSqbChE4FaNGrAkjztZuxYCVGI7y7HMzQ+dYGYMg/IoT5nnaNJ9UiJKX2+Y6
         DACg==
X-Forwarded-Encrypted: i=1; AL+hErFnh6EqHiIN3PlO4ddOoLPYP59LmPsuXsjXFiy1z2emZmMh99PaR+IiiDfJtGalAI/J/VRRZQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S4EOHxJJ4W/KsOz29q8xtidccsIrZrq2ZaKi7HOFfEXltgyEC
	0367xozdRzDQKuHSh2XfQBcI1PYSphMTMj+k8gbciiWgaWmSRLP/ThZTQ6buYgMavsoM8hZkAHk
	ix3Ir0Z+fL+xEVbbvpdOG7gnfnRLFkCg=
X-Gm-Gg: AYBFou0qbz7AtCrNjnO5fobM8hjTi5Gk62V5FXrEmV4uuDFHmpMANR/n5lywzSz+Q7t
	94d5mcZfbcXoUMf6s6pkakDjAcTtb4HCZPn0mOvpQcW6TrYXVeO3/jUTd6Je4P4trrUaB6pXhzg
	RXYW/D2cP5GOVJUO2l1O3ueOTFHqQE2WNVQZ1Zn+ok9OLIS/iT2mac6J2wjMGuMylNfcaE/A/23
	MTRK3ErXDm2SOhs/rw9YqNdbIMltbPOJjzoBrMK5p/py2/zq9SLb8hQr714kvC6X8oKy4cZUXg3
	NRIwe3dWbzGI3l/PjTNECUcZsDOiJhd42JwzGF05SIArd1LUGQ5ySdWb2EVP2lTO/tO3Puk20ZD
	RhsLEhE6FCPZ1m+RGcrYaOVgSrKXes3lMm4zYqjGXA3FKPpPDDuUr6dF0Z23rM/fo6FJFQ9iZf1
	a28MXtSyI=
X-Received: by 2002:a17:906:ee8d:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c50495eff36mr210641366b.32.1794312123731; Tue, 10 Nov 2026
 04:02:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109231739.2561930-1-kudzo51@gmail.com> <db90cf8c-191f-4576-8b19-00b1b92c47e2@broadcom.com>
 <CAM0KYu0_fH6Z0RUGCG7swSPRQNnsMfL5m3EvRscfPf2ZBXvwOQ@mail.gmail.com> <CAHi4H7GcoXkAWESE9hsbJK5frAMsX3FNya7EWdWn9yC4E02izw@mail.gmail.com>
In-Reply-To: <CAHi4H7GcoXkAWESE9hsbJK5frAMsX3FNya7EWdWn9yC4E02izw@mail.gmail.com>
From: Mlody12 mlody12 <kudzo51@gmail.com>
Date: Tue, 10 Nov 2026 13:01:52 +0100
X-Gm-Features: AclHuK8Mwjx9cE6kqiTpcsq5lytQCIT2eaKm-jtrNlwOilVk2yAAlZa4_KUYeFk
Message-ID: <CAM0KYu3CifjqETEvncaFttV96GX1vxUYoTbfWO23wO6faasi1Q@mail.gmail.com>
Subject: Re: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
To: William Zhang <william.zhang@broadcom.com>
Cc: Anil Chaudhary <anil.chaudhary@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, 
	Jonas Gorski <jonas.gorski@gmail.com>, Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com, Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

A correction to my earlier mail: the MDIO_CFG bit for Clause 45 was not
found by testing. It is bit 0, already defined as MDIO_C22/MDIO_C45 in
mdio-bcm-unimac.c. The Clause 45 access sequence follows
mdio_cmd_read_45() and mdio_cmd_write_45() from Broadcom's GPL
mdio_drv_common.c.

What I did establish by testing is that the BCM54991E can set
MDIO_READ_FAIL even when a Clause 45 read returns valid data, so my
patch ignores that flag for those reads.

Kordian Chmielewski (mlody1212)
