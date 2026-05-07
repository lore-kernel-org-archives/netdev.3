Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E67800
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112276; cv=none; b=GoCU3yJk0Vs9nRWIF9u7UqRCiLZGt+qONCz24NHbz5qP9gDm6JYi03zvLPILcujqsXGWkqo1LPX0J48hsSUVilqDhumg/W24uT5fplpjf/oa6cepStWbgZgRF6H2WFWvHonBdLvd5DDoG0GJ7ZNNH0u7VrN/5Yq7c0+ObEuqOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112276; c=relaxed/simple;
	bh=Tg5TruUAInPgPbeh2Se6Ejd6i06XFBwHuLdZW2mdD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6zUA4daQtSUI/db7GwI1wLoWUvzJRcuXDlHpQqBdtaaQOCIet/nfIvn0PqahtqY/PNeBwIY6mTutzyNNKx9m/rNNJBT/tUwrsKdy/c1Bb0AcJGM3l8NEUP70SVPMgFJnq8ShXWu801IjfdIFVSxvMTy9pR4tGMUf5wbkwRBtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCJ8wYWb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCJ8wYWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7FBC2BCB0;
	Thu,  7 May 2026 00:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778112276;
	bh=Tg5TruUAInPgPbeh2Se6Ejd6i06XFBwHuLdZW2mdD7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCJ8wYWb/jsv4jHyYpJoqrYDbHbAV1nkKreWJOqNOtl6c/nbNBa3/KJ1G0tB8gPbS
	 zk0ZNJ05PempTLCvB6ufbf1ROvi6y/cPpImMFPUZVrRYounQbRIOIoKHwO9NpzDF5c
	 qTBE65okEhQKeAiSSXTEI3swOih7c72X7drhhpJpeyz4MwgbsEt49rHKPY4Q842Egq
	 3s1swMIxunF0qA80XBBt/0oMRr9ZKiuPz+Pf8or2AU96gTAzg5/i352ieUvmxOkS25
	 3JpHdfLXA9FO2KyYBHanTQrSBu4JQXRc/twx6BZddUZkI1WS9gK4XdyV+TZItXzZ2e
	 MjCJpE/J8BVrg==
Date: Wed, 6 May 2026 17:04:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/8] tools/selftests: Add a VXLAN+IPsec traffic test
Message-ID: <20260506170435.34984dfc@kernel.org>
In-Reply-To: <20260505132326.1362733-5-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
	<20260505132326.1362733-5-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 15:23:00 +0200 Steffen Klassert wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index dd50cb8a7911..ae0168c2bbe6 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -12,5 +12,10 @@ CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
>  CONFIG_NETKIT=y
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_INET6_ESP=y
> +CONFIG_INET6_ESP_OFFLOAD=y
> +CONFIG_INET_ESP=y
> +CONFIG_INET_ESP_OFFLOAD=y
>  CONFIG_UDMABUF=y
>  CONFIG_VXLAN=y
> +CONFIG_XFRM_USER=y

Oh, sorry, changed my mind we can't pull this:( both the Makefile and
config break alphabetic sort, our CI will flag every incoming as red 
if we merge this as is, we need this on top:

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3b6ff4708005..82809d5b2478 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -28,12 +28,12 @@ TEST_PROGS = \
        ethtool_rmon.sh \
        ethtool_std_stats.sh \
        gro_hw.py \
        hw_stats_l3.sh \
        hw_stats_l3_gre.sh \
-       ipsec_vxlan.py \
        iou-zcrx.py \
+       ipsec_vxlan.py \
        irq.py \
        loopback.sh \
        nic_timestamp.py \
        nk_netns.py \
        nk_qlease.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index ae0168c2bbe6..8c132ace2b8d 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,21 +1,21 @@
 CONFIG_BPF_SYSCALL=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESP_OFFLOAD=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
-CONFIG_INET6_ESP=y
-CONFIG_INET6_ESP_OFFLOAD=y
-CONFIG_INET_ESP=y
-CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
 CONFIG_XFRM_USER=y
