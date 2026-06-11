Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAD329C7B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206230; cv=none; b=M+1fjYkcTrJdSMcsCnugBUI8JTTVFGaxtsS88Q4qlT8dfvk5cPOFUfbxaChb6wr+2DdM2GMowznD0oacNsle1KZMbXq5nqnCG3G5eolzc5R8F4AGOCFKnNOFEDqsF6PTSA8VC4zSNE83mAXrYo1UEQfp6RZJFIwjDwXTjvfkWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206230; c=relaxed/simple;
	bh=b/sl5Sl2CZKdLL1CsvRJVchAi8muX0D8sFJZKRQMoDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG3EAZ6veBs3jWgv4zg+N9XjUH57yKC5pXf6bgZiSbnJ2/EA/OObA9D0vg1/7Imn6RMz55Aa3Aa8zVbZgUinQSdJAmEiJedKn3kKyI6ItcYKsO5fcJyKcq/gpPH1mImP/1LHyO8Aok2kfz9fHLOnvgl3X2f58jVjhc51hT1WroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Y5QOKSmy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HRSG0rb9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Y5QOKSmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HRSG0rb9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE22C7A00D5;
	Thu, 11 Jun 2026 15:30:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 15:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206227; x=
	1781292627; bh=jSSzUj9uvQxCjaJmFRCDjdn4mEhbZSsgWLJyD05+Kyo=; b=Y
	5QOKSmyPxpiMKNzEftOD/mqlNEtUwQJwZGL4KoCecs5bODEjtO34e3V3hFXqafi0
	tIfUABuMArUk8SY2Y2OxhUse1G4DLRgHokwK278kEaPGZWF/aP9P1ZDG8S7kvG87
	lcDiaTSRCemp/2TzP4xSPwjfDheqrXqb2ARLCUjmRrRaQ4MJ8POnuXS+76IXlxlc
	MjU8Da8V+g46k5T0j4sAVrPx7UZlc/Vbm7cRkcR0pHK8HYgifCpy5JFCNdNRk2Ap
	wiEmtfEytmzqRWXkWn/qFmT4AuV/GhSszNVRTX3QMrYuIrUt15kZXHIlnhE/zCbO
	omfJn6bPJIcuzFzyiR0Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206227; x=1781292627; bh=j
	SSzUj9uvQxCjaJmFRCDjdn4mEhbZSsgWLJyD05+Kyo=; b=HRSG0rb9uSphTbxXs
	cAfDaXksHD8yua92bR+HtDg1lw4dHOZGw4jSDLuVoIeCssyqLnDpHkzyZQfy/UrT
	2yiSgv2xpuOZONLO1C0U9M5m50mDaUF8eQSf4m0qfUIBYQM0Ya9zLTUlpp4SPEwK
	FZLR2ux173WoAmc6JL3R13gs4aa8Xf9l12gpU4Bk4rfXoheBNha/IPIVwFMhJje4
	j7/2c+7HC5kBMMvak8U72rsdQYp0tgszCSU6FIINFiZvRIjU8+c27/0xr5WaPoSo
	yQ31UYnQ5hzuWzCq17sQQhTRUSE4h8DXvFcKHpq6ikshBWPI88RVljSASoMV8JKW
	kggCw==
X-ME-Sender: <xms:0wwramHu9DJcJP9yhUoAee4M0O9ogktEBWCTNLPEDZuDTzXrEWoMSA>
    <xme:0wwral3jZn_QnY3xQ3W0AP0mY1n26iEzks_oVgSbrzgKdAS7TOfIhMXaEsrJJDQTM
    DS01OJ4mSFygdQhZaPZ7HTF4NdO12KAxKeE4bzGg_XGHaYWd7Yl0g>
X-ME-Received: <xmr:0wwram94zGTVrfHqw1vC3NAu8f5N2VDDg3lr1-uWQq5F2bZ02TxjxPETXZZ76_qBRfqFAZCWEdPVj61wc1F7hu0>
X-ME-Proxy-Cause: dmFkZTEiC3WdhRi6lmpvrurG1zsBSCtiqP0WNrqAbghd5WJJ5VA7rTMHapznV9StKJaapp
    RCFRaoACDzmV+WD4oXwzhVyqAYewgJwskY7+pzj89kGgG6Z5gh5qwjqnnl1xPZ9xw9XTL3
    6h0yQhC9JWLW9+mdqRsn8FaDYVGkm04cbHUvo+O2iHxAKiVWkwOc7fmUFydM3Q3w8Zl56u
    v+GK2GCObb3b4V4RDlvLsMODXfS6N+5oUdni3ao7DuI/y5kjlxXKXH9JMIpsen+KUYBZ/y
    QM6GhQcs+90PA2n4UkkP5wtLFs/TKnXuu0mgwtrACzJAoOCVpXiPf0MWRzXp2RALkPmocC
    EFjMvh5PHmifeOvcluQB+aIPkZ3XZdrC8kTnz7eg4KQSJAI2XPliELd8FxkSlw9WTPg4AD
    keSIuj9Gff+cJHvlyPKhSQFtbhti8diEc0GRYKz43XTWcLeiEU1FiTwZ9wdJDqQw4fe3KE
    4T6DUgNxXbh/ebxtXV/WdipP4+kSNdTS1Iw2WD1Msx+7vuWgfSE+LjL9ZPnbrlX8tEk60r
    BGCkQf4pLzsggTStUZMcVGaJnDrbu33k+3mC5kc4AhstmznGEANY0FmrdfiBIPKr7O0SUj
    oCj8a/cVNWYQvkKuX3YlK9VyrgoubVRUQ7jJIHnervEksGVg+6LsYyS5vf+g
X-ME-Proxy: <xmx:0wwragFN_bg4aKv9E3MtK1Ca_YSw0V403Lm91T0CSex_pAmzSGY9jA>
    <xmx:0wwrakjt8wGDrx2Kn2_4imrNdPJJ0-NP-4kIpbJZyDBrcOiCndvY1g>
    <xmx:0wwrat81o2YQtNQOvvIjQp7C0Eg66EeBJhLdjPr_qPD8OiKyAuMwkQ>
    <xmx:0wwrasZPJUBBovXj85O2S3BXXy4oF6Lwf8nbCBJJmDaTJvg8pwX7Ag>
    <xmx:0wwranQz_u16q2j3-_2sYthy7JWFoMDv6C8PkYfOvWe7naeWw8Tq-cOA>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:26 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v7 02/11] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Thu, 11 Jun 2026 21:29:46 +0200
Message-ID: <20260611192955.604661-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
into a u16. As can be seen in skb_gro_receive, packets bigger or equal
to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
16-bit iph->tot_len field with an overflow.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 23b42466a7c9..9afff7bcaa0b 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -604,7 +604,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
 	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
-	if (total_len > GRO_LEGACY_MAX_SIZE)
+	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
 	/*
-- 
2.54.0

