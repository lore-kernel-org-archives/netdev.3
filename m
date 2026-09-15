Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786153AFB06
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508214; cv=none; b=TW59VULl0Wy36ylsJhoNwPeJRUgVxuDrdLFxGd35YJr+01P4WzJBz24ecr7PYv3YZ+znOoMSrdfnrvi+xyf/1CXPutBUguVrhDXe8U/grK1AnjYmye4U7aKaPPe0Qafp4+9HHA4EyuaMp+ma4ZZwrupXgdAcMMs7AUFTZsX547U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508214; c=relaxed/simple;
	bh=J2RAxbBdegPC3ppmBYJBGjZ+hCtbx1xz4X111FRTmt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqtGmu/Qh1Jtha2qkvIVzik3v06Iahj7/qtU5kJ+JJZNw9S30vXQVZ8v6QzTtwDWkYpPFYO9Vfa491ssfXew/FwK/pdeKFWlAKPbU3J+SBal8ZOZQrI+Tr1S+rJypLlUHUQi215qWUuzXA4XHE65IW+vnhqaSC3iKYLJYLKlPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=JWuzi948; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="JWuzi948"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so158385a91.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789508212; x=1790113012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4/OSJoGFMSnDQQp9GnXLsgJ4+G9fP5VQcpwbpvMfQo=;
        b=JWuzi948Pwjqsj3jVD/nwTx2ZcYGo14vhAhRLWW1vrOC9IOMESHILgjKw93VEc7Xhw
         SJHC/fV6+0IIG80jYyjhVGuspRb/VCFAhQT/fVvISwv5lROVKyqMA8pEyAE0Ax8jkYjP
         A61TDfQkECkmVyrbXcrcsQ1kOjxxtsZdOuSaC/tfy7XQv43PcNYo+S/fixcIB994xeRS
         eMda8irI5ij4q8lq4i7Zid/BEvzDgWWtidMv66TCIG1X1p1ikVQYh1p21Cr5dz+njHyE
         XF47ZGcRA8BzkLiJDJtvMo93hwZqBTT9n/4vo1bcztQXkIZvLEcGhpZMDc9tXR1oTnld
         5Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508212; x=1790113012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4/OSJoGFMSnDQQp9GnXLsgJ4+G9fP5VQcpwbpvMfQo=;
        b=1sUR8Xi5ZNx8kfrMA0Q7lcxpxmECtul8xjHGi9kf5q2y9PS3MoW01EwAT3X6Lbh0uU
         UuNWWM06wp20YASQm5+lCzeia0hlPKAwLnzoOS0SQI56iikDwe+Bi22vOhKmTqe9RIPR
         Q0TUR+3BH8WV8uY1oV6CSgGLrd5004Kty9Y0+fNLqJNPtsyeMjhmvB+cgbOgXOvjpSKG
         K+K2zkH+n42WR9JpZcgGWWj1xVnVfMPKf2C1Wfft8j0KHBRvPGn3A0EOnF/8oOql69CT
         mLF7M4fAWP3DWZydzZrV6hLsdus5VnZRNmHuwjRYFADGTPz4fa+Y+hAMMGAqhrv3W3nU
         YHnw==
X-Gm-Message-State: AFuF++ku1lkoA9LHa+G6yFTX709ikHQ5ko80rgCl+Jt5Fr6uDOmlQR3/
	oNgU95sRmT0btJFaDvXpozGAHFYed5yWprWdmbq+E3m86Xw+w4M1pTRlAtPyZ6gyVWi/RvsXfmN
	RZ4U0cSbYnQ==
X-Gm-Gg: AYBFou2fF35tdaVph35lHXci26C84cAUIn0WUQf/lXCkkRPz8Ooak+dpI/Qos1BQx1m
	49v/71QNm+dgiMYZehlNjYrNOHjbPPooS+tqP8aNu136F3R4U7hF5EjcMMNUl1/Ie4sJIV0G+uT
	WYhitIehKkofMboSkLLB9uNiHdnvReAvhvHPhMUUmzSo40sk4/JsRdipd/advkS5p+sSLdRRNk2
	6FLIuUQ4p02RdIyi5a0o67bc9X6UcjRjEFMsRt+sHdCDleGDDtPYKozcDGv96+4ry0Y4a7M06wW
	5m9dh1EEizdvuGCk0tD3U1awLGONNDXL3628wbfIBsOFNDivhlU67A6p9cgYq0lCN+b4BCcVpF1
	zbD+d1AYtwzbUM5Jt9tu/m+2P9ToTQ93d10mY8hBARWdB6M3EWkv3oUb7lDMyoQhz6tyPzKOqOo
	dnjD/8f2qZtMxF7cAsFnhtkfZPY5frtcBBnpRU7j2sGKI6xihm0U8cw+3SfA/GHkPXU7qYRtpmt
	zoGvKqCGTb7idIl88J0zhD1VaGHNE2340kGuw==
