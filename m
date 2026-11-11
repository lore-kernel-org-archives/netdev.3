Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433936;
	b=WXRCdT55YEbVxCyufue6de5W37bhAKtmaFjRnNTudbjnz83lMqp+w3gAO+CwHkI+KKJc
	 JsLubyJrT9emX4XI7+I/orczOWz0b5C529n4pszD0juhR3EnhmTnY91jZGAVyRuIFtJ6f
	 41yHDXtCBafHExyVMadSmIZo2CJv3XQqTlnxptvOHIBf5zW1eX4e2eXM1YbsMINiU6IFs
	 p++YE6tFpW/Dhzl7ryIHVyH/XydHnH4owf98nQfCWG4hp71KSTfnJXdvOg6GjDqS4oQap
	 FYdwClPU+DJmwaXgGihBM9r1lKFVzgt4Man5VJVbcOW00/diOpO185XwIjXh798TUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Gi11Qvl77A7lJFoMQdONv82mizaQFstGPpmtJnQoYZ4=;
	b=mMvS/RSlloAjtxaiVvoIxHCBDc8YkDOO+3ltaAjBCLyr+8HZbmrlogsqjX91amxeLvyM
	 7mvvUYRoyag7mZYAHEX9PzMraPfmsEZpCt1gos8CWiJw0E7CgchzcBgHLyggEvYrYtT+m
	 3gJ0juWHajcPjI78vB8Hht7dhMXSy5zd4cf3+vr3RaFZE4DErlTjUkIkiB19qD7xoh+wK
	 Z1AVmBs79YL8UqaxMLRoH7hxo6+OmAF/joWWlzJ0ybSGAgBkDxTmGWuqBspP6sLQkJzk+
	 4eQyR4dectYjBN1395FjaFzXjI8xPG2a3HX7bm4mUipa/cXaTio/a5EPioQ0HrCx3Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVadYj45;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF9606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 21:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVadYj45
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so1362004eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794433935; x=1795038735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gi11Qvl77A7lJFoMQdONv82mizaQFstGPpmtJnQoYZ4=;
        b=LVadYj452qYWKXqudUfJYP4vTIXJJ1dd3U7RzKuzs6NI9h1XPCVOlLH2NMyOw/fSpE
         a88EhfciP9x3tgYLLbGHfZo127HjqFmkiin6KdIsTfgtrTwkMzRTwMGranMmPEkRP4af
         1fgYgf7SIEfRGRKqH/+rnq1nmaqMdDGChDU/8bSAhmdWZvQmWYxe9hk/nKnyh+hUXQpS
         RuZz/rfJupbQipvOUhYUOt4z/uqT3MMyj4Fxlml3BRqUtntjB8kfTsiEqHI2gsRKou6J
         mzatv8neNrpup03S/lOw+mLiQnIi5+xiU0V2Sh/BMvr0RUOSPeWmUcV0x7Pv860pKpje
         f9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433935; x=1795038735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gi11Qvl77A7lJFoMQdONv82mizaQFstGPpmtJnQoYZ4=;
        b=it7iJREbleh8QA0CirbihlxEM12HWVpbILug1XeJGs6Oj5mFmei3BTXOzsMsPZw689
         WZq/CKxGFDs6ZDJZwtxVWX1vSiXZ1e3aNzeY8KLo/EnnIg1dtfEQdlnW/C1pDY7WxDZC
         Vqr6qizhwyTa6Yn1ZVMGchSHuxBEeQSVrNRw9Nm7NNeZpP4lpdpqZNpevnq66oa3cCvA
         HVbeX8eL+Ab8sv7+BF34R3eSSY/CDAUaMSuoYVpHN68D/EAYH8gEr7RmXlJWvgyzGdwo
         7NrwKemu3aXtxjQUQ06IQG0E6rXr8gwMxHyFK/iB3VQtTF/f+z5Up4vZJGm5M32NJ/EW
         XWWQ==
