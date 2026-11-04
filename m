Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825852;
	b=UIp2zsxKzgPOqRilESpyU/HYR4qF3fuxl5w8W8jPpaEx+jeTSIOOpcv9r4WqDD2UY6yp
	 F8Fv0QSPJa4mJlsaFkMPEPhk1xE7n53jHUP9yis/Qq+ZzTSq6EkfxKD689bMfRb7oDbKA
	 Dqb9f86CdsGOrqeT+loOtzSR3r0xWXSUFC19FfxOQmrGcy9VMD8aJ6GitFXjCN42Llrfj
	 Q5q9Rps16ZCxCl2U80wNGvx6ra70GOAgYQgXYdBMrsxjxbOrEJfBcojqi5HgAViI42iuF
	 iwbKPotBU9usdRsEocbN5Tn+ayR5dAfrB6kI3Fl8iXgRSrGLcNDxiyWIInFIdX2kvtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825852;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QroCc3soYzLpiwN5IIzNHAwlSssIOI5rcaIIFmq/08o=;
	b=hsDmGdTqL0hkX7i6gxTgK0P7qqyRaVOC/bShQNyfbaVmHKJT6pEo8rgBPnKdodyUX52D
	 ADBYRMsysKB/3s7XNTrC+m/pipik/LUaaoqok2dp0/z6etAPCUA+XGvVWmxpPIV/qdwqy
	 DFWeUiUmnNHh7JN7Rz9Y9eY0cwnlsXyHl1tjsx15UwsgkhGP6N2/sacKUJu4FrC8D8LWT
	 uuiXQSxYq4nC3VIYV6r0itZsIBG1ZF+KJ5gO+ZVa1C0wEs3XtuNQPkvkqDoL19yUL1c97
	 bIU5TCN3IG8MBCZbWxQNxHaB3mgiGU6KOIDVIhstsMxnrJZyrg9A9qraLCGE1OT+9Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kE9k6dxr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F4606C908;
	Wed,  4 Nov 2026 20:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 924F4606C908
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kE9k6dxr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QroCc3soYzLpiwN5IIzNHAwlSssIOI5rcaIIFmq/08o=; b=kE9k6dxrQm77Q3TaQLznHk0QR+
	L8qHNcR1weDMsAwMdROd/dcOjy09t8m6A0GoyVGy5yzyyzFcG2phut/ghVJUkUtsiew0sNzvJo9hb
	zv2ZsyQpG50qBLR2lEzdF4AhXPqJukRFYVqnDZ9QM19zk/SjgkGwwl6bTTfgyCmil8Jk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOi2t-00EO0v-AH; Wed, 04 Nov 2026 21:57:23 +0100
Date: Wed, 4 Nov 2026 21:57:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: phy: aquantia: add get_features() for
 AQR113C
Message-ID: <a3bb991a-6935-4ce9-a754-0c4ba9e72662@lunn.ch>
References: <20261104-net-phy-aqr113c-fix-pma-capability-v6-1-d6d4718e45e3@oss.qualcomm.com>
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
In-Reply-To: <20261104-net-phy-aqr113c-fix-pma-capability-v6-1-d6d4718e45e3@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 05:59:13PM +0800, Hongmei Xu wrote:
> AQR113C does not correctly report its supported speeds in the PMA
> extended abilities registers. Without a get_features callback,
> phy_probe() uses genphy_c45_pma_read_abilities() directly, which
> produces an incorrect supported mask.
> 
> Add aqr113c_get_features() that calls aqr111_get_features() as a base
> (which uses phy_gbit_features as base and forces 2.5G/5G that the PHY
> misreports) and sets 10000baseT_Full explicitly since the PHY also
> misreports 10G.
> 
> The AQR113 likely has the same issue since it is a closely related
> variant, but this fix is limited to AQR113C as that is the only
> hardware available for testing.
> 
> Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")
> 
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
