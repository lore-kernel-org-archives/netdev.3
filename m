Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D023B2FE3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413488; cv=none; b=Fpip4IzYLB9WCaijVBBwZinHTaoL60yI5crWtp5MbQN706DCTKGllmnvYLZ9f3x27TgQqMxeOhDBeD4r/oxXWrObkjn53bER0PO6zpMWGbJ9clNWu/irpWNUOxavPxQvN0NFjOq8Pit33cv/X2mKq3Euns2rsCR32ZUHZN0uk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413488; c=relaxed/simple;
	bh=5L3rxVqo/q+LzdNYiYwvvqN4YwWQmTUyUp7q/mn5s18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deRPr0jriEtxsCVh4/ussEVTVX9AzHffLdurieOpXjWvWDsa0GOt9FxqhphB0Aa44zeTRew+7u+mQ75+Xza7GsqLs/WNot/9BzWwIpoMu0EN54COpmiDxEk0Yumcga3DxMpeW6Usn/309RWOKR0/jYsQqiN5Jro6OdmAHtMFRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be19f05d7dso545484eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413486; x=1774018286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HhwdugrCRsR5oiEhkEWTd6TGEnJjk75ILAki+ES5OCs=;
        b=myqmlBmfYan4BF1c3/TdkeapwOgkjYDhxLjFIooiW+wEgekAop4mT1zCXpkyzCvnm7
         UqrHlab/ZYKgFJ8Wyg7AqNgQBc5xLyIMs0b/gZL1uFoDq3P+p0Ml+AvKCVSjo+EGyst4
         N6+zdMKrmcf9FERuVQgb7fzaaAnu0j6KqL39se/bbvdbPbtGRODNkfps4fOmzybotjca
         /7UsWOm4FLw2k1nKNx2ttc0yo5X7gV71ieBb65cSQGydfVq3MAeRLqqhLmZfIwaDTHCF
         /GCgqs0yG5YF+L6zkFFbzJkoDLeCAl1tiA+rZPHyf31HVpfW2S6O32M9exTWWCuWhqFl
         TzWA==
X-Gm-Message-State: AOJu0YyeuUGwIzPTyW8PhWh+F9z5ge7ul028DPOt5f8LAGZOMNJCsu6O
	B7xGYl+DglYTxbF/kJBLGeXJOJs3AZCnFEIYc20wWEyBQDfae31rs86EJMiD
X-Gm-Gg: ATEYQzxZusnjaLnloQRjEa7cDnuY4K2RjkTknf+z8bio8Ii7OivAKw/NOTDIW8LsfSq
	GM4VUhT3MLEmuZJt3ULys48WUbi3sbpXsct0dDB9rbTB6vjljC/mR9S8suOr660FjUVCj573vZ1
	ytQ8tCwIyX4BAqwDNvtFX8IRhLWhkDOfeB+ORFeMl+WaCov6Ct2Mhe2Sxj2LBphMhuMmrFgOEEk
	Sgqt5iz2TjvxVY3Z8Z8TG8iIPnraaiPq4kwYqKXa29wbEnxPQAHPbR3nztaaPh+ZsSJPDj3HrlQ
	ZnF6wqSNPbHHlZxYi6wf10EJCN3Rjc7tnLy0d9dP8M6dpM1kC+Cz6P6ELjhfSe5Vo7wGmME3CqX
	/eoeLB32fv/XnQCX/hXLioWZFmrU7KNetDdUWtkIwbO9SIt/VaIGnfJuWfBq9M+1nqX6X0zHB6K
	35LxMnPGGbSgBoXrgAPcFt38VmLSNUUD9GaNGxXKlxVdHgwS4QHSG+HRdVT1eVDAMduIQVg9qlD
	3cqeyBk/N1YxR8MEg==
X-Received: by 2002:a05:7022:68a9:b0:127:3b1d:14bd with SMTP id a92af1059eb24-128f3d81536mr1836126c88.20.1773413486040;
        Fri, 13 Mar 2026 07:51:26 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62af8desm2116707c88.6.2026.03.13.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 11/11] selftests: net: add team_bridge_macvlan rx_mode test
Date: Fri, 13 Mar 2026 07:51:13 -0700
Message-ID: <20260313145113.1424442-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5a5ff88321d5..c499953d4885 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -23,6 +23,7 @@ ALL_TESTS="
 	kci_test_encap
 	kci_test_macsec
 	kci_test_macsec_vlan
+	kci_test_team_bridge_macvlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -636,6 +637,49 @@ kci_test_macsec_vlan()
 	end_test "PASS: macsec_vlan"
 }
 
+# Test ndo_change_rx_flags call from dev_uc_add under addr_list_lock spinlock.
+# When we are flipping the promisc, make sure it runs on the work queue.
+#
+# https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
+# With (more conventional) macvlan instead of macsec.
+# macvlan -> bridge -> team -> dummy
+kci_test_team_bridge_macvlan()
+{
+	local vlan="test_macv1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local dummy="test_dummy1"
+	local ret=0
+
+	run_cmd ip link add $team type team
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: team_bridge_macvlan: can't add team interface"
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add $dummy type dummy
+	run_cmd ip link set $dummy master $team
+	run_cmd ip link set $team up
+	run_cmd ip link add $bridge type bridge vlan_filtering 1
+	run_cmd ip link set $bridge up
+	run_cmd ip link set $team master $bridge
+	run_cmd ip link add link $bridge name $vlan \
+		address 00:aa:bb:cc:dd:ee type macvlan mode bridge
+	run_cmd ip link set $vlan up
+
+	run_cmd ip link del $vlan
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+	run_cmd ip link del $dummy
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: team_bridge_macvlan"
+		return 1
+	fi
+
+	end_test "PASS: team_bridge_macvlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.53.0

