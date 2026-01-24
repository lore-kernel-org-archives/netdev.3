Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F123B63F;
	Sat, 24 Jan 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273643; cv=none; b=bDcM5V4UwN2dmRg0P5RYxyuyBYpBCFEixq3EAKcY/ILRgOssH85eLgNrWF6Bd4frkSgjtGjNfQG8hZfuQ/k9GOai1Fj77RRmluZQ0SrOqJlyoQh+VmMpjCrsvmXeIEAZYJ49BT/He0TmHESQ+Y2P/uhgtb0zcZNcRvxzRsji6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273643; c=relaxed/simple;
	bh=x6pIZFkWfo/A5QG6esJtWuDt6lzuF/qevIF179w+EhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIqkhYYJ0XV5bMD8ZC3nGvM8RCCJ2ZdrQUqVVKfYgTTZOxrYAmps5KzjmL/jflS8rI/a6mqsZbjqnL4tXGMDo+Hx05RbDOdf10yxkayJCBNQtktmz58UHzbgHw+Sp3nUkdRyiJbkXhVFyFth070de0u8tqXZoT2XrpJZtEidrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=ZEoRkHLR; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ZEoRkHLR"
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=ZEoRkHLR;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60OGr3a01469420
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 16:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769273583; bh=G+blzddir3mpT70odrfslKdPz5Oh+vHDTpmMukCbfSs=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=ZEoRkHLRGNhNXXNBX6iA3AbeMCsGWugziy0ES1iI1VvE/5i/gjFYbrhzc0Jy9r4To
	 bq+yTiuN4cRsHN3tMH/JepkWTOhx+5v1Rs/Mz6W2IMqqQWyVtfhij/MGoHppSjHIuA
	 8LBSo0vyC+WOEHt4Xv4TjDhy+Txl1Rz8vWuuG1mo=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60OGr3C13772477
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 17:53:03 +0100
Received: (nullmailer pid 1252851 invoked by uid 1000);
	Sat, 24 Jan 2026 16:53:03 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
In-Reply-To: <4a3430cc-5a9a-414e-9dbf-cbc34c8fd019@lunn.ch> (Andrew Lunn's
	message of "Sat, 24 Jan 2026 00:01:29 +0100")
Organization: m
References: <20260123075817.1162068-1-bjorn@mork.no>
	<20260123075817.1162068-3-bjorn@mork.no>
	<4a3430cc-5a9a-414e-9dbf-cbc34c8fd019@lunn.ch>
Date: Sat, 24 Jan 2026 17:53:03 +0100
Message-ID: <87ecnfj6kw.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Andrew Lunn <andrew@lunn.ch> writes:

>> +#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
>> +#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
>
>> +	/* Configure led gpio pins as output */
>> +	ret =3D air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>> +				      AN8811HB_GPIO_OUTPUT_345,
>> +				      AN8811HB_GPIO_OUTPUT_345);
>
> The code/comment probably does not describe what is actually happening
> here. My _guess_ is you are setting a pinmux, disconnecting the pins
> from the GPIO controller and connecting them to the LED controller.

Possibly.  This code is copied from the out-of-tree vendor driver.  We
already have similar code and comment in the en8811h probe:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers=
/net/phy/air_en8811h.c#n959

The register addresses and layouts are suspiciously similar:

#define EN8811H_GPIO_OUTPUT		0xcf8b8
#define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))

Without any docs, or a way to test this particular feature, I
believe the safest option is to assume that the vendor driver is
correct.  Can't start guessing no matter how tempting it is :-)

> I assume there is no open data sheet for this device?

Correct AFAIK.

I have no other docs either.  The code is based solely on the vendor
driver.  But trying to reuse as much as possible of the existing en8811h
driver instead of duplicating it like the vendor did.

I have two almost identical boards with this phy connected to a Mediatek
MT7988D SoC.  I can test, and have tested, the features exposed by those
boards.  But this is obviously a limited test environment.  There are
for example no port LEDs on any of the boards.

But that's what I got.


Bj=C3=B8rn
