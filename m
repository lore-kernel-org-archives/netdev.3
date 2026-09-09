Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F543F8A7
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940649; cv=none; b=S4M7P1sSv+9n/hYUJAJUVnhO6NbpWfK3OsEvDniKI5mN8Z9Yrx53rlizmJSpS/o/Fw5ElQDQz911oedNqURYiPlzJYXdfrwt6y6hBlbHQu48nMDPcEh97iK35kwZxtbxFm3jIAiZGtawtQv8mbg4kYLrM4hUfXMLWkXZUkbr0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940649; c=relaxed/simple;
	bh=PoJ6Q5M0DPUlQ0YysIg5TB4c61efy8lFCLIq+TrJz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQTbHOvRtdtjPBm+l4j3Ftj6TCbJP3hYR8P2AkFJ5IrNxfNsMT1CwNiKpiKvQvMRfAKXOY7gKUt2VvcCQkAh24VAEEj5IP4ueRgKwCbkbEl+tF27KVzKdKNrSeTryjLn1WapGKrXCYqm1EepWrbcji6VGtcT7sQR7+aQEH4dz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=Ge5EEjtK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="Ge5EEjtK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b93204449so2512245e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788940645; x=1789545445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbZ7q/pzMG2HFYHsDRloOW3kv1MN2rhYA4VNX+/OTZ4=;
        b=Ge5EEjtKm72cexlTaNOaNSB9SzZZ0Kleb2/o7EHbA11povM1L3CzcxGwm1LlhmxMPa
         PqGgVpTHbtDuVj8/LflufF+QG/1dljzME/lN7vOaoAfxC3kPc8tuJIjVxTMEoEhf676b
         GJtKdS5IstuQykgRqSEXRgVwLSc/vbCCQDA7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940645; x=1789545445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbZ7q/pzMG2HFYHsDRloOW3kv1MN2rhYA4VNX+/OTZ4=;
        b=ab524w6iDjZpyrd+leOsvEFd4CFm+HlwrogCMG5htdmr8bX32h4Gc4Hb/Uwf+uRJed
         F97o8AWqGKZzDahArqKxlhkZYHkPVfbb9NjXupBeo9RTCoBWe1+2vABOeXoTiVNtJZmS
         LwBq5sSKmoY3IKpx77ohq/SewKlLwfB1dE1yvzjtdBCTJSeCnYoqDmgaW1JU9Iv97xc5
         dJag4Ui8KDmPoynBOs0xZ1+Uu2GKHQJjLHnTbKxKAh/GAd14NbQLq4nO7nECJK8kiijj
         ZAZOiYyxG1JTQFuBtlNpuuL2Pc1lkZ93cnQNCHJ1hQ5yNYMlgMcGU7KqsKOcNnApnE6A
         auWQ==
X-Gm-Message-State: AFuF++m3htgwa/g0rTP4uMQ+8uf4kf3tmOojGgVFF26noAISN3SUhJjY
	LrFgt3iqrVwH8o/C17I++LMZrfJh1oVv9DL8z0m082XT4WyF9xwKPD1w98bfTO/TVWZ6jBmxttn
	+SDJjmC0ssXUPn/JaMNOGPVwnT0SyRqQNuMZNcNH+1DBKP0c6tIGuXui7NLcUuCuYLNW0Ssrep9
	VQ000lhtqcBNTP14bSkF7rhSEPDozqhVAe8jfbD5fuySWi9sKwQu9WXtz+Ig==
X-Gm-Gg: AYBFou1Kjuc05yiSj+Kyh+CwSJqbzJPUI3EgFZid/B6rtNnGKaUXAS33z5sBGor2+wN
	jEWgoTtmYe9Kzit10dfwU9CBSddHnMZz6MjYb2cT4tYCoEnh8QigdmTCt4KYWjeozcjrlEXm9yK
	8R+rjclkp7s1b3iXu0AktrFu7p87ti2/EHDj6OSMoB38vo217v1cVykbc/1Prl3vSopFDbccK9L
	KxYtPK946lalaicpZ/Ngm11zlZbIIpG8saNQDJC5t5VEZ1fx2Owtk+5HqGGFKgPsm0tSbUjCyp1
	zTErxRj34/qgSm+YUZrtB1GTmDwxU7u/JlvnHQWVWjBrsEDFu9vfgXd41xrVwzDyXCUOsRG6IDi
	6MlAn5m3lTyS6gq4/ZQBUsCUD23GMH+JDT5c46o63fLJPnvLTxdx0B6BBGG2UHGKni0GCpsB9n4
	o+AOZZMki9D9VoF2A7sJ8kZxRZtsuEvkoE/a3798r2DJyhiufyaan6TfppcPOxCeRdFznz+pFEw
	T2eNXyOQZe4E9RWD+mpnSwsucMitPscazOL
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id 5b1f17b1804b1-49d010c3969mr239043255e9.0.1788940645463;
        Wed, 09 Sep 2026 00:57:25 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm45677255e9.3.2026.09.09.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:57:25 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Subject: [PATCH net v2 2/2] selftests: net: packetdrill: test exclusion of old ACK from TCP fast path
Date: Wed,  9 Sep 2026 10:56:44 +0300
Message-ID: <20260909075644.1408171-3-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il>
References: <20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a packetdrill test for an in-sequence data segment carrying an
excessively old ACK.

Verify that the segment falls through from the TCP fast path to the slow
path, where the existing ACK validation rejects it and sends a challenge
ACK. The payload is not accepted and RCV.NXT remains unchanged.

Based on the reproducer from Commit 3d501dd326fb
("tcp: do not accept ACK of bytes we never sent").

Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
---
 .../tcp_rfc5961_reject-old-ack.pkt            | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt
new file mode 100644
index 000000000000..8e7229127670
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt
@@ -0,0 +1,23 @@
+// Test rejection of data segments carrying excessively old ACKs
+
+0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1024) = 0
+
+// ---------------- Handshake ------------------- //
++0 < S 0:0(0) win 65535
++0 > S. 0:0(0) ack 1 <...>
++0 < . 1:1(0) ack 1 win 65535
++0 accept(3, ..., ...) = 4
+
+// Populate receive memory so the following segment can use
+// header prediction.
++0 < P. 1:501(500) ack 1 win 65535
++0 > . 1:1(0) ack 501
+
+// Send an in-sequence data segment carrying an excessively old ACK.
++0 < P. 501:1501(1000) ack 2794967397 win 65535
+
+// Challenge ACK; RCV.NXT must remain 501.
++0 > . 1:1(0) ack 501
-- 
2.43.0

