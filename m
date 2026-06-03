Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB92D0C79;
	Wed,  3 Jun 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466744; cv=none; b=hWkQtYU/lwT7VuxLwo+doCrK1wkABUr/XnatLvhQBdz/msJ9kInnhTz3VRE4Xf56LSqirnZxLBUiwnMzSO5xffj+hzWkEpWZXg3yRn8VtC4fRFUsP45DmqGJLjutGCIz3jykKvg2JRlorimVXaRzPWXu63yiOfHqtZTJ5DDvyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466744; c=relaxed/simple;
	bh=etYlbpVMTxKne58P1nAPrEYifje/z3rX0Y22s5Zhvto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJKDYhsgaYWmGlKhAO9siGlPH3MLrdojS6zN9J9ws4kurXWURsFBxEDBIL7g4hO6yWmXCZwK5qP+pJf4bjWb1zUbfdmRNkvxvEde7Ut9QC7CNGf3jx/+gXjOzO+QW3EHguqJucwYLZTbpzRJNWAbyvf0xhuLjkzHGSkQo+0Dsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fEfXCRvw; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fEfXCRvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=SLWtycUJ8gUDuBzPmH5dSceW+4BXRpBWW0
	2+ITGCaQI=; b=fEfXCRvwwz6GHJT044JhVqnZQjeZ5rk2MI6Xs9IoWNQGFGq1uX
	/oIW+urJD6vPeCUSzmIkfFkRSZKx2j7E5wv4JhYCpnuUCQpKdi+3aSCZTsgwgNVo
	IZDd5DNg1B/FiK+uAovcPU0xJSRGNx7qcI2Vs6l9xUXcF2ZlS2XGUE/0w=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web4 (Coremail) with SMTP id ywQGZQDn+J0lxB9qZf_+AQ--.217S2;
	Wed, 03 Jun 2026 14:05:26 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	fengxw06@126.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qli01@tsinghua.edu.cn,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] net/802/mrp: fix vector attribute event count handling
Date: Wed,  3 Jun 2026 14:05:26 +0800
Message-ID: <20260603060526.21631-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20260602181338.3636444-2-horms@kernel.org>
References: <20260602181338.3636444-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDn+J0lxB9qZf_+AQ--.217S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOe7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I
	8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I2
	1c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8Aw
	CF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUgmiiUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgIHAWofuqgbDAAAs2

Hi Simon,

Thank you for your review. We have proposed a v2 patch at 
https://lore.kernel.org/netdev/20260603060016.21522-1-zhaoyz24@mails.tsinghua.edu.cn/.

Best Regards,
Yizhou

