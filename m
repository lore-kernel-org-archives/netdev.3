Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFC33FE09;
	Mon,  9 Mar 2026 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090089; cv=none; b=Qmk/ls8+hDXa+v8OpdTbkMx4I2NiH2ftaOZvXs32b1h7NL0ie9mrXWsY/gckf63elXbxeTAptprcLr4krBCoSX2zNOXYZgSOVc1pN0SI8tIiLGL28XLGqvmKtiQdnN1g3Pq3bZv54Vh6qMPGKZ5jdRPnKIalkPUlO973XL7Mmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090089; c=relaxed/simple;
	bh=eWuwbM/YVSHop4C2+irDcn4M6R812zJY3pH6YRcKOH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT+VXPZyznjbd5iisdcu2f8L1oDcFxlmsTbDS/9cODbvAuCd0kF2u+SRAgKGBoqv4GCYiMQAcfe+7qhunyadoDqdZEpW2JuVGf14y+RWps3QQYPDdGq8QH5y0DFwi4gZUXN94XBkI8wXdKds6SbRujgzKpvLXzuguekYXYf/2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN2G6eGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN2G6eGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C6EC4CEF7;
	Mon,  9 Mar 2026 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773090088;
	bh=eWuwbM/YVSHop4C2+irDcn4M6R812zJY3pH6YRcKOH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VN2G6eGhskvUChY8yyvklZoy8uenXvU6kqtOk05QtHv+MEkajT5HOSu8asxDNGnDG
	 y25ZrbP+1xVs7OizRBPv5P08o/nmLnM5UsqARA6zAjz0zGYmqXGU0XTOE3MK3oFC/K
	 /DSLbvgW2GQi3vuVV660EsElmySC2d7cNKeqGpMNwleetgrmX3Fa77actvKxg/sJSH
	 6XrS0xSgLXBw5bJm3pefoPRPpGlH1A7V8phrKK4sigXynaMCiuASEOsAI8v+fYekYn
	 Bc5JK0He9E4VKl7HojpuIIAJ6fVRM48vFnJFLuc0qsOiGirvADuoOqvNA1V6PHRr1L
	 Woi94iVO+RTLQ==
Date: Mon, 9 Mar 2026 14:01:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Felix Fietkau <nbd@nbd.name>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
Message-ID: <20260309140127.465b6ccd@kernel.org>
In-Reply-To: <CALW65jatv71b7G6jpr4g-6j520RjLBDJMH8uta5MPJHmEM1S1g@mail.gmail.com>
References: <20260305013852.3769-1-dqfext@gmail.com>
	<20260306170411.49912ae1@kernel.org>
	<CALW65jatv71b7G6jpr4g-6j520RjLBDJMH8uta5MPJHmEM1S1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Mar 2026 18:46:59 +0800 Qingfang Deng wrote:
> > Please add some selftests.  
> 
> I haven't written a kselftest before. What tests should I include?
> 
> I think I can add a local ppp server and client over veth, and test
> the connection with ping and iperf3.

We have tools/testing/selftests/drivers/net/gro.c and associated Python
test. (note I have ambiguous feelings about adding ppp cases to this
file vs creating a new test, adding Willem to CC maybe he has some
guidance)

The test itself should send and receive raw packets using packet
sockets. That way you can easily inject arbitrary fragmented frames 
on one end and check if they are coalesced correctly on the other.
