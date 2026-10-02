Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEDDF59
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911250; cv=none; b=ptmEnm/+ZGPNvuO5qq0LrTr4NnkyOHg+0pCSSXfVwzfnjyqHJvF50ipMB3x/32LiZPyKF/Caqm8iYimIam/+f+mnkj3mj6Ha2NIyh226sENliNV2AQ7GPkfdvGCddnaH6rRtqaSYpLXASMX7JndJ+UWcPpfbxdFiCFg4oJNDtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911250; c=relaxed/simple;
	bh=3o/KnFSkpk6UkGMxjU4GEmfmAvsRh9Mo9jHtdw6J/og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UN/+zj9yZQW8n6Cz5LpRodRmYQrVafJEqRmrPiqqFuE6lgWvfRKghoAeXL1qZGYZZHkeJU4yl4GC3m1BjfSiwurpKoLAZuSVEqOOoI/6FnM6x2WJ5INWU4CDximDgyEidrePfkoluW3pFliqOdKy8wrMi6cqlCXkVrsaqFTackY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQtTXNkh; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQtTXNkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=bN2ejqfI9l/65yUvIl+gPU51QEzpjP/7zCUD6I9YtZ4=;
	b=jQtTXNkhmHd73Eb/IvQXB29+5zWn5VvJpHIwz4NoPfUcF/fJ0k8H6yVhkacswX
	ho06wBtNFxx3hhqL8BpTa7+jBsLTovmGXbUUVG2k+jnHYrJ/cNPkmx+Eot6Vmw1D
	usWlxZqpIepl9CjTtwlU4mlzjhov8nDJRuzHjjwJe4Ruw=
Message-ID: <ddcde66a-27cb-4c22-8faa-ba89c83cb608@163.com>
Date: Fri, 2 Oct 2026 11:20:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] selftests: net: add TAP socket filter attach
 tests
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
References: <20260930080746.135017-1-clementwei90@163.com>
 <20260930080746.135017-4-clementwei90@163.com>
 <willemdebruijn.kernel.279db086fa165@gmail.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.279db086fa165@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3_5j5Ir9q8pqBBw--.11384S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18ur4kWF15WrW3GFyDKFg_yoW8ZrWfpF
	Z5WayDtF4UWrWDXwnrXr18ZrWxXr4DGF13Zwn5Kry5ZFn8AryfCa1fKay3C34kZw4kGwn0
	9FyY9asrWw4qqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ufb1nUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hlRvGq-IvlgLgAA3W



on 2026/10/1 03:20, Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
>> the program was copied from unreadable and then attaches the queue again,
>> which used to fail with -EFAULT.
>>
>> attach_filter_bad_len_keeps_program() checks that a rejected
>> TUNATTACHFILTER leaves both the saved program and the installed filter
>> alone.
>>
>> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
>> ways to attach a queue without a filter.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> 
>> +TEST_F(tun, reattach_filter_without_user_buffer)
>> +{
>> +	struct sock_fprog gf = { 0 };
>> +	short flags = 0;
>> +	void *prog;
>> +	int ret;
>> +
>> +	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
>> +	ASSERT_NE(prog, NULL);
>> +	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
>> +
>> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
>> +
>> +	/* The process that called TUNATTACHFILTER no longer maps this memory */
>> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
>> +
>> +	ret = tun_attach(self->fd, self->ifname);
>> +	EXPECT_EQ(ret, 0);
>> +
>> +	flags = tun_get_iff_flags(self->fd);
>> +	EXPECT_GE(flags, 0);
>> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> 
> iff a respin is needed, consider adding the extra test to make sure that
> tun_attach did not just succeed without attaching the program, as it does
> before patch 2.
> 
> EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
> 
Yes, I will add it in V4. Thank you.
>> +
>> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
>> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
>> +
>> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
>> +	ASSERT_EQ(munmap(prog, getpagesize()), 0);
>> +}

