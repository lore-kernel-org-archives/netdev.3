Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004800;
	b=idatX7kCTWr72GiyzTcAzkETi3GxaCp2MkGANnb3ifV06ESHvMk7LsMMvwTvGujgD2qP
	 PXrSlyXPi9wCcYfQygTZYdfHbw+1Evmo3zCJAvjMKijFC6kw19ce0Hf2SOsEaxyTMyriy
	 3Vw7oapyjx2oDj3sIt862ahYx61BHSLQopxQUbrlsssXDdAS2an+xFU/pLZc28K8ItpW8
	 bWZUQBADJaLG/Vb1PFXL5gF3orN3tbxccNo6iz4kUgmu7Po/NFAU6M6fSA9vANskqaoDH
	 Cqyic/J3DNMdcspjOWAVAjMxOMspvZFW9slIWuQCOqR8e6klyQD0D6dJ1mhgGaFAb6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004800;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dZ9QsbA9QwTKvGZBboI7YZTRLZ7fIDnixDLulFlqOr8=;
	b=2yBBQsp5Mw/J9etM3YvmE1zwCQcxUuwFuaEOjBBSNDqluh9U85Osx81nTaHMmefYreHs
	 LLb2QJr85/yGZXk6+fw7Mkfdklfl7jigZDpOXDpncEhvs/E+iYps7cTnNqRs//TMKoWIZ
	 bFx/fOhrB4k5r31TAOB8oLYdCaPqH9fx7z/QiVrYdPGpr+UvbqGM9pEBJocJE6J5Z0jRG
	 lN6xeLyPsCvghYwhPtWLeMULpv30bGKbH8HC5Htk8yzP8zW52MGDiIiAvJYUuZoLSgA6r
	 OLLOqOnVqwkPMkc9w8tiZK1sZKpznPv6kfwcYQ85E9x9kcgsMPJTH7QS347XR7UbnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=C6LmprTf;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 05BF5606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=C6LmprTf
Received: from kero.packetmixer.de (p200300c5973cE5d80Fc8DFe94a24022D.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 97AB3FA006;
	Mon, 26 Oct 2026 09:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dZ9QsbA9QwTKvGZBboI7YZTRLZ7fIDnixDLulFlqOr8=;
	b=C6LmprTfwyC68NDhM8E/qRr//HptQaaAVuJ6CgWwGX2ffJClTuMUpYY9BPVNO1aIM52QU2
	EBr35KMrwdmenQQZkFD+Zspz9hJfB/etIj+XiZkKos2HXHEO5dB3i0rhygAp5zvDQCgKwE
	RqZdoDMpZ6VAQ7e1nOAhf6pVHAR+ywv2IVZLMhOd5HQalu7SvEBe1gXJRhZyHFF3Uijw+B
	GIlUr90vRlT2R1NG0inQYMdTLAWWADv7P0sqMY6PEqSF9ltv0ilIifydCHCNHcYZodrFR7
	/8q+1iTopAbAGMHsFnFA43EjafPuFhYHITKz4oFVJtEo78SEyyANi6LK4PRsLQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/10] pull request: batman-adv 2026-10-26
Date: Mon, 26 Oct 2026 09:52:59 +0100
Message-ID: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here are some bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20261026

for you to fetch changes up to 6e7c45ed237c5cfe10ee121f8c0c8909e7d6e0f8:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-25 08:45:11 +0100)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

- avoid WARN_ON for orig_ifinfo allocation failure, by Deepanshu Kartikey

- close OGM aggregation before transmission, by Chengfeng Ye

The remaining bufixes are authored by Sven Eckelmann:

- tpmeter: fix u32 truncation of reported bytes

- dat: initialize orig_node of unfilled candidate slots

- fix skb leak when hard_iface is being released

- stop originator purge worker before freeing tt

- tt: fix flag and event handling (3 patches)

- tt: limit local table to single TVLV response size

----------------------------------------------------------------
Chengfeng Ye (1):
      batman-adv: Close OGM aggregation before transmission

Deepanshu Kartikey (1):
      batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Sven Eckelmann (8):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: limit local table to single TVLV response size

 net/batman-adv/bat_iv_ogm.c            |   7 +-
 net/batman-adv/distributed-arp-table.c |   1 +
 net/batman-adv/main.c                  |  12 ++-
 net/batman-adv/tp_meter.c              |   2 +-
 net/batman-adv/translation-table.c     | 138 +++++++++++++++++++++------------
 5 files changed, 104 insertions(+), 56 deletions(-)
