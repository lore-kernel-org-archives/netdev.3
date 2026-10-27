Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125903;
	b=qpym3YYM5Cw67bXpO4fByb0s4ZLzX04HV6ukfi7M+UsppzF8J88Go65hGfZ9ZEhtxPDu
	 Q+PbsnYKjLlgfvBnOREnmjiWTZPhWXZNT4K5iRmUEEaUyOY5qc95JxC8xWV1vqSZ3gKIs
	 ups9f+Num1C7S4HjuS0/L9Xstv5+r2/+YPpA/4pyrp/W0wNOXkgi6ZHmW+WQcK+Ogkz1m
	 Pw2idunBTZfrYCY5fVeAgyqzmULN4hl3SrEDJX3aSRtAJknjfD6o8DcZGdeBPS2T7KeLI
	 97NXxCVVuEuo0C82XVYnYxXk5OOmJzVgjNhJnhVIjpX+Hry5QUg7VfwA8C5qsyRmaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125903;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jwVMYqATmMoi+MfU2NzwBtahzJeExlYAhj124bRfpQQ=;
	b=u+w8hFdT/9cpfBxX1AenH/TXGzKI60bTpqZPdZDXL/bcOggADrB5eXJl1rvbTTVJvZLg
	 gY6tzpKgH7Y5m6Rv9U5dCJK5dLWGFJNNim+JarktEILkrgnaZvL9kcOPU4Z9boEsc3oek
	 tRmIO51M+AWs47mcLiXapStB+ypID5uPUYMAfbv24t3QBaUVVekgDdvq67VE/lR95yFey
	 /mU42foGp0A+uGxzjq4fKtM7TZo0KyZ/z5o/1MQI5vwVBrh1yw329OCE8u98JFXSHqz94
	 1in6U4VFAl8a90dB7nLZI7AkNOGjtpY+DMdpZC2/cMW6XQtNYhKnxCqxHMvHalr+fhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtOJEvqY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B6606A336;
	Tue, 27 Oct 2026 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtOJEvqY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA31F031E1;
	Tue, 27 Oct 2026 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125903;
	bh=jwVMYqATmMoi+MfU2NzwBtahzJeExlYAhj124bRfpQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtOJEvqYrmf4Gv3UUj4FUc1RKQOAxGc7QrR8+1C1H1aKLA19ft2ieBfxRDtSAiEpn
	 kiL6ortvW8eU/9nAcAGvFFt5MgbzfiQB/xlqVgMSqGnxtf3vQPOeFqGONlo+hgljzJ
	 CCsqczZ09+ye4LnWxoyU9d9DXwPJKQr4lZGOFMG2IXerAVFeqNP8pXSxIG85VwRRT+
	 ksPN5+6lhWv7XsC/C9cpj+Lv2EecXKSQY/aHrhCC+sf4APC4qngySz1DRCzPlUwo1e
	 BaCcjc7JUexHnEw0K5Q6iPfsNP+9GM8pHsl4eoBpUo/tVFgNTkbvtvm8n8fBHbgStw
	 sgZznyV1gpaJQ==
Date: Tue, 27 Oct 2026 19:31:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: rockchip: Add RK3572 CRU
Message-ID: <20261027-amiable-dazzling-kelpie-cef3ab@quoll>
References: <20261027-add-board-ok3572-c-clk-v4-0-d4152b4fedaa@qq.com>
 <20261027-add-board-ok3572-c-clk-v4-1-d4152b4fedaa@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-add-board-ok3572-c-clk-v4-1-d4152b4fedaa@qq.com>

On Tue, Oct 27, 2026 at 06:04:28PM +0800, Cunhao Lu wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK3572 CRU uses the PMU0 GRF for the AUPLL reference mux.
> Describe the controller and define its clock and reset IDs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 
> - Documented the xin24m input.
> - Made the PMU0 GRF phandle required.
> - Updated the example.
> - Closed the reset ID gap while preserving each named reset's register
>   mapping.
> - Removed CLK_NR_CLKS from the clock binding.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Same comments as in other places. I probably responded to older version.

Best regards,
Krzysztof

