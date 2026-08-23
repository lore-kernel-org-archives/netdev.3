Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDD3C09E3
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787462465; cv=none; b=tTiW/1fkpg/en/kGKae/WB+oDJr6nD5go0s9xXnpb/rE7sRS6XSdugrPfXz+IPxldONj/N7DCiJwLKrWrEKMUxkT22polo1tn2ytqrbDr5fBmhPJNfWaglIxR7xLUYd6utP+QtbKZJwim829WByQ/GtuHOlwQKpIu6PXHuZQ+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787462465; c=relaxed/simple;
	bh=uzx75yIruzEb185DUmOH1rR07mfiV9w7N+BF9XIajPg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zd+ZslEaEWz1zb6EvRDgSoo9W3WNUPmJQOsLZG3zw6oQ2KKCZPKG5GwvH3Kxn38usAe7onPXYnmL2Qvt7gFEBAfNZD4Ld0aIv3J+2xvMZ4f8l/+i40hXkQo4jr5ACW1eue8BiQnm21JgcUMVhWibWSbm2NhxK2Osy1LIEIJlqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev; spf=pass smtp.mailfrom=dnim.dev; dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b=Hc5DhzbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sb1JxHZa; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dnim.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b="Hc5DhzbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sb1JxHZa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CD161D0007A;
	Sun, 23 Aug 2026 01:21:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Aug 2026 01:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnim.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1787462462; x=1787548862; bh=D3
	yH6p9f7BplkK10K5fg+YQC78g+B3sDvC0OZmlC148=; b=Hc5DhzbTFPdU4v2oyM
	jh7am4AdkD+fq2C5EwLM0lPqj241L5ho4HCPrpiRruQ0stv7h4twYpnF+p1axWCK
	j3ztmcmeXlmTcXLt8BFKHo5utTQNW8BwQAbAYbDQQ3pZ8qOvDYk47iGuC+4wo45/
	b4ihUTmhSFbiaKyD/tBqdK811QSR9EHUIBL0qnEgoFzSNEItUvZoJwhOavjx+8ea
	wVW5D9AEeLqtGRF5GKlOBOSZ9XoEOo/dJQ+qX7cnkoBHtbGpY7QW3Jp0vtSCgJzm
	L5O3C75P+TApUUcty8CDIAq+rofRoBRLLDjKQ2fC8iNsNvfC4hyx9/lFnbDnZFxF
	TkDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787462462; x=1787548862; bh=D3yH6p9f7BplkK10K5fg+YQC78g+
	B3sDvC0OZmlC148=; b=Sb1JxHZacQeqi5NRBGPlVVNGh3ONhU4q/hgzeoWTEKCy
	len94P1m4DSQs8Ca8TyDJQ4Kw7ofTCIzRljqslrNe5zic/VyB/mbev5oIQJYwvYx
	YqtukDNTIPZIhaeQDpvFDedgG4XxL46W8gjewuVFPE15L405zY6a31iZCaRUWPzS
	zJ3uaOS9uaHj7LNTPFtHkeXFLGMDGW/tNiEnYGgefYiGzMyzInC0eveOkIvfFQML
	0AIhg3X4jxJnSiX/6mKiQr6GrGocMP7ZVWRy/osaAE5AWmHO/AYxyPayBPUnWy+P
	6AxQ84WB8/K/Fut2SZ43ePxn18q1Sx4oNYgquTlcqQ==
X-ME-Sender: <xms:PoOKaoAeVMzTjT5acWEBYPXsQKjdUbJd3Bw4bok-_TdSxsaq3Tctww>
    <xme:PoOKatHc6-OyW_QnW8I-54MArU0z0zkCIMez5HL386rzNDnuFV6CQ2lFmmILqsPOM
    ZWwrQUeMIkVoWYmfULhS5WBYz_OnI2ouzcSWAI4ibngciPi1yk0Ep0>
