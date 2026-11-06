Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977517;
	b=MrChAOQ+GMHkAGKXVQP7qIJmejxzaNLuIstPSE6lsDjPU562yF+aKgONy4FOMiEMa4tB
	 m4HvEhdEMHtonIv/0fijl8VjpMcO5jJ+nQVbYpwMpSNOfr2V2It39d/T0SRZDR4zvJp5A
	 ygDV6+vghdwIOOlLfF3XM48PNpDUKMUt6VnahVFjyTCHVjP7btVx823hbJTDiVj/0IOBf
	 bxjwEKMFg7xQL7wHjvHPBc68+ZAgjcX+PQ0efYOPoVweDMZGnSV6+lOEkSCJ7Rx8C/G5u
	 DKIlBs4apytsGj+snkQQbyJb4qgpyPWtrkbGybeK96bpqiqtJV3IW2nFmEujkMQ2OuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x4ebrvmdLU6EKPb4ZWVcguXHkQGxBYos3/0gbpsvT5k=;
	b=sRWHQcttaj6MjjTXZrYc5hMuHSJG754CNBI6J3R7FwU4ELA/0xKiqjzI8kQi7clw5fu0
	 ZKssplKGNuZ76DgkLHQw87QrfQMKDjQubYssYoXCRQWEKo7aW+Y4Gykj4fWezhi9+MifN
	 nPP/LOkNQTos8wFcE51BlP9S+M2qDlvSMO8SZkYw5dHSIXGlrhlOL5/S/cOiRf2ieuPYG
	 P8/YJ/ZHXozcPQ1dYkamDNqL6iSttmzRAeQ7hAm8Vox91GtUnCiajJQfp53qHMVKaPPpO
	 923cxSIa5jYlavnLTDLUJN84PbzQzgINEuYtfau0kRK11hhTRvE3dpm7ZgEIE47EP3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwgv8l4Y;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3209606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3209606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwgv8l4Y
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59ffacb51so780625e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977515; x=1794582315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4ebrvmdLU6EKPb4ZWVcguXHkQGxBYos3/0gbpsvT5k=;
        b=rwgv8l4YyYaxXg7OKRyBgrec81Wj2XRwnaT2rX8+mqtfax8O3c03Ic+U6aSBpJFY/y
         nEX6ZIKAh8Hy0TtrYwI42iVJNpvaZ2IIV5tUt4HtUnH+sT1wC7AQ0iNp3EAyp3Gmr8GP
         l8YnNTZXAS1lYleXsSzw1Y0s3hmfDNFcfEbZYItGu7ifEmssnowHZydjvWZX0E6QMr4r
         A5F0ujiGz5jePPpCxhU2Si9nuQnGXmtB6kcC8Yof08dPSbjmd3mykchA0YN71qFfuGmn
         PGihV1cs315CtZkT5pUcmSSGN6hc+qN7LbHV3x852jEyiFM9Tm5dBKKa5SgZmjcnFSTg
         VHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977515; x=1794582315;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x4ebrvmdLU6EKPb4ZWVcguXHkQGxBYos3/0gbpsvT5k=;
        b=L0LhsY6WXz8XGcRy8KP6BPXhnUpx/3DkzOJB2VPvR3PyuVV1kYd164dvQxILaEhuUg
         XrFuJ1k92CNfMKzU7u8Ad239KY5WXlhZPMOWt3Aqgns1Y9NuM5YYxijc609v/ex3OMO/
         MyhCi0HCxmC3RC5gD1qdkt1TuPX6Tws0UP9+C5HoucqqLnGpaM2FX07dOLvuNPLyHAVj
         KQdfMRU6Zbdg7QShUA8Lo0OTvummh4ywPHS57FRZv8WrnfKXD9lK92G8DL639f3Mf6XP
         jzDzE1ikUnRHDVMIUay9SyGUrpuc+hQwy+oIlIN1KrWp/sWCDrkktK7rDwZygE2qCy7O
         8tBg==
X-Gm-Message-State: APuU4Z/sqGi/ZGTvHhqrwsHmrZqf7bcKns7MGMuFb8asmoB8No91/yHg
	2ynN/RyhvtivemGeZfz1vilmtKe9fzjFRNbYmqgLxUxd/ObO2t/2kng2d3XvcyKH
