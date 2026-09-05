Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF34B0495;
	Sat,  5 Sep 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622596; cv=none; b=iB6qU9ujAj+/x0Gk7YXJe3wjbAXbOEgmkNDnOUNAfW7OXLeJUhetXtc9O2Rq/VAARDfNPy+Sd3Fjz7iDOWP9TNI9my/U5EPPqz+wpSvtCTMBfSJVmrlBRn1LOjxLiIs8Qt9HU2oG8zEwIm6zY5UFeLhh0mNFoTJ2+I3Vf5e9KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622596; c=relaxed/simple;
	bh=1MlI5//YnPlCkNTCdkd8+ZBjEpxPzDfVlXzv5d8aufI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxJwnjIVbjyBhQp6DH8584xTrNqbxLcFABo9Or5CZCAQzwu2zG6+fYBcL0pc8foN0xitkziIMopAEab0J8xQ/DkRiOGvhJgMPVqDmyLlAcrUkAm3pRcsFX9fuQx/FoYFjeObjf5rEK5Ww8NoDP/gbe4odx3NNT+c5eHIHJAOAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n1HFzLaD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n1HFzLaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BG
	tVfsD+Idm0Rru8q8gaU08QlFQGRmR/5Ipf/gp+BbE=; b=n1HFzLaD/Mr3yToOrQ
	jwQOj7VG8257/rB70mvnwEH/keRu2+VoPsTMJedavH49zScoRTtz/IjzTyboAHHL
	VrMpeZ+eHc4PDw2J+GatHJsoPPS8f+qnqURcYOI1vFMBh4TEztNCMPXczxXoK3FX
	/TBn1iDsHFSD0zBJBgm8y58j0=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn8j+dNpxqczV5Aw--.37655S2;
	Sat, 05 Sep 2026 23:35:10 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: andrew@lunn.ch
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH] net: stmmac: fix NULL pointer dereference in tx/rx resource cleanup
Date: Sat,  5 Sep 2026 23:34:53 +0800
Message-Id: <20260905153453.1648537-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3fd3506f-f254-4bff-a7ee-1063bf413919@lunn.ch>
References: <3fd3506f-f254-4bff-a7ee-1063bf413919@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn8j+dNpxqczV5Aw--.37655S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4DAF4kCr1Utw1UXw4kCrg_yoW8Gry5p3
	yIva1qk390g3y8Zr47Xw45Xa1SkanakrWUXr1S9rZF9anxWF95tFWjqr1UWryUJryruw40
	vr4Uua97AFWDZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRiYFdUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0g56pmqcNq7OUAAA3w

At 2026-08-30 22:06:16, "Andrew Lunn" <andrew@lunn.ch> wrote:
>On Sun, Aug 30, 2026 at 12:06:08PM +0800, Ding Hui wrote:
>> From: Ding Hui <dinghui@lixiang.com>
>> 
>> The DMA descriptor ring allocation in __init_dma_rx_desc_rings() and
>> __alloc_dma_tx_desc_resources() is split into multiple steps, each of
>> which may fail and return early while the per-queue cleanup paths still
>> call the free helpers for the partially-initialized queue.
>
>"and return early", is the real problem here. When a function returns
>an error, it should first undo what it has done, up to the point of
>the error.
>
>Rather than add extra NULL checks, please work on
>__init_dma_rx_desc_rings() and __alloc_dma_tx_desc_resources() and
>make them cleanup on error.
>
>I would say the problem you are trying to fix does not bother anybody,
>so is not for stable. So i aim the patches for net-next.

Thanks for the review and the direction.
You are right. The proper fix is to make __alloc_dma_rx_desc_resources()
and __alloc_dma_tx_desc_resources() clean up their own allocations on
error, rather than relying on the callers to handle partially-initialized
state.
I've reworked the patch accordingly: each function now will undo what they
have done before they return error. I also kept the NULL checks in the free
helpers as a defensive measure.

