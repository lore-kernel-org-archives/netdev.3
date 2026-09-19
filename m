Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F337C92A;
	Sat, 19 Sep 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801715; cv=none; b=Qq6oSbSfz6k0wjVwIC9ZoDmz4aqyKzF7MX7uJTe/iJQoPzFc0b/QGp+kAV60sILm42JJls9L4Ulh0N2Oaq4twTWlCsN4FgvQZ87SU9oJJ8sHvX6ixv1JSUkYqDp47JvVnTURwj97apRv89ch5b2PLVDmGFh9Wa98DlE+hDzc8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801715; c=relaxed/simple;
	bh=tVg7cYLlFFW0Q80Il5cGDuD6WH0A4OjX5Q8Ten5PIuk=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZuFyrS/Eg+AwwlVj1dKFOoDC8/R2WRaSNuVGNDfVLAR1OTInFHqIE4JmkIOhFRBN2+yyN/SzsHBEcfA4XnKjRH0v8K9mXTPfj/mroGCI/zsOjoHOYFKBNaW7qA/9kRiaghBdCLGobHKMd4YFaVdFapiMsQMxgHlRZnEBcqzZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=tTIDKaaP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="tTIDKaaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789801702; x=1790406502;
	i=markus.stockhausen@gmx.de;
	bh=tVg7cYLlFFW0Q80Il5cGDuD6WH0A4OjX5Q8Ten5PIuk=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tTIDKaaP3ECJELn0uxG8OFYN9mbY9LaR+IWn3HRIVPDfDBg0w7MN/Kb0+dJSHTiv
	 9fYsICS1f0QdaVrsL94CjYBoqeElYMjOuTkkiSM2xOrZDVSTkTR3YWArTygWIqjvT
	 d516rzecWHKagC6IR9Z0eHumMdGZlWRuc7UnHJIfj4hOEikkuYFBhivMaVYCLqGGy
	 el69aPTT/edQ8Rjy7+C0F1nC6GDhVHc/MdzH7LDnKR7Yxbv+TClcGyJUlyJR0+Rsc
	 fyrLxyu6v0WS1mPRO5kmNCn/X7hogNd1HncoC9a838VDJHzWo9winxcAzc2mQW9IS
	 hXAfrHc0lvcVxy8Mzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1wYDRv2xhy-00l8Oe; Sat, 19
 Sep 2026 09:08:21 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jonas Jelonek'" <jonas@jonasjelonek.de>,
	"'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'David S . Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260918211955.3955777-1-jonas@jonasjelonek.de>
In-Reply-To: <20260918211955.3955777-1-jonas@jonasjelonek.de>
Subject: AW: [PATCH net] net: mdio: realtek-rtl9300: fix RTL931x C22 extended page selection
Date: Sat, 19 Sep 2026 09:08:19 +0200
Message-ID: <004e01dd4805$a804b4e0$f80e1ea0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGY5yhDeQ9Lb9A0Fd7F5oOf2yV1ardePEqw
Content-Language: de
X-Provags-ID: V03:K1:2fwPd3nGwiQNAmTCfKLgu8qtNRhiJiGf1VsEzr4UdjBC3qQVeXu
 AdQpI43zgykz9gfv38rkuI3jruYpxPnh05dPv6A5dbUAae+Hz0B8CiFA2oMpNDOitYJfaci
 OEanZsNevwUY4fdIacisSMZsIPMrw7dL09u8VZuxayGzhoIyHxyb0h0xAveDyUswNY+4NgK
 iDRY+ooryT7lNG5HiEoiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WcBVZrUmMbA=;nclWuW/6Jf59degtAQJz4ixO6FV
 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
 H5Ce

> Von: Jonas Jelonek <jonas@jonasjelonek.de>=20
> Gesendet: Freitag, 18. September 2026 23:20
> Betreff: [PATCH net] net: mdio: realtek-rtl9300: fix RTL931x C22 extende=
d
page selection
>
> The RTL931x indirect access engine has a separate nine-bit extended page
> field. The driver leaves it at zero, and otto_emdio_run_cmd() therefore
> programs extended page zero for every Clause 22 transaction. This
> overrides page selection made through PHY register 30, causing accesses
> to private PHY pages to hit extended page zero instead.
>
> Set the field to its 0x1ff "do not change" value for RTL931x Clause 22
> reads and writes. This preserves extended page selection made through
> PHY register 30 and restores access to its private register pages.
>
> Fixes: 5ebdcac59aff ("net: mdio: realtek-rtl9300: Add support for
RTL931x")
> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>

Acked-by: Markus Stockhausen <markus.stockhausen@gmx.de>