X-ME-Received: <xmr:PoOKavOfmkmxbujww2iFsceekfKbUVSAE53UuNI2LAc-KLeeSbMdepgrEUavmdCBl6L5wmYWSw8MkaSCPgdo9xydQarS9_lfTtczzA8KmKcT797JSXFaApQaRd8g2ddTSGCV15BHGJV3RhY>
X-ME-Proxy-Cause: dmFkZTFPojN2Vz1wRvUmDV6XLM3LWR9PKUC9Vt6vJHGvW0FLdGkcILTszsxyWBVbXcVk7+
    pP5a9hnr5ajOFEtgRUEaSz4iX6dFnh6Wjj86epj6Eh1XtwzUIWjno4+QXlpYhxLFKkRkez
    YtefYNtgghP+Y+Cq58kyJYZE9kCJOmZU8Vxr9rwB1SE5N5ojc4v1438EgmDJmsVSN2Mvqk
    07m4/WZ/kF9PRbAkikInNm6OXgce83ptbiiTfjeAa9BnJKuuQm2JUdBbZ6DHLIKmNKteuZ
    ZYstnQIVVU7phEBpOMATn9E4jZQzI4dAuReN4xr4IKz+sOfJYZwcNT9SrKWB1a0h+oetGy
    jXq1eplzyZr1XiJZp/XRk/jfJV2RiyxZzRudYguz5fM5M7wCLWOJT3AknnJkUhPc1NZ0mO
    U0tT3elrB4/1IRn2F5GEzwHyHZQgviKvNUaDL3c5MnrZKFAXoOXPX+d/kZUgbqiJ+iU5cS
    saaNCzwfaO1R/a/TYY5khx85om9JFTp2JM+crFJCySMCeHEod2RHY87pKx7tmQH6JlNKMB
    Lamu96x3rFT/NETPx6LUL1loi7Vk6JLovc+Xw4noM4NEkrQPclUhbf5wTAF8yJovf9RMDZ
    CSJDcDcChVsCY8vkNc1rDMgwhnc50n3wJMpfA0D4FqJTuN9UzrAHa0skw05g
X-ME-Proxy: <xmx:PoOKau4hG346Ag-GewtLNxoFZ4PhHHUtg2XGTrFC4wa0dxSIGsDIzg>
    <xmx:PoOKaih28T5NN4DE0Fkf658Cm_K1EJXmg0h63F5wAqefBIEEJQYG7Q>
    <xmx:PoOKajf1eGvdW9eAcDzMNtTHCY-gm6bOyJpiKFCfngg4lEkLhDSdrQ>
    <xmx:PoOKaqzOiviGtEZiVY2pXaHY8CVDHHwFy8WBoF3fiE1DZDDDGXY-lA>
    <xmx:PoOKagfcxdEg3ACP5qVGMqDMAjwJBfTv4oNNjIyFuyRnC-xMgdAcY71Q>
Feedback-ID: i14ee4b4c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 01:21:01 -0400 (EDT)
From: JR Lanteigne <root@dnim.dev>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>
Subject:
 [PATCH net] net: fall back to skb_iif for the timestamping pktinfo if_index
Date: Sun, 23 Aug 2026 02:21:00 -0300
Message-ID: <178746246095.3786864.2262454553798466512@dnim.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

put_ts_pktinfo() resolves the interface index of a received packet
from its napi id. The lookup fails on drivers whose napi instances
are not attached to the delivering net_device (e.g. ti cpsw, which
keeps them on an internal dummy device) and on kernels built without
CONFIG_NET_RX_BUSY_POLL, where skb_napi_id() is always 0. In those
cases SCM_TIMESTAMPING_PKTINFO carries if_index 0 and applications
cannot tell which interface produced the hardware timestamp. chronyd,
for example, then ignores valid hardware timestamps.

Fall back to skb->skb_iif, which is set for every received packet.
On aggregated interfaces this reports the aggregating device instead
of the physical one, but only in cases where the napi lookup already
failed and nothing was reported at all.

Fixes: aad9c8c470f2 ("net: add new control message for incoming HW-timestamped packets")
Signed-off-by: JR Lanteigne <root@dnim.dev>
---
A userspace fallback for existing kernels was proposed to chrony
separately.

 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/socket.c b/net/socket.c
--- a/net/socket.c
+++ b/net/socket.c
@@ -900,6 +900,8 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
 			if_index = orig_dev->ifindex;
 		rcu_read_unlock();
 	}
+	if (!if_index)
+		if_index = skb->skb_iif;
 	ts_pktinfo.if_index = if_index;
 
 	ts_pktinfo.pkt_length = skb->len - skb_mac_offset(skb);
