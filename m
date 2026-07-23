Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791336B909
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824685; cv=none; b=GJdCn2JuShbaWt/ajpEb0vwsVU2n/GNFXmOh6igt2YvVDJq2gqEl0SZlANM0ximdHFyO/6urZdwnkpF8OHu/F7nbofeO1t+ak6Gd7B5GOERiGkk/8HGF3DlywjHa3QUTzmM1hllN2XurCmCoCKxlawPKEFvCvt+ylzOodt+/aeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824685; c=relaxed/simple;
	bh=KNLxu+S4EoRgHjFYK3LH9S8e3cKiFPBLwClD2rjcgg8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l6N5ORbcp1/gTyykECxNAMDbUK4QCwQcZHI5dgIIMqJkWXKIXl2FDFkX6n/sbo7Ig77oQOcp5NYze3slbjvlzOwdr4moYSFe9evNaRMPoo7OFXhmL9cjt9j77x++G3sumNxXC8o9RTN5odAvCcb1Z81uKXRG939rt3oEz2RX/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyCXJesQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyCXJesQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so6369205e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784824682; x=1785429482; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-type:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BEyeXCQxmH69jlS7Z40errNpL/tYJ4es8ysVgt6WSxI=;
        b=XyCXJesQ5BgtPFbfP4gK1ssy9wE9n+GtQosgzZTnrQB7GkGi1jI9mKG67wZamdynn2
         CAbUYIfK/1mbhdwqrzsQL7MpsisCRgczv4HvxCzkF92Wm/JRjCEq/IiXEBlg0zMsYB3+
         U8zsdGn8QJSRktu1zneVH5w0yxAJ6LbePHccRkZ0MgACNzqISna59tULXRG2vVx5anEg
         Gi8io9HOPPAYcOwz0Q5lyA7dUv2DNxKzcOHzPI+EQQKfAGRwOVIO46pxC3qzkZScaOLv
         16RtdKmRPhFXG1298e/Sh5PuHFqkro+3y0fFIUKy78A7nrk4chMhbqHMahRv65LVnFFE
         YOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784824682; x=1785429482;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BEyeXCQxmH69jlS7Z40errNpL/tYJ4es8ysVgt6WSxI=;
        b=cE/tpxVBbuMSeO5XkF78mn2uQ2C2T/MbWCOLRiQUmW4WhQRxUiEXnnWWfbMwIrNF3b
         mHDvybVh5p5I/iteDVxKBrHR5+ouPCh9Q6ARwwos7c8jIDO/BnGTl25anW2OaZnzTr4N
         cbh+Cq5Ih7bv0gH7QrKB3var6EaoRtLUcolD6J9DNB2bg0xe5163jxZCKNX+Xrxa8KHP
         AhGH1YgXHYi0OA6Wf0uKydhC1Xtcc2lw3+0TvlTwD1ZTlzLZ2/ONArB47GfRvPgJawQH
         bj8rN4anJHhNCMTU7JcHYqdswBDFsDMx0rhytttlFNcKAtdsfBfy7RyVC8AuozyJvi5l
         0N9g==
X-Forwarded-Encrypted: i=1; AHgh+RoY6DwflJOqZo8JHHkiUkpbvH5N0AoT8gFduPkKSwqCGiHCJ5/89yNVxC7y6LFGKyKStfbBYok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cFcm1eAY+YBbtFgAcE+tHj+OhgpvncAYzvoOt43lxdVLx+KD
	BYiqcIlohPDaN1MFzAttKwfshs5aX5gnzP8VAPGQgCvrgqriuPL7v58GGD5WgtiO
X-Gm-Gg: AR+sD111CuakPqkKPC9i3Zn800dAXIulqd7YSg/f7qUUTmC0AKd3QbYQweJRTdaytBD
	cpePHCGtkkrdC9MM8EE+P6MuNjG/y7XoB2j3xyoM/6e5uVbCcdDQNOKdqWAmT77ai+GWVSqVd/m
	VJMFUmIXT47NNh3ub2x9+xYRUec670z87e6nUYX9b7m3lb7oTftGGkHRv4UBydmk5zgZi1GaW94
	PqQUNDW07tDJOdZo5VzWUJVyYbsH7xUzbFm5PcPT0JfFZxZ5g6GATY7dutn0AXXtbCIf3Y/d7np
	bPT/q+0PiT21zbY1VrYyZ3btvPpXuyH2oT+ojPrQ21uUeQF3ODHk22nsfHjnibx3eLKdzeBXLOj
	moK2VhBt2gtS3wdaJClv0NosZJyyOhA0dZ9A5hg2KSUl+Xof/6EMGsZD+fqeMeErSbGDEBVo09D
	z30TOTsa90V1khhpX78DGVRNkvELSZ1zU=
