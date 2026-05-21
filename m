Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58285253B58;
	Thu, 21 May 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366503; cv=none; b=MuhyyJ7xuActsJN3zjkWjHvfiFGHZeaHTcqxArGIHdC9V2Cs7JceRxrP6cc51zZDYA3DAB/24tsGQypjM3/Mzs0UNWAeu29Tgs3pwad+fKBzh2maFPoHalYSsCwV37WGYZ34IiIu1zREYAUorsirbzLabr4QFWdbLwyfy8uo5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366503; c=relaxed/simple;
	bh=yJGmkCw3fBcFklUlcv06Ftia7PXkCASCxi01kumHb2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1weAtH7HoeJd/Q+OWigh2qFRvJAW6+uIlUe8wMK+NnhVwn+QXmNcJKmG+n9DZKmoo68vektbDTbIZgvSf8qAq/b39TNpO+gZatPTaIwjDyMRkim0/NyvFHHSE+PoPn2+BkMrREImtnk4BC2tAy8OG8ZoLTKXftMJUMZVJlah3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XMAaPR8s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XMAaPR8s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D4B364E42D0D;
	Thu, 21 May 2026 12:28:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A82E960495;
	Thu, 21 May 2026 12:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E2FF107E8B67;
	Thu, 21 May 2026 14:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779366498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ssft/NzfZRZcfj5PrYHp1lVFl4VZcEXN3GWhU7p5eT0=;
	b=XMAaPR8sLQ6fkvdLebTrLGWSJ0Nx34Ps+wEUDK4b1XlIUkwwL6VucJXFMXfRGHhv3aktkf
	BGYq5Ox4jW/JY4wwc7BTCLBOsK3n6l/6j7FEaeolQznYC/z2ujWjCtK+edYWA1pE4WDh3G
	pFepQjhbczEuZBF2kQcz+ZmoQwdW7By0MZY/xwoEVZY2M3ESYBgwzY4xS/YkRqbTinpVMM
	Ped1YehsGbA0SLIHjSGgcrGTUc8ZqOLPzvdjoldIuAQlUJ2V5/Z6natwwnYhpEZ2LGcemq
	QYB9Yoxs3lWeCIZsIFGLFssocsiNB4x6rvqfD3dQchNly7NCf+nq3/ITgCK62g==
Message-ID: <45efcb6b-a439-4b38-8214-1c2f4f6808e9@bootlin.com>
Date: Thu, 21 May 2026 14:28:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: e100: replace silent 'hope for the best'
 with debug message
To: Ashwin Gundarapu <linuxuser509@zohomail.in>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
 andrewnetdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
 pabeni <pabeni@redhat.com>
Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 5/21/26 08:10, Ashwin Gundarapu wrote:
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Sun, 10 May 2026 15:09:12 +0530
> Subject: [PATCH] net: e100: replace silent 'hope for the best' with debug
>   message
> 
> Replace a silent return with a debug message when no MII PHY is
> detected on known variants. This gives users visibility into the
> failure instead of silently hoping for the best.

It's not silent actually, e100_phy_check_without_mii() already prints a 
message when returning 1.

Not sure this patch achieves anything meaningful...

Maxime

> 
> Found by checkpatch.pl inspection.
> 
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>   drivers/net/ethernet/intel/e100.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 9074b558de35..bfacf877ca40 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -1450,7 +1450,9 @@ static int e100_phy_init(struct nic *nic)
>   		 * But do this AFTER MII checking only, since this does
>   		 * lookup of EEPROM values which may easily be unreliable. */
>   		if (e100_phy_check_without_mii(nic))
> -			return 0; /* simply return and hope for the best */
> +                        netif_dbg(nic, probe, nic->netdev,
> +                                  "No MII PHY detected, continuing anyway\n");
> +                        return 0;
>   		else {
>   			/* for unknown cases log a fatal error */
>   			netif_err(nic, hw, nic->netdev,

