Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440388;
	b=XrheV8AMxnv4PKyzZ9siHn1UPBIjndB4GdATP7ZS0/CWiQNw46ROzO/hNRGrCQwP8ibr
	 mEHyD8q2qqOrG3Tv/0iBfr5oAIQ11YtRVCT8KOMxRixWC1YjisRnp9LWBntPaBinxo5pe
	 Ti4KvMfJ6VBosDC+RdeNPUVo38EeaW9ch+vgljYLxAnLf8hJHSlyNhqDReFBA7rR79vi/
	 4gSKJqaK7HREAhhOJKH7ES3a/jhUT6X1ITZvJWbnX5Y/HhqyZ/gPx9GIHfwDE6e84n9bZ
	 p7fSds0OdStGryvg0QsvFYf00q0YrnFwFHZDvwSmUZ+t5XM1P2gj1ovzoCOkV9P04BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=V7aoMAt7nLdABcEGS/L+1z1bKpPVFdZyHVrN4B0HHZ0=;
	b=CB6g5awvSYynzuS6F4qsrwyjQo8OOTtAp1cjM66IN6mGwnQMLMpnI0ew6PPAGmTZFDh0
	 mxkeGwyVz6RFqJZcWbpLZSH1LaSwVHJpxTmgw5BYr0qCTvIXfrV7WsqVwIebk5FXdoyGm
	 Luprc6OHB3zAU2UzEqdud+ejBW8vDM4jn2QJQ6SLazDEwlxymqroThpswnGxcinmHbup5
	 wSuEKNId5meRp/UVFoUMaoXECtQzJnOjXAeYbC6krpmzx1NqUu2Y7VWUU6p6iJlbhB9un
	 fNPrWPLjYFhh0mImaQPfxwZKldo1kH7T5FIYxc5pLS8h2EEcLF+6y5oNGhExK+Eo62Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sIQ5rOeC;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE7606A320
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDE7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sIQ5rOeC
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1331819a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792440387; x=1793045187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7aoMAt7nLdABcEGS/L+1z1bKpPVFdZyHVrN4B0HHZ0=;
        b=sIQ5rOeC0XaCMUd7ope5kVJ9mQRi1sxq6WK5jurwQDrHhL5Nf3peh9sKx04gJKKzXY
         A2PvruLsbylktKx0m2MzOlTBYrIpeUa8rjOFhVjLXZhxIoQsz7kQ7OgEhUMI6ao3ngEc
         NnyEKcQBnH7K3R88uTrunwC7TnGM8W6GcIaRtiWzM3T/iFg6kHcgzIlmYfRAqG9tZ4p8
         lV3LdM7tWY6RX9Tz3Aww3yRitjn9Hs6yq4HNNvFZq4pLKsU+O4CddSvvqScBHZwOeQ2p
         E1+2nnTlkyXYjF83VH7fYmMrIoEW3zSD+BQZ3/+2GyymmNB40ONvL8yc4KRmLeoRwyXz
         zylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440387; x=1793045187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7aoMAt7nLdABcEGS/L+1z1bKpPVFdZyHVrN4B0HHZ0=;
        b=W1hYFsIdu1IqmioUpNH3KhDIHdM+qezU/ILNLwvwtjD7bQ7H3HmUDT3EPMGR2VL95M
         WJqynYirfXdhtfuKc5yLGyeTBaBxfuIqVaERYplxcyt9K9pJcqMRoJyHoaklnJUy8pDf
         3/FRPPa48vFO+vcShQOHzI2qLeS8I2e5H4MfmA8FtwNu8vN4UpyhishMPbFAcBMGJy1f
         DsGzPD9xum7+KQs8fkEW4x32PIqaqjCtqh0eKvVrvFx5zs9qRDq8VkiXdGhG97GPpzdE
         KTkPsze4kbTcEN/kcavkmt2WVXKiuRqgmoktTw8Bk8tnuGd4LxQEvXv6q0RU7/7rN9Uk
         bXmQ==
X-Gm-Message-State: AFq9FYJrYO55Mf6BLwRu2GX4OsuxI0cO331iNdG8lvz9biJCcekVs7jq
	IPr4w57SPCyZzNMbk39c5pvEVVQLGkkdz8boeKZ14IFHnAsfAL+mCBEMWzGye2BhNH87gKSmihc
	2j7hYubw=
X-Gm-Gg: AYBFou37FIUt1AY0vITB5bi+CQ3OkO6enAFxo+O8U64LHsvNmgynZuYDN9lulbYpbJF
	iVfulWHMmiodoL4Xi+GLUNSE3gagmSx6X5kLrh8cRAPbyKNwQrZAv5AXJ3e8HIX/JTOC43S0T3M
	c3A89N1NdsrjLc5uGQ3DE8O0vdj52+zB8MyQhTz/z1Dm+GdItut/lE7IrMHHE1J1+5a5aFMaqpF
	5unmVaKMF6rAZI6mROdyACmssbOkSFCXAsONJ2czI/XD+BN1MzIgKWES/Oca1E1dkdWXOnUtAjH
	qLRnEeUv4I0J8sk+XPnivg1X8NY0R/EQnGN/AHYkfmbbJUL7u/J88McHyMdNzV4gkUolmpSB166
	HenFUMJ0Wy8VaNlBTUiDNnECK3RQ3X5qSXCPxzshuhWtNZWwpERysUzofszzXIgjonTaCS7H/LJ
	BDc0yXDFlj7oe5mXsV+DYfKsUponcKCtWLtplkmXPnXEBz5DCfxptXbCEV5E5Jv65YC2hQjoJ5r
	h5P9cXr0Aj50EmT3ip1cvIuBkaQC9/Iot7N0g==
X-Received: by 2002:a17:90b:2f4d:b0:3a6:fc30:ce16 with SMTP id 98e67ed59e1d1-3acef167363mr7118045a91.51.1792440386963;
        Mon, 19 Oct 2026 13:06:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm4492935a12.1.2026.10.19.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/3] don't build printf formats out of names
Date: Mon, 19 Oct 2026 13:03:01 -0700
Message-ID: <20261019200623.816470-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Several print helpers built a printf format string by concatenating a
name or key onto a conversion specifier, then passed the result to
printf as the format. This is unsafe since '%' in name would
be converted by printf.

Most of the affected names are string literals, but the rdma driver
attribute and hwcounter keys and the vdpa vendor statistics names come
from the kernel, so they are not under iproute2's control. No failures
have been reported in practice. Each patch passes the name as a normal
string argument with a literal format instead; text and JSON output are
otherwise unchanged.

Found by an automated source scan (ANT-2026-JAWA8082).

Stephen Hemminger (3):
  lib: don't build printf formats out of names
  rdma: don't build printf formats out of keys
  vdpa: don't build printf format out of vendor stats name

 lib/json_print.c |  7 ++-----
 rdma/res-cmid.c  |  3 ++-
 rdma/res.c       | 10 +++++-----
 rdma/utils.c     |  4 ++--
 vdpa/vdpa.c      | 14 +++-----------
 5 files changed, 14 insertions(+), 24 deletions(-)

-- 
2.53.0

