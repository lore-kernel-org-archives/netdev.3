Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680551;
	b=qq9djyG/Zt6kGET7i+LAunXpUvOZfoISFdy2KYaQbzUVlQPt9etnNlFuszWpnqT5VhN5
	 IApuI0F0xjc7vCnPKaFhO6avXZDZO/qTHNB6M2fw9bKygpcAhKTWj7wyOIJooRiSf1Gtu
	 +Z6jm6G64PMJBhXzObNvfoWQJxCZ3gZhNBkbeMSs+m4+XdvhE/igti4qU+IXm897tZM2I
	 r9xx6mKOPhdaSx75B6gRrGnurxc58J57198JEzmpaDaQCpBR5oMB46yELLq/3uMuQDlu7
	 84F4jL8nKVyssHD1bCKs0hYQ5dlnY9weQlOAeIQYHnqir9Ip5XMsopT+nuJ/dOAbP4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680551;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=VPRO3PXa2/zji34oyXe+9F8Yh09iar2A/K8GvPXivFM=;
	b=xTLLhk5DaZDcw85RHXpHP3tlzy8nPkoTUYI2yEPDplKz8IyTGPVA9TZxkYcD9FQCQQ+2
	 hNl1geYhPWzxYHs3QB+lpibFSo3x8PPvfgVs76CRrPRsxvg4bReETA+ld5Gf3Dft/2PFQ
	 sQJrUq3QX7f5BLCv7WB5QEd9ltEa3BMNOjk9Z0GfNGYXTebNsHg6YgOSR8SlIHwPxBBUG
	 8Gvi6pDMpn1tH4GIGfVI1iL2YiZ1xvgqA3XDCfnFjanMtqxZnunfmXtyhyUf6jd9Tu+cQ
	 Agru7LpyV3yEwAe9fqBBPuAi1WfFl5ag3hT25ulybb9FYO4umqoqgCJWKEb6tIwjAVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iVqaUuIK;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEB606A328;
	Thu, 22 Oct 2026 14:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FEB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iVqaUuIK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VP
	RO3PXa2/zji34oyXe+9F8Yh09iar2A/K8GvPXivFM=; b=iVqaUuIKuvHM1uKkKw
	KWHbolbzNZNxxkqSXDzgtm1dGrEP/6b9Idq0lq3lE0oleqnDDFg7Uv8y7QcBICqR
	Borezo+qqZLGvnc4s7a01jPLuE9JIfHiPyUEKPLUXqK6oJgiaqWlCR4bVTfl1T+r
	/0HbosZUNUHIBOepcHEftbi2k=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P+ExItpqnVr8Bw--.21753S2;
	Thu, 22 Oct 2026 22:48:18 +0800 (CST)
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
Subject: [BUG] net/sched: malformed TCA_STAB can leave failed qdisc change committed
Date: Thu, 22 Oct 2026 14:48:17 +0000
Message-Id: <20261022144817.66648-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3P+ExItpqnVr8Bw--.21753S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13JrWDWw18GFyrKFWrGrg_yoW8Ar18pr
	Wvya43tF1UKF45JFs7KF48u3W5Wrs7Ca1UKas5Gw48ZF98Cw1jkryrK347ZryUGr97K395
	Za90gayxKan5WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07josjbUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8RLl82raIjJK7QAA3y

Hello,

Change an existing netem qdisc from 20 ms to 100 ms and include a malformed empty TCA_STAB in the same RTM_NEWQDISC request. qdisc_change() calls the qdisc callback before validating TCA_STAB, returns -EINVAL, but leaves the 100 ms option live.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/faf3f124983448070e5242af5b3dd68d/raw/498cec333b632cbea7ffa02539d860e44d84c864/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/faf3f124983448070e5242af5b3dd68d/raw/5e0a640b23f7635af2334f3e1ff7cf185a620f1e/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/faf3f124983448070e5242af5b3dd68d/raw/ee84d2095025cc488421c5c2d9470604b456e73a/poc.c

Build the tested kernel with the attached configuration, boot it in disposable QEMU, compile poc.c statically and run in a network namespace with CAP_NET_ADMIN. The program creates netem, submits the mixed request and reads state back with RTM_GETQDISC.

Impact and prerequisites:
A caller with CAP_NET_ADMIN in the target namespace can receive an error while the device continues with the changed qdisc configuration. This is a control-plane atomicity/correctness defect; it does not cross a privilege boundary.

Validation: Four fresh exact-revision boots reproduced the state change. Invalid-STAB-only and patched-order controls left the old 20 ms setting unchanged.

Thanks,

shaos

