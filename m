Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347191;
	b=L5L3QwHzoupw/RO4U3MqMfpRWqO9HuHfh8opqe2qFR0fLeJk80GvzyADxtDpQQY2oXkb
	 UV6TDleGKzONTUhcvN3qT8K0qCAoosg4EkJtLlzvo2YM7x44MrFQn82bv/JR4Akpwljkk
	 VmfCLv8wj/6507qI5mK5sec6+IIv/ZcRiSr2dTEvt3kILS3VcjlwVKztfV7zWjLoKkjEO
	 2Q/rzEfZgRawOZI0XeV18TKqL5l6aKxiGuYlvmaX0Ba+Mp6/LVAF0JWctfp5HlH8WJ1cp
	 49P36yZvPoFkA1LBNel8XzHNTjQcy/HvwGzZ1/OEK5cmnqeg/nmdrgRitdwQuxPM8CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6FZ7eMvY8oN74+MoaJPVq5/MbdbF04OhfLtGkmr49Z0=;
	b=RsUrA3+Aut4GIkS1lkNSVrPh7kioaRvcLrPIcJhbSQ0sRvKjiAnagEWxDKSSj/LXjhPR
	 1ncoFndY5voEHSYiJdDGFDMZj1RdCu2L0SDiaX0G1+vgLbMPv57YwvUyj54ebuXyscqjF
	 YJOuCd+X2ibe6PwquP3sy8k3hK+ZOxYRoRu7FvKw5b4HvhDVCrhFwWoRwaOvOI8u05qBe
	 5QcE4xeCePUVlf+AnOO6KAs53s4OYRWqR8vLCbRxYaQVtno0Bi4hJ8XkuRJyQ8LTnPSDK
	 uuL7/yAjEQqugeSotOYKr+jxFAnTihtWPLWpXAw8ZsBdnwytbXrelPMDnEoVMAdfLwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUqyUj+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08C606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUqyUj+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187421F0089F;
	Tue, 10 Nov 2026 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347191;
	bh=6FZ7eMvY8oN74+MoaJPVq5/MbdbF04OhfLtGkmr49Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MUqyUj+XAOmJA0DB6k9wwJtpYOH4qg5dpRdkEF1RIq7AXOSu7uLxSsykMtjRinp+K
	 zPrYRmSem8BuUFuWMep8T7UqIpP+qm4awJayMLrWLxur3EZ5PbNO0+hKqwQ/bbxHd7
	 jNU13vYAi44xxCSNlL7vYgauUDBt88dOuQ4+Mhek/R8xLQGzbYknBjidS77BOB853k
	 WRbxal+QFO2uB8sW/CviqICDjo5GtAaFh3Mx8sM7kTecv69kNA1ZIbMSxiItm4G7JG
	 fQvm027ZpYfbEK7meBOcU/AHnEeWVqwwW7BPefSaNmGLtMZyqeZrTI3hGd7S8tIosv
	 jlltheLc8eaTQ==
Date: Tue, 10 Nov 2026 13:46:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?dGVuY2VudG9zX3NlY3VyZQ==?=(=?UTF-8?B?VGVuY2VudE9T5a6J5YWo?=
 =?UTF-8?B?5YWs5YWx6YKu566x?=)" <tencentos_secure@tencent.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steffen Klassert <klassert@kernel.org>, steffen.klassert@secunet.com, Eric
 Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net v2 2/2] net/ipv4: reject appends with negative
 fragment copy
Message-ID: <20261110134630.13c5af31@kernel.org>
In-Reply-To: <306E09760B4212AC+ipv4.6d58afc075934322860394a26ceaa2e8.2@tencent.com>
References: <ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
	<306E09760B4212AC+ipv4.6d58afc075934322860394a26ceaa2e8.2@tencent.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Nov 2026 15:34:36 +0800
tencentos_secure(TencentOS=E5=AE=89=E5=85=A8=E5=85=AC=E5=85=B1=E9=82=AE=E7=
=AE=B1) wrote:
> __ip_append_data() caps datalen at maxfraglen - fragheaderlen when more
> fragments are needed, and later computes

This series was incorrectly formatted, please rebase and repost.
