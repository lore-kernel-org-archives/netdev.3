Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DE3DC856
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946064; cv=none; b=LmSoXpXETo/GiGQvAz9bTYC2q/06Nnr2CanA5GZuFjQc2GtN7hi7vEQZUNthOjdxIr4F48lYeP5dp2OW1sQZHDTyHcxAlKqlsXBhh9OCbDnLR7ZrCx5+oRn/AMnlQFO6CjRXyTUYGpSNUZvgG/Qrs2l+GhvS1ZaNJTSaqvPeFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946064; c=relaxed/simple;
	bh=nhZxE20iqrNouy33myorDXb8+bwJsQJcZSRRuLIwtTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSI3NkAvgW6H8Md4T9Nzlzh5pKaR816BtlK//6RN8owRndTqc5X7SzyWUxTqZqbq3vIYU4tIvnF57KXQs0ukzs6hamcPwTO3/46G/w95mqUtiClspiwUNIWr6mOWUtBv+yViBkHZFcgP6rYo0PqMIGXQujzUuRH8Rr8ttiiDDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPZdYCDs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPZdYCDs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so67655e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788946053; x=1789550853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZOiWl3M7/VaLqAJX3bE5+mtA25D2TLANT8C6ELvR88=;
        b=XPZdYCDsa5YsWFLRV9Ffn/xSw14ylG5wQEmTox4o3XeHfjUVJc2d8KExxzMoOx8WiN
         6I2kecAf1F/YA/TzIkQnBEHMCz9zcSF9HBzCZwzxwTcE0A6hAsAcxHdmnn8sjd3jBZyc
         Hc9zLMdMZqj9+cXZrzaPlzyzs/5lZxp+4bh5wvPqpibbcHtR57uj4W2SXzIwcdZ8CH+L
         KjOGG+hziNT5IB6WBppHiNBGWnho74oOfEY+RmMOgvVmEla3Y2L7CXCsBczvssWcCdSQ
         JQi6l/KQVl60ZqMWToRHXBSMlUQxsycEI0XFespaYTgkUPPwaZI5T8HGekV+FSBW3c1U
         oSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946053; x=1789550853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ZOiWl3M7/VaLqAJX3bE5+mtA25D2TLANT8C6ELvR88=;
        b=cj6hDSg+ATX90cPJSNhX38Xi2eH2EHJTaYlY5OVa9x0H45nxPtvcIJ6Egsp16qz+uL
         i8yxUutFHYmtujdT+WTOPeYnLNHT4p4VY2bM3TSZSB7VvcE3vVJEzgeOJVsUbQqcadcV
         lZE004vjGxEoZL6eUVWTwspjTlrr7R3Pr+xvlYP9RSaqOvOiOgDmpF34hfmq2OLF5PkX
         ZJ6TeIrXLaYT+6lkgrLpE1GmcrupxKCXqIHE4mueqUMeENgnBKVDXcrBYaukfF8vT/qb
         KTNuXl7eKDx8I6Z16GP/+zNZH7vtRcOZh6N9qgsDUy3gceRiH42ZEelbGQCALgHWfxW1
         WvEg==
X-Gm-Message-State: AFuF++kIjRYHetZnZrt9O86+Z7RBnW5oODCjSgakhF2nA9iee9RYOnZb
	aphlvyxViZrPIRVF+BKS+gBKX81JEmiBYVUrZX4B0JNZzL/GeOXXBYsXz0CHJmt9xeM=
X-Gm-Gg: AYBFou1GPi6vqOWK+47sH3d6cfL/5UXe/eOvkHss/xTJsHdAktbFkyJqAnN3DECyOTb
	XXOFUW4HeDZ6SeGc6/MiszJmrojXR0K2O0jJqcZKuKX3B7Fo0k+Zd0/lzo+SU3w92i9lLrsjPui
	BWQEUo6jaH3K1x8H0R5OXkxUaaDjxVenWM+j0iPws6ACaYJBYQl8ZMi5vIk6gPZN3eGxOxpUDab
	GFhH8YxWZS0GV5GSRb+Zkz4izAJYCT5qzTQGZwAS/61cqGHOmhRQsLpfwvc7rJHhksHybWAeR/h
	aUnUizy1ukZA+rCqFAA4M5MhCeNghPpgfeucZi9Ovj+8iHM2f13ZQLQLs93OSDqQe3+8wXhE0oM
	rvyeuCE7XNSVeoB8/WS7Z3Nt9gXwgiQRT4Zgm2vF8y+0ZjXegJBcaJlHffTU1WMZX7HDYXHV0Vq
	HvvE3djQidVEIvT2sG0qxsZhas+yw3l8TyQAhUdBW5FHyEhrrb3zPHknWbbtCgRrcAJlem7QCwJ
	HVYBEto1bC/1+Gwn8JB3yuw4w==
X-Received: by 2002:a05:6000:2011:b0:485:9876:82b8 with SMTP id ffacd0b85a97d-485c2411beamr100636f8f.49.1788946052430;
        Wed, 09 Sep 2026 02:27:32 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm41558442f8f.23.2026.09.09.02.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:27:32 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net 3/3] selftests: net: test the vxlan vnifilter VNI range limit
Date: Wed,  9 Sep 2026 12:26:45 +0300
Message-ID: <20260909092645.3105263-4-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909092645.3105263-1-alishmery18@gmail.com>
References: <20260907141001.GA708129@shredder>
 <20260909092645.3105263-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single RTM_NEWTUNNEL or RTM_DELTUNNEL request may span at most 4096
VNIs. Nothing covered the range functionality at all, so add the
boundary cases to the existing API test: a range of exactly the maximum
is accepted and one VNI more is rejected, for both add and delete.

The range used sits above the VNIs the surrounding tests already
install, so it does not disturb them.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
 .../selftests/net/test_vxlan_vnifiltering.sh        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
index 8deacc565afa..464ff353d6c0 100755
--- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
+++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
@@ -371,6 +371,19 @@ vxlan_vnifilter_api()
 	# change vxlan vnifilter flag
 	run_cmd "ip -netns $testns link set dev vxlan-ext1 type vxlan external novnifilter"
 	log_test $? 2 "Cannot unset vnifilter flag on a device"
+
+	# a single request may span at most 4096 vnis
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14095"
+	log_test $? 0 "Add vni range of maximum size"
+
+	run_cmd "bridge -netns $testns vni add dev vxlan-ext1 vni 10000-14096"
+	log_test $? 255 "Cannot add vni range larger than maximum"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14096"
+	log_test $? 255 "Cannot delete vni range larger than maximum"
+
+	run_cmd "bridge -netns $testns vni del dev vxlan-ext1 vni 10000-14095"
+	log_test $? 0 "Delete vni range of maximum size"
 }
 
 # Sanity test vnifilter datapath
-- 
2.53.0

