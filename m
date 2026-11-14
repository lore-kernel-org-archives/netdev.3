Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615737;
	b=T/CgPVDyIP4JpGU03AwW2rdaV3BpiSkYrtxXH7enUGaTbLA/xRW088oXoYd1xH8TctcU
	 MvDcQ7yx88Ht+qq6m8Kp8kiIkclBUegqWMkpIqzl9U1gTxzcSNwF2+5+7020EGj9cfEn9
	 s7o6xxcsEi25/rgTyl11T9LffW+dw4qovg6wOZaoiVeaYgYEYWjXWc/NmuyYMJJgYg7cz
	 VSOGq6fDKLOr7DNWS7d6adnQyEneGIoqX+qvb5r2hHx4zCkApaLVPU6Ni0NJa3C2jnT4e
	 fcWjHi1+dYeNFB06y6b+NqtgD1Eexrea44jFTTlnQSnIb40HalbVgGQ+o0B3fkeyDcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615737;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=TfSMsxzEv6Kf+dgjZS07LNkCPWXnoDJlWL3tkXED0ZIqVXuxLJV2/B+/XIzKAJFXD3rl
	 f+tNMWPye+m4fLIAfPuJopFKswa/QoSslQzMMotvQsh6JB9W6+5gSOrH7g2DXMNk5D4Ip
	 EJvb3NynEJJ1skT/MPKOdxaESciehYn1tr+3sfbzI3MyL+e2FdMq7ASYuwmgA3/2XWfML
	 ZRe6WnHg05jc5EL09YN4eTZNHpMZke5s2p2BdNzJCKD3lhEZl4VDsOiyh/bAEiZPM5+mp
	 oTUxcnsIjS1BukSW+Q2oDffOvEx3+O77sa4Rg6ZCS8I8UdqFJ5VksR70BK2pDyNpKpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N97ElCaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF202606A333;
	Sat, 14 Nov 2026 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N97ElCaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7841E1F000C4;
	Sat, 14 Nov 2026 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615737;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N97ElCaZ18uG92IjVfYrXBblFU9aIYDF8KKtN22kDx36OdOITRm5VfjGhB7FhYoPz
	 YBF1A54C19ostQzREksQNdAf+lj8VQ+ACy7pKzdrKlRFWREG2vd0d4u+MzVK5YodJ8
	 uXHj1yfjmmhEs1uRLUTCSMVeQZW5EOFEZ/9Ap5PRcPI3i5ba86J9NzfuxdliVp+ZYz
	 VP0WYYFcQWB1QrTIbLyy6FGb/fxFX6EVGHI5GTMNfmuGUiFrrdEqF3n1Fo7P3IHttw
	 UFj6Bj2dsyiQ3xxluOETQzEmyJUMupPwEir4iyjps9vPgq8eUgYxfHKWwfDzvA7xbz
	 Iq+TEa216kMxg==
From: netdev-bot+sinfo@kernel.org
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>,
 Mason Chang <mason-cw.chang@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/3] net: ethernet: mtk_eth_soc: 9K jumbo
 frame support
Date: Sat, 14 Nov 2026 00:22:15 +0000
Message-ID: <179461573593.2168702.7673153146325668469@kernel.org>
In-Reply-To: <patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com>
References: <patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
