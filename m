Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381034;
	b=QtRAUil1bmTq+/JjtjPNdFhQzKbOpck+5L4MnfWlVX+Cor+3COnhPYev96N3MqpL0KJh
	 zebBEimRSJGyprTnzjoClnOh/fpoTepECEs4sKo+DspLEbdCTzWm0ybYs3fyTv6Y9xRIe
	 BJPnYTsFb8haDnV7MJNpQUmX9b/yUyBAb54uBLhj5i6XGC/g2bo5qSxMvVSKq+zvOb83f
	 tFBV+52stkS07NHkDMGyqC3ZYuSAxDnTfkBUQ3Tyb4P+j7mM1ZshdrvNhhRzTWBf6S6xP
	 UdmqQ4iLsvcL+Jp9CQdNzW147CYQV3m8iFG2azgsIdrblJPInCQ5D3h53FxNAfRXEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=S4N8TPIiWWlaffvzOsFOBPVAruHG0QeVKLuSe0btBn0=;
	b=2gk5hazyMCoUmXU7ZSowi7w1ZFnmOa8ukQSuiPaDFmaPIyoRsir5Wm+MTx59BTZc7Jw5
	 aTOwoXvg69UdLVpOxFZaLeDoV31ps3iSS3K9DGE43uIg1W58AUvHc95HXD7F2n2AxhDMc
	 MUfC0vQqLBc7B3htBM+qP84LrqnzeB/0n8++D/dy16GbUp1Q4wnG4xd+/na2GJ4vrs72r
	 ETp+vGiJE8uLhgVYz+Vf8LDVJ+ZsOqbJ6ccoZytdVQNmpBVLuioSVe8UGh204/c5168Lk
	 jcUH/ILoVlGtc8vbgsVFO+7gvFURuRqfagVf5KVALQxeBmRLUa1YfQjZpPcBq/vht/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTFGJS3v;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685D606A32D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4685D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTFGJS3v
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98c78660542so505963241.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381033; x=1793985833; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4N8TPIiWWlaffvzOsFOBPVAruHG0QeVKLuSe0btBn0=;
        b=YTFGJS3v3/aVDq4+r1W98vA45nFikeEjXo8wFlXjxvzYjHxAamD00S60pVWGMr9R3y
         beKrWCJ0qWberEkhh0bByA0ycVRgNqWu0BXG65KC49jPqu8l/cFFZrpkkV+9MBj4VHQ1
         O61QSrAJShl4k7wjoMoQ1FNNzdXfb74iQ07MncyhUPfD7s4DPxAxUeqM+pfxpISs5whx
         z5q8onutacRwRE4rfvaQ5OHAB3fShOZDjunP6yrM6o2KKw88204Xtlb9mTRzk6UVHtwM
         H40OuU0oD/eOv/Cn/JgfyqWl1gmwMfz4Wo3qRf8OgvOCp9iuwPhyN7cYbzO/uTLe9SxW
         1PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381033; x=1793985833;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4N8TPIiWWlaffvzOsFOBPVAruHG0QeVKLuSe0btBn0=;
        b=1gHpPlKCQzyOAeDPasJDEEwmCj5dc+vmKvrPADtUBtETb/TsRO1CBIMM7c3wwCbEZu
         +rFjc0DNBXi2vc7BYT0voGkeda2D9ZXE1rPuEW/sznjgkxBvnfcpc/XWUjHMhl0VkcgZ
         3N1n0kRGuJLAlpqfj7qcKj1RkN2Fd9J23UOZ6n2lV892SU/gc0gD0h/idg8eXwElqT5w
         fEsoB3CKaS01q0mlIp2EMkKaTt96OhABmp7/j+vaKwLr4mj+W/fbRij3Ci1Nm2u4nbPp
         VlDNLEbpm7OR+ujQHtsqY1eKUmarkn2eWKUtnC9t5ruiues4oBgL62B8yUYVAmOKoA5R
         YjYA==
X-Forwarded-Encrypted: i=1; AKwUvBy1O0hq3Hu+X+IWZJwxjBVyPICXYpDTo5p8keiYw3E0IBQ31iDSJyNSeidpF6zyjA6qEj1t+Ic=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM4L/+KW3Qn+d4hBULCbnTlm0oDg2v+XtEfDs3Tei66GP1Ne09
	ikrqtR2F/6QP6m+Sp9ni7lB4UPFt3EHIeiL+m7AOXmq8yyK3f9vom3NYMK5hnwkO
X-Gm-Gg: AYBFou1XMP5uOUZPDorP97IHZfYm4iPCCCawlUUx+a+BhTZTP1r9pI7oFKBzC/L8SDO
	y3F5UPD7emOH5dQQwO0DapmkUKtte++jWfSwPBk27pplUb6UM9nJ4H23YtdfBzY18y+QKIh496X
	TOw3yKUY+DZ+++eo4ugFA4B//OtSUAv+8hvOfUjyv1p4W2+YyPbTjD6cGncacy6aaLHLtGrSYiC
	fZZNOU8qOdmzyTskeiPo3OgfXI44g2tJqqSc9m/oW0oonU6l0kJMGmhkOUkmFPOBn+HNmJ9L5Nb
	MJi4c1UOA8euxXCMyYGVA7hDOlebd7hnVE3OmOnz0TeDY87J9YVfdw8rEe7H2oub8b6l0qIFhEf
	P9l1sFuaOOTrNn0NVxctVfza92r5nN2nJEDpggBjxFG22E25dzwCbji3FazzrPEmt/XAJm5Saxn
	CJ2FQVUA9hsPV0Xp0YLbBMcf/VO3wsJQehRzaCpZX6AhJ3nHV+zGgZI3cqiHd7gydxk8zdTH9+b
	O+FOXTnubM4XHsoSOe2hGaQzVqH3/criADId/dkFFzV50xf2VGbjvhCG12TP2Et8mJd/KzTiZYG
	BZPvb4KloFF5t+zb4CNQ+m1nOEkSe1+pSV2nXe+iirG0rwr1DvBwm6wHH54B96Pg8uuDpGwC5Y9
	bF6QsPN5n2Gev/vavWqBPb4rs5EuveNtMA5FdOTWpIlqAj75jDnj3vHLHEAXVwKqgnnM7cp0qiB
	TrywfEZJuPysaoPcg9+iO+xHu0DO0VjES/vpJeBSk=
X-Received: by 2002:a05:6102:8092:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d07279cd1amr1615059137.31.1793381033093;
        Fri, 30 Oct 2026 10:23:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:18:15f:b9ba:756b:b70a:a34a:8232])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1b4sm2990154137.4.2026.10.30.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:23:52 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Hangbin Liu <hangbin.liu@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
Date: Fri, 30 Oct 2026 14:23:45 -0300
Message-ID: <179338102577.65907.6165293008000000698@gmail.com>
In-Reply-To: <20261030001444.289973-1-omermetekaya0@gmail.com>
References: <20261030001444.289973-1-omermetekaya0@gmail.com>
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

On Fri, Oct 30, 2026, Ömer Mete Kaya wrote:
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.

I sent a fix for the same syzbot report a bit earlier, which only
deleted the leftover ports in nsim_dev_reload_destroy().  Rejecting
new_port once the reload has failed is the better fix, so please take
this one and drop mine.

I tested this patch on net/main (94cea342e891) on arm64 QEMU with KASAN,
running the syzbot C reproducer.  Without a fix it hits the WARNING in
bpf_offload_dev_destroy() and then a slab-use-after-free in
devlink_bus_name() through the leftover netdev; with this patch there
is no warning or KASAN report in 3 runs.

Tested-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
