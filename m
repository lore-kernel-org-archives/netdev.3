Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEC472775;
	Tue, 28 Apr 2026 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400170; cv=none; b=NESgBYsW38ayIWlUVCC3rCoSYEm9vUtonGNsOa48Js9GqxvHkNHjCRBMaeS1CEmeOK84CUWqUFkKlCE3jOpLmdQM+hxwNNpF/iuepftKSCac/mXlGX+YfUKwtDCvWGPzC0NtOtq1u36KhAp/Nl1PJz+GntZDDFVgUtTbKjBdgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400170; c=relaxed/simple;
	bh=CfnuGNVtvyVkIg4D6XoyH2upeat/Ucvt1FLvXNoJdGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hic19L9j29/fdf7Y/jcwldtSeNxPyWuuqWRl5kCcS0PJ7+JEhOvaPtikNn7tpCMN94DUV/sJyPMMSntHyC48WGl2J7kt8t8RnWcWmh5zWrVM/JTKKvmpuUSc6YGVBQq+ZLfWN4f6USTaFmH9d+p+rteWpYCSBQ9/MIMRVsJHQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QAq1Tekj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QAq1Tekj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PZVQ4OViT35E/GKZrXOrPA6LRYR+VLf98sqtL5tsCUY=; b=QAq1Tekjvhqt60dGv+jGdw8oMO
	0I7aJEHFLzOwHThqdvDDyXZ3mO7HQEpTg0dtdeHfiyxIQVrUX4mGZr6QMzvILUiSQowyhUzm3MuiU
	luzh8kosSBCQOTH3VoqK7nIwigwnT3GnjB87QQrVTpHQpClKNuMKoq+v7YKQZjYCitwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHmyU-000O3Z-PX; Tue, 28 Apr 2026 20:15:58 +0200
Date: Tue, 28 Apr 2026 20:15:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: mdio: Add support for RSFEC Control
 register for PMA
Message-ID: <8b662c6b-696f-4402-b736-f2a20f0c7500@lunn.ch>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
 <20260428172810.175077-3-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428172810.175077-3-mike.marciniszyn@gmail.com>

On Tue, Apr 28, 2026 at 01:28:08PM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> Add the constants associated with RS-FEC configuration
> and status as well as the indicated separated bits for
> DEVS1 to convey a separated PMA.
> 
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
