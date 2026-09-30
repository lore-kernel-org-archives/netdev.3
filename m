Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E43C0A02
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749567; cv=none; b=JGBRK4ddnves2O7yx9CFsmLDOSEV+Z/B+ki1MFzuA0fPDB6DKr8Uw51Gpas1LOWLOw9lb5/rKVm+SfgteEdr/DstdXc4K8pCQOU8meBPuOZC8hz9iDzB21L+LJUCgZvmaGzQRd58ku+rZu9YPbzjeAql/3hkZeRY7CoJUJqHPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749567; c=relaxed/simple;
	bh=qiAK5qbNlZlOC6JWKqzjCQqjxUHzzNudJLsvsaSFCnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxjvIYHNZwaZJ/t4fxUaRpo5EAmKbSE8UMS+cvrFeHt3asVJAvvQcmrchUxHzz/7cUWfCFH3opD4P3/bHYDvTwS53abGu9LBMGJ96zcWHvK+sZfqfMK21XfUcRiPsxkwOCgeLMqKyVtDXa7p8es6Wc+bcUOkrkUq9ACIkUSt7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb20c7aabc9711f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:18752841-5d5f-4138-bddb-fccd2fb1bd91,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:7db8b62,CLOUDID:d10109be28d3d57c2d41af2eeeb8550e,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cb20c7aabc9711f19a56ed5b684f684d-20260930
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 761912671; Wed, 30 Sep 2026 14:25:55 +0800
Message-ID: <b9f3761c-f02e-43f8-96cd-6aea69f3d32d@kylinos.cn>
Date: Wed, 30 Sep 2026 14:25:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Rongguang Wei <clementwei90@163.com>, netdev@vger.kernel.org
Cc: jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org
References: <20260929093712.131096-1-clementwei90@163.com>
 <20260929093712.131096-5-clementwei90@163.com>
 <willemdebruijn.kernel.d4382759ce27@gmail.com>
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <willemdebruijn.kernel.d4382759ce27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



on 2026/9/30 10:48, Willem de Bruijn wrote:
> Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
>> the program was copied from unreadable and then attaches the queue again,
>> which used to fail with -EFAULT.
>>
>> attach_filter_bad_len_keeps_descriptor() checks that a rejected
>> TUNATTACHFILTER leaves both the saved descriptor and the installed filter
>> alone.
>>
>> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
>> ways to attach a queue without a filter.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>   
>> +/* accept: return skb->len */
>> +static const struct sock_filter filter_accept[] = {
>> +	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
>> +	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
>> +	BPF_STMT(BPF_RET | BPF_A, 0),
>> +};
>> +
>> +/* drop: return 0 */
>> +static const struct sock_filter filter_drop[] = {
>> +	BPF_STMT(BPF_RET | BPF_K, 0),
>> +};
> 
> Are both programs needed? One will do, right?
> 
Yes, I dropped filter_drop and use filter_accept.
>> +static int tap_get_iff(int fd, short *flags)
> 
> nit: tun_get_iff? Or even tun_get_iff_flags.
> 
> Also, could just return flags if positive, no call-by-reference needed.
> 
Rename to tun_get_iff_flags() now and returns the flags, the call sites like:

	flags = tun_get_iff_flags(fd);
	EXPECT_GE(flags, 0);
>> +{
>> +	struct ifreq ifr = { 0 };
>> +
>> +	if (ioctl(fd, TUNGETIFF, (void *)&ifr) < 0)
>> +		return -1;
>> +
>> +	*flags = ifr.ifr_flags;
>> +
>> +	return 0;
>> +}
>> +
> 
>> +/* A new queue attached with IFF_NOFILTER must not get the filter that is
>> + * configured on the device.
>> + */
>> +TEST_F(tun, attach_filter_nofilter_flag)
>> +{
>> +	struct ifreq ifr = { 0 };
>> +	short flags = 0;
>> +	int fd;
>> +
>> +	ASSERT_EQ(filter_attach(self->fd, filter_drop, ARRAY_SIZE(filter_drop)), 0);
>> +
>> +	fd = open("/dev/net/tun", O_RDWR);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	strcpy(ifr.ifr_name, self->ifname);
>> +	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
>> +	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
>> +
>> +	EXPECT_EQ(tap_get_iff(fd, &flags), 0);
>> +	EXPECT_NE(flags & IFF_NOFILTER, 0);
> 
> nit: here and elsewhere: avoid the double negative?
>> 	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER)
Done, all three of them.
>
>> +/* A TUNATTACHFILTER with a bad length must not clobber the saved descriptor */
> 
> What is the descriptor in this context? Do you mean installed program?
> 
Yes, the installed program.

Thank you, I will send the series as v3, which also puts the kernel copy of the program
before the corrected error check, as suggested in the CI review of patch 1.
>> +TEST_F(tun, attach_filter_bad_len_keeps_descriptor)
>> +{
>> +	struct sock_fprog gf = { 0 };
>> +	short flags = 0;
>> +
>> +	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
>> +
>> +	errno = 0;
>> +	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
>> +	EXPECT_EQ(errno, EINVAL);
>> +
>> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
>> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
>> +
>> +	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
>> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
>> +}
>> +
>>  FIXTURE(tun_vnet_udptnl)
>>  {
>>  	char ifname[IFNAMSIZ];
>> -- 
>> 2.25.1
>>
>>
>> No virus found
>> 		Checked by Hillstone Network AntiVirus
>>
