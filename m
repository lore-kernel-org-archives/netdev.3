Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B538332A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944373; cv=none; b=tzJOaWEoOha9aMQETqvbdJWOUG1XwVPCPwUNinessHrCL+bCoac/ayIdAYWhs56MAiBVQs7WgBrfZoMDpTUNUuwCpYd6UN3or9Jxbwah8gl8SmIJgNYI5K5uRkCCnr/qSrpQViZ93mS6mXU67JTCij/VtE/79EGne8kRjsLc4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944373; c=relaxed/simple;
	bh=+aZCkGzmzyb3Ni8O90KOYoHBpoR3ORaot1SlaWUcPSc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ExHd9ImSvUHmaV1jVZInW6WskJDICPIgDkAtH3L+bbnbPZlwDUVA0j2AJ8ZUleeTR6M3Vt8PX/QXvIJm2gjF8mCV25AQT0tyaKDF/v2eCCk1Kt/qjPTtVrClOublngoqjUf2n77W6pGBTQOYXU4G555sR+u9DUieYngOXYujda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT613ol2; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT613ol2"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso3139649a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944372; x=1791549172; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6MxKeQsSkvDC79zO+4M2FDLdj/BSRGg8BfAbdcOHv6E=;
        b=KT613ol2Dew7rmefX5MkoyZZbkFriX9lokUsxycpjE2cTU/YUf8ofJGug5oY4iJGHx
         3W7HoOXeblrDh0Cik/KW+igoSii1x0VX5iXyFnryLU0dFy7HL2MGNVYt5uZHAvSrzr+D
         NSQmkeU4gVjMXVtT4rZdYH4t5jGyo4sKQ91G0KTz4X3goFxttlX30r4WGpcEe0JKOlxr
         D2CVJ9u5wtWNbJFKiQG0gxtOWRMnPpoRy+LxleQzCcfdTwLSOJYBNuH4yqnuGyQqtXCk
         vu9LvpipvVMdIna+7QIwRei1jw3gzCvG3iV0hc/pJpcLSI2snS5OxcWtPdTTA8RrG76a
         HUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944372; x=1791549172;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6MxKeQsSkvDC79zO+4M2FDLdj/BSRGg8BfAbdcOHv6E=;
        b=dK6a+ds2ZnG4la54UyuTIW0XUH/WHE0tKZlRFqfuxxNhqlWNWIj8Y8yIJSKC6UYL27
         /WiuqV+bvHC9jJgxQEa22itv1bhFl2fbfMJkjR0ggnj90JxZtvAwMFzioNJ2zQ6SbwQI
         hB769pVZMhQF39b8LIkf9ppECfLTHiflljk8+ckbZfcjQOFzLP211W5qfP1lXyWp+jHV
         i76mkqdkSIAk7z07yzoZEH50LoNg4KmJs+NOKghXDV0S64iWd8nmParVr+E6wgMepBlj
         jGcD5a4L69FqlfuW0M4YcOM7GjHTJ4sgEIzfe9EYPYMx7gq8DAGB9XeSka71j8wxLVQi
         LBdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzK4f7DjYB/ymejtv937jcuwb6L2kN6pCjk35cizcReQT1guIxPNmYqpiwT3hdlyv+za0TLoJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA9moO16EQDpRmRFFQrfFE6r1DYK3DaoMuETxs22NbGLi1NF7E
	bLQ78BfHK3cZGO0EwhAUoYqNlUmk7Lk4l1x+2tO2NVhYiu7qb1K8oE+QZNshdnlK
X-Gm-Gg: AYBFou3TB4cetSdfz6hjYd/qH4s6HVnSRWhInok64JKFERvdBkra0deO0mTZcgHtnk9
	95CwRx3CyCRV8SJxISZwV0O11Vj9ZYqWl3iuGqkXw2FOFU3wqX8RuFpGMLMtun30iKCwSbvOnON
	5q2q0JS6WS3E16eBySMWoTr/kNE2eLoLDigzbFqjoskhvlpgLiHzGMgmR4/IWgUxzC+BziEsdvL
	lPKnhPQ9wHgWdomqu0xAhSJ9WFo1GlmZ7who8IlN0PNpeIvuJEiSuU5fPzaKC/GRDc+IX230p+c
	cYIOi7611VvurkZ8CrjE0AXKyFlBvs3absnRuZB0//huROdqQPM3o+TcBEZ3TLtmkefDZKTaB8L
	r8nNZ/KdS9JQjd4IvoQZH19f8bbJaG4CoaRSPePgE7RkSetfPk3KNbRbcfWPERI+Ekq2ZFGA/GA
	GQmhb5/4OS0d3PBQ2uhhLmzuUE8QGcZr7If5XReA2Vj9K54GstztMN+3/TqGiq1buVqSOUnQ7/u
	rtUzqUxOCrFTatl4Ak=
X-Received: by 2002:a17:90b:3b83:b0:39e:6c69:34d5 with SMTP id 98e67ed59e1d1-3a6ce95dedamr2582031a91.57.1790944371490;
        Fri, 02 Oct 2026 05:32:51 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd1a0c1esm1523877a91.4.2026.10.02.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:32:50 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC iproute2-next v5 0/2] seg6: add support for the SRv6
 End.MAP behavior under seg6mobile encap
