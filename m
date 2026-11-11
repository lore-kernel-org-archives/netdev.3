Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402254;
	b=a5erqeQNO8BCWR1iHNnS4qNsseSAZxNwKuGAPaj1mYkZkw+O62+A0L3g88kcRKEeZT6h
	 5WPQwD5AWawnQGNlCiPYwDwnlLHxQDCzBaLWl/AjgmQedI8ZOMq3xizwcOL67GKNk8RnT
	 ChAbrLrV2WnFOnnrE6PkOsjJ8pT3C3kYdIpITqQot2n/eLrqMRc+cNvL2zUQuH8Af0EsN
	 RRobDBtx2HaKrhZe45ayertas2azlIjwamvG0mtY7ZoJejc6kxpAM8rtWS3LNV/6P3Kik
	 kMYtTBgO5OLEup1FtpDj5sQMi/wKbp6mHD1DzuhiN6Cs9R+6v2Fz4UcB1r2tD86orig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402254;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IDM8m7uT5omzAHtyhGdjHEEMSBTWvHbWIkCrnPa+cKc=;
	b=2+gu8qnT6lSRBD4bAbOYyJG6Hxlg688apdfcl9ZjfaUkG1azlNjfJkhBucAnM/n28viN
	 OxQIUfQ7WYGbOyrv3hKkngn/LkUXqUQDyn0G7PwU9aClfjsBezXFm+0TLjLhuAFRtiJGD
	 0gZwwOzbf+diOrziZpE/9+PLFVrHxKXiDVKAQFOA6MV95IPrJ961MK8WuYA8zXiCVVB/L
	 FCaBvqcbAqJ+ae9mGVU9KeX4Iip7AuavitV4XhiZtI/9um1UmANsccBos8bsgi2WqomLe
	 0uWR1EiLhZvYVygCPCkxsICRevQkf6bQWMIz4FbofNFBHXdP/VMp/sjvZjwgdlQwssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH4dvwAY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BE606A881;
	Wed, 11 Nov 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH4dvwAY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717C71F00A06;
	Wed, 11 Nov 2026 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402254;
	bh=IDM8m7uT5omzAHtyhGdjHEEMSBTWvHbWIkCrnPa+cKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mH4dvwAYMMPBVa/Necq3qX+0kRxd5Wh268+g9KmekakLbTB9EWX2yeqr61bPOc1HK
	 ZXordEl+EZlh9l7GVee5kcgF6PlzPyKmY5Xa+zkKwntjTtfl3XXPCm+n6xDuSIK6Ff
	 4yJh8CziWGc7nWzC0iNvMqN+UWmgeq9c6/8DWjKckHbvkQBo4whHSk0xtJ5mtUjlWJ
	 hJN1FjHSl3RQwIYaB3dj1eFlIINRi5ROO9KfyxtMmVNwREagigqtaK+mgqqrJirgk0
	 u7VigQPQ//zC7HiK97n/pyrBItlrk/mJEcHytYg8PTGvsFu8fQ3wtu8dTQxgraTAX8
	 WhzcTWbQQTD6w==
Date: Wed, 11 Nov 2026 14:04:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom: Add I2C and TSC clocks for
 Nord
Message-ID: <20261111-magnificent-spicy-pronghorn-076beb@quoll>
References: <20261107-gcc_i2c_tsc_support-v1-0-433d02972d7e@oss.qualcomm.com>
 <20261107-gcc_i2c_tsc_support-v1-1-433d02972d7e@oss.qualcomm.com>
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
In-Reply-To: <20261107-gcc_i2c_tsc_support-v1-1-433d02972d7e@oss.qualcomm.com>

On Sat, Nov 07, 2026 at 11:36:36PM +0530, Taniya Das wrote:
> Expose the I2C slave and TSC subsystem clock and reset IDs used by
> Nord SE GCC in device trees.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  include/dt-bindings/clock/qcom,nord-segcc.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

