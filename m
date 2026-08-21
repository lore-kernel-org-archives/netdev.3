Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0612E06E6
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303701; cv=none; b=kwr0TdBevpFG1B4XlhD7yIaJXirc9bHG9pEu876VLspCLmI5aO28ZCJTHIW1Qe7qn2MglzwZe48Nx1kk0W3XIA8hlkQ2f6QFl9hmt82iYa999q3ZEUjM7eoAUijUwlujhqbqSI5oi94HWc/ht9yJHGkQMGggVUDEyYsg/G25PSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303701; c=relaxed/simple;
	bh=6Fvdwpxft8AoHYq1aha5MR5WZhcRsv0eeaJ35BUbncY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7LPVw/ZX56qkeTifLPgFXKYbCytItTRoG1dv5/8xLPsmkHAzNKG/nl1minFMZuImBwvyJEXozT0W66WRkx61rnCMGefkDB4/39/tQyO/bZl9XHQd9Ow+oXimunbl9PBTEbbPYNxNFUhJ1uUg3aQOvoZ/8ZbuXPeBwffEZAubs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaYn+gBM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaYn+gBM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf27856f9cso7785285ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787303687; x=1787908487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GeuHunERBfxvzXCv5bOEDXvdATeClpDwiKOKDbZsOk=;
        b=JaYn+gBMCiJ3W4iB3p2jg25zmAfPlTV0cBtuLQTOrPsR3sxkdU8zzdm07N/pI0D0f1
         JznZwOe7WB5RnbmQATiBgbx4glIeISypUQEBxtg9T1Jga3LvN4jR09iNI5hv1jn4/iE2
         1beO6JeuZaPzGPeAbh8em2+1vktbm+Su0d4Ddv/MUxzvXhE0hivL79OJyn77HDCWp0T7
         LMCxBsOOHqyW5bpIVNz0AH8/BvfUI7QOgwoNExwYgPPRgzzXMeszd6llhB6HORxDhDPe
         5SAvZshFag+tSSrET7+muxXECbkkDeBQOaYDBkzFftuEjz1NdXb+b9XPs9lKFjr/bD3d
         43Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787303687; x=1787908487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GeuHunERBfxvzXCv5bOEDXvdATeClpDwiKOKDbZsOk=;
        b=AXVwY4nYGjEOAoww3TG8RxyB72p/ccTVFbN2J4zpYBqTO9SOLVq88PYVocGAdNqMtu
         R9eQbj2AToe6otJg8V9Sj3uGDStRDKz5mqUD6mxeimkn1V3rFn8f1FE+AwvUe+kAFBvL
         rdLu2FUVYfSuwN62owH4JR7y7Eu7i9hAChtWk+AFC7ADcoPB4nAUfz2G1atedF4TzmqU
         TImy58apMpxZzxulEEJXdfvLIykAaqsQvvH8IOKhSKH6iDMyzlKv+y58VgOxTWnT3Auu
         Q/ExwxYE9ghxmmjdhE25X5iERu712fvCSBtb8e+X2tpCPXBDgmfn8k10ZcfjPek5JhgE
         typQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFwwxw7oU9ihNAR+uxTPeF1BIieEUvH+21N69FVVDbt2zx1WxUpknXvF0Z5ieZX/pQBBfgQqk=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ+KIbQdKqQb4p21LogpzAZy2J+NR1jVpmw/i0aNEMxe4dnFGd
	IiiR5OSqyIpjk7qE0YJg3yByEqT2onggWGt2kaXhkrUKPtYlDmQGjQoK
X-Gm-Gg: AR+sD10sBje+832OrmfyZf7oSMpFzIfgCOZNOVHYIM+pO60iUZQ6MfAdo1PJjKFXewP
	cLNYoVCzewEtGrUtFcUoZ9bP8HgfOXotceAqzTJ5ziaHyICmvlhr5lrR/EREstOx0onyfM6kp7B
	mkY+fq3F2q0r3ski/waH8e0aZPzCtMGO25FfOHZN6zt3Dvb1Tm8ZV2IyQ+3Wq+eviOb4c0URa1x
	MWD9LGNcPhugZt9nGCN2nNdcGjtFXleI4s2Yoj/pzB7RcEJpUlbT+f8q3Qh8hccVI1hwLTw274K
	hnnkquFjaWojWpjuH+MkLF1wZWIUwJ2kNyMYDtjgzWMUEd1t4uHAdmTPozg+TgvMecyZbtpuVJ+
	GtPdSxMUlaWX9XemnD8n6OVY/A3yrqQxDIB+AilpskCqcIvwbQ2tQevPN5oL9+7BR7f3D9rSPhK
	0QNmQELTZx/3vYUjKOS9yc3dIgrRN/cm8On/WJTQ/6unXu0FsUQ7Et8TJRWlC9IkMyHBNj6T71r
	Lk3YsuB1aHIJje1/7oTsp/F3uSXzQ==
X-Received: by 2002:a17:903:1a28:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d64adc3f0amr104460525ad.4.1787303686407;
        Fri, 21 Aug 2026 02:14:46 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3cf1e3sm16141265ad.72.2026.08.21.02.14.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 02:14:46 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Jun Yang <junvyyang@tencent.com>
Subject: [PATCH net v3 0/2] sctp: handle wrapped and duplicate RECONF responses
Date: Fri, 21 Aug 2026 17:14:37 +0800
Message-ID: <20260821091440.6496-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix response sequence zero lookup first, then make RECONF response
handling idempotent with an outstanding-request bitmask.

Jun Yang (2):
  sctp: distinguish sequence zero from wildcard in reconf lookup
  sctp: fix stream->outcnt underflow on duplicate RECONF responses

 include/net/sctp/structs.h |  2 +-
 net/sctp/stream.c          | 46 ++++++++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 15 deletions(-)

---
Changes since v2:
 - Split the sequence-zero lookup fix into patch 1 as requested.

v2: https://lore.kernel.org/netdev/20260804113100.37840-1-juny24602@gmail.com/
--
2.55.0