X-Received: by 2002:a05:600c:3b91:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-49573ccdc3bmr48040325e9.10.1784824681958;
        Thu, 23 Jul 2026 09:38:01 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8012:dc77:0:5094:fbda:cd42:f524])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm16315652f8f.24.2026.07.23.09.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2026 09:38:01 -0700 (PDT)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_88EDE387-B344-4498-92F5-6AFE000F4BBA";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/1] net/ipv4: discard icmp timestamp requests
From: John Haxby <john.haxby@gmail.com>
In-Reply-To: <20260723090858.GA3224213@shredder>
Date: Thu, 23 Jul 2026 17:37:50 +0100
Cc: John Haxby <jch@thehaxbys.co.uk>,
 dsahern@kernel.org,
 netdev@vger.kernel.org
Message-Id: <B4BAD3B3-D795-4863-B20A-F457BE24CB77@gmail.com>
References: <20260722102441.8762-1-jch@thehaxbys.co.uk>
 <20260722102441.8762-2-jch@thehaxbys.co.uk>
 <20260723090858.GA3224213@shredder>
To: Ido Schimmel <idosch@nvidia.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


--Apple-Mail=_88EDE387-B344-4498-92F5-6AFE000F4BBA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 23 Jul 2026, at 10:08, Ido Schimmel <idosch@nvidia.com> wrote:
>=20
> On Wed, Jul 22, 2026 at 11:24:41AM +0100, jch@thehaxbys.co.uk wrote:
>> An icmp timestamp request is classed a a minor security vulnerability
>> (CVE-1999-0524) due to an information leak.  As pretty much =
everything
>> uses NTP these days, it's not as though this is an actual problem but
>> scanners flag this so for everyone's sake, let's just discard =
timestamp
>> requests.
>=20
> The idea was discussed in the past and was rejected:
>=20
> =
https://lore.kernel.org/netdev/1557711193-7284-1-git-send-email-chenweilon=
g@huawei.com/
> =
https://lore.kernel.org/netdev/1557754137-100816-1-git-send-email-chenweil=
ong@huawei.com/
> =
https://lore.kernel.org/netdev/20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.=
com.cn/
>=20
> I don't see a reason to revisit this.

In fact, there is a reason to revisit this.  CVE-1999-0524 went from =
having a CVSS score of 0.0 (ie not a vulnerability) to CVSS2 score 2.1 =
in 2022 and today it has a CVSS3.x score of 4.0.   Those first two links =
are messages in 2019, well before there was a non-zero score.  The last =
link is, admittedly, 2024 but rather than completely removing ICMP =
timestamp (as was done with ICMP address, the other part of =
CVE-1999-0524) is provides a sysctl to turn it off.   I wasn't aware of =
that possible patch, but it assumes that there's a use-case for ICMP =
timestamp and in the few years I've been aware of this as an issue (in =
my previous job) I haven't found one.

Admittedly, it's easy to just disable the timestamp in a firewall (eg =
firewall-cmd --add-icmp-block=3Dtimestamp-request) but people have to =
discover that after a scanner has screamed warnings about unfixed =
vulnerabilities.  So now I have actual time on my hands not dealing with =
the daily firefight of kernel CVEs, I had time to actually do something =
about this that's been annoying me and quite a lot of other people -- I =
mentioned googling for "CVE-1999-0524 fix".

If there's a genuine use-case for ICMP timestamp, then yes, it should =
stay and we'll just add to the documentation from Cisco, f5, Dell, =
Oracle, etc to explain how to disable it if you don't have that use =
case.  But lacking a use-case, I still think ICMP timestamp should =
simply be consigned to the bin.

jch=

--Apple-Mail=_88EDE387-B344-4498-92F5-6AFE000F4BBA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iHUEAREKAB0WIQT+pxvb11CFWUkNSOVFC7t+lC+jyAUCamJDXgAKCRBFC7t+lC+j
yJzcAQCNH7DPnPwiSmPWW+Ilr+yf5RQqPQmA/0pwrWHWGp/eTAD+PmlHckNzePhI
8ZgtLt3Zhc/soh5KNMzC5s0ONMEpBds=
=haGc
-----END PGP SIGNATURE-----

--Apple-Mail=_88EDE387-B344-4498-92F5-6AFE000F4BBA--
