Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680520;
	b=ifKyzC3dGsYRlE+75gdYfHUIqoUWqFNvKU/R4qtzt3tiSc/HuAE2yAZu3EHvZfx61RoC
	 4EGu7+ulYRe2wndLVcrl97PlLf+SU6zwawqwdMp7xYTrm4D7/6o/uE9/lXMgDzvaH0qWL
	 MTBrrPdkBRMxU+cYmzesm07pAc71mvu0oxJiraWjO9H8fJslaAYfNrtHPOymNzYMWF4ta
	 FEJdhKyEcKM8VaersUX7yU8f0/PLhuSMRFk6TZwn0FwjG0Ug6fTZbu03MHFJQIVE1G/9Q
	 jT/ZUK1D4ANCW36Mz5OID6Ju2Czl1XSKILaN/U7Rk9P4/bJj0rbERgF3b6BeYQGGPMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680520;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vm38/MPbNIU1t2ouDzv5D6+sE0FkxX+qIWQN96y4HJo=;
	b=HgKXUxkf4k2XSdtTJPaGfszTrAX3FG5stsBZrmjB4l+PAyaMaYwm/5iGikmFVAN39Vj2
	 L+SGY7bSLrJx9S+ckYNvfXCqWVRx6cDRYaQ7hZvNLP+ImP7n3zxrblgJI3iQbxcIPeMPk
	 d7GtRsfgCC5azDYzgb9ZsjTYFznCfU5CV7F+5NbJa6zu0MOoHJw8F/hIOcUmon/5O/ZmD
	 Fs9nj7JPhO9AQSiTb4+pXZZhr8RGNsbUEs9IK4xdDA0KR3qLlX0OyFbTmxVpVAXU8o+uA
	 Ovy9nU81Tg2Er5/FS1qL4AOo/ZZErkfOeV0UVESazH0AU56NzF7QdLPu6xPuzri0acA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JW6ckQEb;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3D60A261A;
	Thu, 22 Oct 2026 14:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E3D60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JW6ckQEb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vm
	38/MPbNIU1t2ouDzv5D6+sE0FkxX+qIWQN96y4HJo=; b=JW6ckQEbrSqHQDq7L6
	8i7s+Xg6CopZkroisZtzuoLNTJfnvHJRUfuOOoDnKRXilBHPYtfdr/GyIct0g09y
	zWVPAANkdIZx0g4emkJyMC+a9xIFWKVK6ph3zZa7pkRR7DEsdYbb1ezoUje0W7jc
	ktvt/D/Lb1UI/MqRRjedoOCPw=
Received: from shaos.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3sQglItpq+dZbBQ--.34036S2;
	Thu, 22 Oct 2026 22:48:05 +0800 (CST)
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
Subject: [BUG] net/sched: failed fq_pie flow change still commits the new limit
Date: Thu, 22 Oct 2026 14:48:05 +0000
Message-Id: <20261022144805.65699-1-shawnq1@163.com>
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
X-CM-TRANSID:PSgvCgB3sQglItpq+dZbBQ--.34036S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw13Aw1rGr4xCrWxXr4kXrb_yoW8WFWkpr
	Z2va4ak3WqyF45W3Z7KF4xu3Z2gwnayrW3JF95XrZ5Ar43Cw17CrWIkryYqFn3ArykG34F
	va1Iga4vga15uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo7KsUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0Abi8GraIibdrgAA3D

Hello,

Create fq_pie with limit=10240 and flows=1024, then request limit=123 together with flows=0. fq_pie_change() publishes the new limit before rejecting the immutable flows request with -EINVAL.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/76c412e475cb36c49649b9825e807ff5/raw/ae794ca3a9b896c8e195876de08f79b82f67c5f9/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/76c412e475cb36c49649b9825e807ff5/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/76c412e475cb36c49649b9825e807ff5/raw/3a875172daae5e614f50f4ec313e3dbb85893d1d/poc.c

Build the tested kernel with the attached configuration; compile poc.c statically and run it in a disposable network namespace with CAP_NET_ADMIN. It creates fq_pie, submits both the invalid mixed request and the close controls, and dumps the resulting limit.

Impact and prerequisites:
The failed rtnetlink update changes live qdisc state for a caller with CAP_NET_ADMIN in that namespace. The same limit can be applied directly with a valid request, so the impact is control-plane inconsistency rather than privilege escalation.

Validation: Two independent fresh QEMU boots reproduced the limit change after -EINVAL. Invalid-flows-only and valid-limit-only controls behaved as expected.

Thanks,

shaos

