Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245196;
	b=QWPa4aPVcEma0bg/TlhaUbsO1Cs0Sky1RNuiGWYn3xG4iyNoOvtZCGSbXec4UsI5pP/Q
	 MnCsVKPXcy++5sfT5OmskOVgJgh9mLJnnZSLUnWT/Qj7Jp1sUYi9mUzmc2mPYAHClFYB/
	 z5FSOeuGts+pehydtDwDyIs88d16+pwLcI9m3cnr5nQKKxpFsQ5ETMgZ3Un+N2Fv7t1V2
	 AxR2PNfUmNEU7tjTKn2k9KL2pwsgwB12xlr3kA7Mvr2JIPQxnh1DSCDAo+ObEr87wfKCh
	 Apqz9f9/V0IannkgVbXxpoEDPidxQFo6ZIvuVv58GzAd8h5QuCCEPxmKwMuSKnWOzIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
	b=v1lqJA1b77aw6urKXQ4v+6uMLb4H7fP7g2NlHPYlk+8r6ur5MoNQ8Ss0o626onDyMiUL
	 in7y8LgBiClpLLoKoLlvIr++Sdgj1/BEqOi4AylP4kA6WpxRPVM7H53+sRkDgn4I+2Yug
	 iHxHXgmMEEEIjAO7bZyb3J59fCDGW4azZVO4D550XWHfOWUJvist6xHBGjOFOaMjbXeU0
	 JqXyQTsqIf+6EuYB3+X2nI87N5E4pX5RGC5PyhPXBoOdQulBxZHCskSbeTraqM7Pb+fEr
	 craMt5J2NmDIwj1VIvyQKMWByVj8QEgKpBwC5Lg4p8mCSFztpUwN26/0sJh9lfP1agw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv1xaFV1;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6A606A324
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC6A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv1xaFV1
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89d3a4c9fe6so246219b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793245195; x=1793849995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
        b=yv1xaFV1JgIdj3pYONuZXPUadEphqo10zclxkGanXVfIo1jyBv5EDPfAKGxTzrG1UU
         ClbtYmODiH4rju8A5h/c3AZiV7oydd459mCTJP0AC4BHZetZctvozhsB3BEhRt2SmgUs
         WB0em3YY5qnPuKbGraNIjXthL/JiNBCKVBF5dqymbw0I428l68G+CNNCdmI0ojCoVlgQ
         fD2QfWDNzpin9QgdOqT8eYR6hIkKYpb3e+LS9OFMa7L7WD6cKRvFmnAmkS3vqtCLlbCO
         lKEyOuD9XflPiplp8/VmKqF18yluUuypt6WJt+MCfJ6m1aInpV9E8N7BExXK31e8Zbvb
         TcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793245195; x=1793849995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
        b=JI2G60LQQLrI0S64tcU3legUlub0UCVHje8ShhciOxNK/3aXR18PsHhPtUP4cD6JaR
         CbAfiCebhD9IDeWFQLLlFFToaRLaYyapv0HKDtZPiRu/G9jBb1+iK9TTnRz06PY3aQ5F
         FmWq52JaAZXPFf9cGEMim8wf525rPIfisCusnU6o1OLIt1dyc7nFR40p/xpcNabhq8FW
         FRtPun6gcTjkdTZWBMm7OyeyqsoHfWLxErQzHzEAU4AWoFJe2AY5sgxkqrUOQYDK4oBF
         Fb5n2q0qljB0mfA9ibwTADaIeuw7EjmeYJHHUYe2p3K/h20mikzN8McGN3MFXEStAtUj
         5EyQ==
X-Gm-Message-State: AFq9FYL+uBFOP894KN0CaWoWGjSavA9aWV1G066TAd9kKH66raM+xvWA
	97bzQq6P6GFYv0elm7au2mx7+V2WYHKnLuN55Qu7kwneICLA7Q6B0v8rYnfFPA==
X-Gm-Gg: AYBFou3etXF2WXzbGxJA70QOgDXy5IvsvmADCtlSHQOaa5kpIsp93FFpMI0yUuiAF+h
	ZWAkwrrMc75MFHAD0M9kLxPfjfJh7bwKcJtiNGs2hCRsepMDSq7qGcc+BiBE1NADZdc5K08iRG8
	EcfRbY/J/8ebMSkRjdZBPo0W0MUo4di1HdexXej6kXkKoggqWUb0lULjlAwe+uQ8NzdLQp7OtY4
	HCaEMxWNzohCFL6gAm+KNl88dH6fhygw3gUTWqWB1pxelmCx6Bg4ZZCpPIyzP1zm2LZ6Xt3f776
	IoCEBR7VuMIblml3GvgFjJ7o9QuNh7AitfDw1uKEnYExeeDow6Mk9ZsmJqr3RHAZTVIkOwXYkd9
	Xcse+vhVOp7e6L7GzghsybTdtfyHbIxj2sgatCn5fY14nEL94hiFDltPBsUFE+4WgrPbxBbn7Mn
	+AP02fjC1Z+06TpFtlfnuLjg/eNUR166f0jw35lRoqX38dP9sFoKwT5VEtdP1ZutwhgODpTuVVb
	wgGTa8CHtvB2zrbqwxQ5kTMZDa7+LlIDVVhz5lRqV6ZzVFUMQ9OPaENdahG+CQv62dub4tsHo20
	Te1xWJUMvAZzvrm3WfXLDrkA37FdSnjLUDxowUaZFH0zQDsmlhlDE72+N0PJTHDlKdrkNm41vaP
	/hpX+1XngUYfhZn1ZifQzWBV2IgprZzfhjFi3vQ==
X-Received: by 2002:a17:90b:2f10:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3ae58316577mr6084276a91.6.1793245195196;
        Wed, 28 Oct 2026 20:39:55 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57a2a053sm2311009a91.4.2026.10.28.20.39.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:39:54 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Lucas=20Dupr=C3=A9--Rabinovici?= <omniameasunt@proton.me>
Subject: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Thu, 29 Oct 2026 11:39:42 +0800
Message-ID: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

cipso_v4_delopt() recomputes the option length by walking the option
buffer after the CIPSO option has been moved out.  The walk then reads
the stale bytes at the tail of the buffer as option data, and a crafted
setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
length, increasing opt->opt.optlen beyond the valid option data.

The corrupted length stays on the socket and is later used as the copy
length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
where it exceeds the size of the buffers they copy into.

Compute the new length from the intact options before the move and
subtract the CIPSO length, and fill the padding with IPOPT_END.

Assisted-by: LLM
Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection endpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v4:
 - rebased onto net (fcc00b15cb21a)
 - reworded the impact paragraph only, no functional change
 - first public posting (v1-v3 were reviewed privately)

 net/ipv4/cipso_ipv4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 1aacbbeffbc64..e65a3f29d2caf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2013,6 +2013,10 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
 
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
+		optlen_new -= cipso_len;
+
 		if (opt->opt.srr > opt->opt.cipso)
 			opt->opt.srr -= cipso_len;
 		if (opt->opt.rr > opt->opt.cipso)
@@ -2026,11 +2030,12 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
 
-		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
-							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
+
+		memset(&opt->opt.__data[optlen_new], IPOPT_END,
+		       opt->opt.optlen - optlen_new);
 	} else {
 		/* only the cipso option was present on the socket so we can
 		 * remove the entire option struct */

base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
-- 
2.54.0 (Apple Git-157)

