Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDA2EEE90;
	Thu,  4 Jun 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611219; cv=none; b=SpGHmQ+D5OiDKL8GRROX00vqDtxfFqqSpwTMKerAQ14sq4AtHZILDQbRYoL+Ij9byULVd1L3fwQYA/OidsFZ/ddilp+lRRAupVTDFUof5Z5KRKaxuCVgIPu4j0hcEUDGL/7nqKo1lACWAPHKU5XAM9lu1zXMMpEXBsWuIbfn5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611219; c=relaxed/simple;
	bh=VBPzNNhKg/gxgevw9Vu7BeyTNnOknUjKtkIaoQ0qFUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjEnaa2bx/KME0I7/2EumJKNuwMR9OwVf72XGolOLdQDTAbB3Sh9kdpojKL1bJgpZbaKU5brlMgki6r4GiLk2PINf3Z5VngOFK35fCJ7wOx8wRzxEk5gCB8VklCZBFqu8XZ07tub/geXNwBuigyUQjR0YtCSl3fg/t7BvUX4eHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2dBSWT2E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2dBSWT2E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c1PTdC9lXCxKPecUug8orxQ1I8i9oybZdggOXybuF2c=; b=2dBSWT2Erl8bH1W14lQ4z/tzlW
	xOsL5jj92/VqRaLSDi27QR3X/CiVUJs0LMHmaUlPrBnAxFHufLXL4FXN/5EF7GWXMIC+VoncsL9OV
	168ZwQ3MvVwqyyH7i+yy7yXVIEeawy7qpg+6qatpq4UG5T5jHx8Ss5GDTV2WarsO2CTM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGJU-0066yJ-Ej; Fri, 05 Jun 2026 00:13:20 +0200
Date: Fri, 5 Jun 2026 00:13:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] net: ethernet: oa_tc6: Export standard
 defined registers
Message-ID: <171a1424-eb9b-440a-ba3c-2f6296727a44@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-5-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-5-5debdb3173c4@analog.com>

On Thu, Jun 04, 2026 at 07:32:50PM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Move defines for standard Open Alliance TC6 register addresses and
> subfields in the oa_tc6's header and add entries for the PHYID and
> CONFIG2. As such, other ethernet drivers that rely on oa_tc6 can use
> them directly.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
