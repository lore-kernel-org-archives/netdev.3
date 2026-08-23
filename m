Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F21BD9C9
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529150; cv=none; b=VG6hQrvqCcyi6xLmgflEOD0axHkJd+xdK5gGW1uzf+nkMXlp8igafTHkmy0c0e3qawUU+as6G/boqKQqBeecWASeuNzqyKInUpur1KDHjPaeXWoaStQI5PD3syPh7H0rjsd7/hkO7pff0LofxEIKhVpRkiGDlt4vPdYJfSTNP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529150; c=relaxed/simple;
	bh=+xSCnQ6j3Nkj3BG0yL8pd+ImOm6GHMzMwdo+1df5Tko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CPKXSjn804EXMkZYc/xwmw/N9gwFSc64smRqum7qIAjgEry2m8U4OEf/yvNGhQaVMYdwIw76OHyw7g25aGQttACGVsgLJiSwu0pCl+XcyWnL47n4LRuol4ZdFVSyPc4/55ZxU0byixqYsPjtoNDxOdobex+lDWilWjVugFQYu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=TKWh0yru; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="TKWh0yru"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbb7926836eso2055371a12.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787529148; x=1788133948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZhA8/jiSjmNEFUUYtyZESPG/YPoGe0UeFYWejYxdOs=;
        b=TKWh0yrurtJ9WcrGu1uxE97ev3zJqtrgAP2ELXAjtmge3SlehvUHQA4+IccPPnSaxW
         cvyKz2w5DslRstiMgor1+dm4/MdRTyyxnYZBCYqm4CUU6aQX20HbUCRIlbMlJcEzAaYZ
         a/uwi0riE7R21SkEos0qQrccFwWjDjqZpJqGG6GGbqSZRG6nTT3hTdZXPoWgh80XrEeW
         8XBfiFwx6jp63WcQGVkEL0j4Zw5QHcNtF5HfFqOMtPIb93Ek/F/bmp7Ennbo6G3k002Z
         D2ffhBD9IDtnV1kSvrrnHrXnLJsf8C4GNXlo+k7IySreMHU2jEOoKzoEITAaxFgI6jWF
         5SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787529148; x=1788133948;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ZhA8/jiSjmNEFUUYtyZESPG/YPoGe0UeFYWejYxdOs=;
        b=BHbcfTXdDSX+3inuOjbheUk9ts7ZI/aLUQhJsPCNiPFXSfHi3l9pBIjcDJP7f8mgny
         +BO8aV0tnt6AeVL74OGvuLmbh6uPDSbexA8nN5TfJih1lDlEpBJ5ir70RTt7w13Xz+ML
         Oo0ueLy646ZwwLVel6pcvdmtW4ltL54TEvFqmg69uJ73c7jDmC/WSwKBwJKicxjuWBAF
         SLCMxBb3IsET6wktzCpjPiXY5WnunC7Tdxcagz+BmryyyAT9kn5qkPKvMS6ZgOXlHYvU
         lOhGxXfr0mde4eX4KeLpdtK+mjRhhE2kPQTxI5Jri6TghXAY4q9ZU/xgIE59GilNInEh
         04JQ==
X-Gm-Message-State: AFuF++nlmW6XOFGBdS5zqrFER1ouYsNDCeJaRNr0iyKPjoyFKtu3DPJS
	NjiLvxK6cm8S7Q6/dp6JE8WCvqCkoxQz4nECtzhmAxNBAZ49Bk+/lHLlN7DrzbSIv9hOhuDYfWI
	83g+v
X-Gm-Gg: AR+sD127wpAA1jo83WFMymIuazhhptSNRJvM2noBFpeX+xf0mGROEz3DXgBuTwdMkHg
	Zu2HEnmBFVbdQezK3p23MZIYL30lPLtg7aKoqKZCTX/jtIjWA5JR86coeHFKjShqhdICqAmbnZe
	oUs/T9B/9vqwAChMya6mxl/usID9DcZW23paEdsY78ge9RwSttahFNbavw4Twu04B6+X23XJs6C
	kj4o4HV8RJxbDSOPTZ5nSXl4ofvEJQOvT3R3jjGjrCAdBKz3ZSs4fCU9UwmwhQ+YkBg6D5yZXxs
	+b/27WZmF9ngiDxYrj61HJZoL0UuxEGmHWPFcbVQgANQMo72RV0PtKGwRXh8kWKJg93/pULskab
	R8veQmkDSfwffh7Pwjrj1UB3l/doK3Ig2GDE53Ar2yaxVPrFOrHCUwwFQiBkuifzKv4kSGonCe0
	NNz1rTLP3HCoZCJGWvrKyy1Vr33Tiv/1IORWnRuAqVuWWNkdCEmCI3u6Wr1Klt+uzXmgDi8pAGO
	pDWWzyZszbOUJB6FpQ57tP88GI=
X-Received: by 2002:aa7:88c4:0:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8520b942d1fmr23151679b3a.1.1787529148083;
        Sun, 23 Aug 2026 16:52:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed243csm1387573b3a.12.2026.08.23.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 16:52:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/3] compiler warning fixes
Date: Sun, 23 Aug 2026 16:51:30 -0700
Message-ID: <20260823235220.79790-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Three small patches that fix warnings when iproute2 is built with latest
GCC-17 and/or Clang-21.

Stephen Hemminger (3):
  json_print: fix Gcc-17 warnings
  lib: fix warning from ll_addr_a2n
  tc/f_u32: fix const strchr() warning

 include/json_print.h |  4 ++--
 lib/ll_addr.c        | 52 +++++++++++++++++++++++---------------------
 tc/f_u32.c           |  6 +++--
 3 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.53.0

