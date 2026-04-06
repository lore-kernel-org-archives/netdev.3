Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5383246EF
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467633; cv=none; b=DZ0QHS4kLGAjJFVMgIaRNsyR+6vtzfPxqLJrnvJZCEVEkJ3NzNLsJnhDHiyvSFFTd3A1yrz2LVIYibEmAPkvKP4izn7HL8ox9YNDYwcm+Ab3bD0dbXnOeZxTv7rDZDkvgyNU9MmxG1iNnbx4vH2en7mDO9oTRFVYhktBhkSqazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467633; c=relaxed/simple;
	bh=lEvuDfMbAo9PRGVT3OUpXJy6KBnBXNk7eE9OcVQDjJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZ7vdNTpZ2LbLX5gp2baO2P/PdKCY+1AMvjYb0cnPJaP5vucsu90aHKJpw/eN3VAWQL6az+qkAyrmIVelWlSHIeScij12w13QveBmum540To7OwpLmNaEpypc0p1Uyv2oSlpuL7OnJgdkezXcWYQjhtQzOyXNinCdbe3jqWAB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnD2X0MH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnD2X0MH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d43e09de5so150636f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775467630; x=1776072430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lEvuDfMbAo9PRGVT3OUpXJy6KBnBXNk7eE9OcVQDjJU=;
        b=DnD2X0MHUkX/y3Ao3pi31NQpVTS6Dx8LpCe7Gv8mY55udgCExjtvLpfe36gPDX4iWL
         XTHMksXC3B4JP4WrG4mhH3J/C4ge+uWkdMiKKs41N+CRo51yQ8A8f0ZR86kdDVrv1nd7
         8+EOQDul7orkO5ip3uowt1pKFkcoYYMmN91LucoPrQZe9UIGwzoz//LpXloI02vzWsA/
         Y3dccs/1BmymrRQHWkTkavtmDIu/EZOCiVHJnSesZ97EYQK76ZAqpOW+t8K0mlTt0JhJ
         JERniFs4N2AGf/c5juVyA8DuJ+dTJFLpFKwQslfwnv7mz+LgfHQ0HcSlXti93w4kVWFM
         GnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467630; x=1776072430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEvuDfMbAo9PRGVT3OUpXJy6KBnBXNk7eE9OcVQDjJU=;
        b=Rx/0E1xEwgCodP6Nh7PT6YL9v3+/ZeJOTxH+nOrS8F2QXPVxr9LCtbcq+s5F5ZXVfi
         cBMzoWUwg88xghknv37+B7wBuNgGBRmzeGOqHKciUecBYxpbZ4PTS+VTAzyyikcTkT9y
         pBq9RpMN6g459FL11iQXPTZWH1QOK2vBCxDSq3DgR0qLmwlBWVsWzW35ykPhBxrveDfA
         eMY6jusz5ZIPbsxysGlQajhKm1eIPc7IJ46k0T2hFNCWCziUSOrxgP/Zr24sTSyRG3/R
         00+OUlGujgvSXv4j732qoTk6X2RdWnygd36HzKPh3yxmw+/gbZfz5uw8mqevqbIwQVLU
         aB6A==
X-Forwarded-Encrypted: i=1; AJvYcCUD0FGlgYS6pvk1MQPhJOn1SASBXkUsTaE9wCMIRkZ8Mi6GEsjOwrOI8QOMzehcQp71SYD8OHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NrbrYZXDJqMKUQP3dY3X9HXxRhhkquWgV7OvxAevqdwdv+Pd
	wDJFFBU6RwIWHzgQoAGx3bOZJSPX2e3mAzXrl1sLh4hrZm2TYXCBGEMf
X-Gm-Gg: AeBDies0ylsbQ6F3E5eJLHQ+u2rniNoOGRRiQBFUW0hnX9MgtD2rvBbwIoG2NmfYtOx
	auHGIFCSQoWZt0R3FTzxGgxT/HexYapQ795JyEyql+wAUcjuwtur329j1G1Sr0Md2XsO53pfoG4
	9vcKM5UBHyniNRPdar1foZIUYXskx2RDNKatpGO4dpfOvyB+CZv1OOi//AXEoNW60bIfa76eUjF
	5ys2qguGGt26KUKvlrL01GTsRSEp6SquFcSwVRSN6FmjNxYjvLtDWFoyeGrlrORSUJGSn/VyF87
	4VaX4gRneVc4evqV5a+SZxEDiakSCqLwqBpiwuVuJRaWZHbmOq00KSpZQXJzNjTXk+009HzjXK2
	4Vtfn5ibEDk+rM+4R3TzPuZ9fTIAJYYRca3YjwkuKv0QeHjLUWKeFwrn3o5qsp6vWIWi5SE+qLB
	HvixwdRajUVOQD+vJA6Huw/KlgI3uWfLI98Kzsftngh9J2lqMgYYRVlxZpBr5UyF1XnZ/3JQ19p
	Q==
X-Received: by 2002:a05:6000:310a:b0:43b:4212:2ee8 with SMTP id ffacd0b85a97d-43d292cbcd8mr17078806f8f.24.1775467629447;
        Mon, 06 Apr 2026 02:27:09 -0700 (PDT)
Received: from ?IPV6:2001:8a0:e95c:5e00:7c8d:20ac:6645:7b95? ([2001:8a0:e95c:5e00:7c8d:20ac:6645:7b95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm37655217f8f.37.2026.04.06.02.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 02:27:09 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <f914fb50-ffca-49dd-901d-0b0176e5ee93@gmail.com>
Date: Mon, 6 Apr 2026 10:27:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davem@davemloft.net, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <20260402145858.240231-1-julianbraha@gmail.com>
 <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

With the patch applied, I've attempted to configure the kernel
with STMMAC_PLATFORM=y while STMMAC_ETH=m but menuconfig gives this
error message:
"This feature depends on another which has been configured as a module.
As a result, this feature will be built as a module."

So it looks to me like this patch hasn't actually changed any kconfig
behavior, but let me know if I'm missing something.

Best regards,
Julian Braha
