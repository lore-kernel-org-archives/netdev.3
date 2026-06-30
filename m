Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3027364EB0;
	Tue, 30 Jun 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834944; cv=none; b=cp7boooLVpwqowj1eyiOKsNB82uYIOokiJIYaut6fnxKyJEKRfkLMBWEu5Pj9F5ki45B0/cDbqOIRdymt6eVyID8OPf132L+ZXDYPQ1SCidO0FXmRpqxsT1+BL+LIsO0IXOZP93AFBAOckKFh75augJehyxneRkAiu9oPZQpnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834944; c=relaxed/simple;
	bh=qNw+rfc5RaRzX4FS66f4i257tm60WUbUF0Yzq6qnW/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQxYDj0ZBlq075I4APradBsTT/5MzhPJw+jg+U0oLc6pzRCruOWrqqdDWol151RHdG/eJ6zwuoKT1BDLDDoP+z1I212yVCs9O74llgM8ebmyDPD/4bJjF3C7nISMufX3UFXUR9qu/sf+EHeVXNmbipsF0sShEgj+Tf/99EZzwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bln5+dvx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bln5+dvx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1DSEkkeUWuBq852dBwLWoDlL272j4zDNWdzdhzKPv6Y=; b=Bln5+dvxZTlmqJ2KXuVvTDs9Jb
	Nz0zst665HeIJUQqc1vAJ3r3xWvB5BqiTsBZcUtERT0DEGAhYKBmd4gyWlA7eiIAZ/4b5M2cmU+tn
	qaeBwXoj0fjVuFcVGiyuB1QAcHE9uUKs/JeodNQwQrba59igTqTHozlTlgraUZ5ErU/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weaoA-00A0tu-LA; Tue, 30 Jun 2026 17:55:34 +0200
Date: Tue, 30 Jun 2026 17:55:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: phylink: Drop references to the
 .validate() method in comments
Message-ID: <7b12830a-85cc-4681-a6bc-4f9e252be129@lunn.ch>
References: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>

On Tue, Jun 30, 2026 at 10:37:00AM +0200, Maxime Chevallier wrote:
> The phylink_mac_ops '.validate()' has been removed in:
> 
> commit da5f6b80ad64 ("net: phylink: remove .validate() method")
> 
> There are still a few comments around in phylink that references that,
> related to the ports fields as well as the Pause configuration. Let's
> drop these references and update the comments related to Pause handling.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
