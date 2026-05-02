Received: from smtp.xn--rombobjrn-67a.se (nestor.xn--rombobjrn-67a.se [188.126.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD31A6831;
	Sat,  2 May 2026 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.126.83.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777721515; cv=none; b=Pitjyo9PIjpERVIwXtfq6kw1BegK6fm2sx+4J0c6roUcUKUNrOSOrJ8G2rWXfxUiKoxvCIL4WQj3Z08O9SJYEbuLeUKi3kWSyebwbydde5EBcNrFPSUip1uyn2rfUY2Ek/xhEfHrkrAeSJVFpgpxYby3iWK+ZW56wrY4GRzQU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777721515; c=relaxed/simple;
	bh=A3vGxSeaEOC0ehyCWhZbXgnccbtdifS+SSyz8g4nKaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO28V9Grv+91kJ1YMa0rRGvTk64ljoXOshIMJ+K8eOUduYmPqDQ6457lvbsR+tviHOMHN78DZ3qO+L7ks6CEGFUcHZDwER57Z0S/9VCo+HZIlt9X5NkTaq0PSeMxBkY0hItQCQ3h6xZChp5pqwIuNw1XMy9TVfBRTnl5rBcNObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xn--rombobjrn-67a.se; spf=pass smtp.mailfrom=xn--rombobjrn-67a.se; dkim=pass (2048-bit key) header.d=xn--rombobjrn-67a.se header.i=@xn--rombobjrn-67a.se header.b=At2XEd1M; arc=none smtp.client-ip=188.126.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xn--rombobjrn-67a.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--rombobjrn-67a.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xn--rombobjrn-67a.se header.i=@xn--rombobjrn-67a.se header.b="At2XEd1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xn--rombobjrn-67a.se;
	s=a; t=1777721144; bh=A3vGxSeaEOC0ehyCWhZbXgnccbtdifS+SSyz8g4nKaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:From:Sender:Reply-To:Original-From:
	 Organization:To:CC:Subject:Original-Subject:Date:Message-ID:
	 In-Reply-To:References:Original-Message-ID:
	 Disposition-Notification-To:Disposition-Notification-Options:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 Content-Features:Content-Alternative:Content-Location:
	 TLS-Report-Domain:TLS-Report-Submitter:MT-Priority;
	b=At2XEd1MVpaO35gBD2TNsWZ0EQSMzsDeLvO+4TC860rCrdQVkRIcYAjb6uRpv9AsZ
	 2UvJZoN1wFMcDWFba2fwZD2rZWIbL8PKt9jvDELHUC0xiCXc9Q4pr6vLrvV9N3ipnc
	 CvKHZmNZXji76OB6OQjnMT2ltFFcUxG60NbHBtW4RRE3jj8NYh+4wkMTDpX98NfND2
	 liNXyy1gz+hObdXo9V6SRm6zL6ZavbnZAXHH/MLape5TNtBT09ZVjqFlXKbT5KH7lq
	 +kwSOXzmBFOEgBj7in43UF6V8aZTo6/Vesf3LRL+m5k/nhpjX+8815dR34o2Tjsgrf
	 toU547BRNodXw==
Received: from tag.xn--rombobjrn-67a.se (tag.xn--rombobjrn-67a.se [192.168.72.9])
	by smtp.xn--rombobjrn-67a.se (Postfix) with ESMTPSA id DB4EE407BE00;
	Sat,  2 May 2026 13:25:44 +0200 (CEST)
Date: Sat, 2 May 2026 13:24:46 +0200
From: =?UTF-8?B?QmrDtnJu?= Persson <Bjorn@xn--rombobjrn-67a.se>
To: Wang Zihan <jiyu03@qq.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v2] net: switchdev: fix duplicate word in documentation
Message-ID: <20260502132446.5b2c51cf@tag.xn--rombobjrn-67a.se>
In-Reply-To: <tencent_93F8CA2FB714A80C571AC978F39E51D6E506@qq.com>
References: <tencent_93F8CA2FB714A80C571AC978F39E51D6E506@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7KymnrWYGcZ_jCt9wcilTxM";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/7KymnrWYGcZ_jCt9wcilTxM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wang Zihan wrote:
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's pos=
ition in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved =
into a
>  bond will see its upper master change.  If that bond is moved into a bri=
dge,
>  the bond's upper master will change.  And so on.  The driver will track =
such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by
>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
> =20
>  L2 Forwarding Offload

This change claims that a port is a position. The preceding sentences,
talking about "a particular port's position" and a port being moved,
make it clear that a port is *in* a position *in* the topology. The
port is not itself a position.

Bj=C3=B6rn Persson

--Sig_/7KymnrWYGcZ_jCt9wcilTxM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signatur

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE52SginNFTPmg+iBb4Tha3NZK5j8FAmn13v8ACgkQ4Tha3NZK
5j8s8hAAkqDw+y4bCs96k3Igesu6YhghD/E8YXetS5I+A9gsAg6Digqw/V99nkRn
ntFhbaZIqmb3KsFCE2RABP0XP6Mj91Rfq+pYpV+balVx6v0U2yoCJqwjfgJl29yd
VybG9I9IDQdrCmTAh4YWvUOKiuSmtdWYsIsH0hESWIaB+dHvOoEvba1F0pLWfnd0
com35sHH9qIz72YwcU2+pamyhjb5j4H58zaFJFn3SqbVZvFlmCI2yfDaRw5kNoEt
v4LKBZGlC0UEik74u+mK2YdHRp43gRsG4dzIIlWVpGiBAqPGOtl0FGg7O5Bjnofr
vaAsZRXOJlX7BdhuYx+QC0pw9YqRqELD9FExSai+NXTaF9llOHLwZhtlR2qcn1Jt
SvMmKggcvJkh1BLKqtS3ApYKMN4AqnHFqd3CMarW03wU0kuO6gReJHU+ecXpmroj
RfSFbH1qM0OHKU+YRE9m9HzAnkZXxj/0gyTlYPHmuPxY+84ie4hKTN1H8jQXnIGo
ITzrLVyy/08rfBbS4WFHgIC++c+xE7KZbBt18YLrFawo2Kozzb9U0ZTw/d1fS/FR
bedfEoO+phVwrhFESwNj32xXG4CGeaCIr7b81i87iTP/H/4UorucnKEJBDVMho/n
mrdhyY1LjWBoLnckoZT26zUaSkmCaidYcgka++DjGtwtwBfE8EQ=
=PIgh
-----END PGP SIGNATURE-----

--Sig_/7KymnrWYGcZ_jCt9wcilTxM--
