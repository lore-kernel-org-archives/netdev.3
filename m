Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433C5218A9;
	Tue, 22 Sep 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063459; cv=none; b=oUKtPlVBrrQzwY2T8vVC01XbfXpGc+MSe4d9iXYVtdLY2RmOxgrZFYSVjsC55fCe6qB3maVEkKyWkrNo8PYPjn6GG3uNshxCbv/O25NfBhQJpyoLQ6rJTT58/4NPDkvFrRDdQAx+G/3saMQ+wajULCm0LWpDH0D9rIXrTg0BzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063459; c=relaxed/simple;
	bh=Ehb0qutR8MenPgNu9E+e1P2VW64xTQzLJGfwUv6414k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfQcP4BoX/PtXeK53SSPMeNPjm9WCOifEm4KJV7gUJSn4Z+VOfssRvryZBJqv7gTuRxJWJXHinPuRva7ebUGtZ/hD+r7CLWsN6cBFpBKfHMMiDlX/pdl12pTXohP0tL2A0DPIYLM8ebPRB8mS7qhjRx1zPuU16cpy3YEOKtP2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gjl8kPDH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gjl8kPDH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C0C91D000EA;
	Tue, 22 Sep 2026 03:50:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790063447; x=1790149847; bh=CLTOomVvwyhaIVz87iePe3y/WJq8UrZa/EE
	6k4DqZi0=; b=Gjl8kPDHqaXVFTZhrK0tVPA6mwrn5xeq47RO4UjBfJ/RnjGrtpA
	hw85QrPxDW18yYDS1QuipXOqbGLNEk+EF/7FMEU+m/hEWJWekwG1GHg2S6GHF9X/
	kZiahBaMrcVZIf5Adwh7fRpjLUALEJE2HP08N3n2a8AR9zkTwUtOhJz0PrJWocCK
	gdSVTpvWW0r+HpIdxhCnuX2UpLG4nHRMxTAJNy6JD/y4WXprwTuTdSpZ8vQ57bZL
	cztl9GdxXfK/8wP3kvtZBlhwxVzth/77o92tXRcXWHHbhsXXvcbQLsHeMRs5z0l/
	Z4XrWbO3U0NH5SYZNevEFtnU0GAAAZYAGRQ==
X-ME-Sender: <xms:VjOyamt_9lxJ8XC2idd5jFG2Uk2iNDob6iP-HAPxXdZnYVA4f3XQKQ>
    <xme:VjOyagYYn1mDBK5Ncr9VYB5K6seYdxlMBGVITm8yCRdxCD9OlAN6lEI7ems51RIOK
    YFz2StjKxWHIzvW0THksB0bGaG_CVHDhV4NAWNmxrXekdTyazxs>
X-ME-Received: <xmr:VjOyamDOWvMJg1gG3uvEfDeJ2y_tlc-tF4sWrddw01FAGhG6fAz97ASu>
X-ME-Proxy-Cause: dmFkZTEqOfxk5KetvJAl/TK5VbeQw7ocLoRNt8Rri1qUHaBlUxZAGQ+Wr2dIfLKcHDObO5
    wZZPiDV3wqpb9ppN0GB0lfXmvnh177q6/ouvggY7dc7DaU+OfSaYOXe7ikToQ5D/agkDMn
    ofN0V0CHMLdo9btn7yIe3ajPKQaBY351OamH8O5TvEIHWS6t4SQQnXu9kvPPtPCt7cxlt7
    bfTwnpbxguwVtAoO0l15fULlrtzd3DYllK4TpwVFkWxzTzfVlduMqvzTZEJ3DBAUOAhKKe
    2CCR6Gi5b1oLyO2ICXRbmSpNfjiFqxlh4vOFxYRmg71BkFJW63B3cRpnGRNWyTrDo3i1ap
    IOGBR/YF9/UJA8tCwn64NcVJmx+ED5JiRl6qqkyipAfeGQXsI8JJCu144XbhrcB+KDOJpv
    a44X49XZwTFXdsxPF9g1u5Shux98YUzbkswJbl1BsljjcA/PfZWHGo61xNMO08vv1Ak7/K
    a0tsu3OQlvyV3giFhO4WYT01lQKjy0WkzjjKk/eE8frJTjGWzBDlEZips+cAVC9dQbJKsb
    9IkJ+ZZy+wC+qWehAM6sMwHz2gvP2cnrbgvT2ImZ/ePvjPhyjeLPi2KmlZajE9kKVs3yhB
    z0cDKuUvux74T4UcijR5NNnXFKkdbYY+ef1tUl7PdRk2kjkh1UhHlUsaCXSw
X-ME-Proxy: <xmx:VjOyag_VNcX5tt4cYNx5WPGSQgUHTS56pHWaF2ptoEaaqxwBFiriRQ>
    <xmx:VjOyaqQtMopVxFqOxgKBSB4J35E8Y_XrDFCteoXFP0OJ--vdUoYD_g>
    <xmx:VjOyasWtWq-tZNCegammSUopTWpuJZ6mh55sufgL5w2u6whVyDZjgA>
    <xmx:VjOyasQz_Zwp_bq3R2VfpQVuPFH_6cVsEXNFyIPRtZG5imcP8USZ2Q>
    <xmx:VzOyanyDOrSinpRYdhICu8nsqNhAnCp32XmTOuptyTm6hrKeGz9JOAOi>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 03:50:46 -0400 (EDT)
Date: Tue, 22 Sep 2026 10:50:44 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Stefano Sasso <stesasso@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] vrf: attaching a packet tap to a VRF device corrupts
 skb->csum for packets from L3 ingress devices (Udp6InCsumErrors, packets
 dropped)
Message-ID: <20260922075044.GA2349844@shredder>
References: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>

On Sat, Sep 05, 2026 at 02:59:13PM +0200, Stefano Sasso wrote:
> Naively, the fix looks like it should be to make the accounting symmetric:
> either drop the `skb_postpush_rcsum()` call, since the push/pull pair leaves the
> packet unchanged, or add the matching `skb_postpull_rcsum()` before
> `skb_pull_inline()`. I do not feel qualified to say which is correct, or whether
> there are other callers/paths that rely on the current behaviour, so I am not
> sending a patch.

I believe your analysis is correct. I will test [1]. Drivers that
support CHECKSUM_COMPLETE don't include the checksum of the Ethernet
header in skb->csum.

[1]
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index a0557a3a7026..d4dc6d690a75 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1175,8 +1175,6 @@ static int vrf_prepare_mac_header(struct sk_buff *skb,
 	skb->protocol = eth->h_proto;
 	skb->pkt_type = PACKET_HOST;
 
-	skb_postpush_rcsum(skb, skb->data, ETH_HLEN);
-
 	skb_pull_inline(skb, ETH_HLEN);
 
 	return 0;
