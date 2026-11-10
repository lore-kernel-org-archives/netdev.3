Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298203;
	b=xZRgrexz8PJ9VQ8h9+6A1cQrzZLUsUFqvDB5tEGMCNA1YrByti6D09ToMQDj7os/BdPS
	 RgWYFqI94wUyzN/7goLp7RE+/QlbB+N+P5Q0itrl/d6ZLsydloTosr8bOofOQMYJ2V4W3
	 52rIlKDjvp+DM2DQPKrwtlup0sif1hdqiedMGAwuCFVyrjTHcfwgSR2uMyef0jPEWwf8j
	 Lk+PZgmxeZfLyODNMN9FwFQbfcrw7GoaeiX+cVoMXfSd2Km3TRSXjPHqVt5VGDkADVtp7
	 EewBdFtMIkkukCQoQmuYJLpMZ81x26sgm8uwjXxWvVdPBvWNL+rOcBvveWFvQ1FW4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298203;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L7X08ZaDKejqmoDVsYnR15CKc4ooGxbHKPQKWY15LNk=;
	b=kg0UNO3OKCFpn3KA6t2zFPLiYp1Ae400GgszyNcpPVwkkVg816Noq5qPych85lT4w4nR
	 9mmlLLel7IS6EUrwzmbAN9YJ5fykBS3r49Vhirx//Q2laekvyD4BcuA7f5LIIqrn2z36U
	 qrnAZcZOY//lDUi98t1Pt98Eebn6gazVJVwWyH2dt/jEs/t6unYIpmRvYhbLTxGlWa7z6
	 eqoc8iLnXBJcoW4GK40+1thLYTegehHUkn0JSYaj0Pg5vlUkFXSsV5p9J/d2Am52laMXj
	 tCbUDAhn0qTEl/BTGRc0ARxyXm3Iq9S/EDPO4m7CmUR2iQTzQvybKHoNOxgwXbpRnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=smZzyaKt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DFgOGQUm;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AF60A2639
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E73AF60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=smZzyaKt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DFgOGQUm
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 52127EC05EA
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:10:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 03:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794298201;
	 x=1794384601; bh=L7X08ZaDKejqmoDVsYnR15CKc4ooGxbHKPQKWY15LNk=; b=
	smZzyaKt7iVQLSJcvCcIr+qAmkb4G48diYMQa1s+tWLcvv0WDzRWkNdugfKZZ6Pu
	MBPNMXJ1zajaAtewGJbZZ2yaiFIa0AtDKzq5xfUfWYViyY2gkGN6PaGGFg9zbxbF
	s8VQxE6VSV86xF34XOCNAsOf7IuSIcRhVOtq8ahf+RwbKL/GK9gp5xryT1Zb4viQ
	W6rVvnvfUE1+OJpB+EU6NjS4fnfRX5hM65B91Xj6pVaCVY4o448dO5ed9ecXDMEA
	aUwhZjRkY7UXuCyZbGf21yzW/5XKjJvXZOueGY7UvjznjWCoy9YtRqorZH8fD6Lw
	Su6ILgW2bIxKwmFsEhQvsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794298201; x=
	1794384601; bh=L7X08ZaDKejqmoDVsYnR15CKc4ooGxbHKPQKWY15LNk=; b=D
	FgOGQUmPbUW7ipMN8vuGjyelpQ0IyQ0ZWEeLOXJtJOil9mNJ7g6nNkBZUiF6RzaK
	l6giLNTVDsr0K7qv3Dz3J7P6TD8QTRVXH3Q+BqzQJ45sZr4JcGy84RxocLi1mf2S
	cZJ4utdPsV8DUrlJLprDlY/HbVoEWj38XtklBo3HlKPWa1DHdX9vt1kyH8z1B/BA
	FYqAVPDFU6VVVlT73FPUnh06rKKRGDftKImOb6AybZ8oY3Ri8tCxJL15MfEj1FRk
	LXfw63fBHH/9uSA5+2P6XL5wE90nm/WwfyVahypDV8I8pjYag4wUTKIsHyU3lfQA
	vmLxh18aUag0nEZnq/Qqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794298201; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:yeZbm31hJ0Z7pJmK+J8dbcz3Om0OyOKUl5zlVqZaWbLsXcf
	F7CXXxZvH34zG3eV7wsg3ooJMwmJGPtNwcNwUZIB3RATyv/nn5MhKqL1RMUF5c2p
	wl3/3+cnszsCuIYQ5NmKZeCQrSfVWTU/7jTCVfU+oIAwC6NoE54bCIgWvtjpQQ7q
	G9MAO4+UjGFvdEDXhVn7QIvTrn1U2wzo7VuP48uM2vfDijUgObl7xloGXHGPvvQe
	03+did3/Ahx4lzNhH+mM3zMXpS4MFZL/KpQr9xnBICy2S/8QPjf+qZUBnuGd8Yj6
	myS33eyFgwFTnIy8tqBQ48VvA6piBZBILNn6Cpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QzMiz6hXEi+H3u1xNR3puK8mz4UjMhvECPG3etrAv/A=:QDHYz0joinfyqcMDnrAmhllDNNnbF/S0QcY6HnLCl/E=;
