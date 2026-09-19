Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051F3CC323
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815694; cv=none; b=M059QxgFsMIqyY5oJOZgNTDB/i7cQASAViYW8dHM4n8IQC67mAaBh28Ua1J7e0ieqf4Kslb+bO2aYay4EczqH7H0zrlVIlSY4Z8mqCermDxd1QwVUtPIs5m2iZztUGRpPCEyCIelOJmQKwPr6XpVNqvORJdaTs9a1fzL7x8iF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815694; c=relaxed/simple;
	bh=ieyVfeWZqbE1yKbLmklEHB6pUgsMwiuMSXZ+6dhoRdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahaAlJM1EQv3TDm+CZOCm7n+F35kNsF0PNc2L0euMElOwKmRukitsaStgrLJvxVHGNK1Tmei7zXi0Zrl9T53nvvDdz7FzsSiQ4in81Y7JfrsQjEJLCvbQXGifSIbSZTysulD1i6ZKB5pdRBhE3Xh+S0e+2EZRwafZA1nbYMTrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clZn9/ua; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clZn9/ua"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1640262a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815691; x=1790420491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CrEZGhAP68TvzaEU08InnPyZJBhHkfbU1+U3CFH3UQ=;
        b=clZn9/uaP18IW7DvFCYpoXARmC0vHJrCmEE3vA2XDMVDxCaLvmkYNQBAIcZy2ubVYz
         /qldp9QhV1QGiBjx24mtuouBG8yTfFN+dYbOFPlWd6QpHNOz2VZhALqgTQE7sWq4AKg7
         g5ivaxL97KewFi/PiULHhQ4DDETBrjfhxZQtPve51MjE4D9Svp5NtdoAlN21hNaSMWBK
         dJmNotjQM3et7nzXyHBiv7dO+g1fk7Hagoruz3Q2/wetuwmAxNMKQoLb6gwEPzBfNiRu
         HuVRy3a4dZJIOVZ7ry1XJoNrRYklgvwAzLjEV/MUugn8SyBVoY7Y6tdzaGxF0ULBYYZt
         v3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815691; x=1790420491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CrEZGhAP68TvzaEU08InnPyZJBhHkfbU1+U3CFH3UQ=;
        b=bVe5WrQ10TicDHpBQLzs89ET1s8Uu0cOkJsznLFos80o8by+qTPaivTz73KpfaZh5e
         mIHhnsJHvKVH/YNA3oNWPD/s1PoYOOK+rkRgmMwGUhpNWdiWnqIYtZTp4AbXERi/4SkA
         ZNusHcVFRmKkV+ufc6XLbaxx49RXsKjxyezRHNwkrFh5u6zIdhut84sWBEHautdeUHri
         RLHxMnIs1rHTw7k6ol0VwE71+pdYWCA0sYnhm9MjUYAlECVfWA0wShbiALNWTM1Hnm1n
         qEyfuYn9P3Jz+3B2nqcer1wYgGqVWQ+2qTDCs0J5QoiolJAdglBwOnZ2xORU2IBbhLSw
         0M3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQlZ1lwJrCxe2z3InosYkDRhNMvYUIpkEk8q3RzHPrsK/Uu1qBPKGuCMHl1rtL2BfnEFy9Qsc=@vger.kernel.org
X-Gm-Message-State: AFuF++kNHr/khA2mXptSH0c8R4iLqs+7gADhbVfBzGrz5rCWF/fbYns1
	Z3YttTCoKDIAOQrSJtEyMxJAR+ElO3FIsAuzi3WkgLaqlbO7VkdJqlvx
X-Gm-Gg: AYBFou3GWIccz7C6fYiXKXOW9ll1D3KZgxFB8DMXKoi+NnThZSTaRgZcaccSi5ceG7D
	tlsIm43HHFfk7Q3jN5d7VTZe4UiboQA0NeydnKadcdAvoIvxJdDiUWOMjA/q6jHddiszs9WCwZA
	nNDs6sE3YTe9xO4AWnT3QWADnsaPvSkAJOs7VbCO63nhyEOuAn2qoQ4eee5yOMYX8K/vAeB7B0o
	CmFknZjq9MxKmoRa6yhgKK9bYf+omWNFDm3yKEUeDW47WxI4aU0+lY2QptwtgsUShFtIpwrJ2aq
	XwOWRyGEae7gnTXsceJFf0Jop4NAm560Mt9rYV0V1Fj4It//TCJoiWF7OscxUqpcq7kphYOJ5HF
	QZq4ZJv5XZ9sUchpglq93elxWd9cFLcFFNz65wwDOnpTnYoVPs6IHa3pltaWAXu8/L9mlhAKFOo
	tdNmSPeP0m+s+SmRgyLzaS4QkEXH/AS0gNHF7IL8FKlcDTGrmAhsDyazm5XjU/cUz1UbrYXbAEU
	oZskU+zhJlWSwoc8xJ8SNDGoT+1IAU7
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr3126815a91.61.1789815689714;
        Sat, 19 Sep 2026 04:01:29 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm4147054a91.11.2026.09.19.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:01:29 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	co+ac0a8c41de69121d@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests: net: test cross-device XDP dev-bound attachment
Date: Sat, 19 Sep 2026 19:00:54 +0800
Message-ID: <20260919110053.497301-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919110053.497301-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
 <20260919110053.497301-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

Add a regression test which loads dev-bound-only XDP programs on both ends
of a veth pair. Verify that attaching one program to the other device is
rejected with the expected extack.

The second program keeps a bound-only registration for the target device,
recreating the NULL-offdev collision fixed by the previous patch.

Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
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
