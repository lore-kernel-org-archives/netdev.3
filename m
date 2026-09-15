Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E2199920
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448497; cv=none; b=W0EY6d+h3utoUuAZpRRlw6tGBzxUUROl5tD0aq5sOrZ8zbrqQY/dfk3v2CiZQtCvh+NILYf0hs5HtDX7Z832hh5XDAxYgXnXPsWEZDAtPdjxjM82CJ4mVe9feb0jQaBXQ07EY0F+8IeEx3k55Hgd0DZw5mWWKTH72ALE+XOiEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448497; c=relaxed/simple;
	bh=WvJDz0SMer3VBOphKTbusnWx9vBwOwyigPUnd+wAAiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxD2G5gD1dMx3RcH+jCFrpP8FAd+N8pzMD9o6bb7VKE2HYwv/JHv6WXDKkaZlrS4mSk9Bej4VffXaS8xFs0j+7DyweI1WvrrEZDBGIo2WoZYt1W0wJTHbgwi5ufs2b/G4RmPVPRND2q0QqqOSdlX943c6oJAxpwC1C0lhaYEbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CESLyb8q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CESLyb8q"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso2824728a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789448495; x=1790053295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ptBV0v6Gt6jAGsqstGkmrulpyxyqgfaikKMDt/h5aaw=;
        b=CESLyb8qb9mC71opDonoVuBQSmNLGkr0FyokxmGTXBXKnoGBaohfQtCFhF9iYDfSZX
         OfGYYFOzGxa4dsd6j/zDtS3Cj4a3AGa5Jgfo/pd75wLuIaRmJ60D350O2I53HL0JbM7Y
         SE4OMaXtERlI24QAe/wrufjpOkVXCuFppv5+fe5PKlShsccsf0EP2nRdjP+6sMye1e1i
         brCrnikbGHwPIZF0H5foqV7lrJ0oGAEgNgHtTVhR7uTwHOOmREhZUCnimhLJMchiBk6G
         w0hU0HuoY3ONKkoG5l27rBui5zgFaPh48lKsfBqYcAqTFfo24Z938eEoWWXxi/ZA7q8W
         EBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448495; x=1790053295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptBV0v6Gt6jAGsqstGkmrulpyxyqgfaikKMDt/h5aaw=;
        b=2iVKYb9RZO+K5Zwm5EUOR9eacv3lnuXu/R+CVGu1YPsFjUmI2Tn0vZYwatCKTEs3/U
         UH0rYY+qKrFZ1KuvTSjv6sfxYHmkDFxVhqAkQvGWqjEZbDPSG6TvHDB43Rh0YoTf6eQn
         W8zSiSgfIgci6De8Ox/qvsh4DZaqfCyD2WwABXyHV/fHy1/80vrHcisDRKg9iowGFi+G
         x+RYnVPOipGEkwNgQqkNe/JGVY31306gEaQnc8alU7//ISeFqK0FPoCD1bjpQlCEYDKY
         yXql1BuchAOuNTl3dqBD9w86JKJVIO6sncigaqEnItpjBbcWmPOmzIV+DUqEjc99L8Um
         /cAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx96L0f6fmstFIVvB4OI9tgie2U9eqQC9RZnRuL3d5NDpeCGYj6yI00oU5Z0AbRetj/+SYFFlE=@vger.kernel.org
X-Gm-Message-State: AFuF++lZZZmD2usiIcOLeEPU00ijfF7utFItpa1qtupumyg9bqKyp41y
	zI9Rg7W4vUnjurYdPpp0jv/5IcB8UdiAWVbyUOhCzCSrP53bLaRlRktu