X-ME-Sender: <xms:WdHyakIyJ9SYod4wpSneN6-HtKNDfpJbU7JjRxhngzC4uqj3pkQCqQ>
    <xme:WdHyas5N2LnA53nNrpqPBMwrqo3un_d8H0uiqgqOQF01hGwEmN9RXA4sfQqaawb3P
    -nFfIhROb30PbMX_ChCqZaE0n_eFvuEsdJqJrFs57SIUHuZszL6C54E>
X-ME-Received: <xmr:WdHyajZUhx9uGef9FGeJbuQ9Um0-FWtnJU9nNIPwRhyKoUREAWblYxxWS7NW1h4fbX3mDr4ZcjvT60Tq_DvwXNq_zDOVois>
X-ME-Proxy-Cause: dmFkZTFJs/KhJ6SVSDBDZQ2cuGthrLhI26tG4AKadjP+rz0vKu8/vpVkZtjs3dDgzseOCx
    CQdwP9dxcEUOSOOaHycnESElSgKGWQSVjg9CnjuWwdALffUgiw7Cgtyk32U83e7/uiz5Au
    Tu3wYbKEqrO8HNNohxgKZqhwKT/fpVy4QnJPvVgh9zx+38otiGx+0iyOUvbNzswo/z2HJM
    +pT7iyuPv/q0O9nvEvbo1y0nNnCIcxaQI3BsEVAZwd9ailNOjj+x5S9nGtWK+/XL1pKlLM
    TfMQPsa+KkwRI/m/7CyjBwzWQqwpkJ7zuEINI+vnAqK/VnzWCezlnlN9k2YRVE6ycxcmfr
    hLRWlo/YTQJo4n/0qrG51q0GOd7vDSKbF4QpJLBIXCLDdspf0n6x2EIiXPoOCaY8kwSfDv
    CqGvyZ9Cz3nXlNzFafFa436SukLaOMX09p0eq6UboooHqsNnnQrUwY/61tOUSH/oUaTtbT
    Y1rVpsiZoXEgNLD87bVuQiUM3BJ3+oNZSCURiuMGgixhf8h0z4AW/Xb2FAwL4E2Xs1JpOQ
    gZUO38n+grUW/+XRGIAwOHNW9iV6myhCIvs7k/j01u6T141NZQsIYj0qrdVQNCfDBFhS4T
    8SZ1LDCBN4AKxTkE/ihnVzBlu0QGVhFLN/s4nVmLPRl1v/aR2zE54VIPx8+A
X-ME-Proxy: <xmx:WdHyajz2KdqO3qoNJpZXXmEbyrKROyu3Iw-tmTOvGY8Yc4knzYBtRw>
    <xmx:WdHyavN-Hjr5h_iiyCSvKMIezf-bkYivztnUrAsJ-Ki9zRm7pQJlNg>
    <xmx:WdHyah4WBes-kCOWkmDAhqY-iFd5Q2l_t1UxiJzW96DAjuUmcZhi0A>
    <xmx:WdHyaldoVyA0fcBaqoa83KV9bm7KeLbLGQ5X86VIQZOuSBjAgcmuLA>
    <xmx:WdHyagS590pe4-_8Fg217SPGY9lZk1RIA_cC_P4CupArufrb2Unqxpu4>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 03:10:00 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v8 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Tue, 10 Nov 2026 09:07:27 +0100
Message-ID: <20261110080727.2377040-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
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

The gPTP module is shared between the RAVB and RTSN Ethernet devices on
the SoC.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v2
- Preserve sort order by unit-address.

* Changes since v1
- Rename node ptp.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 5284923b6cef..f2d6696680db 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -606,6 +606,15 @@ mfis: system-controller@e6260000 {
 			status = "disabled";
 		};
 
+		gptp: ptp@e6449000 {
+			compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
+			reg = <0 0xe6449000 0 0x500>;
+			clocks = <&cpg CPG_MOD 2723>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2723>;
+			status = "disabled";
+		};
+
 		tsn0: ethernet@e6460000 {
 			compatible = "renesas,r8a779g0-ethertsn", "renesas,rcar-gen4-ethertsn";
 			reg = <0 0xe6460000 0 0x7000>,
-- 
2.55.0

