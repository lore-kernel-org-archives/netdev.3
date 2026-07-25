Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA12475CF
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784972043; cv=none; b=r6BInTT5eoTy1Q5wKNcLWYhZWgW5B69ONN4K/lvI1E5eJyLVkmOccLeQYbjAe5w9NPxIbNtiajjickfwXAr9sc67mxraYGPykos2hnM9SF1Y6azU1EjdmHRPCQScTHSWky9whB24/nBrQSvHsJCMSgO+Mj7yJMqx2dBtiZWMyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784972043; c=relaxed/simple;
	bh=meRMfy0o+DG+KyNeQH6Lb3VAeSy4HQz7T2DttwTeRU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LmFD3TtVjbkNGEX3YwiyLauj2dpyBj4lBGFJIAj8HnweVEAPtnG35VJ0Dx+7c+VozBe7yQcJPvkLhPNseQ7oBvv+o5780UFc3PwD0cIYyWGCa0JwG6qOGUxanuPzx1xRJFNs2Dwyp9Wk5Cq3gSJECuuIOWX9LK59W4+GqKszWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G75q2wl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G75q2wl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F20F1F000E9;
	Sat, 25 Jul 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784972041;
	bh=OSAA/IfR9dxDSKHZ1yxehMqBPmQWJvJgw2/2B2ryBFk=;
	h=From:Date:Subject:To:Cc;
	b=G75q2wl3CWJG2J3FFxbBwloHVTun1ydhFSM2CvIVyck1dge/ib4ah0HiCoYJO83zM
	 8GbfeDNKj6GfZjJbZbC1K2puAFkE3gNBvEooBhofm6xNGkD9k0SA8/DU+kgTKc/cws
	 KJCm4drLFQpOGkVKz/WxGHGHEailqjZQdfMQ8qexFT/yAR/j45XmVpBDub2E7O69Ve
	 Jv/Xv3nSIodc6RFNmFCRPLj/UeUFV/1kiyIbeSvumkq2Lu+UaI4EgQ6CCzVGVNTGxQ
	 W88C1SzUR7vy1w6SCzvjlCSQTF9TT5/NO0MkOZjnZO/9uhmLfRvaNg57z3Za8O+lqC
	 Tz6mhNysbp28Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 25 Jul 2026 11:33:45 +0200
Subject: [PATCH net-next] ipip: reject unsupported configurations in
 fill_forward_path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-ipip-fill-forward-path-fix-v1-1-bc69fd3127d5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gZix44wVxEXRaMGpJa0qCDef
 YLL/xb/hswqnOFX3aB8SJY9WjR1BeMa4sIokzU4cl/qnEdJknCWbcN51zPohCmU1eRC337GtiG
 i4DuwQVI2fuc9RC4Y+SowPM8fH1Yg2nYAAAA=
X-Change-ID: 20260725-ipip-fill-forward-path-fix-543c41000a57
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

The ipip fill_forward_path callback currently does not check for
configurations that cannot be offloaded to hardware:

- Collect metadata (flow-based) tunnels have no fixed destination
  and rely on per-packet tunnel metadata, so the forward path
  cannot be pre-computed.

- TOS inheritance (parms.iph.tos & 0x1) requires copying the outer
  TOS from the inner packet at encapsulation time, which is not
  known during forward path resolution.

Return -EOPNOTSUPP for both cases to fall back to the software
forwarding path.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/ipv4/ipip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index d1aa048a6099..0831f6b81717 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -360,6 +360,12 @@ static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
 	const struct iphdr *tiph = &tunnel->parms.iph;
 	struct rtable *rt;
 
+	if (tunnel->collect_md)
+		return -EOPNOTSUPP;
+
+	if (tunnel->parms.iph.tos & 0x1)
+		return -EOPNOTSUPP;
+
 	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, tiph->saddr,
 			     inet_dsfield_to_dscp(tiph->tos),
 			     tunnel->parms.link, RT_SCOPE_UNIVERSE);

---
base-commit: 04026c998c24ac47eb76886b9790c5710b603eb4
change-id: 20260725-ipip-fill-forward-path-fix-543c41000a57

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

