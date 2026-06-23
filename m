Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0E2772D;
	Tue, 23 Jun 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214394; cv=none; b=jcgFIXhizK3GLt/PPQjI+64b3Q0hv3YQt9HskzqxfAdQypTwlTwdIRVDLkxxycKcPWeVOZ87OEHe80ADW+sCpdXoPPFAB4hMa3Nf0qdax+6WTCMR6QpJIpu/l3ZbU5Mqx6609d6KtdVLvqNE4+IKb6LXXTOFLzHiKQJuyKNriEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214394; c=relaxed/simple;
	bh=+BCocolzNbPqVls/vOUaBRdhKMlP7Yt6GUBic0kLLgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9ObwR6NttbZ0TzO8awbY4KFP7M+Fyv327NzT4optn8HnibGj5tPZyukiJQmfaQSI25+zUKqaHmVDtHKatw0MxTyCftPPQ727fbQHk/YusAjkncR5FJdNLtiY3kenxiCQJuOOaxrjgLXDIB0JevT2FBOzcf01SZGm/fjBHZnfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ozHrpuCk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ozHrpuCk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XdA/MiW6laQIoTxSswqnH73r0TTTKiMzVB16q8vAsp4=; b=ozHrpuCk16GLXUg2AHUYBiZOoy
	O2QaDSL4QCJwvwRop5dzcyG5PoGDUjI5toV3TLK6urV6ILbglITQTVncITWEEq+V71tcBTSYez+bo
	KL9AfPMuNmEB5QPQ/MZULnvo5bP3E8/ik/341LOSG2xpjB1I3e8n8KWu2s6buZTjUxUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbzNJ-008whw-9V; Tue, 23 Jun 2026 13:33:05 +0200
Date: Tue, 23 Jun 2026 13:33:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Jie Luo <jie.luo@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <0c1be662-3c6a-41be-bc19-081d0299ceae@lunn.ch>
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
 <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
 <f8441903-c768-46a1-8f95-b1b25d420a2c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8441903-c768-46a1-8f95-b1b25d420a2c@oss.qualcomm.com>

> If address did not work for half a year, I really doubt that you commit
> to above.

I tend to agree. Maybe we should set it to Orphaned, and then decide
in 6 months time if it can be set back to Maintained?

   Andrew
