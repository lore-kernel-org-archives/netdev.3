Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44172E7631;
	Thu,  3 Sep 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402083; cv=none; b=i7PgaYvStNmZX7p2SJmx0N8rpUDDdYzyPkeVKURQiDqyVaYa91iDNs0Rf7qdmRlfKBjn9VZtHW+dqYSGKTjF3LyJTiZQiEvHdLyYqSohhwjaM0Pv6wyfdTAZDixu+yIcWSK0k2q8aa4+cFjdq02O8KMvN5aBVgE/2esJtAxwHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402083; c=relaxed/simple;
	bh=0snNFNPJZeBH0dNv10jDWDoEvqSIo74+5h1V6qx1dTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fH/FlX/MxbhRKnUJJxV2oyBWeNgZoPxSKfEPpepmddHiYtLzHmYtGDqGqK3i+nk0rbSaf1WHD/FyCiSMuccSc0AiC7qmmVKWfBhCl53Kp9fuXixLm4Tz1DqtURagnzR3OyewHIJbx3Iktz+Gi/Fmnn1ymv87GpAmdQ+NCSeIrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSKZh/fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSKZh/fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773331F000E9;
	Thu,  3 Sep 2026 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402082;
	bh=IBYrmRb5vv5AtfBrpzpdgjcJluKkzhoEEMla6JWlj8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NSKZh/fUqVSqzG0vdhN+x9wVHVpm202fcK0c6KSEtjgEH+iSAfrw4gX4ntBkcnd5h
	 KLOIrpN0m8Y4iUENDiVW0hhgghSqJbD5ktbhDe3WpjVbmPKyguXmZvQi6rRJ6h0uaF
	 ApHxXDUO6DQo+fgjWTnL37R3jDT3wmZEy41f26ABuK3FuRDrXHYAnXYurnwRX9Vx2a
	 NPIwTo+Py+bhEp+Mf5RUeioSBiTXykwYwj0wz2fvFh/DkqjOfRko5lGew0A52HAJLL
	 F+N1i4nTR7U5rQ+0CY17E+uuc2DCs/Vntp5bHsSsPl50qIXq1n8bpEOunNepqWvR2L
	 xb42jwbd3QKnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569333927056;
	Thu,  3 Sep 2026 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] net: dsa: mt7530: modernise register
 access
 and add two DSA ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840202389.3047971.6055175026951986778.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:20:23 +0000
References: <cover.1788190568.git.daniel@makrotopia.org>
In-Reply-To: <cover.1788190568.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 16:37:43 +0100 you wrote:
> The mt7530 driver carries its own register accessors that predate the
> regmap conversion and now largely duplicate what regmap already
> provides, including locking. Most of this series removes that layer.
> 
> It first moves the MDIO bus locking into the switch regmap via
> .lock/.unlock callbacks, matching the PCS regmaps, so any path reaching
> the regmap is serialised automatically. With the wrappers no longer
> adding locking, the thin mt7530_mii_* indirection is folded away and the
> remaining accessors are replaced mechanically with the plain regmap API,
> using the coccinelle semantic patches included in the commit messages.
> The two remaining reset polls are converted to
> regmap_read_poll_timeout() and the then-unused dummy poll machinery is
> dropped. Open-coded register fields are converted to
> FIELD_GET/FIELD_PREP. None of this is intended to change behaviour.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: dsa: mt7530: move MDIO bus locking into regmap
    https://git.kernel.org/netdev/net-next/c/fbf5096f540d
  - [net-next,v5,2/9] net: dsa: mt7530: fold mt7530_mii_write/read into mt7530_write/read
    https://git.kernel.org/netdev/net-next/c/b62351d125ad
  - [net-next,v5,3/9] net: dsa: mt7530: replace mt7530_write with regmap_write
    https://git.kernel.org/netdev/net-next/c/63ba2b758938
  - [net-next,v5,4/9] net: dsa: mt7530: replace mt7530_rmw/set/clear with regmap API
    https://git.kernel.org/netdev/net-next/c/f6692ee8def4
  - [net-next,v5,5/9] net: dsa: mt7530: replace mt7530_read with regmap_read
    https://git.kernel.org/netdev/net-next/c/10d9d8328e8a
  - [net-next,v5,6/9] net: dsa: mt7530: drop the dummy poll machinery
    https://git.kernel.org/netdev/net-next/c/d7110c1dab44
  - [net-next,v5,7/9] net: dsa: mt7530: convert to use field accessor macros
    https://git.kernel.org/netdev/net-next/c/3d8ca6f90475
  - [net-next,v5,8/9] net: dsa: mt7530: implement port_fast_age
    https://git.kernel.org/netdev/net-next/c/e1d532b6b056
  - [net-next,v5,9/9] net: dsa: mt7530: implement port_change_conduit op
    https://git.kernel.org/netdev/net-next/c/e5ed29f15603

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


