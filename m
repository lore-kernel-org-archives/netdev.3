Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940F38838F;
	Fri,  9 Oct 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564457; cv=none; b=LUtb16vFUv6s/HkkLBOGTN1wzUx62bptNxSgXm4aC6A3k6tYu+An8rADaEutmjlxxA1fhnFOOTGpID6zJMx2xOxW7PoKf2mZMjytb+C0K50RDe7xv8jushj1tYcnI/DOFarIWdcJ4XdCR+JWYkCBq4km36E5kD5ONPBNOTTBDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564457; c=relaxed/simple;
	bh=s5cEuLdlN+PPlUwWQ58v32ncF+mLLnHpBX7/MXR94xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWWqSjeqc4rt3Y3GJ+l4Qlhmdw/F5bSyXll9/FquBzKSyXhQCFHtpBaOtusUpA3/g86o8aYYbZiIl+sky/SlYYh1uZkBuLptVJdAN/5UFIaw8e/Oezf+/pck1cltJZQclHAFYur+ocAbrE2IeIttDqy4ZS9hmllKMDv2Wic5rqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9R1Lm9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9R1Lm9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2D01F000FF;
	Fri,  9 Oct 2026 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791564456;
	bh=0ZIVHrCq1ew1FhPHwVQ9oRt+nrgfNIPMv41G3Ez5E8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R9R1Lm9suYUdjdSJxedpskqK6Qp7LUiKN6/eWE+TKp9Gyq7W4VE54LjMdYqXDt48Q
	 DI+t26WB+/NsZBF+RAZF574+LbR6ha78Hl+n2NW6sEa9wqcVC3/MfFa9tvIvqpYqys
	 QxEVh3y+Mq+wLV1/mBiaHkHfEZQxvS6fTGZMZD67fIsjAk8T28Qasdk8JvR/4vuuSf
	 M8X3QhvWiTygJlbqbqpWebiyp+PMd4qdV/R9zOzTMaN+dmUzXle00yfFjqAD5wCvbV
	 VF1HXxChauwkK5NMXA8J22dQes3AvdKlB0xYT69W+N6Ic90NwCqs54hsI0+4JZKJon
	 9BYN1S/90wexw==
Date: Fri, 9 Oct 2026 17:47:32 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ag71xx: align the IP header behind DSA tags
Message-ID: <20261009164732.GG83879@horms.kernel.org>
References: <20261007174449.671416-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007174449.671416-1-rosenp@gmail.com>

On Wed, Oct 07, 2026 at 10:44:49AM -0700, Rosen Penev wrote:
> The receive buffer offset includes NET_IP_ALIGN to get the IP header
> aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
> switches whose tag sits in front of the EtherType, which moves the IP
> header by another 2 bytes. Every access to the IP and TCP headers then
> traps and gets emulated by the unaligned access handler, around 6 times
> per forwarded frame.
> 
> Take the headroom needed by the DSA tagger into account when choosing
> the offset.
> 
> TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:
> 
>                        before   after
>   routed up               743     855
>   routed down             660     749
>   local receive           554     572
> 
> The unaligned instruction counter no longer moves while forwarding.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Unfortunately this patch did not apply cleanly to net-next at the time it
was posted, so our CI did not run.

Please rebase and repost.

-- 
pw-bot: changes-requested
