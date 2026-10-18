Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A68498E24;
	Sun, 18 Oct 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327236; cv=none; b=QhVPPz2F1r+0SJFLwPLLh15tMn8CH5DHDdmqNd3lL41fVcmB9nTbK+kMD9YuMzCH4FVC9YsdPELvF+rrn6VtwvwiXww3T1kepLIAFLtoen2aKlFJ8bQcRzPrnuE7lQGtD87PPBHqwAfg2OcEvUogxFyXcYn3DkoU3Mh2RZPxvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327236; c=relaxed/simple;
	bh=1/pqM7p/6ttwUPAd5kRhYrVlKDPT+FMXNpvvZatNezE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkveNDSl1JBKAUbbe0Zuy2/VEnlxccIilFXmOlEPwqFfdpfcPNFBJHK3R3r1l2wSnVe2zNdo39iFG2CYAkfsjPtSJX1RItySeXkAfLO1bOR69Ilfui37qO9SxzvyjjzDx41fIhN8kyRGcRFgBhT4xqKcK5Quf4dcaernUMY8Mjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUXqF01Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUXqF01Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C939C1F000C4;
	Sun, 18 Oct 2026 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327233;
	bh=TUwMqbPfvkRicubw+241eApHbwFZLrNEs/4kQCCRzY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KUXqF01Zut2aiB76uBWfLiEgyyhNA1WUhFPXeBnD8UzzRiTVGd5nMVOtfVPuO4IbZ
	 nG5NRwSgNxfLgfpVswHWTr7QPrx8KGe7FSDOSUISd0Xwgrv8sI1WbBRo6OahD7BERv
	 KQl0i0kGz0dsq5kTeEwDWUeJUQ/vQRP0zqNNJA4wubwXxcewysbsRGJzXJPtLdfObM
	 6BgTopWU1DgpEu9/U3fPWGzo0GAWUc5QxivfsKrH9MoPLy3hOXI9Hk/Uf7E6OjoePP
	 fa7JtRr3wbuA0MhXjkvd9yYfDPqnrt0P6fj6m1HFwQFDzobl/B66Io8YRwyV23zn3L
	 t9LbgF7Kx7NFw==
Date: Sun, 18 Oct 2026 13:40:27 +0100
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
Subject: Re: [PATCH net-next v2 07/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 QM configuration
Message-ID: <20261018124027.GE503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-7-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-7-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:13AM -0700, Luo Jie wrote:
> Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
> PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299 are
> not available on IPQ5424, and 2010 buffers are assigned to the shared
> group0 buffer pool, instead of IPQ9574's 2000.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

