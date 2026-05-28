Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73AF17A2FB;
	Thu, 28 May 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935427; cv=none; b=FlBPELFCgCwjDMParGPaPSdz73rgFk9QPOPkmCRqVRDxIbsdCLhCppileCzT/EuQcwBuuXFieOxXltRKwovH7jhUdqHQV2KUtgqZnaRCkwRxYeiqdugG9HqCW9kE/qLgcGm4y0tRgC1dJVhjHBsnzzkmW9fY0t0k7pv6uNyV3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935427; c=relaxed/simple;
	bh=0+Ehya0eIhaWbfmqqN/uxZat3epxtuQHA5CkiGF18y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R991Ksa5PmOR4rm4EylVP3Zl7HTzgqeQtTvr3i7y4Co073RZzPyDfgmi9tkaofUP1p+JoVucO8O0Riknr9F3JRhxj4Icr13+9suXDTyXsE8meMcBUPE/ajTxM6a9Vc596IpN29p3gqGN0348tusQ3YLQ6wnDWfL4FMm1JlvpoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9VZt7hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9VZt7hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE71F000E9;
	Thu, 28 May 2026 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779935426;
	bh=0+Ehya0eIhaWbfmqqN/uxZat3epxtuQHA5CkiGF18y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z9VZt7hO1Hb4DjsnYKKh1J4qtq2j5xeO3authTDILadUDSaKIiVJYZXHUOuRaqfM5
	 2r2AVuQY8t0F4GNQpR7Eh5PObzXsZkB5Zr5AzSnhVRjW2xuU6qxisiIx+gaeRi6fuR
	 3jw+voOI0kKaqlG/+5e+kk88TaRiCMQCJ0VnlFcKtDZcGcpPxkkLhipK4sRgi5K08R
	 QXSQXh12alYKiMp/hRJ2Bsgm3iA+v8YGH3F6j0YaSmmZZgBSQUCVRl1qRHMv4ZzyYd
	 ScYe4EwRHKPUlTEjd3fP1pbmp3/P9PBRwrn/U68LIvvXOGruRoWhUuuWkDYxyqmmm2
	 THwAXgxTp27vQ==
Date: Wed, 27 May 2026 19:30:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Fidelio Lawson <lawson.fidelio@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>
Subject: Re: [PATCH net-next v7 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Message-ID: <20260527193025.64bae197@kernel.org>
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 12:44:23 +0200 Fidelio Lawson wrote:
> This patch implements the =E2=80=9CModule 3: Equalizer fix for short cabl=
es=E2=80=9D erratum
> described in Microchip document DS80000687C for KSZ87xx switches.

Hi Andrew, could you cast your eyes over this?
