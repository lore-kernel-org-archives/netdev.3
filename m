Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36F538D72;
	Tue,  8 Sep 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869520; cv=none; b=PsD1PBW07ZtB7QlyBmJRRCScLTIl6ZDQR0QKEzh4B3ZYvnS3b8ovK736QO9IzyyWe6LTV5BdnZPfX/BjpLLMdu50rjGUxQaNRrIZeMEjQcgKO0qd7i8m5ngoRQC3NGwHi1tUxJT6xTUzfIcFtrPmL2Wjwz33KKZD/nXZEAHc5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869520; c=relaxed/simple;
	bh=g3EU/SwNXzHcls/4SnZ5WjIBF80bI+SuZA3/IBQzgSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Xcj0sD+7LB3nDJsI23uzuBEGvgNDZcx4U4yPEsyLecnqaCxVJEsN0a5MHKX3KufOvB6XmZgbNYtYxOSClW743OiPIU0uJCcg5bU5Oi6Y/vePpXMN8OKbgFDNJ9zfqrsQUlzthgnj2HNgg4OhcCQqf4nuh6AEg5wvKfPsddJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6H+/rHWI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6H+/rHWI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QRgLDIKiB+9Awq0KyO7EgBwdPwQyrHHXRPZ1aYnv8w8=; b=6H+/rHWICEjmPSa/znlZBSFfHi
	ir79TOdkyzSFNS/wilSMtJxU3+Ymlxi4wtNue1aE82xdBGDooqJBN3lT4eu4M+cpw/xybhra7vy1u
	BsowDMg+5CJWpFlue7krAuIGyQjEHsrOz5GcNx+p8oTxIVde0PuUkBjC+O5L7B83GDiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3ufa-003sje-GZ; Tue, 08 Sep 2026 14:11:22 +0200
Date: Tue, 8 Sep 2026 14:11:22 +0200
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
Message-ID: <169b2cd5-d0d8-4682-8756-bacf545a95a0@lunn.ch>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>

On Tue, Sep 08, 2026 at 11:53:30AM +0530, Mohd Ayaan Anwar wrote:
> The GPIO mappings on the IQS variant differ from the CQ variants.
> GPIO138 is connected to the RGMII1_RX_CTL pin rather than the NFC ESE
> Secure IO pin; the latter is connected to GPIO49. This incorrect
> reservation causes the probe of the second Ethernet port to fail:
> 
>   shikra-tlmm 500000.pinctrl: error -EINVAL: pin-138 (5d20000.ethernet)
>   shikra-tlmm 500000.pinctrl: error -EINVAL: could not request pin 138
>   (GPIO_138) from group gpio138 on device 500000.pinctrl
>   qcom-ethqos 5d20000.ethernet: Error applying setting, reverse things back
> 
> Replace gpio138 with gpio49 in the reserved list.
> 
> Fixes: 779aead2dace ("arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm")
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

If this is a fix, should it be posted for a different tree, so it
makes it way to stable?

You don't normally mix fixes and on going development work.

    Andrew
