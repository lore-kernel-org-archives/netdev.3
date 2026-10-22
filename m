Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679816;
	b=maH8LrV+lplPDbrEi1eCIJ4it09siq9I6yWTleXiwJl7Jg75diVV+es0r3I083pzNRvF
	 qWjZVFVDq7rn1m2kvCBz7KgLdICaJFdGXbymCnNIlQacdCtRo6CpzEHrCukwT3Plc9cHi
	 qauxz1jf7GVa5ftVOU22o7qUjfTuBWEJgMTBvABeXiAxUFsvmA2re2KrKxL8mq4Ohxfaj
	 IjW/1UZMuym5c3oyL3cWyzbT4SQLj27+7k/kWRMohSORdeaIKW6286SAijXX9E8lrb8oa
	 7tbKwneobaiKVbe8qwXPtJDGoiE4249h9/EtlsTeOMQR0yz6B9maB0W+j2hB9jgl8MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mvAGYPaHlikIZq5QDERlND46MryykUYmthk/Ww6XUqk=;
	b=LZRfVaom8oQ+eDfSX1msHF+XR821d7zYLycODG7JWIfMavpAdt4oAZjDCHILr3+RDUc9
	 3GX0dVPfhOH+qWn4TPDm+F/JU/bsVeg+Pjuo6Jc7+DwSyQY4VlKZokk+q+KC8yzgZFWwO
	 ObxUq8/nHD++Gc9nW1mPf2xopW5fnjsvK2yn2JNOuzZkgn+K8Ylicd/zeVcxn8/TCd0R9
	 qV1w1UgFloweiyL73nYoHnyImWzzEmt3Pm9tvjv7a4YVEAzx4jnQwJIerlA6A8N7ehIHG
	 +NxAL8WpqFY5CdEM4reBNL+16d7nBheEVBPvdZ+1PhWXHVdUcBhxXUmHDdScdI+zbng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rWzOsQYX;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D6606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829D6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rWzOsQYX
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c434376dbebso221157566b.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679815; x=1793284615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvAGYPaHlikIZq5QDERlND46MryykUYmthk/Ww6XUqk=;
        b=rWzOsQYXQqTVdPHfBv4oBRlk7alBl9C7/EGhfrE8iN/K9/eKdRFqvZLFyRwDFPZwtU
         VBf455BTddg6zUW8/A5bTMmZyJ1WxnNI7fJqcYf5W8vn0R835CpG0egI6j6gZscYSvud
         sguFmG5aBPUQkoapBZSSqsx9pCiifvytK6KoDRZJ60JMmCCsuWLDj0jrTsFDZ2qu9s6k
         vIJZwJ6WA+b+C0w5piTFqTsLgBcYDrPBlfCM1pJAYOeBTDkCdrZWwvasn4J89U0AJwGV
         qjGWaRjPxnNF0icCnOZx45Ku7BO5l/cb9GebiRA+tVLKqrPpLx4F0aV6s9ze5CtB+Rb0
         fREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679815; x=1793284615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvAGYPaHlikIZq5QDERlND46MryykUYmthk/Ww6XUqk=;
        b=lnpqoUvJdoo72XpeO/5I4Scimxn7c2dRtfR/li2dCtTEFuvQzFrfcJ6OOxuFft05sJ
         3Ih0VVCO/8AXxBsHIs421iKV11l1jO0amf9+JNl8e0zUts+uqEgNr7VvQnPBYXNAI1Dd
         dA6ZtpaAxqtF4heWtSEn/5kQEh7+5Lv63ZxhBNFhE2PoRxQt0Dvm4GxLN9rcGYBO2/cB
         sUjtRoThapfOb7ww6vfZH5CRwgzlIuKb/xlY09ntx3y095voaoHPAiaC5Muk/zwtmY9+
         77YG4r+H7839WGR995wATbKSpblUxwt99iOuXeKrg5ppcg4/w3VWFL8DPTDeJg8vaZup
         Vkug==
X-Forwarded-Encrypted: i=1; AKwUvBwuHjT6vl4TVhSHB66UQ+yF7u5hk35LEcl95i2/xgWcJXjevxrnBNoEwiUaRQ792Rlsa1R6cbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNjr6J3T7BPKL0S3y145EwnpfAerbXyCwT94sQxo3tqCOCo/+W
	sOUzq8/Vt4nGVdxAnxx5m0qhu1u1zx9bsdGcVOgCHtJoJ4f9u874sbDd
