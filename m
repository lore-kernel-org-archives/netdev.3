Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247972D9ECB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749753; cv=none; b=NJ5aQ5vNg633Rai8nEr8djx1Ezk1xGtj/jZs2rFebVlRa7wwpeeoDQSbkcqbrM6tySsAjg8NxM+nQn5uxZ1hu0kLzRzKpk1q9RHCPoZoQs6kiZ5vYNQO4+Kaa8cMalmzWyaWL+HrUraleTC9AeRqARIHbM0Y6W3a7f4j0vFQBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749753; c=relaxed/simple;
	bh=vfoG9acJPnT3ikDPDJIsh1vuwgut0qDkYKMT4ru9sA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHvXew3Rs/L/jbqGV6+sl+lIQWSZNn5RNvHsngsjmPYph85retU+8vdoRxievM9g1C4HknpMKwC2ETfVVB2C6/8fFJ5TlGT13NiSPqrNgzdZbef57wCYX6GYp7NuQOf0mAgIx4YLy8221Rh83KX1rwBmP9Vv05xcEKqjhbtLRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZUDrh+yc; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZUDrh+yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=BYAZKHN3mZXnitQDLyNK9hsyDOUgKjRmZq+a7DDlPTc=;
	b=ZUDrh+ycl4+y3N+dBVX8kk5FEPm8Gg0NOgkyY0Au7ZfSGURR8gLuRiwgs0qw0c
	9S9NEvnt/TYudJ+8hSyhoeA+eMwsidtfLB+YxKksK7i4DyYlioSRjVq9tWO6kBbk
	EGZuyknReyHolRRSgvqL7/wUXWMYu3U7kP1zcMmD5B7Qg=
Message-ID: <cb804869-1af6-4889-9620-953d0d85f5c2@163.com>
Date: Wed, 30 Sep 2026 14:28:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: filter: add sk_attach_filter_kern() function
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
References: <20260929093712.131096-1-clementwei90@163.com>
 <20260929093712.131096-3-clementwei90@163.com>
 <willemdebruijn.kernel.2d6146d195b1a@gmail.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.2d6146d195b1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X04QrLxqRdPLBg--.39666S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF47Wr1ruw4fWw15Xw15XFb_yoW5Xr43pF
	Z8Wa15Ar4DWFWUWFnaqrWUAw1Sq3Z5WF1Uur4qya4Y9ryDKr10g347Kr1akr1ayr4jgw4S
	vw1jgasrWw1DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRppBgUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RH4ZGq8rBF8WQAA3i



on 2026/9/30 10:43, Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> sk_attach_filter() copies the program from user space and sk_attach_bpf()
>> takes it from a user file descriptor, so a program that the kernel keeps in
>> memory cannot be installed again later.
>>
>> sk_attach_filter_kern() builds the program from a sock_fprog_kern, so no
>> user buffer is read, and attaches it like sk_attach_filter(). The caller
>> must hold the socket lock. Failing the attach releases it; so does the
>> socket when the filter is replaced, detached or the socket goes away.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> 
> This should probably be squashed into the next commit, that first uses it.
> 
Agreed, it is now part of that patch. I will send the series as v3.
>> ---
>>  include/linux/filter.h |  1 +
>>  net/core/filter.c      | 22 ++++++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 39decde7fc73..0de5a738fb26 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1218,6 +1218,7 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
>>  void bpf_prog_destroy(struct bpf_prog *fp);
>>  
>>  int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
>> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk);
>>  int sk_attach_bpf(u32 ufd, struct sock *sk);
>>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
>>  int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 70dc621672f2..64d6505a4ef2 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>>  }
>>  EXPORT_SYMBOL_GPL(sk_attach_filter);
>>  
>> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
>> +{
>> +	struct bpf_prog *prog;
>> +	int err;
>> +
>> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
>> +		return -EPERM;
>> +
>> +	err = bpf_prog_create(&prog, fprog);
>> +	if (err)
>> +		return err;
>> +
>> +	err = __sk_attach_prog(prog, sk);
>> +	if (err < 0) {
>> +		__bpf_prog_release(prog);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(sk_attach_filter_kern);
>> +
>>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>>  {
>>  	struct bpf_prog *prog = __get_filter(fprog, sk);
>> -- 
>> 2.25.1
>>
>>
>> No virus found
>> 		Checked by Hillstone Network AntiVirus
>>
> 

