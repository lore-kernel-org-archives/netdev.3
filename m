Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442307;
	b=amDZCZwOK3z/7kGqSgO5eBKm2MVxMTs69LP5uzKoXCeMwYtIO5mj8gzQ+9jhncHMkHsR
	 Rs0rgqZ6pboE1AsVcy9wbXJLDh5K92Ud36KL7pE5K/hWxFOCzgsS7WSRGugAiuTSyo0Fj
	 +I5ckBxAmHhIT4fX5jNcQ4+Tr+Jfng9wUG2T/18Cv9TmqvNQAnwsK0TXoefcMKhyow0wC
	 iPnTCxv7n/VliIfkICGPtqFTlkbXlN44QuOfqM6LLo55EYEoIdPh75Tfdo2uWgAFhGZex
	 sNZavaf+KpZHef2W0/DwG66b3mkg6BSPkcWb/20ElXla/IQNVMPkTkCZ8/XFm6ppefA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442307;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8dRLRQqR44E19OnpO3sE/FWQ7JtIz7Y7r09SBm4JBJc=;
	b=232JS7dJXowIkBL2h/OW9fm2nUTxp3qp6F/Nnc1+o/iVQOCSzOgEodED7qsN6NtrVXl6
	 QpeifII8MFgv6C7G/w7lZF7wC+taDgYCGZpd+9z7WW1w8LdQ622STZJPwpf1uNxUocbPT
	 53yiuylLQOVtfkne3M/tRvyMaVFRXeMHa4A7nd5HB0OPThzFnBlCBwCRKz3i9TF3hDrN4
	 w4AlisUnGE8SMtSEA2FbQqB1znWyDV/kB+q3embwhiYYvM4rmfmuc1TKrSV/Q/lJPI/CV
	 n2EeEo2qa8VXf9B6xM/JPinjLEBW5d6BgXt5/8iXM3DODcbAhM7wBwCGdNXs9duON1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxqSfMfu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56F606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxqSfMfu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6361F00A05;
	Thu, 12 Nov 2026 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442307;
	bh=8dRLRQqR44E19OnpO3sE/FWQ7JtIz7Y7r09SBm4JBJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RxqSfMfukXeLNfGh5dIQRUwgdm4eImcr0iMvmsFjmFyKSHvVT8v+jbuArfwWufjYo
	 B5SvXQXFFkZGF1Zc9LOBCHmZM/UFHbjjBwRhHAA+laZiU/933MZG6N1vRO5GLsHPYT
	 jzvNV1WzCLjehJI7syqsdNG7gMEA/E/j6sxtNiwcwosLD21Cg2gJIRwX+25kz7cTLJ
	 D86VfvEBT+5p+k7FnFaovhFxuaymOkOQ+gIJOca8RdoWMCGEEOcL1vU85VsOHHSknF
	 Q6YqT51x0dBX4aM0rU0Jezrb7OIgGY2txoBE76F7jDg4MNhxSQZ899ad7xfkFjHben
	 tEIkFnu9Mo9cQ==
Date: Wed, 11 Nov 2026 16:11:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org, almasrymina@google.com
Subject: Re: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20261111161146.6328f2c7@kernel.org>
In-Reply-To: <20261108201503.85000-3-maciek@machnikowski.net>
References: <20261108201503.85000-1-maciek@machnikowski.net>
	<20261108201503.85000-3-maciek@machnikowski.net>
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

On Sun,  8 Nov 2026 21:15:02 +0100 Maciek Machnikowski wrote:
> +	if (config->flags) {
> +		NL_SET_ERR_MSG_MOD(extack, "Flags are not supported");
> +		return -EINVAL;
> +	}

Why?
