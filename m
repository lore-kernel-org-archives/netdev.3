Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680506;
	b=bUWY6Z0/Srijbb6Cvk3azQhbBqXE/SuAXhP/BYk1uOaCimTsvcGEfInGbmIKgFvt8Zg4
	 bvFbrmbl9aOJ4gJz6vFIXAwdeOqEEjkEvXFfWvMkgKETU3Hk6QEDpspVD/Qbs5vBOAJ19
	 B9iWLfg0DB+pRaCQP/Ambs1CiiHubq9IDKnNBKx93c2FiXzQaw1+2SIOOVFITR6AYoNFX
	 hxt6Qr4SSNLCr+oqxkPufSCWKa/AA/WV1+OwfeBTx84ZaSeGP88D7XUV9Va0J/huE+Dax
	 edH3HYchEWC/43lfr3Kg616c+uhCfLvPOyzjm/PThxZNZJbzmIZ2Hp/0D65CMcl4++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680506;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=TZEMgCC4lPFe6Aq4pxV9q2m4PTyaJp/mWSH9KsdvZtk=;
	b=DRvUtwnXYERZUsFZxy1lVUcWZK+4wM2ocNQV7DVojHa1fLsHVAQ1cPu8YH7JfFmGBHKJ
	 udPgElIiMwYX0CXJ8/tWXJ31rvAXABYmZHRquw1d3vFvWqBH7QaDVEhYWPqgL19iwoCR4
	 W0VZa/FwjXoF1hfjoeY6VT0dP2W+QoQL2c318gJZOVf3mOJaTGoh75YvJynakiGPAYk+S
	 B8Dda2rpYfvtDrm/biQB4FaYHy/bGgr4G2y2EBb8SJX6nisLgx+8+LVkRHZqXX8fomE++
	 dPo9efSFyiCBmVvaQtvOasnJUWBka2Dkqu0jZFM7ro4XrbsP4eP5xMRmfFzX8dkvZ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gqWwojbA;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC7606A327;
	Thu, 22 Oct 2026 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEAC7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gqWwojbA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TZ
	EMgCC4lPFe6Aq4pxV9q2m4PTyaJp/mWSH9KsdvZtk=; b=gqWwojbAMZTbS/3MI3
	zUPFIc/ZEtZMtvaopSf3o/cu19LR7DS0df1F99sKJBqqK9pe/aomrF8K2ZHXuqPz
	rvbDjXW6DGsC2IN8dA03WRpeOhJjTK5Izt56UEYDLEX6fyuYyQ6DG8b+0eHwzVME
	macLBVPENL6Fn55CODWl3njmA=
Received: from shaos.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3ZS8VItpqBITBBQ--.46459S2;
	Thu, 22 Oct 2026 22:47:49 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net/sched: cls_fw failed add changes live filter state
Date: Thu, 22 Oct 2026 14:47:49 +0000
Message-Id: <20261022144749.64372-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PigvCgD3ZS8VItpqBITBBQ--.46459S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWDtFWkuryUtF1kJFW5ZFb_yoW5Xw4fpF
	Zaya4akF4DKF45tas2kFW8X3Z5uws7Cw45Jw1UWry8Za9xGw1qyw4Ikw13ZFWDArW8Wayr
	Zrs0qas7Ww4DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo89NUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzxXe7GraIhXKkwAA32

Hello,

A rejected new-style filter add can leave a new fw_head and its request-supplied mask published in an existing legacy cls_fw chain. On Linux v7.3, an optionless legacy FW filter first creates the tcf_proto. A later add supplies a non-default mask and a nonexistent ingress device. The request returns -ENODEV, but the mask remains installed: a subsequent otherwise-valid default-mask add returns -EINVAL, while an add using the retained mask succeeds.

The same failed request also changes the existing datapath behavior. In the reproducer, packets previously classified into the configured prio class instead enter the default class after the rejected request. A clean control keeps classifying them into the configured class.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/031126b2aeea4add6fe9fb8c7d9f36f7/raw/038fc0766949ae6025e04308b63e3ad065a02e53/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/031126b2aeea4add6fe9fb8c7d9f36f7/raw/96fd3ada617c0f89dc344f7bb650b0818c480e65/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/031126b2aeea4add6fe9fb8c7d9f36f7/raw/c49340adda66fae59de716c352f915c8738e947b/poc.c
initramfs init:
https://gist.githubusercontent.com/shaos26/031126b2aeea4add6fe9fb8c7d9f36f7/raw/5dcb67be6b9905a0b466bc98dd73369ade7dc6e4/init
reproduction notes:
https://gist.githubusercontent.com/shaos26/031126b2aeea4add6fe9fb8c7d9f36f7/raw/fd147fa4b5dd1c4fa1b0831993137b1ff57f4529/reproduction.md

Build the tested kernel with the attached configuration. Build poc.c as a static binary at /poc, place it and the attached init in an initramfs as /poc and /init, then boot a disposable x86-64 QEMU guest with a serial console. The default mode reproduces the retained state; challenge_mode=datapath and challenge_mode=datapath-control exercise the packet-classification effect.

Impact and prerequisites:
A failed filter-add request can silently alter live classifier state and packet handling in that network namespace. The operation requires CAP_NET_ADMIN in the target network namespace. No privilege escalation or cross-namespace effect is demonstrated.

Validation: Two fresh positive boots reproduced the retained mask, close controls passed, the datapath positive/control showed the class change only after the failed request, and a scratch rollback kernel passed the fixed control.

Thanks,

shaos

