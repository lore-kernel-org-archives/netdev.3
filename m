Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680523;
	b=MOjt9hRhuJvs4Dp2FcCGvO7IXnQfjGoVnHhUCMWYPKrPQivPyq60maPS4Bsub8yoyjnV
	 9WjTkYhAhz8pmibMLaffEQa3OdqFz1M6P7G/W1GhWe8KYoT897chyasYB1/hkPLCnNdiC
	 /8TefjDll572C0kw6UVCzvvCAZ6PfsFUcK2dN8OJlBDQOSRogrj52+PDbd050GgqyUtZw
	 f5eHDr+ZLlgSsp4GZY/w0rLvGZfylE6/nyT92VxYQGzLLA1Pk3p2mBDpiAm202e9tE8+q
	 il6mFJHblGDMyi4gt4CWzmw/v6yJ63yyRnTfIil7lPBNAC2HtktBiVhEn4Ja7Zg3cww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680523;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=5c3xQVElowUfLrTzEWstHGeY2ZjYqm7kADYcumVcXW0=;
	b=ageLDP8l/GSq0yH7ASSk4bzXrjMoIgg98+f6jWa/txOlQCrPHq3ieb6JLBiLw4B0aB2p
	 uFHPXpIEKs1mtKmTI8b/MGD66TOB/Jrf1RWfIIzbNlGsc8helOLJt7CoWAP3Jtt89B7i3
	 lyMavfe2K0eRGocWyjSw94t67Ft5UeZWbWuUgOVUh0aWKQxl4L2KLBn+arMqRYw3RCOIS
	 ckVbIPiEQdtc734fqYOkKGf/qOhqjnjjaRFmHKdC7CjnX+1CkcTvZRqGP9mPWCMPhTRQR
	 xOLlwj2cn0ogZGwRAq/1tm8E36mQoNyEWT7/Rf93VnnTeM2Th6hCEFanwOtQrRDyhew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=doedaK+U;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210B60A4AD2;
	Thu, 22 Oct 2026 14:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8210B60A4AD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=doedaK+U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5c
	3xQVElowUfLrTzEWstHGeY2ZjYqm7kADYcumVcXW0=; b=doedaK+UUhIbfvBndN
	Iv4gmZW5OyfVt7NYX5bg6rXwaWBfpea3vYBczXBD5ccqoTQUJINXLZi9GMzdN/sm
	snyjAEyv8Z+HzQGPQgWUHXk6NU/GBc8WLYhAc2zvY50qnJSgi6zV5zTYpdbdaZvF
	K0P8oO3Gnf+ayXqvF0G7ULYOY=
Received: from shaos.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnph0oItpql9hbBQ--.32871S2;
	Thu, 22 Oct 2026 22:48:09 +0800 (CST)
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
Subject: [BUG] net/sched: rejected GRED change can still update TCA_GRED_LIMIT
Date: Thu, 22 Oct 2026 14:48:08 +0000
Message-Id: <20261022144808.65885-1-shawnq1@163.com>
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
X-CM-TRANSID:PSgvCgDnph0oItpql9hbBQ--.32871S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xZF47XF1rKF4rGw4DJwb_yoW8Xw1Up3
	9Yv398tay8uF45Xas7KrW8W3WUWrZay3y7Gwn5Xw1DZFsxuw1qkryxt3y2kF9xWry8GFWI
	v3y0gaykGayrWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo7KsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwnj8WraIinLzgAA3q

Hello,

On an existing GRED qdisc, RTM_NEWQDISC sets TCA_GRED_LIMIT=1234 while supplying invalid TCA_GRED_DPS.DPs=0. gred_change() commits the limit before table validation returns -EINVAL.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/563fcf9f7c2144e0750f9ce9aef7f6ff/raw/18bf75ffee3a3587a962770c34af2301fb1c098d/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/563fcf9f7c2144e0750f9ce9aef7f6ff/raw/817a9271004049a448c2124d7a51e6d62e8ddc7e/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/563fcf9f7c2144e0750f9ce9aef7f6ff/raw/0b53273f9f8cd884092267d61110aed70f6233a4/poc.c

Build the tested kernel with the attached configuration and run static poc.c in a disposable network namespace with CAP_NET_ADMIN. It creates the GRED qdisc, sends the invalid mixed request and reads the limit back.

Impact and prerequisites:
A caller with CAP_NET_ADMIN in the namespace receives an error but the packet limit changes from 2000 to 1234. This is a control-plane atomicity defect with no demonstrated privilege escalation.

Validation: Two fresh exact-revision QEMU boots reproduced the change; omitting the limit and using a patched validation order both preserved 2000.

Thanks,

shaos

