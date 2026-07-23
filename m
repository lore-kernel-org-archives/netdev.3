Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BF3DA7EC
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834123; cv=none; b=XnDpTRsjvDyuB56lMYJLKQwXrGS5ZpWw3heBQyDvU9u1FAyIwKJZrtIa1TajvhMpz6c/CiFWd+7L0oMWXPDVSJDbpVYBw+HqNd+0NyR3gBsS9EspfheR1LDI9FTNyL0+d5kVtkyj5EYIBayLm/7I+uSP8DUCUBZ0gkI+0AgbF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834123; c=relaxed/simple;
	bh=iQRcAPrmkOCIeOVpLH6hZr2n8wEx2fjCNbhofcKZY1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9W84CiV+TzvE9zBaiSeOYff9G5LZwbmn0CcprPtJH90vrdFGbxkjNu+HRi0EV1ffejTAcnGnPD1eWEAIdd+HawA6AfbiJtb1XD0i2Ype9VQ3DITRUuVrx/KP1RBSgP6ah6d0B17Y9fUTcUg4jeyIwHf/4ME+5w1va0TsWf/kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mR4Oa0N4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="mR4Oa0N4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so776052a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784834116; x=1785438916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sq2wqK2oRbgH1KHTbEc+JZ77imTO4AU1+FUxyEKsank=;
        b=mR4Oa0N4Ejrz/66OoUbagNkEIZAPqil4yvyMLK9c6JTf+35OajVUbLIdFHSKMI3N/p
         r7L+LWRWzDHVBWVWUqNmI2GCkpBR902KXG5QpJvYYyYVxM7lp8htvO+kWtKe0qtavcli
         9mjZv7XORKQJ7yIAL/bXxIApf6q7FObCFl5hptbGNTyoDFSXC8VTxR29EEX98wIES5ey
         Y2RzuUKANL6TbSa+0yqDysnp0FXlnjj6RuUmj1ehbE0UHj+Le1rKiac9hAqEtO2gFHlU
         gQ48vAnVaLYkxzApPUMddRH65RIDQbOuB3HarIwSaaMk2Pn/SrmzRDxNZcTqPmhpXl+U
         Btrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834116; x=1785438916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sq2wqK2oRbgH1KHTbEc+JZ77imTO4AU1+FUxyEKsank=;
        b=DvLPzf67M25FagPu0l0Y6DgMNGl9cIg1ltp0Kz5qFAKtIBLqZ/MRJw+k9nJZPxV1cm
         wPMgf8zDvU4L3/pYOhlR3t9X7F6quQKVvmbVF35l1i0x878uNrRyGY73KaFOU2a5Av6D
         qOeBRd4mWq+v4tVmkU6Ty+SjojsEwcZn0PqmhBTRWuWLPRqA4Qbzyb0cAw8j6wKiM1+s
         /+YL+IdFeFNFP7P7//lpXNpfK//hUIFdBOiT8gyYIou60DrYzc6P+vhSqtyWkj6giFhY
         j+vcPke8d6FeWqtezX8p9Hp07BSiQqdceTmOPw67diwZwmOc0LV/cv1fy8UW+Mc4cJIw
         mzUw==
X-Gm-Message-State: AOJu0YwvhfT2DHahNRRsZ9Bw2l1n92V6QcslmIVcjeLin4Fo1Q0dDy9d
	QK7Eerp/MImfYW2wNVsJFsjUKKj9f1eetEwKBXEna9C73K3MzSwmZeyTXXAtnREWyDmAz+F2tg+
	hC1Qp
X-Gm-Gg: AR+sD11+nQzTRwOyZmekA+GwMXrOm5pBewnp/YEUA/67AzYboUaFgj037hHWr2iNnnx
	vTfpfDnLN5dkEfTzWCw+K4EMbh5A0JsV4T9etCVHCOEoNomgPkuunO8SzlG7bf1I69rZJQJdtr7
	gZOXMh0ejakg8Cf3ciniG6l8ClfYmMPAGEzQYwqNLnD5+Wukze5W+ZF2HkhDuj8YADuaYPHQFV8
	CBv61zteJ+7tWRhvlZE+DgAn2QE7lpEVp+ErlR9muOMNoldT9KnpOeNKVVhKdvcaqMJMvW7v6yW
	APRpGnkZkM8lQRBAR+yLaBiXXEKwSVLT0Kz15gkfwAf2d5dJdu7oQFmDcuCJ7AkH3LQPlWKvplQ
	2qWVNgHUd3w8JXTspMnyQqGPPjljNt0dmAstOghLkMKTLieLOtIJvL0SSsdT3X8bp3u8G7nq4Cm
	btlJeoeZmifx+RgqK6a4Xv7rE4ym3Stv7Cet7/raig
X-Received: by 2002:a05:6a21:e081:b0:3bf:6237:4d49 with SMTP id adf61e73a8af0-3c44affca25mr4898646637.23.1784834115656;
        Thu, 23 Jul 2026 12:15:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm11843090eec.8.2026.07.23.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:15:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/3] hexstring truncation fixes
Date: Thu, 23 Jul 2026 12:11:37 -0700
Message-ID: <20260723191511.216182-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an alternative to Gris Ge's "Fix netdevsim switch_id display
truncation", which bumped SPRINT_BSIZE from 64 to 128.

hexstring_n2a() writes into a caller buffer and silently truncates when
it is too small: the loop stops once fewer than three bytes remain and
returns the partial string. A 32-byte netdevsim switch id needs 65
bytes but SPRINT_BUF is 64, so "ip -d link show" printed only 62 of the
64 hex characters. Bumping SPRINT_BSIZE hides this one case but leaves
the truncation in place for the next key wider than the buffer, and
enlarges every unrelated SPRINT_BUF on the stack.

Fix the class of bug instead. Add hexstring_alloc(), which sizes the
output to the input, and print_hexstring(), a wrapper over print_string()
that formats and prints a binary attribute with no caller buffer. Move
the print-and-truncate sites onto it, and rebuild the ct label strings,
which open-coded pointer math into a fixed buffer, with hexstring_alloc()
and asprintf().

Stephen Hemminger (3):
  utils: add hexstring_alloc and print_hexstring helpers
  ip, tc: print hex attributes with print_hexstring
  tc: build ct label strings with hexstring_alloc

 include/json_print.h |  3 +++
 include/utils.h      |  1 +
 ip/ipaddress.c       | 19 ++++++-------------
 ip/ipmacsec.c        |  7 ++-----
 lib/bpf_legacy.c     |  6 ++----
 lib/json_print.c     | 12 ++++++++++++
 lib/utils.c          | 21 +++++++++++++++++++++
 tc/f_bpf.c           |  8 +++-----
 tc/f_flower.c        | 25 ++++++++++++++-----------
 tc/m_action.c        |  9 +++------
 tc/m_bpf.c           |  9 +++------
 tc/m_ct.c            | 24 ++++++++++++++----------
 12 files changed, 84 insertions(+), 60 deletions(-)

-- 
2.53.0

