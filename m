Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559367;
	b=4nfq9sqrZR4E3vlKgqRu5n5OzCmDKLhyj+wCj8D6J5r2FtBT74RCEkC9MXcA/SfRPNOp
	 Ndf3zZJG1l0jHyx7wPNUpzdstpd04HRHtBfVKLOw+3ZW596tuYHJmqKno/+1PThe/v/yu
	 Lz/0FKvOdfEPJVQJjkKIkHSt58sLOEJfGU1OAuMNZLGQYG1qfwt8ccItyQuXE6BpBfeq3
	 5XZk8hDyS0gd2BIDUi7BDMQqWYctOEGp0mGRS9UTEh7g919M53HQ3kFIQSYUBmALa6w5i
	 tKOiZtMiGt9wacjwY5fWP2uuk5ANVysbwB8s6gF6huuckWj2AfebnGBZd7V1EArvlJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559367;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=EP2SyCkNlTn8EMVIQYAEgqgA2lFhEBo38MvNL5VS+9g=;
	b=y7X/XAypMcfOmvd0wRKry9KipzldoN6LgzNv9KJHK4FrkpdeLCs/ezbTVaYpzJ2mPLh/
	 PS9kKguQsYcQYASTo0MsF0wpmeVxT80zPt919Q+eX01nHXur0ZcEz4G9U2BcOlo/eo2q8
	 J3S2OlhsKi6QLpiOfkafpHUc4ExcSuB7AAXTlvT3LDNdU5g/7r24SdcrBHH7SNMS4nQQ6
	 RzcRkIJO2B8U+f28kBpH6ditudiadQ34fedibus9V8ZG6h5QAgLPM+afhIoSPS592oT7Q
	 m+PpF+iPz3Xyi46YPuFGYAJhoX4SZ2LyP0qbgtoZqtxxh3vcik1XDEN6xzFTpYEcuDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=idosch.org;
	spf=none smtp.mailfrom=idosch.org;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ffzd8GCp;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90679606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90679606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ffzd8GCp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E17F7A02DC;
	Fri, 13 Nov 2026 03:42:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 03:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794559365; x=
	1794645765; bh=EP2SyCkNlTn8EMVIQYAEgqgA2lFhEBo38MvNL5VS+9g=; b=f
	fzd8GCpjIhf3EfTDnVdBNpRRw3Wn3r7fYYRu0of0fGAhBkwC02tReMVymmJUgsaJ
	LkjgHH/nzaxqPcMU0UvtHc1TYNFAmHIYKmbuG0SsW0mJn01RILaKOZy2v4/AXcn9
	QjvleWdNwYMwU6j0Z84S6bwezbmXxQWHHlSQQ2W6BolAL2puN/a4FXgWiEH3fbA4
	EbXavIUdGyvZNWUt6Xfd36LdryVnqtG9fgjyHP5Mvc7B0h5g+Hojf8O4JM2A5let
	044q6VKRvVGGLbO+IOLqxFx05Czp5bCisECn/gq5KEciJ5Jl5t+SpcqF00cFcM/E
	XBoV5nsOpr3CWdLzLx+kw==
X-ME-Sender: <xms:hM32ah1fDNZu3hVk3NrjI0qN4LZj9fvNKZMysm9Jjg9-dT6ezBubng>
    <xme:hM32agSe5tdDsEDYDL-PQn3FpijTYWcE3vQ527KTw4dhs10ZYJFIMCllbNNmBiyt_
    O9qShfxkMFqgcCThYFruPxXd4AM41yiTPF6G96QOZ0D8tOYncM>
X-ME-Received: <xmr:hM32atehU8xjqZOKeNoIknCQi5mb6AdB3t14LBykUjimVUTTtsMxDQXWB-jLzpDw6WuQewshYX3SoHMBYE92O-4ac6MA7Q>
X-ME-Proxy-Cause: dmFkZTGKyZELgZy1AVXtUKQfDe+LoPY/aNl94huhGjYCLjWEeEX046Z/nLirETcf4jjBv1
    AC40+nzKUDkdEPDgHs3Q0uk0JpSkId4j6Stz/1EZqF5/uZUJo9WdP3F9PHu0V5aPI/tvXa
    6zZ9s3SnvfsM8XGV0Sx+b41vKFEbUYfqljzAAtVeRcOulXEieK3Fdp8fiRYSlCrZQWpYlD
    oTWGWrXsl39z59m0Dnn1UwfWUYcdXGwjZFqzaTLZcHBIv1jGfX7MKyOtpJBBl5koJdgtjl
    5RtGyGc2hYZrmfNWvO2fGd7sfMh639ZTplbP5eUyiOYsWugwLFXa5E7j/dhw34Iya8YEVa
    /Uc3EJLskHaDQq2vq5+xP1M+cXsL5HfVRhqWMM9ok4cFsjNN32XALQUh5BSvlnQcIk69+D
    oBNmylW16wIxaP1WQcM6VebIxiZNoQdmco1oF8VzEaz+IplRq5jMfN21Rkxe7PWFbNYNiN
    40X/LLXCiyy0chAwoyyYcmhVILCgIwB00WJWZIGb3cWsdBWX8Q5BsQR+0ELWZ8Fp70t1HZ
    h6d9/VfRVHsj9Qn35+4M8E8+PAUoZT62JseCrciLFUaSn6EzasB3hPIu/iy9ArcpjL9C4W
    uKoqFdEz7/HeTcVkcpujQwuCMgPkJv1+uTWZRU4gKpn71iaMRkTv0dFs6p4w
X-ME-Proxy: <xmx:hM32apeYrylUGOdmoZvS2oGESznbtdrAg7K8LkKgp8dJ8MUJnmcYFQ>
    <xmx:hM32av3lXRcdoJVK5gdR_427BkdmAoGmVK0ZtItrjbX8utsYcmO5Gg>
    <xmx:hM32ap8NvbEalaSNgSQYTvTbHFrT99Th-Swwoh9rg1ziFzbG9qNp8w>
    <xmx:hM32as7BGsgXGlbusq6e0Gm8abtQKs5GCfwgZJzgDC9uQr6wqlSrgA>
    <xmx:hc32arU-TMNPYfsYResXhBFdt2IU6lSbuz6DhSdUZGipUCrExWS0tpbV>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 03:42:44 -0500 (EST)
Date: Fri, 13 Nov 2026 10:42:40 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	razor@blackwall.org, aahila@google.com
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Message-ID: <20261113084240.GA3595966@shredder>
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <20261111171947.2816258-2-idosch@nvidia.com>
 <avZ07oXIXo7xZyCC@fedora>
 <20261113070732.GC3517282@shredder>
 <avbAFdyJowX8CvOB@fedora>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <avbAFdyJowX8CvOB@fedora>

On Fri, Nov 13, 2026 at 03:45:25PM +0800, Hangbin Liu wrote:
> For a pair of physically connected ports, do you mean two ports connected
> back-to-back on the *same* host? Otherwise I’m not sure how to run the test
> using two physical ports across two different hosts.

Yes, on the same host. That way we can test both the hardware data path
and the software data path (with veth pairs). See
tools/testing/selftests/net/forwarding/README 
