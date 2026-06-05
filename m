Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE794ADDBB;
	Fri,  5 Jun 2026 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650008; cv=none; b=UXpnUEDrPoV/zVWvxR6IxFh7aLPI67xIg12ZNFVACIQ5fUN9waUy8rNYLCT5sAVSd9YYzs82jvCQ2jFswmRRZQM05caXQ7hkZjsMH2ijrYhX76BGmpxaRsv0ETpKgNmUBckCtzk42IhK75qU2o3YVsLdIPuEZFPCF/P8U9bD500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650008; c=relaxed/simple;
	bh=Ds1PAnRsEm3ccvRy1HFgEUGyEQPJR9Mx1ng/I3h/cog=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LTl1Y+2U3Nk7c4SXKX93ySL4r/3byCF1N7KKnF4ZFGFH5G+xqJE4kQHI910jE8zkoYuK1SGO3VxsXMnCT6lWyKvSFubVhOmUPQfyZ7H6J5SWT1jV5FVI2BBXGfamoFpQzaN9DSZ138Ff2MyEcX4Q2rQJ40I+eLrt84IWhXOLlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=r8tz4hux; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="r8tz4hux"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77544A4C41;
	Fri,  5 Jun 2026 11:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780650004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RccDxgGvZ5+/QF+jvmtjhqDNtfqK/hlFJZrrDuPIo/k=;
	b=r8tz4hux9RMrLyuflZK7aivZEQEeNvuKAbFI7fRsSU6cjBc3QyVJNDyVJL8p0rRyFGTKMf
	MZzwQWQBUUzLIOpw4MUQQNdygKzSRSujwU9eupQ5WAG+MfMDcUmSgZEsp6ioi/CmbMirb0
	nMcvKW/gRouK0H/Pn7TpTDu0OFclPUU7ep+8ddoOYre1SFcDHcompXIug4uH2CqaO1GSqt
	O0k/0zzaepzECzDtEzIAlBLOoRrgFOsLPIxxfTG2QnjMEcSwgkk5ptKgY8IfLpkQ+X59aC
	h1VCDFh1r3rIS9QmcvVTt2uIwuwB7Yc3VBtAvScMWlkISvMTZ5APaZhK6x3HJQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 11:00:04 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 2/4] net: phy: c45: add
 genphy_c45_an_setup_master_slave()
In-Reply-To: <20260605074328.1800-3-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-3-javen_xu@realsil.com.cn>
Message-ID: <f3df03371596e5ff3465c0010a9f07fc@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic helper to configure forced master/slave mode for Clause 
> 45
> PHYs using the 10GBASE-T AN control register.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes, new file
> 
> Changes in v3:
>  - re-order function according to the order in phy-c45.c
>  - add kernel-doc about return value
>  - add MASTER_SLAVE_CFG_MASTER_PREFERRED,
>    MASTER_SLAVE_CFG_SLAVE_PREFERRED, MASTER_SLAVE_CFG_UNKNOWN,
>    MASTER_SLAVE_CFG_UNSUPPORTED, MASTER_SLAVE_CFG_SLAVE_PREFERRED cfg

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
