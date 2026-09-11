Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F73C4B64;
	Fri, 11 Sep 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093512; cv=none; b=Kz7YmBGSyo9JGy5zQLVzVGvv2cnt5eNIjV93gGuJYLshcMHV0IwMZx+TeCMTFIEtzwZr/Qf6c+Up9sVWfspoRy3oPvY89J0+INGk5Xw2w8axuUcUGbtK6bUCdewJL/V3k3vo0oZhiFInDCfaRmvCrJG9r+h4D9Ot2WfXrCk8rDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093512; c=relaxed/simple;
	bh=iu0xFS54jtqt/le8IYdRc71D046Hy/mYlgF6ro1+ciw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRu8z9QuDa6QCE4TkkwN44Cs3bsMeXyWYH6ROFFiVG1P3XutuOOjL7WNOSK926LbIERYuBWHm5ccbY+kX/xg+JTZ8Y44Al/HZmdKLKF9s2005fYM5zecSpaHjRmbH8tiyRmQcXw06BVyimnt8ETPCc2Ya9ajRWo8j0pkJUWbgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caoUIJTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caoUIJTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D821F000FF;
	Fri, 11 Sep 2026 02:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093510;
	bh=0KDI+PR5NrM9GYBSon7cJT/Y9OtpJ32TC7sVfz4WwsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=caoUIJTzw8Y56ZIr2gYvCH2/OTplJoOPqd4ryEso/J2+yXPE9kJa9FRVsMLpOqp/d
	 mtCtDMsPgmIC1F2e4gvOJS7DffFk3thram98q0Qq+gBGkvATFWkKmcxabMCk3QxCRT
	 p1N1bkZEK2OkFFGguQ+vAyrc40llGyg7QdJujahHmYsn1DT1IHD3/8fFxKlyKt3/h+
	 aMvv4+3Y8w8MA4IfBjYt9ar/5qcH4WEQ6g23iOAkTQZpzmHqlUfwH0QiD717fGZ1SR
	 xQGXN5qqhye3M0GWZUw/pE5KaeydLPd/38N2jvLoQk/6d/LPlkKz3MNCQH5ITcle03
	 YKKry6Lc0m7Zg==
Date: Thu, 10 Sep 2026 19:25:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taylor Bates <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] tools: ynl: reject zero-length attributes
 instead of looping forever
Message-ID: <20260910192509.73207bef@kernel.org>
In-Reply-To: <20260908-ynl-robustness-v1-2-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
	<20260908-ynl-robustness-v1-2-f255214c0f30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 19:45:08 -0400 Taylor Bates wrote:
> The BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS payload the kernel then sends:
> 
>   34 00 02 00   MDBA_ROUTER, len 52
>   30 00 01 00   MDBA_ROUTER_PORT, len 48
>   08 00 00 00   bare ifindex 8, written by nla_put_nohdr()
>   08 00 01 00   MDBA_ROUTER_PATTR_TIMER, len 8
>   00 00 00 00   timer value, 0 for a permanent router

Sounds like the family outputs garbage and should not be supported.

>          while offset < len(msg):
>              attr = NlAttr(msg, offset)
> +            if attr.full_len < 4:
> +                raise YnlException(
> +                    f'Malformed attribute at offset {offset}: '
> +                    f'length {attr.payload_len} is shorter than the header')
>              offset += attr.full_len
>              self.attrs.append(attr)

Not sure i follow you logic. If anything I'd have written:

	if len(msg) - offset < 4:
		raise ...short, not overly verbose msg")

? But again, if the kernel is not outputting valid attrs that's not
YNL's problem. 
