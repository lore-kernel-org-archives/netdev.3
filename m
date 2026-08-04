Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391845DF72;
	Tue,  4 Aug 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849997; cv=none; b=inyYtWKws5xoQv+FoNVbjiHZNCrf9ODPpTron5ERDw+O9ioKyDMz6FfqQD1R+9A/Q4c/YRPXF9VuF9EJ/h/hM2vr0Dk4n0R7C6IULKkDFxqcY8YU9qv96poMZuC7ojOTyns+7AAHl/Ishb7AmBBVIj3qvIiDA30h37H5wxMzrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849997; c=relaxed/simple;
	bh=XhFZeKL5Sn4X7BedZWQwy2j0fPx0KW72upyLeK6pJcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0o8cL44wIZ5jZRyCCfnRWp4UTF5YFsFbUMOOBGFv5dGuYTFecwvee1fCDZL+gUK7msZtpICHJCjZF3hI8PlL69rEnw/cMBA2SjS47rzdxF+UKXSTNfBzydrXbWM66bbTR6MuEe3NrCCj+xjwCUMd4gXCcVlBoWp4TQAcvaX1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R4h9jNkI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4h9jNkI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9F8JU3oj6i+P507qUThZb9pSgFYYfyS7ll4cwREFZiA=; b=R4
	h9jNkIRgeEjBUeEKdaEbMwHSQ2ywJuH9CkBqcqFD7ICoV5Ch6WQWmhKmkfVLO0OnNQCgQzvFSW/+5
	M1pIZRN+TrqWltEBtz2YySHKPnMi/d5pvaZMgitfWi3D6h1LGclF3tgGKZzDfL5RHIyvKUNaaJpX/
	0SEVpPHIxEOs8MA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrFA3-00Fzf9-3N; Tue, 04 Aug 2026 15:26:27 +0200
Date: Tue, 4 Aug 2026 15:26:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
Message-ID: <78ad6961-6be7-4759-8c7b-f4ce070521d3@lunn.ch>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-4-a.shimko.dev@gmail.com>
 <239a7699-bbda-4fab-bfa0-604b1d8806a9@lunn.ch>
 <CAOPX744YEhdgmOFPT8PjfKp=v4tVq4XefYaRnk7N3J4MPB9sfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX744YEhdgmOFPT8PjfKp=v4tVq4XefYaRnk7N3J4MPB9sfQ@mail.gmail.com>

On Tue, Aug 04, 2026 at 10:13:06AM +0300, Artem Shimko wrote:
> Hi Andrew,
> 
> On Tue, Aug 4, 2026 at 5:30 AM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Why 0.00 for one and 0.15ns for the other? PHY_INTERFACE_MODE_RGMII
> > means no delays.
> The 0x1 for TX is the hardware reset default from the datasheet, not
> a value we choose for RGMII mode.

Ah, please add a comment about that. It could be there is a minor
design issue within the PHY, and this is their workaround. So keep
it. A comment will then stop reviewers like me asking...

Part of producing a good patch is to try to think of all the questions
reviewers will ask, and answer them as part of the patch. Either
comments in the code, to text in the commit message.

	  Andrew

