Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436809;
	b=KzgOXJ3Y4EqCp+Re6GGyiFCYR156Ukx01fE3YA4exIhYawVj/SdvsVEmSO/8PQ09PJis
	 vhGEeSbsKSLg5Hj5epmG/hwwVboNJCO4pRswbEO0cxR/m+Celo4sjtEm3ae/6qJRTpbx+
	 y1qdNP0F6V8xfmLoPwPo582Q9aVU3C0Swh2HVkSJdtu4/EbJfugt7LcHxE/PtJ1Ucmfs+
	 LoAJ3uECTiew3wR315++oTW62+n3bp2DBz9tkQuqdKKQJ67ZZXzndHjmRe2oohkEAlrOP
	 VVTDc//jIlyX/rxeB34xUtk/JIDEHBYlkxfJsEQAqMer208zGGk058UreI2LXTLAeQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TEZpFpmffuQgsA7wHSJ9KvqILxRMLO1TQcfZqtrUdh4=;
	b=FbpBzTaR1F9VAEUPSZa2zywtzvXnLJtthHdgqVzoKKGmEswfcZhC/XY8ycrUtkrRfFHv
	 cmajFNH68yFu8dlyDX5Oqqbv1dnnAnCi7HIp1UyNxgJOBBqnBIsQKg4vtCbDsjg9mbB9n
	 UEviJ8IhFQuNa84YKQC2gF6szD5mKvbm45Vz5FMHJ6QueThxvWa910pKmgVkNBVftfOdy
	 94wpGfpKOJUIkjlPz1klzmEmFewj+I+T0hkyjaur1M3/QXwLIJ/rCeb77TSmM0YoDCRjL
	 znj8uizJ/vjVOueR+215P4aN48WMXDrniVZwjuBXPCM/vWbCCdo3eo+GuQPJrO4R4HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIVfpXmh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F40606A321;
	Wed, 11 Nov 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIVfpXmh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C641F00A05;
	Wed, 11 Nov 2026 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436808;
	bh=TEZpFpmffuQgsA7wHSJ9KvqILxRMLO1TQcfZqtrUdh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VIVfpXmhJUD7IubH5EEoQ8qr/rmNnAzCk8A6zI51ixsYfPkrXvpaj6m29W7c5jiGD
	 a0rEC8u8SNRb3D6X+POh5EcgmzUfq/k04uNd5lArAuY9/odZtW6kuLtiQEC6Af04Va
	 fQ+/njH4QOccgDyvlwoYrRBASdIB8QddWoG6BE/yVWytxSKp4InpcZpx+IttPSWLFB
	 KC/ZqZjwBFI4CfjqRgK6QDmjDOlFuWLyXZaKBySjva34fCszKNi/HZU/cEyNeN2eVk
	 PN8kTUOMuN45nj7O1XXOEv2eGZcuCBH5zleaqJX8R8Mi3rhe/igM72TTMTnG4oz118
	 og1BMVfihdU+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81C4391AFAA;
	Wed, 11 Nov 2026 22:40:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/5] net: sparx5: add tc matchall port policer
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443680768.1682529.11013685548418051653.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:40:07 +0000
References: 
 <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
In-Reply-To: 
 <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, robert.marko@sartura.hr,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Nov 2026 14:19:34 +0100 you wrote:
> This series adds offload of tc matchall filters with a police action to
> the ingress port policers of Sparx5 and lan969x, which are both served
> by the sparx5 driver.
> 
> In hardware, each ingress port has four single-rate leaky bucket
> policers. A policer drops the frames that exceed its rate and burst.
> The four policers of a port share the pass and drop statistics counters
> of the port.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: sparx5: Drop redundant POL_ prefix from POL_UPD_INT_CFG
    https://git.kernel.org/netdev/net-next/c/de6c6d0fe1a2
  - [net-next,v3,2/5] net: sparx5: Add registers used by the port policer
    https://git.kernel.org/netdev/net-next/c/08543a66f15a
  - [net-next,v3,3/5] net: sparx5: Track shared tc blocks and per-port policer state
    https://git.kernel.org/netdev/net-next/c/54d7dad1a3bb
  - [net-next,v3,4/5] net: sparx5: Add hardware programming for the port policer
    https://git.kernel.org/netdev/net-next/c/b18f7b93e0f7
  - [net-next,v3,5/5] net: sparx5: Offload tc port policers via matchall
    https://git.kernel.org/netdev/net-next/c/a53151fbbcd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


