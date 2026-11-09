Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187281;
	b=fAsrzTd/wy8Fe1a5JWceTZn7SkETByLGCGXn6pwScc+RI+Ja590BWNWG4mxBObl9/ipK
	 3kWwk1S53WBJAp/NX2W0aqh2BK4L5rKoQszn+2Bl3I0n81Ps2NMRaprGkYY/b5uWFtxQd
	 YTu2mPjCRIGCoCwnmVIlirpAYiZoEkyi1QwAhImtOqqkfRww7q18kZLRlEn4ozsfH5Pcu
	 8m1/9pQ0colsxxEH1Hcbfdf3Btt3rA3uNov6jzLP6oS9nYinVG9I9i4KFDKICwP0zCtqw
	 7fFoJziElCwzu5FH+afl4UPDozD/eCKdpLXccZyePRjsdGiqTqsyLbogVy+JAloZINA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sifTHNrNa2DBCU4nC4S+i036dPkRsfarMXgVCAWsh+8=;
	b=kgfehsDzrJmBJRUEX5UP9lbLxRHrLnDb7dGS9P+uujm+3jY31gutbl8kFeC+M85cYlG4
	 J6pFVDDtUUnwqghQjBkWnuxZolvm15SmOYE5xil1WM6GQRP8NSzS3nXQSIegDl6HsnHOo
	 8W7ybDSBKmVhWIabHv2Qo7dJVZ3GTnVN4xGZD5HBbYk5yb6CV1Mml4tAw/56nmFUG/s5N
	 4bT+sKms5/rN4qz3g09Bu8y40b4NV8MhAlerepKW8NhEdv2wVyzP8tlOSXn66c/QVHNh1
	 XrLK0dhxLQdkFRi0MDYYBxV0DyYRwy2a02AXFGKFHHZUg1r9b3yo6cciLtdOptZ9pww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q14AXqh9;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3D606D81E
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D3D606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q14AXqh9
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb628232d2so187571a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794187280; x=1794792080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sifTHNrNa2DBCU4nC4S+i036dPkRsfarMXgVCAWsh+8=;
        b=q14AXqh9xNV12Rolio433oMvftZSMOru0V9VbHpTqATO1pla1rbJVbGuCzwKP1rPOJ
         SXYoTB2Q/P/fJm80nN3G9ii6alzMHnlBRhlSFOkszdL01U2z6XYIZJm0q0IKEJr3PrJy
         dVkFP9qeEC4FZSDSDMB75jBSixndq8U1ABACqQm1nqPby1MztHB70gJuiWBZy6cNFafD
         9wVz5insjz3dKRTOgRpKkIb9Ogal11lQWplcAK2HTlWEwjYgl6uG2nBYQduYu0+vNHQe
         /eIgl+RRGMI1c2H1u/wZMQNrs/f2QBR2CNK84xCTvLENtq1Jv6uAoDtTyduF2BjgWcyf
         iIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187280; x=1794792080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sifTHNrNa2DBCU4nC4S+i036dPkRsfarMXgVCAWsh+8=;
        b=ssc0EWFN5FQnDpuyZTaGdjfZx2duY1ZRqaEwDcEudPxB2uck0oEz7Ru9VIiDfUKrlM
         i5H9MpTtgNwbR6MA2hRIacnB18thGsDooUPBv43otpQW+iCRSHILeWWLrSqZeLEV+Qxc
         QXWW13VgqIqGX1rz4mrYHu2V3/IojOi0nM8wnk5BlX95j6+6xDCmeUvkDI4Ms2NAVZ88
         nHA8W8RseTXa94cmYh4X2QY+duqTQobwm5Rw5yGhKyLjzlb+8uPnuvqZC2MfxidWVWZT
         3LwZB/p8+DMfrVPn2mARHsgyGHcr/tAc+uk8Mahq23zHpMHLdg4ozWkGrL6WkNrXlqao
         Ynog==
X-Gm-Message-State: APuU4Z85bpHfjEXrusShe01hwHhZiMkMVHd7b+sgfFPUYdPcIVSRh/fa
	ZmcciBYx3gq4pyvPlKn8MXRtBOHmddipQmsI/W8f40g7QyJsjFT4brWCFvu5ofnKwWtY/+az3HD
	+g8Es+cw=
