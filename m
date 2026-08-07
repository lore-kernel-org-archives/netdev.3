Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEF2264B0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093976; cv=none; b=hpqhbcVUsK6FXblXnwtj7TYWxWYpf5rXT/MsfYDwcPmNGz8BUxxYqGKWxoBmcslzVqOOwDCoX4FpuD4kD+OMri42J1UyK1pb/eRqVGnhOCqBY1oenBbcBSlNunsvOPbxaNjYb2SejPNuUnEfzDjHqCLy5p2dthSR87PTtFmtrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093976; c=relaxed/simple;
	bh=crII75xd+SdlUuxBA92ZDs3fjRIROp/o+7sjz3A6phg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdO+3Y2Hk5z4YYWt30BdaJ+lxb+647S5FqOrisqfBOTmfM5hEfovVw53eERPgLepgf65ks1eflLfCFsjLIXqGS/VyjFY3Zq2xLlEvo0BtHL2ZLUNeCeMmVsOi+4Q7V2ZxrUtfr5tX5eLeXI48XJzE1uwq7JjjwS9X7WYC1hwbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKwwZSen; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKwwZSen"
Message-ID: <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786093972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLj0Q0XyXsxquMKgTk+VBS3kxVOOHgc3yPVMUAr2/U=;
	b=xKwwZSenSEEHc8EKep/4Fjoi+oOHobDEfUgyw61WOYKD6/mCG6q9iA94x7G6EwFbzGVSxG
	mw8DfYPg+0CX9jAgjg90kbnTRnMtsUCsunn4IXtATtKDE0qytC615rtZM0NbkgjIWizne2
	rolalbV+epWmVmf2tKwUWyYolI8Y/no=
Date: Fri, 7 Aug 2026 17:12:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/5] selftests/bpf: Add ksock kfunc test
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-4-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260806182234.380833-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/7/26 2:22 AM, Mahe Tardy wrote:
> Add
[...]
> +
> +SEC("lsm.s/socket_bind")
> +int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
> +	     int addrlen, int ret)
> +{
> +	struct __ksock_ctx_value *v;
> +	struct bpf_ksock *ks, *tmp;
> +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (ret || pid != target_pid)
> +		return ret;
> +
> +	v = ksock_ctx_value_lookup();
> +	if (!v) {
> +		send_ret = -ENOENT;
> +		return ret;
> +	}
> +
> +	ks = NULL;
> +	bpf_rcu_read_lock();
> +	tmp = v->ctx;
> +	if (tmp)
> +		ks = bpf_ksock_acquire(tmp);
> +	bpf_rcu_read_unlock();
> +
> +	if (!ks) {
> +		send_ret = -ENOENT;
> +		return ret;
> +	}
> +


Since bpf_ksock_send() is sleepable, every consumer of the kptr is
necessarily a sleepable program and thus has to open-code the same
bpf_rcu_read_lock()/acquire/unlock sequence before each send.

Given ksock_common.h already wraps the insert side, how about also
providing the get side, e.g.:

static inline struct bpf_ksock *ksock_ctx_get(void)
{
     struct __ksock_ctx_value *v = ksock_ctx_value_lookup();
     struct bpf_ksock *ks = NULL, *tmp;

     if (!v)
             return NULL;
     bpf_rcu_read_lock();
     tmp = v->ctx;
     if (tmp)
             ks = bpf_ksock_acquire(tmp);
     bpf_rcu_read_unlock();
     return ks;
}

These selftests will be the reference everyone copies from, so
encapsulating the RCU dance here also documents the correct usage.


