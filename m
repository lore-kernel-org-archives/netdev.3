Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770146;
	b=puzY6Y4BRjkAY98mEMkh3pXaLV7CXFEeXF+6bt9DTD3h2nNis/kBL0VYJcJ620qgKcj/
	 QkALuB6jOzJE/27Tb6YcxUnrBK1LcgMaiAJ+tyzXIxfLEuzicI2p1vSQAm87RkXPqY1+F
	 s8pHioxDUClFfN3XRX0BChrFh6SS491YM9tSFSPm7YMm0d+6w4nWZoeT1eFEivCObqVhe
	 gwqaJt3JUU7Y0lOKoABMHwYPIH7FQYfaJTNgv6XU13SmAkmyn1uZDs2yahkILJF5ESwSA
	 lxddpOzw2MqBHGlE+dGi17bh8yNpBj3m4DsSgT1OqsAyPimmD13kICqfKbIgCoP9rdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZCC50QbEHF1bMAUFkDnjNV2OWw2AywfGw5wx0TGBlWE=;
	b=uFaVNwx4xX2UZ01WYkhbpqWOnF16ACPhHCX/jmwvt7pNJHg21NHrbyNro9tOhP0inBaj
	 Leh1mQRayInVQ2KbmLKALWa7FQZOqX4ZNCIgy6yPA18vRdYLHWKiOdZ2KAF5BVJ/CphN6
	 a9udYZkGW2MJTpSrTrL8UCkS0Msl5G8VxhJfLKCG/syVcnYTrfxVIkOahP+BeulTTI5hb
	 k7JhJuhYRsN7JVlI7NoLV9+lu7Oo2C4UAkC+BYsHhF5lEX1WfK3HLauqRvx092+oZMw18
	 VmHG/b2rYfrFiuTlN4DDTIfTZl3bcQic9V8fzBd4sJwoIf8MqylPYnSqE/vDawQnjaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJL7y96y;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C28606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 05:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C28606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJL7y96y
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a18fc7a38so670975eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 21:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793770145; x=1794374945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCC50QbEHF1bMAUFkDnjNV2OWw2AywfGw5wx0TGBlWE=;
        b=yJL7y96yzAOUDaONmz+iDLaVSzO05E803AMg9Ju8sqRRh9EVrwZGofisf2Ez9zHhZV
         QWcTHbCQKlC/Hycxfan27fc5tTFL30ogcHXq15AAwaQNFZvnaf7q+isUzlcTuuGoKA+f
         uuWwYR4K58KvQCV8rgi49xlZa8GGEeDpRbBCtkkDswLDkkqVnwT90aaQuyTLmo+vVSNt
         6IN3aZwj845q6JK7wGLofQSF+G86luV09ZxzuLXHG7JzyPnB7Dnnic1iCxXKrUkpwja3
         HeqXAdzQe0zKLRGP3vdKjL4CO4Zr+CmTgg5a6qJOWy2fYZJniKwAZjH2YdsVFQjJ4Xvg
         hDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793770145; x=1794374945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCC50QbEHF1bMAUFkDnjNV2OWw2AywfGw5wx0TGBlWE=;
        b=DBu6tzeyte7jkG05/qdhbsWo82nrOi4T6Wbt0XI97jjdfH5Yp9h6NjK0tytqHUiSKc
         yXktj8nDWiSiOVk7r9L5Xl19XCfOh9UZvTToF4LB2q6CbovFDRe+p1orAWDt/kbNcgnw
         RUCGowQtkAWhNkbFv6BpyrGpKJup3T8Av/T7Ivo+EKJm1Ww4S5m0Kg34uI1aRnv55NFa
         v4clS60PBQl33P3CL4Rw2Zfj6EvTz7a+EMb8LYpKnj0GHosV8RbWUw0xU1XjP2VPjmuh
         eUOEZhSDTdlPpN9gtratU+ryOj8870GkyscWdpx9V6tMg2ocr7mOaoaxhXEXRxyMWKwo
         u/LA==
X-Gm-Message-State: APuU4Z+C1DlohrluVsoMXOJ0Ar7RsXu47bGGBPzproPPhJWlf5UwOcbb
	EEIKamx7W6RbgLgCrWzFNMyLw7Dhu2Y/41F2QLkFWj4n+PN2X1apuunHv0Dyag==
