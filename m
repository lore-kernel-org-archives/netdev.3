Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C56FC5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763266; cv=pass; b=OxISpt80dV+bbwRF2ejan8b1ih4n7bKwpnt8g8DAZkNBG2gvE/F32dP3aWptih0Er/7+yFJXyb01NRGvhmma+SO6DKO8KI/jg7CqEDUaBXPyJs2sL71FNw22F4OhD8BX4UYza2jeOB6zDMSRnTWyNI4Xpjmpm3TvIf5zaG6k8KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763266; c=relaxed/simple;
	bh=/eVb51aiLoTZPo76+XhF1s6aUGtH8cwOHZxfUJnZmJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qYRZVPgwtkMTeEiVf6nUEGr/252LuQ3Dcj3bJ2ynFTZCRjzfaqrwjEIkqpsz8EIlWmKoKy17+tkcuVCSM8zSsU2ujXS5tOW1lHG7xKNLvr/+t5MOXRBpA8qcXA7xRjhRqCRZuB209X6YSaO0cWwOqnoSLyzOb3hThxYYYitIZyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vLnnYV2n; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vLnnYV2n"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-85377c8bc96so481941b3a.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 17:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791763264; cv=none;
        d=google.com; s=arc-20260327;
        b=jSVoqvtnUSVoF8NJxo4DA6bOaiLXyQHtN2XPsvY5/jbdRCgT85l2ufaDXTNpJYI13o
         DCVRPPHdYS7gUEmMEIMkazHEDxhud54xN4mu63JUuhtSGbbw2AwjyTP3YvyxgOxNqdbh
         3Qzl/zKR5K9IyH4e/pmuu5nc16l24Wb8aUgTYj3x3T6zGe4PxiFmm0vOwuTxlcc8sJpX
         5tFLW1WDCu79MVp423XPdBbkYEP1TU7DGfAdcxl0BRLvI+Q8CuOJChoEfjaaaARhndWK
         rp/CTCvS9l4Pz7eCefHIUvw8SERWEm0kYDqLMBozCSF7g1bZTrfMnMmH3qjxJ9/ICAfN
         gBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FdPTdSTHcvE2jwUYkG1pwEXG6KFrPTpT43gQS/R7sp0=;
        fh=00TA1EFqu8bgPT+f+LMnPCDzYCpV0heaxcwSrsm7aso=;
        b=aU0J7kZ9e7zCGDAtMkyz/xNknB/C1IWPg3UcoBVCwzwbGpnE3xPE4Ak9L19Ta94G2X
         4hdsxOj83NJMwcq5XV2WoUzJRy3yuCxwUtI1XzMiOzLeBHd9OjWm2Af7WBES/QRDetZx
         qGML5xVduFcVn4PbrzjT3mLqkBc2DyhP/ccgGfdrXWRdl0uwM57t8GUsEN6qWCHS1JBR
         3ZnDglYzCfz0TnPSQ6Z/TsrL+wtswz76cA0NcuBNGciZTv1h8Cs7bOUzUW1Y58Yt4INP
         1Mkem7JT2IZs71uXIZAw8Spm+zgzJwODsvDzwvLAV0zrEEDAZuyDl0dkW9+jtEjCXXST
         VUfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791763264; x=1792368064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FdPTdSTHcvE2jwUYkG1pwEXG6KFrPTpT43gQS/R7sp0=;
        b=vLnnYV2nmOkg4LInR0SObLjhE+z5e0X91VP3AjjXgvM5/PLz9mb1u5AArZdc7TTiVn
         qv9JrEOl+8iOwVBW/6MIfpS9xr6gf2g8erXoZtupRhx+Nw6YVyYFQ9o9201WU4HOxkYK
         /nyDjU7caHoPr8+hsLactmTLQCtQIeVUU5Ouw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791763264; x=1792368064;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FdPTdSTHcvE2jwUYkG1pwEXG6KFrPTpT43gQS/R7sp0=;
        b=ei1itLtRD/9qbFS/s7vQtK1QaFZb64dwFP67WJIGmeA4vDyZWQuuBNiGoImi7m1wtm
         HMuFGd4HY9ojbS9o6FsmUYYMfdUFBwBT9ZAQupM0kVByDIRp6yAaKqhDbqC2LqYF1kyh
         z5TVbEcxnYK0mSWZwMTQsIh7IcZpRlAeK6+xhhxx3n0Muzym5xmYQe9AKIgnKg2n8TiX
         pHbZelMuNvQWPYE4UR/SMBl2hDYW59DavF2GVW+KDZtVn+XQJPtTgoallOvzIfIZBN1M
         exCsYHqwbF4sItclzBFQzy/vF3vwTPhgk1HPyTYcbbw4TE/IZiN+wWLC0CFPVjnwSWcZ
         H5zA==