X-Gm-Gg: AYBFou1pN0cctILOSrfGeReRK3ju/UkduL4VSQ6bzc0hq8+qkj98UDcMmzFoi9wTFlR
	IP3YuUuvsmN23pXmvS1euV3NUv96O7vvU2BTa+ILN/7O0Vr+DsvdLGOF9qI/BQo9C1CW9D9NDdV
	bylGgD56XC1C5fQh1+8fItQUDTHRDOCz+T/JW5Fi/DfczZydXD+FJZQ1t1dEN7Z9cI0M6HbWk7B
	J3cXtgdEDutflK9FNyXfSbosPafOI14Z1tyuVQcw5vtfqMijmgLxCTx4yR+pmbhqzLDfS6SLmj6
	uq3XUD3myGwjPxZuw+4xu4Pmz58XcXo78XWB7jMefTkJowgy/rxxSRFbDqvWowPKG+OZMyPll8L
	5FgImOT/8AlehzKjuO6bVMlZ5PMBnY80KhrDjHiwLDbM70pSrcNco2yehcDPZ2D9p9O8bLhAmTG
	7mEL35kn6oHLi7NoWJn0IBXb9OoExHWzw+xOM3gNmULCnsKkMkK43/IMtDEet+jac0MtQzxe6qx
	kIeg0Ev0SHpaRQzSOxY/kgRyxaGbBKFvTzGy8t4RcYKO4FNW4yDh/IsZPgDMi/ABN+vttj1oDju
	QF48c/MHXp3MnRxt5IgUujGDjJMqJtPyOXUMAQztsdNRpmvGHaSKYGaaQ/I3duUdpwuJVKdqLod
	6FuwfuAC4pIy2BC2x
X-Received: by 2002:a17:90b:2890:b0:3b0:d0c5:c10e with SMTP id 98e67ed59e1d1-3b12d3cbdf5mr2565235a91.17.1794187280310;
        Sun, 08 Nov 2026 17:21:20 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103432e26sm4883217a91.3.2026.11.08.17.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:21:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrea Parri <parri.andrea@gmail.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] rtnetlink: return EMSGSIZE when first dump entry does not fit
Date: Sun,  8 Nov 2026 17:13:12 -0800
Message-ID: <20261109012115.11898-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109012115.11898-1-stephen@networkplumber.org>
References: <20261109012115.11898-1-stephen@networkplumber.org>
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

If a route entry is too large for the dump skb, the dump is silently
truncated and no error is returned.

For handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE, rtnl_dumpit() drops
-EMSGSIZE and returns skb->len. With an empty skb this is 0, so the
dump ends with NLMSG_DONE and status 0, and the remaining entries are
lost.

The first dump skb is allocated from __netlink_dump_start() while
max_recvmsg_len is still 0, so it is only NLMSG_GOODSIZE. On a 4K page
kernel that is under 4000 bytes, and a 500 way multipath route does not
fit:

  ip link add dummy0 type dummy
  ip link set dummy0 up
  ip route add 198.51.100.0/24 table 100 \
	$(for i in $(seq 500); do echo -n "nexthop dev dummy0 "; done)
  ip route show table 100

The dump prints nothing and exits 0, although "ip route get
198.51.100.1 table 100" still shows the route.

Only ignore -EMSGSIZE when the skb has data, so that an entry which
does not fit in an empty skb reports the error to user space.

Fixes: 5b4b62a169e1 ("rtnetlink: make the "split" NLM_DONE handling generic")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/core/rtnetlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e141340172ce..2777796a4ed2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -7043,7 +7043,10 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	 * Some applications which parse netlink manually depend on this.
 	 */
 	if (cb->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
-		if (err < 0 && err != -EMSGSIZE)
+		/* -EMSGSIZE with nothing in the skb is an error, as returning
+		 * a length of 0 would end the dump as if it was complete.
+		 */
+		if (err < 0 && (err != -EMSGSIZE || !skb->len))
 			return err;
 		if (!err)
 			cb->data = NULL;
-- 
2.53.0

