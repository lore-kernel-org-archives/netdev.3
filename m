Received: from mail-ed2-f10.google.com (mail-ed2-f10.google.com [74.125.228.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6E35C193
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759913; cv=none; b=Dvy+ne/fZWJmbS56l9LasWyNWvmqTW1t5Vv/CJ39Gd6u+AsMAOOuXG3s4kVBsbVKh4KFkeVpduGZ2Toq0xQTRgv1xm/NxL3ITzcKP0gsI5udglsxEPmXBssFb7bugM44CLznpd7qxDTsTQsX4T0T00/F6XjZLKetR93kWc8S5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759913; c=relaxed/simple;
	bh=KPyVa+kWY0UZgEil0HmF+BJp9Seb0JTazm0TmuAhnhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLzo/PRDR8UMRSn1SxWskad42d2LXy5Ow8KwyueWhcEohalWFWVRSiqjpUJ21zhwKLsEEVJ3xDuFBcA3Z28PclhglRwrA1DrcbxeoZAU/FW/DXJVAs8oczlO9r51LMNoc6MNkMK3MmJpFoc6hEgcM9/Q0o46e/rFdZoLkD2/kXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f10.google.com with SMTP id 4fb4d7f45d1cf-6a0942e63b9so1829108a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 05:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759910; x=1786364710;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEACbumYlq70aPk7n7e7K+N7eZjss06m4IWks7Cusa8=;
        b=bQeZyeOK0fOjWdIOiJRMO8BZHBljF/i49EUkCq2ejRGh5XiziJuZz/uDJKbjSYb9eP
         crzyFz65i8icjXcNdvfEny5xP1p8cq37JMEqaejemUS4zGCvhRfKuJ4VhHkVYyMENooE
         F7N2EaVzU9RI/xTPsLFbmpK03PAsIzIVsmkzM6BqfzmCvw0g12BHSlq6ntJNWt05bHJt
         gVFgXoN9ZtB8EY8vEs8RiQlWd/QSF6Y1sWq15q6wHhWTOMQsfRgAT0NHBdXDy+y4AteD
         ne3PRAFac5TyFm3X9tYLwJdqOj43SZIMDrGwDsoP6m0ZMQApJJ+nRWjFq+xyzcU2x2wL
         xRZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDap6NtVmCCYkF5qxk+NPO2xsM85NNEw5myCLwi7w8OfoZ73GvMHJjl9jHdXUmppePqTF9K/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Y3rG8ArP/aqvR0bgWVGJjDFzXDakcFKvg/iPLlFEUzrILLeu
	MjLJrar7sKs/XyUgpconCzXfl7y+K4u0W8k0z5zupFpWF7RlsHeskSjw
X-Gm-Gg: AR+sD106P6xkqQpzLfY3jpe9/boWOZ+ftdFZ2zZ81WPzAbl69UuyQ2Evz8xYMa6MSpL
	VhqMkC7FeaipOAyI7u8myo938D/2aqxDi+qgLyD03MD03xA4cB/G+6W6FHtoM2r9L30MLWi//QV
	pFhsAK1ZNMIV2QjDlNvFUBqaMcYwhAZujvsrQCmgg6LiYS8OcNdVzye0Qp/VfaErBYHCifXVeD9
	xXrNho0jSb/MuaGPEoRBS42vHs3aQKgLISHwjjSkE+ZhzCX518jLghJX+fHD2xaZ97yrz5GuJiB
	sSoIOAZp25EVvSBXaXNi8Ht9BTL8l7DsGLJYcJK6NXh2AoWLizz2/v5bbwiJF+mT/xRzY0zm3dt
	KogfrqNkTxSngIzZ0K+Q1A5gTIh5cs1K6eylPcUal9Q3aGUIE6AX8kbpY91QpcFpPiAg+zZCo6M
	Hmkq67C45EHeIBVxjqQ9FqYdiWER4xx7dXkRUrh/T99MJX5zUs3WDW7qsH1MWSeDjE+bfnjF5UP
	OTkzuKcB/XpWxbrMpBYzx9aXA==
X-Received: by 2002:a17:907:7243:b0:c20:1923:d8af with SMTP id a640c23a62f3a-c201923dee9mr173920566b.26.1785759909391;
        Mon, 03 Aug 2026 05:25:09 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd44541fbsm526648566b.39.2026.08.03.05.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 05:25:08 -0700 (PDT)
Message-ID: <0544fde9-55a4-4345-bc85-e0fba6e16195@ovn.org>
Date: Mon, 3 Aug 2026 14:25:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 yihung.wei@gmail.com, vega@nebusec.ai, tonanli66@gmail.com,
 xuyuqiabc@gmail.com, Ilya Maximets <i.maximets@ovn.org>
References: <cover.1784711445.git.xuyuqiabc@gmail.com>
 <20260722164120.2064541-1-enjou1224z@gmail.com>
 <2c2cef53-3bba-4dd4-b66c-cef45852d470@ovn.org>
 <b4779996-0453-442c-a92f-1312418b73bb@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <b4779996-0453-442c-a92f-1312418b73bb@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 11:19 PM, Ilya Maximets wrote:
> On 7/22/26 10:59 PM, Ilya Maximets wrote:
>> On 7/22/26 6:40 PM, Ren Wei wrote:
>>> From: Yuqi Xu <xuyuqiabc@gmail.com>
>>>
>>> Packet processing uses CT limit state under RCU, while netns teardown
>>> frees that state under ovs_mutex. The CT limit pointer was neither removed
>>> from readers nor protected by a grace period, allowing packet processing to
>>> dereference the freed state.
>>>
>>> Replace the pointer before freeing the CT limit state. Wait for in-flight
>>> RCU readers before freeing its contents. Serialize CT limit netlink
>>> operations with teardown for the full lifetime of their state accesses.
>>>
>>> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Vega <vega@nebusec.ai>
>>> Assisted-by: Codex:GPT-5.4
>>> Co-developed-by: Nan Li <tonanli66@gmail.com>
>>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>>> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>>> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
>>> ---
Hi.  It's been silent here for a while.  Do you plan to send a new version
of this fix, or should someone else take it over?

Best regards, Ilya Maximets.
