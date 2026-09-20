Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADC334692
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909976; cv=none; b=N9VP9XD/+9Wt7bovnhZkm0kByUowdVAZZHDNGcZT8q+Jph9csSDtTnSAFUx9C/xarqWVyrJubeuQocC4e4wysmQ+c+44Q+bSQhWRMcPpnl+JuI8sMV+iUB26mYV8qHQZ4sWMNqEi3h4A/0G3LiAEoPoYRXUayi6p1mJ4BCEr9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909976; c=relaxed/simple;
	bh=P81vFRzTziy0k9cu0YlaeJP+frqBYKMEk4jXHmd6bps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjHKdfYgnMOHplmb1SciU0MxpoR8k+ejx+UShwk5ar57vyEbwF+FY/2EfIyU5Js2Hzh1dy+JJbGCZc8MkXqDruK8KuNM1SvR03lp4pVt0XdG7npfaQ5RENyhaROIRdcdM8fnWKpMDzxl7UlQl63iT7RGeGqc4P0l+U8tBIDQJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=WliibicP; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="WliibicP"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e59dca659so1404682a91.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789909964; x=1790514764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAU0COEqO65HvZJVod9cit0qQYNEvDlRCM0ilLlgPSI=;
        b=WliibicP/93TQKTqOx0Dc+h9ASY5ksp6VaGgslQL+018u+ptcCl1+e1znl/wjda09o
         3AZjWmjfKAIXwo1KhpkSPw502TM2d6frHv3N0nceTlfMZIyLqSHi+Nf+pq3OqZk/pk6I
         +u+LfWHsQ4EfGAojx/4BFycpDwMJHnqA4CpZZUuITFcHvDuyiJ3e+6b0RC3TbUCioOjI
         GG1bWwinLRGzcfrhxmK/gkHdOgRyGY6Sc5sAuSS+AxW6YujuelqbtL7C6EtNwikUzEAL
         dCCNkfvcWm6C94WmaMQgaLn5LxmkuJXDjCKjpRaMkMLVQ19Rtf0wzUUBvkFKqoMrEPpm
         i/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789909964; x=1790514764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UAU0COEqO65HvZJVod9cit0qQYNEvDlRCM0ilLlgPSI=;
        b=fgoXoFrypdRKsQ8gtVAi//VITXql/dJKrWZUGf8LaKPeKOgsVMzQCIyBLz/mJ6Guzh
         Rf2CvtW51ZP8OePjaMFJ9D5TIT0+gHTlAxY6f2IhoygUb6fsa2owpoy90qYAox1s4riD
         jxZLyXqMAg6DFiIp1nQcynAN+z/KsW+AcIOCxILx3kxLfeM7bjvuA7W1HxOACqw597Bj
         mlqHnx+Di/8E8lrk4iW5WEnC1gwfZdcVqEEe+cLY4TkmlRQ2d2eeYjCwxnarZrxPQ5r5
         U3Ab31gm9qSIb3GI46bGPDnxjZ8fgWO821nTXitPeY/U1Mfivs4kWe0Zyxgwj5A9ObdI
         K20Q==
X-Gm-Message-State: AFuF++lx3SLoFhmfZhkGEpHqyE1m1KBHiElg5cXOoNve6kVIV2caeS7h
	Q8P6LH0iFB8eEhYuggAL5QQO3XpjFo5Iy+xPBERAIYmufAleM5dkw6dp3/b3PAivyPfExy0X6bA
	YKQvXYghRaxuQcpVc7RSUcrHoDSE/EoJJz2oFLfGA4BaJuNGh2UN0hmwlK/IAByszo4Kf/0heCA
	xU44GU
X-Gm-Gg: AYBFou2yDD/oVrEEtOgv90qIJ1oi7NpQYEv4K5HqisgCSb0uOPt2lpT456E6rAXguQF
	Z6mYR4vJTF7/+QPGU/lbshux2ddhodnRxBcffJp12IhXGrPhIc2Z2qfLG/u17bsl0tIPuuZfoWM
	CTcPZaN0Kwofk/bcy8uTFqfbxTJ/sApxC3euYZDByNzg7+edLSkXqbMvrleOF4KyNkice/h9OZd
	RzS6vtyq0YPda8r1uy/IcfH2hM/MFCA767jU7SnaI4qYoyaQzTtBzrjUFrBzTuyjlA8tnNHgCA+
	niwA6PV4RFR7zXYCPsusi4l0Sl5RWisVwv4xAZHaLrYhXpeaQhTEMhDjzoob/DUh+3HwZdL38TN
	UHV0fbiYrt1CHWWrYB9sNQYZaKNPCFtwMMQBmnQ2v3AgMncbYZzObSDyARgfVq4myn5LFrzE9eO
	WsFzs/R8JRLGkGDVCG+57xSxPAYjux+/iKQXzhVdDCr4c4p7YU+/09PIrmnAB/XHnDM/XIlL8nN
	jQJUt36hZq9sNxx5/DgVQ==
X-Received: by 2002:a17:90b:1dc9:b0:39e:6c69:7775 with SMTP id 98e67ed59e1d1-39e6c697929mr7183662a91.30.1789909963236;
        Sun, 20 Sep 2026 06:12:43 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d53968afsm13327541c88.0.2026.09.20.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:12:42 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Sun, 20 Sep 2026 21:12:31 +0800
Message-ID: <20260920131231.3610688-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 11:35:17 -0400 Willem de Bruijn wrote:
> > -		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
> > +		struct sk_buff *segs;
> >  		struct sk_buff *next;
> > +		segs = __skb_gso_segment(skb, features, false, 0);
>
> irrelevant?

Not unrelated: with the extra argument that line is 82 columns, so the
initializer moved to its own line.  The call itself is unchanged.

> > +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
>
> could this be computed inside skb_segment, rather than having to be
> passed through SKB_GSO_CB. I haven't checked, but it would simplify.

I tried it: https://github.com/zwtop/linux/pull/3

It does read better, but whether to resegment is the caller's choice: the
qdiscs strip the GSO bits to get one packet per segment (sch_netem.c:443),
and a device-derived limit groups that output instead - which sch_netem then
drops, because skb_checksum_help() on the first segment rejects a GSO skb
(sch_netem.c:538, net/core/dev.c:3626).  The features cannot tell the two
cases apart either: gso_features_check() clears the same bits for an
over-limit skb (net/core/dev.c:3843).

So the bound stays an input from the caller.
