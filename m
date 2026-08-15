Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAE1C2324
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757581; cv=none; b=YR5z4GiAFWTi9BRTQy6WPvb2bWzAHEvB6kkiO861SZqoCX/7fh+UIYdTr1NYib5Jb5l7i6hMwM5sl7eiYxCCT0LKngaalDUDthTIuJk19KiC27RfaC7QLRQDd+BLM4CbRFjanexYv5ZcL1fczsYqhTrbxcHWeWaBIdE+8cpkNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757581; c=relaxed/simple;
	bh=mDgAsKs6meo//NBXXLbI4OKPjgjud9Wvq+usYByvNDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fo95zuv+LCO6rCxX43V0My5IFV3+Cg1AvJcveDJ9Tk+Vl0tSdEh8YPBjT7g6SM6tn4cl6qdCGt1PXm+nrBro3pxCKC3Vx/PqKpd+S7hgIbGaZ9x34r+CeK8FVlngjjZMC6abvDI1uIYj+41BCOlZ1FHEh/wph/W5WFbRnPFklxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5a5Jwzw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5a5Jwzw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso11343045e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786757578; x=1787362378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+EBtOS3yArt80y5oN+qnjKWVwEXEBrwucchm/mxHIo=;
        b=K5a5Jwzw3tm37oBhTUkKHQMR82eb1IGEfsZ1l18+RcsHFlgC+4on6OooCAZmQF+vJl
         B7lojnRhXV852EbJyAamAR3NTRkuz5hRWJbQ50mWLtC6oZtQDdRKErgXaWtd+rjEk7iM
         Gq6wJkCZHvkBg22ZfaUilig+7Y3lWXKMKmDO/uGdyq4/P1/pUM7ccYS4DRUKnQDozMRK
         OU5OTyPtgMTtJDcF/CdbMU218X4kcQ2HgGlTfy/Z7e7srxjecaZ5oxuUcfNmuqVFTxi/
         rS1Cga+rSS/oKfWwJFwTfvFXBMBoX/IpUT7h2u7fqBOaXhiyHIVck3i3RQgs7y1mfjRA
         W0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786757578; x=1787362378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+EBtOS3yArt80y5oN+qnjKWVwEXEBrwucchm/mxHIo=;
        b=VrZ+9FeuRD+WH/Qx6ZkLU/eeEysPLGaup5/WIhyuQOkvqex3C5nmrnMclhv07vrLgd
         xrMshZU1sojTnfPfecHodaq7Tyexe1Jy9LxCSoKLqbS2Zlhh3sLeSN6Qu/g9KmWSDHmk
         446LYUfOezA355WHBsL2lR7X3enV18Z+p3GEiuSFz7c7RWernv3OSTLxB65UJZ1QonNs
         2aNeZfPd9JAOUvymGlsGKjPYOYZ5mvXLL7nZXGSoNnF64L4FxHbC/njzc4BGunfR6o7M
         yhi1xKHFBDP7uD4A4fKb3KOtATbKdfz7+Rqg044tZ9RDnpdfo8W2Onri6m4nn3n8N4o/
         BchA==
X-Forwarded-Encrypted: i=1; AHgh+RrNR9iMU5cWxgNUTztJ4msbHi1hLw6HZZJveR13hNlnRuBB1+1lQ169tPyl/xIsNs9FygGS4oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/76GbTKjbLFc0GrXZlZpJiCATEjR9RksyOVkwM+f5gz+Nlwq
	QQ+3CYMS3W76grLH5bALldswteOLVxPA5W8qLodp+4fvsbLSdn6Lt3tP
X-Gm-Gg: AR+sD11eSw4iO/PCso25pIppSoxrPa5jOYlxlUiC8/30vwzAfO55HxhSdJb+vmCdAkq
	44xCMIxNs6mn2OYtjtVGxNqP1zKOtaT4kZutxv4XO7TzJ4N4/c7vIqGlEKI8wov5jqB5Uh2DJxr
	Ml0qcd6aSlyxmHtAhs9cDdhBagWm3iRgN8ybj/VNVqICHKiceqwDcsd/Nm487uM5GQ0uL8sU3YR
	GmEl6nUHXEm2o713NnUbdM4K732QCbVUCkYs0VLcbakf0ugEHs5zE43Eqp3+VLkWD1ghNMwS2Fz
	VbyHZ7+FWPnqPTM/vjW233mbxIujKV4AmBaAl8PPcgjxT7zn5BAYlTbum9mGkertXsj2Bd/daiL
	mTAVl+hHbbNITKlPDIOMp1TYIUhra7bpsfLi/BtTyFBSUIB7VJgTW9PCd1DCRuWzLT6ryFGGSLy
	c8MBBSV/MxHyOY6M1tCzNY8hLiYHkitMgiVQFE52tjdgSE3J94/cgxwcDybWpeYVcIOCm8wT9x0
	KIbzyT+o8W2UzI5brTaJI6igmiOqzqcoCPmeYXv/ttp31oIDaIzMNW9sRIcScG51bDfQhhG0vO6
	sLu1OR9iPxlQkkdF0v3YP4ODdsSme179EnmMIVNkJkrPrw5n1wCNHp24cDpQ+26SufXzQe00xp2
	Zgg0=
X-Received: by 2002:a05:600c:3491:b0:498:952:e276 with SMTP id 5b1f17b1804b1-499879653bbmr149398885e9.8.1786757578369;
        Fri, 14 Aug 2026 18:32:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d7d-f301-9495-44ec-73e6-1be7.310.pool.telefonica.de. [2a02:3100:9d7d:f301:9495:44ec:73e6:1be7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b1a31esm110672885e9.2.2026.08.14.18.32.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 18:32:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net_shaper: fix kernel-doc rendering
Date: Sat, 15 Aug 2026 03:32:27 +0200
Message-Id: <cover.1786751700.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The net_shaper_ops documentation contains a malformed ReST list and
exposes a kerneldoc.py title-context bug which drops valid headings.
Fix the list first because the parser correction makes it visible. The
parser fix also restores three Xe DRM RAS headings already in mainline.

Tested with Sphinx 9.1.0:

  Docutils 0.21.2 and 0.22.4:
    make SPHINXDIRS=networking htmldocs

  Docutils 0.22.4:
    make htmldocs

The full output differed only in the intended net_shaper and Xe rendering
and checkout-path-dependent build artifacts.

Changes from v1:
- fix heading parsing instead of replacing headings with bold labels
- split the list and parser fixes
- add diagnostics and point the Fixes tag at the kerneldoc.py regression

v1: https://lore.kernel.org/netdev/20260813192131.21254-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  net_shaper: fix kernel-doc list indentation
  docs: kerneldoc.py: preserve headings in kernel-doc output

 Documentation/sphinx/kerneldoc.py | 3 ++-
 include/net/net_shaper.h          | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)


base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52
-- 
2.53.0
