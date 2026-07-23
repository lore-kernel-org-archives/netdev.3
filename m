Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8306331ED0
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816409; cv=none; b=pn+nKeWfKpjsXfCN8zarVyTglQpbaJD0LfNQUZrp9zNEtf3SrJHEQNaaYnG995lmvUGEvRc+GA75HpEtZJ3a06u/qyE1ql5xXE1BYaPs23HDyRHJbHX9BGczzVBTxCL1nTrkTwFiVvYOMG+2aJrfuGRnH2gVSwfCnawGbEr67aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816409; c=relaxed/simple;
	bh=7hIh9+OlkeDdLjMV6UuJCxpjLcTvn1XVANetH/IbmA8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNVgWfWTr0hlPxpiU3/N0N5qtzqffkv/fN+HIGWG+B/MQfNSWtVc72oWD1t29xtl088rubygboN1oKoS4K2GEaVLQdCM1eNcKXTNQOyem/+o3y2qqOLu4ouEIAeP13XQglueS2Nvo6Qgen0ZClQNfeL5AdALGksU0n5bnXRUloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LBqzyMqz; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LBqzyMqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784816397; x=1785075597;
	bh=7hIh9+OlkeDdLjMV6UuJCxpjLcTvn1XVANetH/IbmA8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LBqzyMqzdRnlaH09tN+aIknZQMe/1Er68UF4qTknc4wkj1ivoGbLCs0QgSsKuNF5V
	 TyjsweVICv38DdXtVVCv2Ste8h+6X0m8o4t09P+bpWAbZFmdlVXX1FZCQBtgDglFzL
	 UxiJOJ+NqS6iXhA4cBj3LE1O2YMiKBsixdP1qvQ1lWsZxEaGfYTnaEI4iVm4y5bHBB
	 cpVp2J5I0pwAtJrQDriP0sa6dvwEIpWB5VxAWfBf1i8QwhsX0BAXv+BNkbQJKk1HJi
	 kHbHPZCqbIs6Lhx3mQk+9VUucxIW90MsKUIDHUVsKEldQyFH/ThD+TtYNcqifu69kh
	 As3jyS67Kp3bg==
Date: Thu, 23 Jul 2026 14:19:52 +0000
To: Alex Elder <elder@ieee.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] net: ipa: Add IPA v5.1 data
Message-ID: <f01671e5-9185-406f-bbfb-b514201f257a@proton.me>
In-Reply-To: <b810c574-0f60-4d3d-ad5a-4205a119fe00@ieee.org>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <20260622-sm8450-ipa-v1-3-532f0299f96e@proton.me> <b810c574-0f60-4d3d-ad5a-4205a119fe00@ieee.org>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: dbfcab0f484828c77c17fe31c6d57729b5fcd9e6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/8/26 5:35 PM, Esteban Urrutia wrote:
> While cross-referencing IPA data files upstream, I found these two
> regions to be present in data for IPA v5.5, even though they aren't
> defined in ipa_5_5_mem_part. At the start I assumed these were correct
> since they were present upstream, but I took a closer look at that file
> and I believe data for this version was directly added without going
> through a proper review process.
>=20
> The reason why I used IPA v5.5 memory regions in IPA v5.1 is because
> their memory partitions are identical.
>=20
> Now, with this information, I would like to ask whether both of these
> memory regions are correct for both IPA v5.1 and v5.5 data files.
Any update on this?

Regards,
Esteban

