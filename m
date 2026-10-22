Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680502;
	b=juKQdclOvSjJ2/nDihn2BGQ8+oE4IofISdSLwvrcNycTck4PAYs0JZVeYptAH52IS4YC
	 Sw/VLd+bmdlgRjM3CF+qBfv4wXN2riJaNMbMhtR29M1GuGqrHKBZ9XDHBM2ZBfbDHlTD/
	 7y5+Rh7qR1aPyyTJRR9Tb1V+2INvTL+/dcF6OEsCOffW4obm+qWziXxo9reEVKNrMWTIm
	 NbdwIkUO0iMHgwQ8LN1vt4M8bd6Z0zETik0itqeJmKAyxuwarl9R72G7T4CaklZTKTR6I
	 J3lS2U94VSl+b6tqVd5O9mmgaSnfAwAdJ7XQZe8+ji9o7kA9CYGl4+AouYHDnWY0wDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680502;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=W5/eA65Cr2py92E4BQkH/p5RHwcqj734bB7a1FhByO8=;
	b=yjlZR1vN6/SbJ/8l49dWOuQwI17kR25s+Nepx7XSq3WC+Yij/Xc9Rxs+f4PfzLrZKNan
	 a8OGY/KaQ86FJEUxf0Dj5TUxtyoZza0mDduLOjHWXRRv+zxzYqUHwsQX9KUecIMz5fGD2
	 0EbeDAPLZ756uCrLkG1EMp9Ju+P6+X7RFQvLsSu+4mzpDIQ3+UDitmEIxnIRPU2+50cTe
	 WGw1quXGNNEw09mlmeFykt4CSC7JQRtPiCXp+8PMsa/CwiUSYYUqc2AwhSNK1o5BEB0Bh
	 fsX5Mb5vsQX2hM2OLq6eQBoO2YzZF6O0dE/bk32hx1bCKw1kKqMbJcfSORYUiRU3GXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=czGBgBwG;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC03606A31A;
	Thu, 22 Oct 2026 14:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=czGBgBwG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W5
	/eA65Cr2py92E4BQkH/p5RHwcqj734bB7a1FhByO8=; b=czGBgBwG3OylLtl3hm
	kQ4edxHO9VbOmq5fpzMW9530P5qmGMV0fBRyEjnP1GBD+Z/KxEgzG2mTnjjBc3GL
	TJjfbdxQcS07+fj/jkqGUnWrydlxKvqB/MDQnDxzM7zoCdhtedubxJ4T7NYBJpZy
	qXelqEdgOrPKUixhTSoo/0MUQ=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD313sIItpqZSsvBw--.16907S2;
	Thu, 22 Oct 2026 22:47:36 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [BUG] net/sched: act_ife reads stale tailroom from short egress skbs
Date: Thu, 22 Oct 2026 14:47:36 +0000
Message-Id: <20261022144736.61227-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD313sIItpqZSsvBw--.16907S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF48JFW7Gry3Gr1UuryxuFg_yoW8ZF1UpF
	9YvFW5WwsxGF1DJF1ktFW8Xw1S9395Jay5G34DXw18Zr1Y9w1j9FyxtrW7ZFyxZryxK390
	y3yDWayxKan8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j55rxUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwnb6WraIgnJxwAA3h

Hello,

A UID 60000 victim in one network namespace sends an 11-byte random marker through an IFE encode action and releases its skb. A UID 65534 attacker in a separate user/network namespace then sends a one-byte TUN packet through mirred to loopback egress. The egress IFE action copies ETH_HLEN bytes from skb->data without checking skb->len, and the emitted frame contains the victim's marker in the stale tailroom.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/3961afdf0773e9f65bdfe152e05356da/raw/65466e4e5bd3843400c036ba31c64108ae4d57e4/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/3961afdf0773e9f65bdfe152e05356da/raw/7d8abdee14fcf83f61e27fce20dee98b4bccea8c/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/82ce293b417cd5a2d19c0978d562bc1c/raw/b65492b33b91aad0479423ccf92d2910c1c9d656/poc.c

Build the tested kernel with the attached configuration, compile the reproducer statically, and boot a disposable QEMU guest with TUN, veth, mirred, IFE and packet-socket support. The test uses separate victim and attacker network namespaces.

Impact and prerequisites:
The attacker recovered 11 bytes from a random marker generated by a different UID in another network namespace. This is a cross-principal kernel-memory disclosure through an emitted frame, reachable with namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW when user/network namespaces and TUN are available. No arbitrary-address read or privilege escalation is demonstrated.

Validation: Two fresh QEMU boots recovered different victim markers byte-for-byte. The no-prime control did not recover the victim marker.

Thanks,

shaos

