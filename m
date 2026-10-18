Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF34302F8;
	Sun, 18 Oct 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327307; cv=none; b=AS9SbewOsraN/pv4R5gzlcJeh0zYYplARIWLS4/0iEKuKhROM0gAWejhGt1JClvYQgWD3CZD+DDyCICwUKJLUgxTUVX4VmwKk+gvUIEsFPu8Bdd8kVXs0+wQ/Ra8ErxG8LduYD9gyefn2CWAlaiS1/yXLZo/Nocl+g7p2HEIHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327307; c=relaxed/simple;
	bh=4oh9PulHu6G64lNO7jXAUztgRSPHQhwzqbYHYCUDpL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I19L2DBCld8RMwv0BZtwuOIbYR4NXqPb9D0ALVzG5hWsQxU636NPxAJb23XCjw/P4O7w3f8UTmMbysWvk1BGf1wNVzD3Vt0918GjfuZtkEKBRvAVXpIDGRoJlH3EPvrXRGdkV3izmOXgazxb1El6JXaiuKs65xe6RVvf7lyS1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBF4H/H5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBF4H/H5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5281F000C4;
	Sun, 18 Oct 2026 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327306;
	bh=YYLxVppBHM6KQuKaWTes1M0f16cRn0b8V8W0F9t2E3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aBF4H/H5O2A/dAr7/FXULD+FWwu+Lhzv8ZPehYqfSxDBNeEqLisSuqrWwtnhgwvVZ
	 T8iK/ZA+LBA9z1oOzh5e8l/S1zfJoWuHuCvNHdJ3QAeU1MgqCOOe5vjmg54VIlZnso
	 0Zkz+naox6FR3lY46srEcLeT/Mpcp289Gwzi+9yz+Zj2K9vsLFOVg741n3QQthmGvx
	 p0jBnC9KPcZwpaekTs5yyrK3iSICis4K4akQ2gnPfpMNJB1VWKdMuJWfH8KwWHVgWA
	 ZvLffHIEj4mGj4kwIEY6i/stGgxQFGmdiL8mFCE2khKmJAuc40YO1j9HqkGaCMv9M4
	 ElMaucEBwcV8g==
Date: Sun, 18 Oct 2026 13:41:40 +0100
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
Subject: Re: [PATCH net-next v2 11/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 counter debugfs support
Message-ID: <20261018124140.GI503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-11-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-11-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:17AM -0700, Luo Jie wrote:
> IPQ5424 has more BM ports than IPQ9574, so the BM used, reacted and
> overflow-drop counter tables have more entries on IPQ5424, and the used
> and reacted counter tables are located at different addresses. The BM
> silent-drop counter table on the other hand has only 4 entries on IPQ5424,
> versus 8 on IPQ9574.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

