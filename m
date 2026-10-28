Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186889;
	b=32bG7fRBMvhAjsRuXJprvl4ZTR8IhYQfm4qsj2QaFYDfKzqljcs4uwnMpol0AeDk4GM8
	 LeV32jA2w/a+OHDrdLY88uDvFOspCEHBqZS6uSpyWHKU743sa7acQ0QTpuOFOe0N9/cvu
	 5C6eEzLd2P1T9Qf/fjMGdWU8d3tALKwqO4FIZ61dLQXZXBdFldUgbZgW5zCOOX/htlS88
	 60LX4qNXrehJQ4+/TKlOr4uCLVz9cbz5djyPI3R791r3dC6/JxfDvfwohwCE9qf8z1zZI
	 a8E/MzeolrqpZftNIqrJuEOwBd8oMmDH0urlSEfksGofX3Kls0cNhree74ttXXD0Okw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186889;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vjao0k+Gq52juNWET6vZtX2P6Tqcoz+JQL/rOBKl3UE=;
	b=2pOYUc60dC7oshWPb8JWszWWtXX8KOWmlD1UmVfNJbJHfbevL66xu1noC4UsEweFaXoZ
	 XRjqk6Mie40lTQMIvppX5ybJXhbPNpqSMYsZx5V+TOQTqsgOogluGIa/GIixuGp7fQWAu
	 IswpvjqtTfLvkyzvx3Ci2WPCMAkMdll2zTrRN4knLmpxNzygejDcd8LUU/H+uqAeeXv8b
	 ALUpdfpXn5SwguCOPEawXxwp60n7OkUbZ+lRE7VjFkMgTkgjdjLx3O7fLth4Cnn+zhVa0
	 yfBeD4PDj+LaPt2PTAu1h8Z9lfXd8O2/KgS4chUFUB6h4ADs/GWoi157DdAKXDEAH6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tepw0fRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A206606A330;
	Wed, 28 Oct 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tepw0fRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B181F01825;
	Wed, 28 Oct 2026 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186889;
	bh=vjao0k+Gq52juNWET6vZtX2P6Tqcoz+JQL/rOBKl3UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tepw0fRtsXxbiIR6Dpsceez4GERZTg2qAcr16y1/et2qVig53iua73DIPM3OwPxyU
	 /vyQOESrhNVraQeGi9s1cHJaZx1yO67RjdKyEnIa/U4QRXqVmIECKRNQrMtdLMkazx
	 hBenM2K9noBXgSiPY12SGVbDuohREsLETbiHLo5RS1nXlYZD6vsUifluM6my6cUWph
	 GEpsO4QnH28kF8blCIYqDmqX7xJ2tRZ6Okkyj1AIaKr2pCC1YJGnI16FpQMafb6hSL
	 dJvfCDKDfNABzJhMBmHUIxeyTAJSDMUUcMuV3zDgRL9fD6dl7v/E6Yk8TvL4P4QGKW
	 caMqG2IRujDLA==
Date: Wed, 28 Oct 2026 12:28:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/12] dt-bindings: clock: qcom: Add PDM XO4 divider
 clock IDs
Message-ID: <20261028-fuzzy-raven-of-rain-e768aa@quoll>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-2-ff8e4bc8d567@oss.qualcomm.com>
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
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-2-ff8e4bc8d567@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 04:59:28PM +0530, Taniya Das wrote:
> Add clock IDs for the PDM XO4 divider sources on QCS615, QCS8300,
> SA8775P, and SC7280. The corresponding GCC drivers use these IDs to
> register the divider clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

