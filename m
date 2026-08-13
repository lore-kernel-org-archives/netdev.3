Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857839CCFA;
	Thu, 13 Aug 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614814; cv=none; b=J2RGSStR3C/SNRpY4hug1sz6/5OMjqeu8bpFg2ExBBymraXRbUOCMBUQMR2NJH1UxtWM1TVawpX7+Z5McN6aRKW6uVOdU8Zsu3Rc4gZcP76jCbybQUUFdxMMJwc5uTTAC7K9vL0Hdth9HQxaS1dXNerCWdsbgdvl0wmROygksGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614814; c=relaxed/simple;
	bh=Aw/NrBKBku8zo9XhlWyKeaV+0xrrgdZtKnzgdrFZ9fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPhIIIU4q0BIRiCD+d+JZsqPwDXmLqStiGMQ0KtwcMbNVYOPsjg+8hae9O4vlpM81JfAqON/uJPtxyCKYHheZD5OaRGqxT4v94fLnCO3ZmmVvUyUazf3VveMkfBmGZENJSCswO6IZN6ciPah8Uy/CaQ7pAk+ZT5u2AjOqrLuQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyjaphAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyjaphAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC31F00A3A;
	Thu, 13 Aug 2026 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614812;
	bh=iUazUG6DvoMz53ai5caSMEw3c5FXlY9MNE0qxXkV634=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DyjaphACex4r75BUiIgJeUPR/oEo4UZILWJLOVeTzcowpGB94FzpeMuV+pD8LVN/C
	 ktfG+YEVogrLd16CKcPvKor7CxiZEUf76kekrwQUWVrTZnVPQvhf5nFdl7KlRxZsTJ
	 yEEAFxvul907+emzymqnOX1YYZkvexObJeWf+a7nm9RB2hOHMSo61iUbJfkF8IQQPq
	 nwkqQsMWZY+CbbyL5ouMOR0GslVSywmn29aqRsjRS4kM2bHvSF3X/SqQVRA6/Hj/QQ
	 bLIYKpxEDsEOwSlSKYQSaTOI89dRFx23H1QG/lgNnw4kKM0li0VqfgS/AYUqGdgwez
	 KkVcccRY4IJaA==
Date: Thu, 13 Aug 2026 11:53:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Matthias Kaehlcke <mka@chromium.org>, Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: usb: document the Prolific PL2775
 USB-SATA bridge
Message-ID: <20260813-durable-doberman-of-gaiety-b2d9cb@quoll>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
 <20260810-msm8974-onboard-usb-v1-3-08a805768328@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-msm8974-onboard-usb-v1-3-08a805768328@oss.qualcomm.com>

On Mon, Aug 10, 2026 at 03:42:34AM +0300, Dmitry Baryshkov wrote:
> The APQ8074 Dragonboard has an onboard Prolific PL2775 USB 3.0 to SATA
> bridge whose RESET_N pin is wired to a PMIC GPIO, so the device has to
> be described in DT for the OS to release it from reset.
> 
> Add a schema for the hard-wired PL2775 (067b:2775) with the
> reset-gpios and vdd-supply properties used by onboard USB devices.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/usb/prolific,pl2775.yaml   | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

