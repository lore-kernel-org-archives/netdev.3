Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F13DD85F
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689004; cv=none; b=SUYTvxKgg1LYp2kJ7qAnEUr4KBqo+6TMFsiZz6KT5GmytLv30HDvdHupiY4KmLY3lSm5NE5uIabTG2Hypy9tvW7wGBeeaMOMryVzW9FwjYdFBy1ACX9VXCnTrbNxZDRLWS59+qYybxmrbsB4vHxhslkxTYo2xYt6RNlNi4e5DuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689004; c=relaxed/simple;
	bh=M1i+cIvPBQBLCdORlbIdFFEY2dmcbhdAhNY2zoLxHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQq9BMfmazLJmp7vIjf8GfZvGTTGx7di4crdHqoXMfQ95tuzDPgetzyyjjVS+HBDjLCbV95zUcbnEP+v0/UsVaYIiNshxIPIzCIaEPVvg7oVNmr8mGgwckKWHPLesZPUeMrSmU/IE3S0o5mY9QUlKdU8GGU1UnXMBGHdfiIRWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REL0JIaj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REL0JIaj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842848fd613so4777964b3a.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781689001; x=1782293801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCUbyKp25k6wbPFQhAin1766IMB+KALX6614QevcGxg=;
        b=REL0JIajjAQzQTNYes+S35iMwme2AT/0oNJr4eYmMaDVPusFl+D63yBeovqavbF42d
         FDRd1p7vuUCb7Ha3HzHSTcsP0tQlAQzSRZN0mBbUTy7QBszleGwE20C8wU5/dSh9XKD2
         gCkyZXUkVAiD6zvuohF8qs66pyuxpo8cJDlQ4P/aqBkLNxjktxpX2Cf+tP5t/m7KqpMA
         IWZ5i7bwhGSzqEcD7EEmOhW8Oe4qP1kQqEMQBVOMmNJOckSKbD3hNuDhm9g0NnAXIs0Q
         mrhPMjzPEDREH0QmIlvnsC+ceBFPm6CVpdGWwmuxBYaOCnsHcYmPuK2NsqF/axIuufGE
         Z6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689001; x=1782293801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCUbyKp25k6wbPFQhAin1766IMB+KALX6614QevcGxg=;
        b=aYRtT0zDPz94uq+4K5gNdLzskmRHmB0zxpZlBUoEbmwYSSNLTT+P9BOUiyrm14t/As
         a6ZPKkSx/bgiqvBFc7SwERvAAKmKfJyR1gTmsEBD37h2cXHn8p1mMhICo8gLhcvuHpR3
         eKQrgfoKNPi0GRvuYc+h7hiLFJJUUOQUxo5BUKGwcLj0kzMqIzo9XkDQ5IJDvujGOBIv
         D9a2mbcIv1s0y7NwuEeyOqSTQvFbo4e70no41ByWFb0w22oynRQcmNB+YYcmpe+A2htI
         TEMlhC7k/Fg3ANcYkbAXy6GR3TCzuWT8JJWrs5/O4K0Jo8aI0psEJJEqkS+gELRTBC5u
         rVig==
X-Gm-Message-State: AOJu0Yx9bRdIHVt28mX5/FR4y3uk7ys22K08jY8xXg4VvzUm7pcapj3p
	XwJ7zN+K1ZQdqkNROMtGsQ/UhYJTXizrGrxpsxoNluueyvk8P4Ida0L3
X-Gm-Gg: AfdE7cmgIzBB9k2sNujdX6ttEm4oDNNwHXIlBsuMRbDHeeyq/I6V5douYOysqutkrNW
	6VesYhAe1M/qf8hJtARHZPEMZ2/IKv1mPRVfZ52HIyHdtQKDxnk9FDCBq3Wk2kzTGwd7RF+N/CR
	05uFcvK7zGQjXQbV2Zyg0VHOsKn83AxRIAZwKqqmFE+Nn4WV+K8Vzu0V/GzL1SbIh8lA2cHB4U/
	97niOTyrvEFzuRVsSbXhWvVLC48WiLulf7HfZoyln2wLtHzrFy3sYeGIDWnmE1DS/QYbDIT2cGv
	AsqV0FyjvPR7TaJbnX9lUg+MgsM805j6czpJRcUNyeVObhT79JW3XkKCqP1lPdS9JatrLaL6Gir
	CMHwIdAI08SvGgD7UZwBKkyKZe2rrAr6b1nUOWPGwX1lrzZdwlEkdpnaXCfbxM3/APnjBtnOsvf
	qrhkqY7qgufaQrF2U0afoFXnRY7/E6LsPhwlz9sunBVo4tY93J4IWF
X-Received: by 2002:a05:6a00:399e:b0:835:405a:7e6f with SMTP id d2e1a72fcca58-8452444f361mr3184886b3a.14.1781689001317;
        Wed, 17 Jun 2026 02:36:41 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::206b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm15521653b3a.48.2026.06.17.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:36:40 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Fix partial copy of non-linear test_run output
Date: Wed, 17 Jun 2026 17:35:56 +0800
Message-ID: <20260617093557.63880-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-linear test_run output, bpf_test_finish() derives the linear
data copy length from copy_size - frag_size. This only matches the
linear data length when copy_size is the full packet size.

When userspace provides a short data_out buffer, copy_size is clamped to
that buffer size. If copy_size is smaller than frag_size, the computed
length becomes negative and bpf_test_finish() returns -ENOSPC before
copying the packet prefix or updating data_size_out.

Compute the linear data length from the packet layout instead, and clamp
the linear copy length to copy_size. This preserves the expected
partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
in data_out, and report the full packet length through data_size_out.

Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..f15c613aaa4e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -453,12 +453,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - frag_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
+		u32 head_len = size - frag_size;
+		u32 len = min(copy_size, head_len);
 
 		if (copy_to_user(data_out, data, len))
 			goto out;
-- 
2.43.0

