Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680503;
	b=Q+4XswPdbsoWOChTpNUpEge9g3x6ki3J1QB0B/nVc0VJK3091uUgv3Khl4Jam7CpVz0a
	 yQHOsGVJ1WLmepvWDk7gnUcvfeDMDZjwzxMjYlYVmrLAqduF5x0uNMV7yp/zH3L13YnqN
	 royY7b2SiWXtK0KFFHFDv0nzA3HDwvEXhHV2BEZpjPz77z5tv67647YBzHemjz9jlC/+K
	 8nBFR1fo7p7Mpji1OjtQ4W5vwZ81w/SnZH2n/MpvcQbipuU9YM7cQv0f5a2LCZGNgeQJK
	 PFzRdA++GeVRJJ8/zHnoL8+MKk7VC/2ktN+iNj2eH2cvA3PWpKFn7RnWRivZIJvXnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680503;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=XruWLBcFftxHPWtjB/T+7YAss7gRXk1fNFoX14yTFGA=;
	b=dDogTdb6UFdh65E+H2wcIe4M9MIZxoC8V7NttYPLLK7JNU8HU4dn2YcDDGMwLn6gWByJ
	 3i0YT4E5kc4rX3CAAA4kmiGnuIL4+y7HdrwlRaEov5MCl/5AcZwH7tcR9jjmnU+yYVpOr
	 8gd+unXK7k3NVO2cKLM7vlr+j/AxNcPNJxA7HeYDyHsSJUYnf0GvCJnxEj00jkBc+o2wk
	 3qH1eKjk0U/7RklVLtMC7YY3D9Qk7NqmfhStITIPMJ6quU+/jFodzHobclMDtKOF+YzLE
	 MsZVHOT+aXbRmySwh6EJbooczF1O4+5nAtb7xWgvujFQQvbFc9Qv3ru4S6e4bsWiS0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SwWYOYyN;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7F606A329;
	Thu, 22 Oct 2026 14:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA7F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SwWYOYyN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xr
	uWLBcFftxHPWtjB/T+7YAss7gRXk1fNFoX14yTFGA=; b=SwWYOYyNuaZvFHHBhH
	IWuCOEmAVThR4GtXuwM6RGoTIKv7xI9IbNUJFR9p5RBmP0FrgeoxUdYjsKiGSHwd
	AxRyUPyFB+uDnCGrPsoM1onDtnJ97zukH3WRSvQbTJrYVMMSXvwqhywDir6It/fU
	ZqwPI4eJTvHhS5xqNQ764XVic=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3X2ARItpqA3jqBg--.13325S2;
	Thu, 22 Oct 2026 22:47:46 +0800 (CST)
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
Subject: [BUG] net/sched: cls_bpf queue_mapping can index past dev->_tx
Date: Thu, 22 Oct 2026 14:47:45 +0000
Message-Id: <20261022144745.64154-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3X2ARItpqA3jqBg--.13325S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1DZw4DGF4fCryxXrWUJwb_yoW8Cr47p3
	yvvayrA3WUKa12qrWvyFWxX3WrX3Z5Kr15Jw4DW3yDu39xuw4jyrWSyay5tFykXrykGFWS
	y3yYva4xGa1rXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrkucUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0BLd62raIhLcdQAA3d

Hello,

A BPF_PROG_TYPE_SCHED_CLS filter attached to a transmit prio qdisc writes queue_mapping=4 on a four-queue device. qdisc_restart() later trusts the rewritten value and indexes dev->_tx[4].

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/78f9a35aefa28e146789cafa359f4503/raw/7e7d944d129639cd162492ae1881a47e29fbd68b/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/78f9a35aefa28e146789cafa359f4503/raw/92563268a50ce92ae4eef3789c52dec7666d0fc8/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/78f9a35aefa28e146789cafa359f4503/raw/828b0ecf003bf52edc7b49af429dbeca013b044d/poc.c

Build the tested kernel with the attached configuration, including CONFIG_DEBUG_NET and KASAN for the recorded oracles. Compile poc.c statically and run it in a disposable VM with the capabilities noted above. The positive mode uses an out-of-range mapping; the control uses mapping 1.

Impact and prerequisites:
The four-queue test reaches an out-of-bounds netdev_queue access. CONFIG_DEBUG_NET reports the invalid index and KASAN reports an 8-byte read past the 1280-byte queue allocation. The PoC needs CAP_BPF or CAP_SYS_ADMIN in the initial user namespace, plus CAP_NET_ADMIN and CAP_NET_RAW. This is a privileged memory-safety bug; no privilege escalation is demonstrated.

Validation: Two independent fresh-boot positives and a packaged recheck reproduced the warning; an in-range mapping control was clean. KASAN corroboration is included.

Thanks,

shaos

