Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536707;
	b=iYuOR+NcDses/4SyINMJK7iTvCGVXYA4dodoay2DndLlJpPN2U+m7FuS/pMPaYPncklm
	 dKzFnDEtqqcuEJATWhlM5AHB9EKjzPwzO0PbOGnOiPoIVZ2getMfKTAIyzn58baguAxkQ
	 H9L7RrDcpk0nu/onjQJJGXzXEScrZcswT1oprVxuBI3k3aZHTdwdQIMTPmYIWcB6abpEM
	 CEKeL1tNJzhkIMuBxXvVI6n7nKbAUJgu9JYCmZTkBn4rC169N0eqt3q6uE97Cb2kFdoeH
	 pcj4KHAbS2+o/lGvKNROsbGO++0He7DPC2ZvESm1r419hGYJRPB2yIevU0rezwFXAxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Zxqq5nhDQ6z/IfYQAoXRtEyDpcvq49vwSR86SZQ63GQ=;
	b=X6ysYchC6jpkbtbtIuPYmHfP7qgYbAMp5rkiBhRX87Gd/PVPteEo4IiCbtQ/YOovMZ1K
	 lQAJ46/ykmdnFS3zkTAhLbKeiN47Lh6pSPvH1th11D+f68HPxpIxWY3qte6DNLnD6G6iY
	 0K6yVgxQ8mQPC8rhYi8SdLpYbD5thtENO+J/fCgTkNERyqX6WB7ZKRE+AOzJm7IWDc7Uh
	 qHbpB+7CTwvcamcXkDIJkCYvXELi1Xf53915buafywVfUU9lX526GD94tavxzC1YgdQkK
	 2vsEOcTbDj8y/5mXgLphw3f1VCUn+R8VaDUpqYG/W4vYWcsh5sHvCokFcHR3PfOH0Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Aq4Yq/6e";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B37606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Aq4Yq/6e
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso309714eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792536706; x=1793141506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zxqq5nhDQ6z/IfYQAoXRtEyDpcvq49vwSR86SZQ63GQ=;
        b=Aq4Yq/6eveKKKNK6o7vPlA92sbI+h48KXZ987WZRG2P+KBJtxESmsvnxnnEB1ZCfsJ
         sgmhx/nhOsT1fmAlhoEyP1ywlGwMnSVK7NtYFFXveZpea8leaI/Xq/Lnl4EKPJQeDisX
         p1vrCUdajF3N3skVP7tlBKhnOvyFWIFdYbVoRtPKIHBr+Ias5qeC3on8jGQ8VulRA0zh
         4a+n7DR80eOjnykvytLiVPRSfgHpGx2J1D5RN1P/8X3cDILl7v+YT5HdRcQa9f0M4k6n
         fa5v7CNwJjXauouWirdYaK+BVa5tvyDkX068H+XtS4TlezWjkE8+oN4ZRDJNJf6ZFOsN
         hQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792536706; x=1793141506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zxqq5nhDQ6z/IfYQAoXRtEyDpcvq49vwSR86SZQ63GQ=;
        b=Qi+3qF3ifcq2YRpqCqXX/hcnBbjIP+XQ5Al50S3wSPpK8pdkPii8+r86ysQi4jnhsp
         eI0AhrIYfwXsA4Bj1YUlBHokAMu2pMmrReFagijb8acPDhXehPl4ydDnnWB2V7wP1+Dd
         f6I4JUGxHqL88jZpWwUCMQciqCuVL6esceWdIkwFaOWhYjog0No5tBD1oxyLwm3R8yE7
         bLhugP5ZgiDiapyPZkBjebVUGex0s7javv5Vi0vTQz50EOFDeNIiym6f0kYZPRFqmKHF
         fYoN+Duh+tcwEi9oiH/YV2KCrOPORUFvQFH2qiN7fnglhBPqGxZ6rsRkY83fD6DIPaoF
         wMcw==
X-Gm-Message-State: AFq9FYJAFJAdH5UzVzNIUGCKGj4NNc304Ux5bn6zDr+Lv8HqW15guOX6
	O/EwL2ltuugaERVtLN1rFEHBvv/7y8rvVRFNgXeudDt12fKrqhdmTlt5qpYi0A==
