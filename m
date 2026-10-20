Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482720;
	b=1ukKsHS3nIyqwGXtuseggtMFSEtghgetbBEfhTLXdhotuBtI5EC8Nnq3nmosjIMnm1cP
	 7qZMfrAtfXtYK+lIEZSpYwDWfXYt5eBaGznOxYRR59xB8MjYlS9hffUKGVkp89ns+t9Vn
	 3ZGI3lzTVHsGbrQyg56pNbyabiA4lv5V7QnE1GHKUpT+fE76azR0P8BW5+aFOmdwjlIFW
	 TFIRh18OxrzdeEYo/cPsYFPyqEug5jLFhLzgCEGscRTVr01kMP0alq4BaQqqRHAXlc0UN
	 di4UyWckmK1zlPEPUtRNtFP9w+t+NFic/EHnihX54Aw6NYfMIQzuUxdgeklVpFxThlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EddoZMnDC5BQjmsaav6GLudp1Fqyzdns9EU0U/ed5sw=;
	b=YdYy8iF5AT7CL2+BzYTZS3EVKb3FaRf7goiwpbvkqh26TsWaOsTxB6LZipS+E4i3jL7z
	 WZeHULGl/P1TRAiCgf6EkBUQgbU5baVgtMjRWiFAudd67LP6M0qfbCTS7u8Cc+7wga/Ww
	 Hyq+Lv+ASGh3qu+z0gyYbNafZWMd0yMxjml/sGBMU1XavdOL53gf9arBH2EYUdRMHIyyg
	 QA1WbCgZNqov3WX3p/UgsYEZaSo4yubcMfyUtCnXqdZVF/FJCPscLa8VDjccFLIHvVtLH
	 mr+YHuc5WHE8mCCS6+ksarfBnv8P7wXyKEdX5vFtucLyU6hvcXa6giO+tqNQZSC9saw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCJ2aw5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B0606A319;
	Tue, 20 Oct 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCJ2aw5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA571F000C5;
	Tue, 20 Oct 2026 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482719;
	bh=EddoZMnDC5BQjmsaav6GLudp1Fqyzdns9EU0U/ed5sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCJ2aw5t8+HrHgixBOlbRwt98vnFSbsecGr1H4pykCS5gqWVhShIzoQdjVhCHge2h
	 IOnqKWfOIzf/p4x7+Z0o7tphaB4HweLOOrYDPrgfnshiXeK4ohl4AKojXfAozj8uGc
	 lzlVya6qTllIUo1iCml3BO+Z5xUrC9DK5QXvHsRPipncv+VCBF916s92zLgLYsgPHa
	 MnFDNG1sUXH59KJrqzAnsZJ4hkxoWBO/BXzF6io7Jl0MOy5szzNy7e0+rBxrfU+8tZ
	 oIMz6ReFBvfe+4gDLYCyLNkbih64B7A6pgy8o8Sq/rnz3DElac05NJsg+bdAP/E/XV
	 GmiyKZgbdEy2w==
Date: Tue, 20 Oct 2026 09:51:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add LeMans Draco EVK board
Message-ID: <20261020-accelerated-husky-of-whirlwind-ce022c@quoll>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-1-dcabe94f1074@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-1-dcabe94f1074@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 03:57:32PM +0530, Gopikishan Thawre wrote:
> Add the qcom,lemans-draco-evk compatible string for the LeMans Draco EVK
> board, which pairs the LeMans Draco EVK SoM with a common carrier board.

So here you explain any oddities, like why SoM has no dedicated
compatible and why common carrier board means it is not common but
SoM specific.

Best regards,
Krzysztof

