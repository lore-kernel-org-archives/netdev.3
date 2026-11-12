Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472675;
	b=Y1u6YnUM5Qj4vufdNcdCI0a5s/vdvRahWntcQChQKy3USkzXfFJtOKO4F3W0KPa7qoCp
	 8nxwUYfD0ha2uOYkxtIZQAdLxsmE+epv8f5Th5/HS8p3BNZE2iocszHMHvmk/e6UkGuUv
	 g9QRlrywBexJtCNMjHhytH5O2XOApJpY4D0en4mbGTG6257kjVhndithI2kmastSxVXmW
	 f6LruyhALLchJhieURvt9U1PHu1u8T80l4VaoiwlXuNqYuu96qZr6oQ5k21B3VWppGIm4
	 EHwDdju2v93T1RPfE/r5N7caEufgWMR3jT6Tx6IT/FMcTXp1zBuLt3my7vrXq9E4F0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=53W5SeVSu8yIwtu2lhFAFXYTbrlByRFfbzx3Hg/k6Qo=;
	b=n0xMFENfsV6tMmz9//EZyxTtb9vNWeaB/iTWR7JrkWODu4VJvzEnJawT9B1O3PBuOzbn
	 DyDvncf4CTBvoT15F/ZWTWYubTVsZ3RQ26P8BF9sJdRF2KObRqTa0iq/pEXvSzxHowDcN
	 pXKZjvQ+cWg2h5T1bn4keIEaUXD2FkMINlNhZeew6UbxIOAlixGME/O18Qnug94aZ+W4Y
	 UrAgoPeWSZyOQaHtq4kqmQAN3VIpAD8BWSUAuf9Y7aCWY5G3VL7BhuBDkzMGlvD/5SXa4
	 jSGZ8pUe0ZS9zsh43UU4PlP2pVGXDwTm7w0AI3AaI3I+em0OaJ18jHXxcKbz4rZFcYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FgbOaAWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4F606A8A8;
	Thu, 12 Nov 2026 08:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF4F606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FgbOaAWb
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 63305201AD6;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53W5SeVSu8yIwtu2lhFAFXYTbrlByRFfbzx3Hg/k6Qo=;
	b=FgbOaAWbNra1DkdA9CBUJhb4/fZJSuFTefs2vV3wmP8DRiROMvQJjHCWpefaBrvwKXxfYY
	5i9DcyErUo9HE2X4vVfKhZdaSjhcdf7V429BZswouPeL8tmbCThxC6dWgMQ1j1C9YOwlXx
	N0xdWdj59vwhUMLmEKTlaSKxBdOdeS15gut7T78u3Z1EpLk5rQaBjbF1jfJyi+SG+eYqmu
	DzOApnp4R23l3BkXJsdAzgWgdkRRH5GMFW7AmkFXRXqTvpgdCuiinb/3ZpCecRE/tusqo8
	6jg9QjfJy2jVsbA+AHosv9id3GPrdx37vDY/nUjU5mH7bDHPMwtMFR991gqgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53W5SeVSu8yIwtu2lhFAFXYTbrlByRFfbzx3Hg/k6Qo=;
	b=FNFqQwhKZ1viL+6BYh1kOinaAeHmpvjNUZN44IL7uxHbL6irSluB3SNxSl4W9EPkJ92K2S
	tZIcZwqMVqpOBwWar+6AOCKXLECU3o7mCT51qWQZFX4+gwH3S3TFWRLhHGyip4hEiKC2Y7
	wd9mhfU5SJFieFIOT7LkriMlrK2b0CRUnIhfLPDNv73L7vzERVlRjqCETOqbviU6l9xXuY
	IdhJTI2dUN60uStwZiOYGWhDgXEY/aHMx7nYYqP45/ICvhLFLfX2qINJvWqmmbEft6XAEH
	5tljbD9nVrtGB8AVm4EFryk3rQE1i+T288V+YzVXJohJlrtCpIxi6oJAlySIJA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=YZlzJxdvddYqOMNtefxutEhK4vW2Gd7I5+TvrZ/H3ZYS+nSNXu/cwMH5Ss0gG0ER0hxaxr
	EEmQ80P1undlk0nGmAcw8+yq+DPGjpHjffniwXOOaq7qphmFv8JobnYvzU/I6snep4GqpJ
	qQGVVKjvBEXtVI24cTg2QWDchxCbxq5rQmd2gPXMaE0+5Advvh5qQVu/bztF+ptFIEGNf7
	CoNYKZtaGIlRAbdM2x8my8nAoFhSiluxlYbfBkClcAiCzX23IreTRuAwQu60za/vR+N481
	43xJQ78Hr+VymoKIC7L61IKOuVfDzEoHb5tOGejfW3l4eGIFHRHP9F/on8YptQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 52236380428; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:44 +0100
Subject: [PATCH net-next v2 01/10] net: ieee8021q: print traffic type and
 queue count with %u
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-1-f8e6fbdf8c99@pengutronix.de>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Switch the out-of-range diagnostic in ieee8021q_tt_to_tc() from %d to
%u. The traffic class count num_queues is an unsigned int and the
traffic type is an enumeration, so printing them as unsigned matches
their types. The print sits on the range-check error path, which still
rejects a negative traffic type; %u only changes how an out-of-range
value is rendered, not which values are rejected.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Drop the reference to a later patch from the commit message. The diff
  is unchanged, so the Reviewed-by tags are kept.
---
 net/core/ieee8021q_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index 669b357b73b2d7746e4856afdc8187cbaa4f9a6d..bbacdfff9b4c2ec14779baa79d341527fed1920c 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -99,7 +99,7 @@ static const u8 ieee8021q_1queue_tt_tc_map[] = {
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 {
 	if (tt < 0 || tt >= IEEE8021Q_TT_MAX) {
-		pr_err("Requested Traffic Type (%d) is out of range (%d)\n", tt,
+		pr_err("Requested Traffic Type (%u) is out of range (%u)\n", tt,
 		       IEEE8021Q_TT_MAX);
 		return -EINVAL;
 	}
@@ -131,7 +131,7 @@ int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 		return ieee8021q_1queue_tt_tc_map[tt];
 	}
 
-	pr_err("Invalid number of queues %d\n", num_queues);
+	pr_err("Invalid number of queues %u\n", num_queues);
 
 	return -EINVAL;
 }

-- 
2.47.3

