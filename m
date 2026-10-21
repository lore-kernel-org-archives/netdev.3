Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552812;
	b=iEtWAYeSw+bQdiU0T1FBpxcYyv+xoa1Ejc37P/diicbKheIOiXi3pe1CE6shbgZXAyFg
	 bh3vk6HDHcK/T09j2gLuDmUcBxS13w/mgThoapL+tQSV7J06jIGdwFnEsDCKvmc7msKa8
	 L+dRHIpxLwp7D6XvYfRmbTD09wNNLRzJfmgYtnC4F1rFYjKyLYk65ZUiOJQcRWlGa+VOW
	 f5PX0LvVewUjDihQkGGN4K55IbdBBvvXGPruHyymbc7G6nJyQ5Kp8D/nicCt+Xmx3d8UT
	 Kqxoyr94rJfQy/fddIThJu5uMjRt/4ym9KAZs4zwnUR2fWUvdZtnK4lQUI0/y1WT+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=F2Oc7khxb+E6t9bMc0xmax1ac45aTuhJuRXGIAiptdA=;
	b=Lsabfr/3zjzUzcvZMqCRmzBcXDxtU7JGX4RNqoPYaW7MpqeL1iIRPSDOv1JMv862uNNr
	 IZemNVP0iN50rtKf+TTj7015Zs5NFB0fEazBM6X/Fkq5sDXdxhP29aDOeOBAn8J9Gu1xV
	 1kUZ5PpMrxbsdfPYHOHxM7VJ0AescEQAkZYMDVneR/+1BhxXApTamVIarAeiHEO7zfJUX
	 4NMN/hy7iiXE3YXtbToe4+0hG941C0xfYPmTXxUYtqrDFWKtI8/UVcXuroWgQhDKTMWNL
	 MicWUqXHOOz5IpXIWIGb2MiRtuAZep771qDJQwUbcoSCehvB+KSrYOW9kfnuhLPA6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxSkiJ4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2339606A928
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxSkiJ4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DC81F000C9;
	Wed, 21 Oct 2026 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552812;
	bh=F2Oc7khxb+E6t9bMc0xmax1ac45aTuhJuRXGIAiptdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MxSkiJ4WBzm+e81dISLz+L0NPUozbSWyRSzH/hqfL3DijnNl4l0/WaoWJmMB7QQKS
	 oYY4sNSJ1q4PRgCg9v0LAHGDEr9BCbxU0w+VAE7i/AqICfwTxjg6g4nL1QfYvCyC3t
	 CZxFliOlmMA0a96Z4JThhuR0SJ5zxMrIBB9PeuVa4V2oH1a4g0KPiLSbOsxSPH0RBQ
	 iHQMi/Ho92/7GhbEVgswy6vRslffdN40E6M9MYECdpQy2dMErAEx/J+rIOyEXFqW2I
	 j+oc8J2/aq7OcZQBMZCeO7rVMp2YDjZZQMxp4ncx9osaU+xdYn8EsGO5vgAdoT+syJ
	 gCjxlwHANwRlQ==
Date: Tue, 20 Oct 2026 20:20:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, edumazet@kernel.org, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
 rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com
Subject: Re: [PATCH net-next v3 13/15] ice: represent RSS LUTs as devlink
 resources
Message-ID: <20261020202010.3fe24696@kernel.org>
In-Reply-To: <20261015185454.6332-14-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
	<20261015185454.6332-14-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 20:51:24 +0200 Przemek Kitszel wrote:
> +	if (!take) {
> +undo_res_take:
> +		int rel_err;
> +

Not sure if this is valid C but it definitely trips up sparse.
Var decl are not code, jump to code.
-- 
pw-bot: cr
