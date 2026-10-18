Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FC497B9C;
	Sun, 18 Oct 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327217; cv=none; b=S4Y4YLyGpgC3opRimh++AHu7lRTZWIxjJtccL+xHSGb3q84JGvz+5qguDP/pQj2cZqP6JAoBJh3QOqY/7jyWwIWR6A6qFh87O/z8OU/NKYsXBjlEuu4MOP5E2hGTuyoZUCSBD5Or5FcLD46pedc66ebQ4BLqUr1WIubvI7aFDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327217; c=relaxed/simple;
	bh=MUhAKyqWnoNcB5Dgu2eJxwotpqvahPIs6yQCems1j4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbnHKeq4cEZo3AFKBbcJaFNgeW3ue/0AYz3Sdg+iccNK0mHQl08giq4yX1euc/OmNJ1Bd0wcvuKBsCVznQwRkJnat/QLVtXLvtdLR6xNa2nNclFHjvB39zgeooW9ObEh9iEmE0FhdiAw1Va/PifLtPx+fMYuKmuJ7OolmtUo8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feq66ipm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feq66ipm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D7F1F000C6;
	Sun, 18 Oct 2026 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327214;
	bh=gUjkH/uip5eRqsW2SlMWuQ1WxScm8r5x0YzC+QwtUBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=feq66ipm9B8i1WZhjprq2uiuhc2Nj+scfWYTn6J7I0Y+5owueebrrhOwQHPBKk8H4
	 ATlWmhWZkQxb+k1Ardge1G2bPPZPblAPpXj1Y+ZmRIBXS6/hvMpqPvx01FM3xDpxk9
	 ooYSiH4rwVKNQg0f+JbNenpDR07mQByJLbYfBQJIeTI7uE3kgMd3aDF4DEbF40GbrV
	 4meIP0/9bg7cyLMEMuiDZJi2qpif4Z7we1BaM2Q3SiFi9nXtCtNpTjtS84/UXH0hf+
	 Gy0ZKJcawVCjL/Sj64lWcPfG2+AzBvBtmFfqOadwToxeMd12fLBBChqo6ui82RRPmz
	 H6IB4Yd90t0xw==
Date: Sun, 18 Oct 2026 13:40:08 +0100
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
Subject: Re: [PATCH net-next v2 06/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 BM buffer configuration
Message-ID: <20261018124008.GD503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-6-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-6-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:12AM -0700, Luo Jie wrote:
> IPQ5424 has fewer PPE ports than IPQ9574, so it requires a different buffer
> configuration per port, and more buffers are left for the shared buffer
> pool. IPQ5424 also has more BM ports than IPQ9574, 19 versus 15, so some BM
> register tables have more entries on IPQ5424, and some of them are located
> at different addresses.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