X-Received: by 2002:a17:90a:d44b:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39e1e51d96bmr416283a91.22.1789508211589;
        Tue, 15 Sep 2026 14:36:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc37f58sm608504a91.14.2026.09.15.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:36:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC PATCH iproute2 0/3] ss: follow-ups to the packet/netlink /proc removal
Date: Tue, 15 Sep 2026 14:36:01 -0700
Message-ID: <20260915213646.116214-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
References: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the overly wordy AI suggestions:


Commit a2b31976 ("ss: drop the /proc parsers for packet and netlink
sockets") removed the sscanf() based /proc/net/packet and
/proc/net/netlink fallbacks.  Reviewing it turned up three loose ends,
one of which is a real regression from that commit.  Sending as RFC
because patch 3 changes user-visible filtering behaviour and I have
not been able to exercise it (see below).

Patch 1 is the regression fix and is the one that matters.  a2b31976
removed the fallback but left the code whose only purpose was to
request it:

	/* use /proc/net/packet if all info are not available */
	if (!tb[PACKET_DIAG_MEMINFO])
		return -1;

That -1 used to propagate up so packet_show() would retry via
net_packet_open().  With no fallback left it is returned from an
rtnl_dump_filter() callback, which aborts the dump.  A kernel that
omits PACKET_DIAG_MEMINFO for a socket now silently truncates the
listing at that socket rather than falling back.  The check is
redundant in any case: the code below already guards the attribute and
leaves stat.rq at 0 when it is absent.

Patch 2 adds a diagnostic.  Without the /proc fallback, "ss -0" on a
kernel lacking CONFIG_PACKET_DIAG prints a header and nothing else.
AF_PACKET sockets exist on essentially every system, so an empty
listing reads as "no sockets" rather than "ss could not ask" -- unlike
tipc or vsock, where an empty result is unremarkable.  rtnl_dump_error()
deliberately swallows ENOENT and EOPNOTSUPP for NETLINK_SOCK_DIAG
precisely because callers used to fall back to /proc, so those two are
reported at the call site.  Exit status is unchanged.

Patch 3 restores packet_raw/packet_dgram filtering.  This one is not a
regression from a2b31976, but that commit is what made it
unconditional.  The SOCK_RAW/SOCK_DGRAM check only ever lived in the
removed /proc parser; the sock_diag path never had it, and since
packet_show() already preferred sock_diag, "ss -A packet_raw" has been
returning dgram sockets on any kernel with packet_diag for a long time.

Open question, and the reason for the RFC tag: I could not get
"ss -A packet", "-A packet_raw" or "-A packet_dgram" to list anything
at all, on current HEAD or before this series, while "ss -0" works
fine.  filter_db_set() sets f->states and f->dbs but never
f->families, whereas -0 goes via filter_af_set(), which does set it;
packet_show() then gates on filter_af_get(f, AF_PACKET).  If that is
the cause then -A packet* has been a no-op independently of any of
this, and patch 3's filtering cannot be reached through -A until it is
fixed.  I have not confirmed this and deliberately have not touched it
here.  So patch 3 is verified only in that it compiles clean and does
not over-filter the default "ss -0" path; the case it exists for is
untested.  Review of that patch especially welcome.

Patches 1 and 2 were tested on a kernel with packet_diag, including a
simulated PACKET_DIAG failure to confirm the new message goes to
stderr and leaves stdout clean.

Stephen Hemminger (3):
  ss: drop the dead /proc fallback trigger in packet_show_sock()
  ss: warn when packet socket diag is unavailable
  ss: restore packet_raw/packet_dgram filtering

 misc/ss.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--
2.53.0

Stephen Hemminger (3):
  ss: drop the dead /proc fallback trigger in packet_show_sock()
  ss: warn when packet socket diag is unavailable
  ss: restore packet_raw/packet_dgram filtering

 misc/ss.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
2.53.0