X-Gm-Gg: AYBFou3RBJWJvo6JskIT4jt6h7cDY1YhbPOkhozBVHyIJhbx2BJHq+crp6W0JpUtHsu
	ENkQq3h0QxqqTFMx0ZZC/ZbsLOtAyHg1GP9iO7FSNj4yJ9w+cORDyS3jno5N4jFD0Oc+h7SSNHS
	Ffdc8nSq/CBMnYb5Dne45EeTlZRmSXYsPaDMYT+ncbVBCVvYE4luyXuCiv/ut8shjpYBOZrpYhG
	E05PLk/h7lKEi0CJUHTejvsYlcEBS3lP+120/UJI58+MigxXz8cvP+MXMdXswyYrGQIyU2bi1tU
	oZLGYCKfambwTqYaZs8FigREOeJNI7lwJcX2Qa3w9HaT37w+skXrVvvXQro5ll9SrIkYduSwwmC
	Gvf2KxeTHZnPybPjfyNHFhMzc47eKbTCpsa3MtRQwiebRxHaV3gl+jj5peKmkfGPXHCT0GZgAKU
	NQkwZssbrsTPFtUCLD44Fu/zYlQSYzavcfYbziI4Tfs9MRfWa4iv0xTPIGehaEp5K0o6v9467vz
	z5Dcncp2moAjDOwroLIxN7rkK6wu9B4ZSf2uO2KHvmWzR1jBjR6WjFssVZiLO3yRms7fyvQ8Bd1
	i34azqF8MLOFY0GIqJLYtIbJzz+Vh06P8P448AA4pg==
X-Received: by 2002:a17:907:6d05:b0:c40:9b35:ad91 with SMTP id a640c23a62f3a-c468d76a6bdmr355258666b.13.1792679814548;
        Thu, 22 Oct 2026 07:36:54 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a4ffcddsm112143966b.14.2026.10.22.07.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 07:36:53 -0700 (PDT)
Message-ID: <46fdec20-c37b-4d7a-afa1-3caadcfc4640@gmail.com>
Date: Thu, 22 Oct 2026 15:36:52 +0100
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
Subject: Re: [PATCH net] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
To: Sicong Huang <congei42@163.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261022133927.3860186-1-congei42@163.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20261022133927.3860186-1-congei42@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/10/2026 14:39, Sicong Huang wrote:
> With CONFIG_RFS_ACCEL, each channel has a delayed work item,
> channel->filter_work, that expires aRFS filters. efx_poll() queues it
> with mod_delayed_work(), and efx_filter_rfs_expire() always re-arms it
> with schedule_delayed_work(dwork, 30 * HZ). Once efx_poll() has queued
> it, the work is therefore always pending, queued or running. It is
> only cancelled in efx_remove_filters(), which is not called on the ring
> resize path.
...
> Fix this in both drivers by calling cancel_delayed_work_sync() on
> filter_work before freeing an unused channel. The work does not take
> the RTNL. It only trylocks efx->rps_mutex, and the filter table locks
> it takes are never held while waiting for the RTNL, so waiting for it
> under the RTNL cannot deadlock. On the copy failure and rollback paths,
> the freed channels are new copies whose filter_work was never queued,
> so the cancel does nothing there.
> 
> Signed-off-by: Sicong Huang <congei42@163.com>

The analysis looks correct, but I wonder if rather than placing the
 cancel_delayed_work_sync() inline in efx_realloc_channels(), it should
 be done by efx_remove_channel() (or rolled up with the kfree() into a
 new efx_free_channel(), since it's undoing efx_alloc_channel() rather
 than efx_probe_channel()), to reduce the risk of the same race popping
 up elsewhere.  Consumers of the channels API should not need to know
 that they have to do this 'magic' cancel to safely free a channel,
 that's a layering violation.

(Actually, it's a layering violation that filter_work even lives in the
 efx_channel and not its efx_rx_queue, but I never had time to fix that
 and am now not likely to — I commend the idea to future maintainers.)

-ed
