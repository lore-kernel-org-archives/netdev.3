Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6E3A7F60;
	Mon,  8 Jun 2026 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951413; cv=none; b=gAAaAAa3UJ6J57AOhA5lf5IDZshdn2rNHlGXJS9Iym97dSL0WME95DHKp+aNPPobz3apfpVGpkP+HovmAoissI8gvoS/muOeue2h+b3I8Q0nFKL+OCkmJUi2xq334ipxz+/jYXPsqTbeTtLwf3RyvydTeBM6OHVkDi+OgqBM7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951413; c=relaxed/simple;
	bh=vueSCk2akjfvJsJv7/CGWOpyHGC9hJSqhSPkj+AcqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0AcQeysOK3tWG5CsfOFnjExXpnljm574CjelJfgjIH2njnAq5IgYyiBbNVbrgAkS1VesYWd2/5LXsnW31KARGsn0RlYBzqGwJF59SK5dVBB3gYn5s/+id++wLxwNVyZ6VGk3F/+DDGiLTkgCh7lHsLgCGjYYcoeM5n/T7RFr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ9f6Nfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ9f6Nfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F21F00893;
	Mon,  8 Jun 2026 20:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951411;
	bh=I6gi1LMk5ag+dHcrN953C0y5GiXFrJ6Zx5j8gSs0/JA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OZ9f6NfrsrzICvhEhc/Nd3yhIUf3b88Im+bu9ZoSqPINgscU9vtk/Fy+iHdh7AiWV
	 dIqGGT6o9gJMnMR1NRwzBGcD9mhczIqttSTWfcT5/DwXyFIF9hDl0z/+kCdJrsNVdX
	 fjINxYX2MaSbaBIlCTH1hkmoCRE+/4s3QotbJGt9ae2PWYcgwYPQdiLu38XyhzFviv
	 C5+G6Z4cWggTpZFr1Noa9VaIMoedTQaFjSMpt9uLvgginU1U21Pf+hrEhf+NOZ7ZDp
	 zfbovKq04ohfTsqmlKFTb/HBKdfkumyb1zQz+682fiSkNXqlXZZLLOz88okE3eU37J
	 RJKSq7KiPzXLA==
Date: Mon, 8 Jun 2026 13:43:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [PATCH] flow_dissector: fix uninit-value in
 __skb_flow_dissect() for ETH_ADDRS
Message-ID: <20260608134330.40bb1b16@kernel.org>
In-Reply-To: <08433245-f57b-472b-96b4-7db28e1a3ab2@windriver.com>
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
	<08433245-f57b-472b-96b4-7db28e1a3ab2@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 09:30:12 +0800 Zhou, Yun wrote:
> Hi Jakub,
> 
> What is your opinion on this fix method?

This looks good, thanks for pointing out.

Please adjust the commit message explaining the problem, the setup that
triggers it, and problems with the control path approach. 

The comment above the skb_mac_header_was_set() should also say _why_
this is hard to check in the control path, right now they comment
just restates what the code does.

Thanks!
