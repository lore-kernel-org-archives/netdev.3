Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0314371D01
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776570666; cv=none; b=P6jsFBWoFelWo+D7DGdVw2Tzi5IU9UuNtTpRDGSbWf/nyqKlvX83/bSOfABfk9+B8OaEqmu5a250pH2HBXZzSWabpw52BWSI4ivlbaS57DZ+GZpQLmL79SpZaE9o5ToWDToEuI6Q1MMa7wptiS5qeg1/hF+hNKh2z/Nm/qAvY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776570666; c=relaxed/simple;
	bh=2EkvQ5dXP6/hha5v8qT2la6g7wy7H9F4retEcAEcKCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYw+1bCV90xZBFJvMCo5aA8is1NCJqWGjkd99/+D53r53T1aPRuutJJHmhxeFem9qvx4bvNwxnXzeHJfBt6GVSEebXfRP4WRLHTVPyiPL239UB3jwyfxf3oimcUsfecnSkOZEtEQZhyoiRqNEz1hOQM2DoergvjfO+WyMziNN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK2jjIup; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK2jjIup"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82faf8b7ccbso44281b3a.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776570662; x=1777175462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFkM/6LRjnQBW5XiVj8s15mRaeqJ9HCVd7cCS6MEeMM=;
        b=BK2jjIup/lhNMEBRCcj78pyjl09UdLqxRecYdDSLujpXVBquloDnQ6SEEBiqUw7BAd
         MScXBSHsNP2ctpihOEIR47c4uP+SaGGCgDoBixX8Z7lpsrzawDigJkKpc6sAUN6gZ0jN
         xRPQZUQonHFFErh9SN23Ko4FfzDSuoLRQM4VsUfQS4GmaDmFIa0FHoQIZOfuWYViGD8b
         aWkdT1bIImdb74LfVxuJd1OM8RmbimX8tvZOzQAczwQsSxqZvdz6ArCR4+gg9zP4N6Si
         wmTNlnPQBdZwsf81SlJo2s868zwXpwcaKWeFxYzFhwDoOCsnJuL+Wct3T8B3dyRUAfNp
         Esqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776570662; x=1777175462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFkM/6LRjnQBW5XiVj8s15mRaeqJ9HCVd7cCS6MEeMM=;
        b=oah27H6jYSIcWxcHgQWjMl6E5mDlK3ZU0NsyZCGUq7TkO7U6NiKFztcWHhzOAxuA2n
         ND1/HOFSk3AjJBu77RjQ8JZaaYnezTgIpXapMAssvFuv77C4QReNatkstgeGnB+r+dPd
         s/OiF/2v/W/1h4xSjjLINPTu0twMH634noLl6yFd8FwKie0Ns2eqAdJodBrYIhZ9w3+J
         dmiTAj5tZbZAQt5/dKfCLk0TzwgB+uFP2fEj7i4sRKtslFOC5ACcMa7uF889glz0LZOl
         6QajdYzbhXg2po5IWVs/UOKvvuR8jYZsmcq0B/j3Y1Dx1A5B2FIpeinzy3+zSSaFjils
         0m2g==
X-Forwarded-Encrypted: i=1; AFNElJ8EKYbhxHq7kUZhAnOxCaXnOqp9OXsH9rb/Zz8coNL7SwjObSzqgjzMbYN/fUQnYRTMff1NPj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5u+6Nj7Uz+tyV3eBDH1peRy1Ifkw93BH2W7CKSGszIbDiLGS8
	2m4q8wzF+r6Ki+Oufmol5f5JCaEXzp3+2QDAyeHbENGhuE9XlxC2yAuf
X-Gm-Gg: AeBDieunJjRTSpXJfEyVPeREHiMtnZkMjgbDwm6B58HwD4tto3s0476KxFvao757Cyq
	0FY28zDiUTWfk2sfNilqxoODi2Sgw78udNtrYgu6OIKwHKo2+rbCcOl5le4gcTwiCKJmz2Fay5q
	AaStUOmQ6Yq7LbTImBa+FJx9diV/blMPktdWvjjzWaWZZuGMMMQtZ+jT0KaemN4LvZBiYCbxfev
	Y6bx13tIrRNKgn2S4a4BjcL5xpT01flfnzuSgghjckuSlEqB0zRRbmaIhQ3ACn4JFAz7TL3TZAF
	M7+FWDTBkSiKb1LPgP455vpoKYYOqdN3dbAyoPiWkjS7B/fRsNXfqymEfqW6bU1SoxDxWbG1amX
	x3RIFso+eBvPE8LFdrSS+dc1NHUpFujQ2AO7qDn79M63Sfs2xEnnbBBXodBePYE63Pg8+kqZoPD
	NT/uJ2bZkfDY+Gz4FNyTcKVX5uLCSsCdJOBE3zOqyeua1p51I3sH32zGU6V7s=
X-Received: by 2002:a05:6a00:4b54:b0:82f:6e39:d90f with SMTP id d2e1a72fcca58-82f8c93d102mr8681866b3a.39.1776570662467;
        Sat, 18 Apr 2026 20:51:02 -0700 (PDT)
Received: from [0.0.0.0] (42-3-10-232.ptr.netvigator.com. [42.3.10.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40e5sm5965339b3a.42.2026.04.18.20.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 20:51:02 -0700 (PDT)
Message-ID: <681eb20e-530a-4b80-937a-39f3a71a88e6@gmail.com>
Date: Sun, 19 Apr 2026 11:51:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
To: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ao Zhou <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@resnulli.us>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 royenheart@gmail.com
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
 <20260406154808.GA714138@shredder>
 <b6cc7bc1-f18b-43d2-a21a-c964466fa882@kernel.org>
 <20260407080259.GA760990@shredder>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <20260407080259.GA760990@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/7/2026 4:02 PM, Ido Schimmel wrote:
> On Mon, Apr 06, 2026 at 12:14:15PM -0600, David Ahern wrote:
>> On 4/6/26 9:48 AM, Ido Schimmel wrote:
>>>
>>> Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
>>> If so, please check if I missed more places and include them in v3.
>>>
>>> And I think that the part that I was missing earlier is that we don't
>>> have RCU synchronization in the unslaving path, so an RCU reader can
>>> either see the original master, NULL or a new master (e.g., bridge
>>> instead of the original VRF master).
>>
>> synchronize_rcu after the unlink (control path) seems like a better,
>> more robust option than adding more checks to the datapath.
> 
> IMO it would be better to proceed with the original approach and look
> into adding RCU synchronization in net-next. The original approach is
> more surgical and the pattern of first checking netif_is_l3_master()
> already exists in other places.

I followed that direction for v3.

The patch keeps the more surgical datapath fix for net and extends the
same check to the other same-pattern slave-side helpers.

I am sending v3 as a separate public thread. Further feedback is
welcome.
