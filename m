Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AB1AB6F1;
	Sat, 24 Jan 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273737; cv=none; b=naevCVJ/6mpnKRWezp+O6AWyv3uThJFrz5DHin0zXiDqoDZhhGrIJZBYZmG6RwooVYN0TlSckyZ3V5DP1c5atUBHCdPetbzQ+fb7G6U5jG3lgV48zdVv84MBxT1YkYkQLMAQO24AVvGnpGpS5wf7hKr/ysI8rGzerWgEScVLDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273737; c=relaxed/simple;
	bh=rq/OVGoKiCkphuwxc5rvdjx7oUh5aVwp5kn5ScZ2cGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iwcs2HDS+DFdUgZ8sKloby2lxHXBVE1sFBiwZK3A7bidkK09vQoJChpHqAWxg5BuLWjJpdhC44SoQpM2mUaE/59Fni2s3rN3bTqvxm+JENrfZiQ9+P5w4yeGKZMlXu+/oP2eeAsnFA30pS96na1xNQ1bdk8xV2z8k2Vr+A8n/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=h4yte9Vd; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="h4yte9Vd"
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=h4yte9Vd;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60OGt5DB1469633
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 16:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769273705; bh=NMb0q2Zqgth+ji1y2GZYzupnnQrISSohUnKCWRBGi+g=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=h4yte9VdybUTcuOOJrLeJwWKC8PxQ+LrLtYYvzCwCZylKPspTYoVyA4VLW8qh2Zpw
	 vIlOB5b//rrnV+iQPPZF4P2qTSrJjH27+hyemRml+PaFQaRhdejesmVMHe2/mAlO4k
	 797EJdEE1TNsfprIVfeNA30pj1TVA+xlIbgHb604=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60OGt5kJ3772836
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 17:55:05 +0100
Received: (nullmailer pid 1252903 invoked by uid 1000);
	Sat, 24 Jan 2026 16:55:05 -0000
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
Subject: Re: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out
 shareable code
In-Reply-To: <9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch> (Andrew Lunn's
	message of "Fri, 23 Jan 2026 23:50:00 +0100")
Organization: m
References: <20260123075817.1162068-1-bjorn@mork.no>
	<20260123075817.1162068-2-bjorn@mork.no>
	<9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch>
Date: Sat, 24 Jan 2026 17:55:05 +0100
Message-ID: <87a4y3j6hi.fsf@miraculix.mork.no>
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

>> -static int en8811h_read_status(struct phy_device *phydev)
>> +static int en8811h_get_lpa(struct phy_device *phydev)
>>  {
>> -	struct en8811h_priv *priv =3D phydev->priv;
>> -	u32 pbus_value;
>> -	int ret, val;
>> +	int ret;
>>=20=20
>>  	ret =3D genphy_update_link(phydev);
>>  	if (ret)
>
> This call to genphy_update_link() means this function is doing more
> than en8811h_get_lpa() would imply.
>
> It is hard to see from just the patch, but it also seems to set the
> state in phydev back to unknown defaults, and read the master/slave
> status?
>
> So i think it needs a better name.

Yes, that was my feeling too. Just couldn't think of any.  So I took the
lazy route.  You wouldn't happen to have a suggestion?

OK, I know it's my job.  I'll try to come up with something better.


Bj=C3=B8rn
