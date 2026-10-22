Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680500;
	b=yiX9mTQ9BXLRDiTH/5BVaz0XRLcLc0tMofNWX1AQSzyJUgGgLRK8Mprdjy2OkwprpNXx
	 meGL5uDdL3lg3n1GsmhfcdEH7aGhhZd3iY2bV76YZSstZBuuQZCiy3vNdjBe179+9eGn6
	 NT7iyJNe4F5LgZgROmjwwHUFWkhqiIgwqSSjJfqMrRDMgAVT8e/xwj1Bj3ZsiE9Priv5o
	 +HTmrWXCM4B4ypKJKD+5ZmEd7W27y3/RetC3DqaUE5P/ongBJGqCp27ZcUfidJuGc5Wpz
	 ylZI420r1/uAzBezZJX6iGyKm0r5Ke2RPFTIvkfeS6+RHi3bJSj2u2qXFBJ7STFGtpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680500;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=tCJKpN8YSvw4o3URDdE3kfuYJtYTimUY48SU45Gm5KY=;
	b=AHIpfb4AIODMSU5iPXp+MY84VeC3TO0G6r8lw6u3yreno+ToSFMdSRzJM/sqOgJ0ln2r
	 cClUR9wfo+XVeNxXv10vfhXA/RnpiOAvnhlg5alCW73MSnsmUqr8aiPjpsDD37RweQb+N
	 q8BvHtItXLBL43rgidjxg2FnesT+cAdMcnmKXGdXtpP4dwR1Z9SIM+VeWrA7QRLEzpl5g
	 6ORWIN2XqyUck9tHprbpZWi1qWoHRmJFcF9sxGBh+6Ex7zAS5Ds4PSjCYETf9RjysIvvi
	 r6c8wHbUQ910McRiC0NYkCzWY0TYQ46VVdTvdJ8Uf1b/9pkosm6G5pV0anVvThDCLjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VgHjx8z2;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0188606A319;
	Thu, 22 Oct 2026 14:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0188606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VgHjx8z2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tC
	JKpN8YSvw4o3URDdE3kfuYJtYTimUY48SU45Gm5KY=; b=VgHjx8z2I1YWDitNIk
	aOWGZtmVxMSmLCFSozdh0NvrAPrybhFgybnKIlNJXd3WfvxjXAvS6De5rwobg4yh
	csRU+oKyFFk7S51AGUDPOY+/pPwqLycZeAQzclVAaB8NMEctvAuh142crGbufKtW
	bOjkVZHWZKjV+n2EmozgIf4r4=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n4cLItpqYi0vBw--.33625S2;
	Thu, 22 Oct 2026 22:47:40 +0800 (CST)
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
Subject: [BUG] net/sched: act_ife can emit uninitialized bytes for zero metadata
Date: Thu, 22 Oct 2026 14:47:39 +0000
Message-Id: <20261022144739.61342-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3n4cLItpqYi0vBw--.33625S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4kAFyUZF45JF4fAw4xJFb_yoW8tFyfpr
	Z0vFyfGa1UKFn8twn2yFW8W3WfWws3AayUGrn8Jr18Z3y3WryjvryIkryYvF9rWr93tayF
	v3yFga1Iqw4DXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5F4_UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0Azc6mraIgzcEQAA35

Hello,

An attacker with only namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW installs a matchall IFE encode action carrying a zero-valued skb mark in a fresh user/network namespace. The presence callback reserves an 8-byte TLV, but the encoder emits no value bytes. The resulting frame contains six bytes from a freed kmalloc object previously populated by a different UID.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/ef81659b25f21284f8e947074fc2a249/raw/fed962675ff9018ab35483e75af1f64b349d0465/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/ef81659b25f21284f8e947074fc2a249/raw/cbbe560851613f20ee1d9893671a4bd8ab44c44b/kernel-config.txt
reproducer sources:
https://gist.githubusercontent.com/shaos26/5e309509387950d97539adf449e7f725/raw/d9a204d10cb437095253c4ff74675c99245a6a2c/poc.c
https://gist.githubusercontent.com/shaos26/5e309509387950d97539adf449e7f725/raw/a81c7411e6b232f24cd42ea4b88a2e84b66af4ba/ife_trace.c

Build the tested kernel with the attached configuration and boot a disposable QEMU guest with user/network namespaces, veth, packet sockets, matchall, and IFE skb-mark metadata support. The linked userspace sources reproduce the zero-mark and allocator-trace cases with separate victim and attacker identities.

Impact and prerequisites:
A UID 65534 attacker in a fresh user/network namespace repeatedly received six bytes from a freed kmalloc object populated by a UID 65533 helper, although the attacker could not read the helper's mode-0600 marker file. This is a cross-user information disclosure. User namespaces, network namespaces, CAP_NET_ADMIN, CAP_NET_RAW, veth, and IFE support are required; no privilege escalation or credential extraction is demonstrated.

Validation: Two fresh cross-UID boots reproduced the marker bytes; init_on_alloc=1 zeroed the TLV bytes, and the nonzero-mark control emitted a valid TLV.

Thanks,

shaos

