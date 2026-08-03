Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BE426692;
	Mon,  3 Aug 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778330; cv=none; b=KSldkEUdUbIrRxclchtf/lq1zSxx43gqvjUnSPHkfW1FGwFrtvQPZYgkbbxBAi4xePWHw9pTXI9YVnFJPIKP13MxZHoEaTtyVtNrN50teYrMj8en6a3zRjIacywIjeFp/vVx+ozulDQyJq/RDFfK40wEV80tHeUSzq6W7JNrY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778330; c=relaxed/simple;
	bh=qu0d2HFI122zUdYFpoReqfiJ5VLNeIUoDAHSHKhwPzA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gFqYDlwp+YFhV2c8sPH4LFU1t4M3iNIhgCx6K2oH0OHJuKYM0/dlIgbYES+6xkXMSpsBdmhKKqFlmiPumln6tPP2/NpoRVpD7wMuTazHDFtKMWF8igbq+M1LfCwFUyuws8GQCyfH9tyYxIRNXfVyTkLlT/eHrR/ax8aZMBXpAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=zmoTzP9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUNEkTJF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="zmoTzP9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUNEkTJF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3ACBC7A00B0;
	Mon,  3 Aug 2026 13:32:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 13:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1785778326; x=1785864726; bh=zyta5cKVJBeYd0OST+Xqx
	/NbpgEfiG9Kn/2HGC63ruY=; b=zmoTzP9deL3YHwnx2Kyg7vvSLfT4kXacxxTBJ
	NqyMXbV9R5PgGdsCHFks91sZlM8dIN7RhEW/WLohrgxNxWWUZUmdaM3GtDoMjGxM
	R6Wg2l4IH/I81sSSN5fKZVP86srGNTxpzCELOxccovfZ9/Rb8FYAcrA+GSK7H8hG
	AYsRMBMYxPw/usxzETqh0xqxiByZc83WIjBxlth/sBQiKKML/oPntCYakVTx0XsX
	h6Mi/ljBV+DY6+foNo4hoRMT0fX1GVPLiPX+IKLKcntMduC2g0G4riuw/xySIKLu
	iVCfVepgAwcclQ/bQ1Rc5ofgHlYZpKiWiDf0pCWZ5ipBuQvjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785778326; x=1785864726; bh=zyta5cKVJBeYd0OST+Xqx/NbpgEfiG9Kn/2
	HGC63ruY=; b=GUNEkTJFK1kH61JWMoGsmTL8ev5/tjePOD3i0KKZnWC4fT0U/ER
	aoPAZgNPxrCF2TQ1d991GWtl1JxLYUEDZEwXdc49TMN3vXK0i/6TYmwX0RoXlK2D
	RRqiD/U+VpKXBB4lpBEtoH8hJWiqKPgY3/pie3eRzO0ixwx2xfeabEOPjHRhspHC
	lVWX6d0VfqRc79gP5zH5dz478K5kCOUMLunHC7nyEF93LpqbdK2y8jWODt7A64Oz
	UzvbbmtTv9Lhzz6ZRJ8DWR0bwM/lSCWMwy7r3LiteueHFPj1L5SCgIpYMhwEwZKu
	W1S8PwJPKc97ioS8aY41k5kHncJAHnpCuKQ==
X-ME-Sender: <xms:ldBwanjYivS9mERzQgqSVYEGvhxF9pb2RyPr2fswcJWbIGNUCZkIBA>
    <xme:ldBwauAYI_GmYWKNMY889DwGkk8y7oiPYfBMVu9460AcKQ6SYCB3ThL40NkrCO1a-
    uqYMGYXgeApEYUhCM8enpeNnY_AQjOEe9iEcWBMzJWpxB0gGNY-5A>
