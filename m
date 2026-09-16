Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A84BF955
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587477; cv=none; b=bmZkxbPhEcwQgE4GQMbzmaCVJd2h/onUBDF7o+HK9LY6LgUJYL5pyDnETsl1WFwh2WPpFf0WZvcBdbHjuy5MKAKrwFjd+bCEqRh43LvdCZgKnJWtgGddt5ZA6wn++IdhMlDN872Iqt5Yq9xgeeZvCK24wd+TtDA6NpZpW4lnKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587477; c=relaxed/simple;
	bh=y6xXqWOvYSXsLSEuNcKM2L/zBtXrSEYd2AuG3tsZsqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgwrmL8CoS6e56AaMp5MbpDgiRKOFKVKm3E/DwlsWlfZHNVtZlX7h89eaNaI05QmSppRWjgb01LiRini88w3lC9X3y624u5V+EiiYLdFR7DJYX06906T1PuzgMXqF29FEU71oBhP3j+a4RhJefJ2fIO49WJodlpUdNG4PZb+hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyRyd8Qo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyRyd8Qo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so931115e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587468; x=1790192268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IZ21S6r7mSJbbzYfZEaWtwaGPB2HSj6XAkt8M6MDS6g=;
        b=pyRyd8QouDmyqUDG32jyyPxTlpWB8RNL1kuPHBsj/QUqbvuHNkLZlN3RGPxTH7D3FX
         rJFWLsG/NoReafY7p/zQtdJRWEaAdaYUV75vEX/CZ4QCHpls8hyih/EdGJZ3MWwH5BEc
         ug88mU3lucEG+2K1nagOAp1PWtJwwSnk6hgczsoAkKkgS9YIpWutH84jKViOfz9pbUOD
         fSRVFvovkFnOk6TGSAF1hftN5ki0t0FoIWtBiR7UVLcti4yqckrCrReKzwBQ1S6206b5
         V9asB8Rn/oJh2kVpKiEKJQqTlR7BUOF0/y8F0A/hhlGWaISCpBKGMACIoRsfgyePKe0L
         sWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587468; x=1790192268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IZ21S6r7mSJbbzYfZEaWtwaGPB2HSj6XAkt8M6MDS6g=;
        b=HSxz8TnTrUsqMBHMlZtqwoXVhMVzJSCGTD5T7GvuISl7cUvA66PjeYC8IugjKf1JEg
         rbfPuia0aoXZvH3UvB2U7HaXJiJoqMfX99aXC+sU3DqHI9hlXoHmG5Cgj8wjNBfe9HY0
         EGDjM6nRwhnu9VzzT0cQqv1bB3rpTydYgFRmDakJ23ABkhstEKlsWQ5//UeJTJQXxzzr
         xJotYB29GAGphzpBa04EcxMd8aQhmhBKJ4A3Ac3yXRQ+VSzeF4RXQ2GLft6EFypppxBt
         EJN+8zuoL6sCsvQKfQEPd7WokP2q0jT0aRxlf6JUP0IVdkWxU0jGHBdjciFcVN8Df9JI
         /adA==
X-Gm-Message-State: AFuF++m7Ovs1gp5NMi449oCXIIKmTvQJar2zkgSn5Zvou42c25jj7oq3
	QuwO9+NEuODufifEiMbXDMApknFj9RGiW6vOGJXwIT8AdV+hfEmay4X4i+t7myZ5yFI=
X-Gm-Gg: AYBFou36+nw1cliciC5tIPkpbKfA8ViW78glUsjyhnkeWhsWoAEOhpzpnd13632JaRf
	GhsPY6wjv1ZuuZBZMLLUJEfSsXUv66d7rxUFkDc2qhljliI5M6G8WOkrosm0qYNZEMcUsDDhRDT
	BxtBabDlJgVW4BQRVQ842YDvldyOtO5PY6zoGV5KScIRrb7PxncRCW5H2dwFVOF3Vlo9MSDhHgz
	zeOmrsoO4b/C2lN+3CpQv6tCd6qBqQFf7OHb1TJbWFgPWbda4zP8eUSIz8cZ2RkhO5KtSmH0vtp
	jtpbI1UbFmqXKN4wktk7xTW+AX0d2wmXsqRFSE8P4AwPSkdfwTsy7ZYvTHXY151Ety2i19vd8em
	sxtmr8hhlgzyLmIuhvlNenzIH45aNas9piHX0tOY9Gb9ydtZNF6AJ3faGVb3Hl2cBwMq4VxC2HW
	ILEM3E1AQNL0rLv3ZCbOu1+0W9CPsAuiLuYYOHv/5md+zp1tUFNYkEqa8skfoYPck=
X-Received: by 2002:a05:600c:83c8:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49eb7341406mr42101875e9.29.1789587467669;
        Wed, 16 Sep 2026 12:37:47 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm12936105e9.13.2026.09.16.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:37:47 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v2 5/5] selftests: net: test the vxlan vnifilter VNI limit
Date: Wed, 16 Sep 2026 22:34:49 +0300
Message-ID: <20260916193449.2552039-6-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193449.2552039-1-alishmery18@gmail.com>
References: <20260916193449.2552039-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the vnifilter API test with the largest accepted range and one
VNI more rejected, for both add and delete, and with the 24-bit boundary
the first patch enforces.

The oversized delete is written so that it can only fail on the limit.
If it covered VNIs that were never installed, a kernel without the limit
would reach vxlan_vni_del(), fail with -ENOENT on the first missing VNI,
and iproute2 would map that to the same exit status the test expects, so
the case would pass while the limit was gone. Installing the range first
makes every VNI of the oversized delete exist, leaving the limit as the
only reason for it to fail.

bridge(8) sends one VXLAN_VNIFILTER_ENTRY per message, so these cases
exercise the single-entry path only; the per-message total across
several entries is not reachable from iproute2.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/
 .../selftests/net/test_vxlan_vnifiltering.sh  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
index 8deacc565afa..7cd4acc76ed6 100755
--- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
+++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
@@ -371,6 +371,40 @@ vxlan_vnifilter_api()
 	# change vxlan vnifilter flag
 	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external novnifilter"
 	log_test $? 2 "Cannot unset vnifilter flag on a device"
+
+	# a single request may touch at most 4096 vnis in total. bridge(8)
+	# sends one range per message, so these cover the one-entry case; the
+	# total across several entries of one message is not reachable from
+	# iproute2.
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14095"
+	log_test $? 0 "Add vni range of maximum size"
+
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14096"
+	log_test $? 255 "Cannot add vni range larger than maximum"
+
+	# install the one vni past that range as well, so that the oversized
+	# delete below can only fail on the limit and not on a missing vni
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 14096"
+	log_test $? 0 "Add the vni past the maximum range"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14096"
+	log_test $? 255 "Cannot delete vni range larger than maximum"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14095"
+	log_test $? 0 "Delete vni range of maximum size"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 14096"
+	log_test $? 0 "Delete the vni past the maximum range"
+
+	# the vxlan header carries 24 bits, so a vni above that is rejected
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 16777215"
+	log_test $? 0 "Add the highest vni the vxlan header can carry"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 16777215"
+	log_test $? 0 "Delete the highest vni the vxlan header can carry"
+
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 16777216"
+	log_test $? 255 "Cannot add a vni the vxlan header cannot carry"
 }
 
 # Sanity test vnifilter datapath
-- 
2.53.0

