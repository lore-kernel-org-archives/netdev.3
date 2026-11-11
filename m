Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439268;
	b=D4kiUgsQQ3x5nWlN2oZfsnS11UPZoM8ZugkeeekmRCBwL59GGnx52cYADTi+r+4aQk6a
	 E3k8kl5IQ0guiSuLVT0vvPaXdk/FJR/C28/NT5U0fvxExCC3s9LIllZ2/yDtthhnVuTGM
	 XgssjiPgCaF8nM53XGNBG6KhMiZtrsDYApgNhQ/GQNIxVuh5jqtYvz8VFCys1xO77AZnR
	 thaOwTaaHTuothKIpUASwtEH4nhzG2r0DFkcA/oLru8NbZ6emhSGd/C+vDbuuprh5jLp4
	 ZDvmVLRJQmOjntqkm8n5Ro6Lg1Z78hP6limuHgvMdGw3UGVI8s3nmWV7pDFnAhCFnUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=F43DNKKfhUAoEAOcfO/HFf7w3xTwpvN1c5+q7kJ/AJQ=;
	b=ADtHZVq3luOPeloMRYLwVGQjSI2JlDUxxkAiktyW3jiojRQcF9CuDq0t7UU3r3H0cIP8
	 e3ccngiaITe/cB6HbLY7fRngYnMKb79Z3VdiVVkmcePrgimmIIGn/kvw7NdwumHO6QwkO
	 1GtDqPzf/VnAZucRXGODujMaxadZGzMMBAzKnq1rY8YBRDxwlzhD/MuVffiGrHDb8fPMx
	 LnkQqA9/ZdW4+Wifz8cLY5EAj73IMlQLyjEAlaYAddAvOLiMl8Q4sflmmn6aaGcjRVc20
	 JzeDRecfO8/RnuR5XoqU5025RMFN9Gs3XeU50DV/QwEvqyxAfbe/1nN570yHOOPkc/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ntajgG;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1960A3808
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA1960A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ntajgG
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so2171579eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439267; x=1795044067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F43DNKKfhUAoEAOcfO/HFf7w3xTwpvN1c5+q7kJ/AJQ=;
        b=O0ntajgGNrfKFATlaSWgSLejjNVQgDjxhVsVSDttqGtq5aviS683LBngKpx4uv3XAj
         dDXGAMnqhsJSWt+XdWei6LCeTtI0eQn5Nl+kVt5xLA7YMoToNjUv3RXoZQnXBzmCAAon
         58HWQLnHa7Grvb7KMRM3cEQbiFQWgxyWzConOroVYW5bzGieZJD/P3DhTxaoXAjODtdB
         g8pGGYhCkd+NRGJqXJU/6bLHnDl0nv1mZ9iVzHlkbKadEUNRBQGHmA6oJ1OCXi/IwLID
         e7Vg3qQ2RpyRtzo25N8hBpRXogew+6Y7BNCYMMxSdgjwXmY/3cPgCHBTPC3v80B5QRTi
         7uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439267; x=1795044067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F43DNKKfhUAoEAOcfO/HFf7w3xTwpvN1c5+q7kJ/AJQ=;
        b=u6cqYe2ypwXpMp20iKr19HKkA6RYOGUv/ZLrNQJ95/bWBbyCWPPjN6TR2XjDyfckz8
         4BL60sNxMQjaDiv9yo+t8b2ZAC4uvSxZp8+pIGkdyQrm9GqoWN0smioeLKqYljOQGneb
         NOZygyiYTaVyLonmvOk9KvK+qp3kKYZxOmgpDGvhfYbFwNvd+1HjBSb34rFy+hNBLcSg
         wKPC/1em4sdyFz0CRaZw+/+Pgr5kknOYIEcm4f2W7adzyxbvoqOlLW4Z59cfdtURr1gv
         9A7dG7IuVAhwvg78uvX8fZ8aAvDZpVXlbS6/Pp8M9DhysrAYsT5JQu7LouzlytgLMVS3
         cOaQ==
