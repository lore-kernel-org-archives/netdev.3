Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227623;
	b=I2j2Wo87tjZ3plmBKo1brY9Fr4XkE7INk/35XNsb7ZO4muHxSrGbjKy/fF7OZFeggTnO
	 QDF3qbUWyyQYiJwZm+PyzPCJN1pX1rQLLfaGo8YHtTZcgFG8A74LYjUsDMoisIi4c884c
	 DEdTBIbslDvSusoNWLbf10fgf4RxIZtnzl4g7jgf/JlrHtXtbWg5oY55o7Qy+8UO/cMrw
	 CwCylUg7o1t3IiFPZihJZv1LYZVGq6JXuY16Dffzi/qJh20LCe3KfaD58YBdNQYSZsBtL
	 dTQN7TdyS+vZG79E1/ZQfTrfzqP8/lQTcTSF2Z+b7tUdm6hl1hfUxtpLGDkUJYHchfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227623;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2JV1b4sF9Bv6mNizFqSbv38ZX8zLnn64bzrFb3DOKnc=;
	b=YiAFOWzHBwn8bHOapRi3cwUBDYxBtZuODmp2EDp2W9T4C7G//RjbLBy7qrkMeop5XWtA
	 OkKyZZRCF9DxcbnlexLLZS9j9v+O0l77WF5AYmFokGxn3WLEq46Mf5FvDASPn5bRpKbI+
	 3jZKwk/O5hKuI24OMwsY3ObmkoHWRRc6i8ay6OgZRlVzOU5AHO5MdZrP+OGMJBvyBBe1k
	 oQmNOI/cbTNJEOUQRjb8RyDXOtVwONMBvcFf3gSEGmsABPEwVEbc7SfckNM5tG8u7B99i
	 TEUfvqsjMtE7xetyxgo8knZcEQwRw/uRhX+gAt38bHEgwFWBKNAmYfnA2mjJI15LKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48150606D803
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48150606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67be6030c9fso556219d50.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227622; x=1794832422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JV1b4sF9Bv6mNizFqSbv38ZX8zLnn64bzrFb3DOKnc=;
        b=do45c0T5IX8iIlacDaSv5sC/wMT5YVWsPhKIXTEArDqarYJ4uEqBdW0JytB7X1xVGt
         x6XtLdqAGzy8DX3KGqCiPYipuwYn62nFDIDHRBDleHLOntnHjfvcdeCmpZ9snGDJLkbr
         M195muh9aC2U++740dssRRtC/pWXGkZ+z3M6ZiugNo1mqs4gsb8ogT1a0tRjXYT+sfj9
         nwEy0lNyIiCCfxCBS5+YB5HFZHQ7WIULfEsYQSDTAFs/QuDgKK+gI31Ie6vYxs+hJdXt
         pQDSog2By9/PwE60U6x3oRqmOrv/9SNjwOwUZ4B1+6M+U8pWZxqOpjvmvQuTPxnI2Osc
         ONRQ==
X-Forwarded-Encrypted: i=1; AL+hErHDenNf5So7TpgKv96fr98pav6RXOat5Sy94i2ydJxEN5ZE1PjoLSD8WOQGHHmFFWReZoqmPBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fkk7Lo9mMDMmK2lUjIMw7CWD9HupM3Fdwxyv8wJNvlGxIHk8X
	dGsfXCQnBvujhwja6BK6LAFTpqKtnBen9p7IpU9+CkD9yVC/QAwXgYFZ
X-Gm-Gg: AYBFou2U11CizOAZEfD2wx416W1OBSuBTLQBgf4ls4h9HUiKrRrk0dceclT3a8+9vzy
	puI5KESJGw92NlJbAHvBZLeyGAVTMAoTWNiNDC1KlBqoI1b0Gyt2bsY+VQfcPaetpdIPoIocpHP
	pyVl9ilao6WAkJlCd1J3nfFW6FjuOOci97EMhAmgTPb3HsA22OJ6aRl8melRM2tf3tP2SYPPuG9
	BNwFmCWxtlM9EKHjcWRMfUgH5/wB32GZkgaObU+DypWYh7PdMI35OVToSgtYDZg8XyxwR/09ITf
	vB3IbIWbhzMVms3vgHcD3983rk2Ac9MQwyhKkJmNrq4oyptodDkXYliTsqdt7jIdN1ie/SLJLL1
	L25TzDxnTV0B8xbgJevxCDh4jGduahlkUEUVhtYwiHAFfhfVRVcaBJYjmM4ZpkcItBeLN6QYgbn
	o9IFVzq/fpm3o9yTt6KLk8nIsCPpOvDsoCFSXUiVV9Oxh3bajX5qMXWmPLJoZtz0bGi7KPaljXo
	bPvaR28Ih5OMNUtHNTLzUZA7Zx6awYBCLH4oufde0zI5ACdUTzQl6Qc8Ur5Fr2z44vVMF40d/9/
	Di2oupr4Tt399faDWZc=
X-Received: by 2002:a05:690e:1442:b0:67c:175c:df66 with SMTP id 956f58d0204a3-67c3d963260mr2729393d50.36.1794227622290;
        Mon, 09 Nov 2026 04:33:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b93be27sm3766906d50.11.2026.11.09.04.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:33:41 -0800 (PST)
Date: Mon, 9 Nov 2026 04:33:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, acme@kernel.org, 
	netdev@vger.kernel.org, llvm@lists.linux.dev, ast@kernel.org, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <avG9bk0kxRUvonhD@gmail.com>
References: <au27Y9m78_3EH2v1@gmail.com>
 <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
 <au347UiVUe5oUuxM@gmail.com>
 <au4kpSGVSH3tYiZm@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au4kpSGVSH3tYiZm@google.com>

On Fri, Nov 06, 2026 at 07:05:25PM +0000, Kuniyuki Iwashima wrote:
> On Fri, 06 Nov 2026 07:58:01 -0800, Breno Leitao wrote:
> > On Fri, Nov 06, 2026 at 09:16:24PM +0800, Jiayuan Chen wrote:
> > > Thanks for the report !
> > > 
> > > 
> > > On 11/6/26 7:38 PM, Breno Leitao wrote:
> > > > My arm64 KCSAN builds of linux-next fail since next-20261015, because
> > > > bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
> > > >
> > > >   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
> > > >   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> > > >   Failed to generate BTF for vmlinux
> > > >   Try to disable CONFIG_DEBUG_INFO_BTF
> > > >   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> > > 
> > > 
> > > 
> > > Has pahole fixed this issue?
> > 
> > I don't think so, see the line below:
> 
> Could you try this ?

Thanks, it fixes my build. I tested it on top of pahole master (9eb594d)
with next-20261105 and clang 22.1.3:

 - arm64 KCSAN, CONFIG_WERROR=y: vmlinux links again,
   bpf_tcp_ops_set_rcvlowat() is back in BTF, __bpf_tcp_ops_init()
   returns 0, and progs/tcp_autolowat.c from the selftests loads.

 - It also brings back scx_bpf_tid_to_task() that was work arounded by
   tejun.

Feel free to add my "Tested-by: Breno Leitao <leitao@debian.org>" tag.

--breno
