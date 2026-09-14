Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D640F75D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376687; cv=none; b=NUir/riveKOVRZP8jjkF2mU96R437BO8zcNcIUNYbMhdfZL0HfHwQ4XB4Nn78EwWioxUzNaGW4A64O2SD3U+TwLFzWbfFDVEE0DaXHW6QNYE/EJIc24jdCui84lRFZFGp6ZSpsbL3JHq05mMZqSVHHw/XqF7tJB1acAofwKnnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376687; c=relaxed/simple;
	bh=+kYxVA269QSdSI76NmqygD6fADEqBxPvmi9m4oziKys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8VRDRK5zOLjCLrXOl/eDxpJvd8v/oM6NtvnDr47oylAYlwwbi2QaXqHFVP0mEcBsmFAkNjjONvkgSo8j+BqYx2k6Hl2U8hMgfifTOn8wWES97djizVvnYF7C8ptTEU6BpfKbTqwtw80HZlS6kh8oRx3PW58WogIy4OAOEKfkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=Ripl6QQ0; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="Ripl6QQ0"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1ddd5d0aso1164515e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1789376683; x=1789981483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y+ZxnVustyskk4m7lWyI5feD0wenHef7tflNZipPiYY=;
        b=Ripl6QQ0Sik6oYv1nmEbYYPKNfMpBX9ERpUx6wufuyqnNbq2deDPbublQ2lOD+XLAa
         z20wlCIBgJ6zWqXkI+DbsT94ifp9McCAE6aZyqbJj18T6li+d/+mtEToPZmf7QcGCGVn
         d3ptdD9zLHXQKoIA8H8twND0/k0elmxBIsX2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376683; x=1789981483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y+ZxnVustyskk4m7lWyI5feD0wenHef7tflNZipPiYY=;
        b=ids8KQpsLCv2G25z9LABOf6Cl3UW19oJaA8MZrRCU5kIVDCT2R3q4OG+MbFrCZBDQ7
         1AEFrleAwI7P6MVtGaC2j5/mz13pAd2tN8OuAyU9IHrUTBZvr31+4uBpiIJ/D5nyRFT0
         hVamsDp5AyeXb0pw6jyIcHM+liYSw/cIhBJkKliUYHU8q5+IzPuAVUw6gCk1rn3zH6Zz
         MzmZ0Luh29ehYgdXVX+zbNIMS9sMpswrq00SeQ1HHXStmQlIjO2JXgTcg0O+xM8bPqJB
         g4PiEY0w7TbroXieYzN2vd2fZJEYN2rwHP3yqMJIWH+ZtwQJRPxRZSaZ5/keDUjQUoab
         uw5Q==
X-Gm-Message-State: AFuF++nNXdKwrT1/UEtFePysqIdMLX6JxoWTP/Y9RgkuOPQjBu79AgC+
	0jO2yyYWvVaZZW3UoGgd0xC64YILfPcX63o2iUyyhc4Y1On+sEvH7qugpehHne8OxS1vvWIZe1w
	tqNGH1guyJ3hkwd7fzZmMpxJASmYAxWimlt2bJTP8mpR9bJDp/gpXn8iDiJRaVLLUXPh+hYq0VB
	+Cs51u2rdPG2miP7hhtF3CZuOScT59SRk2f2DQ9ue9yQMb4wGxiboxUn2mMg==
X-Gm-Gg: AYBFou1kN3qWEtcH1v41D4++mp6wvTSPmrvwguvHY71Vr9vOznOx76kCzd9K/kFx4eP
	Ho+0ImXo+a0kFCNIXHFzmK9DWQ0KI7taSPWWS35A0uNUAlN0gELt/Z9ocL00XzZKfj++AP/fCeG
	7W95oovYdLyOG7i66C+Zi2CIUC4Jv5V+Guzu2fxMIvHWStnfy4ThgakbnBKPbYq4Jxl2S1ZOHz5
	SeDqRrXwKf6Z9V+TzlNmOiEflMx2SApdfFZUARO4L0YRbHni8vCgEp/30mgIMM9an8o+9qli7jp
	wuB3Ma1/IX2UcFuaY/3UlahY7kgIQrAXB2GpepFELTTIB5xf+v54aXUa3oo01hwYCLcaliEmPeE
	eP0zPatekVwAsPn/tKKoaPNbQpQ5vdoIc1e7zJygBmNuqghw5l8XfRRC7PvgiX+nwAE97uaik0o
	8QLYHq5sGS0HIzVr75FXNbjHg55qTQmOZo/7nBh0w81HPD24oPQcG9B5NCTTKSc+7iX81q3bIwG
	WZTVYOgsbtA32DtI40qlW/ynF9/mI0zMPj1
X-Received: by 2002:a05:600c:4683:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49e7a5ed9a7mr15588095e9.0.1789376682771;
        Mon, 14 Sep 2026 02:04:42 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm227502585e9.5.2026.09.14.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:04:42 -0700 (PDT)
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
	amit.klein@mail.huji.ac.il,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Subject: [PATCH net v3 2/2] selftests: net: packetdrill: test exclusion of old ACK from TCP fast path
Date: Mon, 14 Sep 2026 12:04:08 +0300
Message-ID: <20260914090408.1435080-3-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il>
References: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il>
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
 .../tcp_rfc5961_reject-old-ack.pkt            | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt
new file mode 100644
index 000000000000..32dd9de1d366
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_invalid_ratelimit=0
+`
+
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

