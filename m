Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701107;
	b=q7rcjRa4oKJjcY+2ucj0sOnlLkERiINGEhI98k12Etuv0WCZxucVG+/WrBrbt25vR1Gd
	 fv5+VoPPbS7aPn0XW27zMvEEWhtZYy4ELznoov7px1ri3RADkkSCwU1ZE7rX7ewD+mvOM
	 X/YanWzAUcRodMsaDIJIRc2VVplv2lI/02WBmuV3MirvoWL+fK3ZzhVYFZPUVp6KmLgjT
	 znl2sD5R9QqqEPsjWd58W26ylqs+GP++kEo7rIw3PX38RZ2+xbM8a9A2CR+aFLJHg99rB
	 RaYACE2pA5jADyw44L9uLgQ5plJXNnqcHZwIVb1rldZvREBtOe75QDa2OR/CfMRBr+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701107;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q+qf7PzOxjIGrYfKn/FHezKWAiuMsA1N8qY4avTZ+sg=;
	b=SgVAH6QSAdNNy5DE49hmSqOP/FCzfK1U1OU0eyQatfEjqJyJ4a2NUmPIt2+dyUM20kJp
	 JrOCREaKlVlsaegB7kL/WOXdVMUHpHsgMHs/YhjG1T0zz4axolKG2f5ygJisctgSiW9uW
	 FveLpIK2sRbftKcz9dMeXNHhqMz4gbqFgCTi+eIF+wzdlwVvsdzv3GLEF7HXOtgDDqfJv
	 1DDTHJ5ytaeTbt+L2CExlhqT1CvFVmqIemZ5ZCKLEqxqAubfOAMXq9nAcEhi7Hi6hUx/+
	 /nrdeSgfIpmQgS0Sd6NpHRhduXfFlsNW2RVjcvCszrgbB2oHQjb4xejKHB/urrwbKqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Js/t+wic";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F20606EE8D;
	Tue,  3 Nov 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js/t+wic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF7C1F00A02;
	Tue,  3 Nov 2026 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701107;
	bh=q+qf7PzOxjIGrYfKn/FHezKWAiuMsA1N8qY4avTZ+sg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Js/t+wic0TSn5fTLXxZlAewrwiJJ9OtCg/7OOz8p6rErFOEu9Jg+aEmclGkaNai5D
	 OrElr9bCrj5mXtAv/UjhtyfGYiRMyLldLI1AzzKYC+UnlLspBU7P6YFNjPssJtVKji
	 +tmGSLDTg9Vrh+uYF7FAznbRESP53FRE2mTWJFd/8/0VmI1ATdC4SUD4ACxRkpVZKL
	 KnmOoAb14UWgaNg4lghmItZpo8V8jOsWLQJVpfM3OkxUA3ondDmBrbepJTmTrJZ2j0
	 8ncLU+/at2PB21FjJnl5hr0YKSm7hE7TgWO8+TSphHIZEcPLBF1+UH2XxowjEJJ/Yd
	 UmiqJ7Dxo/3ZA==
Subject: Re: [PATCH v3 net 1/4] net: hns3: fix vector resource leak in
 hns3_nic_alloc_vector_data
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:18:25 +0000
Message-ID: <179370110586.488856.5999411563039166781@kernel.org>
In-Reply-To: <20261030095633.377289-2-shaojijie@huawei.com>
References: <20261030095633.377289-2-shaojijie@huawei.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not give the real reason for one line of
  the fix.

--

net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data

This patch fixes the error path in hns3_nic_alloc_vector_data() for when
devm_kcalloc() of priv->tqp_vector fails. The new path calls put_vector()
for every vector that get_vector() acquired, and resets priv->vector_num
to 0 before returning.

> Call put_vector() for every acquired vector before returning the
> error, and reset priv->vector_num to 0 to avoid a NULL deref in the
> subsequent hns3_nic_dealloc_vector_data(), which iterates
> priv->tqp_vector (still NULL after the kcalloc failure) using
> priv->vector_num.

[Severity: Low]
Is this the right reason for the priv->vector_num reset? As far as I can
tell, no path calls hns3_nic_dealloc_vector_data() after
hns3_nic_alloc_vector_data() fails.

In hns3_client_init(), the failure jumps to a label that comes after the
dealloc call:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_client_init() {
    ...
	ret = hns3_nic_alloc_vector_data(priv);
	if (ret) {
		ret = -ENOMEM;
		goto out_alloc_vector_data;
	}
    ...
out_init_vector_data:
	hns3_nic_dealloc_vector_data(priv);
out_alloc_vector_data:
    ...
}

hns3_reset_notify_init_enet() works the same way:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_reset_notify_init_enet() {
    ...
	ret = hns3_nic_alloc_vector_data(priv);
	if (ret)
		goto err_put_ring;
    ...
err_dealloc_vector:
	hns3_nic_dealloc_vector_data(priv);
err_put_ring:
    ...
}

hns3_client_uninit() and hns3_reset_notify_uninit_enet() both start with
test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state). They bail out
before calling hns3_nic_dealloc_vector_data() if the bit is clear.

HNS3_NIC_STATE_INITED is only set once init succeeds, so it is still
clear after this failure. That means the NULL deref described above
cannot happen, with or without this patch.

The reset may still be useful for other code that indexes
priv->tqp_vector by priv->vector_num while the netdev stays alive after
a failed reset re-init. One example is hns3_dump_coal_info() in
hns3_debugfs.c:

	for (i = 0; i < priv->vector_num; i++) {
		tqp_vector = &priv->tqp_vector[i];

Should the commit message name the code that actually depends on
priv->vector_num being 0, rather than hns3_nic_dealloc_vector_data()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030095633.377289-1-shaojijie%40huawei.com