Date: Fri, 02 Oct 2026 21:32:47 +0900
Message-Id: <20261002-seg6-mobile-end-map-v5-0-92ac9b315d23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+kv2oC/23Oy2rEMAwF0F8ZvK6LrMSPdFUo9AO6LV3EsZJxm
 TywM2HKkH+v4y4ahiwldM/VnUUKniJ7Od1ZoMVHPw5pkE8n1pzroSPuXZoZAiqQWPBIneL9aP2
 FOA2O9/XEVSulAttaZYil5BSo9besfrKP97dt56cwXmdCPtBtZl9/V/Fqv6mZt4Lt5uzjPIaf/
 Mwicjr3agGHvYvgwCsNqGVbOAP2tetrf3luxj43LPhvVCCODUwGSIu108ZWiI9GsTOEPjaKZOj
 WAVpjQWr9aJQ7A+WxUSbD1mUlhUNjtNgb67r+AtNg3HiqAQAA
X-Change-ID: 20260523-seg6-mobile-end-map-6f5560bfb68e
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=+aZCkGzmzyb3Ni8O90KOYoHBpoR3ORaot1SlaWUcPSc=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqv6RwHNAugnVsHzROqsW9/qmc7XhwUnBoGsfQT
 gl085jtajaJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCar+kcAAKCRAq19F1Kl0b
 TQ5MEACcFFgR3lGcEoCgSV9YPB3T3SvekcCVn+SmSWRTttOlSyA5cOBNpSUUEbRNXbGoKKm5zW8
 M1hT5cYsI8Ef0y7tfaSSTT1hTNeYvIijIzSlwZEwqpHr/JrDhmdVoi9TLISPMXwWmGasfe6xIE5
 RhUj0VF6kza8FJra5ihhMRB6iXtn+rg1m8SI+yX4/llDkUr5Qk0Gw6ptyQYMEFoXWzS6gGrfJ3x
 n6tWUBuzUEB6hCPhJY3CzaS6q4W+o7NOlCbK67hPF0xQkpUYMUWheyfcXP8ujkxiORTjsBC+AXw
 8DNUWmuEwq6jo7go3RG7WSkhkx+vlmacK9/fJQUwg+C3AKlSjNLR/wDxZd9oovGoUxE7FPaGfmb
 KW8QMOwwQg34ZfxXI8RPc+zR8jUXhb+M0UluEq6i+Og4rAt8KpG9I/n3BmRfEreRaT/T2uPKcW6
 qcXRtx4FpN0FCgRxwPfdIQrz9foJ0osxx5GRJMjRy+Enju+OCHGCVsWb45IAPoS+qCpWvwinIlc
 GP+iw6gAKWPa2ftV1oMjKFj7ZLlIdaBPBoIV4Wm5z/4K3CyXOc01a3JpXLo/sVGRwMcgjzuOMGe
 B+tTaYumiT40hwoUWkFhFqo3/63W8Tmf1KReSfNbbm4WKICCRVABgi/p/A3nqp8UImTgxlbdMjw
 JQCQW/ilSQqk0KA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

This series adds support for the "seg6mobile" lightweight tunnel, the
iproute2 counterpart of the SRv6 Mobile User Plane (RFC 9433) kernel
RFC series [1], starting with the End.MAP behavior.

Patch 1 imports the new UAPI headers as a standalone patch so it can
be dropped once the matching kernel header lands.  The selftest in
the kernel series needs the "seg6mobile" keyword to run.

[1] https://lore.kernel.org/netdev/20261002-seg6-mobile-end-map-v5-0-30eec37563a8@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v5:
- Repost alongside the kernel v5; this series is unchanged
- Link to v4: https://lore.kernel.org/r/20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com

Changes in v4:
- Reject End.MAP without mapped_sid in the parser [Stephen]
- Drop the optional parameter token from the man page synopsis so
  that usage, man page and parser agree [Stephen]
- Link to v3: https://lore.kernel.org/r/20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com

Changes in v3:
- Repost alongside the kernel v3; this series is unchanged
- Link to v2: https://lore.kernel.org/r/20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com

Changes in v2:
- Sync the UAPI header with the kernel v2 series (comment wording
  only).
- Document seg6mobile in the man page the way seg6local is: the
  "count" attribute in the synopsis, an ENCAP_SEG6MOBILE grammar
  entry, and End.MAP wording aligned with RFC 9433.
- Align the counters helper comment with the seg6local one.
- Rename the nh6 attribute and keyword to mapped_sid to match the
  RFC 9433 "mapped SID" wording and avoid clashing with the
  SEG6_LOCAL_NH6 nexthop semantics.
- Add Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com

---
Yuya Kusakabe (2):
      uapi: sync lwtunnel.h and add seg6_mobile.h
      seg6: add support for the End.MAP behavior under seg6mobile encap

 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  61 ++++++++++++++
 ip/iproute.c                     |   6 +-
 ip/iproute_lwtunnel.c            | 178 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in           |  32 ++++++-
 5 files changed, 275 insertions(+), 3 deletions(-)
---
base-commit: 204a721033556114c81c47d00375f2d52e98e463
change-id: 20260523-seg6-mobile-end-map-6f5560bfb68e

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

