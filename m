Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D447404E
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254759; cv=none; b=YOe/dDvhEp/t9HUhBPiFurA8WblAhrn9ZnMYN18/nxaxlHMkf/fjGWH8CGY868KzGeVxo2I7xO6oAShb0Fe831NZqsMC4vwO8faoL0wONqCbk9fyixOohcrTfyeOFwgNG2GBsD59g741fD1tYn/OBqOkeADVIV9ijxnBcFJpWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254759; c=relaxed/simple;
	bh=0fT6rotIYPXaJfFRR9BY4IZqOqibKN6fA6EuB5IgRac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCbbuWooU404krRYUljErxcanJGapj60Gc4FGYIIcp2yjQpME76X/MJ4eZtrMhfBKawVoCie0XcWfDoGheGCWDximpYiUCZvj+ib4CI3rB0Ek6jChNa9kUgSJYkGWaS3a4ZMXJFJJ1vG6sYfvNH7Jw7QC0ArGwkRD3xq2/rKLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6UuWDjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6UuWDjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A71F000C4;
	Sat, 17 Oct 2026 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254757;
	bh=0fT6rotIYPXaJfFRR9BY4IZqOqibKN6fA6EuB5IgRac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J6UuWDjfHhcKZClSy7+U5sMp5kEd2dmFXLx4jWd1Il5ApAvESCJe6eVoil0dL5LF8
	 W2K/9NrRO8rw4EJ/TfkGpDpvlNZcr8HVOtBiAxhXFQc9v4h/siXQQRJ+XKs/x5SAPC
	 bCECEpXnIy7biUmamFhmLmXJ+Jyh54gkCyIyVg8p87HLoAfALRtn9M6v0VeQ+RZbVi
	 Of21zUa/5MQjyYAuon807/t/VWPOBFhBnQI1MqOENZzNJCHF3HcgnweEOM3mltHmo3
	 l3BxZE8e1JKMNZolH7jH2Tra72B+WRK51wZrvZw9TQhIciTzspZcx3WaN9KVh0t9yd
	 talHKR4Dgb2BQ==
Date: Sat, 17 Oct 2026 09:32:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
 root@tr0jan.top
Subject: Re: [PATCH net v10 0/3] rxrpc: fix encap_rcv skb accounting
 exhaustion
Message-ID: <20261017093236.06eeb96c@kernel.org>
In-Reply-To: <cover.1792168462.git.zihanx@nebusec.ai>
References: <cover.1792168462.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 19:59:50 +0000 Zihan Xi wrote:
> Hi Linux kernel maintainers,

coccicheck says:

net/rxrpc/oob.c:281:21-25: Unneeded variable: "type". Return "RXRPC_OOB_CHALLENGE" on line 295

Please don't CC netdev@ on v11, linux-afs@ is enough.
