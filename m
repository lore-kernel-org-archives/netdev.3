Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC930D3F7
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798426; cv=none; b=Pscp4G1fMYYA3ZlLxUeIxCK/+UekogstJP+JuX+uqSGB0vLOeNFTaEBYiPFjqcRMGHauAMyX1cCmZfmpdpCAC2dBps+Kowm/PcbHtMG+iTsMmeBQ4KrKCAfv2ZH40cIhBu1cWy/zdZFVQ5EpwzgSDcbB4//vKoRI65Dn0Nc8nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798426; c=relaxed/simple;
	bh=O5WkeiR/zs1RpUms8+jAU2ZtuF80HK8dFcrVDrHcDa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od/FZHE3hKnggN4NgkyKIB6rHEPO6Pj1DnLeaOL9ajNZiCrYQtZ1l17aL1q0Efrlr2BVdbzucdnXaoc2+bb+Tb/7g4jse+Ianuc0kQZvWWpNmR8fz+XiBOEw028yNtwQGtUO0+u/JRdaj7P0FFRrV6Lg8kaDAV4jPqtno1pDe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSe5W3QJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oSe5W3QJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9D104E41214;
	Sat, 11 Jul 2026 19:33:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC37A6034B;
	Sat, 11 Jul 2026 19:33:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5B1111BD3396;
	Sat, 11 Jul 2026 21:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783798414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Mhr3znqPdzk4zl43zlZdcWAMeZe4rPLdwME/lipWPio=;
	b=oSe5W3QJo41GVdLzKzA54gNzzv/rtfCFyPIHqjMtFO0Rf/c/SaYqw0BmghYV6qR5Nm8/tl
	4UbJZMrM5hv2dJVJM6h3hM1vkpzAoI+WqTQv2mQMDavLA+/jBfI7C1xX9LnyC03U/SDhPS
	S186BaQXir5st5OPap+gze65dxaqRZLAtVF5J8FBrrMdp89kO1ZRnWgKpgBMNPSwjXYPq2
	cIfHH6zQeor03eb4suEobf9ssexsM0CoAMsGy3uH//WDwUYCUCOa0nXBdZkM+2a7W1g8+S
	ZnXUd6HBeEvyR4w4z8qJFUQjY8jIMGLt2f6f2i6VFafdEAh56WVi+gQrgXA/aA==
Message-ID: <0dc5b763-1e05-4ded-bc4d-f89867f24500@bootlin.com>
Date: Sat, 11 Jul 2026 21:33:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
To: Andrew Lunn <andrew@lunn.ch>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 linux@armlinux.org.uk, enelsonmoore@gmail.com, daniel@thingy.jp
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <18a5cd81-49ab-4b97-ba68-121e22cba874@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <18a5cd81-49ab-4b97-ba68-121e22cba874@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 7/10/26 19:02, Andrew Lunn wrote:
 
> Once you start reusing existing code, i then wounder if it is just as
> simple to allow any of the mac_capabilities to be changed, not just
> pause?

Yes indeed, but should we ? There's a valid case here for dynamically
changing a MAC's pause support based on other factors like MTU, but
is there a point in letting the supported speeds / dpx be changed
dynamically ?

Maxime
