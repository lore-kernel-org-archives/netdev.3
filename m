Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B433A9870
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508219; cv=none; b=tH9ElvVHIJQT8V01WxCIkao2U47xDKXfvi3Q6v524JJahFn9q6NvzDGipeSTuYz5/t5IJc+8fLDWvobXh/Y8qVQJUltenj4pynPRFwW9xKgX+45+gFQdvtKs3FuK5e2Drztgn6+15Iza7Gmj68zY/Y+XTGHcJAITL9u/THKRe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508219; c=relaxed/simple;
	bh=p5zEAETL9o/U/Zvbm9PhuV/OVBafPOOX+H7m9SKDsoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttlKcK6UZUxmfKRU9LNugWgTuM3FVzCmjU4WWgBzQdapLquq5sASQlLobP61hZ6X3eyVLxRgbOKje9GlY3jBuQCwbtN8yxFnAFu7bfN7R+ZvOgA7RpyMt2/0OpC4XNDm0PnHD32LhA4AW4uAIsoM3FBzfoIi3G2c+ffNaprMznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=vInKQ7An; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="vInKQ7An"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so249207a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789508217; x=1790113017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLdy1b31Hti3iaSSbYZfZ+HUu7wPdl7Ntm470N+bkuM=;
        b=vInKQ7Anv/H8lcFNxrgHY1KaetCjiSsaI21NEXqGsJdNkDoLaUiLnR0xBRYwxEnSFp
         RllRBdzTJulrxCfiZwG0W0tNA5j4qQGCs+KYl+Cz/YD45wTSpZCkgcFhjlej/x6Ij5b5
         E9bnMV8AFK9ZloCPzvzzdZkSLnuOPU1fd3S7NWfBnVwjeDJFsiNEfko+oFEXB0LHiw+i
         1tdiNC+Bf4E1LxKslvv34JiqGLEmeHvtzpIWc9aDhB/bPm0cnpjSTRWxrCn9NAtPY9kx
         xGjPmYmCkL8ySx3hOFs6hyrU1I+NZ2p0iFOpESzp/KHpHDfEHTvc38Urv4pSWEBsxTRD
         WhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508217; x=1790113017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLdy1b31Hti3iaSSbYZfZ+HUu7wPdl7Ntm470N+bkuM=;
        b=HD27kig/mWjade5sE0hXV/wnNVDShWC2pPuZ9n/YbGlKhsbShNXnmxOJJ7CSECmIr4
         bE+EyFX70hXrsha+N6dN1Y8HhWLSBMxufi0gjDxlTktq7wy8GD8yfyk0scHbLQ46VRnm
         1onzRCOHnUyq1E8itCbv5rQdwaWIJv4OGjxq0xfkJtgAGP6/QvmEkAm3Zwo49HhwGiBc
         jis2zB5wHAb6iU19QdoQUr5S3M1VgZahmYv6iaDG9CyZMntcJXZDXQT82kiMNfX+AKFW
         +qmbbTN62ckLLGfEH0l3JAd+aZ3fQxUtacWlkbEqItWDt9EQmCbsHL2RJw1KvaWZ3M+3
         HRDw==
X-Gm-Message-State: AFuF++m8ss79FaDEmz8vWiKvVWSGLVIpLpw1soZaJzveFWOTd6TXmb7f
	WQti0DSoaWoaSohYqWnKww5aq5dPKkF5gVQAD0oiVmllgRiAbr+Qq44gZbi0Gt9Wp84DFsViYA5
	Tppjh
X-Gm-Gg: AYBFou3pddVRbsNxJRZ8kU6OpQ9Ht7QU/Lxohu5QHWiGP+qYrmsDToh1BzVDMBitOzA
	FHczcAN2boz32tTat1TrrRZDIo5peFHU/6q9DPLS5jkg4rqp8T+SlRFjlYddnEFE+gD3yE4cVFM
	9wBOA2exg6qHw5BEM4QPpG+mNbFXqPlmH1FlTNZU/Fo4JJu5eTJvF8jIzKtx6p0G35Oh5VHsKF6
	+BiLreO8W0uzP41+yCqsp9sx575HoXxfH/6IQCQ51jY8NVinP+Rtvk8UKKQc1vaPtqj5A2Q121G
	AjkpmRVIbkdD1V8p2LBIj4KxZ9xyIJ7xpKGXK2aBfqbnSUtaPon2meDM7rXoUg1Pi0p6hWWOv4u
	gFhoHTxZD8kQlViEFxCH2RTxXpjzHL3xlpvMPSP8UiS5vq0HFdG+GhUqS1uLCpIT7QZW1C7Gt+L
	lS+kh5xq6UXGJH/kfX1FDTcoiEH0a56Ti+tX1dABoxblMfcWvhCjyouPg9tqccgS1yLsD58dh0i
	dGaqyiRZc3hjC2PJK48nOykBFQSYQgwROnulA==
X-Received: by 2002:a17:90b:1f8f:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39e1e514ec5mr420871a91.22.1789508217312;
        Tue, 15 Sep 2026 14:36:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc37f58sm608504a91.14.2026.09.15.14.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:36:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 3/3] ss: restore packet_raw/packet_dgram filtering
Date: Tue, 15 Sep 2026 14:36:04 -0700
Message-ID: <20260915213646.116214-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915213646.116214-1-stephen@networkplumber.org>
References: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
 <20260915213646.116214-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SOCK_RAW/SOCK_DGRAM type check only ever existed in the
/proc/net/packet parser, packet_show_line(), which commit a2b31976
("ss: drop the /proc parsers for packet and netlink sockets")
removed.  The sock_diag path never had it.

packet_show_sock() populates stat.type from pdiag_type but nothing
tested it, and the dispatcher gates on PACKET_DBM, which is the OR of
both bits.  So selecting either type ran an unfiltered dump and
displayed every AF_PACKET socket.  Since packet_show() already
preferred the netlink path, "ss -A packet_raw" has been returning
dgram sockets on any kernel with packet_diag for a long time; the
/proc removal just made it unconditional.

Add packet_type_skip(), mirroring the existing unix_type_skip() and
vsock_type_skip(), and call it from packet_show_sock() once the type
is known.  As before, a socket that is neither SOCK_RAW nor
SOCK_DGRAM falls through both tests and is still displayed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 7ec72c04..37ed73c4 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4713,6 +4713,15 @@ static int unix_show(struct filter *f)
 	return 0;
 }
 
+static bool packet_type_skip(struct sockstat *s, const struct filter *f)
+{
+	if (s->type == SOCK_RAW && !(f->dbs & (1 << PACKET_R_DB)))
+		return true;
+	if (s->type == SOCK_DGRAM && !(f->dbs & (1 << PACKET_DG_DB)))
+		return true;
+	return false;
+}
+
 static int packet_stats_print(struct sockstat *s, const struct filter *f)
 {
 	const char *addr, *port;
@@ -4779,6 +4788,9 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	stat.state  = SS_CLOSE;
 	stat.sk	    = cookie_sk_get(&r->pdiag_cookie[0]);
 
+	if (packet_type_skip(&stat, f))
+		return 0;
+
 	if (tb[PACKET_DIAG_MEMINFO]) {
 		__u32 *skmeminfo = RTA_DATA(tb[PACKET_DIAG_MEMINFO]);
 
-- 
2.53.0