X-ME-Received: <xmr:ldBwattlCYsWj4Dj0-foX_HZHgla11g5XTKvRw0Kovp02iGf-Xi21QRq5gsTas8MZ-KMmg>
X-ME-Proxy-Cause: dmFkZTGWsDSBQqODn0KbLouuZAoqeuTGzVb3k5zXV/nBKVF5BzJs3vDkUJu2MsKKbpiLOP
    fyBc19gvJCoXiEL4kAHltRdR73dvjBmH7bGeCOns3rKLSGp8WTKGecRpBiQWECKNJ6CyLt
    MMLADRtlc70AEWE9dhwisye47SCsqaGDErwnssS4Zi9fefuWeBrtx5m4hzWbVXL+bntam1
    9Kq26aLTcO+mPrpUngj+kpdjPgqY3V686/caLJ2vsFmoIsjm2OWkEkuS24GwzMKwlYKXUZ
    z2t7uxbK9Bvi7zlJPtoY0AYJW6mPEtM2QIuhArVyN1gNX/+dR9v7VbiZ0KUosL+FuWSfoW
    tkOUr199Jzc1QVW67I+f4YZp7jQ8v++gg9Z53qCsLjPl4hbTuCXcgVSeAV8PQn6bu9nf7q
    p1CK4+3YbEC98/eeJwVhOzcl2VBycLIXZpCyaMu+XAXtHY0M39vgbmeS+0j4rAyOYcNgkC
    sXaOL0Sv/5vt9bRBKOeOknz+FTRm90Amp02EmZlUOmia2yrcflj4zWvWGXuLBlZxSytG8u
    T6nI4W8Qi+THUW4Ig5A5tJy3Z+ZMazAZKqMHrAOtmiT9i0UrOvywFgKDutP2KpKJBMPNtz
    Hb/ty4rBt7uUOo05xLxObowlqoZPmwwCttwkJZGof1vPqFdL7mmvEmBa7uvA
X-ME-Proxy: <xmx:ldBwaiceH1U4o4nkvj9128BcMxG65yHQfgBgg226agzFHMX-7AyM5A>
    <xmx:ldBwai8xDlS6HDjoPNM2I_uZFuXx2wGarMiRg1YLO97KMv1eUK1Taw>
    <xmx:ldBwalQLQ9Z90PTa09EUxbe_ilXIa3w2idQEXWabvpqZWDv35KCM0Q>
    <xmx:ldBwarofR0d89FWqlXOZzCjMFuuxsqXXOVFP30hNuYyfAryg2rx0LQ>
    <xmx:ltBwas-1tLjHlZak4UdPPcNWHumMp6pgSW3GQSKsnsNvs680Vi0fA2mi>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 13:32:05 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 00C459FC6C; Mon,  3 Aug 2026 10:32:03 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id F1CE79FC3F;
	Mon,  3 Aug 2026 10:32:03 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Minhong He <heminhong@kylinos.cn>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bonding: check register_netdevice_notifier()
 error in bonding_init()
In-reply-to: <20260803090012.142638-1-heminhong@kylinos.cn>
References: <20260803090012.142638-1-heminhong@kylinos.cn>
Comments: In-reply-to Minhong He <heminhong@kylinos.cn>
   message dated "Mon, 03 Aug 2026 17:00:12 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3479488.1785778323.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:32:03 -0700
Message-ID: <3479489.1785778323@famine>

Minhong He <heminhong@kylinos.cn> wrote:

>bonding_init() ignores register_netdevice_notifier() errors and still
>returns success, which can leave the bonding module loaded without its
>netdev notifier registered.
>
>Check the error and unwind prior initialization on failure.
>
>Signed-off-by: Minhong He <heminhong@kylinos.cn>

	It appears that the matching unregister_netdevice_notifier call
in bonding_exit has the same issue, although there's probably not much
that could be done there other than printing a message.

	Regardless:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J


>---
> drivers/net/bonding/bond_main.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index e1bec8164221..3405a20bd498 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6637,7 +6637,9 @@ static int __init bonding_init(void)
> 				flow_keys_bonding_keys,
> 				ARRAY_SIZE(flow_keys_bonding_keys));
> =

>-	register_netdevice_notifier(&bond_netdev_notifier);
>+	res =3D register_netdevice_notifier(&bond_netdev_notifier);
>+	if (res)
>+		goto err;
> out:
> 	return res;
> err:
>-- =

>2.25.1

---
	-Jay Vosburgh, jv@jvosburgh.net
