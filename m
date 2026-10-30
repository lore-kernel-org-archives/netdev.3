Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334135;
	b=C1iO8VAYUsg7+2eNsNntywWMimMG6aFSt+/CEGhLntjZwQQsSnCP0VrT8zz45ZBFuHw+
	 my4VIa23vi9RyroaKiaZCIqkyJc3Un2rBHubB4fgCkvTgH/ubvjX9GGU2cHq1CHeM3hH3
	 nJk0TAA5e4BGTd+fMo4VP+hhyVTbf+UK1qcjRZCx2AspER3cXDkxWgGHKDbtmin4D3gPx
	 JpUGXnYIiSfSyBRQLUPi98tj70kiDw8KIsunR8gnf/SOxm6NUGvPQ34ZPc7aqF9nAJJnD
	 n17CdIgVkgTW19WO27EQumvtuppeADAjvFfxi6Cyxol00KsrxZb4nCh3DbVQPqNehmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sCvGqwNU2SK55VH1hMa7Zsh/VqV4FJcT/3+6mrPnc1I=;
	b=5MnE93r8n9uGoPG6hcFcOm5D4BlLULhpJ4wKlgnYSPsGg1txKkgJ0PrhN4G/BncKpIQg
	 K+AjRs7zMY7p28Ws6eEm/FACVKU77wFb+k90xMAgeuy7b3Z/lMsUX3JUXp3uI0fDNcKsa
	 UgFTtzYBITvrSgFHL8KyHtuUa27WqYqbuLQznDJzpN60eKr6jPRtL+DYQmTFcqSHeR7uB
	 L93LIpu3P54kDWYhnoKiRu4R9tB219qtQBDTLN0zB0u+NbIdnRp8VZmsBFB6Yi1goOfP1
	 oeQSzsbCbCOuOTRS8s3exYPyS+UlVZf0Xd79czW1CA1D6d0c8FA4HKDl66cgOgbKIPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=P8lKyUii;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC08606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=P8lKyUii
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-7143451981fso183897eaf.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334134; x=1793938934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCvGqwNU2SK55VH1hMa7Zsh/VqV4FJcT/3+6mrPnc1I=;
        b=P8lKyUiinJFj9J1uUz/gfUWezrUvE+7Q9L3hNaeXF6KDvmFv52jq6UhMQ5FQrjYJu+
         0WqVgdsANMCVYZmQrkcVpxZvNtOep8UBVU0+adLSJnrZOFh8kZS7Vvi90GFB+nftq0vb
         JSywjRD0v+3QBgYY/82hpv9oUbcFN3djvrjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334134; x=1793938934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCvGqwNU2SK55VH1hMa7Zsh/VqV4FJcT/3+6mrPnc1I=;
        b=oCUoCGr2Pl3XEepUb9VXtCu7/CvBCEYCM6zR7C8olfyy2bu6pO1kwXihfYxZEicTVp
         zsOnlKJoTyjrtI9W8pWGJ+AUuq2diQhXxulv8L/IBxiXb13IY/iw4RDwFB2ih9mwfUna
         khkjusLaWffHEeIpECmDFr9Hv0tT61VruiZ4zqb/OZmt5XsRVAG5PXoaXQxP8EhLtRqw
         13OZeFRaVL4EZnLkaZ95eOKVXS0DiWGIImNe85T1pPZ6cdrkdpeglrnxmfdtRUvuMCVO
         LJ3PV6cmyzaUb4URdNSgNelz5v6V6pZrm1xHqSP3pM9fe5zsM5+qVOhWYh+QdDDRJ5Pi
         4lHQ==
X-Gm-Message-State: AFq9FYKRx/2PRzI7vSY0porfU48LdGAeW1NTwXYaulm5lZ9q8O7vEqkD
	K/cAn3mnuy0+Fm4kVB5tvH2cUCQjL24nnIRTbK55w3nPNfKVOcT7q86+SObiekarhRVF4CADpVG
	/DMk513E=
X-Gm-Gg: AYBFou15/TPOeKKC/q+u/iv27kySWdeglcH6a2J8ToSlNHZXN05Qeb6lKjIK+FgDae/
	Ick4VtWPu+T32Ve/mnoT64df/doYETAjujM6/VMO+1hsqcL01cAzI0+Mszxw/XP6u/rVRZ6JJZt
	RQeXyT1jJ8gz6YGOQ+LADYn73HGM9Hbr1IIBDlKAv+Azi5hYj0QKPxQ2l+NcHz6KmaDSdt4J3ko
	1H1gO4Rha3h6RMw0gBGBGKjeIYln5slj4Ppe/NNKSwOffcrEAzaEwUZO2zPZ1lmpeeR1BdXvCZ2
	sOWFoIqwzW+LJnGjd6hY/jw2oTf/gIK42WNEtluFZfdbJ+rHBijJ2gJq+7FojaJ5R4N1ySdROiE
	eH18gs7zCjsmp2JSXlino4AVToQFQLwIHQoXBwxlkMaL0hh+ikWxzRaLBuuWxLw48e1LDNQ2kRJ
	QCYpD2NrHDI1eCi0crbqEJPuafZgek7LwIeCxpLxjaKsVHSiTk0HflH94waZZt8izmhV+XSD37h
	dPpovkgtUnVwHdLYE5R2xiY3AZqP3Rn96JBQXSHXVjeaAvE/aPC1b/OV9PNKf76MmWGZr4btA4T
	jaegkH3cURJSc3mqh3zEfDa7J9yetD2ofPWWBQxRhjn+nJzkbb5ZrWVcut7HquafB7cdqb0xE6m
	ntbSBQQ2cZbmkDCPnWOrY5jV5QvWYDQ==
X-Received: by 2002:a05:6820:1346:b0:70b:1217:4a8e with SMTP id 006d021491bc7-714f20a0acdmr892156eaf.0.1793334134520;
        Thu, 29 Oct 2026 21:22:14 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cd9bbsm1127984a34.16.2026.10.29.21.22.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net: gro: avoid parsing headers from shared fragments
Date: Thu, 29 Oct 2026 21:22:12 -0700
Message-ID: <20261030042212.73949-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

When an skb has an empty linear head, skb_gro_reset_offset() can expose
the first page fragment directly to GRO header parsers. For a
SKBFL_SHARED_FRAG skb, those bytes may still be writable through a file
mapping. Headers validated during receive can therefore differ from the
headers later copied into the linear head and used during completion.

For example, changing an IPv6 destination-options length between the
short and full header fetches in ipv6_gro_pull_exthdrs() can make
ipv6_gro_complete() pass an out-of-bounds offset to udp6_gro_complete().
This is reachable with an ordinary TCP GSO skb containing spliced file
data, without an skb zerocopy destructor or a second GRO packet.

Keep the direct-fragment fast path disabled for skbs with externally
writable fragments. With an empty linear head, frag0_len remains zero,
so skb_gro_header_slow() pulls each required header into the linear head
before it is inspected. Subsequent pulls preserve the already validated
prefix. This covers both gro_receive_skb() and napi_gro_frags() while
leaving the existing linear-head and private-fragment fast paths alone.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/core/gro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..d6cf2d497934 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -413,7 +413,8 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	headlen = skb_headlen(skb);
 	NAPI_GRO_CB(skb)->frag0 = skb->data;
 	NAPI_GRO_CB(skb)->frag0_len = headlen;
-	if (headlen)
+	/* Shared fragments must be pulled into the linear head before parsing. */
+	if (headlen || skb_has_shared_frag(skb))
 		return;
 
 	pinfo = skb_shinfo(skb);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
