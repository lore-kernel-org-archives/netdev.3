Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4F371D1D;
	Mon, 12 Oct 2026 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811844; cv=none; b=eBrYAjxFwXfAhSvEIRC0Bhh1F8H9XluR/dctxFe7HClGTZUxnipJ8tNZXHdGn0pw+znajFpkIQAYfEvVSSv0GTinGf7AiAT9i/DCrPYbn6TMvhnSDAFz1VNZq6t2FgnP8dbyGW3Gn4GcR1CX3na3uEXrZaBwmrINsvTEXGdBO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811844; c=relaxed/simple;
	bh=QV7drw0uq/lEPN9PsDrWoSjvlDZyx4+3SeJGInytyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLHVLZI74YDWkKHAkyCRBrM3RtpHCsbes1AzpTCaaim5cOSWCkQq3ptIU/DUIpKJuP11jpZrV6wptwNoaYq068GZ9UgVDZnyQbYxg1NGU4PQ9Mo7ImM5gvOm2x3tr1K/uLLGZ+HpSopsxPMJfq4zz0ZswDKtGBO32Q7Do3RjXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2d75lBRE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2d75lBRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DuZiGly6MG//A57XdYfMe+CWCXBXfmwcJvA+lJ6Y3zY=; b=2d75lBRE+dNphuw/Jhcwgoo2Ww
	e4wvtn04bBClXiJaeoxCLrf2sZvV8E0QWfvrABR0JfUfvGyLg6Vh+MXeUk7WLgwl5F5L0vLRHVmFx
	6d43mkH3XEiuCq6CQEU5nhB7fvwk4wP+2OUr/j/XZoIttEu4O+CgAZuatGN/X20UG2eQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGG6n-00AKVT-Hy; Mon, 12 Oct 2026 15:30:29 +0200
Date: Mon, 12 Oct 2026 15:30:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Do not do the redundant
 MIB clear
Message-ID: <c920abea-8334-4d27-98cb-4fdfbc309e04@lunn.ch>
References: <20261010231015.2600207-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010231015.2600207-1-mmyangfl@gmail.com>

On Sun, Oct 11, 2026 at 07:10:12AM +0800, David Yang wrote:
> The MIB clear in yt921x_chip_setup() is redundant: it runs right after
> hard reset of the hardware, which already zeroes MIB counters.

Please reword the commit message to address the AI comment, but the
change itself makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr
