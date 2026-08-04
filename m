Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B936F428
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821367; cv=none; b=RazpK+ZHv+Zp3biDneEXC2N28vo77seV4NBMJF70d6TegBXfCoW73uuY1BAEguAQPMMtTbgi5/IbvLVhDwfKd27qzx014/LlwyCkqc4KAPoPs0XKEo7Oh1rzxN58GGfaHmJlbBGw9PeAQX/d2/M9iFmAd6wDpvAjKUUkFTxb9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821367; c=relaxed/simple;
	bh=KtQJfOnplEAnHToqIT7C1s7SUHW63edaUagP26DUzzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JepJuE9g4dnMTfysCLTxmWPRgz7HOra6MDrVG1YPl+LfwPp3XreNx1FlM0zb4rZ3bMlSVYJhfYuOxNiMcrf6hc88SvyIll8imU1jJSB+c+aS4E1GxlNpQtNMhfq3lqFbYMI53LxE4UEuVlN3zlnjY1J+wuPgd6M1GZbHCAhc/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtQZhloG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtQZhloG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso40278535ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821365; x=1786426165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6o4n5pupeB2d8RGbxcjX552Uqn/Hcl7H29fyuT3cEs=;
        b=VtQZhloGZ2kLwgTJqiHSWYii8K/KdYBMNLHZrsIMUpkcAszHw9bZ9UfaEXPWkDc+DI
         t93vi5ad25QiYilJehzCJBX9NqDrfGltM1KJL79fcIE4YMhFFTFbVPFK282yIEUzwZ2a
         oRXuHECrEJ98xC/DMPr/Mex2uSxVqOf9v4fFfnItTwPFzZJIPcc3wmXNRFze5AKBwGPO
         IY3srokmb0TgtrH8Q45W80s+tstL2omn/uNTjeVkXGSQ81TZQpgDEob6Ny3JAFJEC/8C
         cVe7X+V3XkPT1ljHXCzRCzUbjyYu5oAxGcWVqnW0/ZvVzUtX1sDoRf24bDX6HLQ1NZit
         BulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821365; x=1786426165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6o4n5pupeB2d8RGbxcjX552Uqn/Hcl7H29fyuT3cEs=;
        b=cQ2x9NUy9N9Hv2m5otJxsVkZ3W7UP/QPQzuKcPtjyQzSw+cEnQD9k5otKIlGmombLB
         gJP4aleEOYMhc3mvU9vUyKLoCC9OL9LJZl98pameuLSNlOaSN5i5+PkMr1onog3fv++C
         nbHWNNmZO04E19vQvweNOFRKrq9Y9wLAhHAtml/KoXmdrLcZmwBSN5OtUfXmUSSPL0b9
         Z72E5ByDF/DT6F0bhGFOraL5uLczjr7ONBRWLsZl2dNstKPTb//jxO3898/PyKVqxHeb
         Tk3utZC0mYKvHr8s9WYrjSyLPYyW+isj0x2e70i1baPQaX7dNXnQnOv7M4BfR6GtL/wc
         AmwA==
X-Gm-Message-State: AOJu0Yx4ZKbMc/WQYHQpUNj3mqr+SbLJQA2QLirH1TFfeqSoksNQzChj
	8BhHeCJr29B7ejzWBI7c5Y1m4T8/Y1qdfmMgONzFJa5ULBqqapCmZoC05UJXIsTQ
X-Gm-Gg: AR+sD11Uu60PDYtIvwKTuXQiHFzci+d9DajxRAbxPcRIn8XftlFgT6StXbHgPO6IpPK
	kUDgaX62XRDA4RZd7U3jpJaRevwutSHZNJHK5qEbnm/l5shMxA42XTiKNHhlS9k8Fe+YsTErLdE
	OwImYUnz2FxuYzRAfDPBsof6MSfMplcCU+grEwDor9tmBpgp/2vMCwgT9oekDJqeRLUGZEvFv8S
	VyUESQCtAb7c9hr1v1Dk6aBB6Lx0VaY96nuhqlOOj5Dm2VJxJCv/xgrqnJN3lLl/APcs/xUHKUa
	JfL3tV17oZhJcRANjDrAPQlxKJZkkULWtreomcarAzn5LfNwzDyOSTLsgOzYet+nctEowUCa7R6
	hxzR5xdb5QGmCXHZM0tKLrCh0EmxFMSXc8OqY/lRfMYjYrh1tAb8UnfW4m8NRqFPH8bVl7QScTZ
	31JfgTgn9UL6hKlQDiCVxuF5ncfpnJLPUg98wRLA+CBza606wKFgGgtZF9246uur/HYvschdWNL
	x3ETP2EcN9R/foPUry3rlZKT1fTCIPLKA==
X-Received: by 2002:a17:902:ce09:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2d05244dc84mr129723385ad.44.1785821365283;
        Mon, 03 Aug 2026 22:29:25 -0700 (PDT)
Received: from anna.. ([114.70.9.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a904sm47056345ad.20.2026.08.03.22.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:29:24 -0700 (PDT)
From: chanyoung <ppoo1220@gmail.com>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	chanyoung <ppoo1220@gmail.com>
Subject: [PATCH net v2 0/2] tls: fix plaintext sk_msg ring over-fill
Date: Tue,  4 Aug 2026 14:28:34 +0900
Message-ID: <20260804052837.49015-1-ppoo1220@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged user can oops the kernel by splicing into a kTLS socket
whose open record already has a full plaintext sk_msg ring.  Reproduced on
net (53658c6f3682) with a stock config, no KASAN.

Patch 2 oopses an unpatched kernel and passes with patch 1 applied.

v2:
  - fix the copy path so a full record is never left unpushed, rather than
    making tls_sw_sendmsg_splice() tolerate a full ring (Sabrina)
  - selftest: drop the comments, one splice instead of four, reuse a single
    pipe, compare the whole blob, sweep 16..44 fragments
v1: https://lore.kernel.org/netdev/20260726105556.2719227-1-ppoo1220@gmail.com/

chanyoung (2):
  tls: don't leave a full plaintext sk_msg ring unpushed
  selftests: tls: add a test for splicing onto a full plaintext record

 net/tls/tls_sw.c                  | 14 ++++++++++++
 tools/testing/selftests/net/tls.c | 37 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.43.0

