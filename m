Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3A552922;
	Tue,  8 Sep 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875860; cv=none; b=OuVUdz2zzjRUHZkh6hJG4K8jTsuwZrifpLqhx8ezJOo4DwbVBxeaJx/C1xotjJEWJOfICM7NyqnRe8reg/b7aRndK+y1qcOr1cdBM5CC9AgjpXnTTjVjTigSOqnyLuV5Gh9h4Sq+MW2vvuQdl2knjMD1YUpxAp2bKE+rY066ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875860; c=relaxed/simple;
	bh=NzOqW4pt1ajz4dkof3dvngKvosflxIFCUNOB+eH1C0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD1pCnyxMgIpdThysdBGWUqFPj/pSAnQvSv02KrdgYz+6ZSlyPqYD/JtVRE5lfF+Vsclt2tyVUHmeHowAbFxqbSiuJYkt5MUm6ry/Hvej13fI/yys9ua4+Uuo05Uqyn4eY6vAuzcauqcn92xXokCxhMZXzcXbOw+J68Zxe2byIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZVSmAlVj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZVSmAlVj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XSHjoqKZS76dua77JkRtMPbt7wmbUOwxQGX1OskVqgY=; b=ZVSmAlVjfi7BqYY3PRBrVxPHxD
	sS5JSfpvLfTbVO26Z99zuuD5k90FELrsTyZ4Nl/bsWXlf6e9F9WwuMBlngO5JdANENGcmVw64gseh
	F+7ENanw2owYL/FxvudbgCfsXoakPB8z+nI0QAZ4ErnRPZMH537uVzrUhMPf1yf24SxY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wK8-003uHO-Cv; Tue, 08 Sep 2026 15:57:20 +0200
Date: Tue, 8 Sep 2026 15:57:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
	Anurag Pateriya <apateriy@qti.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
Message-ID: <6e5624f5-410e-4413-82de-84cf864fd654@lunn.ch>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
 <169b2cd5-d0d8-4682-8756-bacf545a95a0@lunn.ch>
 <aqAQ+BxwJstTlnU3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqAQ+BxwJstTlnU3@oss.qualcomm.com>

> You're right that it reads like a standalone fix, and that's on me for
> the commit message. There's no functional impact on current users: the
> reserved GPIO (138) is unused today, so applying this on a released
> kernel produces no error and there's nothing to backport to stable.
> 
> I'll reword the commit message so it reads as a prerequisite for
> enabling Ethernet rather than implying a current break.

And drop the Fixes: tag. It is that which draws the eye and makes the
Reviewer ask the question.

    Andrew
