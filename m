Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F754D598B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549690; cv=none; b=mwmUUvnj976GW5dcRqiraqTCxlw7xPWqp+qf0yCSeZ1bc6QY1yiOl4dyaAM2nuC+Y7m7ApkvhVfvRqoOmYQ5VzyQOIt0rYzoK196PTdkRpnSK+ImH7He6hd7SkJKyWeo6umvmqbrvm0XzXuj3h0gz7cgaXM3xEOYovfJSWvEL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549690; c=relaxed/simple;
	bh=PfNhsuzh4AOEts9llViSuzmKalMWMyZHXZnTes1rkHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iECXowtvjofHD42lBvta+r50+RDqlsAwoBaVxeKR/IX3AjSuu4soHcEzc1KBAW5uSUj8wnAxKdBRR39hyd3p8jterWl/252FCVZ6B7UFwHA0ioiP4qrN5TowDkxDL/vK/jFKFPZhZeUE/X6pldCbLZMq5snqx5tvLmfVtSIVIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgyw+bYU; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgyw+bYU"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-821480f0153so1630696a34.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791549684; x=1792154484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ryl3WOCqZhMHH6Gxb8y5ffAOVmJr/vg7ENqE2edW0CE=;
        b=lgyw+bYU4JkFYG/IjDvkSjBGeDmIHjZctUFElep4Hb1KTsjxK6gcev5mfkWfYxqVSl
         DUYyYFvRDX5jRpMgdm+5XqryPwNIxGTFyIcwNn/q624CnHYdWa1kWMz0liUc04BoBt38
         1d+/JR42mo2uzyiwAOU1rqj/P9p36vpV3kGP0AzeKWhDy9lthwoA9Kr6E6kszuaQiRVa
         9YP7n84fdnzoSMUMkmQF+6jo/qd396sqMqP/1NnDZjXcfCH1wJCUvjOavfKQKJpI/VJv
         0Sd2OCpBsMnHsCxBH6bMdpe9iHPhY5pSZUAWntwpmVLrvynieGR21MfPSpiV4TpUgWAw
         YPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791549684; x=1792154484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ryl3WOCqZhMHH6Gxb8y5ffAOVmJr/vg7ENqE2edW0CE=;
        b=J60yEcd2HS+VOxgY1g0K5m6DCGHQorNi18RR3twHQj0HBxDaUmuLmZDHGXGPOCKcmw
         SPAOmjguVQsNEp8rLRwn0k75GHjyWYKbgn5lQEiShrN/dlskfDjh1UGIrNMn/4mT9RGf
         Xo1nASknDrfAXzWUQjW1U4a2IokxMHMiT1GZndqAOf4aiHtufISU0CpRCgsWJyWa34jl
         76SqlpLx9UYfldScS1IM3GX6fLgBPvgHs8oZ0cA+FTTn3tiFTNXhQHJi5ID3vQ0OUixZ
         uEDr9hToz/tad9tIOo7ZoFkHMPEFeWPLvylIVjB05l4zLGVqVSDkjMrfos1/vTixbmcL
         iKIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTCvS8NWmNjxLIY/SoUKD8kjCJnmH6uMCX5DO3XLnuKwFe9R4oRwoRC5COXdfERDbmUh4lWJY=@vger.kernel.org
X-Gm-Message-State: AFuF++kN1Y2CoJyoaIrDXADmvkKJc/tV1ZpoL69INPKhZQTKv2EtDlGE
	FsO+9FR2z4CBtcfYu2gHI3ED7Frq8+uB+/wCpQ/wHIqa1p2U5lLN7WQV
X-Gm-Gg: AYBFou3+y86XwMTavWo9rnq+uSTJU871PLs41yBIZd0Kpj2YsDM/trT9XYFwMMNEf4F
	yJ4FMaoeaqxt3chwW5PMBsbPJI/E2+jBoeFE6ULHXbbgTuDV3sJr4hpthVQIAWghe28dsf1zpYf
	5EOh+HaKVQoCqdVeVeSGITZwj30E2C+Bph7apiG9MCuODIX2hCAYrbkVnlfDYFIbynMVSkacZgD
	DsYUqMLFoniJXhdhutHVBrAJ0WbmYBzeDDQj3nCewQL3PGUtGST7jgWBxAsp7uiIFMeERoKv+iJ
	UYEU3tfZvtnVImbMR/yjOTCq9MoP4U5J/2RQmvyFcgHyYb6Dll3S9YcC9I1Deg1otJbIrL+U2ke
	WqddG6AIxTOtdk4C39nS57RZvqUMZnbZAIvl/DNeKpLdu7RW5pUYYrLcJFripnhlcxU70DWycQy
	QowbE50rpLyhfrs60GdQLwFO179N/DyovdW6OExyexiNVRXvSAoT9agirl6Kt1E6SnurooSHxN4
	rzmG5+7cVwDXvVVqEMFeSF1+FuHIf0GRpIaNg==
X-Received: by 2002:a05:6820:1c89:b0:6dd:6d12:2305 with SMTP id 006d021491bc7-6ef08e71af8mr1263442eaf.3.1791549684102;
        Fri, 09 Oct 2026 05:41:24 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef00520fb5sm1492829eaf.5.2026.10.09.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:41:23 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nf_conntrack_h323: fix NULL pointer deref in decode_seqof()
Date: Fri,  9 Oct 2026 20:41:16 +0800
Message-ID: <20261009124116.3950469-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eight supportedPrefixes table entries (_H310Caps, _H320Caps,
_H321Caps, _H322Caps, _H323Caps, _H324Caps, _VoiceCaps and
_T120OnlyCaps, all reached through the _SupportedProtocols CHOICE)
are declared SEQOF,SEMI with fields=NULL.  decode_seqof()
dereferences f->fields on the first loop iteration whenever the
attacker-controlled SEMI count is non-zero, causing a NULL pointer
dereference.

Return H323_ERROR_BOUND when the nested field pointer is NULL.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 6830c9da3507..4d66db5bf5f7 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -692,6 +692,13 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,

 	/* Decode nested field */
 	son = f->fields;
+	/*
+	 * Malformed table entries may carry a NULL fields pointer (e.g.
+	 * the *_Caps.supportedPrefixes SEQOF,SEMI rows); treat them as
+	 * undecodable instead of dereferencing NULL when count > 0.
+	 */
+	if (!son)
+		return H323_ERROR_BOUND;
 	if (base)
 		base -= son->offset;
 	for (i = 0; i < count; i++) {
--
2.43.7

