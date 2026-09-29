Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682A530DF0
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693989; cv=none; b=QiuMvqZdCt4UdE8+UQ3bJ6vmVt4w6nqSJe5iFaM0LzrGyWg9NqC4zDsFqRbznxk+O73mU7xbaU02f+OynwKi138CaRu5vuMeCyKUicejsqe9zYnadtcH6fZAofJFbEPRtuIURjsAg1h1XIvzo4DSzm8VfN36ZBxXuc+1EWC2E5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693989; c=relaxed/simple;
	bh=Oc7bxFFYK51p52NUbs3fixyrRN85Pe6dMqASRV3orXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sgF9ynjSDA0P1IFF3GbQOrIAFJ8l3VDVDT/OF6t6yiHRlpIhwnZ5hA6eb/lAepZR0n0zBIs3oDtb7QRrkfrLlenYcomuUDh7OYCUyp+a0LjXA6VkyuOuR+wCEWgrYxVetkacq9OQJbktHwYS7DbbmoNadQIIga4MJtmV0Zprvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWi7benE; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWi7benE"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so8218557b3.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693968; x=1791298768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UuWrvMp18DN6rvgalWWP1Gy49/TlMK5TxIxA8O+G6r4=;
        b=IWi7benEMWDAgfjre5+otHVvoBlSaYXypu5HdtJNqSCzdLjd7M+EfFK8MedzcAspI7
         m4AOuvwbm9RWijx6lOD3hA1KZXeBppg214o0rkLd790WlZEKP9pTJicm3nBYXUyhpcFg
         Uv6derIz888kKqAB4axgcY//KNEyd0OKROTQ3dljtv5ZXqTNvqwWU9KzP0p42zxFivcN
         OSqzCgsEzuO2uf5Syc3cSBgdiU/6SRYLCLte4t41Jgc5ej9UdjURsbs+NScOmxoMw9EE
         dPLESkU4tyVZVN97zet7A/vyfOmq+gEs2DxR4nGYdQrYhEl+2NtwPO9HqQ9Ed+ROUsrx
         sZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693968; x=1791298768;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UuWrvMp18DN6rvgalWWP1Gy49/TlMK5TxIxA8O+G6r4=;
        b=BxbYiJYJOIHpblTCBsTr8SLh6MSD2RZk299Q1vXgJQS1ZdC62/E2Ae42LM51zku4Ga
         P8wLVPTSiBSyRUcl4mtchW862gj6djy1+3002F6G3RLLHgVQ6Nhtd5OvGQPQmal2QjPK
         FWKpgf1vh9o19qA2Ks7LMrwwAIRJ9n1i0Sgx8g64NQdrAW/WiF3LWJANcNG5cPfVqu+N
         sk7FD6gy4ogxeZXWVDYhCE2KUfw4MvZuxMxepmlEz/qlYKjGCYMqympQdkoJzgYVBMhs
         6AjT0WF2xH47LJvA1mEBbXwFlczj01MV4uLe6Jpmnh2d0XIjJ7XlBSCTNs/B+dhZYGkP
         64vg==
X-Forwarded-Encrypted: i=1; AKwUvBw0h287m/+eNewSb6g70cZVSM9OA44EUx5rWzcReQ0zNxM1poG0Sk5c1ngjE6dtM191Be1iNFA=@vger.kernel.org
X-Gm-Message-State: AFuF++nwZy30JPUC9xjl1qdsG37d0RsZ+czVktbPIJMkK8vSAxtu+sPk
	nTXEjGFTuOwp9eatSEUUkgyaACnF3EfnzQeF4fBVGpKAyfvMw0gkpuwH
X-Gm-Gg: AYBFou0AIrgfjO5uWB2p01YCGHXtw9te8vv3kTIAAQIphqcliGJej966nsx5audrdWW
	OIpHTYvaSlL9etv8m0GJnaYXVg3MqLWicLxzLmKU3VgQCRvB+sR2CAm2zZtuG0zapRRyCEoYwXu
	MGhrRlFfidRIEWHGexMmOXlMVW0VKtm4qJp1YeHqFQKq50GD1ApZ2s9QhpZ8QejwIqL3K6gBvoj
	XioF3uYOHS3ZKtJsotUsDaG5Pre/0U80U5tz6y6mIoPjo4KpipB/th7rxHeZfv/r8BHjzNbsive
	TBFCk3Sroxyk7/oWmZtB/nzAabhlUR8i0ZLK5aj0zQlC8gXkISpDtgo2IWc/QgM0O/drch7kNBh
	Ic/+G7Ucs/zc7X6jeghiuySav73rnnSD5sUXX1bQjvXEPyyruFn7sPI+dsxDujrakwPm1Mz39ce
	r4kN4EMQSlfeTkwwFZ61BEz8Tf0yoUO5Px5WYWzvOAcvUp/jeswQP1AAhWxpzcJOOw+wBScvhbY
	IjqO0Rjo3fgnFm1+Kq8Up/Q6pDu8NKx50aq3TP53Jelm7iMBdRx
X-Received: by 2002:a05:690e:150f:b0:672:f58f:b9c9 with SMTP id 956f58d0204a3-6755d6d493emr1908840d50.59.1790693968424;
        Tue, 29 Sep 2026 07:59:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a861067e69sm59156497b3.45.2026.09.29.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:59:27 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:59:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>
Message-ID: <willemdebruijn.kernel.1ff30a3b3a072@gmail.com>
In-Reply-To: <20260929040122.1968641-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-2-wang.zhan@smartx.com>
 <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
 <20260929040122.1968641-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 1/5] net: core: use the packet's L3 protocol
 for the GSO size limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Mon, 28 Sep 2026 19:36:01 -0400 Willem de Bruijn wrote:
> > If netif_get_gso_max_size needs to inspect the result from
> > vlan_get_protocol, call it inside that function directly? More robust
> > and a one line change.
> 
> Or we can move it to dev.c, only one caller in-tree (before this series).

Nice. Yeah that works.
