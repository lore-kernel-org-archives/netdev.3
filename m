Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680547;
	b=A/xxbNOPZRXHetSunxsEQ2leQZ2FKPSwW3REPSJQHrfX9OH9yW9XxJrwfFSRoZkM8BON
	 EQoKoUquThG3yQUr0DVYDwHPXdhh9SxSGSB0c0ZHMGb37ZwubJt1SYZYpPf2kJSy1vsPu
	 s2RqbrLspuFHzouZh5ikwMUCrMmCpDu7/Rbl98WmsUYoK16Kec3RgoJhpiTkpXzmOA3S7
	 ZVPOKulwv6lZL5HhuQLYuROBO73HBGHlOmIOgW95PXZBweNIIQJg1q7ShDbps1fW/cbxZ
	 ry/1oTt4nrtNP78EEoHvsLIgnkCEiHV4nuMLOTmbzs4CLNXlzLOfRldvuzcuGYucgVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680547;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=BD2YUmGBZ0fJuN8/rGz/WIoqbRwZ2f4JKzdSerHPyfA=;
	b=uPKaui4nCUY4vW0MBnUkbRLQyy0wMUoDAqWDwkDhaZCXnyX/lN/+SoMbIxEy9k75lFNI
	 gFBsQrsLoFJg3aCezX2JGKyoNCyMjOxVbM4UNJWr8cC331mGc0LftVlZNGHjQID9oLWas
	 WjSflZqj56p+BUth9zkDjZ+nFUhMm5QiW4elRhZxsb7mWyHVB/Ws8wQsKz+jBMO0jEE8C
	 U/9AGWRnvmJ6e2qeay+gjAipCAJBJW+zpRQCXvvB/oHUSoKpyz7K3Xqsa7weUWMgvL1zn
	 ISqF6uwpRUZFmIyLL1pBJZoyYn/i06yq1TynPMBUzmJqYdxnf5gmqy/6V9Ti9UcZa+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QHbc5L82;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2202606B040;
	Thu, 22 Oct 2026 14:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2202606B040
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QHbc5L82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BD
	2YUmGBZ0fJuN8/rGz/WIoqbRwZ2f4JKzdSerHPyfA=; b=QHbc5L82PdTaNLvsWr
	ANfStZ2TaQHlv38AxETCBuBxbsXqGn5WT8t6G0wrllwBNR46eq9blELeZ10Fzicx
	JWFhWECu3JO2KcbuiU0aouQY+lJuOKrve7O2fI1EKDVJMT197AW5hCciRqQW08qm
	sr2d747xpxsFD9GOYbwBNkITE=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_zg4ItpqZHaSCA--.62907S2;
	Thu, 22 Oct 2026 22:48:24 +0800 (CST)
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
Subject: [BUG] net/sched: rejected non-root taprio creation clears live mqprio map
Date: Thu, 22 Oct 2026 14:48:24 +0000
Message-Id: <20261022144824.67408-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3_zg4ItpqZHaSCA--.62907S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW3AryUWrWrWry7Gw1DGFg_yoW8AF17pr
	Wvya90yaykWF17trs7GFW8W3WrXas3Aw43Ga4kGr4kZrsxCw1jyr4Ikay5AF97Jr1xGa9Y
	yrs8K3WxWw4vgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07josjbUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzxjn9WraIjjNBAAA3m

Hello,

With a live root mqprio qdisc, request a taprio qdisc below a classful parent. taprio_init() adds the new object to its list and returns -EOPNOTSUPP for the non-root parent; failed-init cleanup calls taprio_destroy(), which unconditionally runs netdev_reset_tc() and clears the existing mqprio mapping.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/d6cb2b6c066a10408dfa57513e998893/raw/40ff06d00c93a18c5f6e9cd5cceabfe8ac1ad5fb/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/d6cb2b6c066a10408dfa57513e998893/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/d6cb2b6c066a10408dfa57513e998893/raw/20c2e2bcbd51b34914e3a6571beb81777802e3cd/poc.c

Build the tested kernel with the attached configuration, compile poc.c statically and run it in a disposable QEMU guest/network namespace with CAP_NET_ADMIN. It creates root mqprio, attempts the rejected non-root taprio qdisc, and reads the surviving mapping.

Impact and prerequisites:
A rejected qdisc request removes the live device traffic-class mapping and its subordinate bindings. The request is available to CAP_NET_ADMIN in the namespace; no privilege escalation is demonstrated.

Validation: Two fresh final boots and a persistent-package rerun reproduced num_tc 2->0. A failed cake_mq control returned the same error while preserving num_tc=2.

Thanks,

shaos

