Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957736;
	b=DPK6RhQrnbBleaN5DB8XiDmvhnsK6BWEF/3I42ARYMUYHYwL3zpkFtZT1hAuMigoE/BP
	 RESJiabmK8HwjkZR/MpfSA7zhl/rDS24Z+5xWSN8s2zUfcYy84Y2wretnd/LWOn6b/A+L
	 fsuz/5gPr7KsNcLYRe5NRtguCj4r75OPSor2H7ii6QrQkWQhZT/otxiBNsSxFGSWwqgmV
	 it1c7v23w94hcfsOrgtmfpsG+w8WRMD5wnoy13rojiAjoEVBqp+6iHHcc33JUVR7xaUwy
	 A8eYgIh/ZkIssdPBTkrFBfvqiAllN34zRPoZy9y3oekQZkbsUzkD49XST8ww1MMmiGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957736;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=fS5WVxr10GoJYly37C3EftIHoJWYXFeARnlJUOrJbDc=;
	b=JlfQdBx274Nnw8RjhQABDeKPVRpiIlnHw7RPYACO4pYf21r01qsy4ruEn/2dQ5gkhgUc
	 xZ800efLyNT9aiiVQfkOZPC9kcjnhJQTTsBiIi8kPinW5UkyRvcVYUFA4qBfkJIJPU4VV
	 jueE+wVt9I+7syPo8v59qIdm2uJjHa4f7vbTzbKjCXynQTRFysSB8ZmdYYlqHs+d05JU6
	 8sS0E+yM5TP8/lQCbr6ShWrSnF1XwsR169c1Wa44ZxTNobKGaAMuA44rldeu5EKENxNe7
	 0hSkoSaj6JbU6xM7qAQBUBUJBp+jImlu55KqXAxvZNg6Bl/rddDneDKCgq8gcu68Svw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OV78lg0I;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6A606D82C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B6A606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OV78lg0I
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso241888a91.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957735; x=1794562535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fS5WVxr10GoJYly37C3EftIHoJWYXFeARnlJUOrJbDc=;
        b=Uj+tr910+tyFYXFe2z6xmuz5rZ3N+7xxA7u8A3w80ZT+zcc+wE2yVSQtmq84Ug97r3
         Wg8CogXZZH4RYJZwTe99Qkz/kwSNIwdCeQpT8d9rP4Brxm3mNYOwUdlGzoovHVOlOhud
         TeLXFBGiJpytpC0/GTBG3NMmd3TCRL31ZdnzL5IXVywWwoZaOMrPHzBaGsBB/dHyrwqh
         GkQwRyIgZZ/xHix/3pIqa3GYWlQV5Es8iWX3s9T5lbVWVSGT30OBjyRv3GZXY7s5y0iW
         qWYjfPU1TzlD315zA5yDAz7tTqemvuyyO/NjUZ6DfdpkDfWj9RCpFZphXgg3CPYPfwbr
         DaVg==
X-Gm-Message-State: APuU4Z9Cb6xu3JMl21wna0S5LPXLWf1Z6BEwT8kGdVGIghCC4/J4qxbA
	SjZAPUIRIPji1sm2RdRfv5yG43t2OxjYj+rPkKj4IUycp85lPp4cs5yVJooO/KBEul8BZ4Ll0CO
	ggznHLk6d7EORw4UE+Uk/bCDinwiGH9X/ZhY9ByULqEY6WkmC7DzNqhJ0Q2l/6etDh1ThY69y2W
	r6rs0ag1DwboMgaPz+8N6o0mgHbHwX/Pqhi9GJLLsFi3XLNHBESsJgFgLyjZ09wL0o4NXZGSJb5
	cnJpjUCbg==
X-Gm-Gg: AYBFou1cDUEQkCTzNZBdYXEnDLjbI0n4QwlzYWokOMokIHRFd8gT3cLlMkvsdKXnq4n
	kQY7pEDC9dm6mKx0Qw8g39C4wVvKuowbGykol1glsot43FaZ7h/Hwi1L4qi9nt3m0SdgjzZ+veu
	hvIB90PrfjtUTqMgGdLJAXqKFNjK5UegPhcnEXt6aoh1BV4dyZTyVghXnZIcc3c6NoSqHKLOIXM
	Y8NLKNNUgHmjswEkGpIwnfzwKoGoa6ppd+P0y4jCyS6RoRGl7H9riPtUmlI5jFzzW+sReLJLIeY
	L4P5b56tycKoVyWQPthKbb9MrQ5se6845mhUpcdnXDMC/2zqAEvVGiUlYKj779AQ1CF+xx3GjwR
	6i0vwd0rG9Mh8VZ5xQg9zjIyxrVfWP30slSXDYQv+lJT/SG5x8mN6j7XiG1ygovREnApYyFm0TP
	D5R5UDVzUX3XKH3htbqmi0WC6wcn4exGpf4A==
