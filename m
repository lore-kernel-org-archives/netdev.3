Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680540;
	b=3POpmnwi6e4BQHC8NKz0xqoHYlTVGJuDB5LooipWGmUL6ukOBE8cA3mlb98beEGEO/5C
	 9TlnAXswdC+ZhsdMR7hKuDpfVcX5bg3GYJrQN9z3av+7kCRQNKGOa0i1WO5LgMbDJS5D2
	 sY0w5Jp6muTPeeha4+tLDxCJL1C/J5YQNP50XsE1V/I/kZth9j0AjYqzpIV1bNQl/ihp4
	 feXGfqXAhhZqmAwGXjkSd3HqFsi40rF35xULYM2wUpjF2fmGCgTTmaYzCnw2Sgs+PxSL5
	 KeDw0mxHxghuPlmiV8bZ1x7D+uMZhl1tVLVK88YH/n6UgdXUcOrYGnN/ujVE5lV38Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680540;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=GKi/ofm15B962rnTZ6pz7sBCLjR4QVY0SWHqOf6JCUk=;
	b=pFbprEADbFhYkvEUw2x+yxge+JnEJM0MWPqNdvuwzmCx1jANG6C61p4V+tY2dT1mTJ/V
	 r0oKiiR5A/i5s6fT3pSU/LwgOahaBCLmafpYw9R3K3A9WZeQhRpvB6SHxvmELkOZqL8Rg
	 7P8Vb2dE8jz2bS0Pog9u+hxD/B+tSm+ZJbfHC6abH1M5ITsk60r7hyBKTAdWQPlBJOlv4
	 MYNiJ5QlM6IeLLIG9WqPBMilkVCJoYzhWb2gSOyKu3mgLIzVEoY0wDnyhVTZ59ajT/RiH
	 jMLEvJUEOg1XjLRjXX5A2f0FQa8UdFziwwElFtv1Do3/U+zDyD2dskmHC34CaiK/7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="KD+/7fdb";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A760A380C;
	Thu, 22 Oct 2026 14:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8A760A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KD+/7fdb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GK
	i/ofm15B962rnTZ6pz7sBCLjR4QVY0SWHqOf6JCUk=; b=KD+/7fdbp5aIBfYShw
	3yxXZMl0L0gIkBI3m+Qw/OnZSmQCt5DDi10KHEJlrie23YQLad0URPnJCWIEKRRU
	iK5qx5FVqpdwagL3TcuhRjXlPecUE22Vc65bQyzu8o6pEx47YCXDS2W9RpMQ5MaO
	Z3xaPFvs27feIoNKjG+Z3LsK4=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn77w7ItpqP6HzBw--.6871S2;
	Thu, 22 Oct 2026 22:48:28 +0800 (CST)
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
Subject: [BUG] net/sched: failed RTM_DELTCLASS clears binding and makes retry succeed
Date: Thu, 22 Oct 2026 14:48:27 +0000
Message-Id: <20261022144827.67604-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wDn77w7ItpqP6HzBw--.6871S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrykCw1rCw48KFykXF17GFg_yoW8Cr1fpr
	Z29as0ka4UtF15tan2kFW8X3WagFZakF47Ca4UX34DZa13uw1jkrWfK34Y9FW7ZrykCFWF
	vw4Ygas2gF4rKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo7KsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzxzo9mraIjzNPQAA3T

Hello,

A class referenced by an HTB filter rejects RTM_DELTCLASS with -EBUSY, but __tc_ctl_tclass() unconditionally runs the reverse binding walk. The filter binding is cleared despite the failure, so an identical delete retry succeeds while the filter remains configured.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/6621bf128af29e1959e1040ab721e8e4/raw/7b5cbc2be7590c9773c8c1245c3e03649b10a21d/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/6621bf128af29e1959e1040ab721e8e4/raw/28677abefb68039a69abe240b0770567dac89348/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/6621bf128af29e1959e1040ab721e8e4/raw/c69106d421daff43d46c200ae3e1d341cac56769/poc.sh

Build the tested kernel with the attached configuration. Run poc.sh with iproute2 tc and CAP_NET_ADMIN in a disposable network namespace (for example unshare -Urn). It configures HTB, a bound basic filter and two identical class deletion requests.

Impact and prerequisites:
A privileged network-namespace administrator receives inconsistent control-plane results and can remove a class through a request that first reported failure. Independent HFSC and HTB reproductions exercise the same generic sch_api.c path; no privilege escalation or memory-safety issue is shown.

Validation: Repeated fresh boots showed first delete -EBUSY and second delete success. A source-patched control kept both requests at -EBUSY; no-filter and explicit-unbind controls passed.

Thanks,

shaos

