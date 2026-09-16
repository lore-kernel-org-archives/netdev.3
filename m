Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98C3BB119;
	Wed, 16 Sep 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560875; cv=none; b=ZlFjvo3HZ8DnU2BvqGm0O697/BeoTs/l3aOxk7dKrjCWi6WXw67OrgQGLIEAcQVZoeFH7meBTssJD6USJk0BBceb2qxPE6XZobHwZUKzTuMmknRQq7JoOo30GYLJgBA0u1TpelSmcvkqpWrWu72HesZbra886z63rpjqgZh8dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560875; c=relaxed/simple;
	bh=nkS5Jyc1zaEdPDUgs/E2yIYOQvxTKY+N+tbghhud08g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bofCJNdrDagyraNghrVnrDNbGjzZGkGIgMfFk6LAmXK8C1OkqUTtSXHXfdhUQKsanZotH2QNcO9a247Mk6WyvBSr/+8n9NjEPX68dYkR86ILHnZ78BE6Nqrxqg3+hwnoj/QoIiCONZcOm8eymEqk2vvyFRZYiX/1SI/NIi0ocrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SiqmKpgf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SiqmKpgf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5YAjV2Rll5HPd4y10Z6mFk378XWQdEP8C2Ozl7nrl+E=; b=SiqmKpgfYvqE+4jPgx1SK+H+Pp
	npaRf46gkHoNt3DKgbxsXBo9Q1tL4gowSd/C9rjj2pd9aC3CkpCvU16X3ddGn7IjPqP5vNSVvL65d
	u5MT8UaHC6cozY7NaSSpEPzMCahngaoQfbkqKPct3Dndl7Bary9/k4+ZbJHuoZn2O0hg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6oWq-005TQK-N5; Wed, 16 Sep 2026 14:14:20 +0200
Date: Wed, 16 Sep 2026 14:14:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
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
Subject: Re: [PATCH net] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Message-ID: <5499cd10-1ba0-4b4b-b996-ed8077d6c5ab@lunn.ch>
References: <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>

On Wed, Sep 16, 2026 at 02:39:35AM +0000, Yoshihisa Yamamoto wrote:
> On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
> machine to the IDLE state.
> 
> Reset PRCMD before issuing the unprotect sequence so that it always
> starts from a known state, regardless of any previous PRCMD activity.
> 
> Signed-off-by: Yoshihisa Yamamoto yoshihisa.yamamoto.xn@renesas.com
> ---
> drivers/net/pcs/pcs-rzn1-miic.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index 2b72fa98d..818756bb8 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(struct phylink_pcs *pcs)
> 
>  static void miic_unlock_regs(struct miic *miic)
> {
> +            /* Reset PRCMD state before unprotect sequence */
> +            writel(0x0000, miic->base + MIIC_PRCMD);

The indentation is wrong here.

> +
>             /* Unprotect register writes */
>             writel(0x00A5, miic->base + MIIC_PRCMD);
>             writel(0x0001, miic->base + MIIC_PRCMD);

    Andrew

---
pw-bot: cr
