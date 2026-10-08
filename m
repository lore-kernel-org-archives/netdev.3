Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39814D7D37
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484693; cv=none; b=jbT4/v8Rf33GRG1GYvG4k9cqzTWmBVcwHF944bXw2GNl6CcXvVwf2do0X0vwVtOteIzXKrdZkHXPaa3dQ/xgJB93jEAe81MEmI+ix7VYpmoOoOx0feHAgWrP8/p7f3bLEa1TRr+di050BKYwUwuJ6KyCKGgZcVkKkjA25ygmxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484693; c=relaxed/simple;
	bh=suAC79Lb92vdODjVsBBG58aFPRRoscz21TCCDZVGmFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JI/rtXiHmijOEAWUuBQPfi5UG3f1lzzPCKQspHzdWkaeO2YRXeamlEW9cZvXoSekrvUeagLUReBKG41UYZ1oJG9tqJMz7txGhKlYawwlZAWIwyOq2wFX38F+1OFmxktZKYwpza3XHjHxhQEsCNOsmCMtTgU8XMx/GkNLhuUg8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiA/HrfC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiA/HrfC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49ff680331aso61694855e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791484689; x=1792089489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhdzuOviOybOfOdxdwALihDABzSCdOjxs/WfjtGrXrM=;
        b=iiA/HrfC5mJbNgDDKCGkMSVDyTi5Op7URF7mB0vKQ3GegdZWRTXllCIsV/EAbZTX1B
         MdzsOMqJsCCjGyWNOF+kqQNu7HAhBlbfpDvexOL1+IZqH1prQ4+rvIPEfGiNmYiiCOdN
         P9JnbJvDMIom7zeKI/sgAsPMsM98GJ4jkJXjN663U/AeT1RrTh90oWnHNHAfJIoXnkxA
         4QPqfWSyZv/sMXkrm3f42FdyWpe+rqSF/6xtLFXgNNcZL1Ucp7RGo6qgdtc2Q5dzX/nE
         HAupAEN/wqd5ZfpwFbbPG0QbXxhBh4PiMGT3ShIHPhQUn6hZyIwlgIcVWLnGNLZvxmHH
         R62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484689; x=1792089489;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhdzuOviOybOfOdxdwALihDABzSCdOjxs/WfjtGrXrM=;
        b=pSYQdRhmGqE9LyAECIoadZZm3cfoaH79PpPWaFP7pblhv3dbEF9YLqKRT6xzpP0zKf
         upWj8F86RXH2XJmKNA9WrNduPTPWTG3Stg6j8tJrjnUOjIw883pFdwmNtrbHb8IkT1KT
         D7DsBW2seSlYlxWbZeH6jlw5j2vMGSvCsoHJYxmt4HceTiCvKMr0qnwJzIYpDuE9NBkn
         I6GJRRVJVKISPIn2wiescUQT7Ke8loSV+1vefGjMYpg7reck0cGiPCTzqL8vVHBbgsAz
         Ett+GznJf3nWPxqsBBX+/H4Df72xgXDgNj9rbcVIFmfqv1BUiAfZ54yUKqw4FptAQ/ul
         xy4w==
X-Gm-Message-State: AFuF++lvVCEscxJcQ9hXMbc6JyfL3WkViHFabWnSBDuF+cidb8KgzIt3
	X+eHqpETeOXSPtfyUurTgOOq8J5nJxEXKzTX0nlWEEp1P/cjVVlRvPn3nZdbyn6P
X-Gm-Gg: AYBFou2M1obZhbJCuGQVlzojIIYlxWrqmbhaR1KaXeX67XFQb7ywo3T0PB3eWx+E1tO
	HNCBlvNY/wCi/OtGYUgVJk+75lNeV9olVxGWlEMZATQujDK8oq3foc/X67blQa8vjaNIR3uWY5g
	l9PJE4P8NMu2dJlZJCK1o7i5gw6RtJ+NivUZ1uQARWZCw9vVOBxeWmiw/UdSCIKWmPGHotB9PmO
	WXXW45iW989SaPXaG/wkfVcrUdwJagr2Rq62aa5YJ+gMurpzJ4E6yVpsbpd74jxdRukWdD8+aGL
	2RqSeHGK7kVlERV8FjSKqMEnPAibtXQV8Yxw7PGW0mIbh0iU59QWfYoVstYf6AiPkzVr7Fvnpq+
	aV0QNqI9p9iY+E5sf+4BB5i0dut7gOEad1e+5otAyd+2VhLZoGRc6LAXWXJDVAxeZJ+dyjFiBTy
	59RNF+S+bYcESXxrwlWhWp/ZxVROZwgG2xjBUQbcg7KflV8m/pwQhABAohJmvK8mo0V3DrDG9SC
	B9hCNd6D0Tc6MOQgFw4g2n+5DgC2jgkVP5U2UV3RTVuuli8p8nia9jsNw==
X-Received: by 2002:a05:600c:4e03:b0:4a0:2423:946 with SMTP id 5b1f17b1804b1-4a18064c31cmr105908565e9.15.1791484688923;
        Thu, 08 Oct 2026 11:38:08 -0700 (PDT)
Received: from localhost ([159.26.107.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bbbfc03sm2413385e9.1.2026.10.08.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:38:08 -0700 (PDT)
From: =?UTF-8?q?Dar=C3=ADo=20Hueso=20Gisbert?= <darihueso21@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Dar=C3=ADo=20Hueso=20Gisbert?= <darihueso21@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: rtnetlink: skip ifalias test if uuidgen is missing
Date: Thu,  8 Oct 2026 20:37:41 +0200
Message-ID: <20261008183742.678-1-darihueso21@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kci_test_ifalias() uses uuidgen to generate the alias names, but
uuidgen is not always installed on minimal systems. When it is
missing, the test fails with "uuidgen: command not found" instead of
being reported as skipped.

Check for uuidgen before running the test and return SKIP when it is
not available, as kci_test_promote_secondaries() already does for
ifconfig.

Assisted-by: LLM
Signed-off-by: Darío Hueso Gisbert <darihueso21@gmail.com>
---
The commit message and the added check were drafted with the help of
an LLM (Claude). I reviewed both and tested the script on a kernel
built from mainline, with uuidgen installed (unchanged behaviour) and
with it removed (the ifalias test now reports SKIP instead of FAIL).

On that kernel the unrelated ipsec_offload test fails with and without
this change.

 tools/testing/selftests/net/rtnetlink.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 4843d474538f..c758efb734da 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -412,6 +412,13 @@ kci_test_addrlabel()
 kci_test_ifalias()
 {
 	local ret=0
+
+	run_cmd uuidgen
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: uuidgen not installed"
+		return $ksft_skip
+	fi
+
 	namewant=$(uuidgen)
 	syspathname="/sys/class/net/$devdummy/ifalias"
 	run_cmd ip link set dev "$devdummy" alias "$namewant"
-- 
2.53.0

