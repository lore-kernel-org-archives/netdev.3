Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A34399FF;
	Fri, 24 Jul 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912576; cv=none; b=Zf6cNt3loFkDKD5krtWoYx4oVpGIqpHz+WsRuw2As+yyMxDtl9lqo90oYXZdtAQ+ezdc1IHBC3cAkUMSUWSVvEvVNQrlFp+CLr2Op/ti3InBw0iYk2pp98CXoPt0R5QJZEDsmZuvBirwvlSxZiHNTBtxnGOEoqxwiddSPzEs9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912576; c=relaxed/simple;
	bh=dC3ZTiR7YdARc8hFvQrW4zErwS4rOZqjE2cDbcMooVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPHyYH1lJv0PcaqzeIouv8QnDqHbFeUAcPOaRiT5cXyFu0nbXjN+3AxMklfsyblE6LpQ2mLBBeLYy3d8/L7Q6Y4C4kuSdCKF04Dzjz2TNxOp5xkkCAIWsgN1MnkWboFlxiWShcA7jD+iDmhltb6OPSi/H5R8MgDRiaKcu/M6qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WRBoJmIl; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Zf/LinL5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WRBoJmIl";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Zf/LinL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784912572;
	bh=dC3ZTiR7YdARc8hFvQrW4zErwS4rOZqjE2cDbcMooVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WRBoJmIlQd9nDXL1mVaHafwYnsMCagrkEhMDqjWzNyPqd9dGCWF39BPPR6ncH8vA7
	 xe8VViRRTQHDdEpe2itnEM60cwaUYU2zqKJ/9lT14RsS5ieI9gdFFTO5Rgb734EkPK
	 SmtkGlJ6+PdseJUK4AX+HHsHCb5iaPSrDmimaodlVjCkDM12Df0uoISqH51+YwcUqj
	 U7p80KmFgCEtei1cx+vbB2DHqIix7H0UAQIL9s94u3RC1QyZWgWDpxpZjD0xB8NcsI
	 g6HVLRcEVVuKnSP8SYle8EeGdn5tMkI/2PlRtBe2Zq1wElFcIpJKcshiL1pcWt65t8
	 rwZyDlDFn9PWg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D78BF49451; Fri, 24 Jul 2026 17:02:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784912569;
	bh=dC3ZTiR7YdARc8hFvQrW4zErwS4rOZqjE2cDbcMooVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zf/LinL5KSfftLG6omLZ6ICT89FF1r/sC8uyIK+f7tcUw4392B9uojnXaUFiGU4bW
	 vGIDMs2aipGULz6rwJyhFljVkRn5L6NDytsTWySwekv30BAM6qu/AcKusBJeG5hvPn
	 lDm97BVdOVTvQidys0PgfsK8nEorR+e8JNI3YC/ex0HAcwgd1cEw+nAJVaA8ecXsI3
	 A+i3w85SV0FkjFEkgims6womo/E67qCrSWURdsyBw9Zip6tVxrxp5hXOAEy3pasHlI
	 RbeMF0AJqFZcmWpG/gcpSLhLaG1reiy3JM6BNfmbKyMcta+gyOAaSpXpK1klLQDu+D
	 4Suc+3qoiSn4g==
Received: from [IPV6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258] (p200300c69f1c3c0011126ccacd9ab258.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C7B8349369;
	Fri, 24 Jul 2026 17:02:48 +0000 (UTC)
Message-ID: <c59f2a8e-4bd6-46c0-bb61-bd2fbddf189c@birger-koblitz.de>
Date: Fri, 24 Jul 2026 19:02:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
 <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
 <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>
 <6042ea40-376c-43d9-97ab-13243b946a50@lunn.ch>
 <6a1935b9-dd81-447d-8a38-74d9c19be653@birger-koblitz.de>
 <958d44c6-0902-44b6-b861-ec501ed3ae7a@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <958d44c6-0902-44b6-b861-ec501ed3ae7a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/24/26 18:25, Andrew Lunn wrote:
>> Well, only the new devices use phylink, so it is not converting the existing
>> chips.
> 
> O.K. I suggested you split the existing driver into two, a library of
> code moving frames around, and then the glue to probe and use mii. You
> can then add a new glue driver using phylink for the new devices.
I replied to that earlier on. My argument was that the frame moving bits are
rather different since the older devices use 32 bit header structures, while
the newer ones use 64 and the structures also are somewhat different. The
library would contain rather a lot of duplicate functions that are specific to
the AX179 and AX179A.

Are you aware that the asix_devices.c and asix_common.c drivers do already
have this structure (including phylink), but target even older devices? And then,
there is a 3rd implementation of the ASIX frame moving, again a bit different,
in aqc111.c (no phylink). If one changes there aqc111_ to asix_ one gets basically
the same code as in asix_common at least for the USB stuff and similarities to the
code of ax88179_178a for the frame moving. I did not want to further contribute
to the mess, but it now looks like I do just that.

To summarize, you suggest to split ax88179_178a plus the new HW code into 3 parts:
- ax179_lib (frame moving, USB read/write support)
- ax179_devices (HW support for AX179-based chips using mii)
- ax179a_devices (HW support for AX179A based chips using phylink)

Does that change taking the other ASIX-code into account?

> 
> I think it is a bad idea of have both phylink and mii for the same
> device.

I agree, but the argument would be that the mii stuff could go away eventually.
Birger
