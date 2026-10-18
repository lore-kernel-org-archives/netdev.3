Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCD49A3CD;
	Sun, 18 Oct 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327273; cv=none; b=cOl59uW2wOqY+hNJI6zLVQylddOvyC0RTaNtdf5evbp3A7ZWT6DgRQik1ze33fia/lA9E/m1O3vfNghU1GwBcaJUBnzeWyvYxxdImchf+p0jtZh7L+RC4bRxCOWJ1BSGPnWAvWFqo6Gz+7oqpcwQHklkJNw5mbZ37GYnL0xW6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327273; c=relaxed/simple;
	bh=mdzhCNqwFmsFU48ZPLlfGgxxvp0XscKtn9064mRorgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJIU9xoSPwz6856B7VS0M69FQZqGP1WNdXXDcBwGuwF9LG0Px7PDeQHcRn00XJ0gDEWh3gY/7ABkQdj970vFUrpwQM9jx0wfsqOckt45LL+fUc1BP9Xv5s2GGaRKgObnurJxME+WXVuzA7yU6Zp87G6VCYyyCodX0buS3C/f8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTJMD3dL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTJMD3dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C3C1F000C4;
	Sun, 18 Oct 2026 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327271;
	bh=rhzL89jOP15mo878PkrCaqoSWRFnZBCWApqKvirBzDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTJMD3dLXD5e4USXxkkt/ddUc6KwpkWhr+YMRHDfWsiJfiX0+sOOVfhWznuInDAx9
	 C5Nj3fyCl36SeaeusaTKsCu/rH8J5BZ8v4XfhXUEea8jwCWnO20j8LjLorcGdku1bS
	 S3gJ0UxypPyyqaPozMmjEVjYoFeHoTjOhG9QHdH2ozqGIKFdBkClLbDj3rXwv8cExV
	 2SzOAfGYGAnkSWdW/90B0mFif1sy9SpOIYg/s0xCoEh1NRy49U8wWeHjKfvk1IKxdg
	 XCjribnVzM6kmik4rOvijdbhCYOWjQPC1wItzVNRkqOnuh7UKJRBPGrEyrtYUB+tCd
	 XZ4m3fFUOX/BQ==
Date: Sun, 18 Oct 2026 13:41:05 +0100
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
Subject: Re: [PATCH net-next v2 09/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 scheduler configuration
Message-ID: <20261018124105.GG503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-9-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-9-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:15AM -0700, Luo Jie wrote:
> The PPE scheduler arbitrates the access to the BM and QM among the PPE
> ports. IPQ5424 has a different port topology than IPQ9574, so it requires
> its own BM and QM scheduler configuration.
> 
> Add the BM and QM scheduler configuration tables for IPQ5424.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

