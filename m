Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB792FD7D3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590484; cv=none; b=L3alwvLiOQTgSIGxUpUFz0LgCpwiR3Fd8XYjMDgGUwVSd1trCGUg7dbu7hHYlaQKZC5s62X8kg+X6ucO6cesEG7dhdY7DflPYcwbeNu75GYNAKZdd3/h0K2wJAqcrhbygL2a3sjvgpjga6+tmjyczxvGEM8OVZCz4ak1/lkSWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590484; c=relaxed/simple;
	bh=mTfz//S02D+E9NcyVZC2mIxi+/sJfzplMtuwvDmQTqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhNMHEQHCCWxr5h1B2MXBXlkArvfKrfG5e3ZRcIaee4hwwuhZ7MLvfTCM6JGapME0wRrdTNmIVrfT/AYDotxi2HZBn0mwrhM34Xo+FffiMLUkL8O7KFJstGF8KfJIzkcz+sQFfya2h6G1MySaPNPNTkMCoxPUFeY2LpBgDEk3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/1E7ZtX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/1E7ZtX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1358022a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786590482; x=1787195282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXT+TFtZILC9kput4/TKXz12rDzU5NmQQ01pk2ZkiiM=;
        b=c/1E7ZtXhTxAU7LBzJ/jc6CV3MntOLb6efK1YKAxvzqWzCJ9gsngiwiQML9eJ/UUlK
         +IBYINDtt4Z5KVmB1WToHAjrHomB1I5W3QTS/4p0FiYVIpOjrktGWHywE+VnHiAHztzI
         RP9WBOpWUba3p2oiakG+R5NVEicONAR8SNQ78V8IsXpHjVtZXnjPBVHNjaxiGxYmiefA
         WAT2o6rkU7VR90YhvYWMNY0VzBlQWay7Gu47rKmQz2NnM7ADDT1DuCKnWzDQSSXUUGY1
         VgYTu/id6m+GDBSigDfQYXK7RhuOVkt8qn5u99o0OB9XVrhlnp99i4OXrzfd+zSZlIet
         KbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786590482; x=1787195282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXT+TFtZILC9kput4/TKXz12rDzU5NmQQ01pk2ZkiiM=;
        b=JrMdzUuaRbIrcoJAmtU5+KJFTID/thbwtFrgwPczhLyrrxzLjAHoVeax7soaFlBTky
         5kiprFHVCdvhpTWRMZXmjhG873kUViQ/KSszlmXOq+eUx/vPGBb+Na3vtMzJ3NlrIXWj
         vXECj+DtvfyaTbyHLTeFjpnNAWe6RDC5scuPGCYzXOiYnETXQcozZ19bqNctIKfwAXqA
         43RwU57ovL++UNCTOUz0sBvIYdil9e/KyGnFbitubYBBtRRDRN3ASXTN5/ndt7XFtlhG
         5HZRuG24ntqt9MXUXjX9MvVNI5BHhJCkVIhDVQWrDPKpCGpkidgg55D8k5DNFxx+AkZY
         xUrg==
X-Forwarded-Encrypted: i=1; AHgh+RpoK1EdFVA+Jdpe8Mqnduf6nvVEMlF3CjROO1NqMwiD8EuLGHZKO9O/wd0oxytSIvQdQpgdoMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytvlCQaLwbIen8PAJHfBsEWvqFrlHgc8cQPanDFPTyO+vpwS4
	AfMbvoBhfQ347ZFn5luYcq7B6732SEYLbiyCnBKOEvXfIXtBmT9IVrQk
