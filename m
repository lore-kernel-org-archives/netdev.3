Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA2435EFD;
	Mon, 10 Aug 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386603; cv=none; b=d1afZVWDh6MdnicL6/q6j32yNfQ3Ed+94BO2sb3Yq4SZHND8y/wRKUlgEMWUXgNqH0TRiEjeizoBxdw+T7lI21fAE9EMfSsgo3iGG1lEm/M/wdf1J9YkbMBSjKkojMQv4Wbzgxh2Kr+CU3A3hzGF673SWLcLfUoM/wAsGgmAhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386603; c=relaxed/simple;
	bh=dbLPTmaKaVPAG0iyT1YtRrYiPbvWsHqqxYEcp/tSD6I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XeMsgU54KB21Fe87WOK+O9cjHRClkFdZW8D8K/Qgozwh+wDMZ/ucwyTc0xgDQVcX9qt+ixJByprplEjdiRCPN9sWW8b32TRS7DAJqltsW1R7yCTOQYPSt9wPeUmu+GLohRfNok9T1gW2FjT01W5bb1Qz/6j5D9sS3TigyqnIpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=VDCq0+KW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="VDCq0+KW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786386580; x=1786991380;
	i=markus.stockhausen@gmx.de;
	bh=i39fTiuvDyCIer/APFJzGPJhvFr01+cci1KuTbnoV9M=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VDCq0+KW+I235ODCNoIK3hzin9aMcNQ2nVsdQa4gp2WQMQcS0tImqTuN7ylOlTI6
	 bidUruHfsfhrc6Vu4vjwWWHFTwpVZM3TYPbenikZpJKJfrKuHMDMvWhsCZJ7CS+sp
	 6r6uVHJBLibtB4rUJznEQWA2T1HKjeaEGcWViLPMUdlDJNEWXC7KGQTVhUBG4hgT6
	 xFjhY5TN2w49qK2H6HyhFH1f0QuynV3lz85w8ouXXVoI2st+urizXWZ9FjUUDuViz
	 uTVB6Ic+FiRlLbXDxAhjSTnpD4ivVCZYJPkKp2Ef8XFcziH3qQScALppsuS+74KOx
	 ehpqqMiL5R4/hYDM9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1wNgAC0E5E-00SOxx; Mon, 10
 Aug 2026 20:29:40 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de> <20260807171058.522833-4-markus.stockhausen@gmx.de> <c3f81245-90fd-4660-83f9-1b09f9da6279@lunn.ch>
In-Reply-To: <c3f81245-90fd-4660-83f9-1b09f9da6279@lunn.ch>
Subject: AW: [PATCH net-next v13 03/11] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon, 10 Aug 2026 20:29:34 +0200
Message-ID: <07bb01dd28f6$34955290$9dbff7b0$@gmx.de>
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
Thread-Index: AQE9q73+nhZZ9fqTTfCC0DE79JhyFgHitQ+vAXuwUIu3u6DmcA==
Content-Language: de
X-Provags-ID: V03:K1:pJDvCFG0Lbu6XkY6tr4cs1O2KisPV3IME40SOn18jMHFmTPrE6u
 EYMdmWpDltQUNqdKEprwxORhnPawSHDac/LR1YAMEKb1oSwwlDyxxpc3vHHt0oYfkeoPVK4
 tw01nDP1C4iAC8nMlpgHNfAD1Rb+bnze2Evi9i2gp4VPS+1793HxuPvSPXD2Lpa/hKZlF2T
 hw+Fo13xnylIMHY953+EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sez8ymYjRHc=;8p/qAZfRSusKS/G6i5KBAiSSkOJ
 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

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Sonntag, 9. August 2026 23:44
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v13 03/11] net: phy: add
(*notify_phy_attach/detach)() hooks to struct mii_bus
>
> > Worth to notice: As of now phy_detach() is not 100% LIFO symmetric
> > to phy_attach_direct(). E.g. sysfs links are torn down before
> > suspend while being created before resume. Without reordering of the
> > detach function the above mentioned notifier placement is the best
> > possible symmetric implementation. For this
> >=20
> > - Relocate code from phy_detach() into phy_detach_internal(). This
> >   naming was selected to avoid confusion with "unlocked" helper that
> >   usually start with two underscores.
>
> Please could you make this code move a patch of its one. No changes,
> just a move.
>
> That makes it easier to review the actual change of calling the
> notifier.
>
> We might want to consider the LIFO issue, and add further patches to
> sort this out, if it helps with what you are doing here.

Thanks for your feedback on this series. I will do as advised and
respond to your other reviews if I have questions.

Markus=20

