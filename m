Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003769;
	b=3ZzmlPPcdHUsYXmlhgiI/9JosZmDoVWDAtpYnjNdS/esaEpTYLcs6KsgK9IhniTn5nrI
	 9D80lAGK+9f9yr1YiRUJrlLtB79k/AOM9wJmaEO+oRdo8oG/WT0QvFblZWgeL/oQamrXy
	 LutsPQ9eHmIPwFiTJaZJXRqm8mHTeL6ZFJBk0QnaRAouvRGUMEDAR3JIY3l0b4ZySJzNn
	 Fqlnq8mUi5PTslx7Y5juU44gyRE7JgLsuV8yx1udM8Bx4B9K/2GvXiPaCvJ5B5hjwtIgD
	 2iChpMWKnLUmEtP4KDL+Hlgk9ONAisESL1e1sTx0GFakIgAOCJI65cnDJjBZw6fSipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=pGix9wDnfmXvLJ0u/zilNWpGlgDLRWrAE8dxSLfPGs0=;
	b=nuN6D9aWk/x2Et6DanOkKtFDJESBGysGUMfx0fNKwVO/wRohbObgANWGTUkfbyrx/RD4
	 sdWkaiA4sbVVYhwion3OZkVWiXfCv03YpLpiOv2m1kEEBSp5qNJvdL00iJYzIuyHPtunD
	 BBmsVPQdfvN8M27+GvjUMMkFpDyUn0LUjrhTQaO10ROTOZxBXsCZOu7cdCHMMEJtEcqbX
	 HNTW3sdjB0Fueq+ayfmwR0p/sZ3rVgPabLucJ8DWPR4cXCcKI+UjyexhWSu/XDEd1OhTG
	 YO3RqcXPat0Kupu9NjDLdXG03BziV10ay22us8DKGRkmwH66N8NwlqEUpT3pIarWzaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bbXhkVFO;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09D606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B09D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bbXhkVFO
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so351952eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794003768; x=1794608568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGix9wDnfmXvLJ0u/zilNWpGlgDLRWrAE8dxSLfPGs0=;
        b=bbXhkVFO2CR8FKQjf8f7WB0KuDK3v1ANl/JoPZKnZ5rpzVaeGT5RyUpjpemk6sloC5
         kP4UQDOEvPw8aS30DevMDZkRiPARoFgYxMScMN+E/NOT2UqgYfFQt+5LqyzW2sQ2DYMD
         KGLMYSerjYDhMflq3JQ1NxOcR/yt8l8Y7IZEQdLW09tCIwlFHCzfLDZXbR5GnyOi+icx
         zPLemJYwKMXIO3OfzCWC5mOBnnHwmyV1fXtD2LW1Z6W3MdrqB1FtB1m5/yVGlT+OO5Sc
         WoYNZM+Zyd+TGrMr/x9byS2a/9GEo/HHjQmR/qRzgUNQk/5cMTw1XNgbbKKbognRG7Lx
         fPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003768; x=1794608568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pGix9wDnfmXvLJ0u/zilNWpGlgDLRWrAE8dxSLfPGs0=;
        b=0lJkZUIgfpSaL0BwwPA66ysCvYDpUFMuc4aScHVgIQ0eTKAezR8fxn1QdY8l3aFN8x
         5RahD0ZJ+Alu6po0S6ucXyZzANa1ZjQF1E3oQBmXfgNc+2cQgB9ilwgOJleAsybcaRqS
         DRSTCieSv6RlcGiMlwAnJ6I8RIcAjlvyCf9GIgBczsDyS4n7ISgOwJPrBM+WhpEaeLsS
         CQHY63oZxi83oU9x6YMLZkShoh8aHO6SDrhUOn+ws0AIy9+yJwB0xXvtW6uEGjT7d6J/
         GTwcQwMzJQm0JCKbrk51c7qeDQEkQMX0ZmwFLNn9TKOzR0nTS2mMTtiewY9ySTYsoRi2
         zMQA==
