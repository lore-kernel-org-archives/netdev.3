Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B163156C6A
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336042; cv=none; b=G7hTf86wIUzJIFsRVA46luIS9i+SiCQ/MnvOjXHWfVtNgzUvmbmHfAwvWJk8GxMJY9iL1wsmB6FWcvUsPjHOPHOpJix2Vy4Ry86UDXoJMYk0Pvy/93cxrvC1fg3d8bzzbTsBjCzFZSAHojA3mrPc56El9PQ9vgWiV7Bsw1whMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336042; c=relaxed/simple;
	bh=MKGMBWqnw5gd+YHmEhsODi47YbAcqgh0GhG9Zr0vlz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZwYwC25T33LjXTSoPlYkx3yWMqMtG3CIQncGx4RddsGDO5eprBuomAmuW7Fe3RATSrlm8WqtaRvggIW693Te4q15gvRCUM02eibrhS9jJBQWjVujucrupUNBy2SewXSKo4BErOPEkLGCV6+CtxWU/xH/n61hmVR5SLaCi4Bme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdM11WwB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QytN3YH8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdM11WwB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QytN3YH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781336040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCxqiC/dbAHUNdjFPYlhhUjIkUa1wOTaY6rb8cF9fTA=;
	b=XdM11WwBOKZUWd1EQwSDVlO6tj5WLshgvPtH5hEBsQ7J1gTpRMkjJJpC24hxmGni9Twchz
	6Chb3o41A5++zetFopRdN3ziM4K7gsWX2d3P2+DDT5MRBh7wJv/f9JXzstzYPr18W3pK9F
	I64IijriffRxzLis5GX0TnS0d0LFN0Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ZS3pLROHO7mAHSAMA1aNKQ-1; Sat, 13 Jun 2026 03:33:56 -0400
X-MC-Unique: ZS3pLROHO7mAHSAMA1aNKQ-1
X-Mimecast-MFC-AGG-ID: ZS3pLROHO7mAHSAMA1aNKQ_1781336036
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91598ab3a1aso198204485a.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781336036; x=1781940836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCxqiC/dbAHUNdjFPYlhhUjIkUa1wOTaY6rb8cF9fTA=;
        b=QytN3YH8Z7mGnJHQSe9l4oVND5d0ShSKOsHqVNE+3XQDq21h5VZtazUSoaWI3WdfQY
         Tst1i2ZU3sMXwSgzGkTde1RnlhXmK7ugd/msWJsvAJH/R8RVEKF9NM/LP3RkLyLExOnW
         clRtta///aBZNSbdH7aLnOW4GvCVuFS1zMezz13FJ+wCprXGyRfFMqfSp4/2tg5ie5Ov
         yb90KVM5vwJQSozIGMLI5aBPlkUzkbR/B2tjc2NJgsX1UVri3OCny9Sw9/o4seCCoJtU
         U14acLLGLePhD+1KbMBy9YrdgIP9C1djbqVe1ro89IINFM7Hzu215i7ZIzfZkaejHruY
         IUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781336036; x=1781940836;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCxqiC/dbAHUNdjFPYlhhUjIkUa1wOTaY6rb8cF9fTA=;
        b=ZHuFJgncdKqFSGljGVVrWFnTiCB7OvpOKPc0gDm3qLdNvxyF938WB7/GQzH3DKMRhn
         JQketWpY4IOceNTaPicOTnPAg+dn2rLWWzc6yE989KN6VFcu0zPo5j+u1jP4IfwlVtZG
         6L48BeS8MAuBjALrpFl1/TUFOArWGbbb5bsBw08kxw/vgcFTQHvZPaUviQYZ/vTWryjA
         +Rqs+jg+rcVIynaQTbwo63BQ34G68TQwnynR8nZCaLNXQTFGjZytfpZ91MQgUkc2sh4R
         KCyeLA5aQa9QlpwVrHJLdvzV9MYLe30sZzVlzdNc/T+ZpnJVO2ByQy473WfZxcqWK41/
         VukA==
