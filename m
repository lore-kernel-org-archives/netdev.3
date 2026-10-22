Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680508;
	b=CEMUa2A4lhtUvolBIXsXmHXNX8x/N11ckxMc44RtOPhIC9d1/ltGS/qgZukaKBq5LyEM
	 lRiD/97FtNUAnunIXVBiUFneUq7hOIbpgFSaWB02kRncNN7FB34vnMdKmJJZVVdrnAXCv
	 yA+7mGuCHKuOAACqPmmI9xNgP5hHj7ZLMCKhtrJYRxjiEhjHl6pXcYynd9mXQbL8B7oQX
	 4DeMbJtyOiC6vnqzRC69j/jXdQbVYhkyvTgvY00Wx6vw4fME6Z8GiXPQTDNkWxdP5tvNk
	 8QEyJilEcm9dDeM7hphCqRdUPA8y9TDrf2fyR+jYxe/GVuOi9BrpcYI4KtYj7IXipww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680508;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=duV/2z31rQIoU2/rD8fKnwPJbWnx1E8AZ5VoupEQHyY=;
	b=jMwixDA1p4VL37GJG+PwleZ4slJZpXB2VYoI5Pt7JhtO4GOWF1Ei+e5u8czz2ZS+kD6A
	 zBDEVAPc806whII1Bj2OzE4sGdlfWKp//L2AaSFEu7kWuT9r3K9KyKbyrd1Hk8+hEndZ9
	 eg+df1oGJFaBWsoMnWYgQtQ6807rGpaRjnMdrIRtIaBNbmZKEoUMOgj8MtpNZtz4M/P/y
	 LW21ePzHZ6im49L8dNwtuC7YsEJXanibI3bUs7MTHCIkVYfZxVdth0Wx/J/sjeOgS9/Cz
	 37Zm0RGnqC//YHQq/VJ7hI7IfAyecbgFy61g+HeDdYM/OHYZiRAdKl91H3VxMSRIUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DDmmWq9p;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD926606A335;
	Thu, 22 Oct 2026 14:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD926606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DDmmWq9p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=du
	V/2z31rQIoU2/rD8fKnwPJbWnx1E8AZ5VoupEQHyY=; b=DDmmWq9p873WGfWws4
	xbkucp9OyugfWW5qjMvb5Qz3oSnuH8LNQ+NKYA/4opTpEY3RAyeQBv0EBI7aArX2
	WNzxxzNmpT06q89GXeo4eyBDdm0gzpCnQysaI5WEodjDgQGZBgNE5/iwSJAuAnI4
	3QdmsGm5yiKbh0b3ixXzmdWmQ=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3h04OItpq8HXqBg--.26724S2;
	Thu, 22 Oct 2026 22:47:43 +0800 (CST)
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
Subject: [BUG] net/sched: CBS slope conversion wraps on 32-bit kernels
Date: Thu, 22 Oct 2026 14:47:42 +0000
Message-Id: <20261022144742.63456-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wD3h04OItpq8HXqBg--.26724S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWrur18tw17GF4rJry8AFb_yoW8tF18pa
	yvy345t3Z8Xr1UJr92yFWkZa18K393Aa1UG3s5Gw1IvrZIk3Wvyw4Iyr15AFy3X34kGrWr
	ZrnY9F1kW395uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5eOLUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzw-c6mraIg-KQAAA3h

Hello,

On an ILP32 kernel, a successful CBS qdisc request converts a signed 32-bit slope to unsigned long and multiplies by 125 before widening to s64. This wraps values above UINT32_MAX/125 and turns a negative send slope into a positive dumped value.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       Clang/LLVM 20 and LLD, i386 build

console output:
https://gist.githubusercontent.com/shaos26/dbaa4a3726bde3bc54298b094d1c13ff/raw/d2c0239d34db2dd28138fe0f267a96263d06c8c1/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/dbaa4a3726bde3bc54298b094d1c13ff/raw/bb3de79c6447b2180acb836fd229584486405419/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/dbaa4a3726bde3bc54298b094d1c13ff/raw/9b82c23a085560adab3f89894fe0847d324be1f6/poc.c
32-bit compatibility header:
https://gist.githubusercontent.com/shaos26/dbaa4a3726bde3bc54298b094d1c13ff/raw/16b578cf6d1de2e13f157406d9b1a55bf15725b1/shim32-sys-socket.h
reproduction instructions:
https://gist.githubusercontent.com/shaos26/dbaa4a3726bde3bc54298b094d1c13ff/raw/28cf51867cfa9e7586e7bb6f2062bb3db9bd31c6/reproduction.md

Build the tested kernel for i386 from the exact commit using the attached configuration, install kernel headers, compile poc.c as a freestanding static i386 binary, and boot it in qemu-system-i386. Use the attached reproduction.md for the exact i386 build and boot commands. The i386 compatibility header is supplied separately; the PoC intentionally rejects 64-bit builds.

Impact and prerequisites:
CBS installs and reports incorrect shaping parameters on 32-bit kernels; the same requests round-trip on x86-64. CAP_NET_ADMIN is required. No memory safety, crash, information leak or privilege escalation is demonstrated.

Validation: Two fresh i386 QEMU boots reproduced the modulo-2^32 values for boundary, negative and large slopes; x86-64 controls round-tripped the same large values.

Thanks,

shaos

