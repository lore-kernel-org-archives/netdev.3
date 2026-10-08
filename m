Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C083B14B2
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484708; cv=none; b=qGkzuspFumZMLYNO/oeJL+GhlndAG7aeSnNiLEEDm36rYwbZUdJnC+Xl9tHSPIeeZ+/+LaQfhbl/12Ezl1KfVe7KPUwD5Os38XkeKdX/Ht1g9tv0Z9Z/mIKdw5c5MBsvr9FEL9BEgB3k9PrLKJPjYIQmANECe4ZKJJ4T7qYe1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484708; c=relaxed/simple;
	bh=m2ewrPoHwizBBGqZ1VX05AaqtRPFHf0B2gzpKKDpFhM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mywVpxvayERG41wbm/X30TxsZAPd1ATsTw1ckPb8OohIJy+fGlvEuNfe+7eiEh1T0sz09t9i3n5ZP5k2tEkvo52IPevuUvY6rJQhiOcHfTKItdxXobC3uqSfnCjFueMsOlAFowKUPDHtkshiQhEVyVZuyXrN8khtLGud/kuMEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXngj5ko; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXngj5ko"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b06c0794cfso17365507b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791484704; x=1792089504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=57HsZIaZxrcnuC+WZ3zUBlBNZxj4v8H8RKQoAORIJy8=;
        b=KXngj5koVU2yj5XFJiA1vpRVxcm8wn4dKCpeF6ygfkzXo5ix7W5kHtX/GKGAYbVlS2
         w3rGXtXBQQRSqEfyWtzKbfKvsI3hhMySLmuTrrB4phjPn3RoRnkg14gSdTLB9B+iz7Bx
         YhsvOSm968yyIN0cZkmsEAS2rm1EB30WemfpxGmptpiHoaaLTxXd5P/mbPOJBFahNukt
         WddrCwy8CV4rnS1UoylNbig6Chio+5gstDqbdXELvip18k5ppFzFDusN5wz46SEI6+py
         Ee/ooKAWFJqxjtD0i7KILWDd02v6dPnVlI5sL6Nu/9plnfuE8VsoZjl2G1jlHnFNpkVu
         ppaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484704; x=1792089504;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57HsZIaZxrcnuC+WZ3zUBlBNZxj4v8H8RKQoAORIJy8=;
        b=DpcCzNCBBDH9tO1mjMqIR5P25/trJMO7R1KY6BodeKkSMB4lRv4K/Y3bTtj+7JEz4t
         gIyHLv6q+QuisOv0tcwUoN1TgcnuwStE9zsRBhDEDhQqohC57e87IJhrdRhhjLt6/bSF
         RnzUi7yg3GTJ+lYFSxHrELn/gFRHj6HblQInvBBjHX4bgqqozoGjADzw67c2Jz8ne266
         +2jIPBU9z+Ctm48L9kvrcJMXAxFwkNhdnCk3/cL2vOUmkzTqGMZEsshnSWxWggX3NB9G
         Lbqm1UaKGue6viR+g8VPxnHSdaKFaDOy5NZfPSx3RxKpAMmYZz0WAbl3HY/0xF/N/2Jv
         TA+g==
X-Forwarded-Encrypted: i=1; AKwUvBzqVFRJsIxs5FHRWPh/7Hrdj/d0ijAVX9U09R9h05+1CLUNO9R8FpYGtWMT9xzvYvpS36nDY3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgpDXDqdZDo2zGWvMCJMgZkKZTOWUafRauc37BFWCsH4ZObUBl
	wnVuoloj44jZlqM1nRAeu9ALSbgHh+HskIfC7DsIjy1YRC34aSobhLWL
X-Gm-Gg: AYBFou261vzxE5Ff+RiNyAaQ2RYFcajlwNhdFWfXR/SZohFm4gGUisZaEf0gorSnwNG
	8yMzByFXTZ0vnQPYfxW0ahBXkyDmKOzvFiXOcgc19dXImDbo+Sxt2nn7OGYg4EbKIv29T+KXtRj
	7yKaQ4aC9Igo6detDkzai5dwzWmext0iT0j2FDOa1JG6ulVeJc9C1SodN1XO0oXmOJFgGypX9/r
	Acx30/dSTByfU/PWfRYgbapc40ddN9htQ/cpMDf77YOqThgcQh26fIyuBIg6VvU2UAzIBkEh58X
	/O0iokAtgxZltCv3GCnRJvKBaoFj8s2H7sHgyZqu9SWp2tLO7nNKJjDXsBVlTaCzYajScyH+zgC
	3JmyHHHC1Tc68k6aAInTHgmvos6YSQruIe0ODM/8Rw3htzHcqR5Th2ElOfRCgBKaLL6ZDBEVuMj
	32x1MIr/kvXDJeyXXd6SZ+DdLxa63uHYwzLxqCErm/0sCdLW7FVzOUfxXtsERW3wLw/FLMtiOBQ
	H6EArUH9zNQv7LKfwxdQCTrARJaRJIg2K+7NN5OkjEV3f0Dc5i4AS/rzfhP6MMzsWvWWTjjPBv+
	x9K7SXTaoKWw5092VJQ2wQkWNWJDeuGv9qRbPrIkIR8PSdLs
X-Received: by 2002:a05:690c:6d81:b0:874:894:9a52 with SMTP id 00721157ae682-8b05b03d384mr42795497b3.40.1791484703943;
        Thu, 08 Oct 2026 11:38:23 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07d351d14sm189097b3.2.2026.10.08.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:38:23 -0700 (PDT)
Date: Thu, 08 Oct 2026 14:38:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.36b1499061092@gmail.com>
In-Reply-To: <20261008100651.2534957-7-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
 <20261008100651.2534957-7-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v5 6/6] net: net_test: add tests for TCP
 re-segmentation
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
> The GSO engine can now be asked to group several MSS segments into one
> output skb, which is what re-segmentation needs.  Add KUnit coverage for
> the max_segs parameter.
> 
> The parameterized GSO test gains a max_segs input and four cases: a limit
> of two MSS applied to a 3003 byte and to a 5003 byte payload, a tail which
> holds one MSS and is therefore not a GSO skb, and a max_segs of one MSS
> which must leave the output unchanged.  It drives skb_segment() directly,
> because the synthetic protocol it uses has no gso_segment callback.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
