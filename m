Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575A1531C8;
	Sat, 12 Sep 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171732; cv=none; b=WPZkt0EyQsLhWvN/z++IYCNE7ICko0ftmuf//8ORWXFdXqcracDsvmtdBr9GIBGQxPlUI8M0jrpTsAnij/mZdaZKwzjpyAvI8ZWSWeLGbbXtkacBkgPTw0H5+gUOC+4ND4DCpc9P1akqs0NHuWbh2/+xxb011/RlVqPt+MRmjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171732; c=relaxed/simple;
	bh=2ZkF654R7XSlQFkUaEAYRtIWvVu6Q3LNH/mvUlhmnNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOHwdG2JDlHYX8ejl8E/sftbi5WqmlAr9PEbZGzrw+OieXYqjDkhypyrr7RjZoFR17gHt1tihqynMomFrrW9KC9vyxA2i/nitRbRVY8Z9fFKAlZ5/8yH6rkjjrdJExEhDbZ+Xh/V5XrHqKNeKr/+8IicYMl6yLE7G8lYMBmFbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Oq/tER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Oq/tER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72761F00898;
	Sat, 12 Sep 2026 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171731;
	bh=PKOjMDXQRwMnjwfHSFSVSkvHj3xfpBDTda3CqhlJen8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q0Oq/tERW2zN2geFXSdG5TcvRwsirw2cC4ORPsqyD8VIM5+1uPIUu/MPj6FLSXxIi
	 PVULcXYpZ69OJIEcvRU+1VkvTyj84g2mEh5bz+fUkRVFtMGRrL4LO7Zo+Hobc+ptu+
	 7eG5T2TlTJg58ugjY9vvZlLMTOPtOqkH6x9K9upMQ0Ea95JC5vrPpbCLtR8lDlLbAA
	 LkCDuxnYw2xdicd9PWl4JtDEgXtp6/i6QzaCRVIToqM1hTPA76deOh1yUndeAU4dDc
	 Jqt4Jtn2rtnlYk9d0cNqPSswzsY8lRHWyo6/2AQxisdkxBIzo2P+Zehe46xLSuo0mj
	 kPV+muiZswLBA==
Date: Fri, 11 Sep 2026 17:08:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Subject: Re: [PATCH net-next 7/7] net: dsa: mediatek: support EN751221
 switch
Message-ID: <20260911170850.05cfb134@kernel.org>
In-Reply-To: <20260909140346.2861572-8-cjd@cjdns.fr>
References: <20260909140346.2861572-1-cjd@cjdns.fr>
	<20260909140346.2861572-8-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  9 Sep 2026 14:03:46 +0000 Caleb James DeLisle wrote:
> The EcoNet EN751221 has either one, or two, onboard MT7530 switches.
> Every implementation of this SoC has one switch on die with the CPU,
> but some chips - notably those with a "G" in the name, have a second
> MT7530 as an MCM module.
>=20
> The on-die MT7530 has 4 FE ports and 1 GE port. The MCM switch has all
> gigabit ports.
>=20
> The MCM switch connects to the SoC switch via a TRGMII link from port
> 5 on the SoC switch to port 6 on the MCM switch. This link undergoes
> calibration on startup.
>=20
> All known devices with the MCM present do not make any use of the ports
> on the on-die switch, it is put into "passthrough" mode in which all
> traffic is shuttled between port 6 and port 5 without alteration of the
> DSA tags.
>=20
> Add support for both the on-die and the MCM switch, and calibration of
> the TRGMII link between them.

../drivers/net/dsa/mt7530.c: In function =E2=80=98en751221_trgmii_pair_setu=
p=E2=80=99:
../drivers/net/dsa/mt7530.c:593:12: warning: variable =E2=80=98default_taps=
_ondie=E2=80=99 set but not used [-Wunused-but-set-variable=3D]
  593 |         u8 default_taps_ondie[NUM_TRGMII_CTRL];
      |            ^~~~~~~~~~~~~~~~~~
--=20
pw-bot: cr
