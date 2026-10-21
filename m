Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622867;
	b=zOkBpH9vnaVPNhyWnixDqiWYm8/Kb+cWVmjBXiugjAperljTEpScUcj2OU6JMs+Fkwr6
	 sq7Nt+NquV/1y2xUtUOHReXowe1xRiLatNgYRJjxr9pWkYHXPkk4iCkW8Zw5Tl53ZQ5Wm
	 kVps7iamOHSqHF+WjzOfGzJJuC9k7r61DsmnJuM4Q0lgpmwTfmhMalCSsPf4kTuLZ4anc
	 gxRewkrKKeGMwKM/YRK46JFejzRyRAbY4UWCfWbqNerApMzQC3VSBLGncD4oiRirnR6To
	 /OAOmdpRd/uoFJo3Ljms/gzc6kXzEP6QOfbLz+OxJVYwP799qmU9N8vO4X38/fQH1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622867;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z17GSdCX2AVlDCVfP3oFeK5ugdwfseV89dBX+YdznSQ=;
	b=aqearF2v05CJC0hOLtRl11uCmjeJosG31enaH8PCwaGWKK5QJ+45zTjzsDzY2kwxT/Un
	 v0C/vtos8NyCmbo/5x3mNyTmos0NpT71cQYG3PHmC2ZZasaA8fE/Xuv3olD4QfTClTUth
	 qVOclxNbdAOUZE6DtGLfdGKZvYVFjPA54di7iTkOeWJP+577XICJATHhnNvYujmdW8jzS
	 UeUi9JYW91UIVJFb54LwboCF5G2vhYLPKSU9i2dBf1NSsQZNodyjEJopi5ItwxtCbQFur
	 obPDWnEyBgwr0dF3l3FDZvlzTTWHv4muw48l83HRW6/kmnS7HWjEO6KC23m4SQzMMGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=185.70.43.99
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E7606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F34E7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792622858; x=1792882058;
	bh=Z17GSdCX2AVlDCVfP3oFeK5ugdwfseV89dBX+YdznSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DI3LSXNuFBeE+EcHbvnsjHBo8gZt6ugvDQytWrBZVkbgOGdRxORikB3zRDw+oNftr
	 u0D3oWNP7Gk2ry71jQKu64RfMCwvslOO6Yc9zegYEjuamADjECcfcDZWDdBAc2Kcmx
	 Kshv8zl30rLHUabLo8GtqRt5X5BYdLDnEcLGG13A95hqqwTwiC38PYfC+VvZQYaMVt
	 zSQTyt11yESyt0lr2Bj8IlvfEe/JNt2Bm1ZrkQzkb2sQgddGf+Nw9H9hzlRkdCjIQb
	 G7xF1stddMB/CeewcQBQ5hUgWfVnMCcRg8q8QAFLUoyUvpnVVFE/F7OBggeUu+jn9Q
	 /T75YrFJ7lN4g==
Date: Wed, 21 Oct 2026 22:47:33 +0000
To: netdev@vger.kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com
From: Paul Moses <p@1g4.org>
Cc: sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Paul Moses <p@1g4.org>
Subject: [PATCH net] xsk: restore UMEM flags after failed pool assignment
Message-ID: <20261021224705.2078753-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ecd6710c2687fda68e398888edecd953935d89d0
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
Content-Transfer-Encoding: quoted-printable

xp_assign_dev() sets XDP_UMEM_SG_FLAG before checking whether the
device supports multibuffer zero-copy. If assignment fails, xsk_bind()
destroys the pool but retains the registered UMEM. A subsequent bind
without XDP_USE_SG inherits the stale flag.

The flag also changes RX buffer sizing after DMA mapping. On igc, a
failed SG bind followed by a non-SG retry with 4096-byte chunks and
1792 bytes of headroom passes admission with 2048 bytes, but programs
a 1024-byte RX buffer. On I225-V hardware, an ordinary 1514-byte frame
is truncated to 1024 bytes or 1008 with RX timestamps enabled.
Restoring the original flags eliminates the truncation in both cases.

Save the UMEM flags before assignment and restore them on failure.

Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing ume=
m")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/xdp/xsk_buff_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 0ebd4d46f7ab..7750d2ec4ee2 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -166,6 +166,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 {
 =09u32 needed =3D netdev->mtu + ETH_PAD_LEN;
 =09u32 segs =3D netdev->xdp_zc_max_segs;
+=09u8 umem_flags =3D pool->umem->flags;
 =09bool mbuf =3D flags & XDP_USE_SG;
 =09bool force_zc, force_copy;
 =09struct netdev_bpf bpf;
@@ -268,6 +269,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 =09if (!force_zc)
 =09=09err =3D 0; /* fallback to copy mode */
 =09if (err) {
+=09=09pool->umem->flags =3D umem_flags;
 =09=09xsk_clear_pool_at_qid(netdev, queue_id);
 =09=09hlist_del(&pool->dev_node);
 =09=09pool->netdev =3D NULL;

--=20
2.56.GIT


