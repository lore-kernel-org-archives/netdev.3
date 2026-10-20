Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456499;
	b=4hZeloytAPfJiCPNGRqWXXDdI1wcJ1xNIngOCae2AtrqNk14DYQrZQrUf48VJyinTw0s
	 xINMEQZTwD8j1lsKhlHdsXldZtpYnQG2C6F8ZgkTgj/BKPARPauThxBiuj0lUZkZvCnF3
	 3x2VtQr37HQ4b6jC3dJGN/ASmaPw+/Jt8qcDlsmp4Mre75n20UQRjtYflgQuEO6/hLSjL
	 a62ECEv2m0nUhLJCKfkUO1GAn4WoDIvWIsCQ0kTGlBcEDw9V4oUn9auIKeSniMAxrEgbF
	 HdfvHVp9SO7NY+djlX0LyWyYoFl0ZqcKFvMGmvQXB8ioVT2V8JTmwNHbNnVDvG6q8xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456499;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=c89tPWE7TD+mBXUxyRxjAoNGWIRJD4P5B4nfsnBwK/Q=;
	b=RRvKCoh+1tVYf1CXjLk5tupeJq1++7DekBbOZfjfF8zkh28i9KjG7FEQYQ6ooXH/YmvX
	 gFao+z7Myey0JRIZoxHZb94XMcuFDPMK8GOJgUgM+LgjbyuRMFV7Zh92sXuB//zCvW1bK
	 2aSS6WvXE5xj+GbEQZAx9xRuagzPbL8uGQ1urJeGdVM6+wFY1GZpdNYZK1PjyNgiaAuqF
	 O4BDltSQvEE0Y8KxpaHhCHb03EUPHSshpLHbl/lv40+BKs0NNz4FpThUxzZu+hQeJwdSE
	 A8zDFlRmKnKY8AZ1EyFoFMiyjrYjIR70Uonecmp8AE98BWeg9sKdlybDhBo1MLDE+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lp6v3VfC;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A68606A31A;
	Tue, 20 Oct 2026 00:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lp6v3VfC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=c8
	9tPWE7TD+mBXUxyRxjAoNGWIRJD4P5B4nfsnBwK/Q=; b=lp6v3VfCRb4B/kDT6P
	TKCarpN2GYHEIxzkAGRWv0ZQ0VCYnWPU1Ik7FNTvGwo/x911KXCxSuDOz+6G9rUZ
	nVedwV0tw7SKS/X32CVAFlwNbvO/mE6acJIFq82T41XUlzKOBkIKqv7M3q1QpcNk
	+d2myfGzU3INwtzLdZ8Ch0r+U=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v2Agt9ZqidJABA--.43909S2;
	Tue, 20 Oct 2026 08:34:40 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: sched: cls_flow perturb period wraps when scaled
Date: Tue, 20 Oct 2026 00:34:40 +0000
Message-Id: <20261020003440.1009437-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3v2Agt9ZqidJABA--.43909S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkWrWxAryDtFWxtr47Arb_yoW8tF17pF
	Z0ywnrtwnYg3W5JwsYyF48Xa1rua9ayr4UGF1kGw1kAw1akrn2yFyIv34jga47Grn2krWr
	JFZ0gw18XaykuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0ksDUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8gBGVGrWtyA-LAAA3Y

Hello,

cls_flow multiplies the user-provided TCA_FLOW_PERTURB seconds by HZ in 32-bit arithmetic without a range check, both when creating and changing a filter.  Large values wrap to a very short perturb timer or to zero, changing the filter's timing behavior.

HEAD commit:    fe2ec83746e501645709761605c2464a44fd2929
git tree:       upstream Linux checkout, local branch master
source version: Linux 7.3.0-rc4-70-gfe2ec83746e50
compiler:       gcc 11.4.0, GNU ld 2.38 (from the kernel build banner)

console output:
https://gist.githubusercontent.com/shaos26/e00f090da98036578d357a8ca70b6e3d/raw/fa14843487b13fb553ca73b2b16ed3db507c1439/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/e00f090da98036578d357a8ca70b6e3d/raw/6e1af5fc2bf4af2bafb39e23f087c47e62ea3ff4/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/e00f090da98036578d357a8ca70b6e3d/raw/2cac1c5dd9e3ba3a9bdd55e803f3cd72088b9bbf/poc.c

Build and run the PoC on the target kernel.  It creates a private user and network namespace; the first command exercises a value that wraps to zero at HZ=100, the second exercises a nonzero wrap, and the third asks SFQ to reject the same oversized period:

    gcc -static -O2 -Wall -Wextra -o cls_flow_poc poc.c
    ./cls_flow_poc --hz 100 --userns 42949673 1
    ./cls_flow_poc --hz 100 --userns 42949674 2
    ./cls_flow_poc --hz 100 --userns --sfq 42949673 3

With HZ=100, setting 42949673 seconds dumped as 0 and 42949674 dumped as 1; 1073741824 disabled the timer.  The boundary value 42949672 remained unchanged.  Three fresh boots reproduced the matrix, and the SFQ implementation rejected the same overflowing range.

Impact and prerequisites:
This is a network-classifier timing and resource-control defect.  It requires CAP_NET_ADMIN in the target netns or an unprivileged user namespace.  The evidence shows unexpectedly frequent or disabled perturbation, not memory corruption or privilege escalation.

Validation: Three fresh boots reproduced the wraparound matrix, including the uid 1000 user-namespace run.  SFQ rejected the same overflowing range.

Thanks,

shaos

