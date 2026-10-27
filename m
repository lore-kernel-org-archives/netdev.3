Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117112;
	b=e6qAIY+lDIWMuAKdhVs8bVOhRQy1lruHV0dEprN3RK7QmpZEzA4kSFvbn9t204H2G/XP
	 lYwqOVL0jBikHjm4JUyXcapz6B4nHYmHEgTYz1cuwW1yKndqjZLrWaNcWFl15CWy70ABN
	 4g83mLmdIztHugcJH159Z4yPsIgNZMBtr5ZBzW2faw5vNyE1F/ZQvvrFH+ECtyE59o2e7
	 BUK8MHv99Q4/NhI8RF50YxEfdxMYzRonlcIHgPHMuZ9TsBZK9NFbF5Jn5xzZAyh1fSgZl
	 m43KY9Yw6aOdzxhPlwLT404RCNva6uMnkLD7c+idSFaB7ZYIJHkeUbbrXwdi2MzYntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117112;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
	b=vNfeUbm9NYuOoWK+ib8w0WSX0oaho6SddOgah7r4Gh9wyyh5yWa9zfzyG2im5II9DYIi
	 gLAbpJN6POgg5Z8yNwTpVxOOFFtvTZFB/CLWi0S27LWcv51d+QVai2BFY4s9egi1zrQpC
	 mp+4c8OtMJR06jVuXSlR7VqNcEIXLHQQul2gxs9y/+XT9Lexg/bDMHZC92L/4xQBA3LA4
	 uK7ll8zrJWjXF48dapGu8QxGJOHVYEtRDfIB4XMvXjQFJVmqJ9b9bCcAQR8TDiapjL0Fj
	 gDwgIx2iJhokwNlE+Ywwb7Pc55iogMIeRFwgJVQcvIstvGgrRvawvyGp22fFLjO24/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447E60A2616;
	Tue, 27 Oct 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5447E60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793117104; x=1793376304;
	bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tmpzVkCVtFh8fUl4Zw3KkD/B61mnXrSGU3g1xMp8Bi6peJUc9iZhhdrWzm+Pu4SM3
	 6Kw2lLpVlKLplc5a3WYkYIPp7N1YSo/ImoZzlt649QL6OEsTYG7Jx+t/2wbTP1Y0OS
	 n96sS8bSVk1JKuQTneyTNREkq85X+qYRgg/HljvhJ0MxvuunFvDDtsjaH1CP1EuRYL
	 1qvbLOWo8AAh00ALfFOfQbx7jCZk5KjcVc8gvFlg+BvZRjMipTzxLNRxPN+ZdWBBww
	 v4VlrJfG4pY3hLL6VBc9b+OW/Ib9byNfSneONKg7/btwAX788g06UD9pkJrb1FEbxE
	 cmo5RSTfjHc6w==
Date: Tue, 27 Oct 2026 16:04:55 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: Re: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX timestamps
Message-ID: <i3Glqm96F2TwAGa6takMMBWz5Fe0r5gw23k57lIUGuQSqsiCFRrzCutLPLR09oErj81K8M1EocaXjYXMH0omemFq_0aqO9HSat904_5_c0k=@1g4.org>
In-Reply-To: <179310343105.3134.12907560938189136535@kernel.org>
References: <20261026091549.605810-3-p@1g4.org> <179310343105.3134.12907560938189136535@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5577dc02ccf452cd87aa75f780246daa3d7ea01b
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
Content-Transfer-Encoding: quoted-printable

> [Severity: Low]
> Does this description match the tree this patch applies to?

It needs to be clear that it is affected by that commit.

> - [Medium] igb_tx_csum() still ignores the return value of
>   skb_checksum_help() (igb_main.c:6170, `default:=E2=80=A6

out of scope

> - [High] This problem wasn't introduced by this patch, but
>   ixgbe_xmit_frame_ring() has the same ordering bug this series fixes in=
=E2=80=A6

fixed

> - [Medium] This problem wasn't introduced by this patch, but on the
>   igb_tx_map() failure path, cleanup_tx_tstamp in igb_xmit_frame_ring()=
=E2=80=A6
> - [Medium] This problem wasn't introduced by this patch, but the
>   cleanup_tx_tstamp path in igb_xmit_frame_ring() calls=E2=80=A6

out of scope

No plans for immediate followups, anyone/everyone feel free.