X-Gm-Gg: AR+sD13V87MZ2zPJpun9+5KhM4pfZlOiXMHHAIr+VDne562wpWnIicHVmGIbL1OBP6F
	i1SFZb6sQLwGheAPo6xzEw+wHHJE8nLn8ZjVGI6LpYq9ej5og/YVc92U5a1GnxFdw3gnRrvOhiC
	WcegKiNz1koXMqOkQ4qcX3ZKSw7xHOWPE7bz+A/ZCaY49ZaxLj9bTIL3M07e5atBbAVS9i3Of0S
	pT1GIU84NSpc6OTqc+9vnAMMnFmpP3CVIVp9aSdBA+9MHG4Q5CLdOReykNLXtomIe4XfS6H5V9N
	7ivOOnKtyMms2G9rIrhAIBOuZJ8lzWL0pawNWiEvN0OOnuS+vLrndbOPiqbf52JZjKD9TWFQzq8
	bfWcLJz9JgB4QKk7imSGWRkj6MHAL6UJS7RaG4nuU89iAs93Y8zLNan9Q+K/ny+7wKMqeibOD7g
	bvffiiZIC5kS2MD6eGGzjtE0HQ7gBu0VHTYvq0Q3H3rldWMR/2CeuZ5fgN3n00UJsfMOI1yA51j
	W4DFADfQZnHDwrD2w==
X-Received: by 2002:a05:6a21:7002:b0:3cb:eca6:ce5 with SMTP id adf61e73a8af0-3cc5539af60mr3994167637.24.1786590482312;
        Wed, 12 Aug 2026 20:08:02 -0700 (PDT)
Received: from sdklog.tvstore.opera.com ([2804:1b3:a8c0:46f0:6d62:6c3f:1af0:ff3c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf731f95sm2249048eec.15.2026.08.12.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 20:08:01 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH net-next] selftests: net: separate ipv6_flowlabel_mgr test
Date: Thu, 13 Aug 2026 00:07:05 -0300
Message-ID: <20260813030708.37609-1-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipv6_flowlabel_mgr used to be a component of a broader overall
flow label test, defined in the ipv6_flowlabel.sh file. This wrapper
script called tests defined on ipv6_flowlabel.c and
ipv6_flowlabel_mgr.c files, using predefined parameters and enforcing
the in_netns.sh helper to set network namespaces for each test env.

However, the ipv6_flowlabel_mgr.c was drastically changed recently.
These modifications led to the mgr tests becoming a self contained and
independent test suite, enforcing netns creation by itself and
not relying on the ipv6_flowlabel.sh wrapper for proper test execution
anymore. Therefore, remove the mgr tests from the wrapper and update
the Makefile to handle it as a standalone test program instead.

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 tools/testing/selftests/net/Makefile          | 2 +-
 tools/testing/selftests/net/ipv6_flowlabel.sh | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ab890e6f79dd..0f5c178bc224 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -150,7 +150,6 @@ TEST_GEN_FILES := \
 	ip_local_port_range \
 	ipsec \
 	ipv6_flowlabel \
-	ipv6_flowlabel_mgr \
 	msg_zerocopy \
 	nettest \
 	psock_fanout \
@@ -183,6 +182,7 @@ TEST_GEN_PROGS := \
 	epoll_busy_poll \
 	getsockopt_iter \
 	icmp_rfc4884 \
+	ipv6_flowlabel_mgr \
 	ipv6_fragmentation \
 	proc_net_pktgen \
 	reuseaddr_conflict \
diff --git a/tools/testing/selftests/net/ipv6_flowlabel.sh b/tools/testing/selftests/net/ipv6_flowlabel.sh
index 2eeda39bf64c..5d1b5464c54c 100755
--- a/tools/testing/selftests/net/ipv6_flowlabel.sh
+++ b/tools/testing/selftests/net/ipv6_flowlabel.sh
@@ -7,9 +7,6 @@
 
 set -e
 
-echo "TEST management"
-./ipv6_flowlabel_mgr
-
 echo "TEST datapath"
 ./in_netns.sh \
   sh -c 'sysctl -q -w net.ipv6.auto_flowlabels=0 && ./ipv6_flowlabel -l 1'
-- 
2.55.0

