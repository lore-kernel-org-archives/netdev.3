Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82787239E9B;
	Mon,  6 Apr 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489777; cv=none; b=urN7rXtavu+5dXMtNMJ1Ph9oUM4aP+kNLFW8dOtlAmrxoPYiWtQSscm6adS8LXFPBmuZMhH1MIESCpoFbhFxnZWTehyjj45KWdayhtOfn450v22/jo5H8UA2jIxLvjE9/pjDzCx3q77NoPelhdhxpRNq816Q1w3FMVmHeOgfuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489777; c=relaxed/simple;
	bh=MYWbB6ymMvRbnKt9cVcsyl0G3Tc+tvo1l3wlz0ADtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ceb3WBgkvRGX1KDfP9wI1ywyIfijvJzd86p4kd97ZRnyV69eRybVqgv2YcCkH5Kqs1ciRj676l8tpS1fheuy8smj5oSzTx3PYHeV/dE6lNJOpcKrzJQVeMRjwJYR+T0ef7oUNHfljjOkwJ5W2U9SR2OMG3wyJJE4GJzEhCIyqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Hb1eBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Hb1eBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD062C4CEF7;
	Mon,  6 Apr 2026 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489777;
	bh=MYWbB6ymMvRbnKt9cVcsyl0G3Tc+tvo1l3wlz0ADtaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2Hb1eBaLtGFJ84/SyNKGJZQS+eGdGzT3pc4X6tkyj5DJfUYRxdzJCCvPhPFUqtld
	 URgAXVgq3PdB8ICXDBfv0RmN4xYk9uO2COgPfmoZkjPMbGwpxY7G1UtWv7gJ3OXMLq
	 SJYwZ79Vy/pZI3ALfl/ffxH29iTUudzc6rH05+1a9Pe/RUp53aoOwypFSMSwPsIB89
	 2CZsK7ujce4jPJUJeat7Ank9YfEPA9UZFir/cGSP8h7prlekDfTyhTL0VoXLWt6NoN
	 +P7TYVKDi6IAc6n0+/577ESDpSROZb593ON8y9C0a6X3EfUjnUc33z7FdEDVhZmQLQ
	 XW8AxD5gRELNA==
Date: Mon, 6 Apr 2026 08:36:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Yiqi Sun <sunyiqixm@gmail.com>, horms@kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in
 icmp_build_probe(): manual merge
Message-ID: <20260406083615.32f44e4f@kernel.org>
In-Reply-To: <c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
	<c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 12:48:28 +0200 Matthieu Baerts wrote:
>  -			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
>  +			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
> + 			/*
> + 			 * If IPv6 identifier lookup is unavailable, silently
> + 			 * discard the request instead of misreporting NO_IF.
> + 			 */
> + 			if (IS_ERR(dev))
> + 				return false;
> + 
>   			dev_hold(dev);
>   			break;

See my reply, AFAIU we can just delete this new check in net-next.