X-Gm-Gg: AYBFou0HVjE6RjusbN1lV6qwcN/Oz59E2TzETfhQMY+dH8UAEKwWB9SR5sdI+ET1rBl
	UgtDVhmvDLUxFUAgvmtEg/S9PsvYMcVTZF32R8UfOLW1HKOIAoUHJgeuIqBOkA+LmMYHjU8tSUh
	d3vcQ+bJuzr2dDWD5p4pib69AidbvaQP9OIN/nS2lkPGAVLq3disCx3O0v1CZ+HaAu6QvDGZ5bH
	pwE6THY7DXWPww5yzDhDb4eJqREo2/pDXA1T8VslqUh+iWapHCDtDk0cFx/4ibrbkmH+cdLbE5J
	xnyzjfmcj0L4nUBel1Kal9emmZcJTyeXdzlrN+eqZNC5DHLFaHgH+XBI7ZDn/a5shUZHLBj5O70
	7JUqkpUrVlyV+14yRC7LU8leQlH7qJ2f8wV6kz32/4G7rC1tTJuHaoa7JNzjBGEIdmWGLnKFJpf
	iCbg4XJzXWYTJ10rxpoky14NTUtgfM/1Y+dhHrnzoThh7IY6hrGDIreoHLxjR4vxyen9V1Oz0qM
	VTkqNktmEH+QmGVjBkdZYcdUGYRktdDMEwDBijnjCYQjjbeeJxpd+df2xpu6gl+i5d1nKjud7jn
	G6Rp/zXioR/NKXhLwPW5
X-Received: by 2002:a17:90b:57cb:b0:39d:f130:f8fd with SMTP id 98e67ed59e1d1-39df13108cdmr11368757a91.11.1789448494978;
        Mon, 14 Sep 2026 22:01:34 -0700 (PDT)
Received: from lawlee-vm0.d4y3nv5wwgfelhhopdxv1tqjld.dx.internal.cloudapp.net ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm26872358eec.5.2026.09.14.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:01:34 -0700 (PDT)
From: Lawrence Lee <lfqlee314@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH net-next v2 0/2] ipv6: update NUD_FAILED neighbors from NA messages
Date: Tue, 15 Sep 2026 05:01:30 +0000
Message-ID: <cover.1789448374.git.lfqlee314@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neighbor Advertisements for existing NUD_FAILED entries are currently
ignored. This can leave a first-hop router with an unusable neighbor after
the host becomes reachable and announces itself, particularly when
forwarding is offloaded away from the kernel and traffic destined to the
FAILED neighbor is unable to trigger the kernel's normal neighbor
resolution process.
Allowing neighbor entries to be updated from NAs already received by the
kernel is preferable since it creates less work compared to periodically
probing FAILED neighbors (e.g. using NTF_EXT_MANAGED).

Extend accept_untracked_na to treat FAILED entries like absent entries.
Require a target link-layer address, IPv6 forwarding, and acceptance by the
sysctl, including its source-prefix check in mode 2. Recover the entry only
to STALE, including for solicited NAs, to maintain parity with handling of
non-existent neighbor cache entries.

Patch #1 implements the behavior and updates RFC 9131-related comments and
accept_untracked_na documentation.

Patch #2 extends ndisc_unsolicited_na_test.sh to cover FAILED-entry
recovery and each acceptance gate, including in-prefix and out-of-prefix
mode 2.

Thanks to Ido Schimmel for feedback on the original RFC.

---
v2:
- Full implementation of logic to update FAILED entries to STALE.
- Update the RFC 9131-related comments and sysctl documentation.
- Add selftests to verify state changes only when the accept_untracked_na
  setting is enabled.

v1 (RFC):
https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com

Testing:
- x86_64 current-config and allyesconfig builds with W=1
- tools/testing/selftests/net/ndisc_unsolicited_na_test.sh: 14 passed
- Local NIPA checks: all substantive checks passed
- Sashiko local review completed

Lawrence Lee (2):
  ipv6: update NUD_FAILED neighbors from NA messages
  selftests: net: test untracked NA recovery of FAILED neighbors

 Documentation/networking/ip-sysctl.rst        |  28 ++--
 include/net/ndisc.h                           |  15 ++-
 net/6lowpan/ndisc.c                           |  15 ++-
 net/ipv6/ndisc.c                              |  94 ++++++++-----
 .../net/ndisc_unsolicited_na_test.sh          | 124 +++++++++++++++---
 5 files changed, 201 insertions(+), 75 deletions(-)


base-commit: 272a65db243bfa34b9277632830e0e06d7e3518e
-- 
2.43.0
