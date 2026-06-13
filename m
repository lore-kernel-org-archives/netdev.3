Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BE2C3768;
	Sat, 13 Jun 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375383; cv=none; b=WrzhEI2AUabgJkFA2lSL9QCcMQs5RXodMIAzJbjAgYVxB0VvG62d2vdgrF0iQMGRYR1/QF5jHaxIUvbek9wdTDVanKC/xLfpwVWs3AlC8/Sf+3CosZ6vW6kPrRGAc+S5znUtQLp8ntp+2AWbj5Xg+L8BCaWoo8rv8nwhDZFY38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375383; c=relaxed/simple;
	bh=odhDIPcmbzSFuqoxnLoIctZ7h3NQAX+GnBVpYDbr8i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEwp0hf5ga+7wz3Gk4UGnGCO8DwaqzY8b2M35qoMZIhKKf+Brze0QsGEKTM118dSQNAUGkAtvZRKykAlO3RCJ7Hdloe/k4IZdke3i3SRUKfNdOBmqwskjNizjXzZ8BCxuqiCKHdNugaxZhnw886PUb9sL3X39T5iOKbm3Fi9AtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu862N2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu862N2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13E01F000E9;
	Sat, 13 Jun 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781375382;
	bh=gF727nZWftSXwKewt3391E5lZl87wD+IcPkpef8dLKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tu862N2vey18lzZiVIY/QTNjsaZBal0RR7RihTnqySWxoBrIMd1TjUVkkUDUZwDat
	 ZU3fZZExDDkv/AbRRxlGUrkbjZgbF4sNfOnc/SjM+/kXM4S3rN7Jl2mzclMSQCW3fy
	 RrnvTs+gPHbXqlznjLp4srmnWmrdphsSg5TjCXU6PL/FWYO7BN6tnt7HfQeHv9nhjg
	 Jt8S+ivOUZiLUTzamQocQ1dyemo2dpLKW92K7OUkallGqUg5M2yVWnlUFfIcIOdJGb
	 TFsGoGjNknkpFTeK7DEwKrNGuU4YVylQQWrc1iiRSG8SqOFD3GAENhN7arY4WwRljl
	 0c+O1/WJJ3+gA==
Date: Sat, 13 Jun 2026 11:29:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 sdf.kernel@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: sparx5: change ndo_set_rx_mode_async
 return type to int
Message-ID: <20260613112940.05bba5ff@kernel.org>
In-Reply-To: <20260611101151.426050-1-robert.marko@sartura.hr>
References: <20260611101151.426050-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 12:11:13 +0200 Robert Marko wrote:
> Commit ("net: add retry mechanism to ndo_set_rx_mode_async") changed the
> ndo_set_rx_mode_async return type to int, however it did not update the
> SparX-5 driver.
> 
> So, simply update the sparx5_set_rx_mode return type to int, propagate
> return from __hw_addr_sync_dev or simply return 0.
> 
> Fixes: d90b85c23b3d ("net: add retry mechanism to ndo_set_rx_mode_async")

This commit does not exist, as I said in:
https://lore.kernel.org/all/20260507091012.7eeb17f5@kernel.org/
the first two patches of that series were _not_ applied.
-- 
pw-bot: reject
