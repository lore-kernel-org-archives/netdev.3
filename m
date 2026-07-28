Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484943A7F5;
	Tue, 28 Jul 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245862; cv=none; b=EJEzCK5xMqq6dEpxnEqoTL6j68UxTUMUFCKOwxRi41lxxsIbNApBf21Q5f9nG7+XT5JQXgtzBuwy5yPGN7oCdyAbLH0X41QkO0N77JMZv5naTTQVl6BWeed5VMxG1mTeJxynKJAjN1YYDdVtWRlITNMUli5L0f3T6ZcsYCJA62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245862; c=relaxed/simple;
	bh=sgTsdDlDtly0xWZbITV5hfRbMCJc89OxwyuGM3l6jKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxgST2iS9XdigFvqjnNZmsda572JdczmYhI4n4/g0R0JBRULMv5mcFFADLik0Og2IMiNNrjq6G62KaKiBLAqXilgQAFuWVg+bNispNxMDPBJIZ/wnkQ7UIsroBpOUch3Z7BFlWDpAScv0lq1FGnxvMbERg1Zs4Uf3p+LEx8z++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Ose2vTHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UF3GcCme; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Ose2vTHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UF3GcCme"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7F2C1400120;
	Tue, 28 Jul 2026 09:37:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jul 2026 09:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785245855;
	 x=1785332255; bh=z3f2OgbFkTa0yiSQNdRvT4FZULvSq630d80q9uArK0M=; b=
	Ose2vTHbM8TLg/Gj1loNczvnocumSA1kx1n247d4DElL/fuHf8Yd5e3GZEwUQ5sN
	r27vKROpoCSerOxCO0AnsWvCvsp+l1NDcdwipGOtWRJhFFzjUtQ28PvWd8aCEWnZ
	J7wrwWgcWXPs4xFbyuuvLfqJVIcIZz00SNTdhpuXe4W9Joz/6dol4h5F2tkuF8E6
	bK85tuLuPavGpup8Y1cvU5c0zH8QNxyWC2an1CMQ++FDeUXzJmTn7n96XUNSabrT
	sd92/l/ufThls6Do7uTXUBhh2qoy3JCb0WNTc3jZgwzuK7o79qPL/ZWpqo19DFXD
	L3kYP9mvUmkAs3DjlO+ZQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785245855; x=
	1785332255; bh=z3f2OgbFkTa0yiSQNdRvT4FZULvSq630d80q9uArK0M=; b=U
	F3GcCmeeAraaSMGdpVUnB0xyCMkywHgJsk9oWk7i01nH3gkCqn00a81uLTEYlAHo
	cyhQB+hADUn6zgLcogrFMfFjGN0cS2s08hITbZEe3catB5TkqTdxAhXQ8ocy2MA9
	YnlAjYypC+31H4BtxIWmcA13Mvn86MaX2k68PcPHkoGGvpjC2wu1WB+74aAri6+a
	HPHRB5DVCAYUZVFKZOl5DMC7cUj0FrdIGNkgcCPhV4kxtr/PHzjMsXgL6KU/z2z2
	01tG/PcGBiDOVspM1MYgDi9IsBcx3c+V7VuIV3pDgLC8hLoocpH7OqjmSq7HZ9t3
	tzv+KOew4OAehdTI4lATA==
X-ME-Sender: <xms:n7BoaqHbG5GgC2n4u91xxqdahXIh2UrPX_7ErzdpsVzJcsjPxwi19A>
    <xme:n7Boap1nIcblkuRlSr6_mfe3A9aeAIJvwhbYUrubbJaQ42OfMWGYVQjl_Yv8iBnQ0
    oz6hn5MNRwYLS1AbtOyb3TyTRed5m0dRjUfUrjWipnOz4LLdLyIUDMM>
X-ME-Received: <xmr:n7Boaq9HCIBtu2tC-mPXQzlHHVw-fpKduFvDc7IUIasn9l5CS7p6kr0Viz4afyuX3SfXADPUj-DtepQhrneIN0kD9L6KERw>
X-ME-Proxy-Cause: dmFkZTEBljVdT5JYx+4e7s2/xtHk4InHzmN6oAJ7bZDMZDH9QSGzEF5FdkyK9S7wHN+95u
    ERnlPpE5MLjq5y0HPjFD8+WkObZUdbjsHndhQGgpMVpyBJ/5v8jR3LOoApedAqQG06UBL6
    Y+53H+fDGSyy1kJ9Nkw1s1IH2H8LFgfoz09CI4aM7p95q6y8MGGXjEB/v5TueW/yQl8+zj
    k+VCI9zPSCOh/v9QncVFBIL5YY0AkvzAPpbT1pdraNmeQzo1+xY60rvtk1eWOJwmyMCVmC
    5DIX5aCOYsC3XA/TRSnTaaKxLAjNp1axUTOpfg/PODao+7Xw1nJ/D/HWk3F+19AXsT/YZk
    rFGp1AdGof1S3HnG2yHcGxLYVKyXrUtOe+36eDa7y7EjcRSVSX4nV43oiJ6yVDnzrzJqoH
    o3kYKNMQwtj69tVp19JOP9Ixc7X2eCgGImz2mKkkRf6/uoiCZCwJFRIaFW/Lyq1kmfxFVT
    Dj5rZ4julxPisNcSrr7a1FB69nXARKFMzEoYOVtdVRygW0ygKMKqaGf6Ii44+XPjd1Wtbv
    h7YK2PaNBnjz+38pG9GAhHkcEapgTN90HCMd9cSPKiyZAJPOnDrMiGF6a46Hh4TVrCuHdF
    y/V1T5KBu0nUPfUsOvOjWJImCna0D5tPL7nFx2kIpoKDkGoMP1DFgxajg7mQ
X-ME-Proxy: <xmx:n7BoakELqJzeWCpz6R3FdPOJkJfjpd-MYUvDW5g-qfUNU6ahXYBsRw>
    <xmx:n7BoaohulDt9hqcXQp33BoFWK3G4rqCFQUVPO2wlnAZggfQmGz7nIw>
    <xmx:n7Boah--GcvUslkgivT0bKT_OV50iJLLtUa_-kSYcLFXbpJa8uqW_Q>
    <xmx:n7BoagbTBqDpvrWbSv1nVVbG05_xjfgJlCBVyS7-Md_7p-ZUkESzUg>
    <xmx:n7BoargKTOMvz9_2RKaoEH_EBK1_ZOysRv109MFGfet0lwNs9SZs4E2m>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 09:37:34 -0400 (EDT)
Date: Tue, 28 Jul 2026 15:37:32 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] arm64: dts: renesas: r8a779g0: Add gPTP
 node
Message-ID: <20260728133732.GA2187218@ragnatech.se>
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
 <20260721132936.1331318-4-niklas.soderlund+renesas@ragnatech.se>
 <1f22ab9b-7951-478e-9271-3d659e991ea5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f22ab9b-7951-478e-9271-3d659e991ea5@redhat.com>

Hi Paolo,

On 2026-07-28 13:12:53 +0200, Paolo Abeni wrote:
> On 7/21/26 3:29 PM, Niklas Söderlund wrote:
> > The gPTP module is shared between the RAVB and RTSN Ethernet devices on
> > the SoC.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> This deserves an explicit ack from Geert, I think.

Yes, this patch needs an ack from Geert.

> 
> /P
> 

-- 
Kind Regards,
Niklas Söderlund