X-Forwarded-Encrypted: i=1; AL+hErF7oGCdnpwig3viPhhXaBuHRI+7Ckj+cFaQpKO4qjmayBbmNG7fl2bpJB89ZSj2gs7y2zn8E5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z805TwJ/VitM/gSG0WqIUHcW2xlOoYEHsQZaV+YNnPODlA1ZOua
	ztcccTq1h7+djvBot4tT6lwe91YsIN9FagF8bm1QTLEnyAAuQL74voHs
X-Gm-Gg: AYBFou0+HXqyg8RaEZQsQwAjKYNypY0dTryzUBqv+VKpP0uF3gpY6TQsfHY5mMGM6Tt
	UaMbEMrINSt8bq2YPKzL0l6ve0BwVHsVsK567gJveKbNMFSR/aYzQDz9KK7rixRxXYhZTUxAQ7N
	p/UGz2XVyd+NvhxXBceQ6Q2zAAZjjcU99PkCBTqIIuGMu/3s8/3U1K00YKREaiNr8ssBmMGzW6L
	9PBL0ANrS080sHSOQ8K7vxMc+xlIj8rHEYfu6qOXL1sBxEz21PBsv/AIMnJEGjpc6Vvw9bgjb8g
	up6zddZ4zdYbwU/ZfXO6m6LYMM/fvkZ/BQQug/s4kH1k1ElqD9O3ENS1/8A00IBNu3Qh+tQX9uA
	hUsoFAsurCYVE64zkBaUith56uNs8Gfc8bcxiw/l4BTbkbI4eJnFU3XmCayqA/CJL4KgYfMNpC9
	04dVRPAxHTdUwk+7KSW8E3QfEuBfAIst+pQJa+YetPd5QkXNjdckWEq63IGMSVSUevKNpHV0AST
	uVgCtA22diGmwZqU9b3vcVgRuLvjWCbdcaRwM4KPQE2b7sNl5x7PRo2p0ImbHi3D3ddg9fJZ9eG
	GTwIHuvjN2nwWJzFVrabcg==
X-Received: by 2002:a05:7300:4fa6:b0:36e:e349:f2cb with SMTP id 5a478bee46e88-36fb6a9164dmr4235055eec.19.1794003768057;
        Fri, 06 Nov 2026 14:22:48 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm12198327eec.19.2026.11.06.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:22:47 -0800 (PST)
Date: Fri, 6 Nov 2026 14:22:43 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
Message-ID: <au5SPWdVCuso8Esq@devvm16445.scu0.facebook.com>
References: <20261104042521.3979880-1-almasrymina@google.com>
 <20261104042521.3979880-3-almasrymina@google.com>
 <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
 <CAHS8izNrM+iaT6OOJVoZdVp00TkNRhFe9ucCVrwaUWL0oQS7Ow@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNrM+iaT6OOJVoZdVp00TkNRhFe9ucCVrwaUWL0oQS7Ow@mail.gmail.com>

On 11/06, Mina Almasry wrote:
> On Thu, Nov 5, 2026 at 8:59 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > +static inline void *skb_net_iov_provider(const struct sk_buff *skb)
> > > +{
> > > +     struct net_iov *niov;
> > > +
> >
> > [..]
> >
> > > +     if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> > > +             return NULL;
> >
> > (a few nits/questions)
> >
> > Why !skb_has_net_iovs is not enough? (and if !nr_frags is required,
> > maybe fold it into skb_has_net_iovs?)
> >
> 
> Well skb_has_net_iovs only checks skb->unreadable, which is not
> actually enough. The skb doesn't necessarily have net_iovs if it's
> unreadable, it technically could be that it has no frags, right?
> 
> Technically we should never have the edge case where
> skb->unreadable==true && skb_shinfo->nr_frags==0, but I don't think
> the code is careful about that today, and I don't know that I want to
> do a global refactor everywhere we remove frags, which skb-> flags
> need to be updated.
> 
> but you're right that it can be folded.

Not sure I'm buying that, but happy to look again if you disagree. I think
the only way to make an skb unreadable right now is to add at least
one niov frag? Don't think this is (ever?) gonna change? What does
and unreadable skb without frags even means?
