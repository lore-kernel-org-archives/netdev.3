Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310F405F7
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644326; cv=none; b=bDhx4YuuFczxqq9jMSWYIJlh3BZGnqiMvZ3sf/DJwQwLJ9A/wakjxEhkJnVzaALIb/+8eKX+dxvarr8UYCgJXCKsEMq1HtH6CLB0dSCL5t3fOG9hyCHmYdGHKkKoDwcCPWaCnu7PtTxH6wgA5uF7Oto3bAbEiqyL1nAer189Ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644326; c=relaxed/simple;
	bh=MMXU2a+i7Yf7Ak7S7Zb+3DIBXEpJYrncAgbLF9rqRNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbJJs2PFy0CM8LdzEQhwcceAlfjWbeICQKaWz5zWFf+vm7k7QpfK/S/fKglXbJ2+5rLjYv5+Nz40xGljzSAIAt2nJ+GIDcNe/e8qcqmz8EbMhjodpTyEFUsFC4067ePODLblwPLcw+9nr3xfaNPkrM8EeA6UMm6t7vZR23jHc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fueZUl8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fueZUl8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787644323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmXhnBSMTGUrH5O1ANS4et/RxLazQMcA0Z+Dk2f/vxQ=;
	b=fueZUl8B0owiv2akiMV8SSe0aYg8Vt96gand62pp4FteXgezArng6+8WxMP9isRoY0rJRo
	8rUuobi71Uzrm4m4hJ6Shd9e4DNhJrcCTqGmMnmZAEQpzVVOGPkwpkoBY3bQowRjJwiulk
	/welmfvmxeEsWF7jRrDVenB0KG/Lfco=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-fhSZXN0aM5-gbGu2ELL5Jw-1; Tue,
 25 Aug 2026 03:51:59 -0400
X-MC-Unique: fhSZXN0aM5-gbGu2ELL5Jw-1
X-Mimecast-MFC-AGG-ID: fhSZXN0aM5-gbGu2ELL5Jw_1787644317
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15755187E5C6;
	Tue, 25 Aug 2026 07:51:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D152F3000239;
	Tue, 25 Aug 2026 07:51:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	alexis.lothore@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: Re: [PATCH net] net: stmmac: selftests: Pass the IP proto mask in the TC selftest
Date: Tue, 25 Aug 2026 09:51:45 +0200
Message-ID: <20260825075145.34118-1-pabeni@redhat.com>
In-Reply-To: <20260822153245.423259-1-maxime.chevallier@bootlin.com>
References: <20260822153245.423259-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: selftests: Pass the IP proto mask in the TC selftest

This adds an ip_proto mask to the match data used by the L4 filtering
selftests in __stmmac_test_l4filt(), so that the new mask sanity checks in
tc_add_basic_flow() accept the rule.  The commit message reports tests 23-26
going from -22 to 0 on imx8mp.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 1df26c217f9a..e9be4d7cbb82 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1489,6 +1489,8 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
>  	keys.bkey.ip_proto = udp ? IPPROTO_UDP : IPPROTO_TCP;
>  	keys.key.src = htons(src);
>  	keys.key.dst = htons(dst);
> +	/* Match the full IP proto field */
> +	masks.bmask.ip_proto = 0xff;
>  	masks.mask.src = src_mask;
>  	masks.mask.dst = dst_mask;
>  

[Severity: Medium]

Is the n_proto half of the basic key still left uninitialized here?  In
__stmmac_test_l4filt() both structs are declared without an initializer:

	struct {
		struct flow_dissector_key_basic bkey;
		struct flow_dissector_key_ports key;
	} __aligned(BITS_PER_LONG / 8) keys;
	struct {
		struct flow_dissector_key_basic bmask;
		struct flow_dissector_key_ports mask;
	} __aligned(BITS_PER_LONG / 8) masks;

The function then only assigns keys.bkey.ip_proto, keys.key.src,
keys.key.dst, and now masks.bmask.ip_proto, masks.mask.src, masks.mask.dst.
Since dissector->offset[FLOW_DISSECTOR_KEY_BASIC] is 0,
flow_rule_match_basic() hands tc_add_basic_flow() pointers straight at
keys.bkey / masks.bmask, so match.mask->n_proto and match.key->n_proto are
whatever was on the stack.

tc_add_basic_flow() in stmmac_tc.c makes decisions on exactly those fields:

	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK)) {
		NL_SET_ERR_MSG_MOD(cls->common.extack,
				   "only full protocol mask is supported");
		return -EOPNOTSUPP;
	}

	/* Network proto is present in the key and is not IPv4 */
	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP)) {
		NL_SET_ERR_MSG_MOD(cls->common.extack,
				   "only IPv4 network protocol is supported");
		return -EOPNOTSUPP;
	}

So if the stack slot for masks.bmask.n_proto happens to be non-zero and not
0xffff, does the rule get rejected with -EOPNOTSUPP again?  With
CONFIG_INIT_STACK_ALL_PATTERN the slot holds the 0xAA pattern, which is
neither 0 nor ETHER_TYPE_FULL_MASK.

From there tc_add_flow_cls() falls back:

	ret = tc_add_flow(priv, cls);
	if (!ret)
		return ret;

	ret = tc_add_ethtype_flow(priv, cls);
	if (!ret)
		return ret;

	return tc_add_vlan_flow(priv, cls);

and with cls->classid == 0 those fallbacks return -EINVAL, which is the same
-22 that tests 23-26 report in the commit message.  Would zero-initializing
both structs ("= { }", as attr already does in the same function), and
setting keys.bkey.n_proto = htons(ETH_P_IP) together with
masks.bmask.n_proto = ETHER_TYPE_FULL_MASK given the injected frames are
IPv4, make the result independent of the stack contents?
-- 
This is an AI-generated review.

