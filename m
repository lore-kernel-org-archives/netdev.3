Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107352CCDB
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694133; cv=none; b=CwHfazylxnUwt9YZ3Khj/Um4+7MzIgs6FoAickmAwc2dfJ0YKOYmEX7YQ4nqXxGlt2ApkTdD0fq94cChj98LpwA+s63gIWOZRHVEBHs+5pIeDLxtE5z3D3xgCQIXUvv56HkQNYX6dpifxpU3sBRk4+TjXBANaER7Y4kK6+DlOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694133; c=relaxed/simple;
	bh=U8WJlmLvpLVPz1PhJ5Fa8xuXrb4x0AHUtwcNMW1YcOs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GuH3+wY5NOR7RkXXh3hHdwnzeLb3MI2+S2G2lNFLMZIfwemWiTBERdJ1NwjqW4InqJWo+roK/xE4L4CLO0rV2G25kMizze4IzIRQvXhBPqlJ+80CnRukfiV2zpFdkpcMhzTRdl0Qwz5AurmlaIcb3NFyC0oYuyL78+0UYMcOMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFndnbVj; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFndnbVj"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756acdc3a8so568359d50.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694119; x=1791298919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2cAifA2cu1OXX4O6SEFB3mL1uRR1VgkoChYEZDiKjsA=;
        b=XFndnbVj64/PHmvHOdCWnz2rEwVHj1Ic5hQCJ0nKynLQQxwbr5DuZwc9DBjgmXdMdI
         2azUVeAi7sMGzmsfsH47ivqLu2PQb5sMQBpt9K61KtgsjbKsEgG9/N/AeawQlny37m0q
         Yq7XLFjfMKOSS1B/VYIcSujPrmCV22yGhdrhvmY3q6zWGXPEUALId6Zq57W3cNOG7Ao3
         lZVt0MSrh0DTyYfEnqNjajN3DioL6yk1V9dG0HfbJPgTMTUqRtyic92ON026/2j9unAY
         WuaJhZWWxtRI4Z4uXkZoGsOFHz6vVHz9ms0imTAutYSxbzUbgKgVRnXH7KzPTUD+PvLu
         gFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694119; x=1791298919;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cAifA2cu1OXX4O6SEFB3mL1uRR1VgkoChYEZDiKjsA=;
        b=FQHdkfD+X7H761C7UprlwhD8eyF1Yg4FwW1iezYGCA5wTH6qPpxYrN2IKpAyM4fyO3
         4Zpu//OERM56Uunn+xfnOjqVDNJL+UgePMNiFZnZqMs/c/0fcD5hePaEIZ9ZbwP6ow9z
         jLjTAiq1g0wd9ZUGN+UpNaxgnXvCOAABsayJZ3rALne0b9PVxDOdJxFCdjjneqkLk6zh
         hYgaRApZpWiV12wuNlY0yML4/ZvzARA6I/DoS4ZlBk/Tirt4dE3HO3/3SDhIaAJOHpQC
         yw9vUstPaQdqSpxIGmkhAh16tT+tGxg/dR7i2yqGeEHdsiBQcBKQYsb/uFNGvxjtkTQQ
         9mLg==
X-Forwarded-Encrypted: i=1; AKwUvBznFI2oQA2ob/FdbMGR7ZXOJE4/OJjJstAGBQNyE16NNxY6nyB6X02Dq/3UJWaY2XqlkJjRjpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/yh9W/nfizwv8ITEm9pD9SHAm5bEfLTqEXJo9rF3cu2fZ5BZr
	lhQNxaILuByKapURbwKr6gr2d3sUugEcUQtmffFFW+vH2EgTFgi+YiAj
X-Gm-Gg: AYBFou3uPbNRqZ5BObfnErxAkXNgPus5wegERZMNYUR88LMIAqvgea7YbngeBUFXH5p
	n0Iyci1/97KKLBQvOn4G7IEasB1kbH06J4XJjBk7oeaoRMJ6ImMJL2WC8z43HiSdhh+dw3gEsZH
	jySskrK7nIPYjoXP/vWpYNDCQWxeHILF6exayKE8Dr0/Y4OghMTAHK1XGwOKoWeBEwIho89u1qZ
	8ucIa4ziKvV082ggxxw8bIHy0Ku0Up/qwFNc+Yw7OVg2szMamUJy+WcZ/Pv4LfWdX3Y7TqTyYzz
	VRts25isKwrf5ZhhR61HdaxQ+xWYu/MoO6VIMuYFH5fGA0H8duLB9tIfxoQcQIO9iuy1Lz2EPJC
	bHopWyOnUVikwRi46QVAZIT1LvjHjThRWZVtHQgDPRNlTqCef+brTN0Qleqml9b4/2zPgEPNg/I
	VBcE64vR1wvWo2JuAXhkBhVKnuxgvO2UNnIxqyM8PSYSWTL6SY3+FkqI6KuUlbCK4Alw2EodGJS
	WdRXP3b6Dso4kgcA/WBC8PuMybGQntI12R9RxA9P3lRokzvNYOOeS2jz4xSlro=
X-Received: by 2002:a05:690e:4852:10b0:66f:c24c:984f with SMTP id 956f58d0204a3-674111b2c88mr2774990d50.25.1790694117940;
        Tue, 29 Sep 2026 08:01:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-675b76e44e5sm71312d50.15.2026.09.29.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:01:57 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:01:56 -0400
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
Message-ID: <willemdebruijn.kernel.3b6c39ab87f82@gmail.com>
In-Reply-To: <20260929103008.2006188-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-6-wang.zhan@smartx.com>
 <willemdebruijn.kernel.3638f2d1c29b1@gmail.com>
 <20260929103008.2006188-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 5/5] net: net_test: add tests for bounded GSO
 segmentation
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
> On Mon, 28 Sep 2026 19:59:54 -0400 Willem de Bruijn wrote:
> > > +	GSO_TEST_BOUNDED,
> > > +	GSO_TEST_BOUNDED_MULTI,
> > > +	GSO_TEST_BOUNDED_ONE_MSS,
> >
> > nit: bound is not a helpful name for this feature.
> >
> > The default segments to a stream of skbs of MSS 1, so segmenting to
> > a stream of skbs larger MSS to me is not bounding. Quite the opposite.
> >
> > Not a comment only about this test patch.
> >
> > Perhaps partial or re-segmentation better captures it.
> 
> Agreed.  I think re-segmentation is descriptive enough.  Partial is
> already for NETIF_F_GSO_PARTIAL.

Come to think of it, that may have always been the intention of partial?
Segment, but not yet fully.

Technically this would more be pre-segment than resegment.

Anyway, I don't mean to bikeshed this and don't have a better name.
Either will do.
 
> > > +	{
> > > +		/*
> > > +		 * One MSS per skb is what the unbounded path produces, so a
> > > +		 * bound of a single segment must not change the output.
> > > +		 */
> >
> > so setting max_segs = 0 is equivalent to setting max_segs = 1.
> 
> Right.  The default is one MSS per skb, so 0 and 1 behave the same.
