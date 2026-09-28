Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79322D0C7E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599191; cv=none; b=VcUVGvraKkBOsJ06ppJ2iZ6rDCJZ0dvqUCc0vgc8r2Fph8eULjhILwqvsuEJcvXVcHBMdNgn5RMA4XiNzKIkaqRdwgQ7bjmtZJP/lL2VQqbZMJsPkN/51KSJ8xb2ePSDxQQZnCu9uhWQnMIha7jKaqx7G6sFtNTtcLxfSHy+glY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599191; c=relaxed/simple;
	bh=HhG09UnjFLJrbNF2of0ds2Qo6nMJtWw1g/fH0tK8Xdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPjguDpLqdFDSe6mCZPq/pbSi6edrOlbeV6jx2GR37028/LcWkNxhBig09J5J4gOC2GwThYk3bdpf6mXAjVIVOBrvA9WBTWY6L8M/uM2r5L0sUsbjp0LH5WsaIz6/AGTUjl5Us2PMbFrh8ahe85XLDzWvLJpt7LL1q+eLR/KC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOIfuqLv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIW+WbPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOIfuqLv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIW+WbPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790599188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhG09UnjFLJrbNF2of0ds2Qo6nMJtWw1g/fH0tK8Xdg=;
	b=KOIfuqLvaxdylDONBIeUywuN6njnWgUicUGuvzHbs2XuUlH3ZYOQUbZQ4tsxlMcFKvhyYD
	bk57z5l+tFIsFRQyHRtzNtVPblGG6eUeVDhqTMq8qQNGmXEiRSTbMBk9YEDH0ZrhdB5QbM
	0xPQYOmTP30xnARYAoeUfbfDy+oA3go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-lHFa9JjzNimfw9yCzavo4g-1; Mon, 28 Sep 2026 08:39:47 -0400
X-MC-Unique: lHFa9JjzNimfw9yCzavo4g-1
X-Mimecast-MFC-AGG-ID: lHFa9JjzNimfw9yCzavo4g_1790599186
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4887efa4486so2313383f8f.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790599186; x=1791203986; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HhG09UnjFLJrbNF2of0ds2Qo6nMJtWw1g/fH0tK8Xdg=;
        b=MIW+WbPOVcZU0kmB66rmHLHz7c8b6Sw371D5DB9NZ0MqVfnxLdA7rdqE8SVAWDJRVY
         3hj4coCquon1dIj/Fel/03TYzJdkPj8dphUsvx3bgG5RIygMqIpdIPyN2g/yPwIKhlCB
         5+y7xqE7KGwOcQlPAqEE/NzuT65qIxbVPtBwkGw+oioAcHe0H8wy8hQTrz3/dDN0gOIP
         7YisCh2S6D0xwQS0FewbLW0YxRtD3NmibnQOqBOuRsMdTvkQ6/iUFczxVGkZzJUh97Tc
         FvtoDg5tUJEZTaoXMAu4JXF3T9T0pFODKp8vYYGg5vXVjamyfeDhRoA2SGfc0V467qCo
         HEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599186; x=1791203986;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HhG09UnjFLJrbNF2of0ds2Qo6nMJtWw1g/fH0tK8Xdg=;
        b=I/bkfKDcmLM2SljjbrHWPg0bRyuxcHV3OLSBy0tZFHVxVmD5lpYlAmyIz3VjXWHSmO
         NFHIP/JFu79oWxT9Py84aSUynX4gxOPaVLlJHCrD5cZUM3WlmgJlPskDbqy1u0CgpmLP
         cR/+Z+cTSNrqR3S4qEDTFK3BcsPh9mHIUVQZmJkKy8WY/DTqgqm78MNfHviMJL/O8+zm
         GHx2mAQmUBIMNJhU4ihthRRC8gwfIHlMURR1qTnRXrwmMQ18t4Yx0ka8nLFayxc/PuXS
         wS/gdqjVbJg7EOEAT1DkdUVobpaNapCixwcutuKFqTuSpapCz5xb0DsUbGw+pifHl9HQ
         yEuA==
