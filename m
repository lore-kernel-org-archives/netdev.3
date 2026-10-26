Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007028;
	b=gf39JlO6Pa10khMfbBb8wcgW4WxRttVqAzd2fpuCBLhhlSwT4hg4sVutU2gepF2YhD34
	 7xLq1XcclUjZU2XckCbPJ/v+Q5GwISfX3xh1I4q15rC/wKW9BcjuTgMJpfMlZD4FcbF6g
	 F8PdoQS4ui4fHGOdqc12qTID2oecWRr5lt6jARdx67QF8vBhTqYLknOP04UnBNfwI423o
	 Y9IRDq999kpF0dkES9sXGPktp9vPsSIvcF+EtbrKBdK2tTtPqTlrM3fCfcdFE6fKXLhaT
	 qHbJ6OsTx7Y8zdt12P07aKIrDbDpzkS9/m8Q6PW6C/DftJkHMBjfhQ1T7kuK9ZIv7YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007028;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=y6qo0wj0rRIS2eApjViaUPtZwXU1dz3SCYfMj/k5mxQ=;
	b=R3AHILok+gZldAWwJYAWWdl2wro0IGw/5dgZAexWtvEIYea91Zo1So1JDINsSQBLJUww
	 cRKeZvdhy701Zqq2o6hjwobLtu69OXdUaLsMLXSUGuNOTWea7BQ5GEuZZmnDMiqwksH13
	 zswSOzP5nCAcp0/v+rK1+8nDbmsbLOd1vpbtmML6Y0AfY6hp2enzOC4B1Rh3avni/gbOW
	 ZM66olfzzGwXMvEYxKBtiTTPfSio00MeF7owq05nEScoL/2Zyn/WmR1RisSWustAKFyf9
	 COvR+yxgZos68Kp9WGrMoAKV3+D9dPEoxP4hFJr5xjKfOX559pUdT4x6b185OMNnalA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Sv598OjS;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17530606A338;
	Mon, 26 Oct 2026 09:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17530606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Sv598OjS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793007017; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=y6qo0wj0rRIS2eApjViaUPtZwXU1dz3SCYfMj/k5mxQ=;
	b=Sv598OjSX6xrXopGjy3ecqKwmgWUSFXNyqKKDJgf50KPfpUNXHy0vQstz9lv93qqAoewHXQwBnmLiFPR26bJwN7DJLGaiLz11LlxiM/fdApDne/m/zV5/A4j+IiyaBlMyIliXfah9ZO3LU6n9XAO9Wt/4P/QDtfWvAWb/4DxqOQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08556221|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0370853-0.000298199-0.962617;FP=6180435180378463291|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jpm1zZP_1793007015;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jpm1zZP_1793007015 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 17:30:16 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: netdev-bot+sinfo@kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	eyal.birger@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH] net: sched: em_ipt: validate hook value from netlink
Date: Mon, 26 Oct 2026 17:30:15 +0800
Message-ID: <20261026093015.49377-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026090717.41597-1-fangxy@xiaopeng.com>
References: <20261026090717.41597-1-fangxy@xiaopeng.com>
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

Hi,

Thanks for the automated review. Here's the additional information:

**How the issue was discovered:**
Identified through automated security scanning tools during internal 
security research, followed by manual code review to confirm the 
vulnerability and assess its impact.

**Whether the issue was actually triggered:**
Yes, successfully reproduced using QEMU/KVM with a kernel built with 
CONFIG_UBSAN=y, CONFIG_UBSAN_TRAP=y, and CONFIG_UBSAN_SHIFT=y.

**Symptoms:**
The reproducer creates a TC basic filter with em_ipt match using addrtype 
revision 1 and hook value 42 (out of valid NF_INET_* range 0-4). This 
triggers the following kernel Oops in check_match():

  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:check_match.cold+0x0/0x2
  RCX: 000000000000002a    <- 0x2a = 42 (the hook value from PoC)

Disassembly confirms the ud2 trap instruction at check_match.cold+0x0 
corresponds to the UBSAN check for the shift operation "1 << im->hook".

Without UBSAN, on x86 the shift instruction may mask the count to low 
5 bits, yielding hook_mask = 0x400, which does not overlap the standard 
hook bits checked by the addrtype interface-limit validation.

Best regards,
Fang Xieyan
