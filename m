Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680488;
	b=zLXG3K8Kt4D0MlTVkzESLlz6GTfFgrFm0S/BUTwcYxbvtX+ywnSNX+reObmvNhM4+dkP
	 NAD13yRSNOjvTY2hdN8q2X4vZHYzmZvzqueaibJNr9FOrognVNbRMDRs0uG0Xrn0kbEYM
	 lZBTPaySccp8wnNHnHURwEawbOYXIOu2ObOlW5410H9zk0pMGhap25QCgZtNG9IVtzbyE
	 OkvLZ76Qxwe/gCDeRASclnLlqrFt6eE7h+7G4Vp+zJsaSkEQzEFF3ZPBmHbk2CxGvDjfN
	 H8FfVWQXmbLqKZEau6msmt5ZJ9ODDDG7Xmz6bv+2dccsr0w37ZqqS3+JSeSnlGbikJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680488;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=77ETMQ3vO2jZDZE1V2nqF3MQlazT7Wo40RJuuWC1z20=;
	b=NEmSQomLh/lj+1rUP2lv/2jXkJHYKBHl9u+XkjPajj6engvdpklACacotGnU48ibTaEY
	 pfMOIikx9URgjX5AGgB6o+qmtX1IX8UfRtv+d5keVqKP6mIWTbxsxuWRKsPWCNcnDPxbz
	 6EEirMe3nOyRqkQYfyokDgTpss0Ba9IMAQgBi20yJb18ILfI9eePquLViC04BhDpSwMBX
	 HSXT5ETHeyUuK/UrtbLo91QV9+eumwRYs5ARClKPrZXKUfuiPqlS6qo/w5VDtKJbcmK9F
	 agpaeaf48UqmHe6VByFzxyEFywsyCf3V7I7wHtXMcCFJTwoHwdYBvmQdB2j6sDIz8ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cn9F2IS1;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BD606A319;
	Thu, 22 Oct 2026 14:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 163BD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cn9F2IS1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=77ETMQ3vO2jZDZE1V2nqF3MQlazT7Wo40RJuuWC1z20=;
	b=Cn9F2IS12WzcWS+U35aLYrRVOGVfSjkN6L47X7VRPslk1LsOxo3CNwxpaKQUuE
	wI2M0bL4D2gJeLJE412Qpo3tBBCmCjQiZbxy5+lH0mBO80bTeIx96+HcSe5qf/8M
	aNQVBGd6bNe4epBn2/ivlMtAtL+U8352CWRYSy1WAT6gw=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33_MBItpqGScvBw--.57072S2;
	Thu, 22 Oct 2026 22:47:30 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net/sched: duplicate RTM_DELACTION entries underflow action refcount
Date: Thu, 22 Oct 2026 14:47:29 +0000
Message-Id: <20261022144729.61125-1-shawnq1@163.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33_MBItpqGScvBw--.57072S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDtFWfGrW5KF13WrW7urg_yoW8CryUpF
	WFvF13t3Z3CFn8Jw1kKF48X3ZY9rs7ta15Gas8Xr4rC39Ik3ZFkryIyry0yay7AFykWryv
	v34UKF4xWw45uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5sqXUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8gLZ52raIgI0xgAA3s

Hello,

Create one standalone gact action, then send one RTM_DELACTION request containing three entries with the same action kind and index. The duplicate references cause the delete path to drop the object’s reference more times than the batch owns.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/c37510312cb6cdfcc7a8dfa8567c0bfd/raw/b8fd79ae905833e51d6db058b2a6f715168b39cf/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/c37510312cb6cdfcc7a8dfa8567c0bfd/raw/1acf6d132666c0f60829ca94c0995f5c5f31f5ff/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/c37510312cb6cdfcc7a8dfa8567c0bfd/raw/a46ac914f3b3cd2abdf52898f90a993038d7f442/poc.c

Build the tested kernel with the attached configuration and run the static poc.c in a disposable guest with CAP_NET_ADMIN in the tested network namespace. The program creates the action and sends a duplicate-index RTM_DELACTION batch.

Impact and prerequisites:
The kernel reports a refcount underflow from __tcf_action_put() while processing a user-controlled rtnetlink request. panic_on_warn can turn the warning into a panic. The evidence does not establish controlled use-after-free, memory corruption or privilege escalation; CAP_NET_ADMIN in the initial user namespace is required; an ordinary user namespace does not pass this action API capability check.

Validation: Two fresh exact-revision boots reproduced the underflow warning; the two-duplicate close control returned without the warning.

Thanks,

shaos

