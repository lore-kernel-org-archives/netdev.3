Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73672378D9C;
	Fri,  5 Jun 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654122; cv=none; b=N6tt1YCEiGG6FAnY5KKi99sfBDH2bXVOgqosz7ohkhINseJK3pekbEsMwYjRqVKkkdiXz/uczICyK4M9EJH7xx2UIK4BMZqktJsZPq8HEolmnVsQ1ZIEvCRVf4iKsasm91oo+8IZvFeU5/CTH2Ua3ghHusTGYUGHJeUlVYKg+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654122; c=relaxed/simple;
	bh=lkXo0ekrqfpmrZot/3+CAawtKmUr4MDr2Sq/OMy2bVs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Zt6ys/1Y3+hPXmbsdNeVr+ZStpvxuxAExm9C6CfCRAPwoWwv8Y/JFOc38oMKgt5ehT/nXWkvwnfpvBF5Pf06nhmGHLh01Wny3073L2x8ZicRjUZKL0kJPGqWkUNC3gJstD/nz8TrnhLiLt/zwWkMMvH7uJn0uvOeGwmEIfLBn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=aa108F2B; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="aa108F2B"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0FEDA002F;
	Fri,  5 Jun 2026 12:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780654115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cPJxATtzRqN1mbowQ/WBc4NP6HJk5fkBbkprFlvxGBc=;
	b=aa108F2BcRZiug4lbaTuoT7Njs4MJgfjjOpUhTNTGzeRZ243sLgbCKY5F3eG2wLjJYKYtr
	r3miKdDBfslu0/ueuVI2MBvLr8Exo70UrHdreQhNmYdT73q4efbVl/2Lb7lM1uj4sNp94J
	cAh/msO+1DC5ADtDw+fmQWcB3VlEdg2Jm0HaLjntnX7jrc2OcJZFIXrTtKm3EKdDs96QAS
	lZYj8Qfp1rGApbeiPpMkauvIzSahStqy09zxbH4m8ENgAwYJVEh+UKmiSIGdkM4bH3Y1Y0
	1p4H+arT+G5oPkS4p0EmgJnk0sCrTlUBTJA1Jhxq3+w68lvjkIgXE7gm89NrEg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 12:08:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, =?UTF-8?Q?=E9=A1=BE=E6=99=93=E5=86=9B?=
 <freddy_gu@realsil.com.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
In-Reply-To: <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
 <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
 <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
Message-ID: <d40ed770fc9067ea6a51e2cc5d80f551@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 5.6.2026 11:58, Javen wrote:

> [...]

> For RTL8261C_CG, the patches will not be lost after resume or 
> soft_reset. They only need to be downloaded again after a power cycle 
> or a hardware reset.
> So the fw_loaded flag is intended to avoid reloading the same 
> parameters multiple times during the PHY device lifetime.

Thanks for the clarification, makes sense.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

> [...]

Regards,
Nicolai
