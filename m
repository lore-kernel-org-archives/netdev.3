Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D7468C36
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451010; cv=none; b=gN9RG3dnGPFK28yFx6zKBS6ARlB88PuDY+Yfu+Cf8SgsY3RzQ7YieuUTLr3HW+qpEzcaeqddQcEWqq13gtGkZ54RGErzj/qdawGS88xP2f+rRmtuKd9bToKuAqb8iLjcVow1AV3SxV8byH2GIVQAkIBaYdcpFTp6rCaSA0VkNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451010; c=relaxed/simple;
	bh=lxBqtxuBOusWek29/dJLnhOh3CXKdVZPRI0FxP1c5Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsIy2UwCC+uWw4uH7InUdtdUN1MBD6om+qlIjtjkmxuAisMcheG/PbMgPwzCEiWWUur2L8GEJiB4JgmX1HomTwyiNF9BGe+xCpzSrS0ONT2pXKJ5KE9D/hR8qpXAZblMvaJyuWCzkDVd1cGlkfdQ0Brtv84ZFOFd0oM/9CIY+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQo+kq4U; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQo+kq4U"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-861f30636f9so611827b3.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451007; x=1789055807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
        b=lQo+kq4UWwDlpZeOEEP99HIxKTkbXa22CzVxTvgRhMqVdwJPmvEadu7Z1PPsc7n+Ot
         tNi0hBKLyX89tm5Akujrxu7rvzRQsJTxh8Af/S6X9GtrIO/vECznZSa0UGmWS6pQK22E
         aKSJybGMnsEIEkpZvHffrfKpCEh0KmseKypapHPdiHpiVzIHuKSiLQZ6puLJuf5s2pRd
         dUqzZCdCY4oDDZISS7orriblx7dpn7V2T2xZZQXV4mAcWWtdseR7qCR/bKytEqTDVsy4
         y1+A8lhabJguPQmA6GIdKz79GhFuY5EXnpNhoRotiHWovAufo8107CCwfLxCGpblYekS
         vpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451007; x=1789055807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BU0pHPVrhHdYT1WkFVjJDxv8ZrMHIUMFXolTYoauB9k=;
        b=k8u3GPajMjn5NsdS8ROnnUrUUTrYimwT/DiQxIRe9RJa/feDaNpxYPkIxvrfTuSIZ4
         0EBhNGLX+WqlljX1tRU0j7OieDQRuqL8YJ4uee5cJ4QAle+XF7PUmsh4T22VUtWN3zGT
         G8mxEn70cMp/OtXSyL0188i38dn4rojluEYaC3rLW7QxFBWhd8DX+UM2A7KF8nLDfCo2
         f4qufDohuWwU72EeokGNbj3WSKZhkh4FYzxrQ0j7E6+vvnzb5Muwf9qR3av7L/uZ5o57
         Gmi7R5nlSGtpvGVAn8WNJDi4xFd8jiyjrVgcAH8jZgGUfHhl6e/yhQPMWdJDfH4/FDxY
         2QdQ==
X-Forwarded-Encrypted: i=1; AKwUvByLaWQY2NnEo7MJjSBtzOqJBDz8V6fEZqg/DiHUer8+0myWm2fxgR43qX/dNmlMSZaqPWwuT5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mYpegt7b2AfNfMgXWiW5L15QgTKAss1r31dZJVD7zWGatELxmG
	ILkSSrEtgKqPhZyVWqlvvk7oPM2+6008pULHVI+Xxs6DOBS/9XQH6Yfn
X-Gm-Gg: AYBFou1HQ48blLy7jL1ERQLqt/1hhAEpthBv51MRZWWdKkMXHJK2fewHvIL2pEX78OL
	EToy7XYGnWZU8DO8kVk2pEKDqJzoxFc7MnlFLFQAsm5BWvvq1pWwsxK1KqSYs6wqBktd3f6vF59
	78E4Eld0i8NUFfgmHwdcdR7Sqz2C0KBgCneEaWvV7Kch5XWbXBm3urBnQjHXbXN85AkfdA+J93C
	oKKvYrE2JWD/C2F6hrftpG7iAAlqo1MXKv6J68asvHmb6uCE5u58BCfUyp0JvOE0E744lMAJXaF
	tkK0GyjDdLi4h1ugE5BTcbpjW32mlKJcbqmpSjv3qqUeRpY5336zIwtWEsYIXs4tPI1wZ9ofGj2
	QXaQy/VR1OreeaJz2kvcBx2qeF/X6GAzX3NYvUTpbNhSta5INwaPytMabCL72XbyOUWRQg3IvIN
	RjGlGDf2AxEpyk7AYNP7gi4Uc02EfXtac8wfMDVR3Lk77f+cQxKBHdgwpkLPRUI8E+z9+7V9s+d
	94=
X-Received: by 2002:a05:690c:5609:b0:81e:7d90:5673 with SMTP id 00721157ae682-86c53678a4amr59135427b3.26.1788451007441;
        Thu, 03 Sep 2026 08:56:47 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm42962537b3.30.2026.09.03.08.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:56:46 -0700 (PDT)
Message-ID: <1fd96ec4-4247-4d6d-8936-cf4607a206c1@gmail.com>
Date: Thu, 3 Sep 2026 11:56:45 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830232146.36948-2-tactii@gmail.com>
 <20260903102730.578872-1-horms@kernel.org>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260903102730.578872-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/26 06:27, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=1
> ---
> e1000e: add jumbo Rx CRC stripping
>      
> When the hardware is configured to not strip the FCS (CrcStripping=0),
> the jumbo Rx path would deliver frames with the FCS still attached.
> Follow the standard path's convention by stripping the FCS at EOP and
> leaving it out of the byte count.
> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 844f31ab37ad4..599600ad695cd 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>>   			}
>>   		}
>>   
>> +		/* strip the Ethernet CRC; it may span fragments */
>> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
>> +		    !(netdev->features & NETIF_F_RXFCS))
>> +			pskb_trim(skb, skb->len - 4);
>> +
>>   		/* Receive Checksum Offload */
>>   		e1000_rx_checksum(adapter, staterr, skb);
>>   
>>   		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
>>   
>> -		/* probably a little skewed due to removing CRC */
>>   		total_rx_bytes += skb->len;
>> +		/* If configured to store CRC, keep the FCS bytes out of the
>> +		 * total_rx_bytes counter
>> +		 */
>> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
>> +		    (netdev->features & NETIF_F_RXFCS))
>> +			total_rx_bytes -= 4;
> 
> [Severity: Medium]
> Could these lockless evaluations of adapter->flags2 and netdev->features get
> out of sync if userspace changes features via ethtool while a packet is being
> processed?

Yes, this could be prevented by bringing down the adapter before changing bits
in e1000_set_features().

> 
> If a concurrent change occurs between the first check and this second check,
> it appears it could lead to an inconsistent state where a packet's payload is
> incorrectly truncated by 4 bytes, or where the byte statistics are overcounted
> or undercounted by 4 bytes.
> 
>>   		total_rx_packets++;
>>   
>>   		/* eth type trans needs skb->data to point to something */

