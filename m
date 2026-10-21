Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598425;
	b=ja1lsDFPkea5fLHbZPK26m+Zj/tMz6Vs1B0oE5wPKdSq58RU2zee3uwcirkqGzvpo32H
	 YjkRygBN1HGmHES1Ce/+YQ1tIN6xryPo788Fw2pGWw53wYtgvZBk5fP/SXltvW1j4+WAo
	 ByGDG2pPS9nf4DX09TIImDMF4zlam6Vr+w3zPegQ5klTGz6LfDyN6WejuV1Tka3VfUuuw
	 pgEboNIwKa7gCuNoNVwHcjzvsTmM3QCUPfiOs5JtObYqnN4Tbjge01nVeZQKLe+MtgfMx
	 Y5KqcyPdQmohCYB7cTz+CpxPgG3jusFkZx0kXx7nXFo6LPpQKXCJXOXzcLshPiSmAWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WoZdIpCqHdgek23yOc70lZL/bp3oXAiqIYBiAU98ApA=;
	b=A56kT36WXmFaRNZ+X+EBLxj+ZRrRCF7n3pQytkFGcmpCLlAwD0uS/ai4vBgSPZpYrGS/
	 9MrANohn/Dd2tODUetVfAVOXmTwJ6BOYpTTJyb9gmu5IX4RohujWRCf6kQUKwrAfWXxuH
	 b6d6Peav86Yn6A98s3RO22aH214HlEMBBE5/yzeHi6a0fDvIMYa5SWf4RYW+oWwTVNE1x
	 qtZ2CcTI5m2rTg8LRRaBRgwPKmPTG1SqaM6IOKQgOwu2+AqqZLQ5GJA2B1XPiNRLx0/Xk
	 Y6VPUVmS+/L1xrzgcyMpbqfG1r7i29/QF8OKw/+XnKTFjYJpyPaDEur14l5SrgzL/dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EHd3SYBN;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11068606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11068606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EHd3SYBN
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so751902a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792598424; x=1793203224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WoZdIpCqHdgek23yOc70lZL/bp3oXAiqIYBiAU98ApA=;
        b=EHd3SYBNmI9upmsiy3PaBpsRa7cj3dnX9PGK/0oZRPRbhZgOB+3NaeBqpn4BrrIeiE
         nzpFwtCIpVQcMXx15sn0nc/28qoZAsa18lk0mrfgXcfodeDN3fU8t1J0qRe8AJ8oAwRK
         qQJ8gjHoeAx9i2KPPARuJuhYFVB867QGKYXjpxi9OdDoOPrUgYC4YmfdSmyi28nj5Eak
         g8biqhUTkR7vRzy/IQKU7axoM/zkgn6aHRTsT2fqV/HVRv9TJzWWAlJY8pgj91Pu/26S
         5tdsffCPQZB8y4hMQVrp2ZUDsR5T77Cx/RS4dLu5Y5TEXSsJHToiaRN7+AC1Xvvh159u
         IL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598424; x=1793203224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WoZdIpCqHdgek23yOc70lZL/bp3oXAiqIYBiAU98ApA=;
        b=XUpyG+SQwBChSuCNXYjxWRi3lHq98XL9vaOJXOxrAGltgN4YuYF+LaoFHiJktSiire
         8o3ZckXHYpG7EqZ8n9rpCxIRBIt0b0MH3K9B2S7fZmGfc6wfFJYECp7YevqU4pMS+VwN
         h+xu1xfinqR4SrxDb/tGtCJB7CkDDNMDCoDt46nhZQCqGQaUDCriyi+d+lrurHMtbHa5
         mkY0f7GlSnItHIUbQXNjLIJJUNId1D0C0j0UMPMDO4j+702LiuWBD+8Kn0fVafVsjFM7
         uTn7XVBWaZzEmA5cNvnnSXbKpwHfZfX0tbp90FP3la4/8csWdzTSCHckJs3qVsn73a3U
         JJsw==
X-Gm-Message-State: AFq9FYLQnDFUJ7KfpJYS99qeUYZCH5qFnl+xb5mxwmLer9Y0BvlhP6Tu
	DcrbKPi2VfzA48UlxyEiBycYEmaM7XXE8w7zBNssM8NQAZ0jFK2RgnJ4oZdcRjTff4W7uk58/qy
	F72EAUnE=
X-Gm-Gg: AYBFou0tHPcxwyUB2cWj2E/oydXYgpTt5y/iltgmbvWiGU+YXgStBXMiU0nZJxs9NAT
	a9E4sHyWydQWEcktsfq1xSSiken6bh9ZEFUICBIxY+o9Q5SyzzCU7wQyTu70bRwstzvIKh9oB1i
	dXpvpFUVI7iawNo3W1ACMolzgccw6IsvOFcLzJMJo9OoD4pgqXgxGz5vfTVoo0kRZS57qTFDkT9
	Gg163pc3XztRiHZdCp7JCXrLBorHZ6VwajXEjCCdKNbziOJVM2a3B1s7ZKK1U8BTL6LJGf0W96P
	+MM6JAXVCukAx/HJGXyIW/E2ltclv0NYLgv2cB2k8H8G40HcY5YqmSAYNRZ2NDHq7V3529WAB7o
	Y8c1PSkjMMjDpI/LVdqRuVp/L9PuIDdg+Jn0RTcss0sxye1ZC9O00w96EoElV7mZKUsmCF+DNl/
	SdKxsF5YYOlXQNfatvSA+KY7Hf+hT7853ybmw/Zx2btBVyhOu2deT7F5Hfq74x4l/RubpAhLGqY
	mEv+fHQIkUSw5nlAcA3DVIwwCE3QkcxKQC8ATWEOS7NeX3xr4KWfhX6O1ynQLZrIokyXct96vAn
	O21jqvDkIjmH0mSbRm0=
X-Received: by 2002:a17:90b:4cc6:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3ad8707a96dmr2200748a91.52.1792598423730;
        Wed, 21 Oct 2026 09:00:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada493261asm85664a91.12.2026.10.21.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:00:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/2] use get_task_name in ss
Date: Wed, 21 Oct 2026 08:57:21 -0700
Message-ID: <20261021160020.3838946-1-stephen@networkplumber.org>
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

Recent proposed patch by Prashanth showed that ss command parsing of 
proc with fscanf is fragile. Here is a pair of patches which allows
reusing existing code in iproute2 lib/fs for that instead.

Stephen Hemminger (2):
  lib: add root path argument to get_task_name
  ss: use get_task_name instead of parsing stat

 include/utils.h |  2 +-
 ip/iptuntap.c   |  2 +-
 lib/fs.c        |  9 +++++++--
 misc/ss.c       | 34 ++++++++++++----------------------
 rdma/res-cmid.c |  2 +-
 rdma/res-cq.c   |  2 +-
 rdma/res-ctx.c  |  2 +-
 rdma/res-mr.c   |  2 +-
 rdma/res-pd.c   |  2 +-
 rdma/res-qp.c   |  2 +-
 rdma/res-srq.c  |  2 +-
 rdma/stat.c     |  2 +-
 12 files changed, 29 insertions(+), 34 deletions(-)

-- 
2.53.0

