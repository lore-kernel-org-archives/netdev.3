Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176513;
	b=SlhsA4tfzZasP/UMHInRWbNkfgsoaYg2mD/7n5tLSL+hZcNqR6pNJiq5X/1jgQbrkolV
	 8AgnHAMEVopq/LhpsaOGsk4piXsyoW9qhdwjAeZ+4U1U+0I/6ivE8I319uwnMjGYbHwKP
	 mTa6lqmim5bIhF+BNdo/RLFod348oR9JkMt0BXjYF4RoRTxA41qZ+4CQpahUr1gEaFw4z
	 HiuTZq0qbYKhw4a6aEOpFeM2fQqLv0u1jSjeu8O0U9I/97XFRnU7/HUt/pDMux40M/qQ5
	 yBQjxSHy6Ou01x7a/3UOsvIOHCxHE3ZMoLVwuQdCOLHWt4Pur4jYv+5VZZ99qKhjv+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176513;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
	b=Qzqpv6WQljlNrwqXXvDp2QpI2/zt5kgewWaalrOTahsuVVZrbVJ6l8fLdwvUHgLBkYqm
	 nevRY+p1RtLCJDraRBOcZlt4SpRihUrs7z/T1fy2Oo7XLPCgR/2ecPHgQVKL9L2lsLaXb
	 rLVtqKypcx/3RsyYj0ENteAJpMlU+OwOJ21kI1U9if9TxzDC/iqCuYA8JqTB90tK4jj4u
	 BUEx6YI9IwEWd1TUStNCjKe/VB9YtXOvEfsyIC44PdGLw9CgsCzbTM7QWx7mlmJzcRRfq
	 kvtmSQidLZg1Sexawou9Di/cKi8yOmh0dfrf7mr6kHthUwBkmE2xY/6E9DJ0qXOnQEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=bdhdNk62;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B06606A329
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B06606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=bdhdNk62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793176510; x=1793435710;
	bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bdhdNk62ShXcE4vfNoNpelK+ePMQ7CaeyV9eENrdPR7raYWPe7iazd3Di02s/Rwck
	 b8oDPiduOF1fk9apXdjblHLtfefgMij3/LKYqykyjUACePLRyxlkQ7ZczxskF91HZf
	 /aigJxFx2xq9tpG6Htrh//zd156buw1eDgjWJQ1GqPTjJN4YL9nhImvKp0u92X3Zm6
	 nf2y4XlehouLCG2BoFtBJIY3Zhsaxjk5iQMxHogCQihKd0KlQ9Rzy7kTtSg8BhrnXV
	 X7N/xuO19JCHKFjzxSShghF0PweHvCwYW+03Ma2/k9fuqVKQJxROpC8crnZ+PH/h3g
	 Vn7mt6xE5zOxA==
Date: Wed, 28 Oct 2026 08:35:03 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, maciej.fijalkowski@intel.com, andre.guedes@intel.com, aleksandr.loktionov@intel.com, avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 1/2] igc: only strip RX timestamp header from first buffer
Message-ID: <20261028083344.3047350-2-p@1g4.org>
In-Reply-To: <20261028083344.3047350-1-p@1g4.org>
References: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 751edead275447b3dfb11a0c783ab0a93eaecd8f
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

igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring->skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@=
aweta.nl/
Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe..41b293dc1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (!skb &&
+=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
--=20
2.56.GIT

