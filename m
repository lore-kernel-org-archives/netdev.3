Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229918;
	b=XWu6WoWescVBHg2cv6Bsat+18+nMoEe6UjMRQM2jj1zeqWfypKQmuHIQlUEBSjJEIEhW
	 hK0dazt8u+DQqcItSzbTjedUD4jY0NqAZqga15vdk9E7HiPPmBovcQelt8hfG2vMNuFYB
	 ygPaKg6ZP2TQH886NtL5dcst44EmCjsjK2uL4FmdLNRGVgTQ94VyVQh9OgM0ZdDUv7o0K
	 z1Pz+ip2EcgT1eTD59LdnkWFA0lMd+vEOEPMgCBSBibxJkfnLKld/2FTD1RaYLds0Fw7C
	 84q6cxGhqPPusqwiDrg34XRSpNgLW9yRA5k149Gv+EIzFD0qYfinwHyKpmSLtTJ5sZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229918;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MqVtbhxmHzuNnaLNhya/ZWOij8VY2elwp/XhppUQFAg=;
	b=FO4U7hzgFXqsty8h3BN2N46GFN00MGgS1PAoOcW2btaqAVhnBOWEw5RBzTKsK2ic+V/5
	 a+Tj/+uHMONJBVnhCPeg4bm0y+vp67ZQnWheg4Iy4HyqcXTNXTm+Ic2amjx++Qfkty1Fe
	 tZPNXh/VzU+QVS40E381r3yb+5ucjZzCCT5LzlRC1SaSEnfoSBcwYiZBAOulAQifI60r8
	 oFp1nbN7TicTH/YigTEFkWJfdVAfJioxcdjejY36mdjb94eCbXQ7NRBK/o4RaWeZrR7vQ
	 41q0YcI+h4Fm99UmGFfy/XSOGRW8uFJ0Q8fNg+sl+Et/EDwAHnyLYAELirndj7jseTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=SwT4dEli;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A1606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595A1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=SwT4dEli
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794229917; bh=idUFQdOgA2qYWeWk5aBwAn1n9ZsSMMDD3IGknTj79lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwT4dElioNHHuaYOSEko6h3eg0abyx1zwOHqzJzksnMcYn2lwhQihUeEZX376yJrC
	 Ng0AZrF3RMscaXXS+U5Xc2nsFfnc5iHpgaxZqWJ8PI0rOFBGKOa3CqpX7ZtkUox2OB
	 gWAr25smzNURy8LepGFOFff/S0PZ9+DMVVeD90C3fAVcrEam5zotNp2XhCepnXgyJk
	 u9t2Uo5dXcBG1mZyJ92/ouTXkDUGPxQh6/cZeMhyYG9ymA5BQxAjyDuMQgjp1/YZri
	 z3dbi8JnUwDyBl87zKW8zK6lHfywQoIy2P5nqAerkr3jEfOOJlbgm4Td7w7sZYd0HQ
	 4YWbsN46j1F2w==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id DD49044C11AE;
	Mon,  9 Nov 2026 14:11:56 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next 1/2] uapi: pkt_cls: add flower mask for enc_key_id
Date: Mon,  9 Nov 2026 14:11:47 +0100
Message-ID: <20261109131151.960789-2-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109131151.960789-1-acassen@corp.free.fr>
References: <20261109131151.960789-1-acassen@corp.free.fr>
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

Follow the kernel series adding this attribute. This patch can be dropped
once the headers are synced.

Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 include/uapi/linux/pkt_cls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 3c24e8e2..16c3f96f 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -560,6 +560,8 @@ enum {
 	TCA_FLOWER_KEY_ENC_FLAGS,	/* be32 */
 	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_KEY_ID_MASK,	/* be32 */
+
 	__TCA_FLOWER_MAX,
 };
 
-- 
2.47.3

