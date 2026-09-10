Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976A339376
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071313; cv=none; b=s2NVaePddFREXg/9YLAsfFq+AbOPdmaWhEN2yYtwcv8ssMjvBtHKRuU1dI9pFnPJ2ppRSCnyuATld2EfscrafjPpAinMcUSyvu1bLQKCxAysY1fhHZzvqwoA0xMPdGUQgnn0lb+oTdfl5B7D6GHHHW2aUBBwMdkHzgT3pVwkgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071313; c=relaxed/simple;
	bh=lhnrct5IwDdL3oCq8UXa5PxdL6Lxk7HEL+sYVJFgPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB3t1qUhRgeSzPcVDSYXJLpxTyKp14UoMqyjHbyi/JAdj3/27F9bmCKVUm+mVv4D0K2vzj1qkviO3BhQoUUqx8jukG+GAP3VOm3jAK9UfULP3G2UTpPmfr3MCG3XAakBaIvW8Lw0T98+H3T2dk9fLf30ngm/49wc+5iFNNQJPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=btB6ClNt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="btB6ClNt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so896915ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789071310; x=1789676110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3MOfs+yLWKNPu3hgjlvLeCZjdzWzvpbMagd5VEL7u0=;
        b=btB6ClNtFYr5A2zJUu5qs+KUy4HKmlgD2G3EhGBDOhyCcV+WqSM10SpsNY8BIYG7Vs
         oHtBQ4/eKXU3FmMIsYpdEAhxyfEBuVsmBhffOOMfT8Fl1AWvNXg3v5mI+yIuJYLrx6uY
         r2IZlIUYIkOBzASF68w6a4PthMsq59076rc0FXMfp2PL10y5D3Aylhu/GP1AHUw+bcpE
         cDDYRQhTVNb9mQCMr1QIqQQNKTYIwT7T0b41YSIo8gc3I+s+SdgKO6r/2Uv99FHmdNOs
         /uv7rtFYL6hUyOWVPB6VUIvBscjagPyvu6cfncUyvJaxKVPzkUtkMzHBj6xIoswvY6Dm
         rZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071310; x=1789676110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z3MOfs+yLWKNPu3hgjlvLeCZjdzWzvpbMagd5VEL7u0=;
        b=AXlB8M2rolcCac6l8fSN3Fyt4HjQ4iHRmZv02tgmFr6LOnDluEcpE2GW5bvq1PacrW
         4YtJr4NcBlD3sxKb89BHPdTDoXVprnffPIi83pLmuwHtVZAPaeYHao3N9ASsL9ke5d6v
         vwkFgr/ejLZKuIh0vkzXyPNL0Z/FyQi0ay7PQjMquD+VWwHTQJCdyBcYc4HhQvmtV3kK
         5j9vXdIpX8XgnkV/0cr5OsBF7pmXxp8fQar+/nNH29mxoNQ89VRSndwWdg9yJV9fAfl2
         8PArOroWd1s/tFPmknIRf68dfIVJPvM4R4pI6ljunnpZBxvnW8ik7EhbeNEFgQFRlKm7
         5FRw==
X-Gm-Message-State: AFuF++nh+qBIfoMUwgU0C68sj5LSmwfq81HFaxQhtdbKqFRsx/O2vI9v
	PYOjgsq8P0lj/lGxSBP8n4eL/fBGOR37nv/G7LSx0YdtIEDC74aVAnW4JMIt1FhFWWs=
X-Gm-Gg: AYBFou3WToTTEEKCS4BppPU9ztzhsf6KHO9YoFB+73aQr/Fq/eyI0MwyHnBKl8wYoxe
	jMqOXq0fcCL8cpq4zpk+9DQGQvQ3Wv7vfge6ZT3HoIKslPk/Q3CiFQSRjY5N8qR+Mt43wgZesqO
	NlIzvHXewVX2wP006+v9dwheQeyMxZjDRya0moOhHKCzAIkUy2GF1RJnFZ+qGuS7dQvokwe9eIP
	UqITB55YUyufB+hgPAHZRoWzlPjKrAoRAQk06pjZJbtMX/gLxdUyznp3dA8sIhyohK0o2PJJe1y
	uTY9s3qxXBTcBhKfNy0A2Dd2aG5NpZOOkyqI/x5AB11bzgMJZQ+wlJiH/Pi2vnfy/rrqQ1WrwVa
	w4MASr4cMILq/Brb8fjEdH66tDGmzryHAlAJLdMZEVcIUuwaQANGwQlErePLF472IwkLZRAIQ2q
	/gVhmirdXc28djphHLUWc0aTAZohe+mVk/2Rrf9tBvwmcvS+SSyZnm
X-Received: by 2002:a17:903:174e:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2dd2a1e1a0dmr16924975ad.7.1789071310032;
        Thu, 10 Sep 2026 13:15:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce9c8besm1325375ad.18.2026.09.10.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:15:09 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:15:08 -0700
From: Joe Damato <joe@dama.to>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] drivers: net: smsc: Remove unused smc9194.h header
Message-ID: <aqMPzDuk1wI0dCkQ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260910143516.87304-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910143516.87304-1-enelsonmoore@gmail.com>

On Thu, Sep 10, 2026 at 07:35:05AM -0700, Ethan Nelson-Moore wrote:
> The smc9194 driver was removed in commit 9fdf9f61fa6d ("drivers: net:
> smsc: smc9194: Remove this driver"), but smc9194.h was left behind.
> Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/smsc/smc9194.h | 241 ----------------------------
>  1 file changed, 241 deletions(-)
>  delete mode 100644 drivers/net/ethernet/smsc/smc9194.h

Reviewed-by: Joe Damato <joe@dama.to>
