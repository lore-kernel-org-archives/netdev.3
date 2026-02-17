Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9E17993;
	Tue, 17 Feb 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359914; cv=none; b=Mb/eEESh40vAGJcAeoS24wrAn8N5hthabdKUHveB4zdQ4loux2Zpfgy1/ZRPKI9WVfezGN8QxpG1yRkwrKf5mrsYym0q8BVVAEKVK/TCUYfxipyM3f7czz/1gSr7eb+JYtIRTTb+D57+AfFSQXmKJGWxTl0mPufV+c81RuASUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359914; c=relaxed/simple;
	bh=3euLIddiuagHcub65etrQEVoDD3rOgtcv3u0gHoR4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjpzJVXRyaoR1O+gU+PCbCLgagIRA03tRRD2BkOmfHh94ixrcN9j3vqF7KOrEl4jw30uD9Y4IZOohW3fpRA/PMQs8lka8ejO2MGhba4xyXeEAXIkPIk3f3Gv+DO6bsnDF/W04xlF4Ds5MfjVlnmitZZy5kdgY2UzxFVEr7eYdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIrKo+Y8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIrKo+Y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B3CC4CEF7;
	Tue, 17 Feb 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771359913;
	bh=3euLIddiuagHcub65etrQEVoDD3rOgtcv3u0gHoR4VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIrKo+Y8n/ukFxMchUyQAe2XdteU2CRpeHqGWHEPOl03fPD6T2mr8eb26Ukh3Ozft
	 oc2vS7116IE+JLIhrD7hCF4sDTOCCNA5j2q1m+jAajZs3xXrg5GJcyAcf6dRiWgjf7
	 1zYitlH2IMs5hr7ZYNPcQGWE/2kl0cb1Rc858vhaJpbmNeEOD+AwtdgfjKUPT1MczG
	 sbo9w8yqA+i2nAbJPX5SPykHtRSKvWbumjI1XW0E/SHoRw356N6VCQ25q6R2ZCs1xO
	 VcsRdaFM3DOU4pp1iQMuW/8PZ0JnTUI9ZmshYrhAxDiMFliJ75eX486W83b0G0a8zn
	 d5UEiGqC4Ls9Q==
Date: Tue, 17 Feb 2026 21:25:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables subnode
Message-ID: <20260217-godlike-silent-owl-0a8487@quoll>
References: <20260217-topic-ipa_imem-v3-0-d6d8ed1dfb67@oss.qualcomm.com>
 <20260217-topic-ipa_imem-v3-1-d6d8ed1dfb67@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217-topic-ipa_imem-v3-1-d6d8ed1dfb67@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 02:30:31PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The IP Accelerator hardware/firmware owns a sizeable region within the
> IMEM, named 'modem-tables', containing various packet processing
> configuration data.
> 
> It's not actually accessed by the OS, although we have to IOMMU-map it
> with the IPA device, so that presumably the firmware can act upon it.
> 
> Allow it as a subnode of IMEM.

You do not have compatible, so rely on the node name as ABI, which is
fine in general but... I do not see usage of it in the driver. Why do
you need to define modem-tables child then?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Best regards,
Krzysztof