X-Gm-Message-State: AOJu0YwjhSN3c5+YPfwJEJ/KCeLX7e/2fQ2rQnOn4A7Yst6E7PJRk8xM
	q0svg22OPZ46xntYAk1k4aZqHd9emGvMVOo/niOUla8s6ZmrhdIEKVG47GaJYAQGkfkgKm62z6w
	Q5WJqyxrvAYT8onQo8tAV7XOMO8mMoZky0l8WdgJU2SdN8JTSNIOmceZmn+9ZZxLzYw==
X-Gm-Gg: Acq92OEUTQ4DxzDynkj0t2ptl/+zClVoY3BcNiOVmCEppqIrJl7xhhxvoHO6SSzOv4x
	R4JRsRZoYxVECo3u188gVXD3WyZtQFUem3eRLl7Dd8xBM/xLQiFOAbr0vp4jepcgvhwLqzT528u
	oxtVWeJ1HSK9dXerGyv2NbupadR/gaRNX+H1kdZUU2F8dOSnLRoghjEx10fPvmlJeAMYXGMR5Ng
	gI3GcXs2vxwxWw4FW5Hhz6Bj18a97nlWPLywWag21vbdg59Y6hb9BHHQICkN65TkR/K7hBW7G5u
	VOnH6rFHAkrlQAqjFRVemR5dJt5pZdjuORza34ijI3TDoaomEc3j9fWmyVQKxF3I45EHtnK5jil
	OhJxtXMmMbzDhR7RAooWtNEdQNktIahkiyN9HS/LPDeIVTjcb8eIbROI=
X-Received: by 2002:a05:620a:2415:20b0:915:9c4b:fdb4 with SMTP id af79cd13be357-9161bc5e03bmr661908685a.22.1781336035880;
        Sat, 13 Jun 2026 00:33:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2415:20b0:915:9c4b:fdb4 with SMTP id af79cd13be357-9161bc5e03bmr661907685a.22.1781336035399;
        Sat, 13 Jun 2026 00:33:55 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a069389sm434800185a.45.2026.06.13.00.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 00:33:54 -0700 (PDT)
Message-ID: <71efa96a-1022-4b83-b007-5cde7b1953c2@redhat.com>
Date: Sat, 13 Jun 2026 09:33:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net: libwx: support vf per-queue
 statistics via ethtool -S
To: Simon Horman <horms@kernel.org>,
 "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, kuba@kernel.org
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
 <20260608103946.25786-4-mengyuanlou@net-swift.com>
 <20260611064859.GP3920875@horms.kernel.org>
 <F78E77E5-D224-41D2-886B-04989C054219@net-swift.com>
 <20260611151843.GS3920875@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611151843.GS3920875@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/26 5:18 PM, Simon Horman wrote:
> On Thu, Jun 11, 2026 at 04:46:08PM +0800, mengyuanlou@net-swift.com wrote:
>>> 2026年6月11日 14:48，Simon Horman <horms@kernel.org> 写道：
>>> On Mon, Jun 08, 2026 at 06:39:46PM +0800, Mengyuan Lou wrote:

>>>> +static inline unsigned int wx_stats_len(const struct wx *wx)
>>>> +{
>>>> + struct net_device *netdev = wx->netdev;
>>>
>>> netdev seems unused.
>>>
>>> Flagged by AI-generated review on sashiko.dev 
>>
>>
>> #define WX_NUM_RX_QUEUES netdev->num_tx_queues
>> #define WX_NUM_TX_QUEUES netdev->num_tx_queues
>>
>> #define WX_QUEUE_STATS_LEN ( \
>> (WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
>> (sizeof(struct wx_queue_stats) / sizeof(u64)))
>>
>> netdev is used.
> 
> Thanks, sorry for missing that.
> 
> Perhaps it would clearer if WX_NUM_RX_QUEUES and WX_NUM_TX_QUEUES took
> arguments. 

I agree with the above. It looks like there are very few users of such
macros. My suggestion is to include a patch adding the argument (or
entirely dropping/open-coding them) in the next iteration of this series.

/P

