Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB954B1CA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083820; cv=none; b=Pbzo1Tjkhgk2CEB2s6z3HPS0XH2z+lDxNMfsy4Iewzg5c/uVxptJyrUL1cl9hpzGhfqLFVFAsFUSgUhpwf3lmq+nkztro8m+Z9GncurNAcc+i+7rm6roVrOXGCEuVZBUN/XEVOBWwiK9NJxEtGcStuebsDGmR45vSuuuNwK3G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083820; c=relaxed/simple;
	bh=Ovh+3NCfWArkDpk02CBsC6ZVrby6mZuDUCj0rpEsB8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ic26kJ+uoSPify8G3CEn1rwY2+XXDCsZA+V8PtFBkfX/cecDT3/3itbglTEWiZS4D+wTL1r76Im62ghbVJqRMVj6AKazS8UFGx7Pd4Z9GHyJbsGh9hparg65x8tYuVuKJBIxtAnkKx0atsmmSThBNDeqzEH0TCLKJtXwTfLD+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhIAyLjH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e79cjbxE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhIAyLjH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e79cjbxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790083818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9g6BjyVGZFd66XuNlSGdvaV1BKMkquG3R7mnAoguds=;
	b=KhIAyLjHomWwFkjv7QUXhwz3VQGfCPWYoKSFeb+nn70oJlwRRHO9yFDrSVpQ5oz3y7pawR
	xL7XlFBjIXjxD+JqlTIDntEEFkDd2z5lDOeOudPNrw+Ho/mYUCfOiy6PjZNH2yueBrxM+k
	5jKkc+sFGDeSXaQQIx9Ot7tBXwJNTxQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-IptrKvunPZe-Gwozzh6MMA-1; Tue, 22 Sep 2026 09:30:15 -0400
X-MC-Unique: IptrKvunPZe-Gwozzh6MMA-1
X-Mimecast-MFC-AGG-ID: IptrKvunPZe-Gwozzh6MMA_1790083813
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c210c66672eso517796366b.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790083813; x=1790688613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9g6BjyVGZFd66XuNlSGdvaV1BKMkquG3R7mnAoguds=;
        b=e79cjbxEs8tDta9SrCtambNJ/Cs0O/RffSJJMSmNBnyjI2oAe7u1CHdwC1+ajPAhuY
         ++80wiAp9u9TsVGgmiiHTrCtvZU+YbV4wr4ol+cBiJztie+rVsqEe4x+fb/DeurqLspO
         jrjlClw6fNBZB1ZKgSzXFALfoBj3GbEaWiY6I9DmaX7Th2OGk8ewZcOGGtK+cIrYi4is
         GrQwiE+CrC47JO4Z8sLbFW56Q8xPlwKa4IMmcnSSw3mZaqnvDmAZS+ZNknF8ff+6EC/y
         nVXWWumRA8cz2NkW98bY0NBysW8JEDZj5BeEAge7gHdF3Lm1IznxbnIpTUeP+6M2f/8i
         75Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083813; x=1790688613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9g6BjyVGZFd66XuNlSGdvaV1BKMkquG3R7mnAoguds=;
        b=pXCyQG4sj57rvyhCdI6uRTy2EbB0PKl8bwdsO7j2++K7z4tO9NjXOIhyEfWEZ6Xtlp
         uru2zMoDoY5KmUgdHLEZ/GquAQrA5dxmR6GKIbqDzjrjeXO0CLB4vZFZi1O4R6SNESP+
         6VwSp0vyUZf7VKgl9XJbSgd0u9ZrSw/sRJ9Yq9rPWE9K7ehWhrTw1+w73nyE7LR4AUAq
         9x2XiRMiw6bnABv6Z2/zCCtDLMvsUKl75kxj1VHW//vRdptGN4RLS3tVH9YW900Lxp1k
         MynhaxavzfSxI9QA1OMU73G903PbSesqzx/pDC8WGpLv5iCCgjDfZV1bKVg3f0PIAgPB
         CchA==
X-Forwarded-Encrypted: i=1; AKwUvBz4/miD0dF14M2qMBeZY2hnLq9EWuz4J518icwRdYxW5bDXzlpXLK6Y7HhXgUYYXGIXIOsHtOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mBSob3dAV1ZLPNytS+hMeLpJYzBtpJWQmNICOOLynfcl6JTiSr
	kkJs2DBIbAdRcQ4G3LN2FvPY/aJ0zhtruPmNtM9pMXRnrVPBulU403rkiSVnpljpjHzS+NSQiCg
	DSzNRqGRTuRVqSb8enLdB9vzvLhQjOqRsHeEU0vkU2XtoWDa8eaBnTGhKQQ==
X-Gm-Gg: AYBFou2FXNfVHeLvvAejaQWFHkMs17mL2QpP/OcWHL8YH9SO2qAAJiW4YQjWz3lUMVe
	w8CcgFZNNoYC88l+roI/b33n0ffwLwj8ZFKcjogR6otH+HiJ8jJZ5A0NLzRi2KdkXS4R0TOQXmI
	8tR78yVpGrs4pKXEbCtDulJDUsX4JHEsbYQZYglSp2xjYN40MORrTXbPX3HprZha0F/undLoPBC
	14817i+/NkfeQazdWqoBFUEuxHeswnk+2BebsPqNmY9tnbjk7ywpDQxkP/Wm5LjksYbyfxDw8h7
	rtlRUY8mUa4AujM5HOKRIfyPREoiZbrMeVqRq9r63u1oQoiH5c2BCwEsgyX9IVYImn66iaGYyJN
	oiOtmZ83FHsGOIQai9dtZoGbbFwY0f+MGnrZggS+7UjbcH7FaNGWjUrJkHQ4uL8nwQNDfUMWaTg
	==
X-Received: by 2002:a17:907:72d3:b0:c29:f5d8:9c70 with SMTP id a640c23a62f3a-c2a158019c7mr1066564866b.31.1790083813131;
        Tue, 22 Sep 2026 06:30:13 -0700 (PDT)
X-Received: by 2002:a17:907:72d3:b0:c29:f5d8:9c70 with SMTP id a640c23a62f3a-c2a158019c7mr1066561866b.31.1790083812536;
        Tue, 22 Sep 2026 06:30:12 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5832fesm88079966b.30.2026.09.22.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:30:12 -0700 (PDT)
Message-ID: <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
Date: Tue, 22 Sep 2026 15:30:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent
 socket
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 devnexen@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
 <179001595171.2160803.3670624686905872378@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179001595171.2160803.3670624686905872378@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 20:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new error-queue splice is dead code for MPTCP-native data:
>    its only accepted input (SO_EE_ORIGIN_TIMESTAMPING skbs on a subflow…
> - [Medium] Forwarded TX timestamps expose per-subflow identifiers instead
>    of parent-socket byte-stream identifiers, breaking the…
Sashiko comments look relevant to me. Basically this work makes sense
if proper support for mptcp-level tx timestamping is enabled and the
and sk_tskey is resolved at the msk level.

I underlook at the above during reviews on the mptcp ML.

IDK if someone is currently working on the missing work/bits.

/P

