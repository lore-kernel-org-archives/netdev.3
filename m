Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547405;
	b=V2vM5XyIK/byR762juzvb/ehNhc/nDBkQbl5iPt56y5CUQevhiiIOJqQbcn10uzfRBZU
	 +h43C+nYtzbod4XQxw0yXZwMoBmNc1waWUuGs5TnreyreGUtCNxDb+oh/P/2OAf+PqDGj
	 Y6O2oV+PTBYtuxE7IQD25e+0qUKj8RNXOTeKY0w9vR7xmJ/Dp2n4Jgmf1D1TZz7oKEUU+
	 NYxT1UqPPf7FcNPvhi8JGY61iiIr5Sp0fDc37dBUzraUjWXcCxyOnh2lYVVhUE83nWHrt
	 DijG2Vf8jfkVW84YvkYtQgg2057sc8YMgAVWGQLOtx3sjVXD1HDvf/7QOFcY0GngCKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547405;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4rGPNIS7k+HjEH9fso4aa6clONgPF4t/gVhB+HuArRI=;
	b=mwKZtlDILEZzwl3cz8FHTGMFZRaz+/qzf3jm3UVlDk5+DFxaBG1Q4lrUSFO2MTC91Qem
	 txxSh+d1oYqC128onwJKZDO3mUhlPCa2hSlsDZeVpf+WDkkbj7/1XzJnzyXw1ciuracay
	 MT470hG8SSv1iJByJBfRbTFJgOLd4LAJjkyoYKsoJAA+KO5MiK5PHkJzK6CALkFylSyO7
	 K4tLKfB6b07eBV8GusE/QDbKl7p08/c4EXN8BJQ+Yp/3u3IFSDd/NpwxHzMPoIXdPLT7H
	 cu3vb8QkHdOPome0X7znWuWNXIxhr0vPqRiuX7qTnJgJ3mULMc2ngWD2EQGA9WjJrbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VpIqQZzl;
	arc=none smtp.remote-ip=95.215.58.204
Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7C606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VpIqQZzl
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w3qwkLhOQVDClh5xUZDW/DKElp3fojVEAwIDOdthKrU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792547401; v=1; x=1793152201;
 b=VpIqQZzlxE2wpvWXlefmmHZ9eIJ3TA3oXA5WF9Jtmf7Iobv0Bt1X2dIh3f2Af8tx/0KD+7TI
 0zzRH04OOGc2xBDS1boIVqC0/k4NHlPqJDeC1c/7UV6JL1g4+4jrU4dcKShUndrIR25YPlzP6An
 /6L3EgbRuNy6JNH+zBMdUE+k=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0c4f03327ff3cea0;
	Wed, 21 Oct 2026 01:50:01 +0000
X-Mizu-Trace-ID: 0c4f03327ff3cea0
X-Migadu-Flow: FLOW_OUT
Date: Wed, 21 Oct 2026 09:49:53 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev <netdev@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [ANN] stmmac enters the Netdev CI
Message-ID: <atgaQZiiuMDC6wiv@fedora>
References: <bdc75e18-8ae7-4056-8f43-dc280a3414f5@bootlin.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdc75e18-8ae7-4056-8f43-dc280a3414f5@bootlin.com>

Hi Maxime,
On Tue, Oct 20, 2026 at 11:07:16AM +0200, Maxime Chevallier wrote:
> Hi everyone,
> 
> It's my pleasure to inform you that the stmmac driver now has a runner
> that feeds into the Netdev CI. It runs in a lab I maintain, and the results
> are hosted by Bootlin, accessible here :
> 
> https://netdevci.bootlin.com/stmmac/results.json
> 
> What that means is that now contributions will be subject to CI
> validation, by having the kernel selftests run on real hardware.
> 
> Results are already aggregated in the patchwork contest, and can also
> be found here :
> 
> https://netdev.bots.linux.dev/devices.html
> https://netdev.bots.linux.dev/status.html

Thanks for your update!

> 
> As stmmac is an off-the-shelf IP from Synopsys and is integrated in a lot
> of different platforms out there, the CI currently runs on 9 different
> boards that include the following SoCs :
> 
>  - Starfive JH7110, riscV, dwmac 5.20 (rgmii-id w/ YT8531 PHY)
>  - LoongSon 2K0300, Loongarch, dwmac 3.70a (rgmii-id w/ YT8531 PHY)
>  - Amlogic S905X, arm64, dwmac 3.70a (rgmii-txid w/ RTL8211F PHY)
>  - Rockchip RK3566, arm64, dwmac4.20a (rgmii-id w/ RTL8211F PHY)
>  - Altera AgileX5, arm64, dwxgmac 2.10 (rgmii-id w/ KSZ9031 PHY)
>  - Altera cycloneV, arm, dwmac 3.70a (rgmii-id w/ KSZ9031 PHY)
>  - ST stm32mp157a, arm, dwmac 4.20a (rgmii-id </ RTL8211F PHY)
>  - Allwinner A20, arm, dwmac1000 (rgmii-id w/ RTL8211E PHY)
>  - Allwinner H2+, arm, Allwinner specific version (mii w/ internal PHY)


I’m curious about how our lab is maintained. Do we stick to a single distro
across all machines, or reinstall systems periodically? And how are
reinstalls done, manually or via BMC?

Also, do we run all selftests via virtme-ng or docker? Does virtme-ng support
all the architectures?

Thanks
Hangbin
