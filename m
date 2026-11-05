Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882406;
	b=N1uIpyCq2PBEILvGAVA0x+6J5Kl5A2dTcbblsaj58OHVyzchuqIMhfRlEFT+YhD8W/Zb
	 8a0mNMlGQrXkjhrQF3S1v93UNTLPtcrHfoF9KUjFL68SpDUDq7yOtmbvs7VLgyIB5LQfH
	 2nXyoCH39Uvn8XnzWykn2g7EjoWq4LNBUkGBqh1xEFmOcNOB+lZsvWc64Iky6B9dfh3h4
	 sz/XBgFHHIAfPoadgm+dP2lqKaIM7KZqpZw4hO3W3OMM+zj1StPzag8fbEBfuoEjWcGvQ
	 VPoPCNktdvHwRmDXlmPP5ymm5IpXk1Cpy5BtDm2v7Oaha6XTGKDxIb8nqVU68KAdVgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ggkopqItGY8IY2kJQiFDy8KtuGlk0599MjF+YJjjJOQ=;
	b=i2pnm3qsa/ihS5WWgEOb3G78W2rLWsgVQrry6Cd/QPm6D16cwogXCcAJd3oFM/NRDXwE
	 nlNL+JMWCxy2bwRq0bC+k3+KaIzhPR76qq4pWxjtBUpELzgnJ0PiinLfXAf2PQTwHzTUe
	 i0CmYgO+fs3EGO1WSDvzQY9FPl/YIHxaA4wXO8fxqQp/PfHZeQWGfFVmnUatTNXCGrzMM
	 CQ2M84DjBAXJ9UXtToV3832xUVBi6d2wnU8Ohz6mqw/E+aG7MaIVoyxCHCdz2ZioSOO1n
	 H3W7FN7Efx5MoQWQ2iqtZW8Pbx4qP3gHoPdAB4okzRywb60uDjOwWx35FcJvaThD6Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZ6Xr33Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D89606A31B;
	Thu,  5 Nov 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZ6Xr33Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8011F000C1;
	Thu,  5 Nov 2026 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882406;
	bh=ggkopqItGY8IY2kJQiFDy8KtuGlk0599MjF+YJjjJOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eZ6Xr33ZBMohmIlRhxObLBdEO6PqRXBvgpqeF5nUO5EU2gy5Vy2WEhART2mo9SvhR
	 aXOgxjfAs5CPYo2xfWLB6K5YGIeZyOX08NobqH1NNPcueh7I5nPTJNkSoCaPclz6Se
	 uy3gRUdy5aDnTW2jgHtVMSYs/SLHYNbf/ycr+7Fv95tFpu1YEf7woz0eH2S8RxxO0T
	 jGYttMVZrMkkNoiEoml6ulyv9MYUVz7D/e/r/sky4aOea/OSk0S08N+9wMzg8sNRBb
	 inOMMlYZ8wR1zcprNExV0rqvMruzOYudF2T/H+gs4XCIxpdiKEfk0h5WezQJzS9mrI
	 mHS122uQv/UeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030EB391AFF8;
	Thu,  5 Nov 2026 12:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ppp: remove SC_MUST_COMP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388240480.3671757.14531262162704521616.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 12:40:04 +0000
References: <20261103015615.2704-1-qingfang.deng@linux.dev>
In-Reply-To: <20261103015615.2704-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tristan@talencesecurity.com, norbert@doyensec.com, akpm@osdl.org,
 paulus@ozlabs.org, Matt_Domsch@dell.com, Brice.Goglin@ens-lyon.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 09:56:11 +0800 you wrote:
> SC_MUST_COMP accidentally shares the same value with SC_DC_ERROR.
> PPPIOCGFLAGS combines configuration flags with transmit and receive
> state, so userspace cannot distinguish them, and a read-modify-write
> sequence can promote a decompression error into SC_MUST_COMP.
> 
> With SC_MUST_COMP set, intentional or not, a fatal decompression error
> (SC_DC_FERROR) causes the receive path to silently drop the failed
> packet before delivering it to userspace. pppd therefore cannot detect
> the error and reset the compressor's state. Subsequent incoming IP and
> CCP packets hit the same check and are also dropped, preventing normal
> recovery.
> 
> [...]

Here is the summary with links:
  - [net,v2] ppp: remove SC_MUST_COMP
    https://git.kernel.org/netdev/net-next/c/4bca33ba24db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


