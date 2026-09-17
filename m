Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F42576ECA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653844; cv=none; b=OdxKoqe48MyBgRZoiehtpoz+iBfbCGWqLmxlYB63yx34io9e1Xtd1Wot7rQc+q9zxJCExwfk36w8zWkEha4GCetT1Yi8CoMavEx3dscr1vVC6mWXUGX+VJUlX3oeuoBWDO+ebmqc5UrbaWYLXV68kDFq4zhg1EoWPE+25bnzP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653844; c=relaxed/simple;
	bh=f9gthdtnme5r9zbQ0ZXVQ9FPlaeOnLAuBmtzjScta00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO+e/do93fpKXu+DpXC87Anzf/zJya+PWZZWzUtSw2FOy6Jn+75gGhlaKz3oVWaK/ndZm5jOhorksIlPtb/porYXICrJRXpbLJPmwpDhnDiXGeOoya+P/KtLq1xE8nR5jm+1BbCStlPEfuTmcjGD3styWihxZt2rqu+1Ln2aNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYBwqiHT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF5lma6k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYBwqiHT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF5lma6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789653841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejWaldWT3exFP5sFeb/13xiPg0X16ooDhRq9dyD2Rdk=;
	b=GYBwqiHTQxPF4olYGPDZcX0T1AwD6e0Y1azIcXPyQx9XC/avUbRxK3F9H7s9qTbyGpPs6r
	IjRIkITBahERsxx8G3g0MfqnjNJ6FIS+sohpd5vh+qp0T7TM+Pu4GsWD3IhpOYeMLKswjo
	pD1idfiFT/Tg5U0PWwifoTTqB0pEZ+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-K7fDedE-MFuKKkdolF9NXw-1; Thu, 17 Sep 2026 10:04:00 -0400
X-MC-Unique: K7fDedE-MFuKKkdolF9NXw-1
X-Mimecast-MFC-AGG-ID: K7fDedE-MFuKKkdolF9NXw_1789653839
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so11797095e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789653839; x=1790258639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejWaldWT3exFP5sFeb/13xiPg0X16ooDhRq9dyD2Rdk=;
        b=FF5lma6kV68U+aYbP5UwLyAkvdRrHgufQVHODNd93INvICR3QmxBtdMkRPFXyhs70a
         S9AOoW/ep8BsHtGahqLiKWeRV353WXpLXGUQFgxFMPx4XUXJDu/2JN6Mz7erYMSupv0O
         daMU5E7aU3OhWYp1VUacyXnB14nLMO3p3stBxjMzeLxqIoXe/4cBwbncS2JEST+0tD/p
         6Gf1AG+GgSvkLXvwL5YB0t+Gier4onLOeJ15KrH1cf05c/3nfW+WHHDMBFqKDDjxcomc
         X+tw9K4o0pnaPFO9VETtq+55kTIWngtjtIDo+W8IEsp3s6S2ICeOMcWenL4kD/C5/j57
         nPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653839; x=1790258639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ejWaldWT3exFP5sFeb/13xiPg0X16ooDhRq9dyD2Rdk=;
        b=sr643TNlB8zvWh2/puemRSS3agi/1wI7lK4F3GrQZg2Kj12lvjefexC9rkQrp3IPvZ
         XoxfoxfMizgJhBIXwGq4btV3/yuRI6FVlnWkQNpbsvnsZ+LYtz0LVUGZFkKcZ4COv0Tw
         pr6HE1mREI8r4Irz9IbphKa3OcpjVbRztoV/4XFpesb65CmJc+kOn1xd7oPkOlfD0BXG
         IdTBZ+R3ESrAePVgV82zM20w+uTtQm2OKgUfWe2ybDBK20y6XnufO6RnEToP+UrKkZQ5
         Dpj0Zk6d/G0xQA7jW7mmaZaHXe8iJB7cj0jE2gzxH5cAhkX8D0g71pROhRDQDsyLxh6y
         L2Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxooUP9+5oFhaljYHHY0QEgpuVVWc61dzc1CZlDCECBMzy2uBGEBr7gZ5ecAs6wXe0oekzKHxg=@vger.kernel.org
X-Gm-Message-State: AFuF++nzyaPbqFNA2/q8GGyVmdaKckTO3Kwfoi4SCMAb2vdKJ0ql4WA7
	YnZiZcYYaPbeTmPJemNI2aqGteKeJBvINk3qmXS+80ALjCgnWhjQY2kdU5zigTxGqgMauzWmbMb
	Ujx0CbU6/jyOvoOkVwrk78efvItD6T25h53KgdavK+wzldns60FzTkjDKjw==
X-Gm-Gg: AYBFou3VSNJqYhozaNs5kJLTL09TzEFr9jE99RtJ9T+Gxzfl3kKqzAkJDwR9pUv83DJ
	0DGi0ZiUhUi2amKM5/VlOW3i5407TND/6OGdKVV3672Na5JEvT62kHQQMfz9CpdceeWEQRNYP6M
	QUtr6hbFZoUi0l3RG03fMK5rbE0PmSnCvtZpAlubN+SaiHH4w4J3Qdr0iki3VG+Myo8Wh2tz3Sn
	9GjQXySA7S42aP0ZACQkCXu4K0pUA42kiCMK0u0DirRiQ4oiqNzJ1ZGGQ4PROAFSomEPKyCYbqi
	TvDFefoOuFfIZblrL4xoPkYOlcUp6lG8JO2mhbc8vzTSKSZaFKpetKIygZBQr+A5uVpn/wYmjeg
	DEwL5zp7dhBBo7/aY6ClUjryyGGf0VFk0MxHYL3xWC5VelZY6QUW+UIMpO2fQlSyyocmNvjew1g
	==
