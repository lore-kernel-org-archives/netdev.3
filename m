Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D311372B3C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149397; cv=none; b=ED/HMbazor2jxLKFqbpuj+wg3UDaKbQJbXRKcvzszP3At1CnL8W+R3okGxDZrBPrNeQVwIkHRhtpf4ZFd+2FmGSVrqU99VoeBq6d+ILL/SZmC7USzQ6xhPBAFBjs71FuTTlObRp1NgiihyCS6AgtJQMsS52838j4f2xj3qraLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149397; c=relaxed/simple;
	bh=ZAYhk6PMtKBOMMp3ORqbpccItA1ZSa7BhG7T6KgZAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H565hOdd4i25bWOIJrlneWl+8I/jbfXH5cH0KGR8T7AKJ2APkc9//WxbfvXGhFsqtADTZGoJ8V3CpVAgH95N+5AGlFDHSBZ8JrKi1PaTv6O40D2nDUG9383KbZm8u66damttjgGPZlg3aUf8fU03T2fC1QfEeDU7WUHsYlXoXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa6E7wxp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa6E7wxp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so54413645e9.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792149394; x=1792754194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q91Kq2uD425J9aokyBJE7F3MzPbeOxtiMjGUu3KOuYA=;
        b=Aa6E7wxp2zDK7iTgQTMJ0v3ZOO/OOOZ0CXsHgDEkQdYScSHsk6FaePjng4izs5jyWO
         Y5fFtGoVvlNLy91sa5Pb8f+gLiIQpzmoEe580778ehRsNTFxjBftCjMTanTalH3glmUn
         GEdx9LZQEUcAUgLKkP3kMceiYPyauTtXerx836oBxrouM1lTiykY2G5FOqu5s9N20GC4
         qDA5+J/yznOe0j1RDjWQlkPHOQe0BEQLDqdw6833SUIwrEZ6FXfgGylmqaiAIKz7m5IA
         +4og/hDJDZhrHspq8rCZVEWoNSSjcwPSb5wZPodv+PWAxOYJCXxAfpfIDNsZJvBlpX1s
         Vn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149394; x=1792754194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q91Kq2uD425J9aokyBJE7F3MzPbeOxtiMjGUu3KOuYA=;
        b=GGQv4L0xS/k2nFerWyDnfO0Va2Iiu8ZHRI8r+OQyk4J5HZ6Gf95E7IgacVgDJkW1vJ
         1ORi9W3GKZ0dmwSWGADotCgpF3JlnHmfKau9fEXUIbZs0emFflED1NQNq7+oAgzYlUzt
         otlqlQCMl2NC9BgGybwV36kl1oWGpumnHoX1fyhPr1nEPUxpE/uKY6XHALFeu5Vepj5e
         jFgB7mHgDpMdQdaxXDrOIlYFTb9B9LTgRxw3eXR+DeiQBakPQ3ZYj89xGy0Xl9T6ol+z
         O+VHvXAwLPXaHvbJPEhc6xNmPXIAitsTiEVUHQ1ELFeP+0gfiUWcTkki+iqPgux5BCe1
         qC8g==
X-Forwarded-Encrypted: i=1; AKwUvBwwRtCXuzeQZvr4rd0i7eICm0mVk4mDE4c2hcxX5ylCK4gRaw7fkvMQjZlSBVTu2OxFpXPLdB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBXRStk1eUeZq20oOyJzdi+Ax/HMiknjas8sojZuSrSPHJbJ+H
	EyjwHtBxCODZ/Pwe2dE9MkaMFQHx/+qhJXjo+dHTcU+W4yegBqfUJ8vL
X-Gm-Gg: AYBFou0/iyz/P2zXJcr0y30hrjENxJ8M0f1ocRa0iGWO9ABqoetjrJSya27aLniXGsf
	zejxPoGGQBVZ8NpUMe3rd0M09VJocT8XCqS7Ha1n9dOYUndx2pifAsVQixx6E4IkoHNxKnctQii
	yod4sdGqwxISKX1WMw0rS9xNVCPdKjTl5K0nue0XrltQ2bRN+AF51tdpO/81W8tF+3BIcedWgQ1
	PnfBlSqKz/vqJrWEwJwfx+6kgXknSiJl5YXB9HSKb9Ex3hQLAwvo8VK3k0U/WNJKqmnL+JtURuw
	5BWgs6owfSr2Fiq6o7MOCkFq1iiP1K3azrJND//ukAPoCtPCklqfUVYzJGBqnmBJ8U3C4Nj+V4w
	0eME7wCIKhRSBX9K+jLF2IXFO2Mu2y6OU3tVOlrah/PNM0QOu2RI2Pi4DtOG4RDe7bkkGWo3OxW
	yvT9fgYXz0YcNfs3RZqEpSv22So+q4WXe+nYl8/Skxm+3WogDV3BNHmTS9CEqdeFVhuM1G1Az6F
	MlJhsxY9aDSmykHNAIjBRKwv3NA1jJm1hJnAUAsSdjHwya1/WKczlwU52P+lbHDLTfJ73uOEhCs
	uyy4+GexfPbi/p8GOQaeMBrhSKrqHgM68JeIFp90OHg0LdeKTQWmar9rGzpullbU3AVP5kXGqok
	=
X-Received: by 2002:a05:600c:4e4f:b0:4a1:ad27:e797 with SMTP id 5b1f17b1804b1-4a1ad27e79cmr243682495e9.6.1792149394233;
        Fri, 16 Oct 2026 04:16:34 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de. [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm34075975e9.10.2026.10.16.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:16:33 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:16:32 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: realtek: restore RTL8211F RGMII delays
 on resume
Message-ID: <atIHEinHKXsD-0z8@gmail.com>
References: <20261015045001.83986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015045001.83986-1-kmehltretter@gmail.com>

On Thu, Oct 15, 2026 at 06:50:01AM +0100, Karl Mehltretter wrote:
> Reapply the RGMII delay configuration after the existing resume delay.
> 
> Tested on a BeagleV Ahead with an RTL8211F-VD at 100 and 1000 Mbit/s,
> including close/open without a link partner.
> 
> Fixes: bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2:
> - Move the shared RTL8211F/RTL8211F-VD resume-path explanation earlier.
> - Add Andrew's Reviewed-by.
> 
> v1: https://lore.kernel.org/netdev/20261014033659.95196-1-kmehltretter@gmail.com/
> 

Now Sashiko found a possible clock reference leak in the resume error
path:

https://sashiko.dev/#/patchset/20261015045001.83986-1-kmehltretter@gmail.com

I'll take a look.

Karl