X-Gm-Message-State: APuU4Z/atUERS6pBKVJnGhmnsmr14oKfYbr+tMnqG/E1WqKaO/rORiWv
	+x2X0QZEXYCdmSBPIp+RYXOiLPSE6s7lc9vLBiOZcJbOBLTlZrgdjuEb
X-Gm-Gg: AYBFou1Wtvd8+VbYtXkxuSCTQd4OgtSPuPK105SSAFnDhBzRG5ooilS7xaz4osyxCWQ
	NxbrvPjuLT74Ccq3JAJnDfC37GqMqHF0gsuxRIcHu9gDcHHdw/9HM4FQr9j9YS7jtyU2u7Gds2H
	H45RkBFv5JN6oNnLSSR7OPqfwD8WArvwgApCh08j5QMeSoiO4fexB7fzpO2eM1QM2VcdvwEl7GN
	xTtOHXpVI6K3hw+XLz+iAPilA49Xvi8TR7HKAQ41SjU3WGEfiz0iEtFVI0t2ygnbIGQlzDL9oso
	cF3lbsVSdv0NPQiNvnXsJjux6oPU+l42Py+A3JBOAjxBiodfAnpZPUXekmF+TLusC1sYxBNRAhQ
	vXnc3MHFBDjDStzfKALNmVZ7+kIDE8yT+hYtZncoWKDGkFOFvJ6LiRe0pc7ojZS9GUpfoh4VT3n
	wCj+1Cmkfb/gSFhbZauPDnXSoAY+DGjmfK6QRgp+NKxtxoy7VRSKF42ouQpFG2wE9X1CQbrwnzR
	QFshrJMX2kcc3eAtKVy++V0pmJ5Q76Lq8k3lnoA9R38lUR4U1qCKpAZlWSIA/pF5rF9sUySBcyT
	fx5+xLd3Sa8sv2OMA8n5Vpk=
X-Received: by 2002:a05:693c:894c:20b0:36d:5102:9974 with SMTP id 5a478bee46e88-3768327e7ccmr4031936eec.2.1794433934007;
        Wed, 11 Nov 2026 13:52:14 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:44::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm38761082eec.16.2026.11.11.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:52:13 -0800 (PST)
Date: Wed, 11 Nov 2026 13:50:20 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, horms@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com, sdf@fomichev.me, 
	dimitri.daskalakis1@gmail.com, almasrymina@google.com, dtatulea@nvidia.com, 
	bobbyeshleman@meta.com, asml.silence@gmail.com, daniel@iogearbox.net, 
	razor@blackwall.org, leitao@debian.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	leon@kernel.org, narcisav.kernel@gmail.com
Subject: Re: [PATCH net-next v3 4/9] net: devmem: add a per-device netmem TX
 frag size limit
Message-ID: <avTiZVzjvMLQjnJ1@devvm16445.scu0.facebook.com>
References: <20261105222058.944293-1-sdf@fomichev.me>
 <20261105222058.944293-5-sdf@fomichev.me>
 <20261110143615.05f9adbd@kernel.org>
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
In-Reply-To: <20261110143615.05f9adbd@kernel.org>

On 11/10, Jakub Kicinski wrote:
> On Thu,  5 Nov 2026 14:20:53 -0800 Stanislav Fomichev wrote:
> > Devmem TX frags are bounded only by the net_iov size, which is about
> > to grow up to 2MB, more than some devices can describe in a single TX
> > descriptor.
> 
> How is this different than normal zerocopy Tx?
> Drivers already have to deal with long frags.
> Having partially applicable limit seems like a bad idea.

Thanks for the pointers. Yes, looks like I can drop all this per-frag
enforcement. But bnxt is still broken with bigtcp, will try to hack
on something separately (queue stats/etc to make it actually run tso.py)..

CC'd Narcisa (synced offline), unless your priorities change and you get
there first (or I get carried away by something else)..
