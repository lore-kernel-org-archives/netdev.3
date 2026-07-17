Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5683C3449;
	Fri, 17 Jul 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293062; cv=none; b=p992b5wibRJVR/2UZoYl8ksnNpREHr0VmE1a4AaTkufy2Fs5Eam7CxKe/DwURRZoEYS/On8v8WFMeqB0NG0NR/SFD0ZOpwhA1n8k490cVHPkfRjvCK1YIhjMzJMf7Cdd9ASnDLrZFhzPkd1QB2MzynCrCBx2Pw2dPJRek8RrdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293062; c=relaxed/simple;
	bh=nVdqnweeK/8b4Zb28MOfPjhGbGeH5RcHbujG8wAded8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=d+7Bcnzp5awQ6MPXmq54aBw5184mjeM7F2Qs+xJpRZl63dbdnZJp1g6MhMqmtnstEpmHTMFHAY44bwcqU2eqHJ73AEaZT3auo9kB/rLVdtrIp1Faq/G7XF3sefOoe6WT3+DErg87Kp74TbAIwK/uuKZQcnKFMnNmrLhEG3v6Eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFkCxTwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFkCxTwW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 096351F00A3A;
	Fri, 17 Jul 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784293060;
	bh=nVdqnweeK/8b4Zb28MOfPjhGbGeH5RcHbujG8wAded8=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To;
	b=JFkCxTwW6uMG3KMkh4wj8kj7NEqCAH7YZz37wrpWOD5THyMaMdnBXMP6aXqONSxl4
	 InefTeoD4/m96vxNFANm3fRQtGZqfgp8yHamaiZRNtiQNFiIIzH7cicynybZm2Je9y
	 PK4SjnPOeHHDrBEqzbQwxmx4OzfkOw92Xxs2WB4gK87NkqRXL8MsRNctaaDW6/gLWE
	 Tm7nHXl+i3SPcmUfaKYfYQxV8au+q9bv+jDLI6FuE0k0qgfCRM/KVuZgh9Hu4AM00t
	 HWx6n7/ZvyUck3/yeCRrlefITut+6CjGPJgJ2cCgChPgGtXWydq10wu87D7G9w5YpB
	 AzweRwlH3NT+w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ae5ad5cfb4a78f2c248140514d559ccca382f5f4870c0bf4453ca98fc494;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Jul 2026 14:57:36 +0200
Message-Id: <DK0V3M8CTZFU.1T6GJTFM5DJ4M@kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Paolo Abeni" <pabeni@redhat.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Madalin Bucur" <madalin.bucur@nxp.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
X-Mailer: aerc 0.20.0
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
 <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
 <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
 <eee42ee1-386e-996f-b9d8-8aa2e820d311@linux.dev>
 <382033a5-77a6-4505-ac50-58120308507b@redhat.com>
In-Reply-To: <382033a5-77a6-4505-ac50-58120308507b@redhat.com>

--ae5ad5cfb4a78f2c248140514d559ccca382f5f4870c0bf4453ca98fc494
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jul 17, 2026 at 2:44 PM CEST, Paolo Abeni wrote:
> On 7/17/26 2:05 PM, Sean Anderson wrote:
>> On 7/17/26 07:11, Paolo Abeni wrote:
>>> On 7/17/26 12:13 PM, Michael Walle wrote:
>>>> I've seen that, but.. that was the actual change between v1 and v2
>>>> as suggested by Sean. It does not depend on the actual link speed,
>>>> but the maximum link speed. So it is not relevant if the link
>>>> negotiates to a slower speed or not. At least that now matches the
>>>> behavior prior to the phylink conversion. If that was working -
>>>> that I can't tell you.
>>>
>>> I'm sorry, following all cross revision discussion is a bit hard here.
>>>
>>> I don't understand if the 'link never established' is specific of your
>>> board, or it a constant with this driver. Could you please clarify?

I don't think it's related to my board, but rather to the link being
a SGMII one on my board. I assume Sean had an RGMII link while
converting the driver (?) and moreover, that it worked correctly
there :)

>> I think we should set byte/nibble mode in link_up as well as mac_config.=
 That
>> should fix the problem where the link never comes up (possibly broken si=
nce
>> the phylink conversion). I think it's unlikely that this config is suppo=
sed
>> to match the phy interface speed and not the link speed, but you never k=
now...
> FTR, the above does not answer my question ;)
>
> Still I think (mostly guess) bringing the mode initialization in both
> link_up and mac_config should be safer (that is, I agree with the above
> plan).

I agree. I looked at the original driver and there adjust_link()
will also select between byte and nibble mode. I'll prepare a v3.

Sorry, I misunderstood Sean's intention/suggestion, thanks for
pushing on this. FWIW, I also tried with nibble mode as the initial
configuration on my board and link_up() is getting called. Whereas
if it's 0 (as in being documented as "reserved", though it's the
default), .link_up() is never called. Thus, it seems that it just
has to be any valid setting until link_up() will set the correct
value.

-michael

--ae5ad5cfb4a78f2c248140514d559ccca382f5f4870c0bf4453ca98fc494
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCalomwBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/it4QF+PueGx3Bp6Fp8hUKmit5UP2NqFfNIfi7l
Z4d7l0Fl45RzxJNXEBGW7MPJdxHpZgqwAYCvnXq5ZCjAGW7gxBJA7vlqOBvNyA+4
4zI5pQC89vs5Ep7rIYnGztivnd7bh09Gkgs=
=aat/
-----END PGP SIGNATURE-----

--ae5ad5cfb4a78f2c248140514d559ccca382f5f4870c0bf4453ca98fc494--
