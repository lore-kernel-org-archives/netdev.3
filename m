Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680542;
	b=Sp1Z9ubj7RmVPypQ/tijcS5Yi5ffuMOQgrRUMUzWLFccSU/l6Oive7DYo8+fWnktWixY
	 E++ILxKL8TJLW+Rjrl5OlJ4j7FZsE15hJsu3qjq/jkYasrb8N5OYtsEZCdaNgix4fToMz
	 cA5nm7XiZs4siHm+o4I7E1fbErOH+s3ioZLxHnBphG4jtckKPO/hbeSa2jKqnuTRkW8UF
	 2KPWfPIB/0+Ey3vy1nfr+0NSStvibID5Q86gEtM+ZfTDygZVE7jJ75sorD8VbHRvCccbR
	 1uvst/3qVDtHD/GORnj3qcZXa6+2dVPJZRjoPPxDYophjo8ltVYKy53PoAmyEsv8uJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680542;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/hNMqU7iKbHfVOzfuf3HD9JJmvgTg2EAMlZnqilLXzw=;
	b=JEAx+wZGWTyyXWJsBY6xle/kw3VjKYQ0Wzs64X2wa8bQU4IpAqTzUZkXdEzFRyyx6A2E
	 JzkLbFdnl3x7wEZY2coBXtqnKB9ZQyeKFtOaNI7Ve1u3pS1vZVAmgxmT72fEYwXbsXwmU
	 jRfYxdgvpQHXcr3HkN4lLyfealYimOlG2ylqyYP/MZdVjofvI5fATl9HdZsfuHRAqf5WA
	 MNkZ3NK2CdqtciW9GTHM/atIEegEJ+q5rJHbR+T5KapIaijncKjjG+FEvxh3FFWskBkam
	 Ai95oKKZAgIb/jpIwuX3fWcMnFxdAjPfK3jCj8WIogryxcojsUXMyxzvjDKTY/7BkaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g0XT+m1z;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBD60A6F61;
	Thu, 22 Oct 2026 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54CBD60A6F61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g0XT+m1z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/h
	NMqU7iKbHfVOzfuf3HD9JJmvgTg2EAMlZnqilLXzw=; b=g0XT+m1zk3nMSizWNY
	6XlprRHlTaG7pvVTjQqfGYs4qV9d0A13xvVLEte+iwfZo3W+L24kvBcbMtcvwEuQ
	dMjvOhULoKlElTOUWLP4aCkNtbo8mZUQAftJct4E2L5QDZX2N7jdanb2edrQoilN
	xzZfvAugX/k4kFqlGptR9bkZI=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3P400ItpqrI_qBg--.56978S2;
	Thu, 22 Oct 2026 22:48:21 +0800 (CST)
From: shaos <shawnq1@163.com>
To: vinicius.gomes@intel.com
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net/sched: rejected TAPRIO preemption change leaves max-sdu active
Date: Thu, 22 Oct 2026 14:48:20 +0000
Message-Id: <20261022144820.66976-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3P400ItpqrI_qBg--.56978S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryktw15WFyDAr4kKr17Jrb_yoW8AFy3pr
	ZYv3s3GF1Yg3WUG3ZFkrW8Zw1rWr92yFW3GFn5Jrs7J398CF12yr1xKrW7ZFW7Xrn5GF9a
	yan0gan7Xw4FgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo2NtUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hXm9GraIjU4DQAA3n

Hello,

On software TAPRIO, request TC0 max-sdu=100 with fp=PREEMPTIBLE. Parsing stores the per-TC values before rejecting unsupported preemption with -EOPNOTSUPP. A later valid schedule that omits max-sdu inherits the rejected value.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/4f6b811c8d96b86c798f6eb3a3e9893c/raw/e16aedab2611e181429db1daa77ce7bdd82b6219/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/4f6b811c8d96b86c798f6eb3a3e9893c/raw/2f23bbfbfd70e81aa2eab3771a97f07c777d4c01/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/4f6b811c8d96b86c798f6eb3a3e9893c/raw/0b94f41b9da291993c9adc1802b31fb6f812b36e/poc.c

Build the tested kernel with the attached configuration, compile poc.c statically and run in a disposable QEMU/network namespace with CAP_NET_ADMIN. The probe submits the rejected software-preemption change, applies a valid schedule and tests short and long frames.

Impact and prerequisites:
The qdisc silently starts dropping 200-byte frames after an earlier request reported failure. This is a configuration atomicity issue for a CAP_NET_ADMIN caller; directly applying the same valid max-sdu has the same packet effect, so it is not an escalation.

Validation: Two fresh exact-HEAD boots showed fp=2 after the rejected change and then max_sdu=100/drop of the 200-byte frame after the valid follow-up. The patched atomicity control retained the old state.

Thanks,

shaos

