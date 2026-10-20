Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792472112;
	b=UlfrKf5/tRKNVFHLoK2ipn9jwDpGQHXAFPuqTme0HBXtYec2EUO2ulitHWY6oa2yAmUM
	 XnhmwdciidzuCH7eLFeq80OJKS0ihAQimEWNxPRQI/oq+v1e6GoJ6ve53XV/NcFEJx4Pg
	 ZtwsjNQx+La+AD8OfkHpZBleWzE3Z3rOokUa9oKRwJdf92DKgoZ50p1Za/SPyRrsZHcmw
	 7ATmMHwfa36LYnUeGzhXvZs4R4vjsA+51Ng7ZGt6TswulLLGA4J5Gjm+IFB2Tt9pNUFfJ
	 BE2Gi76EWWSpJjrJL3Y8aQngkAK9rbsFPmXFeUnMDWQfHm+Lxq8r7D9KRVBNINf9kHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792472112;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JWmybeGplPkSTpFTj85ztkArMWjjQyueHRK8ugu3OPQ=;
	b=uidMs4bmjTWXEJvPws6+Cyk4lGp1fOR2L91CmWr8kZLXdGPPxxJ/xFfUXlyKGNJPWkpE
	 Qsitnp6oWw7NMGN7qDEbBBMIPJmftVGygcxS0q/B0tjB9aI9IYd7o5hljRJXH1Q7sV4aF
	 6dECo8sPUcj8Ved5MddkqT459i8BAvMTcmxBVjZbh9qgeUV8bzd6apkqri+uA8pcxb6ze
	 /eTd48eCtxT619sMNVTI/um+b7Qa80G+Se7V2v9uaDxtEdmk8aVqQVuO0HDIX+2T2YlVu
	 DqbSanmyvkHpwmhpvr2X2GAPyqBLxF/+cISTuc4oE3vrh0VxTc2Kk2UtbLyc5g6QmAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ePbOYlT9;
	arc=none smtp.remote-ip=95.215.58.131
Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD65606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ePbOYlT9
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LFjs2kFiCzLrj4HtSUdWz5JO/YUmh3RAwrRfcIouXUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792472109; v=1; x=1793076909;
 b=ePbOYlT9ZgnXHYmY2hQEgHhhrvgS4wZU6iluN736mIvkP2GdxPk9KcZppbWxvbHXuLdqSNV4
 5KfNhVGrs7uD3xXEMzsN9MT+PO59R8zz6sjz/CQh3LuD1mBpY+NiaxqukauYmqf4evU9c7Fn7j8
 7NxxFUmr7yAYnLeCvDmjh0PU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da4906023b4f5813;
	Tue, 20 Oct 2026 04:55:04 +0000
X-Mizu-Trace-ID: da4906023b4f5813
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d307dae-41b7-45cb-a35d-6cbfb09cde04@linux.dev>
Date: Tue, 20 Oct 2026 12:54:56 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add syscall common attrs support for
 link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Masashi Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261019153628.15912-1-leon.hwang@linux.dev>
 <20261019153628.15912-2-leon.hwang@linux.dev>
 <DM9282PWYQD9.21LDVIJ8824AL@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DM9282PWYQD9.21LDVIJ8824AL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/26 03:25, Alexei Starovoitov wrote:
> On Mon, Oct 19, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> +	ret = bpf_log_attr_report_size(&attr_log, 0);
>> +	if (ret)
>> +		goto put_prog;
> 
> can we drop bpf_log_attr_report_size() ?
> Nothing is logged when the attach succeeds, so there is no size to
> report, and libbpf zeroes attr_common, so log_true_size reads 0 anyway.
> Finalizing only when ret < 0 already keeps -EFAULT away from a live link.
> Then no need for the 2nd write, the log.c refactoring and the put_prog
> label.

Sounds reasonable to me.

Besides libbpf, other BPF loaders, e.g. cilium/ebpf, also need to zero
attr_common before calling the BPF syscall.

> 
> Something like this (compile tested only):

Will change like this.

Thanks,
Leon

> [...]