X-Forwarded-Encrypted: i=1; AKwUvByNxI9bC7GyNJEPLSbK3RADO+kESPlphPRRcnbC/rQVKSYXf5Hs1MKU4wQA+z/jJOVbgZ+3mrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkJ+Wl8V27CQ64WPXESvXWh+ZP3OZvcBjmHas2WoDarKqwjJuk
	iZArFMmlvkccP0ZdCEEwQFjHrbwKNG/pLnDDX951bejgwCt+9UBT96XQab79wtLQtLvNIQoAvAx
	/Z9oDn8IpB3A/fR9OuzjUp0gpBUmZ7pPVUkw/DFPu
X-Gm-Gg: AYBFou3vaXrTW3T6A/nYlq2mY5A/i5qX7KteRKCIzIWT5fISpW+DNcCDVHl+4R32kw4
	jZkRFG7QMisXmfeYXqPe27yFgYYBuSXxvfowHvcC1dz4b3rNvrOPMaSUQqFwEmIhZKFG0oZyOyq
	MtXvkfX8OMVg+gsDfPJsDM/7mBnr2QAQN8Bc6+YpU6bWgqjpbtoiGTTh2DbA7l2Zoyrmd1XgNs6
	UDgg4ns3B4rEQhBsyqQw2hM5JyeSaqq9+8nz9uj4azx9M3nvgfRffyJS8vsUaM6YNXkpWH9IU39
	H6V9FYhhJ+AP0zBJswpI1Mu059QggDye5n0zUBmBVKBX+IHxI0UnsFZCscnAMNJt25G+xj+zNZ3
	tbFQOX6pIDTfrb3lklLLNsCPnoNgN9yYnAg==
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-897c3ff538amr6409692b3a.3.1791763263617; Sun, 11 Oct 2026
 17:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 20:00:49 -0400
X-Gm-Features: AclHuK9ageku3n-y1VbBhtDWxP_mIgLctOxdIk013W-IfXTTayhTYte9JAaENEE
Message-ID: <CAM0EoMn6JoLVHdhX1GB1wBcw3fVZ42ePKXDqsWK-4STj87vEEQ@mail.gmail.com>
Subject: sashiko or lore confused?
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Some threads seem stuck somewhere in the ether for sometime now. I
asking because i have a backlog and dont want to flood things..

1) Sashiko nipa review is missing on the act_api duplicate-index series
========================================================================
The nipa sashiko never produced a review for this series: gemini
sahiko reviewed it ("No issues found").

  Original posting (v1, 2026-09-22):
    https://lore.kernel.org/netdev/QDISC-K1TH.v1.20260922072206@mojatatu.com/
      [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch

  Reposts (same content, no version bump) after Jakub flagged that 2/2
did not land and Simon on that repost  it was probably the W=1 failure
that deterred sashiko from reviewing:

    https://lore.kernel.org/netdev/20260925082237.xktTTrRQRmp_V8OKNBxFnnUlj6a452UO12AQPOXYlPc@z/
    https://lore.kernel.org/netdev/20260925082238.ApYMOyeo4f2cyHtNpBH4bmakwqO17BYdV-HiDQLVM3s@z/
    https://lore.kernel.org/netdev/20261003095453.4jiXbPK5mkXck0VOLiLu3sM9l-NGfDiZ4G96YKNDV-0@z/
    https://lore.kernel.org/netdev/20261003095454.A4i__8DE05M3wQB_gihs9BDHXVQXu0XpMHEs0y-k3Ow@z/

  Thread traffic:
    https://lore.kernel.org/netdev/20260924102910.09e9c601@kernel.org/
    https://lore.kernel.org/netdev/20260924103222.239e3d45@kernel.org/
    https://lore.kernel.org/netdev/20260924134244.1824ed80@kernel.org/

  Sashiko:
    gemini:
https://sashiko.dev/#/patchset/QDISC-K1TH.v1.20260922072206@mojatatu.com

2) What is still left on these two?
===================================
(a) act_api_delete_duplicate_index_refcount_uaf (links above). After the
    2/2 delivery glitch and the two reposts, is anything still
    outstanding from the maintainer side, or is this only waiting on the
    missing nipa review?

(b) teql_xmit_path_pre_existing_bugs -- series [PATCH net 0/2] QDISC-6HS9,
    sent 2026-09-29. Both Sashiko providers reviewed it: gemini "No
    issues found"; nipa one Medium (commit-message doc wording) plus a
    pre-existing, out-of-scope item (the consumed-skb UAF, tracked
    separately). We do not plan a respin for the doc wording. Is
    anything else outstanding before merge?

    cover:  https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com/
    1/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.1/
    2/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.2/

    Sashiko:
      gemini 1/2:
https://sashiko.dev/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com.1
      nipa   1/2:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com.1
      gemini 2/2:
https://sashiko.dev/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com.2
      nipa   2/2:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com.2

    nipa review replies on lore:
      https://lore.kernel.org/netdev/179077366943.434549.8458923511073715827@kernel.org/
 (1/2)
      https://lore.kernel.org/netdev/179077367081.434549.3367341827161501919@kernel.org/
 (2/2)

cheers,
jamal
