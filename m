Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823A3D5663;
	Thu,  8 Oct 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490117; cv=none; b=fHQXpZv37wVyvhABOvquxqAmUou5is64ceZ4qtWuhUBTPQiCzTpE7tClocW+NCp75yawKAs36n6e6TvbJLs3spDAH5Ctze+HiBtWAIWMV4ru+zmJT0G2kEgz0XqtrfpfoEPMQYnasSk20iRcYxV1xaYpVLsb6rKl1cYk5waCLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490117; c=relaxed/simple;
	bh=Sc4fMsvIwqkBAjMFj9hplC8Cttee3nMmLujAzRDb2Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOxB62lMyy1eK3R/D7OpLEuMGGkCANgNE4TxjoDf8FdaL8WsSDKl3xhpLkahXdU/xNodTHsUeg5+4kNaqviilbwai9CIa1FoRojlPzrJfuFSvwzxnoCNl+tq+NMBbXfx5/eJ8N/49MlTyAQCSz8reKllFHpysOCke6RSBjebo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4u4/XCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4u4/XCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0D51F000FF;
	Thu,  8 Oct 2026 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791490116;
	bh=vdt4LgR1i/9D2iXObtflcBx+b8pFRSIJlmL34GzbKts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C4u4/XCNUrBgrjzr1kGfaeJQBnXOXpiULH9hGNUq0l+ayGKK3I8nVMWEgL2MccEwU
	 yzqvqxYvF+2M5N1sGnuRqE1165FMSOqVwaBC6eOTFKZfSypMyv9qKpLvf+fjnEPn5U
	 3k+/LvKwqO0BmoxWMghg3X7NjH5ZNeZhGG9pUDYtUECk4AkXwMq2MqvNAzPQBJdLHy
	 +8VQPzOasRpDAAUDm0NXkkKe8ZAJnw4NdJHb58e76HFL8KuhT5fFg04oJCOVo97gv5
	 d0EJ7pIxogG0NYk9GhmOSZltjrUIy31MTwIrBoyIQCSKQj1uLyHllv9H5NRC1vSzlF
	 pe+0Cb8V5U3ZQ==
Date: Thu, 8 Oct 2026 15:08:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Pavithra R <quic_pavir@quicinc.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Jakub Kicinski <kuba@kernel.org>, quic_kkumarcs@quicinc.com,
	devicetree@vger.kernel.org, quic_linchen@quicinc.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lei Wei <quic_leiwei@quicinc.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5424 PPE support
Message-ID: <179149011467.959134.13186621321621219297.robh@kernel.org>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
 <20261008-qcom_ipq5424_ppe-v1-3-16caf43e44ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-3-16caf43e44ee@oss.qualcomm.com>


On Thu, 08 Oct 2026 07:51:35 -0700, Luo Jie wrote:
> IPQ5424 integrates the same PPE switch core as IPQ9574, but requires a
> different, smaller set of interconnect paths, and has only 3 front panel
> ports plus the EDMA FIFO interface, without the EIP FIFO.
> 
> Add the IPQ5424 compatible, describe the interconnect paths of each SoC,
> and limit the Ethernet ports of IPQ5424 to ports 1-3.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  | 87 +++++++++++++++++-----
>  1 file changed, 70 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

