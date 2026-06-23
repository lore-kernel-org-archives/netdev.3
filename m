Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17C3BD224;
	Tue, 23 Jun 2026 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202262; cv=none; b=PGRpwUWEgKpViL+wBpo3VRv/C+zfz9kR9BrSFHJ4h1rG4EccgMD71XPFQ+DGg5/6cn0NTm/KxkhRXbHd4hWi2TOjUdIy8i58wPHbny86YaAGivi7fOI7wqko5z5qAANG/zGCrPqIKr0ZsZ6PeYfs8kDgx3WeG62518lSpiJUeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202262; c=relaxed/simple;
	bh=bMGw0laREcZXJvOB76BysnF9htOY0ptpEJaRri/+oIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udu5fTAYxC/eOCm6B6vNa2PT6Dppy7KW8Y6ALSGnCzJT+u1F54vm6m3wkUiBrRBoWwEMQLAviG9qEmozgG12BSly6pX7j0DaHVtbw6C3M9gl/hEZjz00HEiaEAOZ94Kw7EWw1u6LoIXTRxv8yk4VPrR3xJ7gJeGOPDqeiyCaM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HvXKBYvn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HvXKBYvn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7hp8NVDAbmZqp5MpKiuRPaDPxwRCqbdjqE1l4PyVz60=; b=HvXKBYvn9sRmQQeHAS9z8G6EqF
	qA43o6oDyvuTo8iTEnNNolS6ejKVDIipURVlztsDaXSP/aVMGmcxdTwxbWvKFCkGveeqAP5Z/kqoB
	ci6mokUvaT2fesNRDnyl2fVaZGtMyWJf1s8fPn5MUBkSSxr/z9qOthzifJyRnBwv5jCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbwDb-008v8f-8q; Tue, 23 Jun 2026 10:10:51 +0200
Date: Tue, 23 Jun 2026 10:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
Message-ID: <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>

> Driver is not supported - in terms of how netdev understands supported
> commitment - if maintainer does not care to receive the patches for its
> code, so demote it to "maintained" to reflect true status.

Maybe "Orphan" would be better, if the listed Maintainer is not doing
any Maintainer work?

	   Andrew	   