X-Gm-Message-State: AFq9FYJQbFf7KghtZPFzto+zayrdBJHkM4T8tU8ElYCA42evnFwZ3njC
	JJIi0ZoQIUlOjm34VZltGSU7fqL4McROeVVaqDTbiCR4b6HB7kUE7bXVP4ReUAS9ZmAlk1dfrBQ
	6YhOKHGVzV9ul9pGQBK5eBDCS88wWp2Ct5zkt5Rm3odeyFWT4cX0xk2hVFQ==
X-Gm-Gg: AYBFou2mvmNTA1fQx2OWuYdrSlId8U3nEHeqyfaeH1xaQnvp4S5hyOQ/E1psz2fAk91
	LBfmI+aQdp+54Zbp67kRjLx32WW6MjGa8bhT/OITKTB7c7j7WxcA99IAvfR7vjzDgzfeljvBz4k
	p/OfWnkjddvvY2DJ7LmERuKnhLWsA9jOJR/mUN6FGRFW4ZdSaWY7DOQ+7m0S2kNOqk2H+T09xPl
	bGZ/pvhUSZyvKA8+M4BHa5/m8S7lCvCX7Vx5V1M8AEyOk5f6QlxzjXJYGTwnPfOXxmT+k1K/oyX
	ntS8/A8QJspNZUm13Rv07ILg5VRrUv+Nr35Df0kg0TYhjTVehLCa1GTIT9fQMXe4o4jmR3ue/Vp
	qBrBwJY+qsXwHrAfsfgBBUp/5RGYOqdQ=
X-Received: by 2002:a05:6000:490a:b0:488:85be:d280 with SMTP id ffacd0b85a97d-48885bed71bmr9953619f8f.6.1790599186013;
        Mon, 28 Sep 2026 05:39:46 -0700 (PDT)
X-Received: by 2002:a05:6000:490a:b0:488:85be:d280 with SMTP id ffacd0b85a97d-48885bed71bmr9953589f8f.6.1790599185565;
        Mon, 28 Sep 2026 05:39:45 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm27872549f8f.27.2026.09.28.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:39:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah
 Khan <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] selftests/net/openvswitch: add SCTP
 flow key test across conntrack NAT
In-Reply-To: <20260918144647.2024095-3-houminxi@gmail.com> (Minxi Hou's
	message of "Fri, 18 Sep 2026 10:46:47 -0400")
References: <20260918144647.2024095-1-houminxi@gmail.com>
	<20260918144647.2024095-3-houminxi@gmail.com>
Date: Mon, 28 Sep 2026 08:39:42 -0400
Message-ID: <f7tik3p8s8h.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Minxi Hou <houminxi@gmail.com> writes:

> After conntrack NAT rewrites a packet, OVS refreshes the cached flow
> key in ovs_nat_update_key(), which has a per-protocol branch for the
> L4 ports (UDP/TCP/SCTP, conntrack.c). Address-only NAT cannot tell a
> working SCTP branch from a missing one: the ports survive unchanged
> either way, so a post-recirc match on the original port stays green
> even with the branch deleted. The suite's NAT coverage drives TCP
> over nc, and the merged SCTP test has no conntrack in the path, so
> the SCTP branch goes unexercised.
>
> Add test_sctp_nat_connect_v4: untracked client traffic to
> 192.168.0.20:4443 hits ct(commit,nat(dst=172.31.110.20:5555)),recirc,
> and the post-recirc flows match the translated tuple,
> ipv4(dst=172.31.110.20),sctp(dst=5555). Reply traffic is matched on
> the restored original tuple, sctp(src=4443). With the SCTP branch
> broken the translated port never reaches the key, no post-recirc
> flow matches, and the association fails. The probe flow uses the
> same ct+nat action as the real flows, so a kernel without
> CONFIG_NF_NAT rejects it at flow-add time and the test skips instead
> of failing. The config fragment sets CONFIG_NETFILTER_ADVANCED=y so
> CONFIG_NF_CT_PROTO_SCTP is visible, CONFIG_NF_CT_PROTO_SCTP=y, and
> CONFIG_NF_NAT=m so the reference build actually has those pieces.
> After the association succeeds the test pushes a known payload
> across and waits for the listener to log it.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