X-Gm-Gg: AYBFou0OIH4Ys5i8204OVXTYVYcWSd3Q3/4TqSOxCw7h+Ym1m+5a70CvipFL5Wss5Ri
	FPcmoIeomDeXX6lUmKCDYuWn58BdTHW55MT6yPGgA2nhOoENP6jbByggl3Iyt9fZ1H+b8oU1dT/
	SQLExUK+B0fLJEGVhxDxMdy41rLk+3tTggX5388yPFbvGqRM8eZEj26Ww7HF2l+M3RQPBvj5z7E
	HyChDfYsKOg83Ep1olr9EHn7aq/id9FLCr8Qc1A0tpyaDz19Kzx1Bmu7T7ev5yXk0CwoprKu0FY
	pvibcBURZICo/Dk0cvMrWt6JZ1cDGpTozT+cnBdYHaP0aUAd3oVJRMdLLGLAgXB8GP6nxZz2YTb
	2okvkC8MVtPJ7QAVS4kfzAvBL1PfVco3jL6Pvuv5TyMUktUnfiBUjammBG/XV4mJMysUKgW/Qks
	V+Mwuukxq4a0US4bD4O6/uD/dFtieZc6qA17PQyEzfo1N6cJD1iP/Uk9TbcPYgmTaCK6tVvJVqH
	yKkHkHbW6vLbqDVHHLhlGLw1nlrnC0g8pDUpoTSJRQ56NyjzOPMOWYbMmx7aAGOgpzBhPo3Q2Vb
	Vc8TMz4/b9i/I+T1yLFJ8rI04w8la6LtU6kRLra8hIohFucp+bS+v0dVBL3kuCbIvOzuJAED
X-Received: by 2002:a05:600c:c111:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4b6dcf861ebmr36412065e9.1.1793977514681;
        Fri, 06 Nov 2026 07:05:14 -0800 (PST)
Received: from localhost.localdomain ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcc6sm260950305e9.2.2026.11.06.07.05.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 07:05:14 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	hmohsin@meta.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
Subject: [PATCH net 0/2] selftests: drv-net: ring_reconfig: handle devices without channel config
Date: Fri,  6 Nov 2026 18:05:07 +0300
Message-ID: <20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ring_reconfig.py assumes that a device which supports ring parameters
also supports the ethtool channel query. Drivers without a
get_channels op, such as e1000e, return -EOPNOTSUPP for it, and the
resulting NlError makes all three tests fail.

On a ThinkPad T480 with an I219-V (e1000e) "ethtool -g" works while
"ethtool -l" returns "Operation not supported", and running the test
functions through the in-tree YNL library against the device shows
the three failures.

Patch 1 skips channels() and lets ringparam() continue without the
optional channel reduction, patch 2 skips reconfig_tx_stall(). Only
EOPNOTSUPP is handled; any other error still fails. The patches are
split because the affected code came from two different commits.

Testing: there is no remote endpoint for the T480, so the full test
was not run. The test functions were run against the real device
under ksft_run with a stub environment and all ethtool set requests
blocked: before the series all three fail, after it two are skipped
and the channel helper returns after the query. They were also run
against an emulated ethtool family (unsupported channels, other
errors, devices with combined or separate rx/tx channels, failing
channel set and restore) to check that other errors still fail and
that behaviour with channel support is unchanged. pylint and ruff
report nothing new. Not tested: the full test with NETIF and a remote
endpoint, and the rest of ringparam() on e1000e (see the note in
patch 1 about ring size clamping).

I found this while looking for kernel tests I could validate on my
ThinkPad T480. I investigated and validated the issue on that
hardware, defined the scope of the fix, reviewed and refined the
implementation, and extended the regression tests used to validate
it.

This work was AI-assisted: OpenAI Codex helped with the initial
source analysis, and Claude Code drafted the implementation,
changelogs and test tooling. I take responsibility for the submitted
changes.

Bilal Yazıcıoğlu (2):
  selftests: drv-net: ring_reconfig: handle devices without channel
    config
  selftests: drv-net: ring_reconfig: skip tx stall test without channel
    config

 .../selftests/drivers/net/ring_reconfig.py    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)


base-commit: 19a227903e65c7a9c179156485660a4e017575fe
-- 
2.56.0

