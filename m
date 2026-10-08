Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC7361962;
	Thu,  8 Oct 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486470; cv=none; b=R532Cl4zIondunBBOgEqLrEDvMo7g4nylxrODPmNx6JhHIRM8OO8zWPR4RfCAcKZWtsnbalRcZWkmSckCDXOlKq9iaHO9jw9J//fd1aeRwkeyjqPl16vhVolHIH/3IbsLcFP3SR/qIcYmA0Gm+iltLa3BbOmlaA6EAY78Bu4fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486470; c=relaxed/simple;
	bh=cpD/y62xJ98lmETMOkFQfnB18TI6VlTyCp8UnTp+z6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrERjSAPMpIivGMgXQfHpVjiMIU4AR8v+yOeC6WCz7jU3imhtzw3z40ouGQmLiP1JGHY1qMJeVJOSSDqdEE4NWj+bbawfoop+pzmt1RZWE0BLvxylV2hW8l4mQvHI+Ovp7pZ1e6gJZTnd8tGwAjtDCeSzbBZV4gaZqqOnI0xvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f+QY2R46; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f+QY2R46"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D8utdJkrn8/2yi/QuWsfX79cpz2BfKt0GflPgGTkHo0=; b=f+QY2R46RDrj5KT51PG5ovGeu2
	iZKDiR0qhQVhTsQ8B0YvBeVQZy8s06z3/aUXmGRtRyDGH2quJvkUJylTFLXuvJVIMWJTBSz2e1gy4
	UFpZ+B+SgyNZ1fBzqCJBvckMZGMiPNo7UjFx/a2Ev9VIgPPcJbM8IOWZAq5khBEGx/Vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEtSd-009g9b-9r; Thu, 08 Oct 2026 21:07:23 +0200
Date: Thu, 8 Oct 2026 21:07:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
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
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Subject: Re: [PATCH net-next 00/11] net: ethernet: qualcomm: ppe: Add support
 for IPQ5424 SoC
Message-ID: <b3863c53-c97f-45ff-bfd0-cdde5bebb176@lunn.ch>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>

> The first two patches are fixes, independent of the IPQ5424 support:
>  - Split the EDMA reset in the devicetree binding into the separate system
>    and APB resets.
>  - Fix the multicast queue configuration table index, which is out of range
>    for every multicast queue on both IPQ9574 and IPQ5424.

Since you posted these to net-next, i assume they are theoretical
problems, not something which bothers people? Please drop the Fixes:
tag.
	 
    Andrew

---
pw-bot: cr
