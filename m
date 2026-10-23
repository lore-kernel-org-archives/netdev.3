Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758013;
	b=EI8QnjbGKzUKsqVacgWKYokHsLKgj3tPp9TOQpmIPw2mEZiX6ni89l9G2YxSr8shXv5f
	 Y1MzIazlrRccY0iHEWTOCiOa1yWld7m9Zu5hJosnfBIa0eJ60hP9/SOKAbGJWHTCSVqyp
	 8vK81NagsfLdb4d5jgCtHrYf4avJ3B74lX4AlZ/ejA45NQIR5piCQc5uz12TKMKN23rAu
	 CNpz5W8Z5rJY1+jw0Dj5zLe73c/wnHeHi27YipBBsX9v/NjCRVdl35l5xtKEqXHXGtcko
	 VEmqPx9Po9EhmshWsw4WYHS/QIIFCxBcOKJRQwHvQPHmB27Ckd4a0W2wMppMyfWPiHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758013;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BuNxMGQP3U94XFMwzCLYvcRc87hOg+v7G+bAR2Oa+X8=;
	b=KiS85SYBBS0JvP9mzaI3yiFSWBD+81097ymUG5BQz+f6K7DNb10N+O/tJD/yatM/zUtH
	 WpmPuu+dA3KSXwIIZ3p6fJId5kukWOvBKDWvPmGz7sKO1ZclP7yAoadbWfHFVlrzLH5vX
	 6Xdr9SAFN7/vaRR0+aSwhHv1b/YnyhQXRNhgS6ud92XG6hJd4Z2WZhdzGC7yWKuiZljRS
	 3vCJWiiXI7wNWFvTupEQ2mTGbsBF9EuXQlk7wf8L5ILw763iFhBiqwU/ahoaOhZqFX73H
	 xr6M6V16U48EfHmlATZZdnoKSAJIqcJR91fmOEFykSp/V3KCcQPaopN+KO721q/U6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=57pxXtx6;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B84606A31A;
	Fri, 23 Oct 2026 12:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=57pxXtx6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BuNxMGQP3U94XFMwzCLYvcRc87hOg+v7G+bAR2Oa+X8=; b=57pxXtx6MugQeorYSu9531Ncyy
	9MhVKUothNxnD+7NxfzuBwjZVvrHvWCBt3QBcAy173vW2nUwLWwKrk28GeCN1qoVZI8FqG0/biaPq
	M7qvSfYw15/PHOrXegZV1t411rg9S3UmD+cJeIo5l5vZBnAvNSO7dQdv0WfPOvctcig8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xKEFj-00CPfV-1X; Fri, 23 Oct 2026 14:20:07 +0200
Date: Fri, 23 Oct 2026 14:20:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans-sa8255p: add ethernet nodes
Message-ID: <e064863e-fc1f-48b8-9cee-b087a5850bf9@lunn.ch>
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com>

> +&ethernet0 {
> +	phy-handle = <&sgmii_phy0>;
> +	phy-mode = "2500base-x";

Nit pick, but if it is doing 2500BaseX, it is not SGMII.

	Andrew
