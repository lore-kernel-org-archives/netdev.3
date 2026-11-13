Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537676;
	b=ZELgPL/GE7PiQSPs47wH2W9u8WyGVto2XAOPMudjhQBcSNkimSPZyhun5uW+Zd7cd4cH
	 ku8jKTQr/60W7AAt0UgMt1c/nIOzZPHsZIXpcNzeHvUQKpdq990aB2xrJD8lfeYx/YNbd
	 9qUH5J/fhMBazbz0xRo8qmR4bcNBIaCXXXu+2KYVHYnkli2RugVwyzzYGe7K56P4zS4LZ
	 UQZWvs3yqxBVAp2uktZq/NSUzKpNoVxYazCzReYKii07BUDEn8PBbjWHWgLBNWVkw1eYf
	 aWY5IInYf0ACBTjzGgiSYwtr34u9DAd748rUhjzoygV3A3DPgh1NBfqp6jqjKW7Thkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537676;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=zkRpKkOvQAZ5hZ2mhhuRZMEQIdulwY+V928mnqGPy7g=;
	b=Dtf3vqGSuLRlSXQGCvjyfwFrTR6YC/68VAzU5Qt8sjRHVX+KDssKk2IUmEVhVzzIsSqe
	 2TlKDdnv58JvRhNe5EdG8nUWXWCH+cvCZmy8pKLc3vQKCaPB5F9fG37axkzlDD52KXLHx
	 xS4ZBb4GtIdJMC+6xW9qZTeE75skF0zB+9HWtKy1WHfva58g0P0esl9/vovhDIhsxCLvY
	 pHxwWxPLtaN87n37GS+BfIKNJwWO38UkxYIlswVi0Ik1dIDbSLGQ6XeH5OK6rVtxX1bjW
	 zqm5USuPZEfhj5A7YKlZsxEGlfoV2j6M46PnW+u8h2yLJ/zbKJd831R+b5j2JLgzSHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m6zWFRns;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46864606A323;
	Fri, 13 Nov 2026 02:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46864606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m6zWFRns
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zk
	RpKkOvQAZ5hZ2mhhuRZMEQIdulwY+V928mnqGPy7g=; b=m6zWFRnsrWnIvnDi47
	QeKuG6UsjZk4TMGCn9cDJlVwbs3LSpxrfcwCJ+7o+/7UoDYVkCDYjJagB9pEVUdf
	dEF6yUpdgS/6ilEUZyR3m7tNmsouQwT3b44aY00y7O6Mb6VSiS3F2QCWExRvWqzz
	Iw1SvsdS9iCwRooG5wtJ75UZE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3n52YePZqW_qOGg--.18359S2;
	Fri, 13 Nov 2026 10:40:26 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Fri, 13 Nov 2026 10:40:24 +0800
Message-Id: <20261113024024.68282-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <62abc297-daf8-415f-9450-202d226ebd9e@redhat.com>
References: <20261016040330.59041-1-taowei@kylinos.cn> <20261106063823.99731-1-taowei@kylinos.cn> <62abc297-daf8-415f-9450-202d226ebd9e@redhat.com>
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
X-CM-TRANSID:_____wD3n52YePZqW_qOGg--.18359S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUoVyIDUUUU
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC4Ryd3mr2eJzIJgAA3o

On Thu, 12 Nov 2026 08:44:46 -0500, Paolo Abeni wrote:
> Sashiko noted the added code could by simplified/substituted with
> a NLA_POLICY_FULL_RANGE(NLA_U32, &range):
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106063823.99731-1-taowei@kylinos.cn

Thanks.  I replaced the open-coded checks with
NLA_POLICY_FULL_RANGE(NLA_U32, &flow_perturb_range) and passed extack to
nla_parse_nested_deprecated(), so both the create and the change paths are
validated by the parser.  The range is 0 .. INT_MAX / HZ.

I will post v3 as a new thread shortly.

Thanks,
Wei Tao

