Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA346F4BA;
	Sun, 18 Oct 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327257; cv=none; b=E2aKVbVgXU28LFQmVqJ5TJWwteZnRnak29uToKHOKRA2fHR0k0zU3Opy64fpR9N8BfeFwraGpUUM2Qdh478DR/uF06DZXMwDxJ0M5cbGvYCnKxof2ySqPioUJkAEtf+C8fJr+gpuXQ0XkPowAQADQEnnj3scCOerW5IuThMVxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327257; c=relaxed/simple;
	bh=BfE7d68dm49yWrnE2ge88uu0JG3dT7ukVWrTJtmk2M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLrUynfwh3GnMH6718GYnbVYTjudl9xvGkc8MfSP59RK95KdsrJfTiJhtS4eUSt0srHcPmnCEH4uJal/9DCvQMAUQLZC3tOFGgXt6hplv0y776HohMwNvKrN4+bflJYAON1kjXEw/Xq6YqEWmu5tbMm7yKbA0oMkJuvNPJ9o7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb4aHhKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb4aHhKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988581F000C4;
	Sun, 18 Oct 2026 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327254;
	bh=y2qbg+LeWy2gDVz4lUYisvsTwq0D1yxqqprIUxbTlyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jb4aHhKo8xg7KTLWpOeEPGCly4sWde8KjracTvBGVYKTzr5ihyFjuNXEsiSXkGxZ+
	 NnRKzDlZzYCITdZ4eJgLUWvIwYw0iEMD+YidzYXP3FzqYW2l2C+cC9QdU8al4IeUAl
	 c7/Uq7PXZzw1sszzafT0fcAzWrwkfFAp4x/nyQ7qkveNuBkMOYZLB+9tpcUfxq5vqm
	 z23x1KKjFxA0lRCZSNrsHzKgSEIc6qkjKYO3vlN4X1m2mAI8GHARdJQDTKSK/2G6zi
	 EgGKm28Tw+7ijg0gURYlIBeMAWaIvpSWO06qVg0WlWF72YdMf5wwMf57si/RAKBj2w
	 SyTgc+rFAwt/w==
Date: Sun, 18 Oct 2026 13:40:48 +0100
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
Subject: Re: [PATCH net-next v2 08/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 scheduler resource configuration
Message-ID: <20261018124048.GF503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-8-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-8-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:14AM -0700, Luo Jie wrote:
> The PPE scheduler resources, such as queues and scheduler nodes, are
> assigned per PPE port, followed by one reserved resource entry. IPQ5424 has
> fewer PPE ports than IPQ9574, so its reserved resource is located at a
> different position. Add the dedicated scheduler resource configuration for
> IPQ5424.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

