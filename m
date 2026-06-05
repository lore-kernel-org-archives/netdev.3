Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCB4A33EB;
	Fri,  5 Jun 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649990; cv=none; b=ZB/97tm4SLd+kMNEVs5VJ3Kogua6HZSOqKjFIMMuYcxnO5kLDuAnrx0zI8SnWdE7eQVXhThx1PvtMidL4/fYalh5IBr1ccXnWXhvtYbwEMezjJsT/l/HXL02YdU43O4vv5V9kaYpXYq8ZAzGZ/a3N2Td5uZwuydllJgSrqvDqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649990; c=relaxed/simple;
	bh=wkdL7mGaQ0V/PX34/0LTG76rf0QF8N/ImOtM9I8X7i8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AR8hoXt3eaRP62UdMkr58HdDR4vwm5J79ZYp7MmQb1C7ju3ajNu0yjLxZH4Il5JH4AwTAa6cYq+TFZ8c3xVaqErXF6YDeLQIPFaxqmtPjETeqq3Fzx4i8ggCmEz0z7FgjRUfOLDmFy5u33EFLkdFNt86+LPfbLrWA9V19XgcS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=WdT8UylD; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="WdT8UylD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F112A4C0D;
	Fri,  5 Jun 2026 10:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780649978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=89zGC+YeEfoyBY+MHqfcZod6/UjbGW0pbmlP5MMJv1Q=;
	b=WdT8UylDqNTsSQ7y9B/fZwdfuKfMjbdVSjr0FZiJ2a1YU+lp8UquwphnUeBOVI7fjHhqWo
	vSgk+oxeKUBYoE+eF8P11l3SThSSeggGeUsyHz7bAftxVr3WnI1WHK1uBMsa2EMwXYn6Hp
	Dntrw/LFE8d5IekWCeOAIJ+Z7b2XXUnOSuZosNAwYbyfV/Z62cH9Zy1CBhHQtTKO22ccWM
	E7WdnHk3oH/+13cl9TRzhtNAP82Z/3UiMP8j//g/jYLv5XCVjlgCr3h4SpYrC5wtprbUMF
	A/zcZSpLlpXlfSjpca5mHDtPGNvThfqe5BrJ842kXqxH4Zx3axma2Ky32rzAew==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 10:59:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
In-Reply-To: <20260605074328.1800-2-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-2-javen_xu@realsil.com.cn>
Message-ID: <4201d4c6df0db7d6cef9ac497448d150@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the 
> reset
> bit in the PMA/PMD control register and waits until the bit is cleared 
> by
> hardware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes, new file
> 
> Changes in v3:
>  - re-order function according to the order in phy-c45.c
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
