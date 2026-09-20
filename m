Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB733260C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910650; cv=none; b=vDqPQE3/tYORWR5pfRoLMpIUzU7hnibYffuC/hpXRoCXOleEsFQReXmbKQ5DffdJH03/vdgMiL3+fxb+WhIewSSKyNHPAg/hyHQVTkFijjRnuplsx87AHL2DzSNtZf7jJEdk1wUlcX1BWPKd7KcK5CuDXKPn6YIJ19tJTX56QE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910650; c=relaxed/simple;
	bh=vN3GvPXhDGTPAyw8RqSAV5H+01VWk0+oT9MkbAuDN1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFWKJieSBXTn4XWS+7BpESvED+lYDbhg8LCCcutQcQ8NBL3sQtI6F1ZQqWS81X/VYc3KUol0r2Gbr9bLPCN31J8kYeu8n8DW0tWAOhZA5tQDqdifA5powAozlHOtoG4s5Pz3d8ImAXTufUyLCAz5S5lio7mqrHkyGVGVyIklE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY4xCnnw; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY4xCnnw"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so13414145ad.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789910645; x=1790515445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpXb80c2/A/RkMSYNkLi4WaEDGLQJKU+a9vHUD3ajSE=;
        b=FY4xCnnwH8QrURp3IFAD775fNLmM6ER47q/k5iYYjXh24+HSH1TnJCAyNb53N1qoQt
         cLABgFtb2DZlLr4DEX0miDjPyKQ/GpvxymTJIGbCbJK2HWvDxSEIAFzQfnJlJHoSY9OJ
         Jch7mrVyQyUmS6J3f5SjhYpzX/6kL6GDxDM/k4b3UELrtka7ponsw6T3zWfjBl5fOgTL
         1Y5861F/vSluyl9qztUCneBH38f0UTbS+p5xS/zE9q74qEyYHG68bVYVatuuPM0z8sUG
         q3FgAHa/Q/NSLnjuD/k39PGaD02V0yoj4tWVS60l7zNCHz49gmX+lr9PlqcPhnmOFLLB
         2pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789910645; x=1790515445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpXb80c2/A/RkMSYNkLi4WaEDGLQJKU+a9vHUD3ajSE=;
        b=MAvsGXqeQbCv+91MlhWwfiLvQTxy84WbkigfQbg8MJXMJDoV+JhzxmM+SGEb5M9R4z
         qPDGuAoa9lRoRfalHOXAY6fYOE7yF57xDUmQOJVWaXIXkaDAAek+zfLiRq+qaLMl4mJT
         52s55+9BsxBIElOPuN0vTP47LqIAr0ZCqRRFcrLw5SQqy0IFNNSYnwCb9fLah+zpyIwn
         qNq0JTZqe+RhcuYcwaUOK0Syzl7z/fm7KJosXVx0L5sR8idiKHF0tzKBzGYEm6WusXRk
         dHaSqGns3Gi41IBHUl9Nhwqdn0fz39qZ+BbSwrNWnFKoEEM9jhxn3Fei3KVn0sSXkdYf
         M1TQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG45ZFoAK4FwpMXodWLC7baAV0ZArItLkfnFP1Zb7yxxDXAShXnwLcZ7GfCeoNy80X1o97uC0=@vger.kernel.org
X-Gm-Message-State: AFuF++npXzi+pTtAGQW/y4esPvfX9VA6yabwRmRfPQQTTO2GyPjC32Ai
	u3fd2eBFldYzzak8i430WcX3iThaAjwII3UKBIksiEw0YhBusDe883Gi
X-Gm-Gg: AYBFou0XjhuEtjyySDaq/FdnT4RP6bS6+k9t6YS2/qA5rGkJJIKSykft2cergbOQ3uD
	U/ut3asadTmebcd0vuZGDB0U1c6+gOpXZUmbAzMOsRo+Dc+9PwjZMaN2Bg4pR4Fch0HRqTlkmI1
	0logdN+9vJt42iwrdMw9BejofbRkEmX+RhVQvoQQqf/wUAsuHh5htANA9GIgJ6TU+nwpw7i7xo5
	weLAFZabP8LmGGcOKbfNwk90nR6LzclBt95pAk793F0EvTufnywMDOUJPaDLWcoDZ4K2U1nV2gC
	Dl8GdkEZgRlMZ9QKfKEapIf3QFn6ZuFBs/nA1XYkIULECM8sZLst9pETAkhbAC0W6u37C7yv5Sj
	aRHA4916wMx981jU5ABfS4BvSv16KCuGX2Yax2RK4Cz6nL0N1MBBr6ydcnIFCyYYtSmyh+4rXiw
	m4NJHEWXD9VGaHHhsxNxCDaHtnq4Q9rm05UZtKP2r+5q9HBC/E5Icpj/nRUQMcfAdmw8tJUu/fu
	gL0/NXRsBO8Ja4fN6mn1iKYF2YTsjuqZI0Y0RuLyWw=
X-Received: by 2002:a17:903:b84:b0:2dd:c053:82fa with SMTP id d9443c01a7336-2ddc053843cmr65687345ad.49.1789910644813;
        Sun, 20 Sep 2026 06:24:04 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df44393990sm4857795ad.20.2026.09.20.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:24:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+ac0a8c41de69121d@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 RESEND 2/2] selftests: net: test cross-device XDP dev-bound attachment
Date: Sun, 20 Sep 2026 21:23:05 +0800
Message-ID: <20260920132303.4109240-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920132303.4109240-3-bestswngs@gmail.com>
References: <20260920132303.4109240-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test which loads dev-bound-only XDP programs on both ends
of a veth pair. Verify that attaching one program to the other device is
rejected with the expected extack.

The second program keeps a bound-only registration for the target device,
recreating the NULL-offdev collision fixed by the previous patch.

Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Resend:
- Start a new thread after the previous v2 was threaded under v1; no patch
  changes.

Changes in v2:
- New patch.

 tools/testing/selftests/net/bpf_offload.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index c856d266c..017910b4d 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -995,6 +995,24 @@ try:
     rm("/sys/fs/bpf/devbound")
     sim.wait_for_flush()
 
+    start_test("Test dev-bound program on a different device...")
+    cmd("ip link add bpfveth0 type veth peer name bpfveth1")
+    try:
+        bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound0",
+                          dev_bind="bpfveth0")
+        bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound1",
+                          dev_bind="bpfveth1")
+        ret, _, err = ip("link set dev bpfveth1 xdpdrv " +
+                         bpf_pinned("/sys/fs/bpf/devbound0"), fail=False,
+                         include_stderr=True)
+        fail(ret == 0, "dev-bound program attached to a different device")
+        check_extack(err, "Program bound to different device.", args)
+    finally:
+        cmd("ip link del bpfveth0", fail=False)
+        rm("/sys/fs/bpf/devbound0")
+        rm("/sys/fs/bpf/devbound1")
+    bpftool_prog_list_wait(expected=0)
+
     start_test("Test XDP load failure...")
     sim.dfs["dev/bpf_bind_verifier_accept"] = 0
     ret, _, err = bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
-- 
2.55.0
