Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185B4E9C24
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779603; cv=none; b=t9i23oz2na26TCQKyudYgPwlFadvUDSkj+3ey+IRmrCeWsmYX/cQ1OWMYXw9ZssuDKzD0O5vIAafAyw1jyiCsO/xi/rLHzxYq5/GLFzVB2tRElwO6bWETKderPdPprfGCT2NhaXt2akv/jqBE6bmAYAvCuoVPdW37gkvdqn7l4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779603; c=relaxed/simple;
	bh=DCAHREkaN7ATO33xggTvPkRc+Lqr0UcH/w7mai3dQHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdHDK2LU65dDjUmcCtRbmLrasdTnkEtUYOrQfwopRJkIw/VgTCz1Dr5K4YRRHJvPZKn7l5q5GLJg9hHAPrwJd7PiJ9nV1c2273c1dbdcSEjk+LalnJ1/FCMp0IHbcaKadnHhFuaFbI9xQZAaWq1SWvEuf5WFQvArt+9yoMK+ST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=Al+E7FRX; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="Al+E7FRX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=6KQ80bAqdkgYRgyc1g8ERSxxYHxzJvPYa7a68Tuq18E=; b=Al+E7FRXlxkAS8ZbN70HELBt1I
	FbE/pf8qbyzpk63XYosR5dZqxjD7FhT5TEiEzjKgkkG7Wu6EnGgPkjzNqOq7mAx06K/SFXAoRn8NP
	50uBRUMytHMKpSNrlQ81hK1UrGftS6WjtOsIeE/nGI17N3SI2CmrZmLTvIVY5EDewDApTPPvZH7QT
	qln7kyN/5bPT3xnbr2jNWiJHN82WXOQxkWfHJ2SdSA8qFyl18y/9cxnw8Ze1/amKUhvU6JyoVYalp
	fUN9zMVQ1Kv77V9OyPyqkar0Jt9AhHeuak+CpMyWByWOcEgiSch+jtDo/mZIWVDh7mfREyMQiiL/b
	b+WfOr9Q==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZp-00000005QLT-0s7y;
	Wed, 30 Sep 2026 16:46:30 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH ipsec 0/7] xfrm: fix ESP IV generation and ESN authentication
Date: Wed, 30 Sep 2026 14:45:17 +0000
Message-ID: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

This series fixes nonce reuse in AES-GCM and ESN authentication errors
in the IPv4 and IPv6 ESP offload paths:
* 1/7 and 2/7: Save the current sequence number before incrementing it,
               so that GCM IV construction prevents nonce reuse,
* 3/7: Use the current sequence for software AAD and hardware offload,
* 4/7: Give each early GSO segment a private secpath,
* 5/7: Use the packet sequence directly for mlx5 IV generation,
* 6/7: Segment untrusted GSO packets before allocating sequence numbers,
* 7/7: Keep the sequence counter unchanged after full ESN overflow.

Note that triggering the bug fixed by 7/7 is impractical: it requires
processing about 2^64 packets under a single key. Yet, I still believe
it's cleaner to fix it.

On the crypto side, as a reminder, reusing a nonce under the same GCM
key is catastrophic for security: it exposes the XOR of the plaintexts
and can reveal GCM authentication key, which opens the possibilty for
an adversary to forge ciphertexts without recovering the AES key.

This series combines and extends these two individual reports:
* https://lore.kernel.org/all/20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr/
* https://lore.kernel.org/all/20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr/

Recent discussion with Sabrina Dubroca may also be of interest:
https://lore.kernel.org/all/c443bad568f4e03d05b848b1b245707d@oss.cyber.gouv.fr/T/#u

Regards,
Jérémy

---

Jérémy Jean (7):
  xfrm: esp6: use the current sequence number for the IV
  xfrm: esp4: use the current sequence number for the IV
  xfrm: esp: use the current sequence number for AAD and offload
  xfrm: prevent AES-GCM nonce reuse after early GSO
  net/mlx5e: Use the packet sequence number for the IPsec IV
  xfrm: segment untrusted GSO packets before sequence allocation
  xfrm: leave the sequence counter unchanged on ESN overflow

 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       | 12 +-----------
 net/ipv4/esp4.c                                    | 13 ++++---------
 net/ipv4/esp4_offload.c                            |  7 +++++--
 net/ipv6/esp6.c                                    | 13 ++++---------
 net/ipv6/esp6_offload.c                            |  7 +++++--
 net/xfrm/xfrm_output.c                             | 14 ++++++++++++--
 net/xfrm/xfrm_replay.c                             |  1 -
 7 files changed, 31 insertions(+), 36 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.47.3