X-Gm-Gg: AYBFou0Xnk7lEVH+DbVFTz7yydMzdRPPrXpyBoKH4ew2RWxc9yrWNnDTKVvj2doYeXR
	f6z631SO7ND4rRwxanIiT2ww/OFSKEEMu9MRh8e92d3izdtdFGJrjKn001xEvdbE8OjheO0De2r
	G+oOArYvMWxRhHps3Ac45hqj7+FkAPR97b+a0DhTu7NhVRHxz3SiwcpRES54MP9F1kwY4Tz9lwF
	JrtGCcAZ+oyrSa+55hSdZsk5WReof/DjQnct2yG68fkoKXATeY7A14knrGEfYaCMFcfrvKfMtoV
	SEvon++DMd+jvl/bt6IZmBxL1OHXVZ27hNOxEFuZXcKrM8+MinjB3QV+McZoUKI9iqoUSmWX3N0
	UjQ01eknEvm5K3CBFYgNcUH6fWcu2aaitF0HpQdE+KAOIabw5FwHdnVCl64QjiLpzgU4ZzjG2s1
	rmJ/H+lgwSKR6e0UJgguNzO0V4m7SQqxuL+M4F2AbOyHXNrLX9QPsuAfPQ+CdE8Meoe7PoYricn
	qfErZzWulTSLOEVDvKZzQttzrF4B4GYDMMI02PrARoxKRhEPNNWsihZORw0D7Saot1+ejTERui5
	sjPdEpUtpb/LcQ83Ioal/a+nIi5+V8NbZ5Wkpjx5fBDx9M6MoiCNSiKcgI7Gd1omAs03bC+T7uD
	78G4Yae/UqG1ImrOU8dRGz+L91MAbVOmaR8mGbpq1spQy+g==
X-Received: by 2002:a05:693c:8815:20b0:356:4b46:9393 with SMTP id 5a478bee46e88-36a423e547fmr23440390eec.24.1793770144230;
        Tue, 03 Nov 2026 21:29:04 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:c05d:b1de:ff25:6930])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6d3dsm4336409eec.7.2026.11.03.21.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 21:29:03 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2] libnetlink: zero padding in rta_addattr_l()
Date: Tue,  3 Nov 2026 21:29:01 -0800
Message-ID: <20261104052901.2735000-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
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

rta_addattr_l() copies alen bytes but advances the parent by
RTA_ALIGN(len), so the 1-3 padding bytes are never written. Nests built
in stack buffers (lwtunnel encap, RTA_MULTIPATH, RTA_METRICS) then send
those bytes to the kernel. For example, in

  ip nexthop add id 53 encap mpls 101 ttl 10 via 192.0.2.1 dev d0

the three bytes after MPLS_IPTUNNEL_TTL are stack contents:

  05 00 02 00  0a 7f 00 00    MPLS_IPTUNNEL_TTL, ttl 10, stack bytes
  05 00 02 00  0a 00 00 00    with this patch

and valgrind reports "sendmsg(msg.msg_iov[0]) points to uninitialised
byte(s)".

The kernel skips padding when parsing, so nothing fails, but its own
encoder zeroes it (__nla_reserve()). Do the same here.

Fixes: 6ef87f9cce21 ("ip: route: add congestion control metric")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
addattr_l() has the same gap, but all its callers zero their request,
so it is left alone.

Kernel side: nla_next() advances by NLA_ALIGN(nla_len), so padding is
never read; __nla_reserve() memsets it to zero.
---
 lib/libnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index edf3a8ba..c4a8e694 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1502,6 +1502,7 @@ int rta_addattr_l(struct rtattr *rta, int maxlen, int type,
 	subrta->rta_len = len;
 	if (alen)
 		memcpy(RTA_DATA(subrta), data, alen);
+	memset((void *)subrta + len, 0, RTA_ALIGN(len) - len);
 	rta->rta_len = NLMSG_ALIGN(rta->rta_len) + RTA_ALIGN(len);
 	return 0;
 }
-- 
2.56.0

