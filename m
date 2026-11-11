Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355209;
	b=gHC/kNbeL+u1K4aBaoe5cuWS9JWH76h/8Cc9rLoDMXHIC6DsP1yzhHrIqHvjyTErJdak
	 TsqOKIHwZWkB/EVY+wjEbwOvS5B0/l8Y3Sn+3OA8LGum485YvatBhW1z57wFUn4M+4pll
	 +FerdvYFyhxsTPrVu+Lh4+CHDl4Fs9oo3Jz4zdKAwvCpug13BLgSXdcT3SjTdomPg7MgK
	 Eo4rB5K68cbJR4TRPN+AISXA+f8IwNFjU5Kfx5l4hL7UsABLHbZOhJ8KQDmv4iSL2+8+f
	 wLbQBWToyx3uDhqpBD/YXX+CrD8jm/Je7jVSKsg2GgtZxUgIQuIN6QxGQJ+eyoVOK+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QSpwGXhGSu9GwpUhbiCm4VqL2IDJL098Jo53HpHhDjU=;
	b=SJOOfTc05rtt6rxZrOIBEy3LeluEaSHiS1HePP31NoToYvCQ54aYsKZJgkFxwq6RTfVp
	 3DmucBKxx01e2hcMdq6jsRSRLEKFhVJ0hrxjeldcADMnBaS/JIMwAZtqr8DEZaZykppWV
	 oS7PnV9pJbQ9wPJ1SC23hTTugMskZd/7NKjE/0JhGOWLYfrRIXwTd4e6FX2efcVGDiESh
	 14ppfVWOaxolnmkIxkAJ9GBOYy3EArvq0CPwTc1ldwSeWfW1lbNIYd3KbVpWiur80eRj5
	 c5L9j9K/N7gqVou8uysrX3lLy7E5dAdwL4c9SMvYY3WdvXLfhhtx2ist/x7u2NojNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsfTgenu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C78606A337
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsfTgenu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE71F00A00;
	Wed, 11 Nov 2026 00:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355209;
	bh=QSpwGXhGSu9GwpUhbiCm4VqL2IDJL098Jo53HpHhDjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dsfTgenu2qJOr0UuJilwVRhFYtUsD/FgrVVR+DsEHhjJDtF8kZV6xQ0RTByTT6ZxX
	 sgWsSQD89mG2O+XDUzqbhBReyhIO2oibN7Bssx3GjnJceqqgPz84Csg8w5Jf860HIb
	 iIPpsDVh1dmWEy89TlmX84HFSBxEk5k161ALLlyxY/CD1Y/D/SrmVqsGR+3Nue6WDc
	 uXWAnPhvsjikOcPMTqG69wOkeRcuN3gnnCA77fuUagiaU3rderDbhSjFC2EuN5QJha
	 TY8ePXJWYpRE1wEBZpAOtsfXSrRMZ6rRUhP2vKwJq1/PgDnqqABslofAKjrO6/to+5
	 EWUvn6MNFuZiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1A039E8A4C;
	Wed, 11 Nov 2026 00:00:09 +0000 (UTC)
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
Subject: Re: [PATCH net] fou: gue: check IP version of held packets for direct
 IP
 encapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435520792.125436.7731047249946664944.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:07 +0000
References: <20261106195615.2498766-1-edumazet@kernel.org>
In-Reply-To: <20261106195615.2498766-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 20:56:15 +0100 you wrote:
> For GUE version 0, gue_gro_receive() compares the base GUE header and
> its optional fields with every held packet. For GUE version 1 (direct
> IP encapsulation), it skips this comparison and selects the next GRO
> handler only from the IP version of the incoming packet.
> 
> A held version 0 GUE packet from the same outer flow therefore stays
> eligible. For example, a GUE/IPv4/UDP packet can be aggregated with a
> direct IPv4/TCP packet, and inet_gro_receive() then parses the held
> packet's GUE header as an IPv4 header.
> 
> [...]

Here is the summary with links:
  - [net] fou: gue: check IP version of held packets for direct IP encapsulation
    https://git.kernel.org/netdev/net/c/c59f004734a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


