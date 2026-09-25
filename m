Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470643A5E87;
	Fri, 25 Sep 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341569; cv=none; b=QnVtPkgMJGcCYFoGk+wsTiiJZdIDPbmy3zIqWnc1QdEcFnlod0AQjiTrxbnPmptLiaqSaHyPCcDwA/h3ME3kqCxIElA7cG56TyXLXuC37kU05LEzc6mSlU52hFd1xwkbdmB6aw7Srm9+R9TRlZmJEEkv7VHU8aKtu/LmZksTJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341569; c=relaxed/simple;
	bh=bbBEp9l2/h0CiKr5nTgIBBkf58NjpF7/UWnmzzF9Q/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxd/QH9pAbh+51SXAXnw5smf6YvD8QyTTR6rew1mu46uCAk1txuOuMXnj5lEe7C1Lq3vd5yBX5PtPGSdHfdohOcn21xra+oPbJ4lE1k3L/r2ofiqUm9dv0LZU41f/nJ5D9+cfb75tHkPYb6/8htPVZSMiWO6LmBqrKUr/lO4X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+eWRexb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+eWRexb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F31F000FF;
	Fri, 25 Sep 2026 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341568;
	bh=/ri6WaoaABgTpzLOK6vXDTBXig3OVUaq8diLr0aWNV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+eWRexbsFjg1bvLGXdG2RiH1RClYlZ8p7oDcK0BUWK53LykVNaMpEfTV+1fAgIlk
	 19epr7ZCXB+BvepeN/8XztbXYNKhycHFyVQRz1NkhQnSy0XnKmcJgR9Zr7ANlNdGcv
	 uiUSDgqBHklJA/D2Kc3Sik3lji0tBMLxzsxyJzDR472DQ12DgG7dJPbcm5R7LAR2O/
	 NeqS2dB6RHpv0y5GPA9NThMp9tuj3gULSRsm1J60zPBvDEs2qcjs5uGj9dleCIwLL/
	 tOmMkkp93l5gDaij+xJLaCJJ/oPKyuY176PdRTQ+rOWNEEfMNYylbR1EzL3VoALlsb
	 3XnBmkudOz6tw==
Date: Fri, 25 Sep 2026 14:06:02 +0100
From: Simon Horman <horms@kernel.org>
To: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Message-ID: <20260925130602.GJ13925@horms.kernel.org>
References: <TYCPR01MB7481CE8351FDB2CDCA229955A4872@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB7481CE8351FDB2CDCA229955A4872@TYCPR01MB7481.jpnprd01.prod.outlook.com>

On Fri, Sep 18, 2026 at 04:30:16AM +0000, Yoshihisa Yamamoto wrote:
> On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
> machine to the IDLE state.
> 
> Reset PRCMD before issuing the unprotect sequence so that it always
> starts from a known state, regardless of any previous PRCMD activity.
> 
> Fixes: 419747319e3a ("net: pcs: rzn1-miic: Add per-SoC control for MIIC register unlock/lock")
> Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
> ---
> v3:
> - Add Fixes tag
> 
> v2: https://lore.kernel.org/all/TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com
> - Fix indentation
> 
> v1: https://lore.kernel.org/all/TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com


Reviewed-by: Simon Horman <horms@kernel.org>

