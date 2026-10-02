Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1530EF92
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911539; cv=none; b=Jpfl0ZtF9ptoCwXsJ+wFjSZmbfWBtQchirhyjVKVCypWQJtYg/xDu66uof9X+nbzw+fbOAyKqqSXd97H8ku56acj/CLm01oi+ypqYD0RT17+m/SDiVlIjbIBFLa69aH/t6BnaiqbPdYWhXSx4n/ZIkBAymLx77SpJSgfN11UhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911539; c=relaxed/simple;
	bh=AgFBgXo3FFud9szMZeQbkyDEeIGFoZHlNIvwWuazSpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLC+r4fIyNfEDh+CPYBbHqQB5gnCZG1Lf5Uwv8HxLnglRJiO0LEw39ozf0NfOuCVNByIrGS0Nakj1uSpNR4+k8tBhj2rXEFsKrbr5MhjQxjOXvEaXXLFm//vBb5Qlo0bwSUV9CfdiKTIAVaq6uOux5PtgOqgXwNXHjjrFBU4MhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=amwxirsF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="amwxirsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VNsdlLDvpEw1fi9ofKxacfSsiQv9DfsfH36Fs761It8=;
	b=amwxirsFaPfPtZBJdgXGDo8Btwdvn2w4rX6Pe/OSW2AMvxAE9qJqEK67NjCqVt
	RJuepONt/VYRtNyqOeHWmPic9azoudxpIGppZnqPi8iG9fcPdWz+3PTGTzvySJWP
	ZOSVQIZlMLvHazGPDIwXSQD1YQrTf3Du9dBrZ30Qtu488=
Message-ID: <1d0e6066-f6ca-48cf-8665-848167f3dea7@163.com>
Date: Fri, 2 Oct 2026 11:25:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] tun: keep a kernel copy of the socket filter
 program
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
References: <20260930080746.135017-1-clementwei90@163.com>
 <20260930080746.135017-2-clementwei90@163.com>
 <willemdebruijn.kernel.3adc274631629@gmail.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <willemdebruijn.kernel.3adc274631629@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgAX5xcUJL9qXV1fCA--.55566S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF15Cr15Xr47Kw4UGw4fuFg_yoW5JrWrpF
	Z0gayjyr1DWry8Ww1vqr48Aa4Sqwn3Wr13ur1vkrn5uFn0gr48K342gr4a93sxAr1rKw4I
	vr1j93ZxWw1DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ufb1nUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RaYBGq-JBZ01AAA3w



on 2026/10/1 02:33, Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
>> stays a pointer into the address space of the process that issued the
>> ioctl. tun_attach() reads it again whenever a queue is attached to the
>> persistent device later on: unmapped there, the attach fails with -EFAULT;
>> mapped, whatever bytes it holds become the filter of the new queue.
>>
>> Keep the program in the kernel instead. tun->fprog_kern holds the
>> instructions and each queue gets its own program, built with
>> sk_attach_filter_kern().
>>
>> sk_attach_filter_kern() reads no user buffer and attaches the program like
>> sk_attach_filter() does. The caller must hold the socket lock. Failing the
>> attach releases it; so does the socket when the filter is replaced,
>> detached or the socket goes away.
>>
>> The copy is freed when the filter is detached or replaced and with the
>> device, and tun->fprog is left untouched so TUNGETFILTER keeps its uapi
>> behaviour.
>>
>> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
>> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
>> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
>> +{
>> +	struct bpf_prog *prog;
>> +	int err;
>> +
>> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
>> +		return -EPERM;
>> +
>> +	err = bpf_prog_create(&prog, fprog);
> 
> Interesting small issue, not new with this patch:
> 
> The BPF program is not validated on copy_from_user, but on attach,
> possibly after the system call has already returned with success.
> Which results in a dev without filter, rather than a failed syscall.
> 
Got it, a device with no queues still returns success. I will look at it separately.
Thanks for the review.
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