X-Forwarded-Encrypted: i=1; AL+hErEqYG+RV8nK/3xusAjauvj9ygc8TeIucNBXZsfcx+9scBXsWxfPlM+nvkI2L7thEr+YiLamzxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z809AXfSlpwE4apGjO5rTIp+4wIaIa74S5DouvPhv+Lef7wqHRE
	Fle+rl4ejg+pGVVS4v2YyVeGlXL9PMrLKIemTZQ+NBeURbSQaDfgcN4M
X-Gm-Gg: AYBFou3eKQ+gqqAl657tURR5LM0ONDI1jdeatd6A4SRR4ggdJfZ0MLmEo/meiCQnUYu
	AGUydQOtRkK1XLY6Xh1Mi8x13mMa8Y2LoDhbAncQVXuxZaipVftIqRH4kshwdhTpkpGoHRh9W0N
	xSfiDyWdLOznmkUw5a3B/L6xE9rnVMYgbvfU+gF6xhMwJxhkwTAsoSDJu1GSOXN4wkIGrAfWZ/M
	WXtWwE1vYh7TM2h0AGkzxumCiaiMjfeoLUwcRWyXbPgXYGV0WMa+xSsVtPXDebnsxcPKYk3gwxk
	jkTlTNlLpqMvRP+vR094OlIsnjU11v/YwKcWrJzMM3QUxdAdc7cG+i5EM9GUsNX/ptCFwozNwgO
	do/Ws8+yx7N1ohPvq58qogMe2fR40icB3eEmd/3B6Y8Rhx12EPQWAogIucC64BjKd0NqUywilFS
	zYFp/kxT5WSZ5D1CiN5Gvy/JSUU2ieQH0oX+r35GgZ9qAE5mwQSdnGyWRM+nLfuudHXUD7sduI5
	6rSsfBnNbP1INzd0w/kNKIXGuij87gzr3/b6UvWPv9jM+uPlFajDbu4G45froiizBjCBXfgnKq7
	eirbFdmkQ9o1f/833Tmi1xIOFpC3Tcg4AOFPgLokz01kiw==
X-Received: by 2002:a05:7300:6dac:b0:36f:4981:da16 with SMTP id 5a478bee46e88-37686754f0cmr6158044eec.25.1794439265724;
        Wed, 11 Nov 2026 15:21:05 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm19142236eec.11.2026.11.11.15.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:21:05 -0800 (PST)
Date: Wed, 11 Nov 2026 15:13:02 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
Message-ID: <avT2Fj5qjbJkArpg@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-7-bjorn@kernel.org>
 <avOtxBw_grmuDJae@devvm16445.scu0.facebook.com>
 <87tslnrwgt.fsf@all.your.base.are.belong.to.us>
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
In-Reply-To: <87tslnrwgt.fsf@all.your.base.are.belong.to.us>

On 11/11, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/10, Björn Töpel wrote:
> 
> >> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> >> index 989120cbf452..ca12cbf7b825 100644
> >> --- a/include/net/netdev_rx_queue.h
> >> +++ b/include/net/netdev_rx_queue.h
> >> @@ -33,6 +33,12 @@ struct netdev_rx_queue {
> >>  	struct pp_memory_provider_params mp_params;
> >>  	/* stamps the page pools of each queue allocation */
> >>  	u32				mp_gen;
> >> +	/* NAPI of the running queue, for memory provider wakeups. Set while
> >> +	 * mp_armed, and if the provider has a refill_done op. Written under
> >> +	 * the ops lock, read under RCU, see netif_mp_wake().
> >> +	 */
> >> +	struct napi_struct __rcu	*mp_napi;
> >> +	bool				mp_armed;
> >
> > The comment should explain why mp_napi != napi? (I do not understand why)
> 
> Fair. It's the same NAPI, with other rules. napi is the driver's
> association: read under the ops lock, and not cleared when the NAPI is
> deleted. Provider wakeups run without that lock, from socket syscalls
> and ->release_netmem().
> 
> mp_napi is an RCU copy, set only while the device is up and the queue
> isn't restarting, for providers with ->refill_done(). netif_napi_del()
> clears it before its grace period. Setting it also schedules the NAPI
> once, which replays wakeups lost while the queue was stopped. I'll put
> that in the comment.

And all this only to make sure that we are not recycling something from
the old pp into the new one? And reworking existing pointer to change/update
its lifetime is not gonna do it?