X-Received: by 2002:a05:600c:c4a6:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49eb7345a16mr82457015e9.30.1789653839067;
        Thu, 17 Sep 2026 07:03:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a6:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49eb7345a16mr82456345e9.30.1789653838600;
        Thu, 17 Sep 2026 07:03:58 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf438fbsm16394895f8f.36.2026.09.17.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 07:03:58 -0700 (PDT)
Message-ID: <cf94f386-71ef-4be9-9a44-10cb91c74b4a@redhat.com>
Date: Thu, 17 Sep 2026 16:03:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: skbuff: do not leave stale header offsets
 after pskb_carve()
To: netdev-bot+sashiko@kernel.org, edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 xuanqiang.luo@linux.dev, achender@kernel.org, rds-devel@oss.oracle.com
References: <20260915130423.3956471-1-edumazet@google.com>
 <178956393100.22033.7676411417898444402@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178956393100.22033.7676411417898444402@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 15:05, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Incomplete invalidation of checksum metadata in the new
>    skb_carve_reset_headers() (net/core/skbuff.c:6842).
> 
> --
> 
> net: skbuff: do not leave stale header offsets after pskb_carve()
> 
> The two pskb_carve() helpers used to call skb_headers_offset_update(skb, 0),
> which left mac/network/transport offsets describing bytes that were just
> removed. This patch adds skb_carve_reset_headers() to unset the mac and
> transport headers, reset the network header, clear mac_len, zero the inner
> header state, and downgrade CHECKSUM_PARTIAL to CHECKSUM_NONE.
> 
> Closes: https://lore.kernel.org/netdev/6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com/
> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index cc3b4b70288b4..609f2c7f4a47a 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6832,6 +6832,34 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>>   }
>>   EXPORT_SYMBOL(alloc_skb_with_frags);
>>   
>> +/* pskb_carve_inside_header() and pskb_carve_inside_nonlinear()
>> + * remove the first bytes of a packet and reallocate skb->head.
>> + *
>> + * Whatever headers were present before the operation are gone,
>> + * we must not leave stale offsets, otherwise users of this skb
>> + * (skb_dump(), drop_monitor, taps, ...) would read or pull garbage.
>> + */
>> +static void skb_carve_reset_headers(struct sk_buff *skb)
>> +{
>> +	skb_unset_mac_header(skb);
>> +	skb_unset_transport_header(skb);
>> +	skb_reset_network_header(skb);
>> +	skb->mac_len = 0;
>> +
>> +	/* Inner offsets have no "unset" marker, zero them so that
>> +	 * skb_inner_network_header_was_set() becomes false and no
>> +	 * consumer mistakes them for a real (and long gone) header.
>> +	 */
>> +	skb->inner_mac_header = 0;
>> +	skb->inner_network_header = 0;
>> +	skb->inner_transport_header = 0;
>> +	skb->inner_protocol = 0;
>> +	skb->encapsulation = 0;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL)
>> +		skb->ip_summed = CHECKSUM_NONE;
>> +}
> 
> [Severity: Medium]
> The changelog says the goal is that "all the header state is invalidated in
> one place".  Is the checksum state fully invalidated here?
> 
> skb_carve_reset_headers() only rewrites ip_summed, while skb->csum,
> skb->csum_valid, skb->csum_complete_sw, skb->csum_level and
> skb->csum_not_inet keep the values they had before the bytes were removed.
> 
> For the CHECKSUM_PARTIAL case, the syzbot dump quoted in the changelog shows
> the incoming skb already has valid=1:
> 
>    csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=1 level=0)
> 
> After the downgrade this becomes ip_summed=CHECKSUM_NONE with csum_valid
> still 1, and skb_csum_unnecessary() in include/linux/skbuff.h returns true on
> csum_valid alone:
> 
>    static inline int skb_csum_unnecessary(const struct sk_buff *skb)
>    {
> 	return ((skb->ip_summed == CHECKSUM_UNNECESSARY) ||
> 		skb->csum_valid ||
> 		(skb->ip_summed == CHECKSUM_PARTIAL &&
> 		 skb_checksum_start_offset(skb) >= 0));
>    }
> 
> Can a consumer of the carved skb then believe the payload was already
> verified, even though the bytes the checksum covered are gone?  A leftover
> csum_not_inet would similarly still claim CRC32c semantics, and skb_dump()
> would print the contradictory "ip_summed=0 ... valid=1".
> 
> Should csum_valid, csum_complete_sw, csum_level and csum_not_inet be cleared
> in the same helper?
> 
> The CHECKSUM_COMPLETE case looks untouched as well.  Unlike
> skb_pull_rcsum()/skb_postpull_rcsum(), the carve path never subtracts the off
> bytes removed from the front from skb->csum, and pskb_extract() trims the tail
> with plain pskb_trim() rather than pskb_trim_rcsum():
> 
>    net/core/skbuff.c:pskb_extract() {
> 	...
> 	if (pskb_carve(clone, off, gfp) < 0 ||
> 	    pskb_trim(clone, to_copy)) {
> 	...
>    }
> 
> So a CHECKSUM_COMPLETE skb keeps a whole-packet checksum that no longer
> matches its contents.  Would it make sense to also drop or fix up
> CHECKSUM_COMPLETE in skb_carve_reset_headers(), or to use pskb_trim_rcsum()
> in pskb_extract()?
> 
> The only in-tree user of pskb_extract() is RDS, which copies the queued data
> to userspace and never calls a checksum validation helper, so there is no
> functional failure visible today; the concern is the trust bits left on a
> generic exported helper.

Given the last paragraph all the above is IMHO material for eventual future
cleanups.

/P



