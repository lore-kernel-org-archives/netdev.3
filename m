Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280914;
	b=Hp5lDlQVM8d6P0KeOwSrJlybSPdvJu4IukncmeJycDP0UVFxKZsN8uroPkQrCiR6qa/w
	 U2xNEjDKfC0HJeZeiHBNPvieMd8pZ7ojNo/6V5fKx8adbY4A5rgqtEsfskBA5GKWWnahq
	 VXsFt3Jb1g3hXVpuE0+DjQqiZTQZ0TThR0bGzFGb2ZNrXReRyxmF71z6jbyD9R4hrqZwH
	 482sVDDtLD+uOuE6zh/Ba2PhBFs9a3uW9DvZAi/ESINJG/c5QFi7th9a41WRxc7R0u3SG
	 IZXaNyHzidEQuG4UBfEU4LhsSHcZ47/iUsZtFbY5VG1/j5CSpZAz+1CCyXzjTQsYbbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280914;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=p860bwH6YeFofoBMbDY5HJC01y3g60gjrZpZOZVP8Oo=;
	b=W+IV9JV4B/4CIg8JOiVAFaiKyN2svmn8ikdGIEAEjn9q4+TFIuBkyKT6NORsP57UIw13
	 gxekk41XN0BJnKG1LihjmFc2pP9WcBjifS+czfLVa1vRaDiK72HeJ6U801mZuVs+ar/cg
	 RE4nXCmEJ8RlTYzrGHiu6DH5kvryQyVBj8GWlXixJ3EiN6RwXkj/Dtw0yh2EGpiooYbOS
	 3CHdWeS8r715rCEuCkGM9RDApbZE/taabaMqKwswADrsev5CiNfAWPm/iT3mQInUobHfb
	 4RzoBok8VdAJ9MvLCJyvpnYMOpW5qfDG5RFo6DYD7PYYC9UVx8xHUGzxRcJbYiq243w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lzAIydcA;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D9606A324;
	Thu, 29 Oct 2026 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E1D9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lzAIydcA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p860bwH6YeFofoBMbDY5HJC01y3g60gjrZpZOZVP8Oo=; b=lzAIydcAdQTTqpVd36qz+60LIV
	G40qigAE0laJGX5NqEExCMlBU5UI631Sthnq6zl9R+h3lVn54tBjoY3013UDC2sB/r1LS6lbtpjxG
	HT96Aiub0i/xeyHZH3rR/3GQrn6JkTlr8/XBgyaWRiQ0p8GtcPkVFdoi+QayCEiLNbaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMQHa-00DFWc-1w; Thu, 29 Oct 2026 14:35:06 +0100
Date: Thu, 29 Oct 2026 14:35:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
Message-ID: <12b07a59-c087-4ba2-8d5e-40b2a6d6a72a@lunn.ch>
References: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 05:28:10PM +0800, Hongmei Xu wrote:
> After the firmware reset sequence completes, the global reserved status
> register (VEND1_GLOBAL_RSVD_STAT1) may not yet contain a valid provision
> ID. This can cause subsequent firmware operations to proceed with stale
> state.
> 
> Poll VEND1_GLOBAL_RSVD_STAT1 until the provision ID field is non-zero
> before returning from aqr_wait_reset_complete(). A timeout is treated as
> a non-fatal warning since the PHY can still function without a valid
> provision ID.

If it can still work without the provisioning ID, why bother reading
it?

Maybe extend the commit message saying what features will be missing
if there is no ID.

It looks like USXGMII and 10G-QXGMII might be mixed up? Is such a mix
up not fatal?

	Andrew
