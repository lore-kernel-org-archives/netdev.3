Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680507;
	b=JEEfINdMqUDhzP3hnaURuD2YWe/13Cg5JToKtoLlYK/VdRB6wkyWLSs6jp9YKxGcgtzL
	 Lrspbr32mmYkVQE5dDs531uW9Bsg1wzIwA8CjlKzmz8bE3wioiz7T9lqAE2LcpKOElQ9k
	 9nYlGUP2LvVoONPJMwLMo31m1OB88cxAiaTWAQHO1+XgNq146OigmBoIiGVgq+fvLN0hB
	 qoP7XSxliP62QOdoPsxN/k05DQ2YKW8hluszcJ/vs4tW5HR8e3T/sSXzwIf8ypTcwTbmM
	 cwjMRCFTqt+jBpUo2UMOBTX7MIY5qnssIWFMn9hMJfFoH06Vm57PyA9+NY3CKwM/fUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680507;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=XIsvbOAnIRW8H1+jITaPE6AgA1HppDDLCXUtfjSNNOo=;
	b=cWod/5iIvFcvL7Ztgxbvxi/l0tvw1HpzuNHy1GFpDIeRI77atADp66H8yjRAKDpgsaNB
	 J/tDk/pq+R0iZHX3OyqAulT2H73AFFt4UjaYB+bC581og5+7hHoRNdenkB21MlKD3a2K3
	 sIzOEgsVtyKUuDYlZRG77AjNdLTZUkZZFfiVQJ6t7FDlNjXDZ3ktXtX7KAE1E/XTX94nB
	 NLzF71TAb0nQ9eQSVmyRiDr941Rah1MJtiSjN9sKxCik0EnSavBUnH4ggbx2czxSYiFES
	 Ti5tkjxhdAU/0r14fVGUmPFK0diuPcw0FGNom6gC/BJWSNSODCXMTOfx4wQJXbsUvBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bQVhcy4W;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74D606A32F;
	Thu, 22 Oct 2026 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E74D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bQVhcy4W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XI
	svbOAnIRW8H1+jITaPE6AgA1HppDDLCXUtfjSNNOo=; b=bQVhcy4WNHo6CIKTcF
	svcdcED6/+/QyTtGg6CE4WtgNMCTSNPKwLoNA3lGcYeeioNMLlYbCArgWnVEcE/5
	ADy3OInDnFCya+qbxCcsuR8DuixTs5pKPEK/gsJl+NYk0YgkPRl88u32MxN6XEr8
	eHyvCaSiG0fEZ07ejDNM7Q6RY=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33wQbItpqVzhsCA--.3667S2;
	Thu, 22 Oct 2026 22:47:56 +0800 (CST)
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
Subject: [BUG] net/sched: malformed UFO GSO geometry can soft-lock DRR dequeue
Date: Thu, 22 Oct 2026 14:47:55 +0000
Message-Id: <20261022144755.65025-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD33wQbItpqVzhsCA--.3667S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1fGr4kZw4xCF1Utr4fKrg_yoW8KrW5pF
	yqyayayF17Kan8WF1vgFWkXa18u3s3Cr4jga1UXr1UZw43Cw10yr1Iy34Y9F97JrykKrZY
	va4UK3Z3Xw18XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXeOXUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hzg7mraIhw2TwAA3X

Hello,

A PACKET_VNET_HDR AF_PACKET send supplies UFO GSO with gso_size=1 and hdr_len=65532 for a 524275-byte frame. qdisc_pkt_len_segs_init() computes an accounted length of 4,294,574,091 bytes. With DRR quantum 256, the dequeue path needs about 16.8 million deficit refills before it can dequeue the skb, keeping the CPU in the qdisc path long enough to trigger the soft-lockup watchdog.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a5202/raw/f4ca89881f7b8163ddea72fbc54b204385142bb8/console-output.txt
user-namespace positive output:
https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a5202/raw/14de8e3a06e7e73c540ebf408e73d301bae3922d/userns-positive.log
kernel config:
https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a5202/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
reproducer sources:
https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021accf/raw/7153646b9233fa53aca81c9af879d48e8f95dd80/poc.c
https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021accf/raw/e8acddd986023c10a43b5106b4734a456a063deb/drop_priv.c

Build the tested kernel with the attached configuration and boot a disposable QEMU guest. Compile the linked userspace reproducer and privilege-drop helper, then run the AF_PACKET/VNET_HDR test from a fresh user/network namespace.

Impact and prerequisites:
A process with only namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW can keep a CPU in the DRR dequeue path long enough to trigger a host soft-lockup. With softlockup_panic=1, as used in the test configuration, the watchdog panics the kernel. This is a local denial-of-service issue; no memory corruption or privilege escalation is demonstrated.

Validation: Two fresh positives reproduced the soft lockup, including one run from an unprivileged UID mapped to namespace UID 0. The same-frame non-GSO control completed in milliseconds.

Thanks,

shaos

