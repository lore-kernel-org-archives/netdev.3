Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5C568FB4;
	Wed,  9 Sep 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979681; cv=none; b=k3y9+MvXmpgsDrqp0qJG4OG1KU+JTCguS75DYRbAvlP6G8krIPypj95acq1q3Hd9bSr2AOAaSvW8yZfv27aLqYWZWaH+zxLixLkYs6YuqOO0gK9sfc0MmXph1PEzvTK+KO5KQYP4eRm0dG2A2FBS6l4H1u7YV98PJMECyJdmPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979681; c=relaxed/simple;
	bh=YBUwuazFKoER0Io6x9et3eIYh1YCqXWyyPJONO5EEZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWnovbb0uDq/rbxyqLdDR6UsM45A80kD9q/gNIRtSeYNxHijBXe1fA/6wkhn5LsTV6yo8PlPF8OCAe4qfi/xM5Avk5msOvxBDympBUROqNm9mmc/8dTHVdi1JzkO448Aa0KPY0JWB+oFfX2Cus7Q1yAGOMcfiBjdt6MoLhPt2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rf9rG4Lr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rf9rG4Lr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xd09WSoeCQnWjQkfhMWJKJhtmZ9tMKocHNopYHX4MQI=; b=Rf9rG4Lr+b3BvxU1Ni5HQYdYgy
	N/ntpr+I02bVwgWuzyrzyylzUAeV6OmS1Cs9jdCsuMRXRoQ3z7lR+68CsXtIMEU4YABf92gVVRtEp
	CAP64ORp8uxMYb5AxQw8rpuoJ/ZBOq3aQI3TTNUwRj9f6I43Rn+0WQEU49LswBNOCNbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4NKl-004MY6-1m; Wed, 09 Sep 2026 20:47:47 +0200
Date: Wed, 9 Sep 2026 20:47:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oliver Neukum <oliver@neukum.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Subject: Re: [PATCH v2 1/2] net: usb: cdc_ether: add NCSI passthrough support
Message-ID: <f398b930-0049-44eb-a4c5-64a08befe76b@lunn.ch>
References: <20260908-ncsi-over-usb-v2-0-92dd78272fbd@gmail.com>
 <20260908-ncsi-over-usb-v2-1-92dd78272fbd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-ncsi-over-usb-v2-1-92dd78272fbd@gmail.com>

On Tue, Sep 08, 2026 at 09:01:31PM +0800, Potin Lai wrote:
> From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> 

You posted while there was still ongoing discussion.

> - Keep carrier always on while interface is up, as NCSI control traffic
>   shares the USB data path (unlike PHY-based drivers)
> - Ignore CDC status notifications since NCSI manages link state

Why is the emulator send such notifications?

    Andrew

---
pw-bot: cr
