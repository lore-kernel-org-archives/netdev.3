Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804200;
	b=UU/mv7N+XLlWqVrKEy242e6+ZmXIu5sDQ4yEbHy2EJ77NHBhojdlIfEI5rcmLDeDwRT2
	 cA4HGfvBvV+44JqTdHjawy6GN5ptliZssLctciib+vOZtqHclu6JgNbX4SLF98JPTCqoN
	 X1bduTvGmvlFyVfmTyuIuzWEFx+8KnFEio9l3AgZA55erZfRrwJ4lfHuGmw4vhRvirm5H
	 PjKws9WBSuw2PjC0xQSg0Avo/eSGr+XiskQrSAb92htHLSJZwiadkqT2Q+JhtzAQd7NdJ
	 PKXx8TxCA+C8R/AXsxegZlGvqtRBqonAbQ2MvOMtJOYxv1CVdBFDPhn7gzvPTnalqQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804200;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=59zhTayxczl43EeYDiMSSxpzLdPh5wVDsn3GkH9nffc=;
	b=hLo6+D8RoFbRCRdd0vYh6bx0jgcHZS5LyCHwy+a0zTjuZtNMyQm0tK8aisbTJALKoIPy
	 bvVXmVyCq4/r7rGfqVtRAQXka1qS67fRRwEcFc4jkPJwMdkKReQD/+aFcOPYH2mgUbG8t
	 ayHUJrrbWWAoCbqJJ8MpJ2t4VowHqoOPWNHmDktbLOKfQxEPz+fqVrLsGp5iCh0x5RC3d
	 U40gOKeIOX5Z0FU0rdSy8j6PG1ERJjpyuand32jveeNd9Pc4eGppahjHVDQ8xYC8s0iTT
	 meW77hB9NCi9WmWReQXCwfV6x/kzGQCPqjF0q0Z+SK+9oAvObM89gvRAJoU+1pQL/yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksej+oID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC3606A328;
	Wed,  4 Nov 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksej+oID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A771F000C1;
	Wed,  4 Nov 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804199;
	bh=59zhTayxczl43EeYDiMSSxpzLdPh5wVDsn3GkH9nffc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ksej+oIDIBq0Lssyj4jKKmoO9D0FheijDjcLkWtrCBSdXuCdPdlONB/yW3l8R5B1B
	 WXzWWTQGWBnf8wiRAal8qMOBvD6dNjR45XhyXSDhm76MfJxdI5vHbS8VJ2i/FsOWau
	 xVucDZMJNOMchEo8l0gYt7SLipQvxzAgpESk7tSyz48gqr4qJiqKg+pvy7L5twQCLn
	 9oVbgvH3TyqprheKDjubv5Vn3YR/y94UzxZFdIaOSUWbcKqfz3PA+mLfEZMQkCUWkf
	 FgXg7066/vRmIPMLBOuRaLCLOLbBTgTKn5LWastAkEBGsuGSznoMtuuH/VFnWOA82K
	 jjub1Ky2gy2pw==
Date: Wed, 4 Nov 2026 15:56:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: hisilicon: Remove orphan femac driver
Message-ID: <20261104-realistic-elite-kagu-7beabd@quoll>
References: <20261104145038.946918-1-robh@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104145038.946918-1-robh@kernel.org>

On Wed, Nov 04, 2026 at 08:50:34AM -0600, Rob Herring (Arm) wrote:
> Remove the HiSilicon femac driver as it is not used on any upstream SoC.
> The hi3516cv300 only has clock, pwm, and this driver.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/hisilicon-femac-mdio.txt     |  22 -
>  .../bindings/net/hisilicon-femac.txt          |  41 -
>  drivers/net/ethernet/hisilicon/Kconfig        |  12 -
>  drivers/net/ethernet/hisilicon/Makefile       |   1 -
>  drivers/net/ethernet/hisilicon/hisi_femac.c   | 976 ------------------
>  drivers/net/mdio/Kconfig                      |   7 -
>  drivers/net/mdio/Makefile                     |   1 -
>  drivers/net/mdio/mdio-hisi-femac.c            | 150 ---
>  8 files changed, 1210 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
>  delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac.txt
>  delete mode 100644 drivers/net/ethernet/hisilicon/hisi_femac.c
>  delete mode 100644 drivers/net/mdio/mdio-hisi-femac.c

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

