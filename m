Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303932;
	b=fisyaPHFb1aDxvd6zEE8ykZW+yeHbd9HnQFyWXiAlobXDUN9umKCbsilyFqSNS5/pQZw
	 pKQBck/HgMq3LwNlmpjKdoHZ6S17spmGvhkcaTMa/RtTtqc5k6iP8FGlI5yXjv1KRRmch
	 PigimI77EhbY+EUTWC7MOIy2AVQlsJTDmebLTLynDZW5il8uBMJUgkPaNZWQNSI2FR6k/
	 hJyKnA2wfhG3xMUOC1AznTzXNJLLRjrcr4PW1Y3zjbsFoaBx82ZoQS765HJzLdPIXjpBI
	 nNMJq72m7nmwr+Sp28/9yf+smraqYVnj1cuvM4lpRzuXIPQvr2eUEwXZEt1tc1fzc9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303932;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=I0aHNpYYYJjXnks0yXtv3vruSoxZWqR1NIB39pb6v0Q=;
	b=vtX0BoJpk2rovTLEIrz3KFgxv1FBDAV9KjENnmEfAG42osTN0xLwX8YC51kqQs3r/Hdd
	 WL8IM5RShGesiQ8sebdLDvMfdIzbRUoWCKJRHa0BGGCqwG/PAgzStNp+bAB0hrqrZdkyV
	 Wgz0gdc5Us/t344MiKPkH1Bg78MIlYW72UE7liIiuQ5icsNGyrh1n6n9bGnd+OQA+q2kq
	 h16adcnVvto3FZ8mZoDyUQV5OtdFKI2FH4metRmdlEcEDCast6KLHxHJr3uYYXSibTsx6
	 XnZSVwM1HNp0+hckEmdWrp7tQWvqEPUNu3W7R7pwA0N/kxjK2Mt2TzZ+xVj3xJ7iXXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLGXsj8e;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDA606B9D7
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EDA606B9D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLGXsj8e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794303930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0aHNpYYYJjXnks0yXtv3vruSoxZWqR1NIB39pb6v0Q=;
	b=OLGXsj8eNZ1lhp6TIezKBZZR/TZdF1AKmsjHFJr4mTk8e/a8LIVp5shlraJ4ORy7elH8to
	E0h9qLOYmLU5DKYEgqoRGwBGRuvQXuMYLbXTNUJYFH8J8gv5lus0u7jahYUc4qUGzB0qIs
	WQRo7Zj+q5UZGbroETykPSP3TH2fg7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-M3SqPeGFPAiHztvTxAVf4g-1; Tue,
 10 Nov 2026 04:45:23 -0500
X-MC-Unique: M3SqPeGFPAiHztvTxAVf4g-1
X-Mimecast-MFC-AGG-ID: M3SqPeGFPAiHztvTxAVf4g_1794303922
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A52619560B7;
	Tue, 10 Nov 2026 09:45:22 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B840A1956086;
	Tue, 10 Nov 2026 09:45:21 +0000 (UTC)
Message-ID: <d5acc725-dd95-4e96-89ca-364db2444b61@redhat.com>
Date: Tue, 10 Nov 2026 10:45:20 +0100
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
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE
 CGU registers
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-3-ivecera@redhat.com>
 <sashiko-outbox-202874@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <sashiko-outbox-202874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/7/26 13:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] ice: ptp: unconditional R10 write and lock scope in
>    ice_ptp_link_change()
> - [Low] ice: dpll: missing Fixes trailer for commit ad1df4f2d591
> --
> 
> commit 6fdc60cccd47bebe7d61ff60807ee77303bf58bd
> Author: Ivan Vecera <ivecera@redhat.com>
> 
>> ice: dpll: serialize changes of the SyncE CGU registers
>>
>> On dual complex E825 only complex 0 has a functional CGU and the second
>> complex reaches it through cgu_peer, so PFs of both complexes share the
>> CGU registers R10 and R11. They read, modify and write them when the
>> state of an RCLK pin changes, and ice_ptp_link_change() rewrites R10 when
>> a link changes, under the pf->dplls.lock of their own PF only.
>>
>> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
>> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
>> the DPLL core is going to serialize callbacks per (module, clock_id), and
>> each complex has its own DSN and so its own clock_id. With that change, a
>> test toggling RCLK pins of both complexes lost an update.
>>
>> Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
>> around these sequences.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [Severity: Low]
> Since this fixes concurrent CGU register updates in E825-C SyncE support,
> should it include:
> 
>    Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> 

Yes, the race with ice_ptp_link_change() is there since that commit. The
patch now goes to net with this tag:

https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

v2 of this series will drop it.

> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 3df08714510da..4d4b6aaaf30c2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1395,7 +1395,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>   				break;
>>   			}
>>   
>> +			mutex_lock(&pf->adapter->cgu_synce_lock);
>>   			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
>> +			mutex_unlock(&pf->adapter->cgu_synce_lock);
>>   			if (active && err) {
>>   				dev_err_once(ice_pf_to_dev(pf),
>>   					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
> 
> [Severity: Medium]
> Should cgu_synce_lock also cover ice_tspll_bypass_mux_active_e825c(), and
> should ice_tspll_cfg_synce_ethdiv_e825c() be skipped when active is false?

Yes to both, also there since ad1df4f2d591. Patch 2 of the net posting
skips the outputs the port does not drive and checks the mux under
cgu_synce_lock.

Thanks,
Ivan

