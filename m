Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96966331EB5;
	Mon, 21 Sep 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962155; cv=none; b=B/yfUbA4kQVyvwgrcBYpS+uIxj73mIUwQVHSBtnwm8GspeuaFdzx+BSI5wTBs2jyCE4obaMOttJhYxsoJmUQkS27t9xgmXuLXiOVs3o2HJZzPTj0oUjKNVrpXJc0B9DKXs5ylHL3jy1tcT+OxycvybJO6+oml4Jy+eTiUx1duAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962155; c=relaxed/simple;
	bh=NdSCcVfzkkNGws8HsrAT0no3jlNrDV1Tucu8z3oaBeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bC0XcquKtSmnUVatGEYl/lHGt9o465bmZxxAvCipHVsaAO3Lt4CA1e0iBTC9DpRHJZS2HSBBTvtk2bHqXj/3SrGFirWwRYHwaJ944E97dnHwoNRNaI7CAGY9V5VFcH11sC4u2eAfyOolPqcuZtHBg8EihP3B+EMAVGDO69AWIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXATyLp7BqpO_RCA--.16449S2;
	Mon, 21 Sep 2026 11:42:03 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: tung.quang.nguyen@est.tech
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tipc-discussion@lists.sourceforge.net,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH] tipc: refuse to attach a second bearer to a netdevice
Date: Mon, 21 Sep 2026 03:42:03 +0000
Message-Id: <20260921034203.2416773-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DU4P189MB3750BF183DB76F1E3AF58B79C6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <DU4P189MB3750BF183DB76F1E3AF58B79C6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXATyLp7BqpO_RCA--.16449S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I
	8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUoYLvDUUUU
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

Hi Tung,

Thanks for the review and the suggested patch.

Unfortunately I don't have a reproducer that triggers the crash
reliably, so I can't do a runtime test.  I did apply your patch and it
builds cleanly with CONFIG_TIPC enabled, and I agree your fix is
better: rejecting the bearer in tipc_enable_bearer() before any
allocation or device reference is taken is cleaner than the rollback I
proposed, and it reuses the existing "rejected" path with a proper
netlink extended ack message.

Regards,
Jiakai Xu