X-Gm-Gg: AYBFou2gT+zjjHerrX9RNXRZFvxDcGirhZwos5aZHADlH+P801S5n77AvepV//5VW78
	6Vfl7wfjEr1d4PP68KHorF9L3ARHXAk2ytNIuwy41f03uTWZitKo07yrpzxA0Xy/lP+x1DmmBPQ
	UmTgITDC9apRqFt3w28X4Aw1Jrc7UB8Pf7ZhaFUYtltec999Rs9/gEMEVqEt5PR4qqBKqj7ZpuG
	SKRv0tWSZ3Vz1/zWDwe7Wl/4uCE6UTND+klWsq1dWMb1Bxp2Uu7dK1RUy1c1hSy9qnucyf8Yiym
	6MoqkgynEwL/iM1DL/CCLQmAIPff2oDE9uKrpClxAyqMWdJwunUrw7qW6Xm2Cbz46ZtFrHYFOr7
	snHqpGneTNQipysqNqU2cFssrNqyxfeTAm4omfTc4yzCbf2N1b2Fn80Nkd9aQBfbMKN7kT4aSau
	5FBXfkNctakquOFFUSWM8PYXfkxs6j1ceDdiDyjbUgERka6nazGNB7mcLBDgTeZCRs0M4JkigGW
	zA73U1ME7kkWHfT7u7kn5fS2AUYPSfio/k3Tw==
X-Received: by 2002:a05:7022:83:b0:15a:9834:73c9 with SMTP id a92af1059eb24-190a941d9famr254809c88.40.1792536705945;
        Tue, 20 Oct 2026 15:51:45 -0700 (PDT)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([152.59.50.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d61csm1515803c88.15.2026.10.20.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:51:45 -0700 (PDT)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH iproute2] lib/fs: fix cgroup2 path for cgroups outside the cgroup namespace
Date: Tue, 20 Oct 2026 22:51:13 +0000
Message-ID: <20261020225114.18233-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
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

get_cgroup2_path() opens a cgroup by its ID, reads the path of the
resulting fd from /proc/self/fd and returns it with the cgroup2 mount
point stripped. It assumes that the path always starts with the mount
point.

That is not true for a cgroup outside the caller's cgroup namespace:
the link then reads as just "/". Skipping strlen(mnt) characters of
it reads past the end of the string into stale stack data, which ss
then prints as the cgroup path.

This happens when ss runs with CAP_DAC_READ_SEARCH (needed for
open_by_handle_at()) inside a cgroup namespace and shows sockets of
processes outside of it, for example in a container started with
--cgroupns private and --cap-add DAC_READ_SEARCH or --privileged.
Without that capability open_by_handle_at() fails, and the socket is
already shown as unreachable.

Reproducer, as root, with a listener in the original cgroup:

  # python3 -m http.server 8080 --bind 127.0.0.1 &
  # mkdir /sys/fs/cgroup/test
  # echo $$ > /sys/fs/cgroup/test/cgroup.procs
  # unshare --cgroup --mount --propagation private sh
  # umount /sys/fs/cgroup; mount -t cgroup2 none /sys/fs/cgroup
  # cat /proc/self/cgroup
  0::/
  # ss -tlne sport = :8080 | grep -o "cgroup:[^ ]*"
  cgroup:-microsoft-standard-WSL2

The garbage depends on what is left on the stack; here it is part of
the kernel release string, and in an Alpine container it was
"s/cgroup".

Only strip the mount point when the path starts with it. Otherwise
return NULL, so that cg_id_to_path() shows the cgroup as unreachable,
the same as when open_by_handle_at() fails:

  # ss -tlne sport = :8080 | grep -o "cgroup:[^ ]*"
  cgroup:unreachable:550d

Fixes: d5e6ee0dac64 ("ss: introduce cgroup2 cache and helper functions")
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
 lib/fs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/fs.c b/lib/fs.c
index 6fe1d6db..1562d25c 100644
--- a/lib/fs.c
+++ b/lib/fs.c
@@ -238,10 +238,18 @@ char *get_cgroup2_path(__u64 id, bool full)
 	}
 	link_buf[link_len] = '\0';
 
-	if (full)
+	if (full) {
 		path = strdup(link_buf);
-	else
-		path = strdup(link_buf + strlen(mnt));
+	} else {
+		size_t mnt_len = strlen(mnt);
+
+		/* A cgroup outside our cgroup namespace is not under the
+		 * mount and the link reads as just "/".
+		 */
+		if (strncmp(link_buf, mnt, mnt_len) != 0)
+			goto out;
+		path = strdup(link_buf + mnt_len);
+	}
 	if (!path)
 		fprintf(stderr,
 			"Failed to allocate memory for cgroup2 path\n");
-- 
2.43.0

