Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68C1C3BEB;
	Sat, 14 Mar 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773482279; cv=none; b=PLzkJB2Q4QGr229dYfKzoTRwfA/g8e7zjRaHM6c8oXFJ2xdZ/GRgJX/PaVQWeve06Ero0z+lGBgh54XMh0gwtFFwauT+k0bmotAYeKu7hDv/zTJp/RSPM4QToGTFLASIw2KbW9W0yLVs+Mi/OJSDRIzoo+J3/ksTjFt30M7W7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773482279; c=relaxed/simple;
	bh=WaFDHNW+o/kPoD6aZqO5Zhku1WNKt9ChNnSbe0Auf2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJkDh/We+e2LIVtRcXW8V9JrzQt4fI2OffrWLrMaNZkN0jWW4Z110iBOSufvPSq8kO1ufAaHyGLlJSTMEaH6g3dKK7kYuSTSnCn9lNX1xSiMqOOp2cbitp/wJ+gC+Rqp4IeSlAsNhRpto1Yc8NLnyP24fIuZbmeGQpQ+8oBqydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMmvAUck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMmvAUck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8AC116C6;
	Sat, 14 Mar 2026 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773482278;
	bh=WaFDHNW+o/kPoD6aZqO5Zhku1WNKt9ChNnSbe0Auf2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMmvAUck6s8qzWXDA5IbzXT698cr8Lh6rpG694cvqFpq1Zc3OkI5TwUsmDdA2Pl5S
	 brZCSNkitOlam7sVRqTxVjvfSGExrCJlvHxAcNPVltfrnubhuhoN9bEovWWabFlPOr
	 vjrH7lOSLdzbxaPFLkiQbH7LHVBJoKcQLrB4FLZpsvf+UHLMfU1zCeSK4KCEwz2Nuh
	 GkDgkQGhy7K91fVKnMhLvJgvpxpS9yMfrdMQ6Lg2H/FqFLnOVArXuKrVjOfSWgKkZT
	 xmQWgZWf4HyUnmwK4446vEIT3kfrp71hNRc+Y9A2YnqovTgAJq4/aJQJA0+NCF4OS0
	 10o3EWP8HRigA==
Date: Sat, 14 Mar 2026 10:57:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com, 
	r.mereu@arduino.cc, m.facchin@arduino.cc, geert+renesas@glider.be, arnd@arndb.de, 
	dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org, michal.simek@amd.com, 
	luca.weiss@fairphone.com, sven@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: arm: qcom: add Arduino Monza,
 VENTUNO Q
Message-ID: <20260314-ambrosial-red-auk-9a8692@quoll>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-6-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313103824.2634519-6-srinivas.kandagatla@oss.qualcomm.com>

On Fri, Mar 13, 2026 at 10:38:20AM +0000, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Document Arduino monza, VENTUNO Q codename. It combines Monaco
> based SoM with STMicroelectronics STM32H5 microcontroller.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

