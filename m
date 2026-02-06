Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C920E03F;
	Fri,  6 Feb 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344479; cv=none; b=QVMr6V4XUraxiyzvcxqk98okMgbAJ5vleYgys7/ybg4E6AbDAOnvxDq0TdVIS3JRIAM0EF588fRuVtNp3I4/LLWt5Q/njxCON1IDn0gXcI1eIqvbTlASeYyeAKIxCsACSxI+cZNvuBs/sqTCJLXWHdMPEh5Q8JzFqoLiHgTjLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344479; c=relaxed/simple;
	bh=NWtclftR2tKjkY2DohNL8ACvl/uiLNA+wFtIphniKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pM5mCVIP3OoGm0OyT3Z+bSkZ7T8VfQSqeLDACiD8j36xgCygmjgG1kId7ZQ2fUz4om0Cpb2EraPlVCsT28SfQWIdQS1E+GdWZkOU5s0cLIJ9HQPm7D74saGeEK3fNBoLVGawqwXFkMVqyNOHQbcKoT93T4MzSzN3+R7soWDFeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Oc1OrH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Oc1OrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22396C4CEF7;
	Fri,  6 Feb 2026 02:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344479;
	bh=NWtclftR2tKjkY2DohNL8ACvl/uiLNA+wFtIphniKq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0Oc1OrHnBdTl+5k8fj1YlHozVRfcKTLwPOIPkD3ztXbPq6eYNwvPqOMdL+HWFvr4
	 CwFF0dTTUug1j6QssQwi0Fb6FSJ+y6pcVj7llow3Mq9wZ60hJknCuWvpWcpk2zfZRa
	 r+pnxdMixKpflj5hkRg1ZKndgLtp3gOoBKuNfOmygL8fIr77h4gyoioCwzK1OC0FEs
	 OQNVn50g+nE72lge0pp3BAb8o3NRQIYkRORJeWI2WV5IA0VilliWSPMlPNOl1ILk2Z
	 DqZO/8uKSaWEMeuPyFrdlKE6n7CetjtljnCG2W1h9ZpCH9U2HnEtF6QvwtVTxb9ZmB
	 F2ODc4shzOVjA==
Date: Thu, 5 Feb 2026 18:21:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>, Chad
 Monroe <chad@monroe.io>, Cezary Wilmanski <cezary.wilmanski@adtran.com>,
 Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v13 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260205182117.41618f8d@kernel.org>
In-Reply-To: <2da8267175bfe7b8ff92d67ba5aa88755fab1710.1770211259.git.daniel@makrotopia.org>
References: <cover.1770211259.git.daniel@makrotopia.org>
	<2da8267175bfe7b8ff92d67ba5aa88755fab1710.1770211259.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 13:33:19 +0000 Daniel Golle wrote:
> +/* The switch firmware expects all structs to be byte-aligned */
> +#pragma pack(push, 1)

"Byte-aligned" means..? Generally aligned means that it starts
at an address which is multiple of X. All addresses are multiple of 1

We used you push back against blanket __packed because it's forcing
all *host* accesses to also assume that the structures are unaligned.
The best practice is to pack only specific structs which need it
and add compile_assert()s to make sure that the compiler doesn't add
any padding.

There's a couple of AI nitpicks, since I'm already complaining I'll
send these out too..