X-Received: by 2002:a17:90b:164e:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b0db6b6e58mr1148979a91.8.1793957735325;
        Fri, 06 Nov 2026 01:35:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0d7da8e5asm1465751a91.3.2026.11.06.01.35.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:35:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36cec75d8caso660025eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793957734; x=1794562534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fS5WVxr10GoJYly37C3EftIHoJWYXFeARnlJUOrJbDc=;
        b=OV78lg0I19QDLHpkEvcTxmOkqEYNhIzMIAQwlC8IR+QTZrH3Q1okEY30CcUbAY+bNq
         O/Hg08Dbs4II68y6H+Awc7ERZQMfn83K8KCMA59xaYEV9mS7BMGarbCw4WMrB27OrrI3
         T/zxbLFTzImbI+RPpokkp++CWgRAr9/0J1Wi8=
X-Received: by 2002:a05:7300:de02:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-36f76d162d5mr2639314eec.3.1793957733607;
        Fri, 06 Nov 2026 01:35:33 -0800 (PST)
X-Received: by 2002:a05:7300:de02:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-36f76d162d5mr2639270eec.3.1793957732982;
        Fri, 06 Nov 2026 01:35:32 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm6447726eec.19.2026.11.06.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:35:32 -0800 (PST)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v6 00/10] add features to bnge
Date: Fri,  6 Nov 2026 15:05:14 +0530
Message-ID: <20261106093524.838341-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series adds ntuple filter, RSS context, and flow steering
support to bnge driver.
Patch 1 is a pure refactor (no functional change) that relocates the
filter and VNIC related code into the appropriate files. Patch 7 drops
the refcount usage from L2 filters, also with no functional change.
The subsequent patches then add the ethtool commands for configuring 
ntuple flows and RSS contexts.

Thanks,
Vikas

v5->v6:
    - Addressed comments from Sashiko
      https://sashiko.dev/#/patchset/20261103123651.442893-1-vikas.gupta%40broadcom.com
    - Fix inline keyword use in C file.

v4->v5:
    - Addressed comments from Sashiko
      https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com

v3->v4:
    - Addressed comments from Sashiko
      https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917064548.773334-1-vikas.gupta%40broadcom.com
      https://sashiko.dev/#/patchset/20260917064548.773334-1-vikas.gupta%40broadcom.com
    - The patch count drops to 10 now that the HSI patches have been merged.

v2->v3:
   - Build fix.
   - Addressed comments from Sashiko
    https://sashiko.dev/#/patchset/20260908093053.2596020-1-vikas.gupta%40broadcom.com
    Below Sashiko comments are not valid:
     Patch-8: 
                Comment under bnge_toeplitz().
                 Explanation: bnge_toeplitz() is not used for aRFS.
     Patch-9:
                Comment regarding bnge_clear_usr_fltrs().
                 Explanation:
                  Both bnge_clear_usr_fltrs() (only invoked while the
                  interface is down) and bnge_grxclsrule() execute
                  under the netdev instance lock, so they are
                  serialized and never touch the filter list at the 
                  same time.
      Patch-10: 
                Comment "Does this direct dereference of the MAC
                header need a linearization ...".
                 Explanation: ndo_rx_flow_steer runs on the RX path
                after eth_type_trans(), which already accesses and
                pulls the Ethernet header.

                Comment Related to bnge_cfg_ntp_filters().
                 Explanation:
                   bnge_cfg_ntp_filters() runs from bnge_sp_task(),
                   which holds the netdev instance lock while executing.
v1->v2:
   - Build fixes.
   - Addressed comments from Sashiko
   https://sashiko.dev/#/patchset/20260814011435.194631-1-vikas.gupta%40broadcom.com


Vikas Gupta (10):
  bnge: restructure VNIC and filter code
  bnge: add NTUPLE/ARFS VNIC
  bnge: add helper functions for multi RSS contexts
  bnge: add RXFH ethtool support
  bnge: add ethtool support to manage RSS contexts
  bnge: remove refcount from L2 filter
  bnge: add NTUPLE filter infrastructure
  bnge: add NTUPLE filter support in ethtool
  bnge: add aRFS flow steering ndo support
  bnge: add cpu_rmap support for IRQ affinity

 drivers/net/ethernet/broadcom/bnge/Makefile   |    4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   13 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 1140 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  790 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  130 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  170 ++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  534 +++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   94 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  151 ++-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  378 ++++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |   96 ++
 13 files changed, 3188 insertions(+), 321 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

-- 
2.52.0

