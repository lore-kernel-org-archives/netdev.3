Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDF48F829;
	Sun, 18 Oct 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327171; cv=none; b=ns0DHPIeUQAcOq/i9uuWzmQa2YJVHkFqcZzibid+nfaKs8eYRqBwiDahmRdtPpdrue3RBHfMMI7+ojbZmffZ0fbJj2tHM5ViQND7SIej7dKRf1CK81M40dt1lIZ4S94S1/xF9xVChzBFx1Ag7AcqCJ1pMw1Q7HgCDcCf/jsPSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327171; c=relaxed/simple;
	bh=Q3I6LGV+Nxymzm7oqDcb/j6Y/zjvAEOb3yiIzeS4MG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5rx4Gfw3BYJ0Wig61C/3j9389/WojMQ9Qbw5rm5YfmzGU9AZ0xCK86nM0FoVcIVwa9G7kM0ODansuglyU/8zat/lNE3uuB1RUx77WfRtRE9Pe5kdUADu858IkokGrgAtOrCRWKCtLTBUEF26pxi7rHcnEdgGoDGHv1VVKGlZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP80Q8bw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP80Q8bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA1E1F000C4;
	Sun, 18 Oct 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327168;
	bh=fc7E2/NcJQFSdM+nuJbApPx6exATasoIVfSOo1KZCFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JP80Q8bwzYr1V8jj+xXncFPGtQ5EMljaOQNTZpBYSfhwBAuqqmCUyPSSz41Bw/jOj
	 WqSvGMLRkmz9xvMRj74vsHL5xI69Qbx5NBkhWOl0OA/eGbfAcPIT2gnvBLD7W/QLUE
	 hYhQ7fdxf3woZqXxUtOYWrCRRxFcRT0yykcNKkYcMIs95CfU3z280Vxh57iIHUAQy2
	 qboM6/x3bVvwwgbuCJMQzB+Z/NAAO1l9LJ3+uHoe3alezoP/B6iEn9BB9Lzd8znvDA
	 uPsA/5K4e9oQX0EXY9LA0SmUeYqohhkVizO5rEYrUSUcAgVLvyFR801+mV7VpKyc3q
	 QOBvqvob5WQ6w==
Date: Sun, 18 Oct 2026 13:39:22 +0100
From: Simon Horman <horms@kernel.org>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Subject: Re: [PATCH net-next v2 04/11] docs: networking: Document IPQ5424 as
 a supported SoC
Message-ID: <20261018123922.GB503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-4-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-4-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:10AM -0700, Luo Jie wrote:
> Update the qualcomm PPE driver documentation to list IPQ5424 among the
> supported SoCs, and describe the per-SoC PPE hardware differences.
> 
> The IPQ5424 PPE reuses the same switch core as IPQ9574, but runs at a clock
> rate of 375 MHz and supports only 3 front panel ports along with the EDMA
> FIFO port for host CPU communication. The EIP FIFO port is not available on
> IPQ5424.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

