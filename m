Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331771;
	b=OoA6UE4JYkvJUP/tIMKWejpeVAFGPwDXe2J/WlAS4FQ95IMjY6O1PnbGX2XcK9tyjbzS
	 ZNa/lTMfCv8JWOE7ETXWfpMMV8XrKc+jjlVcVrlS2OtYRa5CHl8YeIxfY5CunA7ypp4fl
	 qo3bKvar4EnEPdWofTzzvDM3afWYjgytG4/eSXgNp7FGY9NX+TObJjA7N0LVjBcIC/Xug
	 SyXbccs0HhC/5cxJwEzNghO1B9Mh8ZZlqYqZzb+n8z6u+o+UtD8inebz2DgoA3QWj2+yH
	 mOCDdjPJ0uAdUIol7I/TYDDJ9gWhxp3aDyW6avPfVZLVKVuzvBHuB8bPBUba13tBhTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nKI5lgEMslyS9axTotO7zlQA9nsor0FUSNxjWhbBl1w=;
	b=Y/ygeOmLSvdDYuM3FYWP73WxeTEul0uWekrf2c0lqSEstK2kPTX1/dKRQwcZ7uA3RKim
	 cM7C8IoTvgq+hhbRVnhri7fmU3TmQlTnAKRXH1orwR5ylRgf76/1lCHUta1y3yml8Z9Q3
	 9txVb0CXmrziukSxCGmqloXsyeyxAFgcRMDd48as5HwqqG9iGANpY1MVeBRDY0L08yZTO
	 EgdEM4vG1Ueh8MvpR5/KQxN2L2s9KH9Y7zOF4ECnTpR+eJULnHxbbeYXhDFre5MY/JlLe
	 bxRFW+TpqOTN2NnTvQxj+tsSPfLjyDhaQDK5FSrxCZciTOQ+bjzoI7CsBD0G6QJ6EkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SLFrFIZq;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CE606A330
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1CE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SLFrFIZq
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1650513b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794331770; x=1794936570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKI5lgEMslyS9axTotO7zlQA9nsor0FUSNxjWhbBl1w=;
        b=SLFrFIZqy1ahBNEatTEaWDrPaCcsMr3NbWmPUQW6HYbkKrGO20RJBknYiF2UPj9rE3
         g64SE176my3Y/f+itS36kFTxtf4pmHfAKGYYJ+UZovLn5c6X4kRyqqO/kdJ0mCvKyhbT
         Nd/8JoQDUEO+5JBKgPwBzceTAxWhtnjDCIBJA5BpIlFVVY7tLxs5xT9EHutVo9xzip4U
         9LPPZMgA9PLDo62aNF8m//IkesedhhGstwPnEfeVMIDaAieUnGxO4rTAdcvgRMDRWQJS
         FkRn9nu5C92CzZlM/jxwPAVpxW3n/G68Y75u5ZPC2W3A5GsUsLd6sOfRGV3A4AACjs49
         +8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331770; x=1794936570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKI5lgEMslyS9axTotO7zlQA9nsor0FUSNxjWhbBl1w=;
        b=AylNmveu7FYYE/a38MmcXBmb2iBG8xJ7g+9RvrfyIwYNraz5xpKy7fziD6MBoInil4
         h27ufsb6EjFSWMlboeJDPl2Y86Wn9ggdMYF59B56/8dMzSBuVMpj60qKR5UZrleL/P2a
         6BAdDAExmYF10T+P/w2dptWxGlP40J+b7TCIC+Fm5ClEF5SBboaRWR8v1SKuSEmCLXeW
         e6zC7uKfq60WiFsf2LhL0l/6WBx3Vckz/E+sUuKaeUcjQnLGRQfS2FVJDzNyKkF+kebE
         YOYMc7ky9rHQi3hV/FxrgwIIfe5BkHfcJuiNrfgGKeQ7iI2QOoM+UwUPNCtlnLhFgHnm
         +t0A==
X-Gm-Message-State: APuU4Z/mFb+twEs1L9kxfIWbUporZ68dVDmcQL8ipOkqoUo7uHCd1kEy
	lHVU8wjeQvcrXkZIJvewA1SuTXRnwz0+rL0TrQV+asZ2LtKWhnXDMEJOaQu/ByaCqDRCarU1Nzy
	0U1qqr9Q=
X-Gm-Gg: AYBFou1apb6qgi5N7gBBBC7i0fzsQEyEf1cWOJa6htiewAVcCvbJTyHBNJn8kxenFPR
	6488bYsezqD3srHeC+itEmBZ/TMK+fE+UMYyCusvM70kJI+lNAIn107QEXok25AH29zykKAfqBP
	sjO/wt3KZcqxzldluHJ7BuBZJl7ooWmMD4ddRWRSocxdQT/GodByBdWWQ0dsbDWKbxG4HuPO516
	y12B38HVdq2Xp38MHs56ZzXxMX2C5mCg7XGVwTBesqeNdgRJxhzkMy8PyFKyQWXuk/YgKO7AS1t
	O3RCoMDUUK4AOfNoYyGeHg4bZE7boPmDOQS1SGWkg+BB1TIUJTPLg9wt6TaJjm0PBEDbAWayihS
	YBkbkSOQom5Nt6oPDDXVt/OkAdM+lOdaHIYQzyep7L+hPMCBWSWN3sPdz2qITiOnU/CadQvipjD
	+Q7WDb5Tm5Ey51PSl6uDCKSnMLM5CpD8djxQDn0cOCsb51CN9Tihz7c1IptdsOPmcztdMbpZw6+
	dneuH3d3swI61HT7RFOYwua0vEcUlyw4GaOUej4QZ+wQbGGzWB7AyYEUjkY5jGg1pJ6rVSTvXIZ
	eWjkC66uauo0hOPmLz67Kbhq1YJwEUTf0TmDvZLS8yuhV/o7y32EHP52dkg62x0Q4z5h
X-Received: by 2002:a05:6a00:ab87:b0:878:3783:8a88 with SMTP id d2e1a72fcca58-8ba8b192bdfmr3651602b3a.52.1794331769897;
        Tue, 10 Nov 2026 09:29:29 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab5f1effsm1197939b3a.49.2026.11.10.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:29:29 -0800 (PST)
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
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/3] rtnetlink: return EMSGSIZE when first dump entry does not fit
Date: Tue, 10 Nov 2026 09:26:16 -0800
Message-ID: <20261110172925.3293312-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172925.3293312-1-stephen@networkplumber.org>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
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

The dump prints nothing and exits 0

Only ignore -EMSGSIZE when the skb has data, so that an entry which
does not fit in an empty skb reports the error to user space.

Fixes: 5b4b62a169e1 ("rtnetlink: make the "split" NLM_DONE handling generic")
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

