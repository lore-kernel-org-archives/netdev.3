Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E837DAAD;
	Thu,  8 Oct 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488944; cv=none; b=YFb0IcnRUHk/GtoEVygOb7SKdwUUCaAtPkRyIGoG+x1u8XUij3uHvlWybToaJ5FG4G7MEz2SOqB1KR64kDlxNuPcb6ZxGGQ/yufeG4D+kM1iL+5iIm44LkW8BSDNaKYfbmt2XHpB8A6QCcbjBL/Ic36b+TFO41leRG2apPR3GRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488944; c=relaxed/simple;
	bh=HFZ46q3xWOru5PAaBx57+vcpP8UN1FHSmkuwkSpWZLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ5CVe0Cux9dk8WicHgD8ddS7uaKc+NhziwYTjJ6Yi8ZoykY+elIfGYIhgI5faT8k8LNKFmCI89KhrBKp0B2YvRL+NAI4iRGrcM5CPoYORVnkGG0ZjtfMXU0Mmrmx05EE8Qi3yMETwpHMu/61opzAveR7KRbzFJ5/uRqJ2SKKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffnt4+yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffnt4+yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F181F000FF;
	Thu,  8 Oct 2026 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791488943;
	bh=meYWKD1sLEB62RcggqKaZB6N1gJxWM3izFsfIW09Zzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ffnt4+yjuiH0J4ZTGn/Kxiw546K4hoOxC2VdvB5L4PjmJTyNEnQst6tHITLc1mKVz
	 dmGIE+3TwwtyR8BlA5IYmNhBnwmtzbbl0Q6XAumzSpg7n/hRPxexi4GD5L79IPulBP
	 ofEPrVazAwmJ5RJjIn30LrGlyYaP3Y8lDwhpLRyWtx603l1n2bz9q1B3xj2Cj+Yx7E
	 UfLbc+6AnlKEaMhECxuOLPTvbvckvqJLkNR7fczk+99AUj+9RTUfIFf/kkFYtMFZoc
	 31uU68sXZfDc85umx0/60K7TUSbw9ItUsfHZe1NwWdvevys1aWPH1dnT7ZatTIizwQ
	 3LoBPYXAUszjA==
Date: Thu, 8 Oct 2026 14:49:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Lei Wei <quic_leiwei@quicinc.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	quic_kkumarcs@quicinc.com, Shuah Khan <skhan@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>,
	quic_linchen@quicinc.com, Pavithra R <quic_pavir@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next 01/11] dt-bindings: net: qcom,ipq9574-ppe: Split
 EDMA reset into sys and apb
Message-ID: <179148894202.902946.10212431273678375384.robh@kernel.org>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
 <20261008-qcom_ipq5424_ppe-v1-1-16caf43e44ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-1-16caf43e44ee@oss.qualcomm.com>


On Thu, 08 Oct 2026 07:51:33 -0700, Luo Jie wrote:
> The EDMA reset is described in the binding as a single reset, but the
> hardware has two separate EDMA resets, the system reset and the APB reset.
> The reset used in the example is a combined reset that covers both of them.
> 
> Describe the EDMA resets as two separate entries named "sys" and "apb", in
> the same way as the EDMA clocks, and update the example accordingly.
> 
> The EDMA driver has not been merged upstream yet, and no in-tree device
> tree uses the ethernet-dma node, so there is no existing user of this
> binding and it is safe to update it without breaking the ABI.
> 
> Fixes: 1898fc572118 ("dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC")
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml        | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

